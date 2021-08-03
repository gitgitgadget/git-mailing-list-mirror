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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E249C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 18:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CEBC60F0F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 18:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbhHCS0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 14:26:39 -0400
Received: from mout.gmx.net ([212.227.15.19]:44903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238560AbhHCS0j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 14:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628015186;
        bh=FNKnME6zOdoi6vFiKd0eNALsFpr+mme8evwN0sXqfBc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=FN9ypCFD3fgGSwBtB6DoGDziS3YlgmLLfeYkxJGl8DAVpXo47Rnoy6RXxIdwUERem
         PappNkaB7CPjtBg12e5pxOd77Zdm+qp1y+ZrpemCGV1OfC7sd9jF8uV5Ijzc9sRdSo
         IY6TJPDWMVpSa4wvFA0Jz9Jj6ah8PWxxoc8M826s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az94-440.4g44ktyaxzeuxfnuq3afdkdpfe.ex.internal.cloudapp.net
 ([20.80.39.198]) by mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MS3ir-1mZYG906Q7-00TVVV; Tue, 03 Aug 2021 20:26:26 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.33.0-rc0
Date:   Tue,  3 Aug 2021 18:26:23 +0000
Message-Id: <20210803182623.4725-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:S+6pzWvLmzPBdiY3Iw9H3aCap5kLStHV7/Ze7Hu1+TnwNmJGd7p
 hwQ2e+YUkprw96UYPryk+egG2QJ5Zu85pvgeep+HcIozmdUo6FvBwtds3zanqBnNDFe8Vjp
 T3pV5q8xolmegiLTnQB2Ewy1bd32tvhjPVVnnPnY//uX2xUwWwyDqFWYVzoNd8AdiSEdPIe
 MChg4b5PTHpdYGXTXQU+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j9QNwlKgD7k=:fqt5Dk4ZK0mkf0UJOywlpM
 5DNRM9pZrRBi6xYzDmLPqo9Gvm1Sljvd2fsHGskCheG3Nv6PMrxAHc9wLHppCfO5M0rOwv6Zk
 DXpqr+mu6jOhLa6+46Nuiveo3ktnjtFGBeKEOfCudIREjucLs3L4uiwj+7LkUWHwKKeoTCLYW
 hMVwmIpBjr9ADEoU9fn72r4EIJznAKXVMBSui6/Q9wpgmbvht9oZXhJ6Z+EBUKt46ziUIWWox
 nKpfUPPZ2Ilj8W8X3usQsB9y2iptiA1UCQiGOF/8nBMAZhpqg4WBFpQ8gnE7uLO6tcc9SNp1n
 0xMZRA91bnltE1EKSqNwpBXtFT+HARRnQspRUD0jiasuGkzLvPMKCxhbOd2giEz9h3LNjj8CX
 x9wT7nW4MB2FCf01XSMCwkZoSPNlVcBx3TrM5pdAZPJlvW7cWFRV/dy6Kxd9Rix2O/WXPZymn
 USyBZM1T1p7bb29Er7mEDX4ho0BzGRMq+KFDx+FKVxL+qrxoy+i5u2CYOvZl023GRt8zcRtav
 sxhwtwnqee1bRX67nOTsOrw4nY2NgYYNvNWEReZV30k3445V1IGR/hJzqIUoGMTx6hN26uSoL
 74P9qFhaydnosIyWN9EyJLllqRpUhCfw8dDNsDP9m9rRk40HYoGVyEdQ34Mu4C1KRFjIZ7lcc
 3AgV2X4PyTBli8D/n3i2gVif0SelhDMNgXQ71C77yn727Gg4OpTayaA1zqrDMGeezv5FemySK
 rhODBX/Od5sY5BILHYCtZObyzZ+uwbgkKyZm0emPR2TvW70yhxJLvXYyoqo6ldsbSsrBO9Hcn
 kEJhYZjBAh4QU4vaaYZ6l6DE7Do76MKNQ6c3UhOK8OwnrXpU0IceDWtcPF3b+OC2IPUpds5Si
 H/NQts6eP/8REbTJQjHfhtTlaLYf+m6anZGB/coaUq/FNCkFBm8yIqrPirh3j/7ZuPVurPTrc
 k2uzeGx8VKJeNxjlbd7ZZPDpCkJZnuFfFnTtCgEgdbWJcEQzss78YYwRTbPRS2KbrbGbxe2E5
 dnzb6rZXkbjL1FX8CIm0ggEvTyu5grXX2bZHCWukBn/Zc2pJqwQxWVbyeWWH8ybC+1gBIEGwa
 3h5HJ1wYMKcy+QmPhXYcFsHEv3TQv/V6krmQA35l83F2LO+0x1TlbjNig==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.33.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.33.0-rc0.windows.1

Changes since Git for Windows v2.32.0(2) (July 6th 2021)

New Features

  * Comes with Git v2.33.0-rc0.
  * Comes with Perl v5.34.0 (and some updated Perl modules).

Bug Fixes

  * The installer no longer shows an error dialog when upgrading while
    the Windows Terminal Profile option is checked.

Git-2.33.0-rc0-64-bit.exe | ffb629496cbb1005cd00c7ae4f23f4afcca91e772d923b5a6b2c8f33f1757576
Git-2.33.0-rc0-32-bit.exe | 62a6b4d1ae39a4bfd63850ae8bfb10b7efc305b0d4ce161b48a95db20c23f7be
PortableGit-2.33.0-rc0-64-bit.7z.exe | de54ebe5601156a29a9724bf5d0fdd7aa3cda4953b03abbfbd7778a30b449bc5
PortableGit-2.33.0-rc0-32-bit.7z.exe | d927ad98bd3ccb11209e53b5b267575ebf599536ac7a075fbbb748f50b9ef885
MinGit-2.33.0-rc0-64-bit.zip | 295886377a3dfd13c6970636afc99eec23106ba49706bba4def199b9a94e6a80
MinGit-2.33.0-rc0-32-bit.zip | 4b92927f06320d0cc6ef06c31c6b5a5cce3814f0fb442fb7ab8048cfd68e0a36
MinGit-2.33.0-rc0-busybox-64-bit.zip | 9dc65b2c04c752a4b6e0e1bdfadeac570cb4bb42d6e1ac3ee938f16529a18c69
MinGit-2.33.0-rc0-busybox-32-bit.zip | ff2d165439675e99d8a1c11a8c19bf54b1ad762890ff00f99b5c97a31ac044c0
Git-2.33.0-rc0-64-bit.tar.bz2 | c4699f576777da61154cc657c37b1e2db066a53eaca2a3a0f89da67bd79ece38
Git-2.33.0-rc0-32-bit.tar.bz2 | 71f4da4183f20512a517dc54c2107faadb67f0086d848d30d6c50b8f65c40201

Ciao,
Johannes
