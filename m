Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE58C433E0
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 19:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42EA02073B
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 19:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="coBFyepD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgFATRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:17:07 -0400
Received: from mout.gmx.net ([212.227.15.18]:40849 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbgFATRG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 15:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591039024;
        bh=ZZP8DGxRpxy913ju+5MZiLHiDUW/ii8W7GYiO+Njy2U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=coBFyepDjYw8gy4UzTfBVCCXYmZ+IrRXzTcU+JqnuVchgTd6sxO5SyW++nSPvaRBA
         ehcn8dJviYkg+5spQHpiNGvKlhp3hU+0VLUr5bISKXrnWUtvBYEzRzwtu7oWYRSchm
         IlzQaW/+hgzzHvrDZIrnXXXov2ZPPD3nsBB3oNRQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az773.twsyhewivjbu3h3bmkmisqkqqc.bx.internal.cloudapp.net
 ([52.147.199.19]) by mail.gmx.com (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MuUj2-1ipf5G1T5W-00rcTJ; Mon, 01 Jun 2020 21:17:04 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.27.0
Date:   Mon,  1 Jun 2020 19:17:02 +0000
Message-Id: <20200601191702.6040-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:OorUqHUooVuwwrZ2b7EBT8cVBbc6tFzg+a4xvJlR7yh0FBADF3m
 s8JaaKlq4SnTAOH5pJYm9jzkvzCH9QUXjEQ9eX6oOfOzqR0qWgraJ50qHjNqgYL4YpIsj9C
 WAQeIDL0wxG7Ki4Gzn4w+8DLMrHBl5smsqMFIUmiwWQdLGVjEPW5LNnRg4MZa9GPSACOMsR
 OxUEfoHY2d/QfEg3VB0Cw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cko7fB5mSzg=:tYjvfh3i8ly9qAeAOQ2zC3
 NVwUuOR+LGb7jgnGgJQfN1EVGsjvN624/Rkq4x4QqYq9zJEXlIy9XE+uBGRCYrXhYtOtGphm0
 iJpv1V9qTpytMmZvtrc/0reroXnzLXBueELoxnjcK3hifS0HkSQxqzhZ/7cABGeNc5GsCoPvs
 ZGr9TNirayJ8+fTdSoz3lWAA3/SK2ba/r8JgfMiKyavO5bfM/j+ETiC4UaaqA0O6UlOPYeFif
 TCccH7a6xmTgtSE5YmXEkKUMKr4Qq/8V1AhU0nwkKwbwTX20Ono002rn3FDWJFiDr/RttOxSq
 JEaI8/oYZwfttef/Ueog7BCUzFu57SlEVAAcxGeS9LiNp1f563GYnxvYi69Lmz/jYvOtKMmlo
 k+ojhLjuUqOeLgzfBHeQ8jo73mdy57V/k2Cjl4Pfb5LvdiMnf+cMuRVLwaGjNZMBpREAUIDg6
 9Gb6bM09r6N8EDmm3z4MFuvTkqpVd3wx3e6WJEBkTTdmaYK08H4dXXoEqBtLP9iqrrq+u7lET
 VdjWFWKVyRWqBdI4exNSK21IriFqgxBG2x6qWj6pSypyeueNNhI38yAKVtV+ksODQ2lqwCh+o
 qVgs8mjFaGsYYrNFQ0UgzybdTQajutBcKd0Jgaz1ZSQGRKo2P3V99fgPpt3qXHYSoTetp1dA6
 BbuM1BIuqosnnJRaTYbY19DQl1k5C107+NKeznB+lIdyxzopGhW2z97DNdLEk4ee8Y2RxMkm7
 +20t2+HOXz75M7a2rJSfcZofEZldwBJEbK/jCEAJUEk/WoZQhVoJT2oQaJOX99BoS+op+BFsU
 A713Tzmwymbn1kL0O+ZfuleBrozrGqTz0btYLLeWcm+1f5pDhC5x1WO/UGTn2hMR7m+PIPPWj
 075hZqInporYz9XkHbzsrTpps4YbzSKwJc9Ew1PR1kUwDErsu3Ffd1iMBnPVhukmvTufftvMO
 T/PKts+Id0tMLsiASTUdZyFt0YUEwSUFqcs2AZVLAqfnrZqjHR36+vldEHOQZ8QuiSPgVepaJ
 o+uS/63t5S4epG7DZ3BIXLYYIlaemM9SKdXb5FUxYInlGsrH0HaHi+SrFcVN7LAL8cVaoaA1Q
 IMptkqwjhlwboQFEOITBl0NDVzDZVXVHynyG1pKrFSkGfpH3cG4HqZWX+QAjs5/31QAQim3Ne
 G+ggX2LDWFL8AvrP5MBI0vAYqLGyDXNViMK/+NwmgF586xuTuuCO8f5pYFWy6Em46n++DHbiJ
 5Ua7jtA52t+RDUtVC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.27.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.26.2 (April 20th 2020)

Due to a bug when handling symbolic links that was fixed in this
version, git status will show symbolic links as modified even as git
diff won't report any changes. The quickest work-around is to call git
add -u which lets Git realize that nothing changed, actually.

This release comes with a Git Bash that optionally uses Windows-native
pseudo consoles. Meaning: finally, Git Bash can accommodate console
programs like node.exe, Python or PHP, without using the winpty helper
(see Known Issues above). Note that this is still a very new feature
and is therefore known to have some corner-case bugs.

New Features

  * Comes with Git v2.27.0.
  * Comes with OpenSSL v1.1.1g.
  * Comes with cURL v7.70.0.
  * Comes with subversion v1.13.0.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.1.4.
  * The release notes have been made a bit more readable and are now
    linked from the Start Menu group.
  * The Frequently Asked Questions (FAQ) are now linked in a Start Menu
    item.
  * Comes with Git LFS v2.11.0.
  * Comes with OpenSSH v8.3p1.

Bug Fixes

  * Some Perl packages (e.g. Net::SSLeay) that had been broken recently
    have been fixed.
  * Git for Windows and WSL Git now have the same idea of symbolic
    links' length, i.e. git status will no longer mark them as modified
    in Git for Windows after checking them out in WSL.

Git-2.27.0-64-bit.exe | 5974db8c52b32f5e575ee021e8b47948892ce0e760095eef98c31e3bbd5167b6
Git-2.27.0-32-bit.exe | 876ec8b8fc283ddbacab424379eeb7263e4515c497a208419c4e893da87499f8
PortableGit-2.27.0-64-bit.7z.exe | 0fd2218ba73e07e5a664d06e0ce514edcd241a2de0ba29ceca123e7d36aa8f58
PortableGit-2.27.0-32-bit.7z.exe | 8cbe1e3b57eb9d02e92cff12089454f2cf090c02958080d62e199ef8764542d3
MinGit-2.27.0-64-bit.zip | bdb8c1560eca39f4d99b07705006c00d94a3f8612501046a0f89353afc5307fa
MinGit-2.27.0-32-bit.zip | 0f06bae4a5f2f5d910c1ff92d34509fb12b28d5cf1d8a144b11a9bc5412b598e
MinGit-2.27.0-busybox-64-bit.zip | be59e1226c472dd6ad5ea4afaeced2d8543cd2ab363789dd1d0d17164055af19
MinGit-2.27.0-busybox-32-bit.zip | 80ff0b523eca334ba936863be5ff9e804213e399a61e911f7dfadd3d47dfcad6
Git-2.27.0-64-bit.tar.bz2 | a653c41999e4c80eebde8de046dd92a5a9e38a77f60466120daab2f31d3d0935
Git-2.27.0-32-bit.tar.bz2 | 96bcfb93c7fbb34bbd4c5c9ba14a2a6ae8f58b299688278e38db1dacad180df2

Ciao,
Johannes
