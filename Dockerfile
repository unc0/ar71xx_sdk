FROM alpine:latest

RUN apk --no-cache add \
    asciidoc bash bc binutils bzip2 cdrkit coreutils diffutils findutils \
    flex g++ gawk gcc gettext git grep intltool libxslt linux-headers make \
    ncurses-dev patch perl python2-dev tar unzip  util-linux wget zlib-dev xz

ENV openwrt_ver 18.06.1
ENV openwrt_target ar71xx
ENV openwrt_file=openwrt-sdk-${openwrt_ver}-${openwrt_target}-generic_gcc-7.3.0_musl.Linux-x86_64.tar.xz
ENV openwrt_sdk_url=https://downloads.lede-project.org/releases/${openwrt_ver}/targets/${openwrt_target}/generic/${openwrt_file}

WORKDIR /openwrt

RUN wget --tries=3 "${openwrt_sdk_url}" -O /openwrt.tar.xz
RUN git clone https://git.openwrt.org/openwrt/openwrt.git /openwrt && git checkout openwrt-${openwrt_ver} && rm -rf /openwrt/.git
RUN tar -xf /openwrt.tar.xz --strip-components 1 && rm /openwrt.tar.xz
RUN ./scripts/feeds update

CMD ["/bin/bash", "--login", "-i"]
