#!/bin/bash

set -e

echo "🎯 倪海夏Skill发布脚本 v1.0"
echo "=========================="

# 检查gh是否安装
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) 未安装"
    echo "请先安装: https://cli.github.com/"
    exit 1
fi

# 检查是否登录
if ! gh auth status &> /dev/null; then
    echo "🔐 GitHub CLI 未登录"
    echo "请按提示登录GitHub账户..."
    gh auth login
fi

# 检查仓库是否存在
echo "🔍 检查仓库 wjpvip-cloud/nihaixia 是否存在..."
if gh repo view wjpvip-cloud/nihaixia &> /dev/null; then
    echo "⚠️  仓库已存在，将直接推送更新"
    REPO_EXISTS=true
else
    echo "❌ 仓库不存在，请先在GitHub上创建仓库"
    exit 1
fi

# 初始化git
echo "📁 初始化git仓库..."
git init
git add .
git commit -m "feat: 倪海夏经方派思维框架 v4.0 完整版" --quiet

# 连接到现有仓库
echo "🔗 连接到现有仓库..."
git remote add origin git@github.com:wjpvip-cloud/nihaixia.git 2>/dev/null || git remote set-url origin git@github.com:wjpvip-cloud/nihaixia.git
git branch -M main

# 推送
echo "📤 推送更新..."
git push -u origin main --force

# 输出结果
echo ""
echo "🎉 发布完成！"
echo "📦 仓库地址: https://github.com/wjpvip-cloud/nihaixia"
echo "📄 文件查看: https://github.com/wjpvip-cloud/nihaixia/blob/main/SKILL.md"
echo ""
echo "📋 安装测试命令:"
echo "   npx skills add wjpvip-cloud/nihaixia"
echo ""
echo "🔄 后续更新:"
echo "   1. 修改文件"
echo "   2. git add ."
echo "   3. git commit -m '更新说明'"
echo "   4. git push"
echo ""
