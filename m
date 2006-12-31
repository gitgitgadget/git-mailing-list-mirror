From: bfields@fieldses.org
Subject: [PATCH] Documentation: update git-clone.txt for clone's new default behavior
Date: Sun, 31 Dec 2006 18:47:34 -0500
Message-ID: <1167608858759-git-send-email-bfields@fieldses.org>
References: <11676088584199-git-send-email-bfields@fieldses.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 01 00:47:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1AP9-0007zX-W4
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 00:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbWLaXrl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 18:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754608AbWLaXrk
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 18:47:40 -0500
Received: from mail.fieldses.org ([66.93.2.214]:38250 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573AbWLaXrj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 18:47:39 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H1AOw-0002Ew-AB; Sun, 31 Dec 2006 18:47:38 -0500
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.5.0.rc0.gac28
In-Reply-To: <11676088584199-git-send-email-bfields@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35710>

From: J. Bruce Fields <bfields@citi.umich.edu>

Fix a couple remaining references to the origin branch.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/git-clone.txt |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 874934a..9652320 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -75,16 +75,13 @@ OPTIONS
 	Also the branch heads at the remote are copied directly
 	to corresponding local branch heads, without mapping
 	them to `refs/remotes/origin/`.  When this option is
-	used, neither the `origin` branch nor the default
-	`remotes/origin` file is created.
+	used, neither remote-tracking branches nor the related
+	configuration variables are created.
 
 --origin <name>::
 -o <name>::
-	Instead of using the branch name 'origin' to keep track
-	of the upstream repository, use <name> instead.  Note
-	that the shorthand name stored in `remotes/origin` is
-	not affected, but the local branch name to pull the
-	remote `master` branch into is.
+	Instead of using the remote name 'origin' to keep track
+	of the upstream repository, use <name> instead.
 
 --upload-pack <upload-pack>::
 -u <upload-pack>::
-- 
1.5.0.rc0.gac28
