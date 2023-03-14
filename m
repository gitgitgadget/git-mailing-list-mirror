Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8621C6FD1F
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 07:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCNHwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Mar 2023 03:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCNHwk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 03:52:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55030968F3
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 00:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678780348; i=johannes.schindelin@gmx.de;
        bh=+eLTuXD9MSzKxVjxgQOaodyscPnWK7vLzsAwkZifY2g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=bsCScEyEDxkG7kkPr2zbTuSqpNJ5+U9HEj8nqojHhQtIIh9bLgzNCxTDWX/klH0se
         Xf48OO4FqN2B31xFjV9PcrYO8FlsDh3GupD88UB1re9+Kjfyo8/CnY+85SaOuGZBXv
         tXjS6+3f3J7JebG+FK7clHJ7K8f2pkyB/xHbBaclvzFew6V7bBKrYeAKRQ+HDmIMbY
         Ib24b2pnX9ok+OEhRgpF+9ObKmImhcGUyEnqfkRsGGkIUuIByneCZ+0BiYx9pkPqS+
         YE1QQkhtYifernkfmK7/nQBdVpvPHywfqoiC+lMajmqnGJw7wml5irhjPdL7Kvoe5t
         Chu1iGhadiIxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az555-173.gdyy5qod0nmupdgvnjuye0vnaa.cx.internal.cloudapp.net
 ([172.177.209.214]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1Mi2Nv-1q7DTB1ov3-00e1pl; Tue, 14 Mar 2023 08:52:28 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.40.0
Date:   Tue, 14 Mar 2023 07:52:26 +0000
Message-Id: <20230314075226.3548-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:pfjnCW73O9wWUFC/FY+RT8Mx3WfISMlVT6NXYG0T44OkFnIbzm0
 x506qYimefqzrDkYK+BLyJbheYzWNGaLCKFF3yBhSDbVHTcSW7uXC0j2KzGyO8pzbEuMra3
 hxEFDVefgbisdeXKBqSMT9gTLyWuqC6x+KatiEhL8UwLYN/G5UQcyl1b2+6Imk/cx2mnDDb
 ZXFr035XxTnEc2JFdTYtg==
UI-OutboundReport: notjunk:1;M01:P0:QP1AT7iNyZ0=;Ito4q37Iq0V42kWT/QXYkHxg1Vo
 TO4GKkFWffdzQVkeW5Ch5x8MTjZKXK0+d/CO2nPSvP30z0ZUij5/Mgnfj5wAeO0YbRAEFIPE6
 phecOF17jO0bqz3gxMaIU3Npw5etUFuIKSYNoc7X8suvOYDhCF8g97YQ8NtqPDRCYCHmJ2/qu
 PPb4FDSxmjDvqqW/jYLNyyuYHN+qGj/rxIOTuRUcbjQ2qflF9Lnoz+J0H1FBL4hddAlIQJTAA
 UjpckXmiHr/JxXI5QOY4swjJl31L8FrlakFgrPwFuRFe8HuCalY3mILsR0qyfVhJho73vy3Dd
 hoq+zVd8XeOV6xT2T9HkhtLyA6/sybpm/kvoUV9pfSrf+VRJ9+OIfNTDf1bVrK4cd1WeaAAhZ
 S8WmbKTj1ZERB+Ixk2ZSoDQVoxivzmPxSQVnL2SZ3qapqMqx1Jy0w+d1vO+bmaoo8Br6O2G+h
 7laHif78M1d0DDJ1Mxmx5WWp/A34vArWymTUYw2qswjCvk3C9SyZ9vAItB7dCmW0PQlKytm0z
 utgU29lWmid2SPBB/OHy7XLAC/eQOr+NfyrWe8ewtby6vK9/6+G+KS9VnqWTJhdal3WbFQhyh
 BHicPgeCE11buW1tppWKmGsGeON8CHtf6UJ9DV652Wmk9iJnQG0P7Jk/ZkTzR30ippiL4eUkP
 M6qEqWTyYgayS32+R2NKIiBu19UBL56GoSdDqDoRP4LcSi0TI9IazYjmvFBPQ+SmrVErNxaKy
 u0K1xxLfF8L1CF22hJAT/NjDb83fSaKL1/M2Scsv/FhmtgGuYFXK2JKf+r8y0GUidFZ98Opjn
 fR6MAO+5FYguecnvtrSq2vNBQDnx/8kJkfA5wkZ4cqCFxaB23suKAhLqKatlWNvlk6Ya92y9e
 mAeR8lmld/5Rc8viGRF1IDjubhS6l9FmHu3W0XfPNdK4hhcwP4MU4XtRFYqOf+QAjibjFZP0j
 7mRQ+1bhhqLQda06WhGIzu1XuIM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.40.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.39.2 (February 14th 2023)

As announced previously, Git for Windows will drop support for Windows
7 and for Windows 8 in one of the next versions, following Cygwin's and
MSYS2's lead (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Also following the footsteps of the MSYS2 and Cygwin projects on which
Git for Windows depends, the 32-bit variant of Git for Windows is
nearing its end of support.

New Features

  * Comes with Git v2.40.0.
  * In the olden Git days, there were "dashed" Git commands (e.g.
    git-commit instead of git commit). These haven't been supported for
    interactive use in a really, really long time. But they still
    worked in Git aliases and hooks ("scripts"). Since Git v1.5.4
    (released on February 2nd, 2008), it was discouraged/deprecated to
    use dashed Git commands even in scripts. As of this version, Git
    for Windows no longer supports these dashed commands.
  * Comes with tig v2.5.8.
  * Comes with Bash v5.2 patchlevel 15.
  * Comes with OpenSSL v1.1.1t.
  * Comes with GNU TLS v3.8.0.
  * Comes with cURL v7.88.1.
  * Comes with libfido2 v1.13.0.
  * Comes with Git Credential Manager v2.0.935.

Bug Fixes

  * Some commands mishandled absolute paths near the drive root (e.g.
    scalar unregister C:/foo), which has been fixed.
  * When trying to call Cygwin (or for that matter, MSYS2) programs
    from Git Bash, users would frequently be greeted with cryptic error
    messages about a "cygheap" or even just an even more puzzling exit
    code 127. Many of these calls now succeed, allowing basic
    interactions. While it is still not possible for, say, Cygwin's
    vim.exe to interact with the Git Bash's terminal window, it is now
    possible for Cygwin's zstd.exe in conjuction with Git for Windows'
    tar.exe to handle .tar.zst archives.

Git-2.40.0-64-bit.exe | ff8954afb29814821e9e3759a761bdac49186085e916fa354bf8706e3c7fe7a2
Git-2.40.0-32-bit.exe | 9b14e05c3ea00c51dc38838db23fccc6ccb21bfd42ed078bf406857fb47688d6
PortableGit-2.40.0-64-bit.7z.exe | 9031c171fccbf30113b8a9b93b9580b4aca8502dcf2b22c5cd3205212e895b13
PortableGit-2.40.0-32-bit.7z.exe | dc4b824412ee814fb310511921f3748631f3e6cd64c44866e38b3811e8e6dd01
MinGit-2.40.0-64-bit.zip | f3e898f8856e80c66b367c80396c6debc46ae0b258ab9fd00ee08b4812c8f987
MinGit-2.40.0-32-bit.zip | 51f40ccffc08485c80bbe9d54a4ad08e1ef47c6198dc0801039569a8468a6d02
MinGit-2.40.0-busybox-64-bit.zip | 2051be40681824f0e582b2fab362cbd7d3cc510fca9997582d8baf6fa30f3fbc
MinGit-2.40.0-busybox-32-bit.zip | 1a1799effcc53c83bf9c57783ae3ef761dfe61bceaeaa179d205456f541931b0
Git-2.40.0-64-bit.tar.bz2 | d39c1d419479480fc7c1944e19a91b0ca331a4942cdb7c156cf226bba34d2af8
Git-2.40.0-32-bit.tar.bz2 | 9f33238ed9c75f7a61fbcb7f449eaa40f871e0f59816178c0fca95d16d6827d3

Ciao,
Johannes
