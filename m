Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14454C433DF
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 19:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E290B20771
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 19:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VDQ9fUW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgGVT7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:59:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:58155 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgGVT7M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 15:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595447949;
        bh=/qXttXrNKL1pdLmIMc4pDivZC7vTnEMGVliT4tziJRQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=VDQ9fUW8cpcDcVJ6MkQetKcghVCuyfhNajf9p9DE5d7H99rE3cQ/pgADjC6J6ZmHb
         bkRnmlxYLaxmFokgvceY80RFFa7P6ZohdGF6QjDKAuoSxWesAnc0heJ0I4hcNJdDAq
         4FsXwI28oLqBhVbEBoi33sq3u/kL6NNW8oCkAQX8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az764.131idnstwpkexlobsyfpxfcyfa.dx.internal.cloudapp.net
 ([52.160.81.20]) by mail.gmx.com (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1Mzyya-1kmIaQ38z8-00x1fl; Wed, 22 Jul 2020 21:59:09 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.28.0-rc2
Date:   Wed, 22 Jul 2020 19:59:05 +0000
Message-Id: <20200722195905.6540-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.27.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:nWbJpdbzWMTc3peRDnuMeGZ+Wi5z6QLVpDwdNeEFom/4KlI1Pw7
 R95+Lll8ImSueA6058+CO01BowlDSC0s+HqatjyjFgHQkOAoceSU2asjPE2A1L+B9GVatac
 Wq9JmrmALvczThPCIHHil2MTu0vrL1NqsJpfgKI9kXAM2rWZAlD2Xxi/RV5Rqwf0A00BgPD
 SWZYP9ybV4h+NdsP+kjhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1/zwCOh2mu4=:99MHhh2HSXLQxF1NaMjzwT
 KriX6C0jJvje9rhy8ST60TdYrTg0jR4IRPGRbCTcazTN3iWUISQqBSwtKBOQ0Y9t0AoSon4A5
 2ydVTTxLPCL6/j4Ntj7aD2W4II6dbQiiiJkGXK/znEAqioCf+7J26AnEWr1mXSzFYpkbjtyy+
 grhHPP1lKjSzTkWIChOPvEjWZFWlcpIj5C5gupCqcY2jOzSKgLfTOUMrW+lbwsOWz/UMJlNS0
 +dRNZRXXxC6StWGrdIW3MUHaNwYODPDok5cR9aneTYyRxsdKYOaFwFyi28wSWv/7pPYmKw4AH
 dWOBbC9kPZDs+oiHJImVHq/+CNfncCmh3hpw8j6Zc5Ymafq7P+HeEHIC2iws9v1uKdBZQtb/8
 Rj7weX4WFN0+BMPExAkYSsi8MDuwJriDmIJyKS1xutPlbyo7nBRtG4hGXKHqkC5olGyMgzmH5
 p1iG+CicySTuN9eYPTmRiaeX2uYroDhxGxS6Hwp0cy/jwgQKxfEjlBbhZp5f2OHy4Ud1LBF45
 xylFgCU/ULtm+Jan5IEEe6PRTF/b4qo2EskuZLjzQYa2U/KR6vFcDJw64Jg3j0xOp0Ks/qN7I
 0SJIiAb8K3QIsG5dwckg0C/23tcDUTcrsyQ6tN9o5C5DvjF+e3ZQOFLbytqJuGgDjR1Ldhx0l
 swQUs+6jcpeRKYyTafnBj5D8PDK8C+4nlB7enoru7NTpe9f637hZkOJYFg5PMexB+rfh78WX3
 YN3wGbe2TKyt5wr01VB1HArKB8Y6xxia1BOyZE+z31+P7nm8e+F0lZtCgEb+EqO560xZQwnLE
 H6IMr6nSPu2h2seOTsS9mj9XYg9s4EYs7umaJeoXiSeEVtQRitB/2AZrUVzKdiuj2KpAyRuGb
 MzaaeMJDGkEEvXoiyuCevU1FDlU9DCo4LyX0Bt+wCEBpQk8zCOIsKFmoeT3TxDK4YROvVm6zq
 h2t77FBDkjD0kFozyOyFQNXbea+0eIEYVCft8j1hBfhVZz7GKPluIuFXVXqa5+M7qmT3Q49k+
 OeKi+unWxijQ52LM+6fyFJrgc6nFoYrnXcKQOT71iRQdOBjYPo9bGFF2s8foMmVmb6LaeAMOG
 7fTdLxSaBEEci1ComNEXU/yZc/mlrNMrYH79MXIc6HgmR9Jr9rIz9L2p//kqpmyBqu4cCjGWq
 p0q1uFKAlUVmaj9/09Sk+aLtHyzyql3Ki8KVW3Zbyf+RipVaOl+ikMa5Pc/IJ+BhIcEMq5ZwI
 A3Rp3a0EPbqcA7QVrSWNwBmTl1CHDFJs8/qLGyg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.28.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.28.0-rc2.windows.1

Changes since Git for Windows v2.27.0 (June 1st 2020)

New Features

  * Comes with Git v2.28.0-rc2.
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

Git-2.28.0-rc2-64-bit.exe | 847cbe1f10ac1b96be44778861cf8e26806ec48ca335b20f357dd5a7339dfb31
Git-2.28.0-rc2-32-bit.exe | 75b3bdfbf558b3d9b16297e7dad46cce0fa2783853f1701dbb266a14483d7c6f
PortableGit-2.28.0-rc2-64-bit.7z.exe | bc06dcaff14b22cfa11ce281a97e2c93291d391e3bc8234c9433b498fe6c96fe
PortableGit-2.28.0-rc2-32-bit.7z.exe | 6e30d648fd23cffdb2610a52125823c66cb807e612ec4b4856dafe4e81656a8a
MinGit-2.28.0-rc2-64-bit.zip | ab9aecc81c6a0ce9255f1213ba74aa933f34eb8d4a317706b5f8a8b4175c78df
MinGit-2.28.0-rc2-32-bit.zip | 939d9bf40f0c0fa9fb7d7664aa9942916b7e9fe9b26c5cfcd14b55c651473a09
MinGit-2.28.0-rc2-busybox-64-bit.zip | 1c72215e2d2453af243839d21e451c12b090864757f5c0e00e1a9d71d7c03c17
MinGit-2.28.0-rc2-busybox-32-bit.zip | eac626b7d8d181b78dbd1f85322241b1333fd67286eda5c4acaa14672266d598
Git-2.28.0-rc2-64-bit.tar.bz2 | b413877a5b6466f3f7f74ec2281ae602fce5a92c6b71d099a85a0259e225b406
Git-2.28.0-rc2-32-bit.tar.bz2 | 2f72c7d748346cf27b5530eddc07455eb1201658b206005e590a392c17dae2ec

Ciao,
Johannes
