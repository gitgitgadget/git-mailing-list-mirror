Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEC851F744
	for <e@80x24.org>; Wed, 20 Jul 2016 21:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201AbcGTVK3 (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 17:10:29 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:44467 "EHLO
	smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761AbcGTVKY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 17:10:24 -0400
Received: from localhost.localdomain ([92.22.79.77])
	by smtp.talktalk.net with SMTP
	id PykwbXvjRHGLwPykzbEmcp; Wed, 20 Jul 2016 22:10:18 +0100
X-Originating-IP: [92.22.79.77]
X-Spam:	0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=YfJyJ16zsu2qLTmLoX9DvA==:117
 a=YfJyJ16zsu2qLTmLoX9DvA==:17 a=xtxXYLxNAAAA:8 a=4EMVubCEdPEOI01j8WIA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 3/8] doc: show the actual left, right, and boundary marks
Date:	Wed, 20 Jul 2016 22:10:02 +0100
Message-Id: <20160720211007.5520-4-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160720211007.5520-1-philipoakley@iee.org>
References: <20160711202518.532-1-philipoakley@iee.org>
 <20160720211007.5520-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfASWNeGta+Su5kA5zjODLSNmYwjXLIvPTeeSouMg52L/Bs0+Rlr6X1BxeP9nIL/O9bsbhQhzTG3IdohaQX/56WUh6rCYhJkmqVZBA2RTEPlARKj/Uxf9
 96huvuaOF67UYpZfw0Ww0+Bqb+2TbilFiy3UOD2ExpxIlVguvf5R5/kxruM6XyMmDeIUsfjceETecx2JrLjCS6YYEmOYDmjTdWb/SkrDmz1roSK/LfvvfprY
 CkO12aWzkMapYrI2QftLqJ1JPbGsgEbcrhlbv3i3mP9gqfMm6S5bX028u9S1Aaht
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
2.9.0.windows.1

