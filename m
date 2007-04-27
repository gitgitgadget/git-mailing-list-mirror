From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH 6/8] Update git-http-push documentation
Date: Fri, 27 Apr 2007 00:09:53 -0500
Message-ID: <20070427050953.GE9798@bowser.ruder>
References: <20070427050550.GA9594@bowser.ruder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 07:12:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhIkp-0001Dm-Qp
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 07:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336AbXD0FMS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 01:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755340AbXD0FMS
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 01:12:18 -0400
Received: from www.aeruder.net ([65.254.53.245]:4595 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755336AbXD0FMS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 01:12:18 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id 9528C40EC7;
	Fri, 27 Apr 2007 00:12:17 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070427050550.GA9594@bowser.ruder>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45693>

Documentation/git-http-push.txt: Changing --complete to --all.  Added
documentation for -d and -D to remote remote refs.

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 Documentation/git-http-push.txt |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index 4b4a461..a15cf5b 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -8,7 +8,7 @@ git-http-push - Push objects over HTTP/DAV to another repository
 
 SYNOPSIS
 --------
-'git-http-push' [--complete] [--force] [--verbose] <url> <ref> [<ref>...]
+'git-http-push' [--all] [--force] [--verbose] <url> <ref> [<ref>...]
 
 DESCRIPTION
 -----------
@@ -18,7 +18,7 @@ remote branch.
 
 OPTIONS
 -------
---complete::
+--all::
 	Do not assume that the remote repository is complete in its
 	current state, and verify all objects in the entire local
 	ref's history exist in the remote repository.
@@ -34,6 +34,15 @@ OPTIONS
 	Report the list of objects being walked locally and the
 	list of objects successfully sent to the remote repository.
 
+-d, -D::
+	Remove <ref> from remote repository.  The specified branch
+	cannot be the remote HEAD.  If -d is specified the following
+	other conditions must also be met:
+
+	- Remote HEAD must resolve to an object that exists locally
+	- Specified branch resolves to an object that exists locally
+	- Specified branch is an ancestor of the remote HEAD
+
 <ref>...::
 	The remote refs to update.
 
-- 
1.5.2.rc0.64.g8476
