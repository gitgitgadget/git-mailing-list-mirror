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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5360C433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 20:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9514664FBB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 20:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhCJT7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:59:43 -0500
Received: from mout.gmx.net ([212.227.17.21]:38183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231301AbhCJT7U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615406356;
        bh=AdnHtdKH+y6qILfzWF2J7dQ6gUeAO/95cMp5tiO7Gnc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=JtX5qclPbAVYZx9Wd05ojiDtZpRLf0M7jhsw+Entew+PMEZ2XybDNHWAUZTUh38o8
         PQ7W0DrZQKF8Yg5b8aK4qPibHLPrIy9hodIStzPtRhojSs7rPs+r1qb0JKuMYM4Nvs
         JK04I1A3fUC2vraS/ulV8S7dLIE+k74+avF40A9U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az225-425.pnudxjuhuivetef20c4tpj434f.bx.internal.cloudapp.net
 ([52.249.178.141]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1Mz9Ux-1lgZua3Hdr-00wEcf; Wed, 10 Mar 2021 20:59:16 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.31.0-rc2
Date:   Wed, 10 Mar 2021 19:59:13 +0000
Message-Id: <20210310195913.7022-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:aLNOgqBosLTNjwwBPRP+Dy3oTsUZmBE8icG1Bv7BALk3RXpLo07
 0VmG/8gHiW0mhpw9/15aAi0V7rJXo62B0yrHZsmxNSvCV1YxDzJA/kH62BykY3/APRdPc1Z
 H0CcRAbIqrajGX3RvMsdCEY/plyOfztpmOIvPjs0VdLxlZV9xK0ThfYmhvySUSQlnnv2LIo
 nQ7ScUHfpaSbqRhswgpdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d+BIMs4/n0Y=:PHqb5e52Vx8XKlhkOUSVp4
 ad973daSfInr77+cl8z3MAbawzXRjRbOS10RJWCfct31nkzwFe7WMRHfsogD6hk/cNAufF2vq
 rIA5P7qTDx+ZeDAtH8BeVcOlTKoqbj9AUYQo+3f/h/GtSzGVLTUzyIXOL0ma39C3Ue7eJNRXA
 eh8YLQ+Jth8or9WDeaAG5ohUAcJyzFzfjF3ND7dd926Y2tGJLfHkyRikH/MiHldcUGPE7Hu+G
 E1iGLhV0qKwkpLxK6BE5uWhSxQ8bl3GXAXVY16UxhZ1OA8Ldr17w2FmWVQ7sUc/lNiNtc2+no
 VljNZ86vXfMCsFmpIpq+xmem8O2dwZUYIPqHUEkgoIy20xHsPEExtLF/M2ycEC/+CxeRbdIF7
 Ek+uBfx1F+EEk0HrE43k1M8pJPeDOVfwNTVlp/9GYF5S4IxfD/rjgYOx/8G2/TSD0qzQaDLXw
 AM248g8i+v6rmKZbQyfqNHnawyq4Advw8EhhNjmFwmxnNjKm1wO1z9W3u/2g0xI88Bv09uNB5
 dZR0BR5k3UnOsnsz/AsGZ89RMGnNoXZbTHANnv+D0yXV8Lxcnu90+1wovcRhs1d+dQavGhTHJ
 sz5U4/tL+7IBK1dvpxr6T+e6iSGsCZ9UFOykBh4AHaS47yuojP0PszbIt7xaXGJ3ZnwzRwdUS
 VResqxPSxAJaRWejBBzncSlFxw4K/LxT7SHb0zlemH+rBnwhiw1i4FsH4v/hE0LZhmkhwrHDv
 zlY5snvbwJaeXWjwYDBADQPNOTP0b0XEnLWjDM6thZP4h7xIfxUV6u6qyMgslbaNfirGgw5Ha
 Hl8jJ+7O87f/qS0uVJxvj9ILNepf6LgpVPu0nWJV8IDPIJ7kPyJ3F6WYuokFE+NghcM/feC5E
 mNPn5XiVDGkEWv4kw2+rSDuX2Y4m9dX5x0M9ieXAI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.31.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.31.0-rc2.windows.1

Changes since Git for Windows v2.30.2 (March 9th 2021)

New Features

  * Comes with Git v2.31.0-rc2.
  * Comes with OpenSSH v8.5p1.
  * Comes with tig v2.5.3.
  * Git for Windows now ships with an experimental built-in file-system
    monitor, without the need to install Watchman and setting
    core.fsmonitor. It can be turned on by setting both
    feature.manyFiles=true and feature.experimental=true (or directly,
    via core.useBuiltinFSMonitor=true).
  * Comes with Git Credential Manager Core v2.0.394.50751.

Git-2.31.0-rc2-64-bit.exe | 83c836e53d283cc930aee72b709d64747875a7f128a30b77cfb2776023166409
Git-2.31.0-rc2-32-bit.exe | c54d12db288d071348e23665b1a52e94d7b0be3b4f547a17b1ed4c64bbf5120f
PortableGit-2.31.0-rc2-64-bit.7z.exe | 89aede2d9b8931d7b6e5c4cdff4cdeef0784ee01b85b41f742c74d35fc1aedb8
PortableGit-2.31.0-rc2-32-bit.7z.exe | 2e38d508d5099da021ff612408e66c2508e074d67e98636b3afe2181f2c1772b
MinGit-2.31.0-rc2-64-bit.zip | c9b22aa14003687bb53d43b12c9139d6365ca2aeebb509e66b9a724ef1d89c34
MinGit-2.31.0-rc2-32-bit.zip | a43c977b91f90cc606ef33899483020854b6424dc79c0f35372fcf4b8ad2f414
MinGit-2.31.0-rc2-busybox-64-bit.zip | a497a9694a5b395691386f1c7ab91b725a742908bfaca239b725e0404e122ba6
MinGit-2.31.0-rc2-busybox-32-bit.zip | 056521d281d7efcc945d3b52602df659dceac95841560e28e94275fbef995a77
Git-2.31.0-rc2-64-bit.tar.bz2 | f0e5aee5409f78c31b659a31cfe40881bce545e12d52d82bc149f636bb387bf2
Git-2.31.0-rc2-32-bit.tar.bz2 | 1ff79b87a0f951dfcf901cdb2db1426fc720ad87de94d065edd499111d91f423

Ciao,
Johannes
