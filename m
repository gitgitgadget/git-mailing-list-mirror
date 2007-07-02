From: Jeff King <peff@peff.net>
Subject: [PATCH] Documentation: minor cleanups to branch/checkout wording
Date: Mon, 2 Jul 2007 01:28:20 -0400
Message-ID: <20070702052820.GA2590@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 07:28:26 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5ESX-0006XZ-0v
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 07:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbXGBF2X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 01:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbXGBF2X
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 01:28:23 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1662 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835AbXGBF2W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 01:28:22 -0400
Received: (qmail 11189 invoked from network); 2 Jul 2007 05:28:43 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 2 Jul 2007 05:28:43 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2007 01:28:20 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51346>

Change "to made" to "made to", which is a typo. Use "reflog"
instead of "ref log", which is used elsewhere throughout the
documentation.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-branch.txt   |    6 +++---
 Documentation/git-checkout.txt |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 9713f90..bb6b57d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -41,7 +41,7 @@ to happen.
 
 With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
-has a ref log then the ref log will also be deleted. Use -r together with -d
+has a reflog then the reflog will also be deleted. Use -r together with -d
 to delete remote-tracking branches.
 
 
@@ -54,8 +54,8 @@ OPTIONS
 	Delete a branch irrespective of its index status.
 
 -l::
-	Create the branch's ref log.  This activates recording of
-	all changes to made the branch ref, enabling use of date
+	Create the branch's reflog.  This activates recording of
+	all changes made to the branch ref, enabling use of date
 	based sha1 expressions such as "<branchname>@\{yesterday}".
 
 -f::
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index a6571d2..818b720 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -62,8 +62,8 @@ OPTIONS
 	configuration variable.
 
 -l::
-	Create the new branch's ref log.  This activates recording of
-	all changes to made the branch ref, enabling use of date
+	Create the new branch's reflog.  This activates recording of
+	all changes made to the branch ref, enabling use of date
 	based sha1 expressions such as "<branchname>@\{yesterday}".
 
 -m::
-- 
1.5.2.2.1452.g896f6
