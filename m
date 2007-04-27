From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH 3/8] Update git-fmt-merge documentation
Date: Fri, 27 Apr 2007 00:09:20 -0500
Message-ID: <20070427050920.GB9798@bowser.ruder>
References: <20070427050550.GA9594@bowser.ruder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 07:11:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhIkG-0000zk-Rj
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 07:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325AbXD0FLp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 01:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755331AbXD0FLp
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 01:11:45 -0400
Received: from www.aeruder.net ([65.254.53.245]:4586 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755325AbXD0FLo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 01:11:44 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id EFAB940EC7;
	Fri, 27 Apr 2007 00:11:43 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070427050550.GA9594@bowser.ruder>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45691>

Documentation/git-fmt-merge-msg.txt:
	--summary to list commit summaries on merge
	--no-summary
	--file to take merged objects from a file.
	Configuration option merge.summary

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 Documentation/git-fmt-merge-msg.txt |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index a70eb39..e560b30 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -8,7 +8,8 @@ git-fmt-merge-msg - Produce a merge commit message
 
 SYNOPSIS
 --------
-'git-fmt-merge-msg' <$GIT_DIR/FETCH_HEAD
+git-fmt-merge-msg [--summary | --no-summary] <$GIT_DIR/FETCH_HEAD
+git-fmt-merge-msg [--summary | --no-summray] -F <file>
 
 DESCRIPTION
 -----------
@@ -19,6 +20,28 @@ passed as the '<merge-message>' argument of `git-merge`.
 This script is intended mostly for internal use by scripts
 automatically invoking `git-merge`.
 
+OPTIONS
+-------
+
+--summary::
+	In addition to branch names, populate the log message with
+	one-line descriptions from the actual commits that are being
+	merged.
+
+--no-summary::
+	Do not list one-line descriptions from the actual commits being
+	merged.
+
+--file <file>, -F <file>::
+	Take the list of merged objects from <file> instead of
+	stdin.
+
+CONFIGURATION
+-------------
+
+merge.summary::
+	Whether to include summaries of merged commits in newly
+	merge commit messages. False by default.
 
 SEE ALSO
 --------
-- 
1.5.2.rc0.64.g8476
