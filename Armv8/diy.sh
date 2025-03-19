#!/bin/bash

# Default IP
sed -i 's/192.168.1.1/192.168.1.200/g' package/base-files/files/bin/config_generate

# Add packages
git clone https://github.com/ophub/luci-app-amlogic --depth=1 clone/amlogic
git clone https://github.com/xiaorouji/openwrt-passwall --depth=1 clone/passwall

git clone -b main https://github.com/very20101/openwrt_N1-Nova packages/opwrt_N1

# Update packages
rm -rf feeds/luci/applications/luci-app-passwall
cp -rf clone/amlogic/luci-app-amlogic clone/passwall/luci-app-passwall feeds/luci/applications/

## add extra-package
cp -rf packages/opwrt_N1/extra-package/luci-app-ssr-plus feeds/luci/applications/
cp -rf packages/opwrt_N1/extra-package/luci-app-passwall2 feeds/luci/applications/
cp -rf packages/opwrt_N1/extra-package/shadow-tls feeds/packages/shadow-tls
cp -rf packages/opwrt_N1/extra-package/shadowsocksr-libev feeds/packages/shadowsocksr-libev

# Clean packages
rm -rf clone

rm -rf packages/opwrt_N1

./scripts/feeds update -a
./scripts/feeds install -f

