From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH] Force maven build to assume UTF-8 encoded source files
Date: Mon,  8 Sep 2008 21:46:09 +0200
Message-ID: <1220903169-15190-1-git-send-email-robin.rosenberg@dewire.com>
Cc: imyousuf@gmail.com, git@vger.kernel.org,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Sep 08 21:47:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcmhl-0000OF-En
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 21:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418AbYIHTqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 15:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbYIHTqN
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 15:46:13 -0400
Received: from av9-2-sn2.hy.skanova.net ([81.228.8.180]:45348 "EHLO
	av9-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbYIHTqM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 15:46:12 -0400
Received: by av9-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 94E2737ED2; Mon,  8 Sep 2008 21:46:10 +0200 (CEST)
Received: from smtp4-2-sn2.hy.skanova.net (smtp4-2-sn2.hy.skanova.net [81.228.8.93])
	by av9-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id 7103637EC0; Mon,  8 Sep 2008 21:46:10 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-2-sn2.hy.skanova.net (Postfix) with ESMTP id 13FBA37E4B;
	Mon,  8 Sep 2008 21:46:09 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.267.gec3a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95297>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 jgit-maven/jgit/pom.xml |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

We had one unit test failing because of this.

-- robin

diff --git a/jgit-maven/jgit/pom.xml b/jgit-maven/jgit/pom.xml
index fe9b0c5..8ea56ca 100644
--- a/jgit-maven/jgit/pom.xml
+++ b/jgit-maven/jgit/pom.xml
@@ -155,6 +155,7 @@ ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
                 <configuration>
                     <source>1.5</source>
                     <target>1.5</target>
+		    <encoding>UTF-8</encoding>
                 </configuration>
             </plugin>
         </plugins>
-- 
1.6.0.1.267.gec3a
