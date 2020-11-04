Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D075C4741F
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 23:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC9A206E3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 23:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Sa+ROYCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387712AbgKDX6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 18:58:34 -0500
Received: from mout.gmx.net ([212.227.15.18]:44175 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387700AbgKDX6M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 18:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604534289;
        bh=wFZ3A6L39yOtR1sSc9XSiNFnLMvIuLklWM/XzZ5R8Qw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Sa+ROYCwZ6GMxlXIM7IUFjFoVRFdkulYxJjRuylcVAOc3b8u2nsfUBtXixsOssIVI
         jNs2U0v2BKNQ+kTukZOlcfmECK0gwuIEov173+vmpvLn5cA4SmCRe7nNOiWl2rIFoe
         fbiF/vv9tzdvKLR3Vj4G2MFcfoR/o7990m+L4M/Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az767-723.w41zzgmn0uwudj0uul5e02fssc.bx.internal.cloudapp.net
 ([23.96.39.132]) by mail.gmx.com (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MaJ7v-1koTRs21xt-00WIgz; Thu, 05 Nov 2020 00:58:09 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.29.2(2)
Date:   Wed,  4 Nov 2020 23:58:07 +0000
Message-Id: <20201104235807.7157-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.29.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:6eFp/ciSvNZ7GVBpDDRa+kbAGpaY/WD90/kDUn+BkA6i0Rt6aPs
 TuXwXZ9SvfsTAxfJ66QlR2IwsflGkDOspvB9jKMj+oWggmYCT1Z9QQQ0c0aiot6KpklfG7e
 4TgwE121PgVUMnowe8JmUFSagsOSs1WDKxWFwa3ks3a1hWTEq8rwSO6G1w3oPd+1dtL856o
 4EOOYAG7lgYfoLPLrTZSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UAtZ6aPcs/k=:kt7dIJ0BSOno4r3lE9cRuA
 H7VylZYMuIUZBgcy1yuSN34FLzOv0kJhvDZg170Tkq8lx9iZeP/Yii+6xSUtgavAspFV3/OI7
 J4XFumvra+G6HBs9yU47NNYKXmvoQXi4ovoGGcENK4JwXWdHiXv5kkqXDcaFvt9DP6OhgFpVI
 B7q+gu+twxOYfrjeZyKyk+bV/hnjuOOBlp3cCq/U3CkieXhYNNjlVh80/eDWR0mCE1XGbPieU
 zSMwVBFsB5I923TSZ0HR7Gn6u2hEzpl2UV5j2B5LUB8sqSSFZTQjtEiChtGMdMg+AdwKq/1H/
 42jojRZ3q9YcQu45qZ8ax1BEWPHWgIqvyIOmzbsrFrdXrlBV5ZDPjJ2y4dtK3FLRVULRdkKdF
 vDiEIRSEAmX73hlD53zVB6ZDDUqq4kaDQYe9Oge+9TSX5/gspeocqFhU3ttLiizo6z1ILsrIO
 Fua6c0+cMKo5oGs0dNa5rGSyBPbFl8KaqzJgWPhTBNcpOu7DIgWvnfLFGhlQkxG3m377VBJkW
 U4QRVkFkIvAiZ6Go8QZ09Tk8Tiv1S8JBxhbYTC7JRr/G2BQ4tkWyDvuguMkyQyzjZgo59GB/C
 CZ80h8j/NO3FgGUNRd3PgvcQkc6gzSOwQWc9QBNZzogkJG+0iVphtzj+tKvnMLFAgSCylC0S8
 oyKs9yuDgZJvBC00NusgFwjY9vc/Lf2FavZm2vM8ziNPpL8e+/ktfZJqtCTBNCqN9wpPgTXnN
 neSrO1yyRFg2m94Ud8cNqrtW+Ub/v4FebiRNvL3B4iqckyQCALdJTcI+Ui3mbhayPmuLn0Z/j
 k2WzYbUohrUf+A6I4JBGl6VUy3TiT7DvgjwdUBl5vnH+bcNEtGjyJWoKTN2SWyX+mfNRGBzWD
 04Ua649igJBxxDC7wnKqfSvXqEsRcI9O0YyLB1ZQk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.29.2(2) is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.29.2 (October 30th 2020)

This version includes a new Git LFS version to fix CVE-2020-27955.

New Features

  * Comes with Git Credential Manager Core v2.0.280.19487.
  * Comes with Git LFS v2.12.1.

Git-2.29.2.2-64-bit.exe | 9ab49d93166d430514b0aaf6dda3fdc6b37e2fe1d0df8ecc04403cd2be40e78b
Git-2.29.2.2-32-bit.exe | 0a88d826cd4c66d949c054f5830667896fae44fcb29c1698f7ed984df8765029
PortableGit-2.29.2.2-64-bit.7z.exe | 035bd5e46f1ee797b012801b3ea6c07327ce29720062423d057d4c2d41b92355
PortableGit-2.29.2.2-32-bit.7z.exe | 7479d7de99175e6fc5277fda14af240089bbd96fd60603e517dfb960213a679d
MinGit-2.29.2.2-64-bit.zip | 85943737a4fea3c2146f072379ed893b69ae47b9a3cea9772a3302138885f33e
MinGit-2.29.2.2-32-bit.zip | b498a0bab54340edd75c8483d1a7959d9ef1ddebc3bbb5ec66d82b3021f6bc58
MinGit-2.29.2.2-busybox-64-bit.zip | 1e2f0cad96fe8314a6f3d4a0948d2a7f55e8d554c441b492519be2b1b2636a32
MinGit-2.29.2.2-busybox-32-bit.zip | 42c88ca75122e709dfe72b97afad5b64426961d75001a0a219c0b5620fe60f9e
Git-2.29.2.2-64-bit.tar.bz2 | ee0077dbe362c7a72fd1c6577e8cc29b1c48aace9b403bb8fd21f3abeae85871
Git-2.29.2.2-32-bit.tar.bz2 | df0df082ef7775697dbf920cae057467582a7dba64727b22e8014d532ee6542e

Ciao,
Johannes
