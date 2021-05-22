Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EDDC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 15:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1624261163
	for <git@archiver.kernel.org>; Sat, 22 May 2021 15:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhEVP16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 11:27:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:41665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231191AbhEVP15 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 11:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621697191;
        bh=wivEV7Abx6FF6hlFj6F3E/5tpdN3iI1LhEa+nCogZsI=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=E1tUO2ywEOQH1CNfWiRhBNr7HVxDr9Vsnn18j1ZtOGzf8YKY9Nc179pWf4GVSfhY7
         LIpERUQkZh+K0FWhoXRMfoT0ROfwccuXIwS3n9DECD0bWGTD4Ropqu7RV9ghfwjzD7
         ueILVvZGvUP8j6ZoML9Q9GRJD1eHkhTgfC0PK0YU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.198.229] ([89.1.215.198]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjjCF-1l0fAi0IDz-00lEtn; Sat, 22
 May 2021 17:26:31 +0200
Date:   Sat, 22 May 2021 02:33:50 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.32.0-rc1
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1M9Wuq-1lpzpj0bZ6-005clg@mail.gmx.net>
X-Provags-ID: V03:K1:FRqcA4DkwvN5IHrTuCR+F5BcEDp24e3JgpofPSsuQ0glq1urBy6
 ZY+b3nLKxW1nAHMID/H9mW8vKu3EbF7Z6h+Ha7CUPqLarMxjhP7O/kAAb94ddVeUb6TjiZ5
 EWZtZPhiNeA76f8ZrirEsriTlKGM0bXfb2vydGevHVRRMPsrodfQ4TDp2zQO2P9M/xrmOMX
 lh7tfbLtS2dtTqCC4Nt6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F70tvNV9heA=:V7KZH/dyZAepoCMJWmmoyr
 mVGBU711Rap4gllQNV6Wczv4LcWw9TlmZmCrSFU8M/V/cGxp0/wdP+ddUN0jJb2YISpdpRbQb
 GgVHUMx19VX1KAb46Zq8nk5iLhLGnGPpMo1h6iGyk2p/aLl2Ibmmqit+XapZ8RbqH8TiMSXbW
 3CSjKxzd3Au6s2uCVc4iBzxl5zalFrATmjLXk+Di/+g3ty+PzgqJoasEG0teNT5kClzMlb1Cm
 iyoTAuUIjyVy1gR/QC0wJX35hwvS0VQ/7c6FDuT6iQt99ZKwbbjUtZKwLIsiHVvSKDt0AV/MQ
 cbkec5EP+nZWiRLA16asa7Vyh7EhIA17psTWBqgiPbHvV8hvaRIzt+UlkwD1hZskvLJTR1BFc
 OycFnlRXXUN26QQaljkYbNOwJpn7yg4F1lmCIF/v5uLFfTp1gZsCdjcdEFZlaHXV6PG6pAwH4
 xGKcSq9Q9fE+i7qa3mz6Y+tZ1ETH8oOpdg5VWr43MVM5XZ6aPjzB28TBd7erRweLtLBJpaAA1
 q+pS0JdqsmmfEQdAjXCOmWxzD/MFWOX3gPediYjM+1cJ3qew5d0zsT7RC9G3otgl7ojQwXcGL
 LYsjVL4Y12i9rU2CTbI7dW1SDl9Wp36iqWRwVqpmquENiYfAxRzR/1K4BoyyV4vy4qh1k6AhM
 Sd56dZz+q+z0dqLl78O9TyQgvD2wRrCyXMxmWTcvvobeaDlv83ndJV26Itx8fio5mbYnZJHaK
 p2nEPaKE30YXe3fhaXm7cesSDWPGacU3MnJ3Dm9HANtD1j+cIOudtd1z44D/lNgxfPDT8sCGI
 ZBsTDKokzSSOsMCH06HOMoG+ORFOcOcaDMgMK4aEJozYAd0RnTClqkzAHHAWcLSJeRnVhtVkk
 q2JX5h1I3qL3oguI6rm3Wp9vsKZcZ3Qqcr8gQbT6+FfFh/eo318k+Ed38L5eRjFIT1C1dnwW3
 RHYhAONXUZHKOGEq9CVVsZpj92IQY2JCGtoLphj8aa4FP+9ZTDFM86jvBfqw2CDooWMkkPIvC
 XAEdMDn2+QlFjzPvlfQ2lIJe3A5ea/8ArMma95aXUe9kWxLQLjIcaOQIdyxSaesX5jHtOwK9C
 /IF0HvPs5GVo/t0wJ80Zg2zNs+Plz+CAqKmVm2Ob+3ISQ//LK2RQYTU9qk3sZFml4aD01Ng4r
 HhkFpiIlvtmYi9Pbfs7dpG9yLvK3Z7SmfQUivaF/1pU81u4WdeFe+zbcJtDvL2GgqLhJ/Dg7w
 Nx4pQQbl7p1JCoF+3
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.32.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.32.0-rc1.windows.1

Please note that the installer (and the included executables) are
code-signed with a renewed certificate, therefore you might be greeted
with a friendly SmartScreen message that wants you to discourage to trust
this version ;-)

Changes since Git for Windows v2.31.1 (March 27th 2021)

New Features

  * Comes with Git v2.32.0-rc1.
  * Comes with cURL v7.76.1.
  * Comes with Git Credential Manager Core v2.0.452.3248.
  * The installer now offers to install a Windows Terminal profile.

Bug Fixes

  * When testing a custom editor in the installer, we now spawn it in
    non-elevated mode, fixing e.g. Atom when an instance is already
    running.
  * The meta credential-helper used by the Portable Git edition of Git
    for Windows sometimes crashed, which has been fixed.
  * The auto-updater no longer suggests to downgrade from -rc0 versions
    .

Git-2.32.0-rc1-64-bit.exe | b78bfa67b98c27e32d001bc824485803ec5abac1d594a23f3a6a8b2b3256a403
Git-2.32.0-rc1-32-bit.exe | 7f670aa619cc7ce51ac71180249d88be57fa9225a68a221f9e97e573773292e8
PortableGit-2.32.0-rc1-64-bit.7z.exe | 9e66faa533a94b164819273190db12e21ad793389bbc39c5219213f8983307e8
PortableGit-2.32.0-rc1-32-bit.7z.exe | ee1208678cf3411475b8d174d3eeea76ffca75e197a34b388035c5339271f33b
MinGit-2.32.0-rc1-64-bit.zip | 0b3fe56ce75cfee8fd9de2f6ce9b0f3c6979d3307270fc4b989190ac112c7697
MinGit-2.32.0-rc1-32-bit.zip | 7243296fd414aaf7be1e9a8ca90dcf8e0100ed60731cd18c3234b1904fd1411e
MinGit-2.32.0-rc1-busybox-64-bit.zip | bab774be1f2d0cfa7f998f58c7f078902a538524f04061c8a53fb1689edd60c0
MinGit-2.32.0-rc1-busybox-32-bit.zip | f04c19537c30fe2690fa5f02060bad53b020cc8addc1fa00fbd1440ec66da262
Git-2.32.0-rc1-64-bit.tar.bz2 | 31a5d4191e66ff0881e9532fd8815b4efb71d1beba4a297f19f473be629e06a9
Git-2.32.0-rc1-32-bit.tar.bz2 | 694f8a558a733a9c8616b527a0e433e53f7b95a32a1d8e53038445807c38e530

Ciao,
Johannes
