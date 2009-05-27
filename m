From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 03/10] Add a toString to LockFile
Date: Thu, 28 May 2009 00:08:50 +0200
Message-ID: <1243462137-24133-4-git-send-email-robin.rosenberg@dewire.com>
References: <20090520221651.GR30527@spearce.org>
 <1243462137-24133-1-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-2-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu May 28 00:09:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9RJJ-0005L4-Gu
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 00:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757357AbZE0WJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 18:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbZE0WJM
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 18:09:12 -0400
Received: from mail.dewire.com ([83.140.172.130]:25334 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756808AbZE0WJG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 18:09:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 41311145D12E;
	Thu, 28 May 2009 00:09:04 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XchpwI7r6uyp; Thu, 28 May 2009 00:09:02 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.10])
	by dewire.com (Postfix) with ESMTP id F28EC145D12F;
	Thu, 28 May 2009 00:08:59 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <1243462137-24133-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120113>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/LockFile.java         |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/LockFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/LockFile.java
index 9f19efe..abe8b0d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/LockFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/LockFile.java
@@ -397,4 +397,9 @@ public void unlock() {
 			lck.delete();
 		}
 	}
+
+	@Override
+	public String toString() {
+		return "LockFile[" + lck + ", haveLck=" + haveLck + "]";
+	}
 }
-- 
1.6.3.dirty
