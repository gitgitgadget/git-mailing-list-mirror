Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D358920193
	for <e@80x24.org>; Mon, 24 Oct 2016 21:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941331AbcJXV4l (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 17:56:41 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:53770 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941278AbcJXV4l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 17:56:41 -0400
Received: from localhost.localdomain ([92.22.33.31])
        by smtp.talktalk.net with SMTP
        id ynCXb93qqxR4bynCXbQpHg; Mon, 24 Oct 2016 22:54:38 +0100
X-Originating-IP: [92.22.33.31]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=ybqgNu2HPZDkq8okBTEsHw==:117
 a=ybqgNu2HPZDkq8okBTEsHw==:17 a=xtxXYLxNAAAA:8 a=anyJmfQTAAAA:8
 a=7FRZB9tROJxV3DyYikgA:9 a=xts0dhWdiJbonKbuqhAr:22 a=YJ_ntbLOlx1v6PCnmBeL:22
From:   Philip Oakley <philipoakley@iee.org>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, peff@peff.net,
        philipoakley@iee.org
Subject: [PATCH] doc: fix the 'revert a faulty merge' ASCII art tab spacing
Date:   Mon, 24 Oct 2016 22:54:32 +0100
Message-Id: <20161024215432.1384-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1.323.g0305acf
In-Reply-To: <xmqq1sz9b9ex.fsf@gitster.mtv.corp.google.com>
References: <xmqq1sz9b9ex.fsf@gitster.mtv.corp.google.com>
X-CMAE-Envelope: MS4wfEZPzMVe/IMxvBc+Lz20lCmNmbI4oiTbohSsOBubKNOOIEgG5DcPq15uBdKVECvug3Y6MN8af894QNUFkTXoV4m+eAYoBbEqsgqnNCuAl5H6wqtDbWzi
 1X+bNP2Xi/4XkW4OrrbZK7CqMLp3Xn0ZOsdjkVHgUYO5o4pWdoNSI0NyTaSf0DGuXRsU56kKpjkvi+wnjEP9ZLw5SnOTQ37O8wha2lR0EU0W+FjR4nruipAG
 /chihSOJZu1kjSV8OZozHY45ZiKRUDE9I4EazuFNQUePzoSokt+s1ivCyBNJ0tPK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The asciidoctor doc-tool stack does not always respect the 'tab = 8 spaces' rule
expectation, particularly for the Git-for-Windows generated html pages. This
follows on from the 'doc: fix merge-base ASCII art tab spacing' fix.

Use just spaces within the block of the ascii art.

All other *.txt ascii art containing three dashes has been checked.
Asciidoctor correctly formats the other art blocks that do contain tabs.

Signed-off-by: Philip Oakley <philipoakley@iee.org
---
The git-scm doc pages https://git-scm.com/docs/ does not convert this
how-to document to html, rather it links to the Github text pages, which
does respect the 8 space tab rule.
---
 Documentation/howto/revert-a-faulty-merge.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/howto/revert-a-faulty-merge.txt b/Documentation/howto/revert-a-faulty-merge.txt
index 462255e..19f59cc 100644
--- a/Documentation/howto/revert-a-faulty-merge.txt
+++ b/Documentation/howto/revert-a-faulty-merge.txt
@@ -30,7 +30,7 @@ The history immediately after the "revert of the merge" would look like
 this:
 
  ---o---o---o---M---x---x---W
-	       /
+               /
        ---A---B
 
 where A and B are on the side development that was not so good, M is the
@@ -47,7 +47,7 @@ After the developers of the side branch fix their mistakes, the history
 may look like this:
 
  ---o---o---o---M---x---x---W---x
-	       /
+               /
        ---A---B-------------------C---D
 
 where C and D are to fix what was broken in A and B, and you may already
@@ -81,7 +81,7 @@ In such a situation, you would want to first revert the previous revert,
 which would make the history look like this:
 
  ---o---o---o---M---x---x---W---x---Y
-	       /
+               /
        ---A---B-------------------C---D
 
 where Y is the revert of W.  Such a "revert of the revert" can be done
@@ -93,14 +93,14 @@ This history would (ignoring possible conflicts between what W and W..Y
 changed) be equivalent to not having W or Y at all in the history:
 
  ---o---o---o---M---x---x-------x----
-	       /
+               /
        ---A---B-------------------C---D
 
 and merging the side branch again will not have conflict arising from an
 earlier revert and revert of the revert.
 
  ---o---o---o---M---x---x-------x-------*
-	       /                       /
+               /                       /
        ---A---B-------------------C---D
 
 Of course the changes made in C and D still can conflict with what was
@@ -111,13 +111,13 @@ faulty A and B, and redone the changes on top of the updated mainline
 after the revert, the history would have looked like this:
 
  ---o---o---o---M---x---x---W---x---x
-	       /                 \
+               /                 \
        ---A---B                   A'--B'--C'
 
 If you reverted the revert in such a case as in the previous example:
 
  ---o---o---o---M---x---x---W---x---x---Y---*
-	       /                 \         /
+               /                 \         /
        ---A---B                   A'--B'--C'
 
 where Y is the revert of W, A' and B' are rerolled A and B, and there may
@@ -129,7 +129,7 @@ lot of overlapping changes that result in conflicts.  So do not do "revert
 of revert" blindly without thinking..
 
  ---o---o---o---M---x---x---W---x---x
-	       /                 \
+               /                 \
        ---A---B                   A'--B'--C'
 
 In the history with rebased side branch, W (and M) are behind the merge
-- 
2.9.0.windows.1.323.g0305acf

