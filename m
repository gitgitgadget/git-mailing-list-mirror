Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F93C32770
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 12:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F4324649
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 12:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgADMnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 07:43:18 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:49688 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgADMnS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jan 2020 07:43:18 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1inilw-00BU9Q-8O
        for git@vger.kernel.org; Sat, 04 Jan 2020 13:43:16 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     git@vger.kernel.org
Subject: [PATCH] multi-pack-index: correct configuration in documentation
Date:   Sat,  4 Jan 2020 13:43:14 +0100
Message-Id: <20200104124314.10134-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's core.multiPackIndex, not pack.multiIndex.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 Documentation/technical/multi-pack-index.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
index 1e312396966c..4e7631437a58 100644
--- a/Documentation/technical/multi-pack-index.txt
+++ b/Documentation/technical/multi-pack-index.txt
@@ -36,7 +36,7 @@ Design Details
   directory of an alternate. It refers only to packfiles in that
   same directory.
 
-- The pack.multiIndex config setting must be on to consume MIDX files.
+- The core.multiPackIndex config setting must be on to consume MIDX files.
 
 - The file format includes parameters for the object ID hash
   function, so a future change of hash algorithm does not require
-- 
2.24.1

