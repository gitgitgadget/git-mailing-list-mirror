Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BCC62018E
	for <e@80x24.org>; Fri, 12 Aug 2016 07:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbcHLHJ3 (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 03:09:29 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:14964 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbcHLHIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 03:08:49 -0400
Received: from localhost.localdomain ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id Y6ZUbGDs4xR4bY6ZWbadhJ; Fri, 12 Aug 2016 08:08:02 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=xtxXYLxNAAAA:8 a=4EMVubCEdPEOI01j8WIA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 03/12] doc: show the actual left, right, and boundary marks
Date:	Fri, 12 Aug 2016 08:07:40 +0100
Message-Id: <20160812070749.2920-4-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160812070749.2920-1-philipoakley@iee.org>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160812070749.2920-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfEoQKtNQBEtCd5pVQ8exkJ0Rz5j81saDuwMQM8U+w6KyCvXJmDCKqggxZUVuJS2fx6OIm1t++uZlZPqAO95AMJic6wW9uEf7sxgjNqJMUJ5sCFg/7ynV
 rJp4cNZifuMWGtbILg6HltvUtDOatzzA8Bc6GNOXdtYuiew3uM55mWwdP/z0ExsN6nv3hTftkhofz2IGRULktoH1F09IyfwESU0=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
Found while checking the 'symmetric difference' documentation
Unchanged from v4
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

