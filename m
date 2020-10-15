Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F645C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 22:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFEA220789
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 22:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="H6ZPTNVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbgJOWah (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 18:30:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:42199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730407AbgJOWah (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 18:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602801034;
        bh=x+ajKP6XzjUjolikLI0rRjh/NX0EZMdo8ymD2p5+h8A=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=H6ZPTNVoDEr/EP3gDxdn8vj3F/69AkoCHsJ1KQ5dVVqU0IVGGcMWPvtEeuy/QR+G5
         FDKmq4/OQcF/X4SStIlcnI6XWLB6dn6FNCZ947xWGkxJ9yFF7npLRRBZsnJaxvsKnB
         AnE31WJrPZig+nH1l6FjHHaDgAeeJUFZU04AmjYs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az767.0tlz4fqdirrepf5hyhmso2i4bc.bx.internal.cloudapp.net
 ([13.92.187.2]) by mail.gmx.com (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MjS9C-1k11xQ192I-00ky8p; Fri, 16 Oct 2020 00:30:34 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.29.0-rc2
Date:   Thu, 15 Oct 2020 22:30:32 +0000
Message-Id: <20201015223032.6237-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.28.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:jQF8yYByqZ/EOxASff8NKgcVYi1UUapdZrc5jn5T0t+XiesP87D
 TOgs2bCpXSH2BIw+V6kN3NvkceKxSS7iPSIXOF4voYHl12VUnklN9YZU4s/Sk+u89nmEipx
 uQtYLw6JKEcDN19IB2FnI2cxrpehZmvcqpdfSpbt2GtQjDdbsHsgcvLhLfaJYepknzB/lnm
 0u/TmD2JJVGYqxnMSp+nQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N9ZnaHgmusc=:1NzzwO3gkpKcnOiHCFHiNG
 T1w+uZse4Gyk54Ns6+w5lJDD2y9DCRjrxp828DDF2ijMesXz0ZKPJoiMRZgwGivYQPJH3bKSW
 /2mZyXjE4c3OKRf2Wq5MXdpKs779EKOse+IJYIj2zl+BDFHyrucdqdyc9eBcv1qvnN/yjdV2n
 XeTS+nysdFRTyDJktUTh7syVwPQnp2jjF6xzB2tdIaaZm/UG7OXFSq0/p+PyT0uzKTpfpKS9u
 287LZaN5opbtz+iPgaJNvRSrwq6+1soCv+g8+Ln9miC6BVaiOT5GN+I6fKxV7E/oYoyo8LaAU
 /EH+L3YjlElrd0esSCfCoFFaMctce5prCl0Rpnueoaal8TuZe7rdpk9YRZIQQQI9zsG/4ut5J
 5XbPYrFJBz04b2Gl+nN0oXjssOIAU/a9ZA/X8847mq2jOe3N6ohGz4SS04RSUYeij4l6MrQem
 /qYnmj/gOAXZVlF0PUtPnQBhIGJ5Bml0qG50caSml9f9543aOqA49fXEAEj1NwRGNPH6RSBY1
 doX45vX5CHfrvZRmvmBDcgMXj3M6Y6BzAPktRB2PoXs9y+CPBhW3OzXp6sgkD39se/cQoNpSM
 1CTGNhU+4AwWRW604MITrRp8ZnQVBpb5Kd+VkQU4cEhMa8aDWvUz5Llwj86XW0WfWIRpDbdSO
 8yZb/mPx4BkGc7a4oRTV6CNeD2ght7H3Iy+fmec0fQcUU3brdpUsdXuzZ1JeEf3T+e81/+kUP
 8/yw501Wsd2eL/EpCyKPLLhmPSIpvqFaVFkBRn3QhjGpc6JGL97iu3ujhXrBfMq25GM1xOpV/
 7G3fjRAwmKtWVj2EyhBZb1NwgsvANLluB8jAXc+l0AUX40zgyPVFO8hqQFn2E3zUgTO9QcHSH
 ePIeK0KEMBbJX/DbmW7FtgNR/dvLRxcP7wDzLcfZ8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.29.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.29.0-rc2.windows.1

Changes since Git for Windows v2.28.0 (July 28th 2020)

This version upgrades existing users of Git Credential Manager for
Windows (which was just deprecated) to Git Credential Manager Core
("GCM Core", which is the designated successor of the former). This is
necessary because GitHub deprecated password-based authentication and
intends to remove support for it soon, and GCM Core is prepared for
this change.

Also, the option to override the branch name used by git init for the
initial branch is now featured prominently in the installer.

New Features

  * Comes with Git v2.29.0-rc2.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.1.7.
  * Comes with Git LFS v2.12.0.
  * Comes with GNU Privacy Guard v2.2.23.
  * Comes with OpenSSL v1.1.1h.
  * Comes with libcbor v0.8.0.
  * Comes with libfido2 v1.5.0.
  * Comes with OpenSSH v8.4p1.
  * Comes with Git Credential Manager Core v2.0.252.766.
  * Existing Git Credential Manager for Windows users are now
    automatically upgraded to Git Credential Manager Core.
  * Git for Windows' installer learned to let users override the
    default branch used by git init.
  * The installer size was reduced by dropping a couple unneeded .dll
    files.
  * Comes with cURL v7.73.0.

Bug Fixes

  * The credential helper selector (used as default credential helper
    in the Portable Git) now persists the users choice correctly again.
  * The full command-lines of MSYS2 processes (such as cp.exe) spawned
    from Git's Bash can now be seen in sysmon, wmic etc by default.
  * A bug preventing Unicode characters from being used in the window
    title of Git Bash was fixed.
  * OpenSSH was patched to no longer warn about an "invalid format"
    when private and public keys are stored separately.
  * Non-ASCII output of paged Git commands is now rendered correctly in
    Windows Terminal.
  * It is now possible to use wordpad.exe as Git's editor of choice.
  * When using Git via the "Run As..." function, it now uses the
    correct home directory.
  * The Git Bash prompt now works even after calling set -u.
  * Git for Windows can now be installed even with stale AutoRun
    registry entries (e.g. left-overs from a Miniconda installation).

Git-2.29.0-rc2-64-bit.exe | 2b361a71956bc09197d34b03bc1cb4dd302a22f3d765cd88d470b90e6fb6f6c3
Git-2.29.0-rc2-32-bit.exe | 64b004d71c5d8c2a44fa296c2a2cbc6b03ad687296dda15de6b0fb4ca1b8addc
PortableGit-2.29.0-rc2-64-bit.7z.exe | 4900a83a87a8fba5a5417f17dc1bb23db8633095b81b56e10fff7b890fa3f431
PortableGit-2.29.0-rc2-32-bit.7z.exe | 0e4530904095267ae75067e6a4e88a9e36e9b0a84fe339e7bfb26ee32c76e67b
MinGit-2.29.0-rc2-64-bit.zip | fa3ef81027a84e5c755fbda79f8afa7b432b330ce890be6389a2761307672a9c
MinGit-2.29.0-rc2-32-bit.zip | 52747db780aa3608929d3b423fadc59e5bd56ec7784e71ac7a3904104d6fa259
MinGit-2.29.0-rc2-busybox-64-bit.zip | 096ea5e7efefb091adc33897c735efd8d45103d06e5fec41823378be3cc66182
MinGit-2.29.0-rc2-busybox-32-bit.zip | c68e94dfb8c116acdb870e950ee0abd400011ff6a62e78621f52eeefc5a763c5
Git-2.29.0-rc2-64-bit.tar.bz2 | ab2266f729f4ef1f0573f89b9a94d9464f1630fba8a9d4bef27722f37e92a68b
Git-2.29.0-rc2-32-bit.tar.bz2 | 8ff4ccab4e8a59b1c3a2cbdd894bc0747b170e7951facfc304ac47353b6c1327

Ciao,
Johannes
