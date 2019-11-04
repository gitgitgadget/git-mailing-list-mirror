Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 216A81F454
	for <e@80x24.org>; Mon,  4 Nov 2019 22:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfKDWgn (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 17:36:43 -0500
Received: from mout.gmx.net ([212.227.17.20]:45735 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729834AbfKDWgn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 17:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572907001;
        bh=s4VGbQPRj8HnJwo7S4TXhMZU0BoSAJ+kmWihFO5IoK4=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=htVZd6bOKqwtLqOtW3/TG6AhGj0zdmT2Edo6OFwnEygFQw2bHs6K0UdnKfCSIkt9T
         lMLsOo8QDFzZBbevqt5Qj9Mx/Xkq5X7mZd8Ixrhv12zTfwZ64J7DxbGS12kQmHxV54
         Jyfd1nlOxjQlfjbCvuJqnjURSP/V2UuE185jVjG4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNh1-1i0xmw0oJz-00hyXM; Mon, 04
 Nov 2019 23:36:41 +0100
Date:   Mon, 4 Nov 2019 23:36:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.24.0
Message-ID: <nycvar.QRO.7.76.6.1911042328280.46@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XxaNdVcWyCUWa2rlxqlqX9WpilTyyuGkbePHoVxSPL17koB0Q1Z
 e310aTNc3V6UNrVCaqbqJvFon7pb7NtVLtEetUDuMMQqF2ghKuGDQkQIasVqjGJu0ki5xwO
 L/BIixUSwp7jEv5asLH3KKHIH4w99fEe3SdNDZy2aL+bvoO1M3/MonJzUUfS4xVEJto9Hky
 WcPsUU4adMvIhvAeMICcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ozr2aarOklI=:1WGunyZhGZEwz5n4HR9PYs
 CWG9Oh1stGjq2yQegX1TOVxsIY8Wfc7KPS0KfqL2YDzuARve0qjK4aXFnArOT2INSJOxp4g0m
 gfb7ubmYm6FZ5O/NPBk+/9HPw+jp31s+9ypM7s/UonThisSwdVJtW6JQWUekr4jpm0gC3nhOc
 LehhbIfT+9GXdwJLZ1qj5LUm0Ib0Z5rvpmgdHX2DHysxqm12vleK48TSWxYD+LHSRiWunbl8o
 x81uYTcSplzmck7Exfi5aZ8Cjsj88wEjde9bdShr+QoESIOM9rVsKEIRfSuDCRUqFFd/5kORb
 frXHqd+YWSDLPYl0UJZV6GzIe0Vwt+T0Vv4di29PAlfFsISvZq1AEyhrCUyoqAw3uk0kdcsK3
 WvLvbaNdgOtUak3Uz+J6vr5xsWSk5wZB1Yd3n7lwWe3eMl2dGOjhHO7OsiC4vKhzbziX7dZO+
 YxLQc6KXc4M4HjlRViDr4h1zWFrqul1hffkMJRuXWSLgclGzHZDwzOEcVcXprgEGuDTGMnInq
 sygL/apPeTzKUiKEjRQZntTQf7HQPRxFRuz5YYBQ9JjP0Cnm+dFqvIpsTQfhCpsD4bsv8INyL
 kC/4kZecs4P3CM2MWOvxygq3fERMVMSzujox3WpDzFJH6Bo4r31kAoH0byFttxNnr+KLNEzJ+
 W3LoLYERm7FTKYp4MJeVMj41KdpLzn//n/LAARM6dS+/UwFmSHGnxB4TtKozcRlSeP4XjihOG
 X+LiXoeEP8cd3FSqia2m/rxh6ItbuaKlgTkRbxBGkG6cCLXyIbta5EVyrdiww+1f0qPuWrLHk
 9PLj0i1R3ksSnNB/nxLf3eJhLp7VU9E5IjOJbMShbWA9k02Yo3flDU7k65HOVIAV7b+0INHRS
 6WUJFiU5tt851+N6YU7rPrQhkPNHlmue7Hy0awD4GFJuzA5QYvOcFtH1+hETM49CE+ZDJPO2B
 iJ3lwbR6mQuJWGPr9U+L86rWKJRqc57IeK3XWcgd74hpqYyhoASkavBvONOK1Sjtabn/iHFUt
 4o5rOkPHPZkiutFq6RyQvOCO3vl97+aRyDzkvEfWb8Xyka9Og/YESKn/Fhk38TaHmdwEFbrkv
 n9VfFl1dlLAauUhpbdA/zzCl+jYey8LkE8mhEOP33z0ThdCRJ4oJ57FiBPUgTwm4SeUZLy/Jx
 9lS4PmT7c3DkHKd8Qr8VLpuRRxX1uezf6C9FsqrvojSQB9Ih1M5eJDU+UrbmO07Mi5FMtQPyX
 SD8EjXs78TD3RlcppYkaij/w+JEGrW7c3kPW78H+2iD9UVQRgxWkfeaLf00c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.24.0 is available from:

	 https://gitforwindows.org/

Changes since Git for Windows v2.23.0 (August 17th 2019)

Note! As a consequence of making git config --system work as expected,
the location of the system config is now C:\Program Files\Git\etc\
gitconfig (no longer split between C:\Program Files\Git\mingw64\etc\
gitconfig and C: \ProgramData\Git\config), and likewise the location of
the system gitattributes is now C:\Program Files\Git\etc\gitattributes
(no longer C:\Program Files\Git\mingw64\etc\gitattributes). Any manual
modifications to C:\Progr amData\Git\config need to be ported manually.

New Features

  * Comes with Git v2.24.0.
  * Comes with cURL v7.66.0.
  * Comes with Git Credential Manager v1.20.0.
  * Comes with OpenSSH v8.1p1.
  * Comes with OpenSSL v1.1.1d.
  * Comes with Git LFS v2.9.0.

Bug Fixes

  * The shell construct <(<command>), which was broken in v2.23.0 (/dev
    /fd/<n>: no such file or directory), was fixed.
  * The default config no longer skips git-lfs downloads.
  * Starting with cURL v7.66.0, $HOME/.netrc can be used instead of
    $HOME/_netrc (but it will still fall back to looking for the
    latter).
  * The installer's "ProductVersion" is now consistent with older Git
    for Windows versions'.
  * Makes git config --system work like you think it should.
  * The (still experimental) built-in git add -p no longer gets
    confused about incomplete lines (i.e. a file's l last line that
    does not end in a Line Feed).
  * A buffer overrun in the code to determine which files need to be
    marked as hidden was plugged.
  * The support for sendpack.sideband that was removed by mistake was
    re-introduced, to support git push via the git:// protocol again.
  * git stash no longer records skip-worktree files as deleted after
    resolving merge conflicts in them.
  * The Git for Windows installer no longer complains about a downgrade
    when upgrading from an -rc version, i.e. from a pre-release leading
    up to the next major version.

Ciao,
Johannes
