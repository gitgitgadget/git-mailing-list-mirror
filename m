From: bfields@fieldses.org
Subject: [PATCH] Documentation: update glossary entry for "origin"
Date: Sun, 31 Dec 2006 18:47:36 -0500
Message-ID: <11676088581948-git-send-email-bfields@fieldses.org>
References: <11676088584199-git-send-email-bfields@fieldses.org> <1167608858759-git-send-email-bfields@fieldses.org> <11676088582634-git-send-email-bfields@fieldses.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 01 00:47:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1AP9-0007zX-Fs
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 00:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbWLaXrk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 18:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754605AbWLaXrk
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 18:47:40 -0500
Received: from mail.fieldses.org ([66.93.2.214]:38252 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572AbWLaXrj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 18:47:39 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H1AOw-0002F0-GB; Sun, 31 Dec 2006 18:47:38 -0500
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.5.0.rc0.gac28
In-Reply-To: <11676088582634-git-send-email-bfields@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35713>

From: J. Bruce Fields <bfields@citi.umich.edu>

Update glossary entry for "origin" to reflect fact that it normally now refers
to a remote repository, not a branch.

Also, warning not to work on remote-tracking branches is no longer necessary
since git doesn't allow that.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/glossary.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index 894883d..7c1a659 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -188,11 +188,12 @@ octopus::
 	predator.
 
 origin::
-	The default upstream tracking branch. Most projects have at
+	The default upstream repository. Most projects have at
 	least one upstream project which they track. By default
 	'origin' is used for that purpose.  New upstream updates
-	will be fetched into this branch; you should never commit
-	to it yourself.
+	will be fetched into remote tracking branches named
+	origin/name-of-upstream-branch, which you can see using
+	"git branch -r".
 
 pack::
 	A set of objects which have been compressed into one file (to save
-- 
1.5.0.rc0.gac28
