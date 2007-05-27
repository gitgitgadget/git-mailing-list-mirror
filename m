From: Johan Herland <johan@herland.net>
Subject: [PATCH 13/15] git-note: (Documentation) Explain the new --notes option
 to git-push
Date: Sun, 27 May 2007 16:16:20 +0200
Message-ID: <200705271616.20882.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
 <200705271608.02122.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 16:16:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsJXo-0007VJ-SR
	for gcvg-git@gmane.org; Sun, 27 May 2007 16:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbXE0OQY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 10:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753512AbXE0OQY
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 10:16:24 -0400
Received: from smtp.getmail.no ([84.208.20.33]:52358 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753511AbXE0OQX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 10:16:23 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIP00003EBAHV00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:16:22 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP0005KEB97D00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:16:21 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP000I8EB8J760@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:16:21 +0200 (CEST)
In-reply-to: <200705271608.02122.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48553>

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-push.txt |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index e9ad106..2e98844 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git-push' [--all] [--tags] [--receive-pack=<git-receive-pack>]
+'git-push' [--all] [--tags] [--notes] [--receive-pack=<git-receive-pack>]
            [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]
 
 DESCRIPTION
@@ -69,6 +69,11 @@ the remote repository.
 	addition to refspecs explicitly listed on the command
 	line.
 
+\--notes::
+	All refs under `$GIT_DIR/refs/notes` are pushed, in
+	addition to refspecs explicitly listed on the command
+	line.
+
 \--receive-pack=<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
 	end.  Sometimes useful when pushing to a remote
-- 
1.5.2.101.gee49f
