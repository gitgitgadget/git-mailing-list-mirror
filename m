From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH 2/8] Document additional options for git-fetch
Date: Fri, 27 Apr 2007 00:09:15 -0500
Message-ID: <20070427050915.GA9798@bowser.ruder>
References: <20070427050550.GA9594@bowser.ruder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 07:11:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhIkA-0000vd-OJ
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 07:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321AbXD0FLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 01:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755325AbXD0FLk
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 01:11:40 -0400
Received: from www.aeruder.net ([65.254.53.245]:4582 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755321AbXD0FLj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 01:11:39 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id 3A9E040EC7;
	Fri, 27 Apr 2007 00:11:39 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070427050550.GA9594@bowser.ruder>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45689>

Document --quiet/-q and --verbose/-v
Add -n as an alternate for --no-tags
Fix some whitespace issues

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 Documentation/fetch-options.txt |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 5b4d184..bdc7332 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -1,13 +1,20 @@
+-q, \--quiet::
+	Pass --quiet to git-fetch-pack and silence any other internally
+	used programs.
+
+-v, \--verbose::
+	Be verbose.
+
 -a, \--append::
 	Append ref names and object names of fetched refs to the
 	existing contents of `.git/FETCH_HEAD`.  Without this
 	option old data in `.git/FETCH_HEAD` will be overwritten.
 
 \--upload-pack <upload-pack>::
-        When given, and the repository to fetch from is handled
-        by 'git-fetch-pack', '--exec=<upload-pack>' is passed to
-        the command to specify non-default path for the command
-        run on the other end.
+	When given, and the repository to fetch from is handled
+	by 'git-fetch-pack', '--exec=<upload-pack>' is passed to
+	the command to specify non-default path for the command
+	run on the other end.
 
 -f, \--force::
 	When `git-fetch` is used with `<rbranch>:<lbranch>`
@@ -16,7 +23,7 @@
 	fetches is a descendant of `<lbranch>`.  This option
 	overrides that check.
 
-\--no-tags::
+-n, \--no-tags::
 	By default, `git-fetch` fetches tags that point at
 	objects that are downloaded from the remote repository
 	and stores them locally.  This option disables this
-- 
1.5.2.rc0.64.g8476
