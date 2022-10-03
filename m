Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434FDC433F5
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 18:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiJCSue (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 14:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiJCSuc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 14:50:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A1D17042
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 11:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664823027;
        bh=ootcN/Hrl2iwOPUY2SsRVhGC6upzKs2UTg99YGCn8Q8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Ohzg+TAB2KZJmOLgPe78ZiJdIQu4/3y7Zdg4cLQx93hZg2DC+9I7j3lD+RZVQ9pRV
         VsCGB0OFWDfDFCiobsI0xJC0QjqLpYVuzQDwnRaUjgrH/uuNp2wbBBzz+x84fTyS54
         4fw31LDyy1aIwg5Lgrv9xZM4x9Dxl7A3pKjsBqG4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az100-190.zviwil4qdwoendrqhv2fymrnfh.bx.internal.cloudapp.net
 ([20.172.214.74]) by mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MgesQ-1p9GYh0pie-00h8KS; Mon, 03 Oct 2022 20:50:27 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.38.0
Date:   Mon,  3 Oct 2022 18:50:24 +0000
Message-Id: <20221003185025.4693-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:0Odrgct7oqFs88IsIvrEbuzjMVkWNQZtgtreUfxAHoFuX44Gsi9
 cqtRrifEc7tKxfp6poqXCK9NZbnjbY129yrv7cjDsQWoih6O1kYgX/oUxsvMtvyoThkp9Zf
 gkMxol8Fl/w873C/Aj5KZ9ls7QHY6D4Q66gP8+Y4BbA0gdyIZ5EM3cV9qsd11g5pVCC80oa
 Cqlgu5lnJDtY7fWPfTuhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+J2/235/82Y=:mhIEAYSb/tEWny47kx/nng
 xss76yQ7YI2YcpHJIKjfPs9UkzOqH1kxkV0DqMtAeY/5en7P3e2+3tqc+vAhkROO1I1yaptq7
 4/VOakNbz2jOKudsXHWa6AvtiWhOedOf8OfESfy2/Tu4tnTH7HSwdmoTrcYMZuSeM5vi4l1Ts
 /VjMRKzbEEjjCZHzx6Hx5zt+oHY4EfTDy0eriWE3mA8XNDWn7XJ6t5glUb1SUwDqHP4ORrY7j
 fQB1T6H+/RAWNgVsdMTgV/hM5VVjRT0XWZA1eq6DVRs1bvGQQg+Xox5uBmmZHCSSMC1SGMvSs
 2I3EUqgD7dkCxMtiHnlIMfzjenBRb14yjxeHRi7UI/dCP63dAQwBI0DPUAvIj9s6UZnR+ZPhj
 fF3dDFEoYX//kzNexpKkVi2Tzz2xAYh1emgAIV8zYHuBwDzkUgD2Xp/3WfdjaBbxy9dg+oZfc
 jVtggdRqruzy7Q/6vq9gjvN6f45YRGxo1rjfcXgJqjmwfVEUFTYnx389BKpGo5vSXt2CmPlmj
 a0Zwje+hW1L4l5u1bk0zYv7/c55FZkiF1xbsdgsAqu6yInPhjBMMTIUvQ3n9TBD7eOXeq2T6o
 fup0CWz7MpZbSmkMb+HTqY6irc4boTyxnzqRP30y6Q+dT2Aj0x7eZuWiaUqamtIzPpfOtJYI4
 6eXj6ybTmtj4uZ2Nq9HwTvB0vYlyOe0MMlDcfk/+lxNqmUzzxWzmcL42q0kETMRrkh5D6Wgjh
 hfShp4w7OrwHokiHKj8FSHB6wXYl6siyYGx1awuFlmVj+hI1rJKjag1ZPbOH9bBP8HRmTaPg3
 szc4inOjB8PxM+iB6IAR1KSyHvve/n0jb0e+/ooDwWH2fs/uUuKsQCLHqVunlEtiTrmc0lfDA
 KqzhnwWxMrqgNhrnw050L9mLZbHK9ZVWhfIIELAsCB8oj4GIp/H+ZQB4snqDjqQyK0XWp0r6W
 86U1zOTGj93V5wt1g8aD6CG/qbc8omq2Ox7rJE3Ws1qwyhvzO4zN1iyRTDJdI06xLUDjywCOB
 B3VZvzBJ6mhqTudSDn8mA7Z4n6GBGwTsZO/8RXHRjxXEb1WC9a3dmM+apZUjGNwAdCbVh4hFN
 EoXwAdCFKuAEax+uONwrY+vas6eJQ+HcknFttSkntKb7rYSAdwlh1jK5nK3jE0G6r0TdOtTq4
 fwaFdlRm69478dDV4Sow7YY+QZ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.38.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.37.3 (August 30th 2022)

New Features

  * Comes with Git v2.38.0.
  * Comes with cURL v7.85.0.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.3.6.
  * Comes with BusyBox v1.34.0.19688.985b51cf7.
  * The scalar command is now included. Scalar is a helper to
    automatically configure your (large) Git repositories to take
    advantage of the latest and greatest features. Note: If you work
    with repositories hosted on Azure Repos, use Microsoft's fork of
    Git for the best user experience.

Git-2.38.0-64-bit.exe | 49fa8d1f151e83b89c84e0cb9e400ee0d543d238960f506e487b5a39889fa2c8
Git-2.38.0-32-bit.exe | d1f4c6f9194743566b7e02ff4e437144ff102c16a6e3d3238500fb18cefa6a07
PortableGit-2.38.0-64-bit.7z.exe | 68f6eb736f20f51689a77584f6fdb12340754c90ae1fca83e2ca1cd11e3d3a73
PortableGit-2.38.0-32-bit.7z.exe | 8dbea9a129bf072c1650e4f914a8b54f4e6faccbd5c6942301835fcc5ef931c6
MinGit-2.38.0-64-bit.zip | 52c9b2a4b10a0a25b1be9466f60a5d5ca5330d5eb8c1661a8fac4bf2677a0e46
MinGit-2.38.0-32-bit.zip | f80ee8a4f2074ff9dc678487155a0571599cda7dfe4bbf54534f4ead23577b6f
MinGit-2.38.0-busybox-64-bit.zip | 36cff40e8a27b81e13b148c8ef38351f1b234edc18ab09d3a46319ddf317200e
MinGit-2.38.0-busybox-32-bit.zip | f310c8fb14942d5526d9a984e5eac8e70e08d8411fd7850d4dd9371f5e9c114d
Git-2.38.0-64-bit.tar.bz2 | e8e8420d4ce68193f678b5655d96fef79b376f411a1779f322e2165250e73061
Git-2.38.0-32-bit.tar.bz2 | de1d561bafa352eecc8b7b6ddf4ed1ee0cf8c957382574b38282760f0766ff40

Ciao,
Johannes
