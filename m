Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5CBC4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 16:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA92760C40
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 16:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhHLQLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 12:11:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:57159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhHLQLP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 12:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628784648;
        bh=qHJOFfiBe0zDKgzu0GnH9teUfFbdO/5ygWXYV0/NKUU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=DrKYURbaO5Fd6P7VZWUarTWKoCn7XYw3enlNdzBCZc2PT4M8jsY+n2emTJxAZsUK0
         LjC6fHs9N7OmYeZTMcwZPOHBvsRRLnJ3Ey3U97OvApGj5mSaD32XaMBlYkDozCseF0
         x/aEU3ESNZ8PcM+0kf27W0QUb0887GQwY3GSvHHo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az130-550.jopw5mwjxage1n2fsbb4uktgcg.xx.internal.cloudapp.net
 ([13.77.152.230]) by mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1Mw9QC-1n3z480mCS-00s5BU; Thu, 12 Aug 2021 18:10:48 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.33.0-rc2
Date:   Thu, 12 Aug 2021 16:10:44 +0000
Message-Id: <20210812161044.4739-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:gQQgsuxW7KBdbOCrLsKCl18/ayI8sjPbUL8r3DmTW8Tsjv2H0GV
 jmPIyS44E+tn1Nat5OIj9xUXORcm3hvJ3Sd43QIe7tCIVlNyEYorMHnXBw0MIAsYEp9wEjt
 l7v1TFCrInFsdXkOeb1iWTm0iE19hkvUBWeA7Zd9uAX0+CX79EDY9yif8oDY0TaCtgXfNNM
 7N8m5vhEfzdEmeUuOdBPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lXPiopT1tBo=:0wn4BdPdGXUdauZCLP3bpM
 9xdEu7KWCcmC9QpB/eULbDzZN/j4qefF/SpI/NOB3+eT/wT7KuNDds+pjfwsG/noOP2c7lW5l
 TdgV3CAl1GwY8+8y7SwPIX+oEzMefj+cYz5e+69Qm5TDErpRyeyvb++7RxX2uYT9kuQnb0cxX
 C9dOCK6Nbj/1jK4TGQGVqxGASDVOlL89qYuBBAZsx5Ho2EYoc0OtMtyjNkmX9k9MM9p6zqxAu
 khJjP4ZmjK37hSRn4YeRsXa6e1qLhWHMv0IqfOjYcP1TF9nLVe6v+FxLzAoa+UxAvCKtc9+Km
 C29mGgACMl4rYm9SW/h2vv0PTABSn16FHEDW/VfqlhgWu4U89S7Z6kVzmYXGbcYmkNute580q
 76FSff/lyx/W+RkL/mMbEeWNOwIxmOFkQvImrID2OpZBBRd7bSstm+tJikniPpNPTOse5nNbC
 1On11nYw5QwQw567yl4q7fxq674dxUksYpvfzNnTr5yB5Tc+uWv5vQJ9ebsqUw5frbC6ernh1
 gqksmTBbwELTJIKW7ZQwoPnfx61giPwfAkdWkQuANHveo+AN0+LJziZSEMoTsVfgqDsqOoxY9
 o1eb79dUXCdIJYFp/yQLIVLPyT/pTySFLZwC155Ij2tMsApAeUcN1y1jpN+XgroSv2pIHoT7I
 CeQA459AbyOvqca3rlLDfBLhFV5Bv2eGl9m4zMxcQqEcESAJcF2zdIDWI/pQf5xqxl55OU1Bj
 MJC9Z+sBWwGng1TxLbi2YC3YbfNivMSN2PXmxTxF7UxAD4JouPsIegF0yZxkyEKk+uZm88GhZ
 o5xKcQwyobSw59kx0i280x07rDpen/kjxaU+Y4sYGiRmiO8sAytbUgDin63mjN9sREH1AxSy2
 oWXO//j1W3aGAdmAwhOHqVjCgHwpTHyxPJ4BbfMf4dTxrotINSd4p9c3X8HkuZh1trq4R3UfH
 mweziRq6xp4YVd6QDkrbW1IOvnDDgyS9dqP/lj3GQJtWr7M5hUGLnMadKCCFRE+j32CuC6OdD
 5Y9MUiKKLm8TVmqtCkX5vgFLDCymTmpnWtDJyF/S0lyUvXjMAnSgBVtF2K+nDyRO69uZufUHn
 us7afPae5NZ81g18DCyHlDjv1OTROzw4X/pFXl3Z4/Y4Uck5z1QA4ePRw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.33.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.33.0-rc2.windows.1

Changes since Git for Windows v2.32.0(2) (July 6th 2021)

New Features

  * Comes with Git v2.33.0-rc2.
  * Comes with Perl v5.34.0 (and some updated Perl modules).
  * It is now possible to ask Git for Windows to use an SSH found on
    the PATH instead of its bundled OpenSSH executable.
  * Comes with Git Credential Manager Core v2.0.498.54650.
  * The experimental FSMonitor patches were replaced with a newer
    version.

Bug Fixes

  * The installer no longer shows an error dialog when upgrading while
    the Windows Terminal Profile option is checked.
  * Interaction with the git repo tool was improved.

Git-2.33.0-rc2-64-bit.exe | aa71ae664f4ce9221ef1102c8499552d9bc59c14680090e208142fb18c7a4093
Git-2.33.0-rc2-32-bit.exe | 8d61c7d002f19ac47d89abd3ad572af61aff26c8fc97f2957ce336b0e5b8e3f5
PortableGit-2.33.0-rc2-64-bit.7z.exe | 1b12bbfdf3dcbe4d464fab3026d08abd9c4309024b1ffc6343821ee612563707
PortableGit-2.33.0-rc2-32-bit.7z.exe | b4b8f64fec11071e85f73b34c4c6fb057995f8a9bac2945d48f7690067cd9af6
MinGit-2.33.0-rc2-64-bit.zip | 2749791cd2077773a44f3b8cba9fb90a73ec4f20893b1bb633af2bff2553028b
MinGit-2.33.0-rc2-32-bit.zip | b613c4cbb27dff4055431bc5aba5dcf3c7c4cdec7f9cd09ab1592d5355ac483f
MinGit-2.33.0-rc2-busybox-64-bit.zip | 17569916e3140bbee644461988f97641b90f2585aa9218a07a8f285f617ba5bf
MinGit-2.33.0-rc2-busybox-32-bit.zip | 0360379ce1d6b52fac812f28e07884cf3c7c330bc288a0ecaf7da1ad8192a74b
Git-2.33.0-rc2-64-bit.tar.bz2 | 6860e4e3061498b6c6a75d1a0055a0f99856b437745c594999f0ea2b2cf8e9be
Git-2.33.0-rc2-32-bit.tar.bz2 | 325b37ff1f8021ccb78b5ce07679c01677689bf8044d17370707f933ebf747a2

Ciao,
Johannes
