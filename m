From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 6/9] contrib/git-svn.txt: add a note about renamed/copied directory support
Date: Mon, 20 Feb 2006 10:57:28 -0800
Message-ID: <11404618483094-git-send-email-normalperson@yhbt.net>
References: <11404618481876-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: junkio@cox.net, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 19:57:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBGEN-0001UO-CO
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 19:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbWBTS5f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 13:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbWBTS5e
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 13:57:34 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58811 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932631AbWBTS5a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2006 13:57:30 -0500
Received: from untitled (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id B4F632DC09F;
	Mon, 20 Feb 2006 10:57:28 -0800 (PST)
In-Reply-To: <11404618481876-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16490>

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

72331d46b99b182406e06070e905123f76abbac8
diff --git a/contrib/git-svn/git-svn.txt b/contrib/git-svn/git-svn.txt
index 07a236f..cf098d7 100644
--- a/contrib/git-svn/git-svn.txt
+++ b/contrib/git-svn/git-svn.txt
@@ -206,6 +206,13 @@ working trees with metadata files.
 svn:keywords can't be ignored in Subversion (at least I don't know of
 a way to ignore them).
 
+Renamed and copied directories are not detected by git and hence not
+tracked when committing to SVN.  I do not plan on adding support for
+this as it's quite difficult and time-consuming to get working for all
+the possible corner cases (git doesn't do it, either).  Renamed and
+copied files are fully supported if they're similar enough for git to
+detect them.
+
 Author
 ------
 Written by Eric Wong <normalperson@yhbt.net>.
-- 
1.2.0.gdee6
