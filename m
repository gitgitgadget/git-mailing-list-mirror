From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/7] Add constant for "refs/"
Date: Fri,  7 Nov 2008 23:07:39 +0100
Message-ID: <1226095664-13759-3-git-send-email-robin.rosenberg@dewire.com>
References: <1226095664-13759-1-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Nov 07 23:09:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZVp-0008DU-42
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbYKGWHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 17:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbYKGWHu
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 17:07:50 -0500
Received: from mail.dewire.com ([83.140.172.130]:11956 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751607AbYKGWHt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 17:07:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 4B7C0147EACF;
	Fri,  7 Nov 2008 23:07:48 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3lF3o8WUB2QQ; Fri,  7 Nov 2008 23:07:46 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id C1556147EAE3;
	Fri,  7 Nov 2008 23:07:45 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.578.g6a50
In-Reply-To: <1226095664-13759-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100340>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/Constants.java        |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
index f316881..9613d07 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
@@ -216,6 +216,9 @@
 	/** Prefix for tag refs */
 	public static final String R_TAGS = "refs/tags/";
 
+	/** Prefix for any ref */
+	public static final String R_REFS = "refs/";
+
 	/** Logs folder name */
 	public static final String LOGS = "logs";
 
-- 
1.6.0.3.578.g6a50
