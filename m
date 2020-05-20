Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37424C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 21:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B222084C
	for <git@archiver.kernel.org>; Wed, 20 May 2020 21:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lYKvDbjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgETVjf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 17:39:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:58881 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgETVjf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 17:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590010773;
        bh=xDqTCRnro5zJO42g1KFmkx/fH3a9nZgVH+/0Ub/Sn4U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=lYKvDbjsq4kI/ojj7auKUJxNV7tjSjRjB+ewFD2LUlCo0NzBRNu3rIl15rQqIA6GZ
         La0K9Hsyri1wNoEwpSp6DbYws7AqdFA5OVJ7i3FhtfYKswVU26r4jLgcnK5ebe9Rf1
         TjF39dBw0/KP0BjNX5yZgoVge8SBkT04oAS+rGNc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az767.rzbn4we0c4ievewsxya50hlfqb.bx.internal.cloudapp.net
 ([52.168.181.181]) by mail.gmx.com (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1N7i8Y-1iyO190Mde-014hQy; Wed, 20 May 2020 23:39:33 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.27.0-rc1
Date:   Wed, 20 May 2020 21:39:30 +0000
Message-Id: <20200520213930.6257-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:7a7nwNNX4VmhJnO0c2/w/pGhOYW83d4xdBvM+vPf0g/Y7zkAv7U
 LpqbMyq1N+H5iasoAOy2n+coD98h7jNk1QnYKMW8H+GmHPNBRZWTE35UJcDEMJBxyxUT/Nu
 aEXKWM7ClVpTu2rYaaV2yX0bTFAiGnt9Ybl9HmaNSoMnbbFYIw3rL7LxHSNNmr7JZtiN9J9
 R5NBkaOf4F+OCZ4jSwQGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jAMWMX6UMOI=:rmjiccFsHU+pD6zQeLKYJ6
 sNE/lbVIE/73Z/8BFptLDMzwzpwkP0l55ErQS/45mLbL8yx7CilrmQuIJ0EkLvTZKxKqhNQ5z
 9nC9ht8xSvp9wRC5kokJDzl4n6ed41nDWwRDG2yk/xFTcT+czBuhCXdJAXpK0TO1WVdpTfs8A
 3bqwPcIWymmVE+AbNVrBY9eHGUZmjmVi3UV2qLSPDU8Iigak80UmQ1ms3hqDayB75N6/Zgchf
 OWt+E1sKZWZpPEE2sAP+TaCxCF2VCsncx7nyIZYcVaA8z7iFEuvEGQHZS/LuaucUveyu8P0gG
 l7GcX/5oXKfd3gXqGvCW6yEyA0yFxxKyod6kyEGJx9N/8aRPPioGLjVWhwbmG6ZsCxv2UQk4W
 IMCj7/w8KXO37MGyZgmAZCwF0L0LBF5udmG4g+r6Bj4PzhLRs+TvaOvLZyt6S9yXXOxZp3WI/
 wH7ualNbChPoKLOUpLjGx3tbr5xGS7yAFfoVQ6P/WeHlo/5Mdi1cQ3MVfpk1Fur6/AGoyYRiP
 sTFFKfT4ERKdW1eSVKlojJNlxSpPV2oyNwSJd7z9qsyRtPBtFfgMlmzfAXmIqOzK3VewxYmA4
 VWxpibvbyD4b2vO+K1dijw/vOQaZl9mf9F1f3w98A3jtNNWNLHubmNP6ZiCGx8I6lp7apxFBf
 9svC9pqQzq61/ekkuDtTKRFAFt+xLxevsJDtsbWzZ7pXOX3N4/3cGBWjXy8NLPx59B9ILKHR7
 bSi/BQUyx3lLi5jh1eDuUYjC/yLOMm2NLHwN2nVvVNWLnakvSluSd3sG9ez4Bdbx0NDLlAgYg
 vxHC5MxZGbyIOEBePxTDtY+wR844zCaENWl8aNKqRQ47yohAvJJyR16bOybsQcMagagPnq6hS
 EC8bhOC0TpuNJ7m8mrxrlnpEdlZgoQYwfjBs7VM2D5wshZrVhA7I/8Ur9Dr0sDyfZH7UP9PJ6
 bPdBi/ZTzfIkVZNsoY07qvJNzuGmy/uSa6L+VOWEawZjnLLEtCYWjdNQcpE/eX4oZo8glAyUl
 trnPNeQnUf3OxDFbwFOvRK8IEWXzGu4akf9mvTzlRNFrEp3alFuzw732b8xEltnLLk8hDJJVY
 PZi+UIV2w3zHfmA//5+JE2PinZcGOSDyBtiQZoBvDXBhqfXb8nwbKtEm1Ggnrdz8hMS4DlZr6
 nYD5XmaodixSyHK4eftl3bEVp3FGzO1tPoOPFLqmaXv97XBVky6ZDFtmQg1FItyelnsyp3Hn2
 e9rPdPdR8/rvMS2KG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.27.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.27.0-rc1.windows.1

Changes since Git for Windows v2.26.2 (April 20th 2020)

This release comes with a Git Bash that optionally uses Windows-native
pseudo consoles. Meaning: finally, Git Bash can accommodate console
programs like node.exe, Python or PHP, without using the winpty helper
(see Known Issues above). Note that this is still a very new feature
and is therefore known to have some corner-case bugs.

New Features

  * Comes with Git v2.27.0-rc1.
  * Comes with OpenSSL v1.1.1g.
  * Comes with cURL v7.70.0.
  * Comes with subversion v1.13.0.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.1.4.
  * The release notes have been made a bit more readable and are now
    linked from the Start Menu group.
  * The Frequently Asked Questions (FAQ) are now linked in a Start Menu
    item.
  * Comes with Git LFS v2.11.0.

Bug Fixes

  * Some Perl packages (e.g. Net::SSLeay) that had been broken recently
    have been fixed.

Git-2.27.0-rc1-64-bit.exe | d83c8ba3da0bf7057236147c5af5104ba7011beeeab5c7baa295bf814910915d
Git-2.27.0-rc1-32-bit.exe | 618b510e00513256ddf9d00d4dd7f295f703144cfdfcbe5629849fb644543519
PortableGit-2.27.0-rc1-64-bit.7z.exe | 170849bf055768d597ec28028229dc0908bde9153a0d2bf773043f72b6c5d38d
PortableGit-2.27.0-rc1-32-bit.7z.exe | 4b37e334f95469305e326e52d1932c12c5be182d209e5a7860d364ee6ae4d49f
MinGit-2.27.0-rc1-64-bit.zip | 22710025b8fda8c7a6566b32215cb796de586d433c6edd0321100db71b2dd9a9
MinGit-2.27.0-rc1-32-bit.zip | e4ecec19ca697eb8f3413cfaf9aacbda33377d340fb5aba9e733f5154f1dd17e
MinGit-2.27.0-rc1-busybox-64-bit.zip | 562f9515aa05a835d7261584fc3b1accee5a3d9e8a6ef2c29ceb733b53f01b22
MinGit-2.27.0-rc1-busybox-32-bit.zip | ffed782bd3f068e5ec064a022a979b1256a78f3977ac659a13bc52ab307a88a1
Git-2.27.0-rc1-64-bit.tar.bz2 | 58332ba5a048724d616c3108ffbba0320aca5d9f63e0f191ee8f224e01f107f0
Git-2.27.0-rc1-32-bit.tar.bz2 | fbea3701e4267d2f6895f57b7ff21440c291f753ce1a15b1ed729a8a341e512b

Ciao,
Johannes
