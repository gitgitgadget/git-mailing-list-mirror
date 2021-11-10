Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F05CC433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 13:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0736261207
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 13:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhKJNnW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 08:43:22 -0500
Received: from mout.gmx.net ([212.227.15.18]:51757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231526AbhKJNnW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 08:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636551633;
        bh=hCWhBlOMRYTJPgZzMmkwruj4+D6aoAIVHpk+Ej45dvM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Nsdl44jIoltltDK4ZoQvRDAF7Eyk5x7xwzQgftQQnyjt9D0amXWItJhBLT6vCC3RV
         QND3VsVr1VZOv9oZVxUi26S+W5NDgQQB71EAbzOYBhEjoTg3TiTnmdMAFyk0aoNNas
         SCsUVJY8HEbpV3Rg35kdZ7J/xzmO7tWB8Y7IljgM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az81-5.gxbd4xatcqcuvooaec15z24vdh.dx.internal.cloudapp.net
 ([13.88.27.200]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MOiHl-1n4ojH1ytb-00QAkS; Wed, 10 Nov 2021 14:40:32 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.34.0-rc2
Date:   Wed, 10 Nov 2021 13:40:28 +0000
Message-Id: <20211110134029.4959-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.33.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:wQSRnIDSFJi1YwpeIia8kIvcD234jVGbtbkEFtO/4BMtOhynJMy
 VFEbCzvheHOF4PglnwfVAHh+RvmFlQs7aoXqf40wp8SfvKBm0Ck+o88Zzzjt2+3Q13hy82G
 e4wQGlibo6NnQHegbuHq1j13FrgL9Xb6ue2GSLDjnX+a+il+gVXYBdP2/RknR5abO+4Lgv3
 pxQkdGYorO8Ecm492k1NQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BzIKBQ5H2Eg=:S0CJhlfBqul/J8TUStZ0Dd
 gVQ+JLh21TDApwFleFaYVIqngf5RKMF8NIsWtdFMSguj5kTM/b5uJ4cf/PWIF3lV42HDSWUSO
 GG5tGM6aVFFCY0YHezKK3xD3HhM2LNOGPW6QY+o3bjKgmboNErl2/OM9AUP8ycjoB/e/i3pb9
 NtgSi+ZTN6HW4lxyllpppIv50bZTF/9I+Fbc8IHtzvPbRAbxP9WpbWDuPDFb45zfbRWyx6z8m
 4rUQd2J4+YhJCmwW5D7KCVW/m50ICGd814l3qudyKGSGejuP0lmbrgQQLghDlmAVBIt+gpLqL
 aXjbPHD/OL2NkbLlM2EcWfxytkRweiY++6bdz80Sq9bHecmUDZsoDmuFf2h2q4e7uLR5veG3T
 CGklPZwnb/0l/I72rgxH/o+3EYZCHj+Nclxqfef0cgfTqJft3bEfHS7syTvyvVj/bb66j5zun
 XUnLDkIPz1iwnCpQbetLENNNrxZAhbLadr+QQNRYCXPyZzeBIwkKMyZUwwEfy9sWbC+/lUt15
 DH5CwYeJoblkFoCCiehLSJ1tTZ5VyUSv8uhM3aCodGHC1QdAbDv7W6gdhx45MfUXjCBpflZgV
 CIC6Q9l6naGyulcMKBc74Vq4+REFSJXirrcLP8SRQBP9bAoU+Yb1Kmpyd3cqAgQR2+Yg2xpfh
 0d1LgoPYaFVDUVnFrt0JZ0wXlgaBf2aHMlJjc+2xJwRNWSKs3oXuZXlr66mIH8FaG51/IRYeQ
 z8pgkNdGBwyDy1WDfyTRJJEJDq2EKldKNLq1wzH42mtL6oaLszlo98qcY+kMPPd/cZ44CAFO5
 qAvsCSaN8abQOikw99d7oXLM2jcF9da+UJqPrq0wzoprG0dVEVAcefKvAusKAi//rwS/djDXP
 edxDFYs6gK1EABCOba1u81LlCIQ8UTjrZOZgjRPDTZ76Qcci/UPvWB2AYtXJDSceE1LZALNO3
 CeSd/P7d8kqyBNzcJa5UJGjMMp9N1S3R7s9CCcVVHMRv/c7+tIkcdHCaUNsNsyqZdyni0NpRz
 EYqp7QxDMpA9AX3hkWC30FYyAjHiz/dBWlZUckz/vEQUlZqujYu+S+t7PS6Cwst066+TG+VHX
 zT4NuEDuG0KdjM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.34.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.34.0-rc2.windows.1

Changes since Git for Windows v2.33.1 (October 13th 2021)

New Features

  * Comes with Git v2.34.0-rc2.
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

Git-2.34.0-rc2-64-bit.exe | 7db38bae6d487b9679594b26dc15ab986bb0c60c8bc3fc53adc4516eb61a9376
Git-2.34.0-rc2-32-bit.exe | af35e48fd4ed9cade2a6f31f56115ff503c92b770bd7511d6f3f3dde0e3de49d
PortableGit-2.34.0-rc2-64-bit.7z.exe | f587497e7b89944650bd03902983a0f102b74c54419b54360d76b81e5883d02e
PortableGit-2.34.0-rc2-32-bit.7z.exe | 58b0f2f3adbd44e979006ed5d2959ec3a4d2326e7b35a31c54add72aa44f4e2e
MinGit-2.34.0-rc2-64-bit.zip | a0359a03b3f02fedd59d2e307c3be3400c7346ee1b3eb826cf56b0a255ee3b05
MinGit-2.34.0-rc2-32-bit.zip | 09631bb2d3daa1b499908ef3b9719a779369d15db1e23e7bc2cf2178bfc70f0a
MinGit-2.34.0-rc2-busybox-64-bit.zip | 6b40dc2169d5043bf7b536d74bbbe46043260148965005c787c587a6bcac9705
MinGit-2.34.0-rc2-busybox-32-bit.zip | beffadc23005002240a45f1ac34a7b3655cc9077f7f4433f9c1c1260380a78f8
Git-2.34.0-rc2-64-bit.tar.bz2 | 6b890289de342b794c5ada324395aab1e99c04c80d9762bb45637c2d03f2bc14
Git-2.34.0-rc2-32-bit.tar.bz2 | 7a9e7d97f4ce6b598926f88426f7f9960507c147fce4999939244689035403a5

Ciao,
Johannes
