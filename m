From: Francis Daly <francis@daoine.org>
Subject: [PATCH] Format tweaks for asciidoc.
Date: Wed, 22 Mar 2006 09:53:57 +0000
Message-ID: <20060322095357.GA27793@craic.sysops.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Mar 22 10:55:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FM03k-0004BX-56
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 10:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWCVJzH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 04:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWCVJzH
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 04:55:07 -0500
Received: from craic.sysops.org ([217.75.2.2]:54158 "EHLO craic.sysops.org")
	by vger.kernel.org with ESMTP id S1751171AbWCVJzG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 04:55:06 -0500
Received: from craic.sysops.org (craic.sysops.org [127.0.0.1])
	by craic.sysops.org (8.12.11/8.12.11) with SMTP id k2M9rvT8028037
	for <git@vger.kernel.org>; Wed, 22 Mar 2006 09:53:57 GMT
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: ClamAV 0.87.1/1349/Tue Mar 21 22:54:43 2006 on craic.sysops.org
X-Virus-Status: Clean
X-Spam-Status: No, hits=-1.2 required=2.0
	tests=HTML_00_10,HTML_MESSAGE,USER_AGENT_MUTT
	version=2.55
X-Spam-Checker-Version: SpamAssassin 2.55 (1.174.2.19-2003-05-19-exp)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17810>


Some documentation "options" were followed by independent preformatted
paragraphs. Now they are associated plain text paragraphs. The
difference is clear in the generated html.

---

 Documentation/git-grep.txt        |   14 +++++++-------
 Documentation/git-whatchanged.txt |    6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

b833629d00b95554b23d2239cf8d42262a7a6db6
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index fbd2394..d55456a 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -24,13 +24,13 @@ OPTIONS
 
 <option>...::
 	Either an option to pass to `grep` or `git-ls-files`.
-
-	The following are the specific `git-ls-files` options
-	that may be given: `-o`, `--cached`, `--deleted`, `--others`,
-	`--killed`, `--ignored`, `--modified`, `--exclude=*`,
-	`--exclude-from=*`, and `--exclude-per-directory=*`.
-
-	All other options will be passed to `grep`.
++
+The following are the specific `git-ls-files` options
+that may be given: `-o`, `--cached`, `--deleted`, `--others`,
+`--killed`, `--ignored`, `--modified`, `--exclude=\*`,
+`--exclude-from=\*`, and `--exclude-per-directory=\*`.
++
+All other options will be passed to `grep`.
 
 <pattern>::
 	The pattern to look for.  The first non option is taken
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index f02f939..641cb7e 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -47,9 +47,9 @@ OPTIONS
 	By default, differences for merge commits are not shown.
 	With this flag, show differences to that commit from all
 	of its parents.
-
-	However, it is not very useful in general, although it
-	*is* useful on a file-by-file basis.
++
+However, it is not very useful in general, although it
+*is* useful on a file-by-file basis.
 
 Examples
 --------
-- 
1.2.GIT

-- 
Francis Daly        francis@daoine.org
