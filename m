From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] manpages: insert two missing [verse] markers for multi-line SYNOPSIS
Date: Thu, 2 Mar 2006 17:10:49 +0100
Message-ID: <20060302161049.GA4389@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 17:11:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEqOF-0004un-F1
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 17:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbWCBQKx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 11:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbWCBQKx
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 11:10:53 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:35017 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751998AbWCBQKw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 11:10:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 88E2C770036;
	Thu,  2 Mar 2006 17:10:51 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06348-19; Thu,  2 Mar 2006 17:10:49 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id D731877001E;
	Thu,  2 Mar 2006 17:10:49 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id C691E6DF89F; Thu,  2 Mar 2006 17:09:35 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id BBB4361D03; Thu,  2 Mar 2006 17:10:49 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17086>

Found with:

	for i in *.txt; do
		grep -A 2 "SYNOPSIS" "$i" | grep -q "^\[verse\]$" && continue
		multiline=$(grep -A 3 "SYNOPSIS" "$i" | tail -n 1)
		test -n "$multiline" && echo "$i: $multiline"
	done

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 Documentation/git-repo-config.txt |    1 +
 Documentation/git-svnimport.txt   |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

c7336e4b19bf7683540ea4d6704c0f522067f2de
diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
index 33fcde4..00efde5 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -8,6 +8,7 @@ git-repo-config - Get and set options in
 
 SYNOPSIS
 --------
+[verse]
 'git-repo-config' [type] name [value [value_regex]]
 'git-repo-config' [type] --replace-all name [value [value_regex]]
 'git-repo-config' [type] --get name [value_regex]
diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.txt
index 912a808..deee66a 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -9,6 +9,7 @@ git-svnimport - Import a SVN repository 
 
 SYNOPSIS
 --------
+[verse]
 'git-svnimport' [ -o <branch-for-HEAD> ] [ -h ] [ -v ] [ -d | -D ]
 		[ -C <GIT_repository> ] [ -i ] [ -u ] [-l limit_rev]
 		[ -b branch_subdir ] [ -T trunk_subdir ] [ -t tag_subdir ]
-- 
1.2.3.g858c-dirty



-- 
Jonas Fonseca
