From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] user-manual: insert earlier of mention content-addressable architecture
Date: Sun,  4 Mar 2007 16:59:13 -0500
Message-ID: <11730455592152-git-send-email-bfields@citi.umich.edu>
References: <1173045556191-git-send-email-bfields@citi.umich.edu> <11730455574115-git-send-email-bfields@citi.umich.edu> <1173045558959-git-send-email-bfields@citi.umich.edu> <11730455591178-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 04 23:08:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNysl-00081f-S0
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 23:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbXCDWIZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 17:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbXCDWIY
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 17:08:24 -0500
Received: from pool-138-88-140-139.esr.east.verizon.net ([138.88.140.139]:50417
	"EHLO pad.fieldses.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752164AbXCDWIW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 17:08:22 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Mar 2007 17:08:19 EST
Received: from pad.fieldses.org (localhost [127.0.0.1] (may be forged))
	by pad.fieldses.org (8.13.8/8.13.8) with ESMTP id l24LxK3q006631;
	Sun, 4 Mar 2007 16:59:20 -0500
Received: (from bfields@localhost)
	by pad.fieldses.org (8.13.8/8.13.8/Submit) id l24LxJAH006630;
	Sun, 4 Mar 2007 16:59:19 -0500
X-Mailer: git-send-email 1.5.0.gb75812-dirty
In-Reply-To: <11730455591178-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41378>

From: J. Bruce Fields <bfields@citi.umich.edu>

The content-addressable design is too important not to be worth at least
a brief mention a little earlier on.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 0979211..33f8a72 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -391,15 +391,20 @@ index 8be626f..d7aac9d 100644
 As you can see, a commit shows who made the latest change, what they
 did, and why.
 
-Every commit has a 40-hexdigit id, sometimes called the "object name"
-or the "SHA1 id", shown on the first line of the "git show" output.
-You can usually refer to a commit by a shorter name, such as a tag or a
-branch name, but this longer name can also be useful.  Most
-importantly, it is a globally unique name for this commit: so if you
-tell somebody else the object name (for example in email), then you are
-guaranteed that name will refer to the same commit in their repository
-that it does in yours (assuming their repository has that commit at
-all).
+Every commit has a 40-hexdigit id, sometimes called the "object name" or the
+"SHA1 id", shown on the first line of the "git show" output.  You can usually
+refer to a commit by a shorter name, such as a tag or a branch name, but this
+longer name can also be useful.  Most importantly, it is a globally unique
+name for this commit: so if you tell somebody else the object name (for
+example in email), then you are guaranteed that name will refer to the same
+commit in their repository that it does in yours (assuming their repository
+has that commit at all).  Since the object name is computed as a hash over the
+contents of the commit, you are guaranteed that the commit can never change
+without its name also changing.
+
+In fact, in <<git-internals>> we shall see that everything stored in git
+history, including file data and directory contents, is stored in an object
+with a name that is a hash of its contents.
 
 Understanding history: commits, parents, and reachability
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -2155,6 +2160,7 @@ See gitlink:git-config[1] for more details on the configuration
 options mentioned above.
 
 
+[[git-internals]]
 Git internals
 =============
 
-- 
1.5.0.gb75812-dirty
