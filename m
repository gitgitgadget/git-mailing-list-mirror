Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F41DA1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 23:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754127AbcJTXkT (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 19:40:19 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:64119 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752409AbcJTXkS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 19:40:18 -0400
Received: from localhost.localdomain ([92.22.58.114])
        by smtp.talktalk.net with SMTP
        id xMwZb9jI7HGLwxMwZbUMLN; Fri, 21 Oct 2016 00:40:15 +0100
X-Originating-IP: [92.22.58.114]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=2Ll0YfBpv7lGbMD0z8GrYw==:117
 a=2Ll0YfBpv7lGbMD0z8GrYw==:17 a=anyJmfQTAAAA:8 a=5rxgeBVgAAAA:8
 a=1XWaLZrsAAAA:8 a=xtxXYLxNAAAA:8 a=3MHgWqVLjBDDWhyfIgMA:9
 a=6RyHdP9wf0s6W1bbVaoE2bQoMl4=:19 a=YJ_ntbLOlx1v6PCnmBeL:22
 a=PwKx63F5tFurRwaNxrlG:22 a=nJcEw6yWrPvoIXZ49MH8:22 a=xts0dhWdiJbonKbuqhAr:22
From:   Philip Oakley <philipoakley@iee.org>
To:     GitList <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] doc: fix merge-base ASCII art tab spacing
Date:   Fri, 21 Oct 2016 00:40:09 +0100
Message-Id: <20161020234009.1768-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1.323.g0305acf
X-CMAE-Envelope: MS4wfALkqIh6N33coFFjix3k5VRaX8Nte9O4lOwUguu77m6vuHV8VHyKOnwg3u4dVTg1XXkFkbClb+DVPsgFBiwRLJL/dGGm56ttw15hvfLv+6nivKRYxSgA
 QttuaoWTv+9YGiqQcEzjWA/rSvNO1HIEv/Po3BLr/HDQTIqJPOPvWEK0J+wfSq1fMDlcyXKpKWmBFRuQurlRmQePbudJenzqYMkGaC4ehM67UCc1/UEA5bSH
 CVstM+DmfescCqr3qdTD2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The doc-tool stack does not always respect the 'tab = 8 spaces' rule,
particularly the git-scm doc pages https://git-scm.com/docs/git-merge-base
and the Git generated html pages.

Use just spaces within the block of the ascii art.

Noticed when reviewing Junio's suggested update to `git merge-base`
https://public-inbox.org/git/xmqqmvi2sj8f.fsf@gitster.mtv.corp.google.com/T/#u


Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

A fixed consistent prefix of tabs is OK, but once that lead is done, stay
with spaces only.

This complements the jc/merge-base-fp-only series.

---
 Documentation/git-merge-base.txt | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 808426f..b968b64 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -80,8 +80,8 @@ which is reachable from both 'A' and 'B' through the parent relationship.
 
 For example, with this topology:
 
-		 o---o---o---B
-		/
+	         o---o---o---B
+	        /
 	---o---1---o---o---o---A
 
 the merge base between 'A' and 'B' is '1'.
@@ -116,11 +116,11 @@ the best common ancestor of all commits.
 When the history involves criss-cross merges, there can be more than one
 'best' common ancestor for two commits.  For example, with this topology:
 
-       ---1---o---A
-	   \ /
-	    X
-	   / \
-       ---2---o---o---B
+	---1---o---A
+	    \ /
+	     X
+	    / \
+	---2---o---o---B
 
 both '1' and '2' are merge-bases of A and B.  Neither one is better than
 the other (both are 'best' merge bases).  When the `--all` option is not given,
@@ -154,13 +154,13 @@ topic origin/master`, the history of remote-tracking branch
 `origin/master` may have been rewound and rebuilt, leading to a
 history of this shape:
 
-			 o---B1
-			/
+	                 o---B1
+	                /
 	---o---o---B2--o---o---o---B (origin/master)
-		\
-		 B3
-		  \
-		   Derived (topic)
+	        \
+	         B3
+	          \
+	           Derived (topic)
 
 where `origin/master` used to point at commits B3, B2, B1 and now it
 points at B, and your `topic` branch was started on top of it back
-- 
2.9.0.windows.1.323.g0305acf

