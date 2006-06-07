From: Francis Daly <francis@daoine.org>
Subject: [PATCH] config.txt grammar, typo, and asciidoc fixes
Date: Thu, 8 Jun 2006 00:15:05 +0100
Message-ID: <20060607231505.GX29682@craic.sysops.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 08 01:15:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo7FA-000679-9J
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 01:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWFGXPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 19:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWFGXPI
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 19:15:08 -0400
Received: from craic.sysops.org ([217.75.2.2]:36585 "EHLO craic.sysops.org")
	by vger.kernel.org with ESMTP id S932463AbWFGXPH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jun 2006 19:15:07 -0400
Received: from craic.sysops.org (craic.sysops.org [127.0.0.1])
	by craic.sysops.org (8.13.1/8.12.11) with SMTP id k57NF5Jw031907
	for <git@vger.kernel.org>; Thu, 8 Jun 2006 00:15:05 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: ClamAV 0.88/1517/Wed Jun  7 01:05:07 2006 on craic.sysops.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.5
X-Spam-Checker-Version: SpamAssassin 3.0.5 (2005-11-28) on craic.sysops.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21463>

Nothing major.

Signed-off-by: Francis Daly <francis@daoine.org>

---

The first change makes it "the behaviour of the git command". If it was
intended to be "the behaviour(s?) of the git commands" it would be a
slightly different change.

0d3cd4b4e7cb25b239808ad2c63e3e8c7ff48db2
 Documentation/config.txt |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

0d3cd4b4e7cb25b239808ad2c63e3e8c7ff48db2
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 570b691..03eef40 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2,15 +2,15 @@ CONFIGURATION FILE
 ------------------
 
 The git configuration file contains a number of variables that affect
-the git commands behavior. They can be used by both the git plumbing
-and the porcelains. The variables are divided to sections, where
+the git command's behavior. They can be used by both the git plumbing
+and the porcelains. The variables are divided into sections, where
 in the fully qualified variable name the variable itself is the last
 dot-separated segment and the section name is everything before the last
 dot. The variable names are case-insensitive and only alphanumeric
 characters are allowed. Some variables may appear multiple times.
 
 The syntax is fairly flexible and permissive; whitespaces are mostly
-ignored. The '#' and ';' characters begin commends to the end of line,
+ignored. The '#' and ';' characters begin comments to the end of line,
 blank lines are ignored, lines containing strings enclosed in square
 brackets start sections and all the other lines are recognized
 as setting variables, in the form 'name = value'. If there is no equal
@@ -35,8 +35,8 @@ Variables
 ~~~~~~~~~
 
 Note that this list is non-comprehensive and not necessarily complete.
-For command-specific variables, you will find more detailed description
-in the appropriate manual page. You will find description of non-core
+For command-specific variables, you will find a more detailed description
+in the appropriate manual page. You will find a description of non-core
 porcelain configuration variables in the respective porcelain documentation.
 
 core.fileMode::
@@ -52,10 +52,10 @@ core.gitProxy::
 	on hostnames ending with the specified domain string. This variable
 	may be set multiple times and is matched in the given order;
 	the first match wins.
-
-	Can be overridden by the 'GIT_PROXY_COMMAND' environment variable
-	(which always applies universally, without the special "for"
-	handling).
++
+Can be overridden by the 'GIT_PROXY_COMMAND' environment variable
+(which always applies universally, without the special "for"
+handling).
 
 core.ignoreStat::
 	The working copy files are assumed to stay unchanged until you
-- 
1.3.3.g63df-dirty

-- 
Francis Daly        francis@daoine.org
