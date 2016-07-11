Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4CDE1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 20:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbcGKUZg (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 16:25:36 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:60970 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964AbcGKUZd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 16:25:33 -0400
Received: from localhost.localdomain ([92.22.73.13])
	by smtp.talktalk.net with SMTP
	id MhlcbLEzMY8RwMhljbR8ma; Mon, 11 Jul 2016 21:25:32 +0100
X-Originating-IP: [92.22.73.13]
X-Spam:	0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=R5CpdR+gL2+IAQkTIkP0Ow==:117
 a=R5CpdR+gL2+IAQkTIkP0Ow==:17 a=xtxXYLxNAAAA:8 a=nOBXlB7yw2htNP6sz7oA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 7/8] doc: revisions  - define `reachable`
Date:	Mon, 11 Jul 2016 21:25:17 +0100
Message-Id: <20160711202518.532-8-philipoakley@iee.org>
X-Mailer: git-send-email 2.8.4.windows.1.3.ge328a54
In-Reply-To: <20160711202518.532-1-philipoakley@iee.org>
References: <20160630202509.4472-1-philipoakley@iee.org>
 <20160711202518.532-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfJHVv1GifgQixJrP28p/CUAT1FPDXvU3jg8301oEY9np0llNbthdt7NQ3MBKFkv0sRRFrpeKPi3m0h/sw0cxG6K5SxR51ngzvUv1JSVKLhmIWDFXht+Y
 0Pp7x0CTKpcr1qX8YAibr/nXLRbaeZxKsgqjoIbKLz+XifeIwxWjU7H3jAAs9uoFmCEcMckcNxVohQSq0XRgJCUneKOvV0Up49wQKW0y7pnCdeCk6RsVNPZP
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Do not self-define `reachable`, which can lead to misunderstanding.
Instead define `reachability` explictly.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/revisions.txt | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 1c59e87..a3cd28b 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -237,10 +237,16 @@ SPECIFYING RANGES
 -----------------
 
 History traversing commands such as `git log` operate on a set
-of commits, not just a single commit.  To these commands,
-specifying a single revision with the notation described in the
-previous section means the set of commits reachable from that
-commit, following the commit ancestry chain.
+of commits, not just a single commit.
+
+For these commands,
+specifying a single revision, using the notation described in the
+previous section, means the `reachable` set of commits of the given
+commit.
+
+A commit's reachable set is the commit itself and the commits of
+its ancestry chain.
+
 
 The '{caret}' (caret) notation
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.8.4.windows.1.3.ge328a54

