Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91ADC433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 21:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiFVV4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 17:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiFVV40 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 17:56:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B173B3FB
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655934982;
        bh=drF9SMkJ+MuQu8QGSblyEx2UKQzYk0q1DK2wB7Wol4M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=QlVJqnbHl/lobS5RrFMhXsheI5gG0bBNyt6P4vxp8Es0yDW0g8RoCxb/WDRleQmue
         DckbZ1TkiIwlMveceRJCdAaiyISPTAi9xKy+hu/VKCoZJUtaz/rm6G3Sh9wCIZU5aW
         YYrdtY1GU14WbP77/Wbg0Rp4Vu612+VjCxkfe+dE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az48-285.y11my21s2nfuzmiq0sccgy5und.cx.internal.cloudapp.net
 ([20.242.117.47]) by mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MlNtF-1nP4Yq49Az-00lmVb; Wed, 22 Jun 2022 23:56:22 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.37.0-rc2
Date:   Wed, 22 Jun 2022 21:56:19 +0000
Message-Id: <20220622215619.4073-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.36.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:1oXbTLjNFe4VryfBb28od6IVCdUscc0ktRy5TbppANeLLrmlndr
 1RxXmtoQwvJ1+FpoCn3Gh6rExl6NEWd6Qt4nz8zKQNOy6EvnqkQ5U+qDGQQqX5jPrR0QF27
 zqEvRTI5HbJd8JYk/ZQfoV5x7bZq9CSFh6RIWzt3IQ/qNRVWaG/Vi52z8COopijRVLEe097
 qHQLTsSaR7OBVB37FsGGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4g1oHVUFN9Y=:pcrmIKGOi7NA2PJ210Tmad
 MH6i61WVyqmSmENPfYI6yI5AbwbYKsDVnC08hv3Ch4glwi18Ply4TeqQUHzCwxn/5mwKAhFyK
 d3pjNf+W4sqaE+ELTgWbDWeYDd7XaZIF5weq794ygH+lWWea72QVdyd8U2nV/gDHI+GlxqOMj
 OHezYJnRLEDxeTKpC/SMbgJ4JZRARwitGrg58FOP9DUWQjXEJPRh3jHLFcB2FxgmxHu5X4pCy
 1G/5JnXzP/3oyWAruAhrdwHjtJ0wnCEgkgGe+S1uQbXeS4ff2feoWUQU0kXDgPXqAKq6QM74O
 fN+No8yjSIYAvRFN0cOiY57ur153zFvMaDXlqCSqoP4Jzf87LfnDES0ErG53hynANqgV3+TtR
 b23oj9l42Zo7UiL1QRiAkx4n2UiUn7wo+J7s9jA2YRhqo1odhfmb8FV6oLTy22GK+DRDPS0Rs
 JELnZWz2OsHDIfNGUdb5/T83aDLWGixmS4NZmdPUR7BTIHqFcCEexTOLLRuZymoJK2W9Cjxwy
 +KtfFfkzrGA5MT6qRRgzC0fLTxxx49Kvf6eKy4O8tvSQfIrz7af9qXKtkR07GqOSJZe+IkOLx
 mUpDYXgwrZ8fa+y7ayqxJNheKt60NSRSTypkIGM9hjvBFA1CT+jNiJCgxOZqGqv+N2U35wG8g
 Tw0XSz10UZrUn3uz0gK02VEVSoM8ihzSN79fg+yGJD1sLHpRUhl6OXbV9rI0uDbXesii72KJt
 82MpMIqh/gFXv61zcjPxDMoiWoxbU5lUvLSpbIuS8fYTqImJvRfIjsWbplQY53UgUJeyE+s8+
 HQEZz9hXDXMFQcjWL0NnYeYutnhKbuuSsVcCJNEc6uufg7P7Xq0arTVwk9oCuYnwKwD2u9Em8
 xoueqUk7N+nboVfZcMTblfFvWEaXqdjAmFlIjwxNSsYcnwq+B5wYSWuZvCrmFxGP8CQrXRC/S
 WC8YggPAMjXaS2ZkcD0NK6jQNeACoIGbScNxU7M6m+P3x01k/1QWzJx4EfxRuecYqB2XMtjTO
 9OzLRLkb6+hIOYbYzPI+6NVOQd72/57NVoq0KhtCnSfue40seEvcMF4s00aT9Mt2oSocji0Lr
 D7OPYmgjYjWLSqrF8nPhiGYbxb822t99mHu6edXzsuTmC08rP0Af2TWfw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.37.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.37.0-rc2.windows.1

Changes since Git for Windows v2.36.1 (May 9th 2022)

New Features

  * Comes with Git v2.37.0-rc2.
  * Comes with cURL v7.83.1.
  * Many anti-malware products seem to have problems with our MSYS2
    runtime, leading to problems running e.g. git subtree. We added a
    workaround that hopefully helps in most of these scenarios.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.3.5.
  * Comes with PCRE2 v10.40.
  * Comes with Git LFS v3.2.0.
  * Comes with GNU TLS v3.7.6.
  * SSH's CBC ciphers, which were re-enabled in 2017 to better support
    Azure Repos have again been disabled by default because Azure Repos
    does not require them any longer.
  * Comes with OpenSSL v1.1.1p.
  * Comes with Git Credential Manager Core v2.0.779.

Bug Fixes

  * The Git for Windows-only --show-ignored-directory option of git
    status, which was deprecated a long time ago, was finally removed.
  * A crash when running Git for Windows in Wine was fixed.

Git-2.37.0-rc2-64-bit.exe | f97e5288ef8386b25d24d14bbd3ed88b84d3d0d035dca0a1f7bc3c12faa31b49
Git-2.37.0-rc2-32-bit.exe | 1fc4c16bd43e44b21d71822c1cb5c180c9e1c09040dac54edcd33ab510e74d98
PortableGit-2.37.0-rc2-64-bit.7z.exe | c6a9391d926dbddaa20f5197abff780f989e3edd01a07f7cbdd25fe51495af62
PortableGit-2.37.0-rc2-32-bit.7z.exe | 369fc6bd4ddda7ecd6732be01bb81c4d80cedd0de53184f090b82139d4135ce9
MinGit-2.37.0-rc2-64-bit.zip | e7d71cdc098f08fcb3914677430b80e26693bc077afa5462700f3263407dbf04
MinGit-2.37.0-rc2-32-bit.zip | 7824db6c937a63e28db20ddaf414b6471a1c6aaa7ceea9ca8f23047a63cf1303
MinGit-2.37.0-rc2-busybox-64-bit.zip | d7e8a0b6f95dd278296647d4504661b55a731aefe12150d6780712c350e436d4
MinGit-2.37.0-rc2-busybox-32-bit.zip | 187b44044645a346e57de0501d6ebc1097393e6c212e5ba5f2b58a86416613fd
Git-2.37.0-rc2-64-bit.tar.bz2 | 56486cd180bc0aef1019ef6f5839f435f74083bc51a0c332df87f537347be82d
Git-2.37.0-rc2-32-bit.tar.bz2 | f0eb95ed57c26c0081bad9c1e279cb8d682759a689535d92f95a1a63efcc206e

Ciao,
Johannes
