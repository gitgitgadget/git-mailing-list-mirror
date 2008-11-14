From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/7 v3] Add constant for "refs/"
Date: Sat, 15 Nov 2008 00:24:55 +0100
Message-ID: <1226705099-18066-1-git-send-email-robin.rosenberg@dewire.com>
References: <20081111183248.GR2932@spearce.org>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Nov 15 00:26:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L183e-0004bR-Ie
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 00:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbYKNXZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 18:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbYKNXZI
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 18:25:08 -0500
Received: from mail.dewire.com ([83.140.172.130]:13624 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbYKNXZH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 18:25:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 8509D147D4EF;
	Sat, 15 Nov 2008 00:25:04 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MHl+s2UUoe0S; Sat, 15 Nov 2008 00:25:01 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 2B4C0147D0FE;
	Sat, 15 Nov 2008 00:25:00 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a.dirty
In-Reply-To: <20081111183248.GR2932@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101029>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/Constants.java        |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

Here's an update after considering Shawn's comments. 1,2,3 are just reordered.
No 4 and 5 are changed. For patch no 6 and 7 use the ones from the previous
batch.

-- robin

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
1.6.0.3.640.g6331a.dirty
