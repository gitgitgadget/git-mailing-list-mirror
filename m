Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB872209B8
	for <e@80x24.org>; Mon, 11 Sep 2017 19:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbdIKTez (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 15:34:55 -0400
Received: from ikke.info ([178.21.113.177]:51060 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbdIKTey (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 15:34:54 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
        id 595D544012D; Mon, 11 Sep 2017 21:20:35 +0200 (CEST)
Received: from epsilon.home (unknown [10.8.0.22])
        by vps892.directvps.nl (Postfix) with ESMTP id E159344012D;
        Mon, 11 Sep 2017 21:20:34 +0200 (CEST)
From:   Kevin Daudt <me@ikke.info>
To:     git@vger.kernel.org
Cc:     Kevin Daudt <me@ikke.info>
Subject: [PATCH v2 1/2] doc/for-each-ref: consistently use '=' to between argument names and values
Date:   Mon, 11 Sep 2017 21:33:37 +0200
Message-Id: <20170911193338.25985-1-me@ikke.info>
X-Mailer: git-send-email 2.14.1.459.g238e487ea9
In-Reply-To: <20170901144931.26114-1-me@ikke.info>
References: <20170901144931.26114-1-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The synopsis and description inconsistently add a '=' between the
argument name and it's value. Make this consistent.

Signed-off-by: Kevin Daudt <me@ikke.info>
---
 Documentation/git-for-each-ref.txt | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index bb370c9c7..1015c88f6 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -10,8 +10,9 @@ SYNOPSIS
 [verse]
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
-		   [--points-at <object>] [(--merged | --no-merged) [<object>]]
-		   [--contains [<object>]] [--no-contains [<object>]]
+		   [--points-at=<object>]
+		   (--merged[=<object>] | --no-merged[=<object>])
+		   [--contains[=<object>]] [--no-contains[=<object>]]
 
 DESCRIPTION
 -----------
@@ -65,24 +66,24 @@ OPTIONS
 	the specified host language.  This is meant to produce
 	a scriptlet that can directly be `eval`ed.
 
---points-at <object>::
+--points-at=<object>::
 	Only list refs which points at the given object.
 
---merged [<object>]::
+--merged[=<object>]::
 	Only list refs whose tips are reachable from the
 	specified commit (HEAD if not specified),
 	incompatible with `--no-merged`.
 
---no-merged [<object>]::
+--no-merged[=<object>]::
 	Only list refs whose tips are not reachable from the
 	specified commit (HEAD if not specified),
 	incompatible with `--merged`.
 
---contains [<object>]::
+--contains[=<object>]::
 	Only list refs which contain the specified commit (HEAD if not
 	specified).
 
---no-contains [<object>]::
+--no-contains[=<object>]::
 	Only list refs which don't contain the specified commit (HEAD
 	if not specified).
 
-- 
2.14.1.459.g238e487ea9

