Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B8521F6DC
	for <e@80x24.org>; Fri, 27 Jan 2017 10:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932347AbdA0KWE (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 05:22:04 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:10135 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754774AbdA0KVi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 05:21:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 008F51E1877;
        Fri, 27 Jan 2017 11:11:43 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6kBhL-lDDVzb; Fri, 27 Jan 2017 11:11:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 9D16E1E2C99;
        Fri, 27 Jan 2017 11:11:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7DRK-gs25atx; Fri, 27 Jan 2017 11:11:42 +0100 (CET)
Received: from localhost.localdomain (unknown [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 406ED1E1877;
        Fri, 27 Jan 2017 11:11:42 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     gitster@pobox.com
Cc:     peff@peff.net, git@vger.kernel.org,
        Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH v3 1/3] config: add markup to core.logAllRefUpdates doc
Date:   Fri, 27 Jan 2017 11:09:46 +0100
Message-Id: <20170127100948.29408-1-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <xmqqvat11k1i.fsf@gitster.mtv.corp.google.com>
References: <xmqqvat11k1i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
---

Notes:
    Changes wrt v2:
    	Remove duplicated line.

 Documentation/config.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index af2ae4c..c7d8a01 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -517,10 +517,10 @@ core.logAllRefUpdates::
 	"`$GIT_DIR/logs/<ref>`", by appending the new and old
 	SHA-1, the date/time and the reason of the update, but
 	only when the file exists.  If this configuration
-	variable is set to true, missing "`$GIT_DIR/logs/<ref>`"
+	variable is set to `true`, missing "`$GIT_DIR/logs/<ref>`"
 	file is automatically created for branch heads (i.e. under
-	refs/heads/), remote refs (i.e. under refs/remotes/),
-	note refs (i.e. under refs/notes/), and the symbolic ref HEAD.
+	`refs/heads/`), remote refs (i.e. under `refs/remotes/`),
+	note refs (i.e. under `refs/notes/`), and the symbolic ref `HEAD`.
 +
 This information can be used to determine what commit
 was the tip of a branch "2 days ago".
-- 
2.10.2

