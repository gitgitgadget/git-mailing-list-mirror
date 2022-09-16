Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EE6ECAAD3
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 03:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiIPDHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 23:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiIPDHK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 23:07:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D440C13E0F
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 20:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663297602;
        bh=TOhx2WEDRfgREY7sYFuuib6e9sCSCmgR8Mukw3eisZg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=dVf0jXGQ5ZGY/ghuoW+9cOI2LBipe8Pk0nQDYTonm2b8rRlGEjX1aji1NA4Zmnebk
         t+db11x8Ke2PnUyzUSp7kLOzcer0q9jcxa0SssEZ3euKEzDi0KXMb1roy0gDT00A60
         rNhsipmv1n6lq+3g/p6yqVleSbiod9Sla4J2CX78=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az71-923.54gadnqkfkfezo4rfhga4mummb.dx.internal.cloudapp.net
 ([20.245.191.52]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MGQnP-1oXdC02edx-00Gm97; Fri, 16 Sep 2022 05:06:42 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.38.0-rc0
Date:   Fri, 16 Sep 2022 03:06:38 +0000
Message-Id: <20220916030638.4364-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:9UoqC4OjkijUHSWjA/LYodd0keaclNkNgxb6mOG+9fiCWQzIxnl
 SbRE/K7TpSF38Ty5VFoH6ByXFktqaPzLQtLdY6cbXSLMLtmHU/gyMTKpD8Cp3OUt4Jzbdq0
 6icF+qj781pRIzVlvjeWeRAOy0VT9Exss6sTM5LugHM4R3nyYucCl044tjCUWRi5wsqFixO
 ak78pAb27enMYGj/cLMRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kCL/0CQAhEQ=:2eooeSMXsprpB344QCep8f
 t2iVJBDY/LJ7jnCItX/FzppiLobN+F827Y+GogcNmELpiCUP3Ol0gTE8eQp0Vr0h7U6eNxzOG
 1roG48yFVKHZsbbQvVdhk8dyJwRQ9aks7nhycbWzkEGO2PB6EGAfn3PUvPxUwVaWEm7gk4Haf
 hn4c7VLJhbkcrP1z7Gcm99NdTZhYu2sg3UMTrCdzzwTsPRim5PvoXt2x2XNwzT1lK2AyKuz//
 5xiEtQ3I6CDcDMY2k/jTGqRin0PqTcouVF5chEv5JXLUmXo9R3/G19Fjsc1lkCELAJIaRYn3k
 gMHYWjfRzA7xOtnzc/FwKehhiriw0k1I/yD3rKJdJ+GbapXDI9++OxTLttkC5+MmZjQpg0rl+
 H/h4dmFzru7VHLotfPxaWhF9QkdQAdncjKkGJKEEZVTt8v4dkpUabQEvzpuNwLaFhn8tJxT1B
 HISWENgSBMV6JmNVW58vGMXnVvl8wA6A6Ze3/g+x1uBSI4w/vCnHu5jlm7jk04FsJ/7veMUxK
 VNbZBWDcLlrRN2kfy7/ziTNby5RWqx10MRVy8mSQpswINY4yunL7pDfmK/6a8r5HB8ING2d3P
 dfPl+kCNpDoludSkKucdJhgMvmQ4QH99zXtk9Fek4csCd3Pck9Fo+Oi+ct6/8HuK9lwLxLlp8
 HEoLe5o9VpeMyvV/3H5BsGw9uTLFB8T8Qu0GBBmMuM1PlIHUGTAZInG7OOqaXLJYgedWh26GG
 HaAiURkk8E2ShPuywEAB3yvHZp5Zq9UK2Zu94iOQ/1pr1KzIPuoKH+npFNAjjOVVpWg7aFElY
 SO96pU3Lcp+rGJyuPYnWi2YMjatm5sswUzNJC2WGFMwqHxNfoZV4/AC4pSCYsB6ppHPRr/BkA
 UpVU7LRgaL/lIhsp3dszF07F705G4xXLKdb2I5UkOUya99IiF4tDzU+YflOW0AwAuzph89i+z
 RMl8WBioRHJZVc3pL9Is8+zBfLIhobJZeCUFs4ksjwWbmXiT+LiFIQZP5571GJG/TYdRKRS6o
 7p43znPBDLpUypRor0eIiSt6NodRSJYLtRceEcgGR4sSuf1QbZ02ZC3yCg0ewVqrlMkNh85v+
 +1sB28fhoe09KD9ja54S+mHZL8N3sTiye+WHzU4LD/KB+uZvCmp+yKCEkga/ckxgwUvZRmhb+
 9v+wXWRKs56la2IhmeAWcbuq9l
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.38.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.38.0-rc0.windows.1

Changes since Git for Windows v2.37.3 (August 30th 2022)

New Features

  * Comes with Git v2.38.0-rc0.
  * Comes with cURL v7.85.0.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.3.6.

Git-2.38.0-rc0-64-bit.exe | 2bcb263e7bc66710ef27562a795a1e68dd8a1f234c2af7510f84d64793fe65d7
Git-2.38.0-rc0-32-bit.exe | 63f30db87b724759b4671ec9fd7609cf38959067ed102e0ae48015dc3f4dcf90
PortableGit-2.38.0-rc0-64-bit.7z.exe | 00dde8571fbef07877007383d7aaa84ad850e0d7c74928637ba189e7dd7383e9
PortableGit-2.38.0-rc0-32-bit.7z.exe | c95169baf096072df3061d52004988682b46d610253aaedc86da1f088629cee4
MinGit-2.38.0-rc0-64-bit.zip | 21ad098e3b43f09dd87a1ca7c156ad01678dfe897d7a1d2976c880bbf4889717
MinGit-2.38.0-rc0-32-bit.zip | 834149307a2da541967a8f6d65e516906f3de5753d1aab46fa2113094ab9b094
MinGit-2.38.0-rc0-busybox-64-bit.zip | e602a72d6f77dae13c465eee82f19ac96e869027cc628c0fe8ad79b16de76921
MinGit-2.38.0-rc0-busybox-32-bit.zip | 5cfb917d948bcab7d3daf33d0bcdd45825a8823e3eafe13309df8c1886333d4c
Git-2.38.0-rc0-64-bit.tar.bz2 | 2665109aecc5bb5f46f0a0529c582d9bb8c7de73cd08018ddbde6ccc6fbecd38
Git-2.38.0-rc0-32-bit.tar.bz2 | 743890830de736946186d31bb3aa49dc43b9fec05b457643fb38068b5e596cd9

Ciao,
Johannes
