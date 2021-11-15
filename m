Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69801C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DEF6619EA
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbhKPA1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:27:31 -0500
Received: from mout.gmx.net ([212.227.15.19]:55089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344046AbhKOT4q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 14:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637006018;
        bh=k7A+1AQQG6/2DJ6jWW8QsBvxrZwpKOEWuZEiYZGbMtA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=AN/1REq0fbrXbr1NnP96tJaCdiVIefzH2YH1n32j1siGiwIgvNhZq8XNp57cKfeg0
         7hXJ82D9l9sQ8NJqHAXaDoOfiHnEiYw4M3yNc46A0T59NsccZjTwWIWv1sl/iAbpdc
         iK4/MGQvmH822YlfuR/hik4/CeTSnc0Oi71DeGL8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az120-916.oan0u4t4stqe3iorma5cd0znih.bx.internal.cloudapp.net
 ([13.90.82.220]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1Ma20k-1n9pTx3Rbg-00Vu0o; Mon, 15 Nov 2021 20:53:38 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.34.0
Date:   Mon, 15 Nov 2021 19:53:34 +0000
Message-Id: <20211115195335.5290-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.33.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:wJ8UKjN4Nz6NHFZLsbsY5QxuB+aZpRyrSEjCQSnwqlNelvXs8t6
 KY9TiQP1tYfgvyKWqES3v8dM+kG09OaiwgbI26232MU/yyp1yjmh3T83g+R1Xz3pK6cd4y6
 sOMoAvFk9lC7FxNIBhbZC4nWeT/BgROISkfHqvV/KN05Hxi9YzveUEtJEEyA8r03BvYAJ2e
 fQOqgOG75ysGVjSMt7Pbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cWDMgpXZyzY=:ZkIZV1MLSV20p/iruXpC/u
 9Sq0n1ajUoD3alo8Xy4+yrtEmvaNG1ESngWhjwx5Iex+iLMPXOTcZskwjJzNPJliMNpMH7E+W
 4c/ED2EsadGTyqg0yqUh88MlAeBpXj3xqwHAg0yQuBKPgWgxMmIRIpgfjqXVdmixVFMVpyEfz
 FrLueN5H2vb0u68RnIklQ4mvDiUgkX2b1eyHmoBW9K1NyuaLYQ2BoybWEKIUOU1uxUli+0Plt
 8mSp2DMUfQu6VGxySnaamC/wPaQoEMWQwQn6m8U7gbd+M6r44T19b8PSjNEgRrwDsvb0KfUSn
 KYVV6ec3UU3TEFlzrM2xuneqtWg3yIgsmdDnchgaQ9UmscA9J5P+MclLeADzSdD3CYzgLm07B
 2v+gW0yZMmK6ArqMhMVLdjPPdu42Wm3C78FDeTje0Gsb+N1+fQYkfsROxj1VVbsI7K66/7m3b
 e4Ko6qkz+vev0Ijn7sEbSli32MRgjRGgTm8FRw9qephppSheUQV4aF+yqoWg09i7rClYeMUyT
 36w6Vpb4AERotV/ct/1pL3ZoTuzy3fSFMTOAzMFBKsdOi2xqSVPz/tO3uoxSMt2wPSknNsICl
 dNTbvu3uPHyZqek8QytLqY96OnO2pxAQx4qEvd3PME0LzeAR0KKD0GbpmaGx2h0rmTrlBvJWA
 DoygLOVz7xrI+6a1eKSY2epWhk5+Tr/ljpnjqyx+O+kCvbhm/3yuGN116rAmkFiPkNGoSoUv6
 B0pFpvsFdO7JnlumTqKhoCRYmy34Rp6vGGQsIKQJOApaT0uSr2eqLBsekArxTIh15JJRAHl1a
 riqF8DkTPT81r2Z65pkpQolZ7V+W/z8+DV3gwktFLujhrIf+Spkn9ZZxaSgtPTl/6h5Gt1LDd
 9Vt8bEbCE9vME2kpOvMj4xfxYQ3LCCZXhmTURdxsALQZeMWkR3JQ9nEuHA1NcmEPpOIZwIUHB
 7Os+o/qHlN+TXisMrF6gNhL2Y0eNzgv6z1qAMaVgWdYJ95Eocybzdea9VNizcqHuH3fguHacY
 3vLBu6uxNEff+VpzJFwJE2FRu0SCQf98JkeizmpM1aMloTVJDfyGE6Lg35JlhrPyYd1AuLHEM
 gXrNy0bobvSroc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.34.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.33.1 (October 13th 2021)

New Features

  * Comes with Git v2.34.0.
  * Config settings referring to paths relative to where Git is
    installed now have to be marked via %(prefix)/ instead of the
    now-deprecated leading slash.
  * Comes with Git LFS v3.0.2.
  * Contains new, experimental support for core.fsyncObjectFiles=batch.

Bug Fixes

  * Configuring a system-wide VS Code as Git's editor was broken, which
    has been fixed.
  * It is now possible to clone files larger than 4GB as long as they
    are transferred via Git LFS.
  * Git now works around an issue with vi and incorrect line breaks in
    the Windows Terminal.

Git-2.34.0-64-bit.exe | 2a833d15f97539e845b3883e375a8a152e8199b63ac345282d80f834f7d6a9b6
Git-2.34.0-32-bit.exe | e665d6d2e454bfe2a9172e326becf00a8d82d0de080cebdae4218d1727b1897e
PortableGit-2.34.0-64-bit.7z.exe | 12f6aed40fdf2d409dc61d5d1626eed97b0e818549d92626bfffdd7bc580855c
PortableGit-2.34.0-32-bit.7z.exe | 46643dde0f40bee6e7963b9d67ec2f78ffc6882d452b866940e5fe5724dbdba3
MinGit-2.34.0-64-bit.zip | e53818f68308a8f7988f37e2b56f4e8da2aa93b279b6a70c87a21972c7c4ab93
MinGit-2.34.0-32-bit.zip | a8b68a86e999e5c6caf0bf79a92a20631c6b3d9c90404db49f27ed2244d3cb11
MinGit-2.34.0-busybox-64-bit.zip | 5812ef40a0f03f917128f3b4866a7d463932b7f0b2744ac901f00c6434eedce2
MinGit-2.34.0-busybox-32-bit.zip | bfbd5c5dc95d094616f40bd3d27833434b5c3d5dc8a5f3285236b50f6eee93d7
Git-2.34.0-64-bit.tar.bz2 | dcbfd2b24c321973bbd7e27ef841be07749668a0a75c3fad1ddec933154d85d6
Git-2.34.0-32-bit.tar.bz2 | 1b1961c9875edf35aca188e5182b80b1b6d0adae50c01f99f314b83c0062fdc5

Ciao,
Johannes
