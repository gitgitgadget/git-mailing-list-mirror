Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7C6C433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 23:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1844474AbiAXXJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 18:09:05 -0500
Received: from mout.gmx.net ([212.227.17.21]:60601 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1838474AbiAXWqm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 17:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643064399;
        bh=7dHWUu/XRZ0I0j4mgIohybxaV/m0hFzX95jZdyTejxY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=dX9+7DYqk60Qjmqj7j17BD3wJbGwuIOET4mXDPcE8h6HzPxkT4RVT2/Ll3rfDDI+W
         YAuiyTBOfIRpqCtf0kgWhtR0XeU5/6fQ6RZV9gU57aFOOkHaIPurWS+RoXMCqW0Ag/
         KWBxdhCR1jFtxcdI+b3+BPV82xYyAwCISHDkCbTk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az207-895.qghpr4jfzqnezg3apl5mcftwhc.gx.internal.cloudapp.net
 ([104.43.164.244]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MUGeB-1mkwaS1mJH-00RLIr; Mon, 24 Jan 2022 23:46:39 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.35.0
Date:   Mon, 24 Jan 2022 22:46:35 +0000
Message-Id: <20220124224635.5166-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.35.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:8CQr+wwsQinrcD2g6QK6JYYIQnXZv/Kl4cCFCU9iqBYGGSpmtr+
 mUrrlITp4NJpqKel08ot3x2OxjFyFL8/wJFkSTlXSSB1fhj69YYDiZRKZX5pk196Bz5i5xh
 SRSufZM8yOOh8qte5LyiEzNtbUVkdPfR74Isn5T2AXxanybIbIOAPtTPugCnxx/d3lSUyX+
 yceFP+WNhKwcw36ChD6Aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+eMfxbJXb5M=:2PyYv+bT1yq4N2KA4R+MQ7
 SB/FNYaMivr4QD1q7XwzTs+DU5H2/yI7HxcGRvBiAL7Yqsygjm53ATmfOU/KL1HQCy/qVTrcw
 i1cvuCzIY0Gta6uGJ/CW4FqGRrQ2ECpfyEK+EXj6MzM1CickL/9HkQEusZ6dWJQikzfHqFQH0
 sfV19v11l7xpPqTwHkbibZVgIm1DGkVOmFXo6EsJCbH3nSBeQ2RGF7outq7F5oqVXs53MPidG
 GReTWAkOaNAgi9Yd0he/MMxeXwykt7vcuQZMY37i4AVCRl0Dq70eTnB4+uVsEF3OLLpF0CIUT
 cjmIrMhX2fsBajQWYQ33MOo4NDvAedMf9psFH1ctp2T/+g1IPsJrt+EjymCAQNkE8Jz5n/zXn
 mZZ1US2POjRscsXDdcEKS8zqe7Yw7lmuAavlAMd5w+BQVU+zh1jyAaTQsbnWEjVMgKMQGxG9a
 7rgBtNWqsH/BxwLdy7/1lF6Ajp1QrC59k57PG1TR64pk77El/YGLcIXfpzeDThnhTzMeDaDu0
 54WiMtQ8GzpsEhEz4wew6tVxK2z99R0VLzJIhOGlMjvC6WDaZyi1N8pWTfODQ2ZF/+/AiqELn
 f7TNE2/zEY6opeuwsc2KUVxO/gAR1RqAxAJm678RXfMeYfaTEWBO39LJSg73V76QWzmvhkOc/
 YmfcGgPqM7OcS/Cr98MV4qMSbZ7Ljd6m8/gPBMfBW7z3qc3pwFShwR05o6qNS74TNcmUB1cPX
 GtC2hxwmkezNLSzVhsCHy0WgVTYU6RDTy1BlDNBCRE8U2wAG0xVBOYCe3anaz5+vycWsQV9Wk
 qzJfB4b19NkC325PvUhLXVRxR6jPjlH1xKbHiBByjXTqtJO1KO5kxTvcKbi4iDo4JP1awx21G
 +T78Gk/7mH7LiYip66cg9Pz43K7xc+nO+dSeuj9S8h1LU1QoJEV2kLHuQBF02MOM1YCKFmJoy
 J3UH2Wn5apxL3iPnPuKxXE10ZQoo0f7PWGOarKX4X/3oHmXuL4yiPnN53gB3DAUtGya4syx90
 Z2fVNuSx4oV8SUh4oUeZ5QN1dHzbjQoyCug08OXm7xSaw5wNBm08jd/OCfFAJ1GWu6OQR1mIX
 DWJUxasR41rcDU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.35.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.34.1 (November 25th 2021)

Upcoming breaking changes

We plan to update the included bash to version 5.1 (currently 4.4) soon
after Git for Windows 2.35.0 is released. Please check your shell
scripts for potential compatibility issues.

New Features

  * Comes with Git v2.35.0.
  * Comes with a version of the MSYS2 runtime (Git for Windows flavor)
    based on Cygwin 3.3.3.
  * Comes with OpenSSL v1.1.1m.
  * Comes with Git Credential Manager Core v2.0.632.34631.
  * Comes with cURL v7.81.0.
  * Comes with tig v2.5.5.
  * Comes with patch level 4 of the MSYS2 runtime (Git for Windows
    flavor) based on Cygwin 3.3.3.

Bug Fixes

  * A bug which caused crashes when running git log with custom date
    formats in 32-bit builds was fixed.

Git-2.35.0-64-bit.exe | 1f59a96ca29c98260c36ccac594cf5c362160d442e0c7197d36cc99ecc6c3447
Git-2.35.0-32-bit.exe | 3655a3fad05398f6971ca46f49a00b0e4e3ff15141e73e1016c5524403fa7639
PortableGit-2.35.0-64-bit.7z.exe | 5a7e229acec0dfe840055a1327156fe1fdf0ed4ad709e12fab4f1a0e3dca39c3
PortableGit-2.35.0-32-bit.7z.exe | e291afdcfd05aa81e5d0b6928e3ca28094239e8f51e3fba26feb5a61a0c173d4
MinGit-2.35.0-64-bit.zip | 0bf378926e3ddad8eb24808fe9d03919c6849cf503950ad2bec82e8d67e47511
MinGit-2.35.0-32-bit.zip | b8bd8a6add624b6528c6bdeca3964233f2b87f81d6310af4dac10faa8ab85128
MinGit-2.35.0-busybox-64-bit.zip | 84dc09ff298911e466051cc14f33f0a99070e2bfae2e8f74812215f1cbefc976
MinGit-2.35.0-busybox-32-bit.zip | 34690384190c8b7be25050533a213f449bac06007f9e8d017f6411f93c05982e
Git-2.35.0-64-bit.tar.bz2 | 4d853e3f2c05f4fa57b5b857946fe08dfd6e6c3e671dc3b36b23da91f48bd575
Git-2.35.0-32-bit.tar.bz2 | cb79f43ba41eed7c6abef5cc99b72bb0f2e688a786f6bc5f41dc41598e1285fd

Ciao,
Johannes
