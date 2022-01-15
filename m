Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAE7C433EF
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 11:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiAOLzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jan 2022 06:55:48 -0500
Received: from mout.gmx.net ([212.227.15.18]:50221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbiAOLzr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jan 2022 06:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642247746;
        bh=JdJBVfEfiypKGYVWmRmSF7SsgY8UyRO5Z6lOihtGHDA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=lgokxsc5dxIhwx7w7O192zaWxuTw5gO6ogWsDq1PEMhvUGsh2hgZEdSlcMlqADlYa
         JxjVB5wbuyKREQdzjOQnSCXAMs9m/VALmBF1/U2upZwICsX+nA8rmab+TK9PQ5snFm
         oPfDVF07jwuQWXX6K4Rz6iktLXvoAAuY5GhlEAgk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az232-628.x3jni0md3anuvcz2px3t3ecixa.bx.internal.cloudapp.net
 ([20.127.85.131]) by mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1M1Hdw-1nAMLz3oM6-002nH2; Sat, 15 Jan 2022 12:55:46 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.35.0-rc1
Date:   Sat, 15 Jan 2022 11:55:43 +0000
Message-Id: <20220115115543.4106-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:KCMw1FfdPaAfT2/Ls9f2tsks+86FBa00MY+ahXYUccbQv2ZcBuC
 vDWPweKjivknj5dCpOcIoR9ILpwJbojlbG1qi+t6KXKUpxCcww4U096g9JoIsW0WW5BO+rA
 on43RFugvPuEkt9R0afjY/MLUKAmqy/hCOgs//qmVq1DWlfEwEeUrG+njtmcton8DJCPB/j
 TTA5lWXgaxfkS9Bcg1XAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Mcq7/7vGEs=:4JAhEUT8dSH7Rz0+SETZRN
 LDA8w3v/ebkkVrV3RRlQkq2KO3atqEkfSX7X0gKLkl4gfgCComoUDu3YDqg5UAV3blVgzfSvj
 VfeanybquV2rlhQID3RM86aUrDrdVb2oLuR5zJgkfLJx48oA4TGL+HnlJ4XIQyaNeujfCvZQy
 k273LeY+36O8x9wGUd82wAuQTf3A7D7BQsOuurWCOvlsW88JQFP2s88NSyE+Gf0UXbsIl2O2G
 2zGJeTkIYqCpMVuePS4FJc9iIIHqWOl5k1/qFO8QV41JdrQOUN+GORthWcETrepQQCwxbd+Xs
 oMbSwAwcCOQh2h8XpkuZPFVHpnNW88LoW6gmwoU4knjRc1bgmdfsCvoXVI9DMq1vF9SXbrUg2
 1YZhqFFMGmjdul/DgjxZ3TnVGWZIM/Gwv0jU8x2P9iUACA/QdM6/ofpDJnePE27CIoXo1KcMM
 3q50D/P10kJfDpqth/u/TrP3fcxvrE+pn8mcNGTFpUeyTvKgHtkGZHt4WEVw0AMSIUqTVahVZ
 ZPUitdhzp4qEzOwIFmux/L7N0PwUlErgkio6/1CJiopVuhhtYCclrm8KUkPPF9rneCRlmV7SH
 TGF/oxQDOk6VGAMQ1IBZw2iZ6PUolS9bDeQ/QRzf9412Hfgr/ds3PCNc0RgtYW/S1+li26V4U
 T/SDsr4WmZpP1TmSkc46YVZ7Nf4JkHqr25NAmylktOfGIrmCgiMCrDMN5C315KHP25CO5eEX7
 cNuLKAFP9Pc5M1a26K2My8ondiY3nPrBTilIk2bVz6PAY7a1HwmxgY5qc7mXtL6F+qvjV4HGc
 BejW8Ouitgw2FT19MM8WhxIBV1YozwBOx9CrmvZjMrrq6BfZMqgzPncEB9CpT77jgKd052IpA
 VR4zl+vyDYyTYel3wGn79CXjbL16PmkcRs4Vm4Yp+PXdhvLnaQ7rhyzVA6EfD9MivWcMC/Uil
 IatVG26lrIwr4wk2gj7Use9mg0ogwxmtC8Yjj3i2ykq4pvUSwSwa63+Q7FT4NRlLYu+T8Bc1Y
 7ZoL4P/LIN5XeSsgIdM8VXHTeRVoAUafjDYVCqV585U1OyuwIEMvdPUJp1hWgcKrfgUaaMmSM
 2HPZwAa47qmqCU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.35.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.35.0-rc1.windows.1

Changes since Git for Windows v2.34.1 (November 25th 2021)

Upcoming breaking changes

We plan to update the included bash to version 5.1 (currently 4.4) soon
after Git for Windows 2.35.0 is released. Please check your shell
scripts for potential compatibility issues.

New Features

  * Comes with Git v2.35.0-rc1.
  * Comes with a version of the MSYS2 runtime (Git for Windows flavor)
    based on Cygwin 3.3.3.
  * Comes with OpenSSL v1.1.1m.
  * Comes with Git Credential Manager Core v2.0.632.34631.
  * Comes with cURL v7.81.0.
  * Comes with tig v2.5.5.
  * Comes with patch level 3 of the MSYS2 runtime (Git for Windows
    flavor) based on Cygwin 3.3.3.

Bug Fixes

  * A bug which caused crashes when running git log with custom date
    formats in 32-bit builds was fixed.

Git-2.35.0-rc1-64-bit.exe | 86263d1281b8e43c8cb12cd5460a3c45e014e2744f9de05dafa076091ececbb5
Git-2.35.0-rc1-32-bit.exe | fa63b9228efd839d4a2ac95f4dbb3364a2af34aea1beaf5e141bc79a327c9955
PortableGit-2.35.0-rc1-64-bit.7z.exe | a7e60c8dc85fb258253080d4536690e43d9e77b5f7abc4f7d1562217265b299f
PortableGit-2.35.0-rc1-32-bit.7z.exe | 5183326b89227417e4a89203d4f7e736892bef8d2f8de52068369d3ce4b886df
MinGit-2.35.0-rc1-64-bit.zip | ab91f499f220ad6ebaeb734217bda3b019e77e8b15b0fa7a5eb9f87b6a9038e8
MinGit-2.35.0-rc1-32-bit.zip | 65d364cdb7213dc4997db44db9ffbe055654a7ba7385dfedcfde975683504c2b
MinGit-2.35.0-rc1-busybox-64-bit.zip | fc184c21102466906208f6a94bba268a4fa14318299387e2449211d0cee3a17f
MinGit-2.35.0-rc1-busybox-32-bit.zip | c4af60ec99265900eb3a61d0a9bdd2d4893c2c909bf75d322d7a16921c5b8be4
Git-2.35.0-rc1-64-bit.tar.bz2 | bb80a337373887846e520ef0257e6ec7bd26ed74256c3210b863e24b4d192a93
Git-2.35.0-rc1-32-bit.tar.bz2 | 17b422f1b1c96338166144ca2aa4586d42e65af96f303a415be51596c0fe09ea

Ciao,
Johannes
