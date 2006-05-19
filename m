From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 2/5] Added logs/ directory to repository layout.
Date: Fri, 19 May 2006 03:28:46 -0400
Message-ID: <20060519072846.GC22257@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 09:29:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgzPo-0005O5-6w
	for gcvg-git@gmane.org; Fri, 19 May 2006 09:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWESH2t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 03:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWESH2t
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 03:28:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:30147 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751018AbWESH2t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 03:28:49 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FgzPh-0002j7-TP; Fri, 19 May 2006 03:28:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2C087212691; Fri, 19 May 2006 03:28:46 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20330>


Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---

 Documentation/repository-layout.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

27faccbeae368625d4a11788e5cedc7b3dc23f54
diff --git a/Documentation/repository-layout.txt b/Documentation/repository-layout.txt
index 98fbe7d..b52dfdc 100644
--- a/Documentation/repository-layout.txt
+++ b/Documentation/repository-layout.txt
@@ -128,3 +128,14 @@ remotes::
 	Stores shorthands to be used to give URL and default
 	refnames to interact with remote repository to `git
 	fetch`, `git pull` and `git push` commands.
+
+logs::
+	Records of changes made to refs are stored in this
+	directory.  See the documentation on git-update-ref
+	for more information.
+
+logs/refs/heads/`name`::
+	Records all changes made to the branch tip named `name`.
+
+logs/refs/tags/`name`::
+	Records all changes made to the tag named `name`.
-- 
1.3.2.g7278
