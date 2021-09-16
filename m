Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543C0C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 12:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C60610D1
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 12:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbhIPMs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 08:48:57 -0400
Received: from lxh-heta-043.node.capitar.com ([159.69.137.90]:50160 "EHLO
        lxh-heta-043.node.capitar.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239672AbhIPMs5 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Sep 2021 08:48:57 -0400
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 6755A2952B;
        Thu, 16 Sep 2021 14:47:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id D2F6F29372;
        Thu, 16 Sep 2021 14:47:34 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id f7DoZgjFLKIR; Thu, 16 Sep 2021 14:47:34 +0200 (CEST)
Received: from neptune.setarnet.aw (unknown [186.189.145.201])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id 45CF829529;
        Thu, 16 Sep 2021 14:47:32 +0200 (CEST)
From:   wesley@schwengle.net
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com
Subject: [PATCH] Document `rebase.forkpoint` in rebase man page
Date:   Thu, 16 Sep 2021 08:47:09 -0400
Message-Id: <20210916124709.2824551-2-wesley@schwengle.net>
X-Mailer: git-send-email 2.33.0.364.gff7047fb76
In-Reply-To: <20210916124709.2824551-1-wesley@schwengle.net>
References: <c7949156-a7e5-085f-4779-82d0538a4d72@schwengle.net>
 <20210916124709.2824551-1-wesley@schwengle.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=LbpCFQXi c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=NgX6OPfPqt74TpVTvcPRng==:17
        a=7QKq2e-ADPsA:10 a=N3miCFJ7AAAA:8 a=hSZ6u2rxkKINWkIZw88A:9
        a=V5H4rQgsk92nlYCD-KPC:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Wesley Schwengle <wesley@opperschaap.net>

The option exists and the rebase behaviour tricked me into thinking
there was a bug with git. This will tell people how they can tweak the
default behavior.

Signed-off-by: Wesley Schwengle <wesley@opperschaap.net>
---
 Documentation/git-rebase.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 506345cb0e..8d2bee3365 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -446,7 +446,8 @@ When --fork-point is active, 'fork_point' will be use=
d instead of
 ends up being empty, the <upstream> will be used as a fallback.
 +
 If <upstream> is given on the command line, then the default is
-`--no-fork-point`, otherwise the default is `--fork-point`.
+`--no-fork-point`, otherwise the default is `--fork-point`. You can over=
ride
+this default by setting the configuration option `rebase.forkpoint` to f=
alse.
 +
 If your branch was based on <upstream> but <upstream> was rewound and
 your branch contains commits which were dropped, this option can be used
--=20
2.33.0.364.gff7047fb76

