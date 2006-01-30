From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: git push -f documentation
Date: Sun, 29 Jan 2006 20:40:50 -0500
Message-ID: <20060130014050.GA18945@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 02:41:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3O2V-0001i3-Qp
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 02:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWA3Bkw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 20:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWA3Bkw
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 20:40:52 -0500
Received: from mail.fieldses.org ([66.93.2.214]:24768 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1750950AbWA3Bkw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2006 20:40:52 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F3O2E-0006ws-Ba; Sun, 29 Jan 2006 20:40:50 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15256>

Surely the documentation here is exactly backwards?  Or am I
missing something?--b.

---

 Documentation/git-push.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

1391326bf55bc9a9deb52a872671f29c70c0a4de
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 365cfd4..a0ef61d 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -35,10 +35,10 @@ include::pull-fetch-param.txt[]
 	line.
 
 -f, \--force::
-	Usually, the command refuses to update a local ref that is
-	not an ancestor of the remote ref used to overwrite it.
-	This flag disables the check.  What this means is that the
-	local repository can lose commits; use it with care.
+	Usually, the command refuses to update a remote ref that is
+	not a descendent of the local ref used to overwrite it.
+	This flag disables the check.  This can cause the
+	remote repository to lose commits; use it with care.
 
 
 Author
-- 
0.99.8b.g3480-dirty
