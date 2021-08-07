Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61DEC432BE
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 19:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B12A06108D
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 19:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhHGTAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 15:00:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:48771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhHGTAp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 15:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628362825;
        bh=xbvJyrFf2JFpbrRyEC3AGDqA5KcYdrNWM/dU7Yk2VPE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=K0JQImK7XiIkAgpoplZlJjrkT6mQWHP7GofPK0xrIst2P54ypgPx/irSCrin/Nr/P
         Cb9Gd8PwACh6NBVc+uT7NMOhwu2TBZoeHdHCD/v1E9s+ZyJxuAGncidaIPgNwo55ET
         8b27CillLzFD09NfldCZnAXwXxUZwqmUrUHLkqRg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az47-521.2mwgpeqsntxebho0dsvu5l0kwe.ex.internal.cloudapp.net
 ([20.88.23.86]) by mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1Ml6qM-1mr2Au3fTQ-00lUJ9; Sat, 07 Aug 2021 21:00:25 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.33.0-rc1
Date:   Sat,  7 Aug 2021 19:00:22 +0000
Message-Id: <20210807190022.5103-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:nBLxURSuVdNCBIDVdRuZpckx/8JM3R2BhiK+A8uzHN0h6qNjxBt
 y4lkb/DOEGHWqwt/I1khZZfj3839F3XeawmfRC7u5PrVi0OL3doWMtdO4S6r68Qrjonw7et
 fl+3gl6SWZ9IkyqtgrJDTfhBM3uIb42JgGpbxGekKOoixszIoK8GbcKxga1eAhhgxuX1STZ
 cIGjwMS+g9642yvsBh/mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:woqAJp8UL2Q=:DrCpMxSRiK2eRA0eBL3Cvk
 hlaQhLeojG2BpUqnGQEPiLXdLtdszoB7ohQn7B+VqDuTynwmAZVviOBbcLxnxiHaE6DBV9C7C
 cTfRsRV1YPVuCCoyQdMoOHL9a8FFGnYz0L84jYkIHWIOMvd7reXh8z5RwEkXXAKhj8nFP7m/I
 nOcFWbCqTUgcwHQn3tL1iQJre6aq949xTunuI252eO5Bogm3xS/ZfaHYfKeqnWVGgyzSM2Qin
 wxnE/35UtL07bVqUfplDmhCEWAKjaif6BbNp7830S+MD7W+YGkGKBGO1BspnOWX8l1sOxgafS
 39Yc3QBBmunuT1vfGmp/2TQuqlGWU/b3KGJaeU4lTbHD+6EMW21Mrl+kfDBXfZZlZyoFYLrL8
 O84Ou+xiJoo0oFKftTexIfHdg1LAR7EJ1aMRjK1q9qQqVf57ZFFpP+ZW07oJPnBIFMv7tUoRs
 6vnrsu8sOg56N2XooSja7hzGqjo+ph1MZ5dMzSdUiJzBUPc9YX+KZ2IGHcRNdCbryCjyWLzkC
 bIyYkBLSg0IFPLQsL2V5h/AlZcTf+vnKAarO/1j2LlKueSGVu1GFDhdInZ/M5FKFgZYRxyFGZ
 dGJVDWgf+CXNK888PGgxkOAXerWl/0akibxd4Er+RakFznswIYXZCsj1Ang8ewD5B8M7jVWq7
 MT45hN7IvFS11chxpWqo+68e/jAAzVL2TcJ28DP6Uxbyl+EuHKWDvHVK7Os/1A2F5sJ5p3+5w
 3nJ9gJI2Zs8eVRte+o8bapzwJuOGDY4WK/450LSCtTgXbegNLt42YMhPtlDx2XvQdV2asOPO0
 MTyJl1MGamLXl31xCVG0cXL3SFIVy3Zm2EfgB5PyIt4xzJh1Mf5ahcUXQ0v4hKxhZGRDibDuD
 96NWapR5QeTXM6RPG6lor2fP1OSz0tJ/2nOVwpSa57LOdK0415niBIrdqSffoNVjQBY9n8l4b
 6IXci+vKt2e/q4IPazyMbouA9C/6QreLppI08NMdhoQXZjB2EE83PB1B2bxUZWSu3P5U/wqJi
 zsr1eiT26/7SrXPnt9PcLM980kVgugnSL3ys1MXTVyGcgFBsaMbDY4lstCLSQnDwd8WSh4Dql
 EM0lsG86+PhM0pKaofhcfHDcb+wZ97QlR/UrqT0NN0k/mUXizGU2wJwrQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.33.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.33.0-rc1.windows.1

Changes since Git for Windows v2.32.0(2) (July 6th 2021)

New Features

  * Comes with Git v2.33.0-rc1.
  * Comes with Perl v5.34.0 (and some updated Perl modules).
  * It is now possible to ask Git for Windows to use an SSH found on
    the PATH instead of its bundled OpenSSH executable.

Bug Fixes

  * The installer no longer shows an error dialog when upgrading while
    the Windows Terminal Profile option is checked.
  * Interaction with the git repo tool was improved.

Git-2.33.0-rc1-64-bit.exe | d470001da17840f42f1cd49bee0e37d65009b318e86b9c5a36d8839f648650c6
Git-2.33.0-rc1-32-bit.exe | aba619bf53af7c54e5d6354672ece8a13f0160bf7a118d9946a885ecd24fe4ec
PortableGit-2.33.0-rc1-64-bit.7z.exe | 30fe797dec6eb345c383f59d8098d5806ec706ef9f25e52cc5e6dc492626eb71
PortableGit-2.33.0-rc1-32-bit.7z.exe | 91bc6c344505cbe8a795de8a3b50be8ec14e9bbc3d7b89289ad185507307c0c0
MinGit-2.33.0-rc1-64-bit.zip | 1f035f7c2481ef0f63ae0b38c3716aa029193dcd9ef1e1e6ea40325c7f59658d
MinGit-2.33.0-rc1-32-bit.zip | 210df801a76eb044578ff3fcf0ff67227fd15c0db37c1ab9ed84f12e83c16dc4
MinGit-2.33.0-rc1-busybox-64-bit.zip | 362e4aef9f7171f3e2c2297a0c49a4687376e1702d0b4806bb64617fbe5ebbda
MinGit-2.33.0-rc1-busybox-32-bit.zip | 04bf4028daf9f99bfdd72deaebcf46a6b8258722f7a5a531415654ac3bf944d8
Git-2.33.0-rc1-64-bit.tar.bz2 | bc94eadb85f2fb0b5da22bd4b483f38edb772178e8e66a3891b64bb08ae34cc2
Git-2.33.0-rc1-32-bit.tar.bz2 | 63f8b1f389edd0f4435bf59f5fb14eb27d5e48fb304e3a8174991f80afc221de

Ciao,
Johannes
