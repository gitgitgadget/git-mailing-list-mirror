Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A2BC433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6508D20781
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgHMOvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMOvB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 10:51:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52ABC061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 07:51:00 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k6EZH-003jYB-7D
        for git@vger.kernel.org; Thu, 13 Aug 2020 16:50:59 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     git@vger.kernel.org
Subject: [PATCH] docs: commit-graph: fix some whitespace in the diagram
Date:   Thu, 13 Aug 2020 16:50:53 +0200
Message-Id: <20200813145053.43360-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the merge diagram, some whitespace is missing which
makes it a bit confusing, fix that.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 Documentation/technical/commit-graph.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index 808fa30b99f2..f14a7659aa87 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -210,12 +210,12 @@ file.
 			    +---------------------+
 			    |                     |
  +-----------------------+  +---------------------+
- |  graph-{hash2} |->|                     |
+ |  graph-{hash2}        |->|                     |
  +-----------------------+  +---------------------+
 	  |                 |                     |
  +-----------------------+  +---------------------+
  |                       |  |                     |
- |  graph-{hash1} |->|                     |
+ |  graph-{hash1}        |->|                     |
  |                       |  |                     |
  +-----------------------+  +---------------------+
 	  |                  tmp_graphXXX
@@ -223,7 +223,7 @@ file.
  |                       |
  |                       |
  |                       |
- |  graph-{hash0} |
+ |  graph-{hash0}        |
  |                       |
  |                       |
  |                       |
-- 
2.26.2

