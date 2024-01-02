#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
git reset --hard 26f3634
echo 'define Device/redmi_ax6
	$(call Device/xiaomi_ax3600)
	DEVICE_VENDOR := Redmi
	DEVICE_MODEL := AX6
	DEVICE_PACKAGES := ipq-wifi-redmi_ax6 uboot-envtools
endef
TARGET_DEVICES += redmi_ax6
define Device/xiaomi_ax3600
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := Xiaomi
	DEVICE_MODEL := AX3600
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	DEVICE_DTS_CONFIG := config@ac04
	SOC := ipq8071
	DEVICE_PACKAGES := ath10k-firmware-qca9887-ct ipq-wifi-xiaomi_ax3600 \
	kmod-ath10k-ct uboot-envtools
endef
TARGET_DEVICES += xiaomi_ax3600
' >> target/linux/ipq807x/image/generic.mk
git clone --branch master https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic package/luci-app-unblockneteasemusic
git clone -b 18.06 https://github.com/zxlhhyccc/luci-app-v2raya package/luci-app-v2raya
git clone https://github.com/destan19/OpenAppFilter package/OpenAppFilter
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
svn export https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus package/luci-app-ssr-plus
svn export https://github.com/fw876/helloworld/trunk/lua-neturl package/lua-neturl
svn export https://github.com/fw876/helloworld/trunk/v2raya package/v2raya
svn export https://github.com/fw876/helloworld/trunk/redsocks2 package/redsocks2
svn export https://github.com/fw876/helloworld/trunk/microsocks package/microsocks
svn export https://github.com/kiddin9/openwrt-packages/trunk/luci-app-cloudflarespeedtest package/luci-app-cloudflarespeedtest
svn export https://github.com/kiddin9/openwrt-packages/trunk/cdnspeedtest package/cdnspeedtest
svn export https://github.com/kenzok8/small-package/trunk/luci-app-adguardhome package/luci-app-adguardhome
svn export https://github.com/kiddin9/openwrt-packages/trunk/adguardhome package/adguardhome
git clone --depth 1 https://github.com/sensec/luci-app-udp2raw package/luci-app-udp2raw
sed -i 's/luci-app-unblockmusic luci-app-zerotier/luci-app-zerotier zram-swap ipv6helper openssh-sftp-server tailscale tinc/' target/linux/ipq807x/Makefile
sed -i 's/ tinc/ tinc luci-theme-design luci-app-design-config luci-app-wireguard luci-app-dawn luci-app-easymesh luci-app-frpc luci-app-guest-wifi luci-app-haproxy-tcp luci-app-mosdns luci-app-mwan3 luci-app-mwan3helper luci-app-n2n luci-app-ntpc luci-app-pppoe-relay luci-app-pushbot luci-app-ramfree luci-app-socat luci-app-sqm luci-app-syncdial luci-app-tinyproxy luci-app-ttyd luci-app-udpxy luci-app-uhttpd luci-app-watchcat luci-app-webadmin luci-app-wifischedule/' target/linux/ipq807x/Makefile
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate
