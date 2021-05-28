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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E088AC2B9F7
	for <git@archiver.kernel.org>; Fri, 28 May 2021 13:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE53611AB
	for <git@archiver.kernel.org>; Fri, 28 May 2021 13:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbhE1NXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 09:23:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:36861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230512AbhE1NXX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 09:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622208107;
        bh=uVouh+ux/lKNL2rClvjA7N4CNN8YnHkE/4WO+v5ghVY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=bPXkfz6LGrowPAO2IGrYTfNzqCjh7e4L4JtbVPFqROxCrqyO12N+uT2W3qX0I81L+
         DAj0lSAQcQJxv5+DLnpC8LvchRGJPJ0n3vK6+4ZuvRE0LVumugh4ShLo2DGlsFmYqA
         w02qo6+sVxhIVEV+Sc7Nl9AVeZUBMdCVgky5YIhg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az54-702.icfvhty2ri0etlcdmbrxxowyfh.xx.internal.cloudapp.net
 ([40.65.99.241]) by mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MTiPv-1lysTv3fzR-00U5xr; Fri, 28 May 2021 15:21:47 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.32.0-rc2
Date:   Fri, 28 May 2021 13:21:43 +0000
Message-Id: <20210528132143.4906-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:n37XmYsVcO/7iZiB7y6p1rGjFrXu6KHTS1nOx6h2Dd/PU4gLjn7
 FyQxPwmRtXhUmTeZy6FNMHlGjHrORU3eV71++E0LTmiECnpv4hts0YAx9b74HhKgOcoZ4ia
 rEfQKfj0mzDz+z5q2z0SZ9AsIpeOzPlBZS/XH0+jKzTKeEn+SwHUr2Rj2Vus/dmO75gyk2a
 sTjjV9MFnW4ch8mK37cRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vml01gdY/ys=:ArLcdn5aJ3Dz3VQhGb2Awq
 qk0znL/nVaV6NRuU/uyhtS3pOo2yg6HGTc/8bnLcGG4rhwW+cBlKW0DuqSbEIzZrFTWLyVbgP
 Klj+X4rZikUeSk2xE246jRM6WVRoZCu5osKnS8HWqLi91MNXy6kmfUe0GS1X1YEDtjjgbqBBo
 9eMMzjdp4ZOXpZQBLYNnOAyZ/RUUDIH9bgzY3W9IPxhTONIhUB2bziLM7+X8T62RgxwS64P/Y
 sPXUY1O4SGzMw1hnc3B1OMtWV6FGKPObrm//SwHroaApVUszCryvgNWvXlFp229Lz2yzQP+MQ
 lMBS3hxxxs/G21obLutskRUnFgx1uAXBp4L80sdQBK/zLz+837cqzgILHzprNQoGSSReoSi3N
 uBc4M6Za43laHHBfNIaOUyEwV1QQIKAbHlXuhGqapVNRmF87szmzQwQQJIMgF0ZeEv95iJLXq
 1MpU46ZrbyeQjXNIaP1uPWyHVtWBF7ywc5tzhNmVNqgKq6BwQ8L3MVqGbwFVxRri6m67EkA8G
 I2qBGiXe5DONReuUgueVsjNWBQdq3IUOKHRwOD4hS/lAF+lK+st1lDb+6VMUIZE/smLb1sRRJ
 YFYvCLNIE6NIQ3oEyyPpRx1M1D69FuQgX6j36KXVSPDccrHLJRG0RpvLoQ8kwT+3dr+Bcq8K9
 OAK3r4cdq0rvXcoKLDcT/cMPvPH1eLnPrtdoyuGWAbKoompPs+iIta703dGa8BPT/KSaLHV88
 UaKPCEV/5g10e/VA6SX4HiacYVH2UW4e/aNRmwvY7pwUrII4aece+dYTNyxcUlwTigpMRiTIr
 tJG+KuQvM9jh16ZNZ9/pymbRyHFZ6B+5GBoxgvd9zRb9KEq9ffdHI5C1mxwe/MkXp/UtWfU6D
 QwgOgQBGkoIHxXS9eHm1YD1FyjdWuOEoM5Jx0AkwQ0OyBg/HrFNAqRZq1UyVmgkeNEZvXoxtH
 eAKUHr6z0XI9gOqrVPHUHDGPAVHF6X5Oq43kQNnBJjMWCR9ursyPI6Q/nhB8sXwrdmnCYOOdq
 KkXed1ZHJwHU3QnbvRQEDqFkN42k66BdlyIb6gPEgcBdqUGb7m8Pwz8bmvQSdrFsitdaf52QO
 05tt9L/Auluf339iaIyjc+ecJlw/A3q1rrkgpuwabe4cElqK8dUQy8zICmXv552Jc0PenXnB1
 zEZwjj+JTURCWkxA8Av5q6p5MXMixUGyZneU2l7bu6m8qI2vDxFt4EhESi9L1lOZEJuZ2gNKo
 16ALvmIBWyjZZrkkz
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.32.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.32.0-rc2.windows.1

Changes since Git for Windows v2.31.1 (March 27th 2021)

New Features

  * Comes with Git v2.32.0-rc2.
  * Comes with Git Credential Manager Core v2.0.452.3248.
  * The installer now offers to install a Windows Terminal profile.
  * Comes with cURL v7.77.0.
  * Comes with PCRE2 v10.37.
  * The experimental, built-in file system monitor is now featured as
    an experimental option in the installer.

Bug Fixes

  * When testing a custom editor in the installer, we now spawn it in
    non-elevated mode, fixing e.g. Atom when an instance is already
    running.
  * The meta credential-helper used by the Portable Git edition of Git
    for Windows sometimes crashed, which has been fixed.
  * The auto-updater no longer suggests to downgrade from -rc0 versions
    .

Git-2.32.0-rc2-64-bit.exe | 6aeaa999d894fa636ab9ac9080ef6ec44dd9a4165422cbfcfd61707376325c18
Git-2.32.0-rc2-32-bit.exe | 70e8f7b151ff3d83b2cabcd67fa92cb24e445a5f1288711669c590c60294ffa3
PortableGit-2.32.0-rc2-64-bit.7z.exe | ccc3c3a90a66d25dff7b79c8321bcf1cb84d8a7a35907c677616850e39efa08b
PortableGit-2.32.0-rc2-32-bit.7z.exe | aa14f3633333097160814e14347f0b450b7f209acd07c382cd8c59a2f1142e12
MinGit-2.32.0-rc2-64-bit.zip | f0bbff20636b9571f8824fad7ba7c5cd5b0950bd7a102e90e11b31d87eb3ca0d
MinGit-2.32.0-rc2-32-bit.zip | 0250c8f5e6681a5ebc303b03632263302b5ba57d87fe83181727944fdaea3e06
MinGit-2.32.0-rc2-busybox-64-bit.zip | 880ba45f0b3e9194a6f3ebd0f22b71da384edc4cd3de81c1da122ff9df327fbf
MinGit-2.32.0-rc2-busybox-32-bit.zip | b936bd62f50cb903002d14c270568df861d93b6eb1a515f457b790e6cdf8e70f
Git-2.32.0-rc2-64-bit.tar.bz2 | 9f43324b42be7faa6a051f823fcec1cb05616e66846d995a0183d959761c85c4
Git-2.32.0-rc2-32-bit.tar.bz2 | 286f45e4834edd0497b75dea39a6bcde2f909f49596666fa04bdf196d5d8bf0b

Ciao,
Johannes
