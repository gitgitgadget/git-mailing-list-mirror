From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 5/6] Use Constants.PACKED_REFS in RefWriter
Date: Wed, 20 May 2009 01:13:17 +0200
Message-ID: <1242774798-23639-6-git-send-email-robin.rosenberg@dewire.com>
References: <20090507155117.GS30527@spearce.org>
 <1242774798-23639-1-git-send-email-robin.rosenberg@dewire.com>
 <1242774798-23639-2-git-send-email-robin.rosenberg@dewire.com>
 <1242774798-23639-3-git-send-email-robin.rosenberg@dewire.com>
 <1242774798-23639-4-git-send-email-robin.rosenberg@dewire.com>
 <1242774798-23639-5-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed May 20 01:13:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6YVA-0003FB-IX
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 01:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964AbZESXNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 19:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754183AbZESXNf
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 19:13:35 -0400
Received: from mail.dewire.com ([83.140.172.130]:25889 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755659AbZESXN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 19:13:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 27E46145D12D;
	Wed, 20 May 2009 01:13:28 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8WSLXlw0UiN5; Wed, 20 May 2009 01:13:25 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.11])
	by dewire.com (Postfix) with ESMTP id C1572145D12A;
	Wed, 20 May 2009 01:13:22 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <1242774798-23639-5-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119573>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/RefDatabase.java      |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 9c0d114..de987ab 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -87,7 +87,7 @@ RefDatabase(final Repository r) {
 		db = r;
 		gitDir = db.getDirectory();
 		refsDir = FS.resolve(gitDir, "refs");
-		packedRefsFile = FS.resolve(gitDir, "packed-refs");
+		packedRefsFile = FS.resolve(gitDir, Constants.PACKED_REFS);
 		clearCache();
 	}
 
-- 
1.6.3.dirty
