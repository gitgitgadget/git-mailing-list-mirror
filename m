Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 998C420179
	for <e@80x24.org>; Thu, 30 Jun 2016 20:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbcF3Ulb (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 16:41:31 -0400
Received: from smtp-d-6.talktalk.net ([78.144.6.134]:31455 "EHLO
	smtp-d-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbcF3UlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 16:41:19 -0400
Received: from localhost.localdomain ([2.96.205.30])
	by smtp.talktalk.net with SMTP
	id IiWUbMHWfgKstIiWVbS4Fc; Thu, 30 Jun 2016 21:25:20 +0100
X-Originating-IP: [2.96.205.30]
X-Spam:	0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=QTrtdgWXx+RZbj7kV87ZQA==:117
 a=QTrtdgWXx+RZbj7kV87ZQA==:17 a=xtxXYLxNAAAA:8 a=4EMVubCEdPEOI01j8WIA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 2/4] doc: show the actual left, right, and boundary marks
Date:	Thu, 30 Jun 2016 21:25:07 +0100
Message-Id: <20160630202509.4472-3-philipoakley@iee.org>
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

