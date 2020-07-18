Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23C0C433E1
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 01:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40A020717
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 01:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aDSDWrLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgGRBKM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 21:10:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:40087 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgGRBKM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 21:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595034610;
        bh=XwcMviGziMrJojk3ZPrlIdjvhp0qupOqnK0WIc1U82g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=aDSDWrLKRz4CGsRrLa+uwifykqd3gi5X9g9hdExxjeE3UQVxKk+BXhn9wRjgOxuQQ
         TXHGYcVjW4sjAUF2gJy6RdIMBIRKxrT+u2hkM7YGmbsyQLUQ3HO0amtrkkfyeI9K3b
         3kEW3HWd/3NcIcLqDyJ8movUkVPMiQIii+fNDkGo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az767.rnd3qlawrjlelmdafjzgqu2wbe.bx.internal.cloudapp.net
 ([40.117.186.248]) by mail.gmx.com (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MXXyJ-1kLbG23H1L-00Z2Zn; Sat, 18 Jul 2020 03:10:10 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.28.0-rc1
Date:   Sat, 18 Jul 2020 01:10:07 +0000
Message-Id: <20200718011007.6808-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.27.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:ssCx5OHb/PVu5VUHi4dK8zAHC5TqpcdygVLzxsPbUbuqEZEYwNn
 onbYccsLHRWEJrp3MHVJarOGe0qLErHob94/znJM3O7tOpfSlNGoZisBDaOg6b8zi89NdUj
 QRPinMGpDtkLbwcEv+0pN36A15/M9JdDLKisdQOM6V3UQgT7j/jGdPS4cBfuC2p2ri/fYfY
 YxqBeiYuz22EwOmEaMZZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tl21GWraGsY=:fRr5qcIYE0MuCdBSRbNMcz
 3VsZnIeab6kLZH0vBtFwm/MAfb/FM/2faGe6FuvmdqX/7MEP6H+CAss2RMdyxUnSoZuHK5X3y
 LW7z0Gg+xiAKXuPVj8SEBS9vcnwRyB5p7HnWAkhzqk2zQ93CasJi4ux5EJqD175SMAvai4sCz
 oK4wXJWIyoP09dsLYDiz1YmlmLwQ2CLRGg9pbdywhU3zcfhEPNt/rjH8YEhvj0lO1gwiIboij
 WVlPsZnyd3Cw8nLSTmvyUgnF0zkzTl/M4G9xNySIsZPPrtFdse3lyZjhTWiu70aXKWSMztTsz
 pNmF/O0KEt+UNZxx5qs67sOewNF/8H/JqhDOnscIs0Bmo23ngnjySriEyf0lfHPtd3Cg85ZBa
 PTqDiFlplK8iIauLF+1OC6Jzx7lv+ylV06eGpE05FwOUtEujfVnjMiX+k3XeTA/AMkf4Tyq1E
 jUHrTmPl2xo4V1WIFrWUmmmLR29zcc9zFLItG+4AAUCX20KHrm18P7hMcGtTXVtxAlkAgZvHU
 c4utmzuXfRC9XnWY40mAG4exHNAl25ADMx+ZiD6jVS38Hcc20x37y0evxFEuhhunRnh1rpBCx
 qefAnp8GI6yitFRCeptyVAK42jlJaF/KAYLuqwUSotgq860JNns6jnrYZ5uKnn+k7FlPwtNnS
 PGacuRtzE/A1BwH6qyS2bGbwE1r7d8JxiY97gRpg/D3Y1d+GKpanp8rICb2ZE0obYg26f0SSA
 QfHxtHJl4SDGtsEEqO2a8aVjo4Xg/QHqWusq1LVB79o+Z0DG4AualUO/+kVHyRhzte433WyVZ
 mM2feGHzYcFVpIxRK2Txlb6jXzlp4lk8UO5uTE2Vl3BE8a8UEQc6G+f/OssGRfiBP4rZpEEpN
 BTkExWeqy+rTDFU+uUXmlf3so1BZu1OfHlSSXZADpZqQQF75DtkK1e+5RZx2hL0aVy8gxyIRz
 zBtdNXiycSqAjE2QFP/V9J1G5x08FNJVW/vYTcb7E/Zz4EVCHtLfEi6w22tH3GaB5wLKC3GC5
 ae/NAs1hiXpmcRhiAUWMn26STFCvjgcIdWx7dJrHKfpbxS3WlwcqRYPxDcN7+/waPgJrPO7KG
 ysCVASKxxCjrMn6SxNb1gRwy2WHZ9xxd5tMxzCWl1FL1LSj04PTiT4JlkqcxiAh5V4Z+xWRc9
 i1Qmrbjo5QD/NWEkxHwZpzE2Br7skCRNLixQP1Zee7r6Ky7jMEsns8mH8Qah9rwnuvqzmjHch
 rQ8lxajL0jjs4Qh+oihpcfiug4XTNM1xbpu8jLQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.28.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.28.0-rc1.windows.1

Changes since Git for Windows v2.27.0 (June 1st 2020)

New Features

  * Comes with Git v2.28.0-rc1.
  * Comes with subversion v1.14.0.
  * Comes with the designated successor of Git Credential Manager for
    Windows (GCM for Windows), the cross-platform Git Credential
    Manager Core. For now, this is opt-in, with the idea of eventually
    retiring GCM for Windows.
  * Comes with cURL v7.71.1.
  * Comes with Perl v5.32.0.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.1.6 (including the improvements of Cygwin 3.1.5).
  * Comes with GNU Privacy Guard v2.2.21.

Bug Fixes

  * A typo was fixed in the installer.
  * The new git pull behavior option now records the fast-forward
    choice correctly.
  * In v2.27.0, git svn was broken completely, which has been fixed.
  * Some Git operations could end up with bogus modified symbolic links
    (where git status would report changes but git diff would not),
    which is now fixed.
  * When reinstalling (or upgrading) Git for Windows, the "Pseudo
    Console Support" choice is now remembered correctly.
  * Under certain circumstances, the Git Bash window (MinTTY) would
    crash frequently, which has been addressed.
  * When pseudo console support is enabled, the VIM editor sometimes
    had troubles accepting certain keystrokes, which was fixed.
  * Due to a bug, it was not possible to disable Pseudo Console support
    by reinstalling with the checkbox turned off, which has been fixed.
  * A bug with enabled Pseudo Console support, where git add -i would
    not quit the file selection mode upon an empty input, has been
    fixed.
  * The cleanup mode called "scissors" in git commit now handles CR/LF
    line endings correctly.
  * When cloning into an existing directory, under certain
    circumstances, the core.worktree option was set unnecessarily. This
    has been fixed.

Git-2.28.0-rc1-64-bit.exe | 15a73c06141512c93dd0ad92f0aba1628bd6294162b44fb24baba7d05e5c636c
Git-2.28.0-rc1-32-bit.exe | 1a12463d484068e73b218a9a1d2d98b7924699fefbc7baa4a06054ea8a6597cb
PortableGit-2.28.0-rc1-64-bit.7z.exe | 90f6bc4ba6af69375acb286c45fa2ec01d91b0e67a4d851a9e9d7507e8486437
PortableGit-2.28.0-rc1-32-bit.7z.exe | c4e0e659e34f47e679c9882b2bc3c184e0b6ca58f850ce91764cfc19d5f002f3
MinGit-2.28.0-rc1-64-bit.zip | 08edf0ea9f94e511eea3abcc1c3fab6967bbf6e14fe7dcf619c3218b6f038c66
MinGit-2.28.0-rc1-32-bit.zip | ee21cc0648bf2e0f96e331fd6f8a4af4cd01375e18c8980a835baa148b0c1b81
MinGit-2.28.0-rc1-busybox-64-bit.zip | 76b1e67705bd7ea92364e286a6d3e35a1c5b5fb47b80f4cc82a581e478464e99
MinGit-2.28.0-rc1-busybox-32-bit.zip | 2a53b2e632e039a4ed0db3656c6d8394df4111bfcd5ca263067c62ddfff2a3f7
Git-2.28.0-rc1-64-bit.tar.bz2 | 62b70980b712be2ff02b264b77f645d260651053d58eec0191838eaf6b1d59d5
Git-2.28.0-rc1-32-bit.tar.bz2 | cccf7f9696945b2b471fcc4dcad296d61382205bb8d8d64b0a84e950bf1d20d9

Ciao,
Johannes
