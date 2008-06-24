From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH] git-svn docs: mention svn.addAuthorFrom and svn.useLogAuthor config options.
Date: Tue, 24 Jun 2008 12:02:41 -0400
Message-ID: <1214323361-13136-1-git-send-email-apenwarr@gmail.com>
References: <20080624073707.GA6495@frsk.net>
Cc: Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 24 18:11:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBB7G-0002KE-E9
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 18:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbYFXQKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 12:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbYFXQKi
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 12:10:38 -0400
Received: from static-216-18-85-234.gtcust.grouptelecom.net ([216.18.85.234]:40081
	"EHLO mailhost.pwcorp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751153AbYFXQKh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2008 12:10:37 -0400
X-Greylist: delayed 933 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jun 2008 12:10:37 EDT
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Jun 2008 12:02:48 -0400
Received: (qmail 32640 invoked from network); 24 Jun 2008 16:02:43 -0000
Received: from unknown (HELO averyp-server.pwcorp.com) (10.65.1.129)
  by weaver.open.versabanq.com with SMTP; 24 Jun 2008 16:02:43 -0000
Received: by averyp-server.pwcorp.com (Postfix, from userid 1000)
	id 17EB68C882; Tue, 24 Jun 2008 12:02:41 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.56.g29b0d
In-Reply-To: <20080624073707.GA6495@frsk.net>
X-OriginalArrivalTime: 24 Jun 2008 16:02:48.0685 (UTC) FILETIME=[BF92C9D0:01C8D613]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86077>

At least one person got confused because they thought it was necessary to
provide these on the command line every time.

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 Documentation/git-svn.txt |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 97bed54..e8200ce 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -64,13 +64,16 @@ COMMANDS
 --use-log-author;;
 	When retrieving svn commits into git (as part of fetch, rebase, or
 	dcommit operations), look for the first From: or Signed-off-by: line
-	in the log message and use that as the author string.
+	in the log message and use that as the author string. (To enable
+	this permanently, use git config svn.useLogAuthor)
 --add-author-from;;
 	When committing to svn from git (as part of commit or dcommit
 	operations), if the existing log message doesn't already have a
 	From: or Signed-off-by: line, append a From: line based on the
-	git commit's author string.  If you use this, then --use-log-author
-	will retrieve a valid author string for all commits.
+	git commit's author string.  If you use this, then if you enable
+	--use-log-author it will retrieve a valid author string for all
+	commits. (To enable this option permanently, use git config
+	svn.addAuthorFrom)
 --username=<USER>;;
 	For transports that SVN handles authentication for (http,
 	https, and plain svn), specify the username.  For other
-- 
1.5.6.56.g29b0d
