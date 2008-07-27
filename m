From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: [PATCH] Documentation/git-rev-parse.txt: update for new git-describe output format
Date: Sat, 26 Jul 2008 21:46:00 -0300
Message-ID: <1217119560-28380-1-git-send-email-cesarb@cesarb.net>
Cc: Cesar Eduardo Barros <cesarb@cesarb.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jul 27 02:47:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMuPp-0007Jf-4P
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 02:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756530AbYG0AqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 20:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756526AbYG0AqJ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 20:46:09 -0400
Received: from smtp-01.mandic.com.br ([200.225.81.132]:41727 "EHLO
	smtp-01.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756487AbYG0AqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 20:46:08 -0400
Received: (qmail 12034 invoked from network); 27 Jul 2008 00:46:01 -0000
Received: from grumari.nitnet.com.br (HELO localhost.localdomain) (zcncxNmDysja2tXBpdiToZWJlF6Wp6IuYnI=@[200.157.204.13])
          (envelope-sender <cesarb@cesarb.net>)
          by smtp-01.mandic.com.br (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 27 Jul 2008 00:46:01 -0000
X-Mailer: git-send-email 1.5.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90297>

Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
---
 Documentation/git-rev-parse.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 5c93669..2921da3 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -155,8 +155,9 @@ blobs contained in a commit.
   name the same commit object if there are no other object in
   your repository whose object name starts with dae86e.
 
-* An output from 'git-describe'; i.e. a closest tag, followed by a
-  dash, a `g`, and an abbreviated object name.
+* An output from 'git-describe'; i.e. a closest tag, optionally
+  followed by a dash and a number of commits, followed by a dash, a
+  `g`, and an abbreviated object name.
 
 * A symbolic ref name.  E.g. 'master' typically means the commit
   object referenced by $GIT_DIR/refs/heads/master.  If you
-- 
1.5.6.4
