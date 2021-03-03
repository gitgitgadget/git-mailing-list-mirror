Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E0AC433E6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B821664EEC
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355359AbhCDAXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:23:34 -0500
Received: from mout.gmx.net ([212.227.15.18]:53589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243665AbhCCSkj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 13:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614796708;
        bh=qESeCAUWhGByyvz/9P19oDywXhWLr4OtpCFTRxvPP/o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=fZdFI0AKYAGKZ/NpU8AOVzpqsRpuVZ2KvxQ6QW3dQ/wU1O8Rs14g9MerL3cRq+YR8
         utoAT3YyFaaWrnBON3Oxlb0hjSYwT7x1S35Wcc4+xVqnJFD/rfJSXjfDD1W9TDjIi4
         vYlzJGvhobpA/nHa53zphNy0jK7uCgb+W305WlLE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az54-159.cu2syw3x4zuejejfhhverhjdaa.cx.internal.cloudapp.net
 ([52.167.218.166]) by mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1N2mFi-1lw3DM2Gui-0139fE; Wed, 03 Mar 2021 19:38:28 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.31.0-rc1
Date:   Wed,  3 Mar 2021 18:38:26 +0000
Message-Id: <20210303183826.6350-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.30.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:GmEBMgULU9ZKY61Q5LSXU0E2PrbJsqcxxyRffA4bBEVp8u8tgZM
 j0dxwpUHj6LPjHouwWIeLNvhuZR1IcoGsdftmb/CdGPcaMTaG6mWANYMGtEmHPrJzcYFXl3
 mrJrhSbZvpK+cOhsJx/oZLEXnN4Y4SwbCvJTY/p3zY1Q278JL2/yIVBxgMfRPWlY6ZIcUCN
 h0kY8LuTWJxxNaoes89UA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kB8qlkDbzZ0=:71I+kSJpsNrQy2Xip9MJjt
 cA0JesNbRYuQWrYVSxOys2/RgAcnZGdsWrihDxqo4AbaCUxCTfjf5NvCw0ATIYk3BA+pjmre9
 cF7Q0LNnQF1H5HSm4KXJzrJAn8H90tol789FE34b7WKmFouPZw9aGMS8xt+8rv7SMjxOSBWmV
 3apFMkkOIyZ5O1WMW8jje+QD9DdzcyTxxN9Bf6PstPY0hEyBAi+Dpo3W7oHNp07ZG5aVre57R
 s35sV44ZHHQNo1zaULKOQgSGZE4c1w9DxO0b4F3924t1qAWv1Yh4auYajHsVUtgxsNRrYpY5i
 V6WyFxMFRmUGFgci6k2+2J5iX1pWjppb6emV29DNmMkcAyfz9VSumcOsaonw30xIlgpyGfC8G
 vI+Fp0tVgiAhR/NaRgHqJWtXqELjKQlB3s1o+xYJ7WWtRpvoT+XGZ+RK1qswiqYUmiwNiP1AR
 ZZ2/nlf63MbyXfqKvf999GaNvI1nD1oC2LA2GjXQ+HVPvlh7RXrZObufeJdfI4qPst90s5xG7
 tDVc4W6EUGu085aKixRIxc4JxNVx12fFT1oqoSK2iQg5bDuQ0fJeTnbgAPO34Sq3/l/YBfIuR
 y2Av8Cia9K6+UuWIPgfABFeLsj/pdHuHfEHWm2yRtZT22L/7ngpCNgRKavbzC+SFrvotcah/G
 gdlgMfGmCPSIYECq0gJwUogfePzdpYEKtNuWhyb54OWK8aug3p1Blesc114QF1tMaDLHpm5Lr
 5yutQ5VSU7+jG3HaDKG4qbocuIAp2Rg9y2ahR8N9yA9UFdQfFB4mF/q4CIg7K1qml8XkBn9B6
 bhm52BQqFYP/75UyYKoZic2i693q5oIPc0PHLLIQ/igIOGmm/sNeE2/hMcW1IqGXmuaCzWeMa
 KyFiHk/c9hsJnSmFXA49XtimReUpK155Up7uDoYGw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.31.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.31.0-rc1.windows.1

Changes since Git for Windows v2.30.1 (February 9th 2021)

New Features

  * Comes with Git v2.31.0-rc1.
  * Comes with PCRE2 v10.36.
  * Comes with tig v2.5.2.
  * Comes with OpenSSL v1.1.1j.
  * Comes with OpenSSH v8.5p1.
  * Comes with Git Credential Manager Core v2.0.374.5910.

Git-2.31.0-rc1-64-bit.exe | 4a0d7aedb38ecd5f7739a3fd5e4e1283b2b57915dde2381190ee5d53f17e42b3
Git-2.31.0-rc1-32-bit.exe | cd074d80b9553eb46686bb4a37ae2ffa58421fee591257e941ca57212517e4f3
PortableGit-2.31.0-rc1-64-bit.7z.exe | f2d215d33778ac4f33a1c7c5b9e1699d0065e939be6e891ffe760ee3dd74fc86
PortableGit-2.31.0-rc1-32-bit.7z.exe | 1d61749005cb40903178220c648542b7cc8b46347de3d558bc2538f8cd0474ae
MinGit-2.31.0-rc1-64-bit.zip | 05f556ab7f3d1463a81b8d08dbd844917bf82720236a7edc8feef9d5df25b6cf
MinGit-2.31.0-rc1-32-bit.zip | e6129de9071115cb448a2199010be4656ae6a4aee2e50023c4f04f47cc04c75c
MinGit-2.31.0-rc1-busybox-64-bit.zip | 054fb3fbbc31a2d9fec678ee68eb2bde458a5e51bb74cf0e585f1a5fb6267ea4
MinGit-2.31.0-rc1-busybox-32-bit.zip | 79df95331ab28a9a2db37965e785ebc966b80fba90b3a07c762969dfbab66b8e
Git-2.31.0-rc1-64-bit.tar.bz2 | 5933ced6f44dd266d207fde3a5fb093eb897e7b0e68882f911c15d2ae884feb7
Git-2.31.0-rc1-32-bit.tar.bz2 | 521850caba164d1581ed50de5cbc18270bbca99995bc4c062c12fe70c43a7908

Ciao,
Johannes
