From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Correct JGit project URL in Maven pom.xml
Date: Sat, 20 Jun 2009 14:05:44 -0700
Message-ID: <1245531944-26104-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 23:06:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MI7lT-00020z-9J
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 23:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbZFTVFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 17:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752096AbZFTVFn
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 17:05:43 -0400
Received: from george.spearce.org ([209.20.77.23]:55208 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbZFTVFm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 17:05:42 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 7E1C6381FE; Sat, 20 Jun 2009 21:05:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7ADA93819E;
	Sat, 20 Jun 2009 21:05:44 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.416.g04d0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121955>

When we split out of the EGit project repository our canonical
project URL changed.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 jgit-maven/jgit/pom.xml |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/jgit-maven/jgit/pom.xml b/jgit-maven/jgit/pom.xml
index 75c4b75..45fa273 100644
--- a/jgit-maven/jgit/pom.xml
+++ b/jgit-maven/jgit/pom.xml
@@ -41,7 +41,7 @@ ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
     <packaging>jar</packaging>
     <version>0.4-SNAPSHOT</version>
     <name>jgit</name>
-    <url>http://repo.or.cz/w/egit.git</url>
+    <url>http://repo.or.cz/w/jgit.git</url>
     <mailingLists>
         <mailingList>
             <name>GIT Mailing List</name>
-- 
1.6.3.2.416.g04d0
