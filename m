Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 691111F744
	for <e@80x24.org>; Wed, 20 Jul 2016 21:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188AbcGTVKY (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 17:10:24 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:11839 "EHLO
	smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755087AbcGTVKV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 17:10:21 -0400
Received: from localhost.localdomain ([92.22.79.77])
	by smtp.talktalk.net with SMTP
	id PykwbXvjRHGLwPyl1bEmd9; Wed, 20 Jul 2016 22:10:20 +0100
X-Originating-IP: [92.22.79.77]
X-Spam:	0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=YfJyJ16zsu2qLTmLoX9DvA==:117
 a=YfJyJ16zsu2qLTmLoX9DvA==:17 a=xtxXYLxNAAAA:8 a=nOBXlB7yw2htNP6sz7oA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 7/8] doc: revisions  - define `reachable`
Date:	Wed, 20 Jul 2016 22:10:06 +0100
Message-Id: <20160720211007.5520-8-philipoakley@iee.org>
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

Do not self-define `reachable`, which can lead to misunderstanding.
Instead define `reachability` explictly.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/revisions.txt | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 5b37283..d3b7cee 100644
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
+previous section, means the set of commits `reachable` from the given
+commit.
+
+A commit's reachable set is the commit itself and the commits in
+its ancestry chain.
+
 
 Commit Exclusions
 ~~~~~~~~~~~~~~~~~
-- 
2.9.0.windows.1

