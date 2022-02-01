Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053ACC433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 16:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbiBAQot (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 11:44:49 -0500
Received: from mout.gmx.net ([212.227.15.15]:44889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241188AbiBAQos (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 11:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643733886;
        bh=eZxAjprX9DZxrcWl1c3SdI0WMLPRw6RU1ZEf5Zf83eo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ByPEZ92nj3MsOgkhp6mE32DWNx3ZvuyHAzQ3UqqhB2HymQFka6PCDRqI2SKVsB9Up
         Ai0yPb6DTkn7usDtFNSEstKpZ8XkhjUErvILsajjnfGhgz+UD5M3pcoSKyjqvxdMkn
         kheAmGsNUhKegoa3zE3ODxHjzAO7RfZUPWDuqsV8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az30-552.0unkxdino51e5fmf2tnbwhsmqg.dx.internal.cloudapp.net
 ([13.91.104.98]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MiJV6-1md9H11iSc-00fRzF; Tue, 01 Feb 2022 17:44:45 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.35.1(2)
Date:   Tue,  1 Feb 2022 16:44:41 +0000
Message-Id: <20220201164441.4952-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:H9CObi3ui3qJydrMDccd238oBFurOrI8TWR3bxmRA79ag2YlUtB
 I0jh4fjpLrLMVDprsWTg75thNneK7nSJI4+kd5umIEPDJ5KNbEOjzWH62jgXbnPuOyoLzUC
 TuGc9xRH98W7qwSXWj1ARTxLroh0as+3uqXVFFbYji99yO2yU/Lo6AlNvGPiEcLl6sRk4+Q
 8fmQtHRJYTqLOHL6pWliA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i9IOQoCLN/g=:LDVKTBNb8AezGSQ1rD0gM4
 A3Oj2Z3UmI1S4iM+RiYWAK9GsNj38cN0g2KrNHLDoJDKfnrDsBEicT6RrxRm79r1wOS7YUW+G
 3Cq8283hex62GIJ1J3DKckp1V9bQ9FHOVKtB1qKrZDmGm/62ITGT3/sF+A6di6uHROBqhc2kR
 Bes6RtB/F2545uW4+fL6bZ2amH2Rkd3L+JvP1CvqrUyVMKfPtnfMBG4AyoIcNClgggyGZQBLm
 tS1TQHBYx7pVcm+hEBoaUUTsovBbCdiG7hxpfYjw9qJZ3Ya+cGN7rQS2AzI+gPZl/x11+YHuP
 7w7GAhA0KqaoX1vs2iWmyzTs4qzDChzxz1clp8QnohuGXQ1pw0bJhkwCZ0WvK6O6hXSU5gc1y
 I3qGMsIjwZCoj/AyYKEFTIG/Ezp9zqFGQtoEwqgLl5r9nF/f+bYoMkGfnzt0ODHWjfty0mIEA
 GY/htzvkVfAjtdRxCZnJldTB/PLKZcOYUc1vXRdsdvuHkZOHgzzvkkNY7M7EEkDS3rUTxKWHq
 Tn7Po4YYg7j0anFK6cuyDPAzRf7NMdDKh8sXpWqGW8dRAyZpzW5W1qipOp6aZ6LX+hbPta6py
 R/nD6Qcj0H9zupOxq9g2VLMj0+qV7TQtWxHjM3rt4izBmuSFFGThO2YktmtQ1udmcFzviDG9O
 lDU5W+b6hSI0wGS6QCA8OeJeesI3eYty6XmB27hWRAjStOZbfQqWDnRBVgqUYT/6SAe1bAjg1
 /QX3RcsWrbWjzGE4wwThHx3Q+CTLTgFDAAEslysQBb7ctSAvof72PWsW4HiPz9rPeng4zIJU6
 1QllNlmD892ovT9wzXVXA3Znxxpd0m7T/uZPlkQEY6HnQHGQck0QLb/ebs4m/cIhhgdtL3jFG
 we/xjdwvlkeeqovup4xgLyEFlUAkBWgdhr2h7DU1LIMT+yACwJFIr1ZT9frdyzIWLGdhvkbf5
 4M+olYcZ7ty2syleh6BDCFaThr1m4qXL0Vg106bQjWGyFCdU8BJHrS05kwnJp1xK71lpuiYWg
 fHwRVSrgjJLIlgNalrkn9YMkm5/Q44rroClB6IUZqbe52lxMbLz9VurvBVC8EOwsp/NUp0ZC6
 z8I6C4DqjC2ohc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.35.1(2) is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.35.1 (January 29th 2022)

Bug Fixes

  * A bug in FSCache that triggered by a patch that made it into Git
    for Windows v2.35.0 was fixed.

Git-2.35.1.2-64-bit.exe | 77768d0d1b01e84e8570d54264be87194aa424ec7e527883280b9da9761f0a2a
Git-2.35.1.2-32-bit.exe | b5394b97899b0d1c4857f63b7ad6f6a7108f30ca7433ff338ccd57e7c3152336
PortableGit-2.35.1.2-64-bit.7z.exe | c346a4888525de88a6391ec3640013532d0954910bc78950f07e850cacade245
PortableGit-2.35.1.2-32-bit.7z.exe | 93f4a28a423250fff64b16f5c068a143d0f35100d055416c05609f1e890bf92d
MinGit-2.35.1.2-64-bit.zip | e48a78b1b0b6ddbddb539e9ab2d9d99494e2859b6f2113bdb3a8303c00e8d1a4
MinGit-2.35.1.2-32-bit.zip | 9ca4d38e3ee8b0eb830a17ec9379444155719d6cb1d3d4fe37e4c2b5991c920d
MinGit-2.35.1.2-busybox-64-bit.zip | aad8fe5975cb94bb550efbb0b4b696388de1d078296e1f31c268d144f6a6b0ea
MinGit-2.35.1.2-busybox-32-bit.zip | 6f80172dc7f22f4e028024dd3ec6a2ecc0178363f79a7006d3322b05bb6a8143
Git-2.35.1.2-64-bit.tar.bz2 | ec1b015003f54e467eb50664b8b675b871b3258e81ad6e1a0d680966a8e3ad5a
Git-2.35.1.2-32-bit.tar.bz2 | c07568acc519bd0082d16642b6e3dd6c5f87824a68b3cd50fb89b54f06c1732d

Ciao,
Johannes
