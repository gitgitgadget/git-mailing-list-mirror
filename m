From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Portfile: bring it up to date; use description from cogito.spec.in
Date: Mon, 29 May 2006 02:11:12 +0200
Message-ID: <20060529001112.GB2061@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 29 02:11:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkVLp-0007zy-KY
	for gcvg-git@gmane.org; Mon, 29 May 2006 02:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWE2ALP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 20:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWE2ALP
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 20:11:15 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:42663 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751067AbWE2ALP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 20:11:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id E09D677002D;
	Mon, 29 May 2006 02:11:13 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08601-03; Mon, 29 May 2006 02:11:12 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 4632B77002B;
	Mon, 29 May 2006 02:11:12 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 7754C6DF8B9; Mon, 29 May 2006 02:08:04 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 33ED66253D; Mon, 29 May 2006 02:11:12 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20910>

---

9460c53c76fc00e3b7c45e58813cefde78cb99f5
 Portfile.in |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

9460c53c76fc00e3b7c45e58813cefde78cb99f5
diff --git a/Portfile.in b/Portfile.in
index 9e380ad..297fd8a 100644
--- a/Portfile.in
+++ b/Portfile.in
@@ -4,13 +4,13 @@ name              cogito
 version           @@VERSION@@
 categories        devel
 maintainers       bryan.larsen@gmail.com
-description       Git core + cogito tools to provide a full distributed SCM.
-long_description  The git core, developed by Linus Torvalds provides \
-		  an extremely fast and flexible filesystem-based \
-		  database designed to store directory trees with \
-		  regard to their history.  The cogito tools, \
-		  developed by Petr Baudis, provide full distributed \
-		  SCM (software change management) functionality.
+description       The Cogito Version Control System
+long_description  Cogito is a version control system layered on top \
+		  of the git tree history storage system. It aims at \
+		  seamless user interface and ease of use, providing \
+		  generally smoother user experience than the "raw" \
+		  Core GIT itself and indeed many other version \
+		  control systems.
 homepage          http://kernel.org/pub/software/scm/cogito/
 master_sites      http://kernel.org/pub/software/scm/cogito/
 configure	  {}
-- 
1.3.3.gd882-dirty

-- 
Jonas Fonseca
