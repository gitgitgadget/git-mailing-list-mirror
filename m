Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2312EC4332F
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 17:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358375AbiDLRkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 13:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358407AbiDLRkn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 13:40:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B0060DB9
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 10:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649785098;
        bh=rrwbWsm5IVFDaSFknZfNTpGboxhp6xsC6e8grBUtdiE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=dnI1YwHl3+ER2cVRulpcBZOrb4jubHD/+OjSKTARxIXAdaQBl9mWW4vvE7eMbyj0V
         WcNhG6A03R9LDcXgr3e6LAiFwHRUbJkjoh1nu5h7ZEnIbNICalC0NDGIEBWSLWY8hD
         RVCjDzDCFvtSDpLvb6mPy9CjhNC01Plhi/KkT0d0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az196-633.m3u5ga3utehe1jm44gvey0miob.gx.internal.cloudapp.net
 ([52.242.128.14]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MgNh7-1oALR70sRz-00htyd; Tue, 12 Apr 2022 19:38:18 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.35.2
Date:   Tue, 12 Apr 2022 17:38:15 +0000
Message-Id: <20220412173815.4324-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:NMV8ozryeiyaX8RwqDuoA9/r7/H11WAfjqWPGopbqmtLojcyW1b
 Q6eXEerDNNQxmm6aObDl1hGcWbiFSdSnc+rOPE7Ry+P081G5qjFA6XPp9N2MKokhEL5xKoS
 MN0T0eLas0WEyJbePPkzi10XfuAwETgVTJvOfGAnh/nMpd3SmBTGTmxyYp/sY8abe1jhizU
 3GXJsAS18QC9YFE1iHOzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lECZQVhn3zY=:S/WjJ5drSHjQuNtf9B/N0D
 PKGYyMcBekE3R2OVjR7k0XGxGUJKGRjQBXpYn6Igxy1h4wQR7oowORmR6EEMPQ14U34hMYR0f
 whqrG4WuH5FyrgYyEVxuOb8xpyW2Nunw81XNt3n+zTffFPYQLV74l/DZ63ercawkA5+3kI246
 BQ5ttQScSsmSLnFIaqTjT04p8+rgnFJ+yaEg3GtCd+Sdptk7WUCKQLOlHQVLfj2dilF/bWC6u
 ZTSm75xVruTyIpf9Wz37Zs7e/e3DfvIAe2go1wXEmFWEuFVheTwQaw/trpbxKvgpipF3zvxcQ
 EMjHz/JU5ZxX8n7zf3Bdhrkm3/9QNDjKf4KFnfdGYs8odVTPt2Mrmi7hhL+DCb9FEAL8m7cJf
 vAkuc5id/7gHgnPpCTrqkEEYmH3V4rDPGK2ysmNKNLDaMrS+uOlOJHcsirCWvNZWzKbFtBTOB
 Caby1O1FTM/SZEpHKdK+7l3mxtML0fLgkfFrzK4TX8OSYeJ6nYgMJTy8w8bOL1rHi9Wa6Clk8
 wNC9WPr0XgJTVYeInQ03R8tUbzlvkB27Yphg6edvRYOdUYYdMmFlpINOKUvA18QfJxwwoQ2iu
 p7NDq74EYZ1acpnHuUjDY3lRJk45nTR43NVAxkykEa/tF8S/eLmnG3lKngOUwnvvsx/S9DQ0I
 wNGZS+GQQvzSFKndg7EQHZhwcpYTQaN8F5WHLqJTkdyQzw+o3wi8W+9V4Rcv+LYgWWKabafRk
 J7HP3GRji22pl5N+j6NiNhV7wFeCHgMqkPptNURhBRAPDIF8mbEOvwoY0fecQPU5TpHwzmnXd
 4LeaBlPt6kQ3ftkUDGVFT3KfFu8Uaol/GpeYgNx4UfpPmU2V8fLmZyz6V9rvN+6uRSUBGy/Iw
 jWrWFTmYpllpiJAEdtfQCCPQWriogern85MHBU6a0zASejYN7msbQKdU+zMUrol73yOv0qtsw
 SzS5lwxv14+QwGY9VEOmcByGZc2wibJvAp3coxVHG/7jVsHiLhqRwkC0BIFhHWE6EU0A0jn0y
 w4HXRpOlx/Gj3voenqj1U2lxmKNIdatVK+xhBHrwrvQLFaOqh+J9EqkV2i2tXeL7WOHBhJ0KV
 +DTyl2GCTINrQo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.35.2 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.35.1(2) (February 1st 2022)

This version addresses CVE-2022-24765 and CVE-2022-24767.

New Features

  * Comes with Git v2.35.2.

Bug Fixes

  * The uninstaller was hardened to avoid a vulnerability when running
    under the SYSTEM account, addressing CVE-2022-24767.

Git-2.35.2-64-bit.exe | 8d33512f097e79adf7910d917653e630b3a4446b25fe258f6c3a21bdbde410ca
Git-2.35.2-32-bit.exe | 4cac3338d1b637c7574a8ee0214652bacfd030925ea0f2c6beb97655348467c9
PortableGit-2.35.2-64-bit.7z.exe | f15eb0ba8866da555cb8090fbf5aa6862b2e57169d2aeb88ed9c50f59522c8fb
PortableGit-2.35.2-32-bit.7z.exe | 342690bfd53ed5aedca967f2897124f84b65f53bc42162cd775906935bd82131
MinGit-2.35.2-64-bit.zip | 61f0f2d9abd7d54fbb81b30519d4aad8be66268e67cfc9d47871010d340821c5
MinGit-2.35.2-32-bit.zip | ddaa82f450140b2927369d757f68353467b65e31b1a0b85c537ad2759024157d
MinGit-2.35.2-busybox-64-bit.zip | 0ac509d2d2aeb35c301588e31c5afbcf4e74643606f93a4ed808203d80cea01a
MinGit-2.35.2-busybox-32-bit.zip | e8b6300acfcbfd8588e5ec022e5f46b635a00a8d77d0de1a7fc11a4820496b43
Git-2.35.2-64-bit.tar.bz2 | 92a7e9f76682b2fba0a6198a91ee78d3c1df364644b46737d59047907811899e
Git-2.35.2-32-bit.tar.bz2 | 3bf358ee0bd3add315dc90201c4d3325b3f4a6866ecaaf5e6fcd99cfe4129faf

Ciao,
Johannes
