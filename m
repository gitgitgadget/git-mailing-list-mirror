Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA34FC433DF
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 20:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5A12222C
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 20:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbgJHUYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 16:24:35 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:7928 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729474AbgJHUYf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 16:24:35 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:889b:81bb:28ab:56e7])
        by smtp6-g21.free.fr (Postfix) with ESMTP id 9C2307802D1;
        Thu,  8 Oct 2020 22:24:02 +0200 (CEST)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 1/4] git-bisect-lk2009: make continuation of list indented
Date:   Thu,  8 Oct 2020 22:23:54 +0200
Message-Id: <20201008202357.15490-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.28.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That's clearer asciidoc formatting.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-bisect-lk2009.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index 3ba49e85b7..f3d9566c89 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -473,7 +473,7 @@ Z-Z
 -------------
 
 2) starting from the "good" ends of the graph, associate to each
-commit the number of ancestors it has plus one
+   commit the number of ancestors it has plus one
 
 For example with the following graph where H is the "bad" commit and A
 and D are some parents of some "good" commits:
@@ -514,7 +514,7 @@ D---E
 -------------
 
 4) the best bisection point is the commit with the highest associated
-number
+   number
 
 So in the above example the best bisection point is commit C.
 
@@ -580,8 +580,8 @@ good or a bad commit does not give more or less information).
 
 Let's also suppose that we have a cleaned up graph like one after step
 1) in the bisection algorithm above. This means that we can measure
-the information we get in terms of number of commit we can remove from
-the graph..
+   the information we get in terms of number of commit we can remove
+   from the graph..
 
 And let's take a commit X in the graph.
 
@@ -689,18 +689,18 @@ roughly the following steps:
 6) sort the commit by decreasing associated value
 
 7) if the first commit has not been skipped, we can return it and stop
-here
+   here
 
 8) otherwise filter out all the skipped commits in the sorted list
 
 9) use a pseudo random number generator (PRNG) to generate a random
-number between 0 and 1
+   number between 0 and 1
 
 10) multiply this random number with its square root to bias it toward
-0
+    0
 
 11) multiply the result by the number of commits in the filtered list
-to get an index into this list
+    to get an index into this list
 
 12) return the commit at the computed index
 
-- 
2.28.0.rc0

