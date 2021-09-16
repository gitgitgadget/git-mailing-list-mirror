Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BE0C433FE
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D7B261207
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhIPWrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:47:40 -0400
Received: from lxh-heta-043.node.capitar.com ([159.69.137.90]:45338 "EHLO
        lxh-heta-043.node.capitar.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234289AbhIPWrj (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Sep 2021 18:47:39 -0400
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 9ABEB1B35F;
        Fri, 17 Sep 2021 00:46:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 1F51C1B1CF;
        Fri, 17 Sep 2021 00:46:17 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u6pOEjqPBs6N; Fri, 17 Sep 2021 00:46:16 +0200 (CEST)
Received: from neptune.setarnet.aw (unknown [186.189.145.201])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id 2C25E1B4A4;
        Fri, 17 Sep 2021 00:46:14 +0200 (CEST)
From:   wesley@schwengle.net
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: [PATCH] Document `rebase.forkpoint` in rebase man page
Date:   Thu, 16 Sep 2021 18:46:03 -0400
Message-Id: <20210916224603.2912887-2-wesley@schwengle.net>
X-Mailer: git-send-email 2.33.0.364.gff7047fb76
In-Reply-To: <20210916224603.2912887-1-wesley@schwengle.net>
References: <xmqqtuikrzca.fsf@gitster.g>
 <20210916224603.2912887-1-wesley@schwengle.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=LbpCFQXi c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=NgX6OPfPqt74TpVTvcPRng==:17
        a=7QKq2e-ADPsA:10 a=N3miCFJ7AAAA:8 a=q-l5Lz1Us0sBhM_fuL0A:9
        a=V5H4rQgsk92nlYCD-KPC:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Wesley Schwengle <wesley@opperschaap.net>

The configuration option `rebase.forkpoint' is only mentioned in the man
page of git-config(1). Since it is a configuration for rebase, mention
it in the documentation of rebase at the --fork-point/--no-fork-point
section. This will help users set a preferred default for their
workflow.

Signed-off-by: Wesley Schwengle <wesley@opperschaap.net>
---
 Documentation/git-rebase.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 506345cb0e..c116dbf4bb 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -446,7 +446,8 @@ When --fork-point is active, 'fork_point' will be use=
d instead of
 ends up being empty, the <upstream> will be used as a fallback.
 +
 If <upstream> is given on the command line, then the default is
-`--no-fork-point`, otherwise the default is `--fork-point`.
+`--no-fork-point`, otherwise the default is `--fork-point`. See also
+`rebase.forkpoint` in linkgit:git-config[1].
 +
 If your branch was based on <upstream> but <upstream> was rewound and
 your branch contains commits which were dropped, this option can be used
--=20
2.33.0.364.gff7047fb76

