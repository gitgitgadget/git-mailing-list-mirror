Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E142FC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 10:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9BE360F58
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 10:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbhHQKbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 06:31:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:48499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234093AbhHQKbM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 06:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629196237;
        bh=66dLCtgmHj6LMEzpRxTHo8nqjdrX+X7+AtlBV8yK82k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=RTzq/qpb2A3KhjQFzWvc1dR4mOdCsyrNOxYVmL9iwJOLs2JIppaRDSAYblxPPeL3o
         tu3MkSnE+bm91uYe4RVi1IgfW8145B3197S1fvJewI/BrUGtIWePC+DAc1FdfZA0MN
         +nPHqitx89olQ4WT/jUneusUeumL0xGvYRyAjRbA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az53-998.tt11xfkzbotebkioxoimtk40sh.cx.internal.cloudapp.net
 ([20.110.14.8]) by mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MNKhm-1mQSs31LCc-00OnhP; Tue, 17 Aug 2021 12:30:37 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.33.0
Date:   Tue, 17 Aug 2021 10:30:34 +0000
Message-Id: <20210817103035.5482-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.33.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:fxLdh0TIq6T+RhzW0FmOnWAMDYg5QRCEKNni43IjwGy+stkIxVq
 lX5T5N4rLRptGr9Lw9eROhkgZ02IKI7QncR3DLl66HHneC8CzcpxJ61ToPCHX+JUI8Vxcnc
 GX5H3XSnFilRkgRTjf/JU6RxhAVGv4rzm2GOhCuWS5eh09X8XIf0Vk3A9aTjHYfIxBVV/Br
 W/SUtxehkHcbTPoDUGdDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sw+tQqAIigA=:fPoxlCsiGav+HYQoFPg2kS
 PTdgQcdHvkJt7eB4N4yIatxBSG0SbbG5tcVz7MkQJ9fnzbmHxk2vfG/nf04WllBBRtLxXv1ye
 HZgpkKTO36pf/4Cm0LNPsCfE807GpL6QcF9uhAenIRjdTBZgdlvLSxYYrJWNUGf+6ZvMir1W0
 MOleP5kkDbG4pjqk3kelUL9mfQNiumtxd/3qBXlYW9d+RzVzLxYk8thv4TPRs+FZAOUPDebMn
 EaB6hBYmD0RclxxLvkYy7bTRvKntyQznEWiHzcrCsQathM48bhDtqfZ9DzY2RpeHuZImspmJg
 TIjfd3Ec1qSJZcw/fOLvf9BkJeTY78pBYOYw+72dVckobARfKJpjhOt2ofCPrOpCjRctaOzm1
 ETzs46YGdMs4vzmsruKEKUHStn6k2nT4EsQ46DRCgCNVJEyhdtJP1RLsaD8l9O00qIuYAUdy5
 eeIFdNPTFYWJ6fclg69utnLxb/IBlNVTiehcZRn3sX6+nPu1UapF0TYBJ7RqH6iqG+ddo4tLI
 JFzaH+vbxorgp72bJz57V4YHxm5jq6loRWa3J5JIJ9zwH1dSHmTP4rTCkCXihpxc3LFgJRIsB
 nkX6xxGd78yBhHZKxSRHkwT0vtDWrtrnydSLKpB6AbQAFp8QisTUSr+aSV6DW/SeqtHiCvvuC
 gMP7wC4NEmGtvR/rM3UiviqV1X5yOTxmCNAdyCaCyveSwm5jmceTCzbM4IXTtQ584ql4X2t2s
 X8N9xClck4d1rKBgxu9sr3xqP7S1nj0L52qJjFWVeOQoONEND4Cbi5BJDqLESiWstFVIvjhIc
 jSgDoUGy620xn7bo2El4f2T8hO5QklEGGPzoqvh9Ozl/RtyfRCDkrJ+akjtnnVuncidAkawYj
 yORV9zO8ti4QctgpsZNlqZ+ltS8W0MSDFItrjV6VPZRXgqQS5O/oytQbsFF/orZ9wRW+fTkED
 UGfCzurJFwmtWMrxZTIRFxdNR0/cIyMZ9E/vbKkv9RMl+0gVa38h2IOPsJOiUeAIGRhr3pcNf
 T6dTNNxSaRpcLK3cOtZ2beKZF1oDNMiwEY7ccvoTWJojX/Q+IZaa4DLVPumTr/Klf5uMv9CmN
 MP2SrNWoCa9LNfr/4Kko7Qi3YZExY6pPkpDBxKjFX6aCaCk7OZCr4A7SQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.33.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.32.0(2) (July 6th 2021)

New Features

  * Comes with Git v2.33.0.
  * Comes with Perl v5.34.0 (and some updated Perl modules).
  * It is now possible to ask Git for Windows to use an SSH found on
    the PATH instead of its bundled OpenSSH executable.
  * Comes with Git Credential Manager Core v2.0.498.54650.
  * The experimental FSMonitor patches were replaced with a newer
    version.
  * Comes with GNU Privacy Guard v2.2.29.

Bug Fixes

  * The installer no longer shows an error dialog when upgrading while
    the Windows Terminal Profile option is checked.
  * Interaction with the git repo tool was improved.
  * The version of GNU Privacy Guard (GPG) bundled in Git for Windows
    did not work in 64-bit setups, which was fixed.

Git-2.33.0-64-bit.exe | 4e6e0efbb7d35653907175f2735386f55b72d37d442b3a1be9656c26f69c693d
Git-2.33.0-32-bit.exe | 715cfc104c249fea591ab1fb6ba56f970405cdfcebf11798eb02175a3178d879
PortableGit-2.33.0-64-bit.7z.exe | 12c10fad2c2db17d9867dbbacff1adc8be50868b793a73d451c2b878914bb32d
PortableGit-2.33.0-32-bit.7z.exe | c3b6f1a8f8c1b5be2175b7190d35926dce07a58294780291326a437ef0694676
MinGit-2.33.0-64-bit.zip | 220e4606ec857d44f0ce67610bd8194f1c3779fbf85c801e945842e6f1732bdc
MinGit-2.33.0-32-bit.zip | 55e15a351dff1ad327dbf82d47bbd08a19ccc42b2d1b21c5fffe48fa4da3a623
MinGit-2.33.0-busybox-64-bit.zip | 9e2837a0c8225e399e178171c8134f63b38242936cdb51a1400d88b7cfec9d9b
MinGit-2.33.0-busybox-32-bit.zip | 163da52a7208438cd94b611d36809c084cc941dd9bb3e5f683d9d3513f95465e
Git-2.33.0-64-bit.tar.bz2 | 9ec6c3f22ff105f572a0f4de7b3273a5fdc463e8b8dd8334bf4d467a3198e53e
Git-2.33.0-32-bit.tar.bz2 | e50c1e88cd2549aa57137a8ecf8e65b709a35d120a590ff3ac93c415eebe9efd

Ciao,
Johannes
