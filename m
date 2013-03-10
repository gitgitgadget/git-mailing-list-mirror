From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 21/23] contrib/subtree: Convert spaces to tabs and remove some trailing whitespace
Date: Sun, 10 Mar 2013 23:41:29 +0000
Message-ID: <1362958891-26941-22-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Herman van Rink <rink@initfour.nl>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Peter Jaros" <pjaros@pivotallabs.com>,
	"James Roper" <jroper@vz.net>, "Michael Hart" <michael@adslot.com>,
	"Matt Hoffman" <matt.hoffman@quantumretail.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Jakub Suder" <jakub.suder@gmail.com>,
	"Nate Jones" <nate@endot.org>, "bibendi" <bibendi@bk.ru>,
	"Win Treese" <treese@acm.org>, "Wayne Walter" <wayne@tickzoom.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:46:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpwM-0005Ly-HD
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406Ab3CJXpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:45:35 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:39980 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249Ab3CJXpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:45:33 -0400
Received: by mail-wg0-f51.google.com with SMTP id 8so4262537wgl.18
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=VXROSr8ALlQYhq7cRjPENfi6jmVYshrd5RZwPo9jSF0=;
        b=KTc81+CxP30KBL+efk45rkNIFHaLVpCSRiXZmsMGiFDcKpH8ITwc67rH6Ws0wXz6ky
         seA2SylrLrzJYFxCT+XfEfliAV6NjTsPw7ofoYtlx4w77kO2VyWaEKUh9NSNgTjZ2oon
         cVsxaFdEdKujC3A0LWIx8223SfRJwfn7Agm5nBd2JjWxW8WSm+XTkd26qHvL6QUnce1e
         +XjHpNXE2o/Le5SVXKV0CTOmriydldxGtZUsQB5zelb20Xdz39+d6qTcXrv/UNDp3tpb
         A4t4v/cWdJJtA/V0n/zmxNz52rPmOA8LYhNT2rUKqSsfFb6pwHhJpYZ8YjNXAOwbFl6N
         PaDg==
X-Received: by 10.194.242.163 with SMTP id wr3mr15572157wjc.35.1362959132016;
        Sun, 10 Mar 2013 16:45:32 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.45.27
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:45:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQkix8JGfwjZmByQnz9j7gFD9lHvszyq8v0VBjQajIJEXUF1/Pq46izLZCPo8LwETzypPalM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217842>

From: Herman van Rink <rink@initfour.nl>

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>

Conflicts:
	contrib/subtree/.gitignore
	contrib/subtree/git-subtree.sh
	contrib/subtree/test.sh
---

It's a nasty formatting only patch and I won't be surprised or too dissappiointed
if this doesn't make it. Or are the rules for this more lax for contrib? How else
can contrib be brought in-line with coding standards?

 contrib/subtree/git-subtree.sh | 213 +++++++++++++++++++++--------------------
 1 file changed, 109 insertions(+), 104 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 3582a55..263ea9f 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -92,7 +92,7 @@ while [ $# -gt 0 ]; do
 		-b) branch="$1"; shift ;;
 		-P) prefix="$1"; shift ;;
 		-m) message="$1"; shift ;;
-        -f|--force) force=1 ;;
+		-f|--force) force=1 ;;
 		--no-prefix) prefix= ;;
 		--onto) onto="$1"; shift ;;
 		--no-onto) onto= ;;
@@ -123,8 +123,10 @@ if [ -z "$prefix" -a "$command" != "pull-all" -a "$command" != "push-all" -a "$c
 fi
 
 case "$command" in
-    pull-all);;
-    push-all);;
+	pull-all);;
+	push-all);;
+	list);;
+	prune);;
 	add) [ -e "$prefix" ] && 
 		die "prefix '$prefix' already exists." ;;
 	*)   [ -e "$prefix" ] || 
@@ -541,14 +543,14 @@ cmd_add_repository()
 	revs=FETCH_HEAD
 	set -- $revs
 	cmd_add_commit "$@"
-  
-  # now add it to our list of repos 
-  git config -f .gittrees --unset subtree.$dir.url
-  git config -f .gittrees --add subtree.$dir.url $repository
-  git config -f .gittrees --unset subtree.$dir.path
-  git config -f .gittrees --add subtree.$dir.path $dir
-  git config -f .gittrees --unset subtree.$dir.branch
-  git config -f .gittrees --add subtree.$dir.branch $refspec
+
+	# now add it to our list of repos
+	git config -f .gittrees --unset subtree.$dir.url
+	git config -f .gittrees --add subtree.$dir.url $repository
+	git config -f .gittrees --unset subtree.$dir.path
+	git config -f .gittrees --add subtree.$dir.path $dir
+	git config -f .gittrees --unset subtree.$dir.branch
+	git config -f .gittrees --add subtree.$dir.branch $refspec
 }
 
 cmd_add_commit()
@@ -721,89 +723,91 @@ cmd_merge()
 
 cmd_pull()
 {
-  if [ $# -gt 2 ]; then
-	    die "You should provide either <refspec> or <repository> <refspec>"
+	if [ $# -gt 2 ]; then
+		die "You should provide either <refspec> or <repository> <refspec>"
 	fi
 	if [ -e "$dir" ]; then
-	    ensure_clean
-      if [ $# -eq 1 ]; then 
-	      repository=$(git config -f .gittrees subtree.$prefix.url)
-	      refspec=$1
-      elif [ $# -eq 2 ]; then 
-        repository=$1
-        refspec=$2
-      else 
-	      repository=$(git config -f .gittrees subtree.$prefix.url)
-        refspec=$(git config -f .gittrees subtree.$prefix.branch)
-      fi
-	    git fetch $repository $refspec || exit $?
-	    echo "git fetch using: " $repository $refspec
-	    revs=FETCH_HEAD
-	    set -- $revs
-	    cmd_merge "$@"
+		ensure_clean
+		if [ $# -eq 1 ]; then
+			repository=$(git config -f .gittrees subtree.$prefix.url)
+			refspec=$1
+		elif [ $# -eq 2 ]; then
+			repository=$1
+			refspec=$2
+		else
+			repository=$(git config -f .gittrees subtree.$prefix.url)
+			refspec=$(git config -f .gittrees subtree.$prefix.branch)
+		fi
+		git fetch $repository $refspec || exit $?
+		echo "git fetch using: " $repository $refspec
+		revs=FETCH_HEAD
+		set -- $revs
+		cmd_merge "$@"
 	else
-	    die "'$dir' must already exist. Try 'git subtree add'."
+		die "'$dir' must already exist. Try 'git subtree add'."
 	fi
 }
 
-cmd_diff() 
-{
-    if [ -e "$dir" ]; then
-        if [ $# -eq 1 ]; then 
-            repository=$(git config -f .gittrees subtree.$prefix.url)
-            refspec=$1
-        elif [ $# -eq 2 ]; then 
-            repository=$1
-            refspec=$2
-        else
-            repository=$(git config -f .gittrees subtree.$prefix.url)
-            refspec=$(git config -f .gittrees subtree.$prefix.branch)
-        fi
-        # this is ugly, but I don't know of a better way to do it. My git-fu is weak. 
-        # git diff-tree expects a treeish, but I have only a repository and branch name.
-        # I don't know how to turn that into a treeish without creating a remote.
-        # Please change this if you know a better way! 
-        tmp_remote=__diff-tmp
-        git remote rm $tmp_remote > /dev/null 2>&1
-        git remote add -t $refspec $tmp_remote $repository > /dev/null
-        # we fetch as a separate step so we can pass -q (quiet), which isn't an option for "git remote"
-        # could this instead be "git fetch -q $repository $refspec" and leave aside creating the remote?
-        # Still need a treeish for the diff-tree command...
-        git fetch -q $tmp_remote 
-        git diff-tree -p refs/remotes/$tmp_remote/$refspec
-        git remote rm $tmp_remote > /dev/null 2>&1
-    else 
-        die "Cannot resolve directory '$dir'. Please point to an existing subtree directory to diff. Try 'git subtree add' to add a subtree."
-    fi
+cmd_diff()
+{
+	if [ -e "$dir" ]; then
+		if [ $# -eq 1 ]; then
+			repository=$(git config -f .gittrees subtree.$prefix.url)
+			refspec=$1
+		elif [ $# -eq 2 ]; then
+			repository=$1
+			refspec=$2
+		else
+			repository=$(git config -f .gittrees subtree.$prefix.url)
+			refspec=$(git config -f .gittrees subtree.$prefix.branch)
+		fi
+		# this is ugly, but I don't know of a better way to do it. My git-fu is weak.
+		# git diff-tree expects a treeish, but I have only a repository and branch name.
+		# I don't know how to turn that into a treeish without creating a remote.
+		# Please change this if you know a better way!
+		tmp_remote=__diff-tmp
+		git remote rm $tmp_remote > /dev/null 2>&1
+		git remote add -t $refspec $tmp_remote $repository > /dev/null
+		# we fetch as a separate step so we can pass -q (quiet), which isn't an option for "git remote"
+		# could this instead be "git fetch -q $repository $refspec" and leave aside creating the remote?
+		# Still need a treeish for the diff-tree command...
+		git fetch -q $tmp_remote
+		git diff-tree -p refs/remotes/$tmp_remote/$refspec
+		git remote rm $tmp_remote > /dev/null 2>&1
+	else
+		die "Cannot resolve directory '$dir'. Please point to an existing subtree directory to diff. Try 'git subtree add' to add a subtree."
+	fi
 }
 
 cmd_push()
 {
 	if [ $# -gt 2 ]; then
-	    die "You shold provide either <refspec> or <repository> <refspec>"
+		die "You shold provide either <refspec> or <repository> <refspec>"
 	fi
 	if [ -e "$dir" ]; then
-      if [ $# -eq 1 ]; then 
-	      repository=$(git config -f .gittrees subtree.$prefix.url)
-        refspec=$1
-      elif [ $# -eq 2 ]; then 
-        repository=$1
-        refspec=$2
-      else
-	      repository=$(git config -f .gittrees subtree.$prefix.url)
-        refspec=$(git config -f .gittrees subtree.$prefix.branch)
-      fi
-        push_opts=
-        if [ "$force" == "1" ]; then 
-            push_opts="$push_opts --force"
-        fi
-	    echo "git push using: " $repository $refspec
-	    rev=$(git subtree split --prefix=$prefix)
-	    if [ -n "$rev" ]; then
-	        git push $push_opts $repository $rev:refs/heads/$refspec
-	    else
-	        die "Couldn't push, 'git subtree split' failed."
-	    fi
+		if [ $# -eq 1 ]; then
+			repository=$(git config -f .gittrees subtree.$prefix.url)
+			refspec=$1
+		elif [ $# -eq 2 ]; then
+			repository=$1
+			refspec=$2
+		else
+			repository=$(git config -f .gittrees subtree.$prefix.url)
+			refspec=$(git config -f .gittrees subtree.$prefix.branch)
+		fi
+
+		push_opts=
+		if [ "$force" == "1" ]; then
+		  push_opts="$push_opts --force"
+		fi
+
+		echo "git push using: " $repository $refspec
+		rev=$(git subtree split --prefix=$prefix)
+		if [ -n "$rev" ]; then
+			git push $push_opts $repository $rev:refs/heads/$refspec
+		else
+			die "Couldn't push, 'git subtree split' failed."
+		fi
 	else
 	    die "'$dir' must already exist. Try 'git subtree add'."
 	fi
@@ -831,6 +835,7 @@ cmd_from-submodule()
 	git commit -m "Remove '$prefix/' submodule"
 
 	# subtree add from submodule repo.
+	# TODO: Could be determin HEAD to be a specific branch
 	cmd_add_repository $tmp_repo HEAD
 
 	# Update .gittrees with the original repo url
@@ -841,46 +846,46 @@ cmd_from-submodule()
 	rm -rf $tmp_repo
 }
 
-subtree_list() 
+subtree_list()
 {
-    git config -f .gittrees -l | grep subtree | grep path | grep -o '=.*' | grep -o '[^=].*' |
-    while read path; do 
-        repository=$(git config -f .gittrees subtree.$path.url)
-        refspec=$(git config -f .gittrees subtree.$path.branch)
-        echo "    $path        (merged from $repository branch $refspec) "
-    done
+	git config -f .gittrees -l | grep subtree | grep path | grep -o '=.*' | grep -o '[^=].*' |
+	while read path; do
+		repository=$(git config -f .gittrees subtree.$path.url)
+		refspec=$(git config -f .gittrees subtree.$path.branch)
+		echo "	$path		(merged from $repository branch $refspec) "
+	done
 }
 
 cmd_list()
 {
-  subtree_list 
+  subtree_list
 }
 
 cmd_prune()
 {
-    git config -f .gittrees -l | grep subtree | grep path | grep -o '=.*' | grep -o '[^=].*' |
-    while read path; do
-        if [ ! -e "$path" ]; then
-            echo "pruning $path"
-            git config -f .gittrees --remove-section subtree.$path
-        fi
-    done
+	git config -f .gittrees -l | grep subtree | grep path | grep -o '=.*' | grep -o '[^=].*' |
+	while read path; do
+		if [ ! -e "$path" ]; then
+			echo "pruning $path"
+			git config -f .gittrees --remove-section subtree.$path
+		fi
+	done
 }
 
 cmd_pull-all()
 {
-    git config -f .gittrees -l | grep subtree | grep path | grep -o '=.*' | grep -o '[^=].*' |
-        while read path; do
-            git subtree pull -P $path master || exit $?
-        done
+	git config -f .gittrees -l | grep subtree | grep path | grep -o '=.*' | grep -o '[^=].*' |
+	while read path; do
+		git subtree pull -P $path $(git config -f .gittrees subtree.$path.url) $(git config -f .gittrees subtree.$path.branch) || exit $?
+	done
 }
 
 cmd_push-all()
 {
-    git config -f .gittrees -l | grep subtree | grep path | grep -o '=.*' | grep -o '[^=].*' |
-        while read path; do
-            git subtree push -P $path master || exit $?
-        done
+	git config -f .gittrees -l | grep subtree | grep path | grep -o '=.*' | grep -o '[^=].*' |
+	while read path; do
+		git subtree push -P $path $(git config -f .gittrees subtree.$path.url) $(git config -f .gittrees subtree.$path.branch) || exit $?
+	done
 }
 
 "cmd_$command" "$@"
-- 
1.8.2.rc1
