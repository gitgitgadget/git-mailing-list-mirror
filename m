Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A741E20798
	for <e@80x24.org>; Sat, 14 Jan 2017 12:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbdANMJv (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 07:09:51 -0500
Received: from mout.gmx.net ([212.227.15.19]:51069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752075AbdANMJu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 07:09:50 -0500
Received: from localhost.localdomain ([37.24.141.236]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MA8hF-1cHgqe3Sqv-00BKwT; Sat, 14 Jan 2017 13:09:46 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.11.0(3)
Date:   Sat, 14 Jan 2017 13:09:32 +0100
Message-Id: <20170114120932.4124-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.11.0.rc3.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:qLP0hArww0JoqprX5o5UYK/u1sokN844vhOQKFIJNp4XGCt8i3+
 clfpK3r1joVTOlY0fvayqp2uLzwKuxy1wKCgDXR/0iZ5So/BvzCvbZOPEJCVfAiBq8ez4Z5
 yagynluOn2eGSYr0crl9FJ93jV+Kv1fqNI7iqlg9Cfu8Ca1AHwyW0oTmKBfcDsmZ6RdjDel
 g9IbALpKfnV/879G2OpBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e5+4x1Oe4eY=:gz6817kF90OrEt4YDr8l1x
 VKWHZ6bf46RVvhMcbYBXsEHzJZyBGjw0R964n03SGM4vy09LfQXoz8ff0qAqFVsKa9bTT98NN
 /o2nNK7ixDZSbxJyPm+Dr2yUWN/Pt8A+mv17NoawiS7ueKXq75pBHu35cItnVeYZklCJozB0/
 28uvNoCA3C3qIl+8AoltjIVc2ojg7bDY1bRIC3glATxkzRc3JJev9g8cQgwAAkI7c3l6iUIVV
 pHTQ7jNsi45LoUVb2hKvzIFGkXxHkumt9oasK5+ZhxbV2+rG0c22o20vHPP6vN++p+j/h/GmC
 T5YDlFRusDq0eeavqcYqpfUTIC3WLg8+UpLgiUKVh/xlg5cw1JMkId+IVLGtS0uBoV0ZMP8Ls
 O/O/gu9GtIpBR96+c7a7brwSAds7rzQUVptLcPE4nP+RsHDRWeREvqfK4V6LlPVfDcrORxIBC
 Gb5IL0QcKBCuIPXpHMljK8TFB3xFVH/n90z8h+YyprhBM1ieZNi3tddRCkbD1B95IacuULAxm
 JZ9Ezor4eeG1MUcRM/m+Q4tegl2UtHSmbhaWvQ4caP/Keijpt6coxP1xZxaLoOWHImdVyWkI+
 NPuas/ZVDqhbLOqO3cK5Zc2PNYpoK7q8ld/05TKP+hzi34EWr3woPNF6h566ERfsIgsZIIIvy
 m2kiw+yQ+04q/NvhGcHfeTomq9u6brkjQ0jIER04Sm285S6F/AL3DDPNLdLbMgNrPznO4ksfY
 pbasjgf2/S8TcrlRwq+kCYNDyjOT08TIzeA0iALUYjkyOmZmmoGQPEKLyK6JOpuvjpUOKW43q
 j0uTLEH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

MIME-Version: 1.0

Fcc: Sent

Dear Git users,

It is my pleasure to announce that Git for Windows 2.11.0(3) is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.11.0(2) (January 13th 2017)

Bug Fixes

  • Fixed an off-by-two bug in the POSIX emulation layer that possibly
    affected third-party Perl scripts that load native libraries
    dynamically.
  • A regression in rebase -i, introduced into v2.11.0(2), which caused
    commit attribution to be mishandled after resolving conflicts, was
    fixed.
Filename | SHA-256
-------- | -------
Git-2.11.0.3-64-bit.exe | c3897e078cd7f7f496b0e4ab736ce144c64696d3dbee1e5db417ae047ca3e27f
Git-2.11.0.3-32-bit.exe | dff9bec9c4e21eaba5556fe4a7b1071d1f18e3a8b9645bffb48fda9eaee37e62
PortableGit-2.11.0.3-64-bit.7z.exe | 41a4ab3a1f0c88a3254b5a30d49c0c6e4ef06c204ddce53e23fc15d6e56f8d24
PortableGit-2.11.0.3-32-bit.7z.exe | 8bf3769c37945e991903dd1b988c6b1d97bbf0f3afc9851508974f38bf94dc01
MinGit-2.11.0.3-64-bit.zip | bf3714e04bcbafb464353235a27c328c43d40568d6b2e9064f1a63444b8236c5
MinGit-2.11.0.3-32-bit.zip | db05d5e98ef1017dd07f27fa4641dc8c0d66ba09da5a196ef656e7f1d7c078e2
Git-2.11.0.3-64-bit.tar.bz2 | 65296c54f0b8294374547cc6a169d6ea95178e12dee04cd2d4632f39d8fe7852
Git-2.11.0.3-32-bit.tar.bz2 | 0f0e2f78fc9b91d6c860eb7de742f3601b0ccd13c5c61444c7cf55b00bcb4ed4
Ciao,
Johannes














