Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B8BCCA47F
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 11:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347297AbiFOL0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 07:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347295AbiFOL0f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 07:26:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F434578A
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 04:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655292391;
        bh=RXTuu8f5EMupl8tJVKKW3zwtopBxUTZ8cWczjkg1GBA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=jnX5jhkOpXVKW4GApmKLOTarQAV292Xi9OLuQep75Dz/Rbj4YrN9b62QjZIBQV6XC
         TUpayxan7wmFLr+2BA5jzr0tBtRarMG6bf5NZqRNd1ExQp+HVw4n0lCgkUZYjQZ2+6
         JI/aY1Ie0qyUIE3eMRoDjFv8F3AGfcrjkWL16TBw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az95-165.pq21ngt4mckezax5v03dvw0kka.ex.internal.cloudapp.net
 ([20.241.81.85]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1M9o1v-1o6gMd3xob-005qQS; Wed, 15 Jun 2022 13:26:31 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.37.0-rc0
Date:   Wed, 15 Jun 2022 11:26:28 +0000
Message-Id: <20220615112628.4144-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.36.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:z8WwkmwazYDhGbyfT7Xd8AQ2A6hNg5F4ie4UsM2XQtOWSfjBtB8
 CO0NRT9k63UNEHviXO3lfdVdY89bygA4gzoFP7XhYt2mrhc+sFnOtWjAG8CQQTu2KyavarM
 q8v1NTOkcdgmSZbohmnJSDCQ3XEqvM1oZbkHLRBKxlw1WzmVujb1+1t7QhRZjZY2hz1X+4U
 q08s6cMHhT4MpxxJmKDAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P3LtdnB2N7M=:yU+KXhqRWsIk83mUCbutEp
 vR3o0+j0rBYk8y6YE72B9auueyXgP/2z+ja5pVlvKZGsDZ4bLKMNZ5j3nkWEDZ69qJvIkLKsF
 GptmvKbSMLF5+xYzJVBevD1JrwlPMI2PEagPtkdBaOU2MLOQpXORpofAR+KosXAMO4p4F29fU
 +4sI88jBvY2bKqhfWH0GtxbInb2tUsEee0YLmYDzdTX5wAPxJ1R//jBmRXcwJhfSFsGwZoVsQ
 LLokV+m06p/8uqcGstOOlTgiOOq/LH587SSVkNOMVqazNgo1h5oMZ8xHYywXU+akSSORsw+Uy
 VagjL2+gonpAMHGHVGH8o3KqzKEeMP2pZ/b6XjCTqzGDAidiNfzHI1gdTXaQYSH5Ac7Homv4/
 OdEIxNamIM7DoPhHJeyJcxaYIht4ipIpjF/yr5oO/AILjrnM9Ul7dyVAi+wz4EMzZCQHBNYOq
 drIyuX7GDobnoA7xUuLbuXJXVfzE2iw6BcOiAbT+rdEEtmjqy7l1BC09CrYyZSFUqh4MnK0Q9
 8qNfl1HyIK15HBYiIEFEdrGMK5dwF8lhkBlp+rSOguC4pM+RpO7L4N5+arhLePe8iu/WMsCuW
 LhlDIi4AyouPT+897DJlhbggIlISkMjFYOytGux3EEYT2YtLryw8rJqDFm0x6zDtGEJmNxAaj
 D0l20SpHugBlepp4Wvp78DwVn/KFuqazN0ZHNBYceUwskUdu5zsayfVfo+qiAgk7smKZ+s+Mv
 tyOs4RJ2QwUW3G9Eeg6gNBAIRqHT8MtF8v1D9l3H+1XS2raqgkAodJ6o0EIsaZ/0wzrDroSdP
 94p6UNauJ58q6N/7qwZ/6MxoUYuoH7D7RElApwDjEPKbYiMLX6ZRTDg0EXsCMWzhLVAO/X0ag
 4lKI1+NGEAt1VJHXI6hhBVFd8OBNV8Mam9hg1I+Gs0dni7EU2XKMKOPWUfGgMzUDptGOLOUrB
 GBJT4gGR8bpWTm7SUpdBkVqjTmcHYVwtFsA/Rgd8rJZ+Hq4UfzATOY/nn1BlRua8ntngutDyg
 jaNodsqM/7L7G6Ehgk5Pkaf+nkUAzrhIeyLp+LX1p2b12c5qODtoSzypW8U8un/Oeskg2agpj
 QOiQqtClUwjy2+W8HoZx23IhpaOitmKouk1857Qag+DNjZ4hbEcbOmKdg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.37.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.37.0-rc0.windows.1

Changes since Git for Windows v2.36.1 (May 9th 2022)

New Features

  * Comes with Git v2.37.0-rc0.
  * Comes with cURL v7.83.1.
  * Many anti-malware products seem to have problems with our MSYS2
    runtime, leading to problems running e.g. git subtree. We added a
    workaround that hopefully helps in most of these scenarios.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.3.5.
  * Comes with PCRE2 v10.40.
  * Comes with Git LFS v3.2.0.
  * Comes with GNU TLS v3.7.6.
  * SSH's CBC ciphers, which were re-enabled in 2017 to better support
    Azure Repos have again been disabled by default because Azure Repos
    does not require them any longer.

Bug Fixes

  * The Git for Windows-only --show-ignored-directory option of git
    status, which was deprecated a long time ago, was finally removed.
  * A crash when running Git for Windows in Wine was fixed.

Git-2.37.0-rc0-64-bit.exe | 9d3b25406b4f7f30d892e1dfb64e92f92b590a358ab565e2160bfe618c00f3fa
Git-2.37.0-rc0-32-bit.exe | 3a64c014468274e8b91958c96eb85d415c575eaa80787aad9a4c747e372055b1
PortableGit-2.37.0-rc0-64-bit.7z.exe | 8621dbf882e700a1bb9edf8b44554ad961cb0fd734adf3ba1006c255f36562dc
PortableGit-2.37.0-rc0-32-bit.7z.exe | 12df0dc25624245084a8f3489f2ec7d165e9631cd76f0bf514a6463ce4d26350
MinGit-2.37.0-rc0-64-bit.zip | 5a246bd20553a9d806eece96d7a6d11a7fd9c8e19cf604ff4462ca5a88a467c3
MinGit-2.37.0-rc0-32-bit.zip | c31359fd76a9cb42f61b3f1ec2ef9575fbe8efafe6a1ae331ce725469e1e7991
MinGit-2.37.0-rc0-busybox-64-bit.zip | 78d96625acce987f9448e6e32c0cf1ab50112b8e40f0cf88689d4c880853eebc
MinGit-2.37.0-rc0-busybox-32-bit.zip | 6e393b8745d3b2c155882bb8e659a1ff2a8bef2c805db0a60dd8fb2fe893dbb5
Git-2.37.0-rc0-64-bit.tar.bz2 | b440f6d46de57235aba3007ba6206906aa6659cd78fa24c75827f8307f91f87f
Git-2.37.0-rc0-32-bit.tar.bz2 | 6956d5b2010a6cba72ef118f9e3f04ab70cab8664b443177d71828ec9ffcdd69

Ciao,
Johannes
