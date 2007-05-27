From: Johan Herland <johan@herland.net>
Subject: [PATCH 09/15] git-note: (Documentation) Explain new behaviour of
 --decorate in git-{log,show,whatchanged}
Date: Sun, 27 May 2007 16:14:31 +0200
Message-ID: <200705271614.31849.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
 <200705271608.02122.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 16:14:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsJW9-0007Kt-2M
	for gcvg-git@gmane.org; Sun, 27 May 2007 16:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223AbXE0OOk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 10:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753340AbXE0OOk
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 10:14:40 -0400
Received: from smtp.getmail.no ([84.208.20.33]:50799 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223AbXE0OOj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 10:14:39 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIP0000VE8ECP00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:14:38 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP0002UE887F00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:14:32 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP000YXE87JB50@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:14:32 +0200 (CEST)
In-reply-to: <200705271608.02122.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48549>

The addition of git notes to --decorate output is noted on the git-log
manual page. In addition, the --decorate documentation is copied to the
git-show and git-whatchanged manual pages, where any mention of --decorate
have been missing until now.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-log.txt         |    3 ++-
 Documentation/git-show.txt        |    4 ++++
 Documentation/git-whatchanged.txt |    4 ++++
 3 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 0f353f6..1168372 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -52,7 +52,8 @@ include::pretty-options.txt[]
 	See also gitlink:git-reflog[1].
 
 --decorate::
-    Print out the ref names of any commits that are shown.
+	Print out the ref names and notes associated with any commits that are
+	shown.
 
 <paths>...::
 	Show only commits that affect the specified paths.
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 34c5caf..a31ba6b 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -38,6 +38,10 @@ OPTIONS
 	For a more complete list of ways to spell object names, see
 	"SPECIFYING REVISIONS" section in gitlink:git-rev-parse[1].
 
+--decorate::
+	Print out the ref names and notes associated with any commits that are
+	shown.
+
 include::pretty-options.txt[]
 
 
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index 399bff3..3f77b3d 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -43,6 +43,10 @@ OPTIONS
 	<format> can be one of 'raw', 'medium', 'short', 'full',
 	and 'oneline'.
 
+--decorate::
+	Print out the ref names and notes associated with any commits that are
+	shown.
+
 -m::
 	By default, differences for merge commits are not shown.
 	With this flag, show differences to that commit from all
-- 
1.5.2.101.gee49f
