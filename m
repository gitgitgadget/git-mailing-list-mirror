From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Document git-ls-tree --fullname
Date: Wed, 7 Jun 2006 21:46:55 +0200
Message-ID: <20060607194654.GB21448@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 07 21:47:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo3zY-000160-Sv
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 21:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWFGTq6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 15:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWFGTq6
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 15:46:58 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:41888 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S932358AbWFGTq5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jun 2006 15:46:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id BB43E770051;
	Wed,  7 Jun 2006 21:46:56 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07324-03; Wed,  7 Jun 2006 21:46:55 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 5E5BE770050;
	Wed,  7 Jun 2006 21:46:55 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 9B1746DF8AC; Wed,  7 Jun 2006 21:43:34 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 45BEB6262B; Wed,  7 Jun 2006 21:46:55 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21456>

Additionally, reformat synopsis and remove stub notice.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 018c401..7e072b5 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -8,9 +8,10 @@ git-ls-tree - Lists the contents of a tr
 
 SYNOPSIS
 --------
+[verse]
 'git-ls-tree' [-d] [-r] [-t] [-z]
-	[--name-only] [--name-status] [--full-name] [--abbrev=[<n>]]
-	<tree-ish> [paths...]
+	    [--name-only] [--name-status] [--full-name] [--abbrev=[<n>]]
+	    <tree-ish> [paths...]
 
 DESCRIPTION
 -----------
@@ -47,6 +48,10 @@ OPTIONS
 	lines, show only handful hexdigits prefix.
 	Non default number of digits can be specified with --abbrev=<n>.
 
+--full-name::
+	Instead of showing the path names relative the current working
+	directory, show the full path names.
+
 paths::
 	When paths are given, show them (note that this isn't really raw
 	pathnames, but rather a list of patterns to match).  Otherwise
@@ -72,8 +77,6 @@ Documentation
 Documentation by David Greaves, Junio C Hamano and the git-list
 <git@vger.kernel.org>.
 
-This manual page is a stub. You can help the git documentation by expanding it.
-
 GIT
 ---
 Part of the gitlink:git[7] suite

-- 
Jonas Fonseca
