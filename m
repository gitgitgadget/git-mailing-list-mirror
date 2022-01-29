Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6A0C433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 07:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343747AbiA2H7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 02:59:32 -0500
Received: from mout.gmx.net ([212.227.17.21]:32903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241942AbiA2H7a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 02:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643443168;
        bh=ktA2F3wPFRz0fTr4R8pUmH0WOmJo7htNjmmsxznzU/g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=RSSoZx+VUZdGqh8X3v7eIM1eizy7LTx1topQ4EnKC2nIyTcNz6PRMwis19m6LPiV4
         088EzjjT0ToXbw7j5HRfmurSDAPFvuee4bfAqQ1kn4PTvxrv+qGq7kKHW2BggX/MAU
         sufvcWOSRNfd+KK1BntnStFIpzcn9KJM3m8rT6Xs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az71-976.54gadnqkfkfezo4rfhga4mummb.dx.internal.cloudapp.net
 ([168.62.215.17]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MKsj7-1mxRCs3v6D-00LGjD; Sat, 29 Jan 2022 08:59:28 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.35.1
Date:   Sat, 29 Jan 2022 07:59:24 +0000
Message-Id: <20220129075924.4980-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:nH3X7ttRGpF9RaX6TpfAgC2xdKL5kZr1atl9PAt8+S+IoKn/eG4
 mXzjL9JNB8jRAx22nSc1RVuYQi3YjMgHt8DUZs6lN93wIHauz94uxAAXtoS5yUcQn7j6vSj
 L6e+FLynr86sWJzng05IiJMe2dIETZr1b6jSAcwa5fjpK4nXNK1Em92CmMkIX7B0Hh/mJ1W
 HBRM7UjkkN3pwpIAqTVkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WhoDpx4Ei/M=:rN0vdwfYQz1b2UMBvchjFX
 dfAjjIb5lN1vtLFJhURrMi4mIxr2m32667udV8yDVTEWjvne4v/8qga/Cg/LqeZnklYuSn5AI
 tQGYDIxsZXhydw7QMgduTh00ECUGArxPvQdEHu3ONPtXBejE3Lr3fEbWDgPpTdwtMzy0Fi93y
 Qz8fxCUbJZw3hANAf/YKMsAe/64pogh+BgmYsI3uWX65aoMxX+gkKo8qGQ73bhtN1y8JQnCCO
 hDDFgyWBKuNdPUdpZtyb5INvkuBUnpYIBgO0wMywbTJEoGg9UKJvyX5DDtWe87nL4qhrX15Yi
 L5BooPLMq/USxJnAeF7L9MIaeHFqtXgr/Z3pyOyBqha0HeG546OeJNynabhxdiPLQuW3TB4NE
 7ZkxuI13oA4IxnNFGsOYq2Ly0FAOVa5fXmlFnKd+drGRiGLtRqWV3jTrlTqt0DQCBmG3UyAJU
 IvPjMrBhy73vRZecfKCIjRdLKgbBmBT1rNADdR8ZGlOLBIv7jyi6oXks2sdeo/DlTH6poNV+6
 Bhk2GJ88bgdy70umOADTHWP0CA6wq+esCI11RbsBdqScWLeoj5+opIdXtY4xuxkZMxfatE4nm
 fquOEuNC77hwkOUcS1TqlOxIgcJkZT40a6Mab97GL0GJ2G4SADUnPCW+rgiaM9H7hToQZFRIb
 Mo75yPb7eCes4jMX6P7AHQ/DeLWgcTToGtlLc0C93bPcEIILPnW3jShjYETcd4Q54vZuGQdt2
 uc18r5X9A1KsDdHInIx6AKz2mGSruWrSTne0kKpCZsGdcLCuEtIZKOgL7upAWX1Odl8nJQipr
 8iHsrK/9/Y0Siaatk8aQ9X0EdiWhjTy+3x3vUodY7b8UYqQ+rooIV9EJGaKPrm9aNA9gZmaGm
 08Sl3kZhF6Z0dHILZ83VxBhPZ0fMFSg2pzykkPOnFhXoh7kE4vG46lP36qTP0LI313h6e91cO
 c0yPwjs9D/yjoZ+bxsvI4CMbetdVvR9b8POTP6W/4dR1oX7HeVXjIBNhl+YdlUP92YkxSLrIx
 Yio3J9zK5+kqZ2dO91RaeWZQ9p2Akvk4N4bj2XlCuYM9/6i1dk1l1yW1C5J+Qp3v9U1Ry5Mf4
 xWSD47sJjtVUsA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.35.1 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.35.0 (January 24th 2022)

New Features

  * Comes with Git v2.35.1.

Git-2.35.1-64-bit.exe | 5d66948e7ada0ab184b2745fdf6e11843443a97655891c3c6268b5985b88bf4f
Git-2.35.1-32-bit.exe | 5e45b1226b106dd241de0be0b350052afe53bd61dce80ac6044600dc85fbfa0b
PortableGit-2.35.1-64-bit.7z.exe | fe70498dbeee9b3616d9c2a9766279362efdc030dd5ae0c9882f090efdf3d04d
PortableGit-2.35.1-32-bit.7z.exe | f4b945cf9ee74106673fcc712ef4e92285d2ceca8b81c7d9bfe86eda1f00db9e
MinGit-2.35.1-64-bit.zip | 4c0e24b27c425282afc1755b518cd876833efcd07765be04c383af9e365a221a
MinGit-2.35.1-32-bit.zip | 134c2c5c74f3dcf68ba940b20a631f4153ce89ea2ba5974f93a839f0ab3cb9d0
MinGit-2.35.1-busybox-64-bit.zip | 36f5693228a177bf0aec00085f44a7014dae8b47a4ea20867ca24857a4a0a070
MinGit-2.35.1-busybox-32-bit.zip | 9dc2093dd30c1d404baca1604f1fb50ed977e3e0ce65943ff2a5c956c6d4fadf
Git-2.35.1-64-bit.tar.bz2 | a8dafe3ed839494e8b71212c1027830aa8d6f2f04365f4e523888f793f8e3fd5
Git-2.35.1-32-bit.tar.bz2 | 57b063b1db2d99836330043527137b5db8f63a29ef8845480dd9a3908f555f92

Ciao,
Johannes
