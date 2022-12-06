Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E969CC352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 10:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiLFKO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 05:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiLFKOe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 05:14:34 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB5517416
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 02:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1670321622; bh=kwKbEm7r/05QxfTGg0mHvZO1AKI89QMH5behokKEBsY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=NyOs/HSkGXaWugxB/zRGrnkncRhxPpd+HE5wJbfm15vEC+D3V2/L0TOTQAD+Gwehs
         mP7gSN+TUQMwPhqcPeTymE1Zdj2iiWCNkWB9dkjk6kb6V6abGQsK06CZjW00aLJJtb
         k6NB8hDBqunHGBoCbu+wtfyCLAmiktzHKw1NDthG3AY9b4lW1Pd+MpPUd1v3wtcSZq
         fmjI5U6sfF21IROM1hLGBXI0H2KdWF3dy8wvDQ2JXNwPOI8ZOt944uwpX8YixijQFa
         OKhAx9m3jm7IJAr3qGPrZrbtpmUbnEqIHXSZK/sD9rbJRr6/nSPatrZi9xXzTjxH9K
         0Np8h+q3USuRA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az242-313.30y45kzjdhxebl3rnllq33u0kc.cx.internal.cloudapp.net
 ([20.10.188.108]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MLQxX-1pJLFd0IGR-00IUHC; Tue, 06 Dec 2022 11:13:42 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.39.0-rc2
Date:   Tue,  6 Dec 2022 10:13:39 +0000
Message-Id: <20221206101339.3276-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.38.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:JVj38Hpg/WZp+01ZSRKOiJ+l7oktux5yhYa9UDH+3wekSmCQPoq
 vcmkXXhh16fFebCEKQvEeoEZeqWIttiPpOu5DPc2Y5uzt/7UxoEO8c8xtZG4wg6WmZvRX5z
 TojknxU3W2YnhhNrfrckICP8zCpx3ietvMIgh811+XIqhKCMBD9bf9fa/U8+ssrR1D3yovY
 HxjAZjIC9XUimZeWa1zPw==
UI-OutboundReport: notjunk:1;M01:P0:5DdRbU5hA6I=;WumIPv93Zb0IdXRchHKTuBaJDYq
 kMjr50wEK3dNXTcEsRy70m8RbC0iUwvY2N+Gn8k19yBdkh7KulO3Cj1GHOqiwO0hkXvwDXHC0
 7S0Chp7v9ZNtCZe4kyHbVfv1HzMW/DO7qBSesqvMGvEDMOQPtzoq2YMSZqm/t52iJlQSwfEOv
 hCRwCIVGTvpcl/mhzATbEmhse+W8PQgdWvZglJl3KCsahhWj/sgp6DxiCNAe+zc6fZeh6w+cu
 DHBRlQGg0riXPM2RAp834wK7mRpnv/E+/dTvakGN4jKsvcVISeJlBtaWHV6eLpi21Itg1x+gG
 SUAqt0CQCgiYoYlNTO2+uinbH1L9LZ3C4iPA6QnltL5MladSa27bk99N7GCl8A7pfv8bCcTqm
 tP7bzy2oY6wm6UZ601zrQvzmr6GCppJVJDr7x/vwCZvw/j2IlooYAW/0RzOQLMhSMtD1zqXfV
 1uRa/4isrO7xi0Y9sEwHHRBNDOyi4mUi0056nqZhJsXG/knkrkLrSEjcF6m6MfBRJioMKoTMr
 kvTgDPIqwJh7/dF/Dp3KOxIwMv5WiM843GxwMxT+HkM1m6YuTe8NhanE/p9dhGHBdYbYzhGNP
 9r1bmcSFagF80n0RR4SAjjoqX9FZn3M5KRHJBpkY+h0m3Qn9u5ph8hasxugCXCUFw/qMid9kY
 RPkoMpTOMIIBQRyVeRTiYtFK5/AGmJh/NpL94hTVbI23goXKSXkvHwg1AxOkEmAe5hzCTVD0F
 fBHIkhwnv5FIeid4M3zz7pBdprlHVbwYRwXeKLWeA1wKLOwZW5Tq12n4cJ7Ir9Z98mng2Ochq
 1PdyWzgcCgDVmkBV+/SMyOhT+QARt7WWqdQSIIscxlUALaIQzudQCguiIQRELkx5hEjKQevAa
 90L1xF5reOmfZsY+GpeJ3EQ9ELujKUZvSgfCB1xHUd7LBW2KJbiJqQbEUMGr+EciK8PEasQ7g
 sTIc8g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.39.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.39.0-rc2.windows.1

Changes since Git for Windows v2.38.1 (October 18th 2022)

New Features

  * Comes with Git v2.39.0-rc2.
  * Comes with OpenSSL v1.1.1s.
  * Comes with cURL v7.86.0.
  * The Portable Git edition (which comes as a self-extracting 7-Zip
    archive) now uses the latest 7-Zip version to self-extract.
  * Comes with OpenSSH v9.1p1.
  * It is now possible to generate and use SSH keys protected by
    security keys (AKA FIDO devices) via Windows Hello, e.g. via
    ssh-keygen.exe -t ecdsa-sk.
  * Portable Git no longer configures color.diff, color.status and
    color.branch individually, but configures color.ui instead, which
    makes it easier to override the default.
  * Comes with GNU TLS v3.7.8.
  * Comes with Git Credential Manager Core v2.0.877.
  * Comes with MinTTY v3.6.2.
  * Comes with Bash v5.2 patchlevel 12.
  * Comes with Git LFS v3.3.0.

Bug Fixes

  * The Git executables (e.g. git.exe itself) used to have incomplete
    version information recorded in their resources, which has been
    fixed.
  * A regression introduced in Git for Windows v2.38.0 that prevented
    git.exe from running in Windows Nano Server containers was fixed.

Git-2.39.0-rc2-64-bit.exe | 00845a71bc814d2ace4a83f25ee042e04e1e742813460ee64b99028c801aaac2
Git-2.39.0-rc2-32-bit.exe | 214c9e69e1ca6b0a299b4028f0053a735f07cdc27504a187d720048de33f5715
PortableGit-2.39.0-rc2-64-bit.7z.exe | 62557cbfb57e40da55dc96596d985dc409ee8f665fa265856982b92320773d27
PortableGit-2.39.0-rc2-32-bit.7z.exe | ba968b714dab78d63ad0fa66c1ab38980d46a591c2752e987f47523c136de90a
MinGit-2.39.0-rc2-64-bit.zip | c05bd4694da21047083b0858a09453f6cf1c871933ec2c303bf352eb0b0391fb
MinGit-2.39.0-rc2-32-bit.zip | 6d55bf2e405f7005477af028d670ee5fe79e22d5e1b7ab282ef5c030b3c9625c
MinGit-2.39.0-rc2-busybox-64-bit.zip | c7617169686d04f6622a545019b000f318151a774e769e900595a1db21b4ba6d
MinGit-2.39.0-rc2-busybox-32-bit.zip | 9b1593b76b759f41631e43f775ac40ce902eba24247cadd02a0fdd1a265e063a
Git-2.39.0-rc2-64-bit.tar.bz2 | cf8d13e34810f6e90403098783c47c8c3213a3a6cbc35578d5e63f731b29e1a6
Git-2.39.0-rc2-32-bit.tar.bz2 | 2e1e4100e80c62bcf7086140ea30e07f107328e2378545302620c27896f87be8

Ciao,
Johannes
