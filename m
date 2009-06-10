From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH v5 7/7] Remove a TAB from the message Egit generates into the reflog on commit
Date: Wed, 10 Jun 2009 23:22:25 +0200
Message-ID: <1244668945-12622-8-git-send-email-robin.rosenberg@dewire.com>
References: <1241652781-16873-1-git-send-email-robin.rosenberg@dewire.com>
 <1244668945-12622-1-git-send-email-robin.rosenberg@dewire.com>
 <1244668945-12622-2-git-send-email-robin.rosenberg@dewire.com>
 <1244668945-12622-3-git-send-email-robin.rosenberg@dewire.com>
 <1244668945-12622-4-git-send-email-robin.rosenberg@dewire.com>
 <1244668945-12622-5-git-send-email-robin.rosenberg@dewire.com>
 <1244668945-12622-6-git-send-email-robin.rosenberg@dewire.com>
 <1244668945-12622-7-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Jun 10 23:23:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEVGm-0007wr-0S
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 23:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757665AbZFJVWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 17:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757154AbZFJVWr
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 17:22:47 -0400
Received: from mail.dewire.com ([83.140.172.130]:3895 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755281AbZFJVWf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 17:22:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 95285147D5A9;
	Wed, 10 Jun 2009 23:22:37 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1z3pEgOInggF; Wed, 10 Jun 2009 23:22:37 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id 6870F147D5B3;
	Wed, 10 Jun 2009 23:22:29 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.2.199.g7340d
In-Reply-To: <1244668945-12622-7-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121307>

RefUpdate already adds a TAB

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/actions/CommitAction.java     |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
index 03649c6..8415002 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
@@ -295,7 +295,7 @@ private String buildReflogMessage(String commitMessage) {
 		if (newlineIndex > 0) {
 			firstLine = commitMessage.substring(0, newlineIndex);
 		}
-		String commitStr = amending ? "\tcommit (amend):" : "\tcommit: ";
+		String commitStr = amending ? "commit (amend):" : "commit: ";
 		String message = commitStr + firstLine;
 		return message;
 	}
-- 
1.6.3.2.199.g7340d
