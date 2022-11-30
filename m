Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2891EC433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 15:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiK3P5l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 10:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiK3P5k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 10:57:40 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75781167
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 07:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669823854; bh=yob5hBK+vY75Eq3gx9J5OEx7c/6AAKeGFFa8Zt6MS2w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=OxWnKFpai9qVYHPMpOj2YXoeITyLUfo0cZWRal0mu15Gwb6fYP7lwHnKNTgmLGrIJ
         YFMNdWafSmcaLpiXCf4qPbOrJa7ikKP4OwPSugnwG36hWLAK5gcgl+oANJOsPQh8xQ
         G/UkmRydmYitNBaLv+sGQJYa/PpMvjehvGDAiWmnnodGsjp0grr9SPwF1szOMFJefl
         yR5o4zYqr8EdfrqQ4IwzOntnNR+XXl9jcRliHVwvrA4trZuoWUgu6JH55jL8f0MUH/
         iBPCFgz1C3IgbmmZLBjTOy0F3Kd+d/CM3BxFSzOKWHPL8qkAgr/ygNdss/XI9JJoLq
         /lcx6Fdp5VN6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az427-150.jclj4ohiyc1elhxtdmj1rzsk0b.bx.internal.cloudapp.net
 ([20.232.178.110]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MatRT-1oSiXN19EB-00cUC3; Wed, 30 Nov 2022 16:57:34 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.39.0-rc1
Date:   Wed, 30 Nov 2022 15:57:31 +0000
Message-Id: <20221130155732.3246-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.38.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:XUygTFqN0a2r4HNl5kJFAOKbebHpwdQUF3SVwXeG0jCVfD7kNmh
 3gc17Eep0sqvYTVYRgXhCj7/JCIKaWJKvrllAoYrDJ+XGnEJT/0vOPWY+EyKSemwZvrTjPv
 9qa0o/aPE19iIh556ERTF9wufWQR843ty8+CA1yVkzSHL+oEqnW8XEVkTVH6t8kCnPl5MsX
 UzgKzWwPpHDQoChMEhysw==
UI-OutboundReport: notjunk:1;M01:P0:qJeKjZNJoMc=;1iWqpX2UrVzbcpEc4bw39Wocbdu
 r7FRcv5i2MwGbdIb8iqoml7yG+Zw67KS0ll+R7lEvLWFKVkdEEjno973J99Ls77rApKS2wLAg
 9AxCoVYjm9OKcTpCcdhI3hjQKkROQirPxQ4IJorIzDjyjY/SPo3Ar1529yj6t6uY8yLBQVeqv
 zLdGtte7A26BJgnA4Tk6c0mcbhP9w6kBlbXSnsoav+L3j9ZddwOlRFPUgaP6VF/LrRh6KBrNN
 HUaQalkox08fNMMMsGt2Yced+xBmWoPDQR4ILcPDxDCODTgWj+hrbAHyxWFIZi7PeviomVrlk
 sI1a+dl5xRHVpPjAyRWNTaeADr0mtXrwSy3rajb01ppsuCXDRVnH9Y3ooOnC7M+4n2JdfgCoZ
 Z8iX9uu8NKH8Kee7fk6pKG82KBQivUDBDTri8AL86AqcKbkqSL6STtDwGBDV+81kWzYDnUlXl
 CCl1k8IDHorfeYs7ncngfvLkf2dtWFl7mwADK928Kvs80UfTz0osnx3tswH+FLTyP8ES2GVGJ
 9wmZ4fNBQcYtSE+E5jZhhKKgUrA2pjty111AGhk3uI1G4mALiU36ueEB498AbhMb/ZtyFs+u4
 FswPMyfgDtL5REixxAOVhfWUWqaejwRjgDF/isbzFzbcwTKxXn3t1fgLEbqWnhCvBLEFfbGrR
 Rf6eYceN7kFBPNmi+c0t2sZYhW4IPnAh02Ue241tOc0hn026QwPvw3T6yj8/6kUWveD6wFTsL
 Du0zjrYXNqSWAq1l8rZmq9VNtB8aXRTIEk3Wd2Fw9/d725s1TsS++Mpmm0yCr7rqoin0K+k6G
 9zw0ITVHlWVkrX1Vel0j1u5y3FePsSL5Zf7adRGv2uzEGrSRi2LBNRQXqPFdGvb2R0xjsmNEc
 nh8ZhbRu+sRrt8eorL28VUU3MvOYMiOYyC/W67CtKM5psOGZ2nWmNqqJmiQ+GjSPa1MpINJp7
 j2CfMUOLWc3p4giqFwtPawEitCU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.39.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.39.0-rc1.windows.1

Changes since Git for Windows v2.38.1 (October 18th 2022)

New Features

  * Comes with Git v2.39.0-rc1.
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

Bug Fixes

  * The Git executables (e.g. git.exe itself) used to have incomplete
    version information recorded in their resources, which has been
    fixed.
  * A regression introduced in Git for Windows v2.38.0 that prevented
    git.exe from running in Windows Nano Server containers was fixed.

Git-2.39.0-rc1-64-bit.exe | ea2412da9d24706a9f600d34136536e281b1ec5d67ab04cb2edfeb16eb39fc33
Git-2.39.0-rc1-32-bit.exe | aa4fc74ee343fb8e172a69ecb28b215cba84e93c70d1d25b15c70a24966bfb03
PortableGit-2.39.0-rc1-64-bit.7z.exe | dd568bd0fab26f8660a89b125b91c0f681b2b7c235681973bbd886498a62070c
PortableGit-2.39.0-rc1-32-bit.7z.exe | 0c29213329d702efaeda39bccadbda7edf7eded113a68e2b0b4c7242ac6432ae
MinGit-2.39.0-rc1-64-bit.zip | d0bf3d86da0571cfc99b39d9b06c1d58136870e0dde0235db6b3f22685633072
MinGit-2.39.0-rc1-32-bit.zip | 43f658e613de064c38619dcffa51d2fa4e55a4035f6b46054b8342613767a2de
MinGit-2.39.0-rc1-busybox-64-bit.zip | 5c4e74bc0f6d731e9fbc8693c4bfe25ea6b172d38adf70ff0c2d1015c7288f46
MinGit-2.39.0-rc1-busybox-32-bit.zip | eaaf0444b95ab48f442e7a7375dfac0e97c1547afb348a627c70795ec5edb5e2
Git-2.39.0-rc1-64-bit.tar.bz2 | 5db8ec7346080deceed5ee7f7e6c8025b4621954e0772873f1c8c528508979dc
Git-2.39.0-rc1-32-bit.tar.bz2 | db2b57ab50f4e4a5e225842f8ff31bc849ab0c5961fbdd177b3e92c45b6ba859

Ciao,
Johannes
