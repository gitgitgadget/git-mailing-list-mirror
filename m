Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58538C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E4361C73
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhGFVka (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 17:40:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:50137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229770AbhGFVk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 17:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625607468;
        bh=WFqFhYpIKfYWuUjY2h4w+4NUEu1dhxeIU5Hv9oUmU+M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=RuO9nhB3VVAi+CK2T0tx6iNGJtTTQkDS1PpgS/OL4aEvxWcnUB3M3pGol0qGqejSJ
         Xq+za7FLk/7FYxlXkBto1Uw1nHENm7mZY2QHDuwyGPzEQFykBma8H6L8tDQrxCPzjK
         RutXhTvQdNRTn93XqCKglcGnwQY/1IqyJf/eHn9A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az121-786.bcqdpxy2ujdetggs3tg3ro5ulh.jx.internal.cloudapp.net
 ([13.66.53.151]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1N2DxE-1l2kok1lHS-013eOB; Tue, 06 Jul 2021 23:37:48 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.32.0(2)
Date:   Tue,  6 Jul 2021 21:37:45 +0000
Message-Id: <20210706213745.4758-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:DVqc9O+O2JbkhOkxQI8jXTchEiq/+Iu2j2E8+5mxSWNit4iezt3
 PuawQjXqOh1uqpzp5DVEZb1kFZpCmVOtkME1Wvy8WNKF5evMz3oFyPby8txVbHCJi1Jq0Li
 A+W9B+IsLjX18FOx9Vtax0stYbz9BVlAvkuazhymxjQ016vaUw7j0naRGldGPWAa1S1Moxc
 JaYTBQsPii6MZ/LpjgX4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:02G0qPilV/4=:CySZ1cMt5uaELJdYLqQQ2E
 /Q2GpLuXPEIa2FRwPugWbNx0gILt5YDN00nGoAsCr+0zOJGkbopw312bjK19gu2NR8bw+SFKb
 n8XkqscEiI8ZAERXLUukbyuN2bZM+rTCZ/69LaOJdvOC+ieWqfKoeXryH6BDirAC+ng5if8qa
 q4Y4lFhoX9fbZpavzE23P6IBmmZ6Ct2lpvTPkNm2ucqqDkbxXqgDbfJxFjn9+uSBr+1CjzbiF
 6Wuukt9/ugIH6NVxYr0mHG1PZfeLphAYwxZ5AmLOOfPWiu+KK38mr/F3SnRKPHXyjSoCdEXu7
 ngmPS416bV4ztunlGyvc49Ca4utWXFZow9LiiBkV0RJKMga8GKurj1/BhjtyYUD4zSpCJ826g
 Q+oy3BHxaRgdhEBUwlXl8lraGmq5YrJCGItibuGWmDX06Aow3bPR90d+62yfcZ0cW4cEjk3EV
 sqLLigMRonUL0Lc3AXyO+LB7uDZFrSZdcI/1gytOVhdgcOZWjmRfiqA2v0n6b8UNk+QWgfB1r
 9qSeADhgDMJ2LwHL4Q94i82EaqbWoaDMdYZLG89RbD2wTKj6jNxtTXuFfwql/J/Wm58cfC/9v
 t//sFrqAU+UT1WIuq6eryyVEN0Xrec2D5oDRo4wG2pPu8A5slnHN+GcG8/lmXEHET2prmlwE5
 W46CsuftJXq8QrT/C9QNr0ez0FTmf5vx1AjRttgwUVhVEAoJdOgi5PsOQyUZeBFIAAlFTHAld
 5PcuuGkyWp9ieghxEvgV8ZyxbdqNhKM6ho4qL6hfowVSEzrNVDGY9jKp06tiUT3DPMUfSV3Sf
 1WkGvJoYQabBSHE6igA4QwIk8iVzfpEnzGW+UB8Gz6aQhpsepwH7RckGczq7gWpmwGmfHwDgh
 s0ltLuAV9687LPeQH7B1Gta+UAMdD4JKGh1NtdJCv8578SCx+4+yOV7ecXnldzVUe5vWwRPww
 yN2W6xqquo2XLGmKoPxM+lfawsRI0EmDVUFdIpSrtqrmZq7AspKDeRkAQZ4V9EOPUqLseWKjP
 D2wzHOmd8vc9mTRxBU6f5lDbNS94142ppuBWQis15T2g0z7HgHI4fvLAlmUhtSmWChmA+go52
 0wg0zcZovXfDXpNQ+iqyBPWI2iFaSKRLxLqRjOg9SBCollCpvQsSPLApQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.32.0(2) is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.32.0 (June 7th 2021)

New Features

  * The Windows Terminal profile is now identified by a GUID, for more
    robust customization.
  * Comes with GNU Privacy Guard v2.2.28.
  * Comes with Git Credential Manager Core v2.0.475.64295.
  * Access to remote HTTPS repositories that requires client
    certificates can be enabled. This is now necessary because cURL no
    longer sends client certificates by default.

Bug Fixes

  * The built-in file system watcher could hang in some scenarios. This
    was fixed.
  * Remote HTTPS repositories could not be accessed from within
    portable Git installed into a network share. This has been fixed.
  * When scrolling in the pager (e.g. in the output of git log), lines
    were duplicated by mistake. This was fixed.
  * The git subtree command was completely broken in the previous
    release, and was fixed.
  * A bug was fixed where remote operations appeared to hang (but were
    waiting for user feedback on a hidden Console).
  * A bug was fixed where the experimental built-in file system watcher
    had a problem with worktrees whose paths had non-ASCII characters.

Git-2.32.0.2-64-bit.exe | 266fb20b60d53acd1bceb5d02877614c510a9dfd39bed3434342b2187c7a0fc6
Git-2.32.0.2-32-bit.exe | 9cd78f6d86e33f1db963fc544a25e50e6ca32bf01cf77eec0d9146feb29ba98d
PortableGit-2.32.0.2-64-bit.7z.exe | c5efec6e470dabfb97696dce5f15c50a1173c14a8ae55d5a4cb144dd4c9cb68a
PortableGit-2.32.0.2-32-bit.7z.exe | c186d5260025203fb862343bc16ae94722f2d23fb160f083b89b0a50f54b1424
MinGit-2.32.0.2-64-bit.zip | 40e0e8a8a4ccc3399d323b2edfab34fc4ebac7350471525d679d9839b689f4a6
MinGit-2.32.0.2-32-bit.zip | f253b0d3dca2ab09ba616b1da6aea3dffe9a66befccd8933b61271400d15c447
MinGit-2.32.0.2-busybox-64-bit.zip | a439abf1a0f00e1c031a94e427255dbd303556ece5231d1cf6d5c8ff7d43b461
MinGit-2.32.0.2-busybox-32-bit.zip | 964a2dcf648499d4d125c3cc4511243b993cb3b32c01163704c22f7a6e6d4055
Git-2.32.0.2-64-bit.tar.bz2 | 4fde219d84943dd31e56b4641184d5fa6c9274f1faedcf87970bc1bb70bd3b72
Git-2.32.0.2-32-bit.tar.bz2 | c82082423e0f9e9f120c3ee6f935a1da6b2259158cfe427003f13d5f16cb06c2

Ciao,
Johannes
