Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63927C433E1
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 10:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 351F320775
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 10:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GV+6W3Al"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgG1KcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:32:22 -0400
Received: from mout.gmx.net ([212.227.17.20]:44263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728547AbgG1KcV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 06:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595932339;
        bh=mv1pZT8bbccveI7T1mSWOgFq4rePCx1rT8gP3sVQDFQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=GV+6W3AlnP/zsb6CyfqWjlxAnPiyjO+/339Y51K9ARAASOGA+W0eQ6gnvKjSJ/6Li
         /ag6WMxfgf0QqtApJ9TzHXvAYF1/59CzarxWWJvh0u825ufxEMS0RlH1TLIW4jbi+/
         37dyS2gLDTJIozUGbOXFseOye23pSm3SoYda/MYg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az761.fhgdotb13bketnnq5z4r2cyfof.ex.internal.cloudapp.net
 ([52.237.160.126]) by mail.gmx.com (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MYvY8-1kMFMZ0ieG-00Uvvi; Tue, 28 Jul 2020 12:32:19 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.28.0
Date:   Tue, 28 Jul 2020 10:32:16 +0000
Message-Id: <20200728103216.7378-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.28.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:Nzpq1TyJUJnaHVfbkCbppvkvDjvXxrVXEmRIoWs1sgmGRYOckwC
 mGu0Bn3ck91vx5pO1GZh7OKPCD9jz1lBgzuGDgbOdJxwenYrIRtOYoxWI0Ee+4bzKXRnmKg
 xRof8LE32QgoA2pJPkb67G6g/wAumiw4I941koPtws+pVzYUPEoJ1UIxyAfUAIxl3wCZXlQ
 KWghXA/xWOxvTpYw5zcoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jKsztHOhfBM=:PGrj/utfzYyFQhn6VxiOMK
 ErmwAVv+/rjcBm7EhygU1DRobbZD6N7QhJ1W7LTJB9CB+KC6H3Hph3IKr7W8uFb/vOpXUTROZ
 GDQAT+S6T3eahAA9vsLG0geM2lLI2q8jX0cqibG2iNzpzI8KEyJ979axMBp1A3tZZhiQtVAwx
 uUc6O694/TtCF7lOOZn+Q2CYll6RLhgniO0K9B11fMASXA845NRHgAqnPwCX6ldUccHNKXq/O
 GIA/ObM1UrDyat+XoBfXtI6hGvEgYbbtEhexTDJ8KC9u/4CBLR+KdlSvf1hpeyEm1MLJmCxNS
 lD6dYC2edV+wwEle1j2FFGmYUSem8TNoVisv67jM+U4R9ziyCPcU4FiNzxTR9xSMNEq2qzrbh
 dnGWa0y7IEiBdaMNMvFoL34K/DDPb/4RY3QOqthTGhtaXN9pc1QdcLfLTiWABxybg3q4lVE6V
 fsSmc+IsNC2Tnrf/xsKWi5j7oJLo+XCYXzOw0K+As582xQMDCICDjWa4EVo2COF2HALJkqpQD
 CyCbRboRM9+P5MkrvPzep9p8i4129ZCRviRspHT5rRN/aYtHyW2Tc+MrW5luZ1qZyDFNLgN0Q
 YlQ59236Z0kFdzFcqdez+1456ZGgJqHn7gcxOt8F1NM1f8DzbfRDSZBsTAwF6cHTMFlMuodvs
 nreH+ULjNfKIFv3NlWvVS8naDEM5fQVVXacm3rjQ+u/sKGBA8mvDCBTUMcqlwZfPijb9WCE/l
 nUdFd5IsEu5uk3fCoP3p2Hi5kAdlOesdwvvm/0kwRdAzp7EVkMHTQiys1c/CPYwFu1RoaaO8f
 Jl/t0kPQjDhVdop5U+Own6s06dLe4pG0K73fXKvX2y2QOgSrsY0RGxz6g4lyHXChI8WmfoshN
 y0i1ZxAv6d9bXikVkNGPl2pSWdih2iGtYsgCZ8u/zcVoIiHVEd/r+IpDHyRNrdfWTkLucZlZr
 DTtKJqzML+KPyYeLb9NYIwFpyBuKlL8fQOmOVF+1fK2dKepE2AgQ+/KiC6y5G/12mlXQcdgSw
 CHSezeV458+U8+J/52Cr0gNsvyXlX4AKiG1cMD5CwNKSKacb8qtTeoEmUX6aVt9nw77inOGlD
 mYI2vm7VVpy/1kouLGgG/EWXS3CztatZ679rnqfmv7CT8YRbKQaWkA6DVcnu0UU5fOZwPp9cb
 mPIT42exUf74vJPVq7LjfpYyJ1TfNSL9pjgDyXNA7sgflt49IEWfXPEdKrm6RQGKizHxb/vO+
 oXakmLUbZTyY8sySm48CkW3cDrJDKP3z+IbdxEw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.28.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.27.0 (June 1st 2020)

New Features

  * Comes with Git v2.28.0.
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

Git-2.28.0-64-bit.exe | a8ef3311ac0c8747ba2f5aef3e475ad42fbc084ada7e6fb5060481a78c1a9cf2
Git-2.28.0-32-bit.exe | 9b83b16f1d73212492f21d9bffe41c4b5ce8393a356af96bf8271652c04dfe8f
PortableGit-2.28.0-64-bit.7z.exe | 0cd682188b76eeb3a5da3a466d4095d2ccd892e07aae5871c45bf8c43cdb3b13
PortableGit-2.28.0-32-bit.7z.exe | 11b854e9246057a22014dbf349adfc160ffa740dba7af0dbd42d642661b2cc7f
MinGit-2.28.0-64-bit.zip | c391cb018ae959a76ad2688b0cc7a05f6541d0b43d0ff4d4dacab923363c8dd8
MinGit-2.28.0-32-bit.zip | df42b0c1e3fd18714d1de1c5b1b5def395d6952f9e25d23b249d52bde9ec8f85
MinGit-2.28.0-busybox-64-bit.zip | 1d879a5aea154676cd2be8b947dcdfc0991f82b72dd5116a31146bac923b7cca
MinGit-2.28.0-busybox-32-bit.zip | fc8a5cc3e82697fea4a49640f43ba83c77aa75f67eaa1d610e650f3f21548fdb
Git-2.28.0-64-bit.tar.bz2 | b26b558bbcb2f96112ab491591166a295e1ffe197675693aadcb7b5d2b3e1eb2
Git-2.28.0-32-bit.tar.bz2 | 946b798be0c1d7a1e09d4d560a074d80716d3dd64c5484b184316dc465e1f4d1

Ciao,
Johannes
