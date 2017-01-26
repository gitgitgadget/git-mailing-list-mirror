Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33B1E1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 22:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753366AbdAZWlQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 17:41:16 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:33654 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753066AbdAZWlM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 17:41:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 0DD2F1E2F9C;
        Thu, 26 Jan 2017 23:33:01 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DRmdqrn60Oyw; Thu, 26 Jan 2017 23:33:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 802C41E2FAF;
        Thu, 26 Jan 2017 23:33:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Q3qCt2-9TU1k; Thu, 26 Jan 2017 23:33:00 +0100 (CET)
Received: from localhost.localdomain (aftr-185-17-204-63.dynamic.mnet-online.de [185.17.204.63])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 8CE861E2F9C;
        Thu, 26 Jan 2017 23:32:59 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     peff@peff.net
Cc:     git@vger.kernel.org, Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH v2 1/3] config: add markup to core.logAllRefUpdates doc
Date:   Thu, 26 Jan 2017 23:31:57 +0100
Message-Id: <20170126223159.16439-1-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170126033547.7bszipvkpi2jb4ad@sigill.intra.peff.net>
References: <20170126033547.7bszipvkpi2jb4ad@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
---

Notes:
    As suggested, I moved the modification of the markup to its own commit.

 Documentation/config.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index af2ae4c..3cd8030 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -517,10 +517,11 @@ core.logAllRefUpdates::
 	"`$GIT_DIR/logs/<ref>`", by appending the new and old
 	SHA-1, the date/time and the reason of the update, but
 	only when the file exists.  If this configuration
-	variable is set to true, missing "`$GIT_DIR/logs/<ref>`"
+	variable is set to `true`, missing "`$GIT_DIR/logs/<ref>`"
 	file is automatically created for branch heads (i.e. under
 	refs/heads/), remote refs (i.e. under refs/remotes/),
-	note refs (i.e. under refs/notes/), and the symbolic ref HEAD.
+	`refs/heads/`), remote refs (i.e. under `refs/remotes/`),
+	note refs (i.e. under `refs/notes/`), and the symbolic ref `HEAD`.
 +
 This information can be used to determine what commit
 was the tip of a branch "2 days ago".
-- 
2.10.2

