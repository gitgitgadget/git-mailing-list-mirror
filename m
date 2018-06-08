Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5E881F403
	for <e@80x24.org>; Fri,  8 Jun 2018 19:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbeFHTbz (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 15:31:55 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:30384 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751719AbeFHTby (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 15:31:54 -0400
Received: from heffalump.sk2.org (unknown [88.186.243.14])
        by smtp5-g21.free.fr (Postfix) with ESMTPS id EE53A5FFB6;
        Fri,  8 Jun 2018 21:31:52 +0200 (CEST)
Received: from steve by heffalump.sk2.org with local (Exim 4.89)
        (envelope-from <steve@sk2.org>)
        id 1fRN71-00086V-W5; Fri, 08 Jun 2018 21:31:52 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] docs/git-blame: explain carets on boundary commits
Date:   Fri,  8 Jun 2018 21:31:35 +0200
Message-Id: <20180608193135.31110-1-steve@sk2.org>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The caret on boundary commits is only mentioned in the description of
--abbrev; this patch adds a description of the behaviour in the
paragraph describing how revision range specifiers are handled.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/git-blame.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 16323eb80..7f814dcef 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -163,7 +163,8 @@ When revision range specifiers are used to limit the annotation,
 lines that have not changed since the range boundary (either the
 commit v2.6.18 or the most recent commit that is more than 3
 weeks old in the above example) are blamed for that range
-boundary commit.
+boundary commit.  The sha1 is preceded by a caret, '^' to indicate
+this (and its length is reduced by 1).
 
 A particularly useful way is to see if an added file has lines
 created by copy-and-paste from existing files.  Sometimes this
-- 
2.11.0

