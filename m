Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C69C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 15:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354848AbiDTP1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 11:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380205AbiDTP1e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 11:27:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC2F45784
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650468283;
        bh=2iCVSfqRJPsLOdIaTWS4QQqRufSdD6PTjEygre3rQVQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=JJ8m34+1+/wcdoQJ1qIIQopHl3emNhT9CB+ykpCUlIZIRbSerz9xGCUXHBwyAvRBG
         tUWHbInP73DVgCvsOWei78I9qCPt4GRqKGuOEEKCRoEMBDREKC9vW7EytPW21AMi/e
         yKW+Ki1osfWrmCVIJ5FYvTZJUkeiEy+/JQ2jxtPE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az196-785.m3u5ga3utehe1jm44gvey0miob.gx.internal.cloudapp.net
 ([23.99.200.225]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1ML9uK-1nQDZg3xA2-00IGju; Wed, 20 Apr 2022 17:24:43 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.36.0
Date:   Wed, 20 Apr 2022 15:24:40 +0000
Message-Id: <20220420152440.4913-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.36.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:Pe3+6dmiGbZw239aiSp9FMFB7tPYMK72T6B+bz/WdvM8xDqtB2n
 nPO/O3DRgTeyvuvzxd4sI/8thso24fNTBlaol2/IBU7/GaRSyfG/BrtmWv7dvJtNkGOIjtk
 PBcLKqCSra3pPdnz7nCUwH4IEi5ThrXGodJuCfjwAtJLw2d/oJGOuFEhzQvLNCzbU96cYex
 be32Xg7bTNZxdqO2S+7AQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7pBGf8Bpxnc=:9sKOfz5MwIRArod1yoScsi
 wdBvKd3iwcKZb/N15IOPT7dxtZy3bRTBDeTQp1Cr//bZ5/sSlBmxX+iGJDU9kfI2o5yGr8dx0
 JsAhht/xoOsxbAIRXGbVgYz9RUnguamFg+KqsNzyVP27XDay+JF+3Y+UBHqIpxGudfMAwFQqW
 vJ38zBQBoiOoaXaJxueuoQj+EYva1d5JNyQafaW6qxUDD7btifvDbieU/3vR5tuSucTU2sVI6
 ImAqQ+3KfxF8mjgdIyNLloAMu0O/6KxV5smAO0frY/2KWmmS3n1NXhMHxOr9kie77Z8MhKdBf
 PcvkB4wPyeuL2BkZ5BfVqZd6WeSfcqUK2ueSfgzBfYa9yxlHCondXfY4mw7qFm+qEO1ANef5D
 iFbCapWow06YCT9/N3vqNIHzKIpQN6XyA4zr8UqTtrQi9ewwDNRgLNoJFjDM68dsLSMfpMXi6
 VLvd49IW4fTbHbze7dK2Wf8hKGXZw2cUJfGa4gPXxZPxrN6/jn/Vt8ENa/B9CwZmXyZ4cqSBk
 5snfiWlx/vUrLIWwuLunZTCcfSNlJk5vUSbHpmmG1tnRLA0pP9U22gL24GqQW3f66vuekTB2I
 1tWMt6IXDiREjnP5sCmHVTxzKqcTsUnEz1ALfJmbY8Gm8cHFtArCeHhotRagXz1Riwf2KHodT
 sq/hZ8l0lTZnOkcNc0BELuNz8QK1a34+oX+fMehN+4C7+LMVaNi5e7wYbAsLaO82pOufPRxfx
 vQkkhSziAB4rj+HrTN5mQUeWtTaP6kWdkgvOcIUj82mknRWUxznuRPe2QrV1CmTQJbioJz7os
 oBHYFaKlDUa0Y+qz2ql3aFTMoFP0aamedxqgY8j2YVKYK5JKzzzpGnjGSTM9ic4ybmwDIDRWb
 UbO0DFtdD/Ebb/RcO0guMTkASIqbLs02CF+y1PO5gBIkpLJg4ip7peHyaEKKlc21VVV2df4xq
 6bFN3dylcZOU4ef+zIoOvd+wHVuJJVyKn6rkYDBEgVRjBqmo7mPTF/GR10rJpQgTidt0puU4u
 jbu7jur9paxYKfsw+eRCrYMAMxSb09mjmAbjFybQpG7iUBaKty7gEGG6t1TFBO2ZZTpe+ADN9
 L0A8g9s/Tg58/Y=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.36.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.35.3 (April 15th 2022)

This version includes Git LFS v3.1.4, addressing CVE-2022-24826 (if you
use Git LFS with MinGit, you will want to upgrade).

Upcoming breaking changes

We plan to update the included bash to version 5.1 (currently 4.4) soon
after Git for Windows 2.36.0 is released. Please check your shell
scripts for potential compatibility issues.

Git for Windows will also stop supporting Windows Vista soon after Git
for Windows 2.36.0 is released. Around the beginning of 2023, Git for
Windows will drop support for Windows 7 and for Windows 8, following
Cygwin's and MSYS2's lead (Git for Windows relies on MSYS2 for
components such as Bash and Perl).

New Features

  * Comes with Git v2.36.0.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.3.4.
  * Comes with OpenSSH v8.9p1.
  * Comes with cURL v7.82.0.
  * Comes with OpenSSL v1.1.1n.
  * Comes with Git Credential Manager Core v2.0.696.
  * Comes with GNU TLS v3.7.4.
  * Comes with Git LFS v3.1.4.

Git-2.36.0-64-bit.exe | 5196563ba07031257d972c0b3c2ebd3227d98a40587278e11930dbc2f78d4e69
Git-2.36.0-32-bit.exe | 5de71f60ca0012e5efc6e991696095d3eb5a80d156fb404c3fbe8317ba690313
PortableGit-2.36.0-64-bit.7z.exe | 2257df41991f07c33176e2af8240181dab44cc713afe0fd95a0e12964fc46bda
PortableGit-2.36.0-32-bit.7z.exe | 27522261de1666e99d2c9708351de8e25638d6bc2f41e4d9a28bcede4c8eec75
MinGit-2.36.0-64-bit.zip | 0c6611fc04b9b111777a4f219e198bded07fea80fb14dedb01ebbcc231480986
MinGit-2.36.0-32-bit.zip | 8c0d78619273116c7d76ca8ec1e5322ba3a315a113acafabcbd9febfb2dc493c
MinGit-2.36.0-busybox-64-bit.zip | 5c301b9deabae5a83a09efed7f816d325f4ab23b6e3f3a50d077199271e045a0
MinGit-2.36.0-busybox-32-bit.zip | 2aa9b03696f0aa4d07968316464dbc541eb9a997f578cc110e1c3e206f78f2aa
Git-2.36.0-64-bit.tar.bz2 | ee3d663e3aa699dea3dc664e29543a2113e022365d169100f708a8660ae7fcbd
Git-2.36.0-32-bit.tar.bz2 | 6db2399c943ca74ca72884dff1524c6c14f3f16dbd1f139719e62f6d89f0254a

Ciao,
Johannes
