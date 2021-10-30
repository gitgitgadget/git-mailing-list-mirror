Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADE7C433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 16:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EED8260F92
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 16:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhJ3Qcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 12:32:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:44003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhJ3Qcl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 12:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635611409;
        bh=cQFuX21pRf7y2XgBU+NZ26uBZ0YsjAYH30k8BFV/OF4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=KQly/dzXXKt3IvyFVQ8IZxmRvvZx+vLa13pQv6pNf242NAbB5UVEqgSAz4w5T+G02
         1aQ6Cp78xfqgdPNFs9X2TLo2Z+JquhBEf70F6vLFpuyHSg/lG8y5u5xWlN6H2bF9RH
         CIbm4/DcC8+3H9b+4VZyaNvuTDkD9I2xBPtkRT9w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az81-130.gxbd4xatcqcuvooaec15z24vdh.dx.internal.cloudapp.net
 ([104.42.156.61]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1M7Jza-1mZ9bh1OW4-007odZ; Sat, 30 Oct 2021 18:30:09 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.34.0-rc0
Date:   Sat, 30 Oct 2021 16:30:05 +0000
Message-Id: <20211030163005.5734-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.33.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:B7F9E31OORXC6FX/ghUT1yQm+RSqO9juSJyxRfCoGjkucZR2inm
 JjBdsm8N4m7al5OjudberquGtRuiTOffKINm7j5+bOCtLY0G8V83EVZi1IDiabwojRn9WW/
 zl9aBPs066xa+obl+jIuPZdSD3f1WolxVx9I3oL1KETcZm81iszxPI3K0E1obqPXwxksdkl
 N4XBh1BY/BtW09ufcHPcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PZXT65dH8cA=:8x2ZH7KEn3l1gRKVBD/PCW
 HoeSqkoJ7kSF/4C8bT/YhFgCq4MichIacpxqSSxn790I7DEwuEkCAGjmHqkPehMrpduo4t3bt
 ak8D+vUIyauJcfHoB7zbbnsvU2bDGI8CwS/S7JoQ6g1tN+JKGFkn6XVV6uxMS2oB1+6QzaJd3
 I8SXGm8EHInEGTeH3LvREdtjqpQDHHaSo4egEwKThE4uqaNxq041liW3egTOMRFRT/NaZHSif
 ZRCovRIe1+DBhaAPazn4jxr16x2hEgye+uNLII3lggtbOVfGjpwZ3ddviNNabxDyS1Lxv2QmM
 KkOh1eBPSvXMYgUnvXo9D0x7hDj+Mxildeh+P2m/Hb05iSFc0qQOE3n644q9pF9cYvi1xoErV
 85lB0sD1rjFsQeH1BoAS1XV1TYwXDuuTkIABgPpgUEhQn4tburcIsz+VgaO7o0W5cIi7kFgU2
 fLXhmGNfTkwH+AYl+AS2v1x1PmXvTXm7dFFygm1+XSxNkaqimbp3ldGaKtKrmURtULFpyVSBa
 jmxM5n0gAr9s5t5bmAYnJNoQGHSxqeumPO5HN6WYIAIQkBMcJm9UqFiHhcZLGjBEhTil+Q9nR
 2i+a8kuXI5leGRHWNpJ4d0b7RAt6G2eotDev7GlHWEaK+iMc19yp9amixRlY6KRYnMI2bhVU/
 icf3U4JvXSnde0nGZDo+whj0ak3R3GBF/T7FrYh9fvNDGHCgxFg3uINz6yfIBw39aW5O/25eG
 bYQVVp002dfBXGUqpddtOnbb7uUVcKuHZhB0dp/nBSDoXYd1bTh8EHOL2DPIKArh2gCCRf9jU
 WUJDVH9lZJ69LxFEfJaja7o3zUEjLvipTRlliM5IxBB87Srvp5fOsDs+QyWgax2uG6+J/KdLc
 YQgE+jIGZTPX+z0WxLJvMZVBeYb+6VzP4rixxYOr0FHazADpAh8aifVywsW6mzfVrQ53DWZ8r
 on7dHqd7Bk2LfCG4amoSKwaYCddEPH1Qm4NareqilZVmclS7L+QnGye7J89SwnXTOLly3EFoo
 yAV48Nr0m+4ZJR6MFpDNJ998D3hlM7vAgJbMdukGS0nDwy5X5LXGhkhAzPAnfLztR6g5m2SZx
 DVAUXyL0+5rjjI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.34.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.34.0-rc0.windows.1

Changes since Git for Windows v2.33.1 (October 13th 2021)

New Features

  * Comes with Git v2.34.0-rc0.
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

Git-2.34.0-rc0-64-bit.exe | 7b733a5ed5c71cf4897906941642044fcec20cd38043ff34fd27ad3a07c75fa4
Git-2.34.0-rc0-32-bit.exe | 8cc595c1e942e1c47981b2125ec0c25a6296fe2b89d059d6fefdc40b40bfba54
PortableGit-2.34.0-rc0-64-bit.7z.exe | 11a013f794cd16afc65043b62930554f570028a7816dafea3f9497c52aa03109
PortableGit-2.34.0-rc0-32-bit.7z.exe | 49f8b24da774a6a4972161f19cfd18f168c2e6f3684d10204dc69153db6ea33d
MinGit-2.34.0-rc0-64-bit.zip | 2b8cc7a9a5da92ca663b2c3dcc7b775c0039c49c003fac4f36805d038fdc5745
MinGit-2.34.0-rc0-32-bit.zip | b984f1ff847b81799d4a08c0a08898de0c7c06ea53dbae38b63a0b607df40b49
MinGit-2.34.0-rc0-busybox-64-bit.zip | 05f1a2d9e980a8b0c97a0e6602e9d2dc49a40d8809de780134780638bfa83ef7
MinGit-2.34.0-rc0-busybox-32-bit.zip | 931e7165aac458a4dd5527f7f7f542c0000484a2e88270bd5cdcd2284ce2008d
Git-2.34.0-rc0-64-bit.tar.bz2 | defaf243ff0dc85b8f1cbf6a55f7c92208d50a6440c954f240d31f1f2a548258
Git-2.34.0-rc0-32-bit.tar.bz2 | f536950b54e84817ff1e45d708d5a1275f2e5e43dc9c384e27eb7dc21de928b1

Ciao,
Johannes
