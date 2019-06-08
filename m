Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 016D01F462
	for <e@80x24.org>; Sat,  8 Jun 2019 14:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfFHOH3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jun 2019 10:07:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:37155 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfFHOH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jun 2019 10:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560002847;
        bh=pNcnmfKVgOMsxNDbu9SLrD7gT5pffb4qhq2A7YZ2134=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=RSmr1VEdTWL/obS7mhk25OhX3+FzUyOVE8SE1F9hnXKCpR+INoPnLYFQMiOaGMJK1
         k9J2V0jOTUjdXZdBiQbTZCG8k94laFEJF1h0egv8nh2d1NxqKtfF+c3zZvHlinHjeH
         WWKLXjAKdCZvLEWmdRaomfoauiU5WTD+Egr3dafU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzhnN-1gdx2U2ofh-00vcEh; Sat, 08
 Jun 2019 16:07:27 +0200
Date:   Sat, 8 Jun 2019 16:07:29 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.22.0
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1Mi2O1-1gvcPm3DMX-00e5Lr@mail.gmx.com>
X-Provags-ID: V03:K1:6WRVINuXWLXRnG4/6X8Ys72Bg3mmZ3HkEnlgs0Sw9x9L+/9pqxP
 wms5QIXFTqzt+Hx/32So5ETO20Rkh1UFC3kLJ7AoNMLHasTumf03bG6M3cVHVQUu0kFKcAd
 cOpjZng4Tab+Vfdm9QkT/f14JCURcO9b8ACHuNWagI8AHDFFp63Cok+YZh/LZjqTNzF5ZiC
 frFFfrIYrL3wbvEHKGI1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6KsAupBGhdM=:dawZ/sqTo+YEoAvB/lQDQ9
 Cuof8ypP/7Lma+oJHZpQpELw7BSa+otVlQQ5TPac0Cyevj3LVptjE7k8qj3i/WnhsTc9Cn9PA
 9IjmjfrZ/iFSXoqhDVgIqZEJXvaCJDXJOUDiwbchtzU5soyO1WKkZ3XE6KFnUYDho1W2PlWJV
 rB239P3rUNM2JbdntAypg8Muw6tmoKpqyuYzLr6eaBDYc8W49NYstKAd58tCswDUWnwyK+P++
 SLGhg7ZJLSjdvyM9asSAJqjtkhmJOnX0+D+uRsPooJrNBrGNXz1XF2JyqsmQOJMWVcN09dbK4
 2CCQh709m38ITPfjPbbH3b1P69j/xJsnQyZnfuT0s7ljeps1bl+3/LE2tgrksQCGtUb8oM4mv
 iAjAbLLVAFwWFxA85APW9SwPd4AZk0DDj0w1UUO8n8vLUVtI4ku2fpBL0ExwTOAmyA0SLLy5u
 w429LI4unTh5FiTaySpeVn+C/iGEZdyGCADxhMG5dk0A5Bmox4Q/QCDDUEx10PmKoLIqyEK8s
 Gruz7aeEn2eWnSizQsFfLhlyfuze7psejWTif2oroze5xW9gGqGPkscZmm0NFtaQ+ljTVMEkH
 sd2tahBKw//LPkXsmOHb0Tru40Hm8PCva8guow/kI1K1aTX1fm6tt64+1JiNJgCQYNfSPqlcH
 sEnEVJBRWi9hjtBG2hk1Mml4CsZdxxXuACyGal/McFDnrTBylDgcg+h88YNqNKtRjOx/wm93z
 DQo1YnX8hhJRJc/X0kOcbRy78kTc4Fj4eNGcCpDZeh+Sh1dHWfYfLd9diP/KbDvE8Vyl47Aqb
 Mzja5rWn97LPpDTOcgxcjwYLAGkLCJyLGADWlS/woJRLZXYV0oNYH+QKIlglGmcXIJHpl33Ur
 k+dtoHZqnOIRkT+pnoMRIDoI2SK2MZZXSBXxC0/uvA6com83ftnq6vU9TCWFqd/xo2Lm+0Bqs
 SUrepBHlsHGSSijp8ar+vBNwrkSk26BaYA46Yve+ZuHPduOIpfEku
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.22.0 is available from:

	https://gitforwindows.org/

Changes since Git for Windows v2.21.0 (February 26th 2019)

New Features

  * Comes with Git v2.22.0.
  * The awk included in Git for Windows now includes extensions such as
    inplace.
  * The file/product version stored in the installer's .exe file now
    matches the version of the included git.exe file's.
  * Comes with OpenSSH v8.0p1.
  * Comes with Git LFS v2.7.2.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    v3.x (see release notes for Cygwin 3.0.0, 3.0.1, 3.0.2, 3.0.3,
    3.0.4, 3.0.5, 3.0.6, and 3.0.7).
  * There are now experimental built-in versions of git add -i and git
    add -p, i.e. those modes are now a lot faster (in particular at
    startup). You can opt into using them on the last installer page.
  * PortableGit now comes with a meta credential helper, i.e. a GUI
    that lets the user choose which of the available credential helpers
    to use. This should help to avoid storing credentials on other
    people's machines when running portable Git from a thumb drive.
  * Comes with gawk v5.0.0.
  * Comes with Git Credential Manager v1.19.0.
  * Comes with git-flow v1.12.3.
  * Comes with OpenSSL v1.1.1c.
  * Comes with GNU Privacy Guard v2.2.16, specifically patched to
    handle Windows paths.
  * Comes with cURL v7.65.1.
  * Comes with Heimdal v7.5.0. -packages/pull/33).

Bug Fixes

  * Git for Windows' updater is now accessible, i.e. it can be read by
    a screen reader.
  * git update-git-for-windows (i.e. the auto updater of Git for
    Windows) now reports correctly when it failed to access the GitHub
    API.
  * Git for Windows' updater no longer runs into GitHub API rate limits
    (this used to be quite common in enterprise scenarios, where many
    users would share one IP as far as GitHub is concerned).
  * gitk no longer fails with "filename too long" when there are 1,000+
    branches/tags.
  * A bug which on occasion caused lengthy rebase runs to crash without
    error message was fixed.
  * Two workarounds from the Git for Windows 1.x era (concerning
    reading credentials via GUI and fetching via git://) were
    considered obsolete.
  * git difftool --no-index can now be run outside of Git worktrees.
  * git rebase -i used to get confused when an exec command created new
    commits and then appended pick lines for them. This has been fixed.
  * During a run of git rebase --rebase-merges, the output of git
    status now shows label lines correctly, i.e. with the labels' names
    instead of the commit hash they point to.
  * We now avoid problems updating the commit graph when
    gc.writeCommitGraph=true.

Filename | SHA-256
-------- | -------
Git-2.22.0-64-bit.exe | 0c314a62f0f242c64fe1bdae20ab113fef990fb7e3323d0989478b6ed396d00b
Git-2.22.0-32-bit.exe | 9995409d05c6789f96611f9a6365318dd384cb97b94d6d537f13bed789413e18
PortableGit-2.22.0-64-bit.7z.exe | 2d935dc309568a9694711ac080967388c98b69907fb015f6536a4a0920084e0c
PortableGit-2.22.0-32-bit.7z.exe | dee3d963c218b5f7fb0925c5984070f7373abc4c44cf36050fde10bfd3d9bc2e
MinGit-2.22.0-64-bit.zip | 308ce95b7de5792bed9d56e1af5d2053052ea6347ea0021f74070056684ce3ee
MinGit-2.22.0-32-bit.zip | 61bbb2d02baee1b1c24857b031bae1063e38a3b062a642c0c9304bc80bf7b8fd
MinGit-2.22.0-busybox-64-bit.zip | 48213aaba43be9b27d45affadcad98a65d06490987500b59e8310ebaed729327
MinGit-2.22.0-busybox-32-bit.zip | a5a4634a34cafaff3f7d9340c38d18f2044191a83c2da44fb3ff4db825ff4acd
Git-2.22.0-64-bit.tar.bz2 | e4df1f804512e678bc37b4dc2e0354f9177c0e44fbc73b28ec87702cb34eb236
Git-2.22.0-32-bit.tar.bz2 | 15c1e87cd0a5c100c4c16d6043569eb478c87c4856670c97aeee920c20ea0b84
pdbs-for-git-64-bit-2.22.0.1.d003d728ff-1.zip | e54bb0cd2ae6c0e779065aecd8eeca3ab852781665ca9cfa53207cf136b4f915
pdbs-for-git-32-bit-2.22.0.1.d003d728ff-1.zip | 2e4a1c2024de1b6af6259bfe1dae0d98314c72ca87291fd6a542885954dc6304

Ciao,
Johannes
