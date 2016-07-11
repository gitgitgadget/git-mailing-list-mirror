Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 606711F744
	for <e@80x24.org>; Mon, 11 Jul 2016 20:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbcGKUZg (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 16:25:36 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:8443 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbcGKUZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 16:25:32 -0400
Received: from localhost.localdomain ([92.22.73.13])
	by smtp.talktalk.net with SMTP
	id MhlcbLEzMY8RwMhlibR8mQ; Mon, 11 Jul 2016 21:25:31 +0100
X-Originating-IP: [92.22.73.13]
X-Spam:	0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=R5CpdR+gL2+IAQkTIkP0Ow==:117
 a=R5CpdR+gL2+IAQkTIkP0Ow==:17 a=xtxXYLxNAAAA:8 a=aPQgYVu9WxExC_ZTeUIA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 6/8] doc: gitrevisions - clarify 'latter case' is revision walk
Date:	Mon, 11 Jul 2016 21:25:16 +0100
Message-Id: <20160711202518.532-7-philipoakley@iee.org>
X-Mailer: git-send-email 2.8.4.windows.1.3.ge328a54
In-Reply-To: <20160711202518.532-1-philipoakley@iee.org>
References: <20160630202509.4472-1-philipoakley@iee.org>
 <20160711202518.532-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfE+W9W4twk9wtfAdxBDSq/ilFhU6Ksn++myvQecC7WD9PzepTL3eTuXVUBdU3QVbKcKw2WW/E3W+XEXfLvmEDykPCRTkaKD7TaF61mVQZKu2af0was49
 fX0hlbuTsM7C0XZA+qai/I4WC8KQ+RyX7IkupRfUlxxlvq4eV2qJKmUCuNyWPfeFDE7i3xlEN2gfZPCswLv+bJYhfNioKLBdNiPKEjUC3I/0x6SvaCnkIUn7
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The prior sentence has too many clauses for easy parsing.
Replace 'the latter case' with a direct quote.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/gitrevisions.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitrevisions.txt b/Documentation/gitrevisions.txt
index 33039c6..27dec5b 100644
--- a/Documentation/gitrevisions.txt
+++ b/Documentation/gitrevisions.txt
@@ -16,8 +16,8 @@ DESCRIPTION
 Many Git commands take revision parameters as arguments. Depending on
 the command, they denote a specific commit or, for commands which
 walk the revision graph (such as linkgit:git-log[1]), all commits which are
-reachable from that commit. In the latter case one can also specify a
-range of revisions explicitly.
+reachable from that commit. For commands that walk the revision graph one can
+also specify a range of revisions explicitly.
 
 In addition, some Git commands (such as linkgit:git-show[1]) also take
 revision parameters which denote other objects than commits, e.g. blobs
-- 
2.8.4.windows.1.3.ge328a54

