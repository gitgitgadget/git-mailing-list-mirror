From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] core-tutorial.txt: escape asterisk
Date: Sun, 7 May 2006 19:32:53 +0200
Message-ID: <E1Fcn7l-0003ru-ER@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 07 19:33:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcn82-0006Qr-5l
	for gcvg-git@gmane.org; Sun, 07 May 2006 19:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWEGRc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 13:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWEGRc4
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 13:32:56 -0400
Received: from moooo.ath.cx ([85.116.203.178]:5768 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932204AbWEGRcz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 13:32:55 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19706>

---
I don't now exactly why, but this asterisk has to be escaped to show
up correctly in the html format.

 Documentation/core-tutorial.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

7e3a9fbafb8b6aa4ce460221a982feda06549215
diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 4211c81..d1360ec 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -971,7 +971,7 @@ environment, is `git show-branch`.
 The first two lines indicate that it is showing the two branches
 and the first line of the commit log message from their
 top-of-the-tree commits, you are currently on `master` branch
-(notice the asterisk `*` character), and the first column for
+(notice the asterisk `\*` character), and the first column for
 the later output lines is used to show commits contained in the
 `master` branch, and the second column for the `mybranch`
 branch. Three commits are shown along with their log messages.
-- 
1.3.2
