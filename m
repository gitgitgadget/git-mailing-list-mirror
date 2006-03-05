From: Jeff Muizelaar <jeff@infidigm.net>
Subject: [PATCH] documentation: add 'see also' sections to git-rm and git-add
Date: Sun, 5 Mar 2006 16:18:19 -0500
Message-ID: <20060305211819.GA27468@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Mar 05 22:18:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG0ce-00065q-JR
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 22:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbWCEVSY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 16:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWCEVSY
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 16:18:24 -0500
Received: from [209.161.218.26] ([209.161.218.26]:8623 "EHLO
	freiheit.infidigm.net") by vger.kernel.org with ESMTP
	id S1751743AbWCEVSY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 16:18:24 -0500
Received: from jeff by freiheit.infidigm.net with local (Exim 3.36 #1 (Debian))
	id 1FG0cN-0007AB-00
	for <git@vger.kernel.org>; Sun, 05 Mar 2006 16:18:19 -0500
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17243>

Pair up git-add and git-rm by adding a 'see also' section that
references the opposite command to each of their documentation files.

---

 Documentation/git-add.txt |    3 +++
 Documentation/git-rm.txt  |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

aedd49a31816736b244b9f61303e112431eff80c
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 7e29383..5b7c354 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -65,6 +65,9 @@ git-add git-*.sh::
 	(i.e. you are listing the files explicitly), it does not
 	add `subdir/git-foo.sh` to the index.
 
+See Also
+--------
+gitlink:git-rm[1]
 
 Author
 ------
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 401bfb2..d8a5afa 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -74,6 +74,9 @@ git-rm -f git-*.sh::
 	shell expand the asterisk (i.e. you are listing the files
 	explicitly), it does not remove `subdir/git-foo.sh`.
 
+See Also
+--------
+gitlink:git-add[1]
 
 Author
 ------
-- 
1.2.4.g8bc6
