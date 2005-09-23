From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Cogito: Minor documentation fixes
Date: Fri, 23 Sep 2005 02:40:33 +0200
Message-ID: <20050923004033.GA23708@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 02:42:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIbcW-0003ve-BF
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 02:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbVIWAky (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 20:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVIWAkx
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 20:40:53 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:51141 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1750939AbVIWAkx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 20:40:53 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id B08656E0DCE; Fri, 23 Sep 2005 02:39:31 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 7437D6E0DB7; Fri, 23 Sep 2005 02:39:31 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 94CD860E21; Fri, 23 Sep 2005 02:40:33 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9156>

 - Link to the new cg-object-id man page from cogito(7).
 - Fix cg-help usage string listing in cogito(7).
 - Make the cg-commit -m option more conforming to other options taking
   arguments (the old usage remains).
 - Use COMMIT_ID consistently.

Signed-of-by: Jonas Fonseca <fonseca@diku.dk>

---

 Documentation/make-cogito-asciidoc |    4 ++--
 cg-commit                          |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/make-cogito-asciidoc b/Documentation/make-cogito-asciidoc
--- a/Documentation/make-cogito-asciidoc
+++ b/Documentation/make-cogito-asciidoc
@@ -24,11 +24,11 @@ print_command_info()
 
 	echo
 	case "$cmdname" in
-	cg-X*|*-id)
+	cg-X*)
 		echo "$cmdname::"
 		;;
 	cg-*)
-		usage=$(sed -n '/^USAGE=/,0s/.*cg-[^ ]*\(.*\)"/\1/p' < $command)
+		usage=$(sed -n '/^USAGE=/,0s/.*"cg-[^ ]*\(.*\)"/\1/p' < $command)
 		echo "gitlink:$cmdname[] $usage::"
 		;;
 	esac
diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -25,7 +25,7 @@
 #	Note, this is used internally by 'Cogito' when merging. This option
 #	does not make sense when files are given on the command line.
 #
-# -mMESSAGE::
+# -m MESSAGE::
 #	Specify the commit message, which is used instead of starting
 #	up an editor (if the input is not `stdin`, the input is appended
 #	after all the '-m' messages). Multiple '-m' parameters are appended
@@ -111,7 +111,7 @@
 # EDITOR::
 #	The editor used for entering revision log information.
 
-USAGE="cg-commit [-mMESSAGE]... [-C] [-e | -E] [-c COMMITID] [FILE]... [< MESSAGE]"
+USAGE="cg-commit [-m MESSAGE]... [-C] [-e | -E] [-c COMMIT_ID] [FILE]... [< MESSAGE]"
 
 . ${COGITO_LIB}cg-Xlib || exit 1
 

-- 
Jonas Fonseca
