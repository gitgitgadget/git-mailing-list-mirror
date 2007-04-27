From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH 1/8] Removing -n option from git-diff-files documentation
Date: Fri, 27 Apr 2007 00:05:50 -0500
Message-ID: <20070427050550.GA9594@bowser.ruder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 07:08:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhIhD-0008Ag-68
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 07:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755328AbXD0FIQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 01:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755325AbXD0FIQ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 01:08:16 -0400
Received: from www.aeruder.net ([65.254.53.245]:3550 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755328AbXD0FIP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 01:08:15 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id 4932D40B43;
	Fri, 27 Apr 2007 00:08:14 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45688>

-n is not a short form of --no-index as the documentation
suggests.  Removing it from the documentation and command
usage string.

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 Documentation/git-diff-files.txt |    4 ++--
 builtin-diff-files.c             |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
index b78c4c6..2e1e29e 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -8,7 +8,7 @@ git-diff-files - Compares files in the working tree and the index
 
 SYNOPSIS
 --------
-'git-diff-files' [-q] [-0|-1|-2|-3|-c|--cc|-n|--no-index] [<common diff options>] [<path>...]
+'git-diff-files' [-q] [-0|-1|-2|-3|-c|--cc|--no-index] [<common diff options>] [<path>...]
 
 DESCRIPTION
 -----------
@@ -36,7 +36,7 @@ omit diff output for unmerged entries and just show "Unmerged".
 	diff, similar to the way 'diff-tree' shows a merge
 	commit with these flags.
 
-\-n,\--no-index::
+--no-index::
 	Compare the two given files / directories.
 
 -q::
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 6ba5077..6cb30c8 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -10,7 +10,7 @@
 #include "builtin.h"
 
 static const char diff_files_usage[] =
-"git-diff-files [-q] [-0/-1/2/3 |-c|--cc|-n|--no-index] [<common diff options>] [<path>...]"
+"git-diff-files [-q] [-0/-1/2/3 |-c|--cc|--no-index] [<common diff options>] [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
 int cmd_diff_files(int argc, const char **argv, const char *prefix)
-- 
1.5.2.rc0.64.g8476
