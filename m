From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Remove unused NLS messages and texts
Date: Wed, 31 Dec 2008 11:47:10 +0100
Message-ID: <1230720430-1182-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Dec 31 11:48:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHycv-0006m3-Fe
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 11:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367AbYLaKrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 05:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755172AbYLaKrQ
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 05:47:16 -0500
Received: from mail.dewire.com ([83.140.172.130]:2246 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754906AbYLaKrP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 05:47:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D14678030A7;
	Wed, 31 Dec 2008 11:47:12 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w4XsKrQnjnHV; Wed, 31 Dec 2008 11:47:12 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 22CE5800784;
	Wed, 31 Dec 2008 11:47:10 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104264>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/core/CoreText.java        |   14 --------------
 .../src/org/spearce/egit/core/coretext.properties  |    6 ------
 2 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java b/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
index a750117..d048d07 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
@@ -14,11 +14,6 @@
  * Possibly Translated strings for the Egit plugin.
  */
 public class CoreText extends NLS {
-	/** */
-	public static String AssumeUnchangedOperation_failed;
-
-	/** */
-	public static String AssumeUnchangedOperation_adding;
 
 	/** */
 	public static String UpdateOperation_updating;
@@ -84,15 +79,6 @@
 	public static String Error_CanonicalFile;
 
 	/** */
-	public static String CheckpointJob_writing;
-
-	/** */
-	public static String CheckpointJob_name;
-
-	/** */
-	public static String CheckpointJob_failed;
-
-	/** */
 	public static String CloneOperation_title;
 
 	/** */
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties b/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
index 04ca28f..2578a5f 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
@@ -48,12 +48,6 @@ The resource cannot be moved, renamed or deleted due to an internal error.
 
 Error_CanonicalFile=Unable to determine a canonical file path.
 
-CheckpointJob_name=Git checkpoint: {0}
-CheckpointJob_writing=Writing
-CheckpointJob_writingBlobs=modified blobs
-CheckpointJob_writingTrees=modified trees
-CheckpointJob_failed=Failed to write modified objects.
-
 CloneOperation_title=Cloning from {0}
 
 ListRemoteOperation_title=Getting remote branches information
-- 
1.6.1.rc3.56.gd0306
