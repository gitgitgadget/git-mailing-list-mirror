Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539ADC43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 19:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbiF0TWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 15:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbiF0TWA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 15:22:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B26B4A3
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 12:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656357717;
        bh=5amejZW9s3ktSu3AENDClCsPNhjH2yWzm0Qahqc1Wl0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=bJywAgOhp1QDVmwcXzzm0THjWXzJ4Slhw6qd1atAe/CHk9mdpHnvXkv9ej0n6VhjW
         WErzJkriMYtzBzX7GC1tqw5xjXuD1TaUeoSN+KMRYFSsyS2TJPUxLVtHFd9HjV5e4j
         V8kHKSAcaOgc+dbmXCG34Ght81H2RoEypWPRlmbQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az48-37.y11my21s2nfuzmiq0sccgy5und.cx.internal.cloudapp.net
 ([20.96.125.252]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MtwYu-1nnQaG3CmK-00uKiv; Mon, 27 Jun 2022 21:21:57 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.37.0
Date:   Mon, 27 Jun 2022 19:21:54 +0000
Message-Id: <20220627192154.4051-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.36.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:6z2i9O2mUqscLt+Bn972pQOFvoRDfraYcZ38by2MXBwyonw1AZo
 3zgFAKTrttA32FXYL9cg+/cksoVVP8p4hescGQGvLFtvnhGjXtl4UgR2Qsla1I6pY+zeTGh
 l0t65r6FlzmjNkLiwNSnnOTrR+alw3+Nb2yEhfSsD96r4EpQIVWq48WJo2CmS5lHyk27ruM
 lbsadkUk4YsJK0FzmhCDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vyb9n5magnw=:KjYMM3S2OQKzC27f8OYtDd
 86lKBy3lJ6E596TfPGoXZ1PLB/QhmCpfFpmxmKWXhRhc+ob+OYGU1rdOL7tb+tMa8AWSnky9B
 2DEQFwOBbIt4FKkIMrPkseZjMCR0UAI828H8Re2xHVdq5Z9BHjdcYL/QNnZ+0Fab+q9MjJvPI
 a5DTVGunKqs319YPcRhloZTgVR128HEO9LiMmFMNMydnNNsjXmqjjYcg8Mn/Dm26dM2c6z4RC
 jfb2jRA0gA4xUyXMZDHL5RXsNs1tJpqxQIMHyi+c5JJjj5q+HLdbvCS9sikx3GtNCbzfkU4OR
 K3HaQbpIW1qEsoAKC4WsVlhGPlglP1D9/tBf3x6vgm5w3wPCQZOUT5C/5bHGD+Slb24JgZY9p
 8Ff/HUw2uZrV6YNw/FtAoZr8OMeV2qgTqyKFDfF8PadFBgnVURYlaYQO/zsp/1tAnPhaRWnPL
 YDGTly7TxhqqFzoRGuKC7sVBCBg/oIC/RhVvQ542MdKCJJhhhiNjV4o+cr7eHCWN0+/9aHo+4
 MPMxYaVwyT7LjKPW3RNlwkFNuTzvcEhAeGZMEAc9F4gMJ1hvDn/Vh75w7+/80Yt1wJOIKeHM6
 DtQ/RdZs8IBIjjmwQ2myeijK7HneLaBMdkSghcI7Pj3riko4bNeLqUw1YD2DDZi37AO+fUwEc
 e14jqyUoHT23gGPntKpgEWob123SNuxyeQTMZ28hn2owpwqoNzns7XYLfC99vArYOHw8YTJFw
 jHJAe5Zidu+TrUjoe9QaEXdweh3ry5z4Fviu/yQmGY+3dMgTXxYDCTg+VNRYuZ6uaaAl/cZIX
 55q64adnF5Hsq11ai7qsrD/vRdWmbNzzuW772EXgUAuReCFsdKxN7bBmawsyVL7ndYx1zisgg
 ke9KyWTDAToACHkYg8MP5wKFThiiklQsDkxiNv8kpoEEb+lkcIaiuW3Zc9ojOa9XBzGKDx2yG
 01s/TBDg9Ex/MPOk0KFKvp5DxNpLPctjdpLopb9hUCloKk9LxZpH6yZEeGpVUusDVCR8pztsg
 UrbYKlY8vcHcHKgBd5ahRkQw0tTHny/wXSsh0gRMuAvTiI3Vi8jx+hOugjZSHCd+tqtl7gdDR
 UqQ4dK/3gRHelSjxYUZRNw9D0ayAcTHSVI8Ki91COivxYp7R0Y0qko5zQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.37.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.36.1 (May 9th 2022)

New Features

  * Comes with Git v2.37.0.
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
  * Comes with cURL v7.84.0.

Bug Fixes

  * The Git for Windows-only --show-ignored-directory option of git
    status, which was deprecated a long time ago, was finally removed.
  * A crash when running Git for Windows in Wine was fixed.
  * A bug in the interaction between FSCache and parallel checkout was
    fixed.
  * Cloning to network shares failed on some network file systems,
    which was fixed.
  * When Git indicates an unsafe directory due to the file system (e.g.
    FAT32) being unable to record ownership, Git now gives better hints
    .

Git-2.37.0-64-bit.exe | f234cbcb7bc123b8219bc1692b1a44acc0fd805b1c6fccacd1e28d4672499ef8
Git-2.37.0-32-bit.exe | 558c76cb118b6392f4a48d957e1062031a019fd80788d8db71c5702173a8f2f5
PortableGit-2.37.0-64-bit.7z.exe | 96808564283669e0129310c14f8ad6ffb55498d3381420bd22200a62585ab2f4
PortableGit-2.37.0-32-bit.7z.exe | 45efb4a2c9c3fd11ca7580b0d8da469474c2a6ce1c48ff8a7512541923f0cbdb
MinGit-2.37.0-64-bit.zip | ed3689a5f9b3a6af40e447b30088864209128ddf17a4696be3b90b62e8db73ef
MinGit-2.37.0-32-bit.zip | d9b3fdef05b06e2ff9e5855df1205f99f3af079175f4b91f6eb46688e10d0b0c
MinGit-2.37.0-busybox-64-bit.zip | 49639d7272bfe44b779a52629ab5c87923cdad920f8aeaf070b9cb8e177469b5
MinGit-2.37.0-busybox-32-bit.zip | 83a909d0b5300dbd3cef5615b64517b46dab604fe6153e79e840f7b2d3fe13b4
Git-2.37.0-64-bit.tar.bz2 | fee7262c91d495cf7a87be1d28d7c37a74dfdd50f526771029911347a2e97e51
Git-2.37.0-32-bit.tar.bz2 | a955ec2964c028ba70a85a27b7d1468b2bef6154d0fc5d280e26a59fb051dc29

Ciao,
Johannes
