Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 467D41FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 13:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752987AbdFMNfa (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 09:35:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:57862 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752326AbdFMNfa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 09:35:30 -0400
Received: from localhost.localdomain ([37.201.192.198]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MhAVV-1dXe9u2Q41-00MI4z; Tue, 13 Jun 2017 15:35:27 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.13.1
Date:   Tue, 13 Jun 2017 15:35:10 +0200
Message-Id: <20170613133510.7688-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.12.1.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:gqkqWsDpjaQko2GEQoHfRp/JUWBD8jC1sqRpH4iN3q93TNq84ap
 LEODVK3ITH0pJgTp0QjEbPNh9CH4d72zxlsU132+Yg5Ah0UetKpIewvExx+vpVSpKKlYLUM
 Rm54gmdbyg8fi7VnGh+q3OZdFbQUUR84oZdEwjQlK7jX6Te+Nf/4iN8qo/KVqu1TUsAy3sb
 lX9/1a608sO6sXfLuPHpw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AKVCk58r/Ko=:kxR7tbrQvfbUM5jtm09T+N
 ESjkzsuzkPcyk3PFXnyOju3dckaBa8Tpgy0mQ3TeR8C4ElBfOixEHRud6P6CZ74Xi7hSFMH/H
 vXTLowEQer54nzvThXzTvKFbfyIq9kHRLclhtont0KU+Yq+HZClFQSmzoMRazxf+Y+Is1skpl
 cCapdavGzXWAmITz5xLisgmWsxOurKlqBzH0SWwpN2qrHDI+IGdCX8hVURl9wMEHHqJYFTVFp
 GqO/6apkGjC9hLigUrZvFTBx5i7VmMwVuXHcnMFZbo6eiwk9c4Hu4E00zc+RjbfhL5yO6Qx2q
 lgCTmzTxZA9FvHnY6DgTJai3jud+z2hXrWejMbwu+5jxuGgICWzAMN7+kg4bcYlRuMrbRXgkL
 ji+hsgd9hhPu4T1y761tRdRUQwBHDzYNDLv3lO9gHMTVSRlHNbqOLT0y3KqNXn3NJ8pKKXx3x
 qH1VIJbmfTAXBKklb5CoL6yp8LVyrbwqv4JMena5a8lC+Q0JbQfNpCLsoayVyGwKLEDZvUpED
 5hMFGYM3Bm7X+82Uvm5vu2KIPfWxvfsvyuZM1dzIWNlkIAHsCPAGjMr5IOIUaiJa2aEs+7JcO
 iuoX74FUT3oWmqMKcPQFJ2TPF/kBAExgKwKAY560dIhT7Cs5OVmXwH728Jpe0I9dw44ReGJjT
 ID25vhnB5iE5blWfiDOFMYFSsDn19d1O7QlmdTTd0wfVMrTUSXNZ+7XeeOQxDtrqQ/tEn5xCo
 egw+n1o2yPW7lgDiwX5BngWeigI2LwFqk7pAeCQOeBvLbrkT7YwHDMkf2DNCQF2Kbw1b9IHU0
 vut+7R7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.13.1 is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.13.0 (May 10th 2017)

New Features

  * Comes with Git v2.13.1.
  * Comes with Git Credential Manager v1.10.0.
  * Comes with OpenSSH 7.5p1.
  * Comes with Git Flow v1.11.0.
  * Comes with Git LFS v2.1.1.
  * Git now uses the flag introduced with Windows 10 Creators Update to
    create symbolic links without requiring elevated privileges in
    Developer Mode.

Bug Fixes

  * The documentation of Git for Windows' several config files was
    improved.
  * When interrupting Git processes in Git Bash by pressing Ctrl+C, Git
    now removes .lock files as designed (accompanying Git PR; this
    should also fix issue #338).
  * git status -uno now treats submodules in ignored directories
    correctly.
  * The fscache feature no longer slows down git commit -m <message> in
    large worktrees.
  * Executing git.exe in Git Bash when the current working directory is
    a UNC path now works as expected.
  * Staging/unstaging multiple files in Git GUI via Ctrl+C now works.
  * When hitting Ctrl+T in Git GUI to stage files, but the file list is
    empty, Git GUI no longer shows an exception window.

Filename | SHA-256
-------- | -------
Git-2.13.1-64-bit.exe | fe834ec34b6cbda5b973fb4a210998471451efaa42ffe20d6b5de197a95ffc13
Git-2.13.1-32-bit.exe | 6b8f7605eafb982efcec53f128cedaa2535d589207b368cade61ce7ca5f04b26
PortableGit-2.13.1-64-bit.7z.exe | f47957cf596019ace07ef3fc17d08591f0e85092f4ca760850b6f34cabba95ba
PortableGit-2.13.1-32-bit.7z.exe | 8468716d1c32f22394b17534d8346cf352ddce1cecaf6df985d2338106350242
MinGit-2.13.1-64-bit.zip | 4e361db36ebec015797499c197c4e994070cfa76f80efa283c3eef89e9d1ae81
MinGit-2.13.1-32-bit.zip | 8985d57a4410103db339719e9143f367f5645a4ee74d72246a74253fb4ede70b
Git-2.13.1-64-bit.tar.bz2 | a87df3c348d32c91d3f8f76bbe3b621339880b659a5c904bce10c7c96626d756
Git-2.13.1-32-bit.tar.bz2 | 2efd7a1049fcdadfd7ee23fc41bdbf61cf4b185eac706028418991d5882f56a9

Ciao,
Johannes
