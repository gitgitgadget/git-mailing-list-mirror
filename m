Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D939C64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 16:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjB0Q0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 11:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjB0Q0o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 11:26:44 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FE7222C3
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 08:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677515201; i=johannes.schindelin@gmx.de;
        bh=ck/1AyvZCvi+Kkij97pi4ZqDGttVv/PT6qgvEAlAjtQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ZImqWiGEZjRrP/dxDgwoRPa2y7UH/G8jYJXzlYpI6/FlosSlSrcNhYEBAfwayS3D2
         rh9yqt7UbF78hOO6pOFUh0xaqr/tpOsJTQnx6mwv2XnKZ38DH4b56nv2f7OLb9eEnd
         bQSXgshj4fumiCT0kxTi5x4rGyaqu+gljn2qG7eSUiZJ2+ORfsWjo9q2xyg5hfnwX6
         Sr5y5prf8EZkm/erWYf1oDSbGJMp5xnCX63eIOrSSNsjx2jodzxm37G5r3w2V64clI
         6Y4QgBCUSLOCxfenHyGrEMojZjo3n52TDxk97OfE7VapRT0mqR4B0WwAOSBm2528yN
         0wl+J4/7FBeIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az241-562.golb3uybh5buja00t14dfrg5uc.cx.internal.cloudapp.net
 ([172.176.137.48]) by mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MCsQ4-1pNuuO2fAW-008pte; Mon, 27 Feb 2023 17:26:40 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.40.0-rc0
Date:   Mon, 27 Feb 2023 16:26:38 +0000
Message-Id: <20230227162638.3393-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:ui4WTQdn5j6AxVoCE6B+ThCCwjjy8dJpuovWFc9HUbnTOvdHvg0
 yv73ATcOCS/lQnT0IYYR6haDMjtbq+mEoi4FY9GFdANlRJY+Rda6EW+PaDIHho/++Lm8MJt
 U8doEUMRZUl0f8WT7zY/k7WQ/c/gHEzgOM75ktnJzSeAFIztaIBfPcVMub4xGf+4+5i8tzY
 HHdCB2Lp6a+AlgpZlfOtg==
UI-OutboundReport: notjunk:1;M01:P0:XAviF7ki/Dc=;pSExxxYNSBsYoG70UJbuIdDGgrX
 Qw/mw7S98lbzR6lhliPI5GJFF5kKHcotoCDbEglXFjxJgfOcoB9gA9z8FW02ckQKwcmrR5NI7
 6OpQUldjhaoVIytA2pbkN0b3WKDj6G+G87jkTqR5pXGpwFiRG5n5WJRdBjaOzNHcfDunhRYL/
 Xb1l/a7Nwtw9VsfBiX4fajEtXj2/gKL1A6La1kSq5jfFn7Gp0Ao2Zv12Keed7YNCdYYk91N97
 Jl9lq9cEO9h9XAzkIa9wJencjmamCmGc7HxDAMS53y264ZU1JJ2aw8JGg8wlRt7Rw0BC0dBFk
 O52Yh8ehivkbfh5NlYqdUN/f+BAbon35lEFHUB3mNVbPmaXEE9LvfPRm6VG/2ghya+cv/51cI
 j4vRVcIa6aIq4HPvDHD7814z9JG1CRUbbjnsAtUHlWVGiwXd3dENSkAhEtdEu19DFZLkz8C42
 Trummr4ASMomkCUofFu2PpMw92SDXEHgS+G6yyRICj5jl7maiYj8575FznQi3Y5m6jIKV96Em
 8fLN4d8FAo5cBhWkCH4yUE44YALrArdYul8sVmXT932DEwanRO6vwWVsfRy7wzyDnqUPzYhK2
 FZlb3R+PGc8elstmKQpkoyvMZJo35P88p7Bg2VgsPPjKjz5z9DSCFny2lFh+4Sc0XoyjQ/lI5
 iQQtdQxVtv8zS9uckWxak+Eptuz0//N21MUUi9xapLG81Hglbb5sUQwVzanYwAb3rgFegh0cB
 03dbXBQGGAZa0G7hkdg2E+31VicCoU3csTg1aj0Nq/QggxDzJshDGDgGB3mBUl/F2938GBK8E
 IlFq9SgAq3WMj04Pacncr7nUFjAr0ZOWQzFj+5W+9j26Rh6csPmJcXaBsPSEKlZVr78RF53FW
 S3abfNpM2HBW+pLuN/rH0cf1jJKpM93Dk5MJY7xhHbgVNnFOdwr9HzlKIGLzBhdrHsILVGA6F
 /MIW5hbx89biwXyK7pEp0/kPen0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.40.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.40.0-rc0.windows.1

Changes since Git for Windows v2.39.2 (February 14th 2023)

New Features

  * Comes with Git v2.40.0-rc0.

Git-2.40.0-rc0-64-bit.exe | 79fbddbb371a35dcd9b9ff1c2e5e6cae02ee70850b61c177a77c55e3aebfb142
Git-2.40.0-rc0-32-bit.exe | 74856e12f4e9c4812dc7399d107f6a6cc08e808d101d8855de47312a9fec58fa
PortableGit-2.40.0-rc0-64-bit.7z.exe | c15f18be2418ac4c7958c3c78323163735e4c841a0077ed027f439b1e6e994de
PortableGit-2.40.0-rc0-32-bit.7z.exe | ef37a588ceef15f72281f7fee255273005b75b73febb798860ca0639f1e72411
MinGit-2.40.0-rc0-64-bit.zip | 1a746ae0fff8e44f6dc05f0062c031d4d84ca4d7d4425cc061eaa83c199ff236
MinGit-2.40.0-rc0-32-bit.zip | bb8eafa4488ddfcc12d7586824030d890da8ed8e008eb8d9628c834c762b750c
MinGit-2.40.0-rc0-busybox-64-bit.zip | 1226f4af12e834422d5edcde5d35ba71f05dc24ab7e2e99d09d2107d596f6239
MinGit-2.40.0-rc0-busybox-32-bit.zip | 0f98017a8d2178f198e37883175385fa7f307f9ba2a9a1c60f52603f776d033c
Git-2.40.0-rc0-64-bit.tar.bz2 | 41083788a8a3b207deddb777143e4a9f56f777050cf775c59da87735a0fb1f26
Git-2.40.0-rc0-32-bit.tar.bz2 | 637256ea38e2402b77e719c700b61c93ec61574abc9d0acf603b0fe0caaeb389

Ciao,
Johannes
