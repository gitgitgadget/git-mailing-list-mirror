Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0774EC433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 22:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7AE464DF4
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 22:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhCOWFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 18:05:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:38433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230469AbhCOWFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 18:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615845923;
        bh=xb+dd8CPBASYATELBqhgrv9sn3geEmSp3F55CnBKFfI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Ukb6dKioWYw+Lj4PSBgsAF1If3Rbrj6KoGDGEdRzn9fimGEv2w8njrydm/3JNJ1e+
         ZyY+tkRtV50bSARYqtX7Sh/5sSqHAjOqlUiXxVcNd7n7e0XOWnL6Oo8KZkZ0MrgwMS
         fCDnX3g6R5G+nRcfDArm7p6R8WmqHNWZJRqZMWVc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az54-428.1rh4tyythb4e1e04jwdqzyaxch.cx.internal.cloudapp.net
 ([20.36.178.181]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MpUYu-1m4tfL1pCG-00psuV; Mon, 15 Mar 2021 23:05:23 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.31.0
Date:   Mon, 15 Mar 2021 22:05:21 +0000
Message-Id: <20210315220521.7128-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.31.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:wk37QwGHW8c052zdmj8a4Dq5uwKyMHxZNo1mnVHV/Lif2xCKoLL
 ZT1JjfVu7iSiyhEC+1xsknpPuGLkKVcURHbeYzZR365ZHUnXK4nRih1b87wxG/4u958OQB2
 BFgQIaMo2nMzoqxmvf3YdPbn1uD4IBR1PJg6213ZK/GfNrhFckOFcuvypZmlYJkEvY+d4zW
 mFrMFauMjRgckgDmwurYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KmFLmLO+lRc=:nKdNXHTVu50EGCPjZ6WO1K
 1/UQzIWJuZHcBA3NH6cY5KEgFyV4XedroemQb6/YPmhPcXDb4xUQVdJcZQyowF3qslvOq7YX0
 ifowwJWLgAdWNza+5PyXGWqS+SvRBYj/ubf3ImEDC5yJSUiWw4qVqIHqBEDr+JG7XFeX8F3OJ
 JDycij8awB5bFiumE51q5MZG9VlfQBRHvKalke2zKgtoCkameTGdmraCt6FNXOeoAEudezFoB
 Xw0ZV6NcwRmg6OhTee6/s1xXY2eOE4oe1UZB88d/csFTEI4JgXAdKiXpeM8pSnY4q36BHTGj+
 uzwkp2gBJxydq4a7z9A2gASmXvTI4KhnEWC6TA65/uRwgA/ZWQTruzz8+rHS3B/W1q1guygZ9
 fZ+bKU/BExUGjvOx3F9wpT8xM/beHJ4nC/XYJGkCC7ehvRybqmRS6V+40N6PHqoji1zvISMX2
 kKiUBxxdAb5+YsS4arHs82k3J0fBA1EMIKYj3idPg9vci0cPsFuxAkzOdR4/EE3vr1a/KP5d1
 NYbgP6Gu6tKY7cjT0+YO/bX18okKENWSZaI0ptlmLpd5PK5v7x+aviC3aThIVrC9BmCpJUZe8
 Y+pF4PhK6jfWOaSayGW/bWFgHVVVB/vXFQENTq96pnGnOAMAvERrsrYyB0bpOlvDO0oA8nCSi
 Ua+yp5PdaOG2BiWszYsRe8idrPnkBK2MvC7eVpOr6+J8M91DVxdf+5BQSQViIWEfEea1rPV0h
 rf8xVea7gbBZaF+fjzOY+Wh8ZQGel2Ntu6M9Im+iqEMtc/F/yBTVEBOM7fkKFlHuGYqwa/Zjm
 Xy4YKWt/brECMpjtPZQo3aRl8Yf9Sn06JkIedFC8VQgh12GPWoNgcYjVBRkmEgp+v2GLoke0n
 FjantKZ66m3RJWpohqqUbjQtsI/OM40qWDH/wAANk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.31.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.30.2 (March 9th 2021)

New Features

  * Comes with Git v2.31.0.
  * Comes with OpenSSH v8.5p1.
  * Comes with tig v2.5.3.
  * Git for Windows now ships with an experimental built-in file-system
    monitor, without the need to install Watchman and setting
    core.fsmonitor. It can be turned on by setting both
    feature.manyFiles=true and feature.experimental=true (or directly,
    via core.useBuiltinFSMonitor=true).
  * Comes with Git Credential Manager Core v2.0.394.50751.
  * Comes with GNU TLS v3.7.1.

Git-2.31.0-64-bit.exe | baedde203f1d3f2aea68981a9d8da26f0f9ef77684e46e7d6708badc91f6dea0
Git-2.31.0-32-bit.exe | 2d5e438154debcc24e4e97660cb98480e290a8934be9a538d9c18aacc01a019d
PortableGit-2.31.0-64-bit.7z.exe | 2ee5489f844362f6b079be7aa0811abdbe99b4538d66485ca996da2d144fb466
PortableGit-2.31.0-32-bit.7z.exe | 24d594b284cef66b9fa6c6be17896e83381707870d7771b9bd5fc91c6c1568b8
MinGit-2.31.0-64-bit.zip | c470e5dfd3ac4fc257fedb1fd83f67b28977163f3b36dda7b4d57c808e5e2b46
MinGit-2.31.0-32-bit.zip | 9a9fa65b750d8141fe3481727edc7457778e88de83a52e3c8856dfcfb4f506cd
MinGit-2.31.0-busybox-64-bit.zip | 13b0ac2d14b8cc71f24ab69a7241bdee5e661233aa1e6c562619341e8fdef6c6
MinGit-2.31.0-busybox-32-bit.zip | f71e4080355da593139cec6e12e054c4e45227cfcfee8ce2eed89798bec95510
Git-2.31.0-64-bit.tar.bz2 | a5723d9307e044ab9f20f3d43fd014bc6506378da869c98370d3a98b3de7017f
Git-2.31.0-32-bit.tar.bz2 | faff066b2bb4d7640c6a873c87208514218741c201b67b96eacf11be59d9ae1c

Ciao,
Johannes
