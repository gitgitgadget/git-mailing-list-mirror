From: Nick Andrew <nick@nick-andrew.net>
Subject: [trivial fast-export PATCH] Fix typo in documentation
Date: Tue, 29 Jul 2008 14:50:27 +1000
Message-ID: <20080729045026.27648.54610.stgit@marcab.local.tull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 06:53:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNhDT-00074F-Bn
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 06:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbYG2Ewn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 00:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbYG2Ewm
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 00:52:42 -0400
Received: from vps1.tull.net ([66.180.172.116]:34017 "HELO vps1.tull.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751612AbYG2Ewm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 00:52:42 -0400
Received: (qmail 7900 invoked by uid 1015); 29 Jul 2008 14:52:41 +1000
Received: from [10.0.0.67] (HELO tull.net) (10.0.0.67) by vps1.tull.net (qpsmtpd/0.26) with SMTP; Tue, 29 Jul 2008 14:52:41 +1000
Received: (qmail 23376 invoked by uid 1015); 29 Jul 2008 14:52:37 +1000
X-Spam-Status: No, hits=-4.4 required=5.0	tests=ALL_TRUSTED,BAYES_00
X-Spam-Check-By: tull.net
Received: from [10.0.0.1] (HELO marcab.local.tull.net) (10.0.0.1)    by tull.net (qpsmtpd/0.40) with SMTP; Tue, 29 Jul 2008 14:52:31 +1000
Received: by marcab.local.tull.net (sSMTP sendmail emulation); Tue, 29 Jul 2008 14:52:30 +1000
Mail-From: nobody Tue Jul 29 14:50:27 2008
User-Agent: StGIT/0.14.2
X-SMTPD: qpsmtpd/0.26, http://develooper.com/code/qpsmtpd/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90564>

Fix typo in documentation

"hg-fast-import" should be "hg-fast-export" everywhere it is used.

Signed-off-by: Nick Andrew <nick@nick-andrew.net>
---

 hg-fast-export.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)


diff --git a/hg-fast-export.txt b/hg-fast-export.txt
index 1b8bb1c..ede56a9 100644
--- a/hg-fast-export.txt
+++ b/hg-fast-export.txt
@@ -1,4 +1,4 @@
-hg-fast-import.(sh|py) - mercurial to git converter using git-fast-import
+hg-fast-export.(sh|py) - mercurial to git converter using git-fast-import
 
 Legal
 =====
@@ -16,7 +16,7 @@ Using hg-fast-export is quite simple for a mercurial repository <repo>:
   mkdir repo-git # or whatever
   cd repo-git
   git init
-  hg-fast-import.sh -r <repo>
+  hg-fast-export.sh -r <repo>
 
 Incremental imports to track hg repos is supported, too.
 
@@ -31,7 +31,7 @@ again.
 Notes/Limitations
 =================
 
-hg-fast-import supports multiple branches but only named branches with exaclty
+hg-fast-export supports multiple branches but only named branches with exactly
 one head each. Otherwise commits to the tip of these heads within branch
 will get flattened into merge commits.
 
@@ -42,11 +42,11 @@ when importing a small number of changesets per incremental import).
 Design
 ======
 
-hg-fast-import.py was designed in a way that doesn't require a 2-pass mechanism
+hg-fast-export.py was designed in a way that doesn't require a 2-pass mechanism
 or any prior repository analysis: if just feeds what it finds into
 git-fast-import. This also implies that it heavily relies on strictly
 linear ordering of changesets from hg, i.e. its append-only storage
-model so that changesets hg-fast-import already saw never get modified.
+model so that changesets hg-fast-export already saw never get modified.
 
 Todo
 ====
