Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DE191FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 12:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933625AbcLAMbq (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 07:31:46 -0500
Received: from mout.gmx.net ([212.227.15.19]:60633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932557AbcLAMbn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 07:31:43 -0500
Received: from localhost.localdomain ([37.24.142.44]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MRGTX-1c7r1j0s2R-00UeOV; Thu, 01 Dec 2016 13:31:36 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.11.0
Date:   Thu,  1 Dec 2016 13:31:30 +0100
Message-Id: <20161201123130.7608-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.11.0.rc3.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:NvP4c0/2DHP6h/9fVGmDVkSeVnbbWqQcA/cPBfIeTQD5cxiWWpX
 ouq7rIE/a3pZPYIqm2us267Iz99etMp7ixd9EJTlWoKIu0h/59X5NKwilGeWndQL2gMx7jz
 4fcFBXgFDStPpVjBnLSlUdU7RzFbt2lc9ZlmG64CIB58EJOtzfGlETgPgO9o4eJ5ZliKobd
 mKNDReFae2s7avHTnV9aw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lvKIFbETAio=:Vw0yvwtRnXLmuYYSnW3idm
 NjpDqCj5XjDoH6AYGd85BiMtBVk1YMxZIgod+D+OIA+JeHiloAFFfKM0uGZQZ+G8p4jeievxy
 i+Tk6Ejju7qrgSeqWeYcIF2tzyw06f8pggqITcik5L+GMTBz6omdOHTpHibonDJJbWvVfh5CD
 BrKcPgR6BVyAqIbMFGD0Dy9Ovjh8qRcFFtOymYEIOsPhATmtOIFOSmHgt3KjKd2fHSau3h9i0
 Wsle4QqeXfodIaNI+y3fm/Ytp6jaeP7TpRNd4YfkKmPqFLl5WDGLJBP++a2yQodDJtadMmJ8c
 awTB5mXqmQiwrdNdHfX/SW6sYH6J2IA2J6+3hWsJ5Te0lEleo7ldFtaAB1BLbiBAr/u4J33LO
 gKmDPhFAqt0SEaTYxkaRV6yj48GaPGhO07fgDJbPfIkNidbyyEqAAkjH9RKquNhxPEPYaiwEz
 Jmky5bTxOm9wF9zbbYUCmgI12UXLcXVr2yxIdgK89mG6bQXoWzlUm+R1DcT5Sa93VboDLVwzj
 53kPbXkESZhRxmva1teKO0smogEBShgz1Un/tunR3tVWdgJNf/nWOkLw4RfsGqhOJgHgGJWz4
 ZgBmrSGTCEAwS8revL3WNk0LVbuymAdmxjU/SIaiYEmO4DfgJjqwAbhBx1Z2p1VhAMaHuCUU7
 6AoegcMyNUrl7w7RsCkMGzniT9po6xnRX1aKdZuOxecRdUT1tXlbMhRHZ5JwilQI9P5BionJG
 mZcZlUDMFsblTxgvT4WVIPo3pBoRxLxG00uCKpVOrLJLGbz1uw1mZ34XiWFQQdSul5115jxmm
 DaHnwgM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

MIME-Version: 1.0

Fcc: Sent

Dear Git users,

It is my pleasure to announce that Git for Windows 2.11.0 is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.10.2 (November 2nd 2016)

New Features

  * Comes with Git v2.11.0.
  * Performance of git add in large worktrees was improved.
  * A new, experimental, builtin version of the difftool is available
    as an opt-in feature.
  * Support has been added to generate project files for Visual Studio
    2010 and later.

Bug Fixes

  * The preload-index feature now behaves much better in conjunction
    with sparse checkouts.
  * When encountering a symbolic link, Git now always tries to read it,
    not only when core.symlinks = true.
  * The regression where Git would not interpret non-ASCII characters
    passed from a CMD window correctly has been fixed.
  * Performance of the cache of case-insensitive file names has been
    improved.
  * When building with MS Visual C, release builds are now properly
    optimized.
  * git cvsexportcommit now also works with CVSNT.
  * Git's Perl no longer gets confused by externally-set PERL5LIB.
  * The uninstaller no longer leaves an empty Git\mingw64 folder behind
    .
  * The installer now actually records whether the user chose to enable
    or disable the Git Credential Manager.
  * A certain scenario that could cause a crash in cherry-pick no
    longer causes that.
Filename | SHA-256
-------- | -------
Git-2.11.0-64-bit.exe | fd1937ea8468461d35d9cabfcdd2daa3a74509dc9213c43c2b9615e8f0b85086
Git-2.11.0-32-bit.exe | 2a6083479538c4fe454336660fce96346ee3cf46f99ce08a666d4635539239d7
PortableGit-2.11.0-64-bit.7z.exe | a86cc4babfe204cc91408053b517827b4a93e6c659b85ab30910eda0e38bfc19
PortableGit-2.11.0-32-bit.7z.exe | fccec9350c1cb58a5e6d84d307d4f9f43ab9d58d93c8de67056416539d199002
MinGit-2.11.0-64-bit.zip | f31b0135e11e425555fb34779da3345ce8d32490fdd0a33b6f5ae8d74bae20b6
MinGit-2.11.0-32-bit.zip | 48e363cb6ce867a8004056a95da57f7c330ab79dbd26e4895c2aaeb4aec3b3a0
Git-2.11.0-64-bit.tar.bz2 | e62263ff734dbb071819dfcc33e9f443f9a445cde54d0102f6d164d5df5ece6c
Git-2.11.0-32-bit.tar.bz2 | 43dda49d4c7305d18b9f0612f66ba096ca2881a8ebf7b41cfb358d9a05fedef9
Ciao,
Johannes














