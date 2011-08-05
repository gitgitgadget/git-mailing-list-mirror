From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] misc-sh: fix up whitespace in some other .sh files.
Date: Fri,  5 Aug 2011 23:31:29 +1000
Message-ID: <1312551089-3753-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 15:31:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpKV6-0004td-PY
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 15:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756605Ab1HENbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 09:31:40 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63290 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526Ab1HENbj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 09:31:39 -0400
Received: by yxj19 with SMTP id 19so1436174yxj.19
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 06:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=NpJ3gIxMEctEyPxeRN4uLqjL+v+xN9hPWwV1tZ6odUw=;
        b=pCgcyL/RecjP0UvwahhbD6Vd7eUJwjRrCfuUc/DAn4HYpSpVUYaiwp9ArOjPcMC4V+
         3SjmSgjMqFizMiaoT7JOA/4qyS34muagkDohlFShPvPYGdUC+sWMlqDVq8k/sX1xNZQ+
         bCX9/dKST6rcbTv8jna5r4WAWa7kIncmgPlZg=
Received: by 10.91.208.40 with SMTP id k40mr457989agq.139.1312551099040;
        Fri, 05 Aug 2011 06:31:39 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id e16sm2323927anb.40.2011.08.05.06.31.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Aug 2011 06:31:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.360.geebb0f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178794>

I found that the patched 4 files were different when this
filter is applied.

	expand -i | unexpand --first-only

This patch contains the corrected files.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 generate-cmdlist.sh   |    4 ++--
 git-filter-branch.sh  |   12 ++++++------
 git-mergetool--lib.sh |    6 +++---
 git-rebase.sh         |    2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 3ef4861..1093ef4 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -15,8 +15,8 @@ do
      sed -n '
      /^NAME/,/git-'"$cmd"'/H
      ${
-            x
-            s/.*git-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
+	    x
+	    s/.*git-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
 	    p
      }' "Documentation/git-$cmd.txt"
 done
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 962a93b..0d399aa 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -12,7 +12,7 @@
 
 functions=$(cat << \EOF
 warn () {
-        echo "$*" >&2
+	echo "$*" >&2
 }
 
 map()
@@ -98,11 +98,11 @@ set_ident () {
 }
 
 USAGE="[--env-filter <command>] [--tree-filter <command>]
-            [--index-filter <command>] [--parent-filter <command>]
-            [--msg-filter <command>] [--commit-filter <command>]
-            [--tag-name-filter <command>] [--subdirectory-filter <directory>]
-            [--original <namespace>] [-d <directory>] [-f | --force]
-            [<rev-list options>...]"
+	    [--index-filter <command>] [--parent-filter <command>]
+	    [--msg-filter <command>] [--commit-filter <command>]
+	    [--tag-name-filter <command>] [--subdirectory-filter <directory>]
+	    [--original <namespace>] [-d <directory>] [-f | --force]
+	    [<rev-list options>...]"
 
 OPTIONS_SPEC=
 . git-sh-setup
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 91f90ac..9a89e8f 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -79,7 +79,7 @@ get_merge_tool_cmd () {
 	fi
 	if diff_mode; then
 		echo "$(git config difftool.$merge_tool.cmd ||
-		        git config mergetool.$merge_tool.cmd)"
+			git config mergetool.$merge_tool.cmd)"
 	else
 		echo "$(git config mergetool.$merge_tool.cmd)"
 	fi
@@ -419,7 +419,7 @@ get_merge_tool_path () {
 	fi
 	if diff_mode; then
 		merge_tool_path=$(git config difftool."$merge_tool".path ||
-		                  git config mergetool."$merge_tool".path)
+				  git config mergetool."$merge_tool".path)
 	else
 		merge_tool_path=$(git config mergetool."$merge_tool".path)
 	fi
@@ -429,7 +429,7 @@ get_merge_tool_path () {
 	if test -z "$(get_merge_tool_cmd "$merge_tool")" &&
 	! type "$merge_tool_path" > /dev/null 2>&1; then
 		echo >&2 "The $TOOL_MODE tool $merge_tool is not available as"\
-		         "'$merge_tool_path'"
+			 "'$merge_tool_path'"
 		exit 1
 	fi
 	echo "$merge_tool_path"
diff --git a/git-rebase.sh b/git-rebase.sh
index 266a4c1..6759702 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -22,7 +22,7 @@ currently checked out branch is used.
 
 Example:       git-rebase master~1 topic
 
-        A---B---C topic                   A'\''--B'\''--C'\'' topic
+	A---B---C topic                   A'\''--B'\''--C'\'' topic
        /                   -->           /
   D---E---F---G master          D---E---F---G master
 '
-- 
1.7.6.360.geebb0f
