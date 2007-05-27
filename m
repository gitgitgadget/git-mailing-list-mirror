From: Johan Herland <johan@herland.net>
Subject: [PATCH 06/15] git-note: (Documentation) Explain the new '--notes'
 option to git-rev-parse and git-show-ref
Date: Sun, 27 May 2007 16:13:09 +0200
Message-ID: <200705271613.09919.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
 <200705271608.02122.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 16:13:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsJV3-0007Cd-UC
	for gcvg-git@gmane.org; Sun, 27 May 2007 16:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbXE0ONc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 10:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753285AbXE0ONc
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 10:13:32 -0400
Received: from smtp.getmail.no ([84.208.20.33]:64073 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752991AbXE0ONb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 10:13:31 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIP00503E6I8Z00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:13:30 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP00GTYE5YR340@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:13:10 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP000X0E5XJ750@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:13:10 +0200 (CEST)
In-reply-to: <200705271608.02122.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48546>

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-rev-parse.txt |    5 ++++-
 Documentation/git-show-ref.txt  |   14 +++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 7757abe..7d36011 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -73,8 +73,11 @@ OPTIONS
 --tags::
 	Show tag refs found in `$GIT_DIR/refs/tags`.
 
+--notes::
+	Show note refs found in `$GIT_DIR/refs/notes`.
+
 --remotes::
-	Show tag refs found in `$GIT_DIR/refs/remotes`.
+	Show refs found in `$GIT_DIR/refs/remotes`.
 
 --show-prefix::
 	When the command is invoked from a subdirectory, show the
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 2355aa5..7e204f0 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git-show-ref' [-q|--quiet] [--verify] [-h|--head] [-d|--dereference]
-	     [-s|--hash] [--abbrev] [--tags] [--heads] [--] <pattern>...
+	     [-s|--hash] [--abbrev] [--tags] [--heads] [--notes] [--] <pattern>...
 'git-show-ref' --exclude-existing[=pattern]
 
 DESCRIPTION
@@ -33,16 +33,16 @@ OPTIONS
 
 	Show the HEAD reference.
 
---tags, --heads::
+--heads, --tags, --notes::
 
-	Limit to only "refs/heads" and "refs/tags", respectively.  These
-	options are not mutually exclusive; when given both, references stored
-	in "refs/heads" and "refs/tags" are displayed.
+	Limit to only "refs/heads", "refs/tags" and "refs/notes", respectively.
+	These options are not mutually exclusive; when given more than one,
+	references classified as any of them are displayed.
 
 -d, --dereference::
 
-	Dereference tags into object IDs as well. They will be shown with "^{}"
-	appended.
+	Dereference tags and notes into object IDs as well. They will be shown
+	with "^{}" appended.
 
 -s, --hash::
 
-- 
1.5.2.101.gee49f
