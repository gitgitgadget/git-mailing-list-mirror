Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7EEA2093C
	for <e@80x24.org>; Fri, 13 Jan 2017 15:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbdAMPoy (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 10:44:54 -0500
Received: from mout.gmx.net ([212.227.15.18]:51644 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751934AbdAMPox (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 10:44:53 -0500
Received: from localhost.localdomain ([37.24.141.236]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M7HGA-1cggdx04Ry-00x3PP; Fri, 13 Jan 2017 16:43:15 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.11.0(2)
Date:   Fri, 13 Jan 2017 16:43:01 +0100
Message-Id: <20170113154301.5568-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.11.0.rc3.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:vZt1G1myPYxylPndv/VCbt/CF2uXHSmdQnAH56VSdq5atLVzPUV
 MvLSXcLq2BRCtLJpUvlwUmfxJfkQnB66L/mwR2pJ+Oy90ejCutLyCx2JWWIwe3GIBLGzSQ2
 QMOCsESV3G1HpdkLZAU+4FQ3pRIQN328wEroMugZ8RjifPcl5b3UBSfAYCMMmoGH/vll5q1
 c0kjv0PtXo85Da0iUQ0yQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YdrY1IvgQyM=:Z487DlAHl3YKAE9hJTzzug
 irnoMBNHELU09l/trm4/QcoUyP7coBRaciXx9dmnpUensaPznLc9Zodv5Tv2RuUIwYOwRVXa6
 GYMWfup+WKG3yXQRbZV9GA5L27BZtbjTnKAqpmISDyLJG6exketfn31cFRkXL5HlI4TpwZNQ2
 oPibgnVq6Mrml0ocQzkeFlBQZSVSxfH/mCrrY8MsPbJVkAkC4nhnePjfeWRN4NG0rDac95/Fq
 2X0/2xyFYwoRpo+3TvwR43sxXnEmAVmxVtfmsw3OUNcDUZDCJzbBgLVB115i6T+6SWhjASIMY
 MoQNrIDsQ+J/zunZ0+zYgKhX4ZbTGICinPF7JKAynxK2yho+Pfb2tCohdyzWzY/t3iCs/juEI
 UO5t2LQgFNSniBElKA3oJtMHq9daabFiPRHsRtlKSB0F3d4p3bm0AWZilIqSwkV5Ls8DY+5NT
 208iPGqK+9cXoY0iygZTSOUeLCC0oQHs/jn5koU4FGsbbM8PiOXvs3swQqpjZ3tl1hKySYH57
 gx5h0b9U8lMlT+4CsCibjfkdzAM51kwJe3PqSMFunB6VGOcYrmnlB0sdg2DIbl6x79D6hwvb9
 Dhg5RJCldB8wNedsn3rA315zJOGGTvQU6r0F9eTtUHM6vEsXvrdZrtO+4iVzishsZx1Kh5Xud
 XfYPNgZU9ZCAnK9+Rz+R7lxNbT1uZzT+dbNEqD8p13I8WkXmO36Th7FvWweQb3dNor989GX7K
 4ocUP8Xpe0K+OYNkDCS6WRGQgMStlloOwYhommT6lQv4ton4uNiwPOW444HzziOZbD1YtSkGS
 f68eRGu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

MIME-Version: 1.0

Fcc: Sent

Dear Git users,

It is my pleasure to announce that Git for Windows 2.11.0(2) is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.11.0 (December 1st 2016)

New Features

  • Reading a large index has been speeded up using pthreads.
  • The checkout operation was speeded up for the common cases.
  • The status operation was made faster in large worktrees with many
    changes.
  • The diff operation saw performance improvements when working on a
    huge number of renamed files.
  • PuTTY's plink.exe can now be used in GIT_SSH_COMMAND without
    jumping through hoops, too.
  • The MSYS2 runtime was synchronized with Cygwin 2.6.1.

Bug Fixes

  • Non-ASCII characters are now shown properly again in Git Bash.
  • Implicit NTLM authentication works again when accessing a remote
    repository via HTTP/HTTPS without having to specify empty user name
    and password.
  • Our poll() emulation now uses 64-bit tick counts to avoid the (very
    rare) wraparound issue where it could miscalculate time differences
    every 49 days.
  • The --no-lock-index option of git status is now also respected also
    in submodules.
  • The regression of v2.11.0 where Git could no longer push to shared
    folders via UNC paths is fixed.
  • A bug in the MSYS2 runtime where it performed POSIX->Windows
    argument conversion incorrectly was fixed.
  • The MSYS2 runtime was prepared to access the FAST_CWD internal data
    structure in upcoming Windows versions.
  • Fixed a bug in the experimental builtin difftool where it would not
    handle copied/renamed files properly.
Filename | SHA-256
-------- | -------
Git-2.11.0.2-64-bit.exe | c7c6f8ba88a6da491117e03df559abd0fece1352f40d8b2d9bffc9c6c12c5800
Git-2.11.0.2-32-bit.exe | f7862331c994072402f9d7f03a4a6e2caec8ce0e91581ffbc6114631e920d9c9
PortableGit-2.11.0.2-64-bit.7z.exe | d4de119186bd63535fb792d73437cd0e2eb640ad50572ef7e04013f96aa70270
PortableGit-2.11.0.2-32-bit.7z.exe | 1f871552d1736bf86b08f81a55a29ff5aba9943d3c77b16294bdffca8c066f09
MinGit-2.11.0.2-64-bit.zip | 77558f381d21175dc017e90bc9cab90c8850bff6348a7dd112780f4f1f256449
MinGit-2.11.0.2-32-bit.zip | 23167f05f1274e169d42677a99bbc3e03e879250c71d5dcce6b0fbf3164013b8
Git-2.11.0.2-64-bit.tar.bz2 | 28d6d35db9f706c0439a55183ff68d9bbef9b67d66b11ada3775b2492a1d67bb
Git-2.11.0.2-32-bit.tar.bz2 | 592bbfd08c91b5fc826116b0ee29d9949e8e95b3094b81f0d1acea045e98fb64
Ciao,
Johannes














