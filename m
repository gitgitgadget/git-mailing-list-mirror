Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 840B4202F3
	for <e@80x24.org>; Wed, 20 Jul 2016 21:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192AbcGTVK0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 17:10:26 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:64473 "EHLO
	smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073AbcGTVKV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 17:10:21 -0400
Received: from localhost.localdomain ([92.22.79.77])
	by smtp.talktalk.net with SMTP
	id PykwbXvjRHGLwPyl2bEmdE; Wed, 20 Jul 2016 22:10:20 +0100
X-Originating-IP: [92.22.79.77]
X-Spam:	0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=YfJyJ16zsu2qLTmLoX9DvA==:117
 a=YfJyJ16zsu2qLTmLoX9DvA==:17 a=xtxXYLxNAAAA:8 a=gqYX7573AvRiT2ppeXYA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 8/8] doc: revisions - clarify reachability examples
Date:	Wed, 20 Jul 2016 22:10:07 +0100
Message-Id: <20160720211007.5520-9-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160720211007.5520-1-philipoakley@iee.org>
References: <20160711202518.532-1-philipoakley@iee.org>
 <20160720211007.5520-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfEiy8Z9w3aK1iCtmf52doLsulphB2eCWNNuTXdztUs9kMUbcEBEtFZTPtV8yqruZ676t6ulz9RA0wnS2C8u9vNUKXRV4VFHilh0EP1EiF/1s3YmTqz6F
 gXoyygkNLke9xFYA5oJIRkQ3JFm5eTqx97wx4rlk7XH1O2gFph30bTBcnPChp87VqnQxUVpXP08NNFVDHWhsk7a2ZtV+7/K4T0b3qiFUmewgMvAHeUeKYGcK
 qDdU6dXYoXvz5hkgOb+fN3k32ESvhS1zYE1Bp1YJ6ymkkDPO9VtbVCMufdUxOH66
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

 For the r1..r2 case, the exclusion of r1, rather than inclusion of r2,
 would be the unexpected case in natural language for a simple linear
 development, i.e. start..end excludes start.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/revisions.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index d3b7cee..14622cc 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -254,7 +254,8 @@ Commit Exclusions
 '{caret}<rev>' (caret) Notation::
  To exclude commits reachable from a commit, a prefix '{caret}'
  notation is used.  E.g. '{caret}r1 r2' means commits reachable
- from 'r2' but exclude the ones reachable from 'r1'.
+ from 'r2' but exclude the ones reachable from 'r1' (i.e. 'r1' and
+ its ancestors).
 
 Dotted Range Notations
 ~~~~~~~~~~~~~~~~~~~~~~
@@ -293,12 +294,12 @@ Revision Range Summary
 ----------------------
 
 '<rev>'::
-	Include commits that are reachable from (i.e. ancestors of)
-	<rev>.
+	Include commits that are reachable from <rev> (i.e. <rev> and its
+	ancestors).
 
 '{caret}<rev>'::
-	Exclude commits that are reachable from (i.e. ancestors of)
-	<rev>.
+	Exclude commits that are reachable from <rev> (i.e. <rev> and its
+	ancestors).
 
 '<rev1>..<rev2>'::
 	Include commits that are reachable from <rev2> but exclude
-- 
2.9.0.windows.1

