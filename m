Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED22C433FE
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 10:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA6AF22CB9
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 10:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392772AbgLMKO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 05:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgLMKO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 05:14:28 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DAAC0613CF
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 02:13:47 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1koONt-0083eQ-4d; Sun, 13 Dec 2020 11:13:45 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] docs: multi-pack-index: remove note about future 'verify' work
Date:   Sun, 13 Dec 2020 11:13:40 +0100
Message-Id: <20201213101340.7360-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was implemented in the 'git multi-pack-index' command
(and there's no 'git midx' command).

Fixes: cc6af73c029d ("multi-pack-index: verify object offsets")
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 Documentation/technical/multi-pack-index.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
index 4e7631437a58..e8e377a59f0c 100644
--- a/Documentation/technical/multi-pack-index.txt
+++ b/Documentation/technical/multi-pack-index.txt
@@ -60,10 +60,6 @@ Design Details
 Future Work
 -----------
 
-- Add a 'verify' subcommand to the 'git midx' builtin to verify the
-  contents of the multi-pack-index file match the offsets listed in
-  the corresponding pack-indexes.
-
 - The multi-pack-index allows many packfiles, especially in a context
   where repacking is expensive (such as a very large repo), or
   unexpected maintenance time is unacceptable (such as a high-demand
-- 
2.26.2

