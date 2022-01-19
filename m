Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5F2C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 22:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbiASW65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 17:58:57 -0500
Received: from mout.gmx.net ([212.227.17.22]:36423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234447AbiASW64 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 17:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642633134;
        bh=6BAmEHlNN7nVlZ92VgCgqLyalQwsN1CPjATRzZImPok=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=X6x5xuLHk62Q+XdxTqGJ3LGhqJwVZx3THk4EFL3M7H9nMwU8QQi2zIM4p5bSJyruX
         QIOpRKmQZ9W/09HlKRJt5O2Q7hoP7vzYeUrXwUX8sxd4UqSszazFQyflkHY3ShmT7Z
         KRugDnbolgy7jIAir24cRM1d4JxRknep9DRTvt4A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az207-55.qghpr4jfzqnezg3apl5mcftwhc.gx.internal.cloudapp.net
 ([52.176.42.252]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1M2O6Y-1n9lwp3RJW-003sbR; Wed, 19 Jan 2022 23:58:54 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.35.0-rc2
Date:   Wed, 19 Jan 2022 22:58:50 +0000
Message-Id: <20220119225851.4273-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:a4phzHXPah3A3NzTKlvt1f4eJpTcQVU6mD8mCP+eutcYVPpHh/i
 Y3qlNZE1km1cMCqXu3pL+XxQFgr0Old8pJank53c/2J1jvsSjTDjeLu4+ggXobSR9qmAXcm
 1oWdSNUqSCUDKbUUqpTGzU0BNUwdXciwUUNDmKC6Y4bXVRbyxB+2W69EdxYK2oQnkIezms3
 G0hTFHwdlM3ljZNSOUMFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bi+3tkBZOD0=:0zhl0Zaxc9P2aFlmRYSNfB
 SXlDFbkckD1lfo+luOcKNQwt3f2204Xm6pBMvBZeYJ3H3ktXawvcpwnaTGA6l6gMg2EyZE+sN
 WGcuUbwmVpYXNElF9TPRiJwRHdsYc7V0mNpccoda8lCzYisd0A0yYp2shNMVc4nUEHOENNeXQ
 s0rcK3rBP8D4VzoQbP2JIjCPVIYK/JcibcPd3mrAcUOj5Uza/cHN9n53OfBNDTtzZU+AA1+GD
 IOatPdJoCuy0r86QkZ9jCdJc/VGXOisZUYSemjfzhw1ttxzPkhuroPjaHaUS2o8ClT6NDJ9RK
 3XCGKLJA2vDA2pzlhEJ0gBOB7FaNDyExfENbS38QpT/0w/+z5u3tDZcs9EsKZleod0PiibZBn
 yeZKmN7b+jNjp0KhiFb6x0N9MPdNxpvVXeTLlg9fTcw+ob3G+5J3c0aMgu+5zVbNLpKJ1gtNm
 NwSiRfIBH6naCW9GJHOKymaAHqOzDwqWdpKYgZp5OlqK7TB5JDHsiXVYcapQjjfCjmZknAab/
 Uj3Wb/1BFDNlJ6JHHDA65qqg0FdKPGNigoqjFGscO6JzNL8RFtxwrGOHWgyR2KX8vNbVDYzqW
 bglifFRxI2Q9ndZQUFqa4mHEpw/pKfbvmQYuS56MQoIEtitWAav2dhWtiKWuZB7qFNsget5BM
 Jp3uG4k8KTC1/jZRVhQTKbYP6oP0w9yaIPzPktIIRUt189l53KJh/Dc6w0pFiwLGL+roWpmtU
 9PiiMkrdnpgMxiUmCWJ1+hYpE6XM+Tl2sjf8gcfCbPunqnsToeoO3sZwgV05YIMwYn4ECEgx4
 YoLYsfW6AohyKGbXpGhNz3lZU9/OXy3IUWq1jgb7b26+iLa7OCvB0q6lKY0gSTnoCJVkNmtPZ
 BKH9mkdqFohHOYhVdr1DDTXqMD8HhGHBGmC79Omy+QixVaZW53SuTnxzOet5RG/IOc5BZHE0B
 pjrHG3b0ehQu/mPVhxn7MtIDTmcdTw8NefkWThyHnYnDXSBaGNyvM+M/V8PYkd9pnW8hCMTc+
 uEWpjwAg5D7NdMstB9JK7EodRL5fKyDXTXBiFDXS/aJkRUKl9DZqaUI7L+Aayk+X1tdgzevRW
 BtjqZVQcydNjJs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.35.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.35.0-rc2.windows.1

Changes since Git for Windows v2.34.1 (November 25th 2021)

Upcoming breaking changes

We plan to update the included bash to version 5.1 (currently 4.4) soon
after Git for Windows 2.35.0 is released. Please check your shell
scripts for potential compatibility issues.

New Features

  * Comes with Git v2.35.0-rc2.
  * Comes with a version of the MSYS2 runtime (Git for Windows flavor)
    based on Cygwin 3.3.3.
  * Comes with OpenSSL v1.1.1m.
  * Comes with Git Credential Manager Core v2.0.632.34631.
  * Comes with cURL v7.81.0.
  * Comes with tig v2.5.5.
  * Comes with patch level 4 of the MSYS2 runtime (Git for Windows
    flavor) based on Cygwin 3.3.3.

Bug Fixes

  * A bug which caused crashes when running git log with custom date
    formats in 32-bit builds was fixed.

Git-2.35.0-rc2-64-bit.exe | 506bb0197382244052d1b9a1d26347e9b23cf02b113215fb2c35d31831fab775
Git-2.35.0-rc2-32-bit.exe | e3a582543e524fb7e643f88cfe50619aad2983d76da42f4e90ac3b63129844cf
PortableGit-2.35.0-rc2-64-bit.7z.exe | ae7fe0883423dca711f8a488f4466ca63ef438fe4cd31accaef487de6c2592a8
PortableGit-2.35.0-rc2-32-bit.7z.exe | d4efee7e1b1510dc719a7a81fa420f060e5bcb6720911d579122c31a0f43be2e
MinGit-2.35.0-rc2-64-bit.zip | 5a269ce91328bdd76bfa2b8c81db59cbe7a1585735a902d1d763d6dbbab8dd46
MinGit-2.35.0-rc2-32-bit.zip | 3bcb9bc27f3a18b0b316902bdcd249b587de2b1af95b6a9bba0a57c256d8b171
MinGit-2.35.0-rc2-busybox-64-bit.zip | d98a83bd369695b88f528012a236789a9c0bf9978893664cbbee12109cbd9e7e
MinGit-2.35.0-rc2-busybox-32-bit.zip | 99fb4e4500284a395183b69d9b54ac829f95b9d163d6df52c3779066d994f162
Git-2.35.0-rc2-64-bit.tar.bz2 | a0fc21dfd6f86fa518ceef35d18905a1d2aade45830a87b59a64ce1fa4ebbf4e
Git-2.35.0-rc2-32-bit.tar.bz2 | 1fee38b64707afc6be1af1534c5261a80c8d6b78a814659cb0e130768666a8a1

Ciao,
Johannes
