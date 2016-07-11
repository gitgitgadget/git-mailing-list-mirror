Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E4A1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 20:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbcGKUZa (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 16:25:30 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:8443 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbcGKUZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 16:25:29 -0400
Received: from localhost.localdomain ([92.22.73.13])
	by smtp.talktalk.net with SMTP
	id MhlcbLEzMY8RwMhlfbR8m1; Mon, 11 Jul 2016 21:25:28 +0100
X-Originating-IP: [92.22.73.13]
X-Spam:	0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=R5CpdR+gL2+IAQkTIkP0Ow==:117
 a=R5CpdR+gL2+IAQkTIkP0Ow==:17 a=xtxXYLxNAAAA:8 a=4EMVubCEdPEOI01j8WIA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 3/8] doc: show the actual left, right, and boundary marks
Date:	Mon, 11 Jul 2016 21:25:13 +0100
Message-Id: <20160711202518.532-4-philipoakley@iee.org>
X-Mailer: git-send-email 2.8.4.windows.1.3.ge328a54
In-Reply-To: <20160711202518.532-1-philipoakley@iee.org>
References: <20160630202509.4472-1-philipoakley@iee.org>
 <20160711202518.532-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfNwAzFFd+mVJb5pft7uMVwF7hVnzjsAOnCJOXuPrPYkkD2EXjJNqFWAETL5R377bc9T3lYCtoyGnfOHX//J2X00xbop80HEAFd6FJaoEw5zCqzStVoMJ
 aV7YAJCausAVJKXDB6xtufXSWc+p4bFk9jTS2FbPlNPG+ArVNFCYTk/EI3VPFEsaJbtjZKiwwSTfoG4PADiF5BpGqY/0rHS6E8mrPlJhgaE6Wr6UAt3/gDRk
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
Found while checking the 'symmetric difference' documentation
---
 Documentation/pretty-formats.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 29b19b9..10719e1 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -166,7 +166,7 @@ endif::git-rev-list[]
   respecting the `auto` settings of the former if we are going to a
   terminal). `auto` alone (i.e. `%C(auto)`) will turn on auto coloring
   on the next placeholders until the color is switched again.
-- '%m': left, right or boundary mark
+- '%m': left (`<`), right (`>`) or boundary (`-`) mark
 - '%n': newline
 - '%%': a raw '%'
 - '%x00': print a byte from a hex code
-- 
2.8.4.windows.1.3.ge328a54

