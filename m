From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 06/23] contrib/subtree: Rename commands push_all/pull_all to push-all/pull-all
Date: Sun, 10 Mar 2013 23:41:14 +0000
Message-ID: <1362958891-26941-7-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Matt Hoffman <matt.hoffman@quantumretail.com>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Peter Jaros" <pjaros@pivotallabs.com>,
	"Avery Pennarun" <apenwarr@gmail.com>, "bibendi" <bibendi@bk.ru>,
	"Win Treese" <treese@acm.org>, "Wayne Walter" <wayne@tickzoom.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:44:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpuu-000464-1Z
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab3CJXoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:44:08 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:34338 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab3CJXoG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:44:06 -0400
Received: by mail-wg0-f45.google.com with SMTP id dq12so4276718wgb.0
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=gzK3a3vo33g1plcua9aVbupRqwOaWkfwEdxiox5pTNM=;
        b=BAMzJDNNLX7foayL6ENulR+YL0fXbv1c90CTn+ObgQd8XS77Fn+NjSKLqxW+LiDGAR
         VLNXTttIYsn6U5iBlcz1FpWGL1y0m09QXqkjJK9DFSFg7hQdaQ3AojWosDbEdyCdEjpC
         GBBWlN8+y5aIFGrCQtx2j0/qLHUdmtujA17flgFXzDJdnEDTB9VkBKC/3vqWSV82xV7z
         1NNaXraz1HSryr+pO9RXVyWaiM1Qw+4+6dTH0u586G74PuvGU9tXq70JBOoOhyqwkhsK
         jz4ioX1a9uQHFCpqeX7XAvw2pQvd56TeISBskdf/x7aq7TAh698RRgipANwypyxV1Ak5
         Gkag==
X-Received: by 10.194.121.6 with SMTP id lg6mr15618325wjb.22.1362959045267;
        Sun, 10 Mar 2013 16:44:05 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.43.59
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:44:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQkj8E7nHIv62PMTcx4ln4MfR3OBerc8HGtMEArD0lmxQgTcj9rpXhEPLMbRFPdSx260ZR9U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217826>

From: Matt Hoffman <matt.hoffman@quantumretail.com>

Changing underscores to dashes (push_all -> push-all)

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>

Conflicts:
	.gitignore
	contrib/subtree/git-subtree.sh
---
 contrib/subtree/git-subtree.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index ddae56e..39d764b 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -12,7 +12,8 @@ git subtree add   --prefix=<prefix> <commit>
 git subtree add   --prefix=<prefix> <repository> <commit>
 git subtree merge --prefix=<prefix> <commit>
 git subtree pull  --prefix=<prefix> <repository> <refspec...>
-git subtree pull_all
+git subtree pull-all
+git subtree push-all
 git subtree push  --prefix=<prefix> <repository> <refspec...>
 git subtree split --prefix=<prefix> <commit...>
 git subtree from-submodule --prefix=<prefix>
@@ -103,18 +104,18 @@ done
 command="$1"
 shift
 case "$command" in
-	add|merge|pull|from-submodule|pull_all|push_all) default= ;;
+	add|merge|pull|from-submodule|pull-all|push-all) default= ;;
 	split|push) default="--default HEAD" ;;
 	*) die "Unknown command '$command'" ;;
 esac
 
-if [ -z "$prefix" -a "$command" != "pull_all" -a "$command" != "push_all" ]; then
+if [ -z "$prefix" -a "$command" != "pull-all" -a "$command" != "push-all" ]; then
 	die "You must provide the --prefix option."
 fi
 
 case "$command" in
-    pull_all);;
-    push_all);;
+    pull-all);;
+    push-all);;
 	add) [ -e "$prefix" ] && 
 		die "prefix '$prefix' already exists." ;;
 	*)   [ -e "$prefix" ] || 
@@ -123,7 +124,7 @@ esac
 
 dir="$(dirname "$prefix/.")"
 
-if [ "$command" != "pull" -a "$command" != "add" -a "$command" != "push" -a "$command" != "pull_all" ]; then
+if [ "$command" != "pull" -a "$command" != "add" -a "$command" != "push" -a "$command" != "pull-all" ]; then
 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
 	dirs="$(git rev-parse --no-revs --no-flags "$@")" || exit $?
 	if [ -n "$dirs" ]; then
@@ -770,7 +771,7 @@ cmd_from-submodule()
 	rm -rf $tmp_repo
 }
 
-cmd_pull_all()
+cmd_pull-all()
 {
     git config -f .gittrees -l | grep subtree | grep path | grep -o '=.*' | grep -o '[^=].*' |
         while read path; do
@@ -778,7 +779,7 @@ cmd_pull_all()
         done
 }
 
-cmd_push_all()
+cmd_push-all()
 {
     git config -f .gittrees -l | grep subtree | grep path | grep -o '=.*' | grep -o '[^=].*' |
         while read path; do
-- 
1.8.2.rc1
