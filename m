From: bfields@fieldses.org
Subject: [PATCH] Docs: update cvs-migration.txt to reflect clone's new default behavior
Date: Sun, 31 Dec 2006 18:47:33 -0500
Message-ID: <11676088584199-git-send-email-bfields@fieldses.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 01 00:47:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1APB-0007zX-Fl
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 00:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621AbWLaXrp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 18:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754608AbWLaXrp
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 18:47:45 -0500
Received: from mail.fieldses.org ([66.93.2.214]:38258 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbWLaXrj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 18:47:39 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H1AOw-0002Eu-77; Sun, 31 Dec 2006 18:47:38 -0500
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.5.0.rc0.gac28
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35712>

From: J. Bruce Fields <bfields@citi.umich.edu>

I couldn't think of a really quick way to give all the details, so just refer
readers to the git-repo-config man page instead.

I haven't tested recent cvs import behavior--some time presumably it should be
updated to do something more similar to clone.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/cvs-migration.txt |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
index b657f45..8e09bea 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -34,13 +34,10 @@ them first before running git pull.
 
 [NOTE]
 ================================
-The first `git clone` places the following in the
-`my-project/.git/remotes/origin` file, and that's why the previous step
-and the next step both work.
-------------
-URL: foo.com:/pub/project.git/
-Pull: refs/heads/master:refs/remotes/origin/master
-------------
+The `pull` command knows where to get updates from because of certain
+configuration variables that were set by the first `git clone`
+command; see `git repo-config -l` and the gitlink:git-repo-config[1] man
+page for details.
 ================================
 
 You can update the shared repository with your changes by first committing
-- 
1.5.0.rc0.gac28
