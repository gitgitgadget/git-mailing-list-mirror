Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4F7C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 17:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjDYRSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 13:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjDYRSD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 13:18:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824E0122
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682443079; i=johannes.schindelin@gmx.de;
        bh=UkHlxjCMiAHrFKHNRkpfQOkdg/xqtmxUyW0SnCroTZU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ep2eG4/VMOOcStxmkh9K2epWWV67OHTtHQ0b0nDQkeYwdtfIddhV4p9+AcOwgX6/z
         3UzlwUPHQayJ9O928pUh33sVBKtooTURJX9lwb3GGgFmiCNAH8S/4V55HrkjReVk7A
         aE2UaLeHceq5l/oT9/N29PHa/PvWAdQnv0TX9bAgUQdNmVR2vRNidI9KuRp0EWLtCa
         K/arBPVVyEssc9DWPfCqORGvJ2nTNrAj0sQ6zVr2TIjBx8fkRMgV6SWGwRy2i8UEdU
         pynlAHieVpllkgKCQ5uHq5+kFITEkPcmC7qWqhZsSsbpFk79D1UOZrQdK95NyjIeYE
         TToxLR3IHq3qw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az710-665.yetzqxdubp1uzd45l1y0n1ozwd.gx.internal.cloudapp.net
 ([40.122.243.65]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MOREc-1pdgls2zQk-00PtoV; Tue, 25 Apr 2023 19:17:59 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.40.1
Date:   Tue, 25 Apr 2023 17:17:56 +0000
Message-Id: <20230425171756.3852-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.40.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:ro3kZb4MWHKUF9oHlEbIxqtserSo9lG951VFNc6YJxWFFosax7h
 Mv69JRmHfpO8c81OgBZxDdg0DDbJhlw44F0IsMR8ZtqVDTEX09AhOEY6SlPGji/5nDudK/S
 rUlU/6Yts6InWrS8s43rnKaCc+OKF8cTFBDj/8T1KDUBqM0d5UawG1hKsIswTfjbZet1287
 /UJ3krMqyaRla+gI6racA==
UI-OutboundReport: notjunk:1;M01:P0:2obzOcgLL5U=;i90fE4jV+Dy/+XR4Cika6uN8dlw
 pTtzt6yzPS62VRZP2kT9HRb9mh8kBwo4oOfe7VLf/zXFkEwaTy1C+UAb399OShPR7ilwhd2DQ
 NrPmATf0PRGndLwO5O7vf4fXNjfTXpksNQlVOIqrM8sUHLCfOabysqaxhTPHMJsbsO7P08nI5
 7CG+/V7I9OjEcLulfBL4PChEGLcw08t0HhVFL2k4w4+A6CGTOE4Lz6ZB6nUvf38+xot10aj4T
 2egDCwLd4PGmZ2KJ+a060N9FZ3B7t9vfSY2BLruvm01SEfKny8fTqGATq+mAjAeykcKHM/gfg
 BqgoteLx1oCyzI5Buf7qYFX9q9hACe6Z/Aol1LWQTvv+NO9hR0qCLXg+BaSQWezALrb/LHgfY
 dYbUd5Nrs126oAb8861zSlt9/orGhrVlMTY54kB21kspwkJK53ootNfE9czSq3sAckD1gkiiW
 klvc+NfaPRY+fLhFXSkbITFlnJM7tsEA33V2/Yl/WMambWnMt0BsnC7nTohGzwYPCvpJh1V7M
 g7i6RxE/8viScdworbzp0qssSXb01Z3tmXUq1HxTC/wnOCmG8ajaqRxBBCDASK93X6Hmb5Z22
 0R78UGcuy9h9/tPo/Brw4DomXTmp+++1jo4+wL20XAaxxevLv6KTzyQ+s37H+UmDNAuRmDrTS
 18AJzXAPGFF7A3Ewa8pbrCzT3JOieHh3JmD1M/wV1P4waCMaJ5hUSLpopRRYcRyTXQFphwoDN
 nvxZp0HpdjqDz0l2QdHS2ntidCvITGRMRG3Utx86N84XjE99qFoRDUJUmF1N0cijFLlKDUc/u
 d7aCU1ET+n0LzxoPi8C35gYfEVLVjxAf3KXri5YQv//aexJhtOKXcuDkzBtTCwbPj7tX2w3Jw
 nO8GcvW7pfWEErQPRDhb2L2z45wrXi9bMEX6elA6zX3wm4oFAAyDYjKIGv6BiPzn/WTepOVJ6
 g9zcmhcheohi1xevxm34m6bWRPc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.40.1 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.40.0 (March 14th 2023)

This is a security release, addressing CVE-2023-29012, CVE-2023-29011,
CVE-2023-29007, CVE-2023-25815 and CVE-2023-25652.

As announced previously, Git for Windows will drop support for Windows
7 and for Windows 8 in one of the next versions, following Cygwin's and
MSYS2's lead (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Also following the footsteps of the MSYS2 and Cygwin projects on which
Git for Windows depends, the 32-bit variant of Git for Windows is
nearing its end of support.

New Features

  * Comes with Git v2.40.1.

Bug Fixes

  * Addresses CVE-2023-29012, a vulnerability where starting Git CMD
    would execute doskey.exe in the current directory, if it exists.
  * Addresses CVE-2023-29011, a vulnerability where the SOCKS5 proxy
    called connect.exe is susceptible to picking up an untrusted
    configuration on multi-user machines.
  * Addresses CVE-2023-29007, a vulnerability where git submodule
    deinit can inadvertently introduce malicious changes into the Git
    config file.
  * Addresses CVE-2023-25815, a vulnerability where Git can
    unexpectedly show crafted "localized" messages written by another
    user on a multi-user machine.
  * Addresses CVE-2023-25652, a vulnerability where git apply --reject
    could follow symbolic links to write files outside the worktree.

Git-2.40.1-64-bit.exe | d2f0fbf9d84622b2aa4aed401daf6dedb8ac89bb388af02078ba375496a873dc
Git-2.40.1-32-bit.exe | 3ee2289a4f6e9917f702bd032a67874c11aa05bf2d28d967986e40d4f7f50636
PortableGit-2.40.1-64-bit.7z.exe | 9e1d819aef3284420adf6d923b0d4865254bd403641d915975e49ddea1e7cdf9
PortableGit-2.40.1-32-bit.7z.exe | e1360e94cb292862fb023018578a1029022a09278b160f7264c6dc444f65c9ca
MinGit-2.40.1-64-bit.zip | 36498716572394918625476ca207df3d5f8b535a669e9aad7a99919d0179848c
MinGit-2.40.1-32-bit.zip | 8bfc48e5211cc209768297e0b71c253b2d8393875d7b3daef8c54909634daa16
MinGit-2.40.1-busybox-64-bit.zip | 8c829d6f3ae0d48e5939b7ddccbaea44b8ef2a38f9e28c3afa691e0451432b14
MinGit-2.40.1-busybox-32-bit.zip | e31c73c0b7d3546fba54e9416bf4ce850ea7e528eb6c8b059fdd941ad78749c7
Git-2.40.1-64-bit.tar.bz2 | 249b3f31b14b802c26e64f082131fe3346af7de204a897438a0027b67fdcd0b7
Git-2.40.1-32-bit.tar.bz2 | be7c1b51bc30187a28d77e5f71e5bbcd768b2d0021ba11ad26178f08920533fb

Ciao,
Johannes
