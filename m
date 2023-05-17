Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD35C77B7D
	for <git@archiver.kernel.org>; Wed, 17 May 2023 13:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjEQNwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 09:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjEQNwY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 09:52:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD1898
        for <git@vger.kernel.org>; Wed, 17 May 2023 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684331540; i=johannes.schindelin@gmx.de;
        bh=Lcp6I2sp4mGIECKJln75J87pDHvMbqp2a3comlPXJfc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Rfn6QvreFUXNonVbF1G5ajVlzryus9LU+6dPhTunILi26goRy0jOxoDTWZRu/ab/J
         pRTPCAc9WNAnz1c1umNxEZ5O+d4YhcVFXufpBjEtfRu3rlSIY/vaFNwjLIVPBF+pqW
         Pd9ao8/WnXqsx534t713y56C9npySJu4h3+7LQXNUPZYe+x4ECvgbKO+hbMlLLHHAu
         ruacUtOQ+ntMeolvzdYMwcJgMM+OGVQtJQ5S2xUIhftfi9KjSUcouKd+vD93GZU83K
         rkNi21sV1EGFkzcTxDPsZSVgYLUdcJp0Uaw9qwa5Dg/LW1UWhsTi0firaYYg90NObp
         9YvDuV7Bjj/gQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az257-341.vajpmfisnucuhik05izvhlvw5e.dx.internal.cloudapp.net
 ([13.64.213.132]) by mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MkYXm-1qRDY53Pgs-00m1rQ; Wed, 17 May 2023 15:52:20 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.41.0-rc0
Date:   Wed, 17 May 2023 13:52:16 +0000
Message-Id: <20230517135216.3546-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:JAoc1lhLA83PTw0zl47OUO7/L28DxKxgJdIP+NUJ60wzUx4R8IK
 uf4kYwVNh5sHqCM3kLJ6B/4B/5AyaTRmakG7+dy1fBs8C7avAI3y5Ws+6jelPb0AmsSVaGD
 whwavkBy0OmJaNMJyK2e/tC73HP2aLe6yT8WpwwZWwWLDiKsBX1uBK4mQlYmJEfIy2uEoWz
 ZfVul4qYsMqbQQWwTSJTg==
UI-OutboundReport: notjunk:1;M01:P0:qFNhTi/vlVs=;jlB1K9RT+f34x1AhrCSJVfxtN3a
 UR+SMsJsrNGOFjxDHc4RDZESUQRHIC/ljchdwuZRI267VUkx9FQwJYSu2WiMKQRGY1U6MM49h
 +2Cug3dTUmMOumqcopO9itq35qGBr9XGcywFWoRafF8Bui1hxIpvs0Om8r6RjcAhUqgxStBE1
 PaIKoUk5AJbZEmlPK7SCewGSpk0cfq4BRRpnoIQ8WpuyyZ8kO8FC3N3B9/lH6swiYEmnvojmh
 fikQm2muFpVQRd4l5a6fNtnnLYl+HCjY0SFgOdIBG2QrlOrvbjgd7JE9pvLXqPdNZH399oI5s
 kcBjAgaQG5dY79Hk0yCwc9dTgKsTrpqbhVft+ufBelQaBpu5Ket6H22DCiUV9NxrMzGlJuQw4
 1BYGLFkh2Fzu32XaqTRuTAmKg8mKcpqUVpbKxvTvcgoQ7cVYh5hOv1kl9qtLAIWr4Hl8ihutL
 sdgMiCTARjOCVMhD1O58pwtBQdnzbVuv3WM9Ph5uUxtvJ0dx779nwyC5kvIkEEvHq3jCydE42
 iS7HAx51wpS7W+JiVh7ZNQ+agFcbE2Zit/XmcADsBqaLkQn+92rvyXc+p2vM7x81eF8DkRWr0
 QMwW7PTUSkxVfcjslF9EcJmLji4+tHnIaHWRQQIDdyJcJLTgKlvxBaiPUjsOL1VO5jK7dI5h2
 J2KBzyapSZ45MCxi4kuHT84PnV2BiLJQO7Zot3C1TOi/GQdOQLXe5zOXzdX2swwH9IhOvnYfy
 TCx038knv8+VP3kjZZQ04znBJ+IoKR1AjJlJWRB1odZvMV1sBZ/FLpOKJT0E03O381Ll6tdZR
 QvcMvFvUm8OHdLPMQhAQd3gl7dQWPELRx16HcpDzeaGzrR/Qh59CWHT2sXHhetOe9mD2QvCkB
 2iEt/0nczmIRGWDdx7MbXus/Xz2Y8B4UdVW3VqeZ9r2nWoWafJmDB/7saPzto2yEZxIAfKBl2
 UJ6B1A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.41.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.41.0-rc0.windows.1

Changes since Git for Windows v2.40.1 (April 25th 2023)

As announced previously, Git for Windows will drop support for Windows
7 and for Windows 8 in one of the next versions, following Cygwin's and
MSYS2's lead (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Following the footsteps of the MSYS2 and Cygwin projects on which Git
for Windows depends, the 32-bit variant of Git for Windows is being
phased out. As of Git for Windows v2.41.0, the 32-bit variant of the
POSIX emulation layer (known as "MSYS2 runtime", powering Git Bash
among other components shipped with Git for Windows) is in maintenance
mode and will only see security bug fixes (if any). Users relying on
32-bit Git for Windows are highly encouraged to switch to the 64-bit
version whenever possible.

New Features

  * Comes with Git v2.41.0-rc0.
  * Comes with OpenSSH v9.3p1
  * Comes with cURL v8.0.1.
  * Comes with MinTTY v3.6.4.
  * The Git for Windows installer now also includes the Git LFS
    documentation (i.e. git help git-lfs now works).
  * Comes with Perl v5.36.1.
  * Comes with GNU Privacy Guard v2.2.41.
  * Comes with Git Credential Manager v2.1.2.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.4.6. (This does not extend to 32-bit Git for Windows, which is
    stuck with v3.3.* of the MSYS2 runtime forever.)
  * To help with Git for Windows' release mechanics, Git for Windows
    now ships with two variants of libcurl.

Bug Fixes

  * Git GUI's Repository>Explore Working Copy was broken since v2.39.1,
    which has been fixed.

Git-2.41.0-rc0-64-bit.exe | 7b0bfa1e1e059f7bc5e5a5a172f3da0fac8e1f5b6011366527ed6afcc50a82aa
Git-2.41.0-rc0-32-bit.exe | 2048117413bdda01eaa358f9451973876e0e06b7011fe0636f8df794b6b5ad8f
PortableGit-2.41.0-rc0-64-bit.7z.exe | 09085f5414f97e406b13a023482684d2728bb9788eca687dbf19434ab157ef96
PortableGit-2.41.0-rc0-32-bit.7z.exe | cff7a350d6b312112b1cf4eb33344f37a6c85bdca8dc07ce90a23752b01abd47
MinGit-2.41.0-rc0-64-bit.zip | 7b45fc53600f19008d322848305551fbc5600136caae0769ee6d10774c3688a4
MinGit-2.41.0-rc0-32-bit.zip | c49966732c4ba4b8c76057c2ebc13981f39be728c454aaf5849db3833ce049a9
MinGit-2.41.0-rc0-busybox-64-bit.zip | 8792014287b6327bccec16f1ad7d970b10f0566b667f40c57462e6e27b98e0fd
MinGit-2.41.0-rc0-busybox-32-bit.zip | 67030d81d36caf0febab51d0fd1e3f20d2441197b3ca306d41f5f7658c3399a1
Git-2.41.0-rc0-64-bit.tar.bz2 | e741dc0cc7211e974d588f624fa566a4b92e50317e3f735894b443583c8e5d0e
Git-2.41.0-rc0-32-bit.tar.bz2 | 0c0a97258b36b1054c97379b59ad5fe674e539d366618e7df1bc2e20e5666c5d

Ciao,
Johannes
