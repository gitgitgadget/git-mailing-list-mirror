Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 887EB1FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 20:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbcF3Ula (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 16:41:30 -0400
Received: from smtp-d-6.talktalk.net ([78.144.6.134]:26845 "EHLO
	smtp-d-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbcF3UlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 16:41:19 -0400
Received: from localhost.localdomain ([2.96.205.30])
	by smtp.talktalk.net with SMTP
	id IiWUbMHWfgKstIiWWbS4Fi; Thu, 30 Jun 2016 21:25:20 +0100
X-Originating-IP: [2.96.205.30]
X-Spam:	0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=QTrtdgWXx+RZbj7kV87ZQA==:117
 a=QTrtdgWXx+RZbj7kV87ZQA==:17 a=xtxXYLxNAAAA:8 a=Db2OWnXkeSJeAGKD5SkA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 4/4] doc: clarify that `^r1` will exclude `r1` itself
Date:	Thu, 30 Jun 2016 21:25:09 +0100
Message-Id: <20160630202509.4472-5-philipoakley@iee.org>
X-Mailer: git-send-email 2.8.4.windows.1.3.ge328a54
In-Reply-To: <20160630202509.4472-1-philipoakley@iee.org>
References: <20160625164654.5192-1-philipoakley@iee.org>
 <20160630202509.4472-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfN8tXlCD5YYqi+z13Dm9ykjWCOoE2yPbyzTr63XBEKpQfg8BDLnp1eeriPdqf4AtN+n0OLa5PbX+9t9ccif42Hl2p1a4XOFSCTQEtGKObIPc7qy/JY/m
 5p0CVgT5DI66/JIy5fXsDcWl3eugn8tHcYjEmWS9lUTqiUQfPyFMoAWVikZLuMD4ECvpd6yXnhEraPykbWSLhm8CNWL3KI9OJbl9+OCYvu85Kcaa/guZVcow
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/revisions.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 131060c..87be9c4 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -246,7 +246,7 @@ The '{caret}' (caret) notation
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 To exclude commits reachable from a commit, a prefix '{caret}'
 notation is used.  E.g. '{caret}r1 r2' means commits reachable
-from 'r2' but exclude the ones reachable from 'r1'.
+from 'r2' but exclude 'r1' and those reachable from 'r1'.
 
 The '..' (two-dot) range notation
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.8.4.windows.1.3.ge328a54

