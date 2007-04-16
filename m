From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH] Update git-apply documentation
Date: Mon, 16 Apr 2007 01:20:40 -0500
Message-ID: <20070416062040.GD19759@localdomain>
References: <20070416053525.GA18821@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 08:20:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdKa1-0008Ff-69
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 08:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbXDPGUm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 02:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752274AbXDPGUm
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 02:20:42 -0400
Received: from www.aeruder.net ([65.254.53.245]:4084 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753974AbXDPGUl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 02:20:41 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id D1F1140183;
	Mon, 16 Apr 2007 01:20:40 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070416053525.GA18821@localdomain>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44592>

Document -v (short form of --verbose).  Redo usage
to not wrap on 80 column terminal with typical
settings.

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 Documentation/git-apply.txt |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 065ba1b..3bd2c99 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -9,11 +9,12 @@ git-apply - Apply a patch on a git index file and a working tree
 SYNOPSIS
 --------
 [verse]
-'git-apply' [--stat] [--numstat] [--summary] [--check] [--index] [--apply]
-	  [--no-add] [--index-info] [--allow-binary-replacement | --binary]
-	  [-R | --reverse] [--reject] [-z] [-pNUM] [-CNUM] [--inaccurate-eof]
-	  [--whitespace=<nowarn|warn|error|error-all|strip>] [--exclude=PATH]
-	  [--cached] [--verbose] [<patch>...]
+'git-apply' [--stat] [--numstat] [--summary] [--check] [--index]
+	  [--apply] [--no-add] [--index-info] [-R | --reverse]
+	  [--allow-binary-replacement | --binary] [--reject] [-z]
+	  [-pNUM] [-CNUM] [--inaccurate-eof] [--cached]
+	  [--whitespace=<nowarn|warn|error|error-all|strip>]
+	  [--exclude=PATH] [--verbose] [<patch>...]
 
 DESCRIPTION
 -----------
@@ -158,7 +159,7 @@ discouraged.
 	correctly. This option adds support for applying such patches by
 	working around this bug.
 
---verbose::
+-v, --verbose::
 	Report progress to stderr. By default, only a message about the
 	current patch being applied will be printed. This option will cause
 	additional information to be reported.
-- 
1.5.1.1.98.gedb4f-dirty
