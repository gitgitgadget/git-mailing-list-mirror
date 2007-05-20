From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH 3/6] Remove whitespace breakage from *.sh files
Date: Sun, 20 May 2007 12:27:59 +0200
Message-ID: <465022AF.1090905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 12:28:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpie2-0005xf-Hh
	for gcvg-git@gmane.org; Sun, 20 May 2007 12:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758154AbXETK2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 06:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758928AbXETK2H
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 06:28:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:40234 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758154AbXETK2E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 06:28:04 -0400
Received: by ug-out-1314.google.com with SMTP id 44so893253uga
        for <git@vger.kernel.org>; Sun, 20 May 2007 03:28:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=utbapiZD7Sad41TDtt+aZezMGUfzbhfU29RUngo0QdG7pC5oc7V/mT1ZATsMXaZW+DJeSm9xjluL7sBb1BB8HidvA9NAPPUo0I3uGnhU0baFkXNSU67NALGH73aQX2pWiqm9IBfKJg4x0dD7iYaLatNi7RUbFNZHBUjdBUyov3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=cRycwSLN+nkGEeSU1ckbNMAiLlIg5Yq1AjTJ9hvh6e+G1oD7KP90FVTtNY//vuAe8Y2FmjboocV7O6+zkcQFIMVcRW8kQb8+xkN3fTh0dzMQVbqXYihzd8V6a+hIBr5u2Bdl0ZXUtiqzmKo3ZVL/2w4iBXX9ryEjJkiu4gYmfRI=
Received: by 10.67.93.2 with SMTP id v2mr2512899ugl.1179656883224;
        Sun, 20 May 2007 03:28:03 -0700 (PDT)
Received: from ?10.0.0.13? ( [151.70.107.76])
        by mx.google.com with ESMTP id j3sm3762159ugd.2007.05.20.03.28.01;
        Sun, 20 May 2007 03:28:02 -0700 (PDT)
User-Agent: Thunderbird 2.0b2 (X11/20070313)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47816>

Using 'git apply --whitespace=strip'

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
  contrib/remotes2config.sh |    2 --
  git-applymbox.sh          |    4 ++--
  git-checkout.sh           |    4 ++--
  git-clone.sh              |    5 ++---
  git-commit.sh             |    2 +-
  git-merge-one-file.sh     |    2 +-
  git-tag.sh                |    5 ++---
  git-verify-tag.sh         |    1 -
  8 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/contrib/remotes2config.sh b/contrib/remotes2config.sh
index dc09eae..0c8b954 100644
--- a/contrib/remotes2config.sh
+++ b/contrib/remotes2config.sh
@@ -31,5 +31,3 @@ if [ -d "$GIT_DIR"/remotes ]; then
  		esac
  	done
  fi
-
-
diff --git a/git-applymbox.sh b/git-applymbox.sh
index c18e80f..c51b2ff 100755
--- a/git-applymbox.sh
+++ b/git-applymbox.sh
@@ -69,7 +69,7 @@ set x .dotest/0*
  shift
  while case "$#" in 0) break;; esac
  do
-    i="$1"
+    i="$1"
      case "$resume,$continue" in
      f,$i)	resume=t;;
      f,*)	shift
@@ -94,7 +94,7 @@ do
  		;;
  	2)
  		# 2 is a special exit code from applypatch to indicate that
-	    	# the patch wasn't applied, but continue anyway
+		# the patch wasn't applied, but continue anyway
  		;;
  	*)
  		ret=$?
diff --git a/git-checkout.sh b/git-checkout.sh
index ed7c2c5..1ea4226 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -210,7 +210,7 @@ else
  	esac

  	# Match the index to the working tree, and do a three-way.
-    	git diff-files --name-only | git update-index --remove --stdin &&
+	git diff-files --name-only | git update-index --remove --stdin &&
  	work=`git write-tree` &&
  	git read-tree $v --reset -u $new || exit

@@ -245,7 +245,7 @@ else
      (exit $saved_err)
  fi

-#
+#
  # Switch the HEAD pointer to the new branch if we
  # checked out a branch head, and remove any potential
  # old MERGE_HEAD's (subsequent commits will clearly not
diff --git a/git-clone.sh b/git-clone.sh
index fdd354f..5bfd8d1 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -2,7 +2,7 @@
  #
  # Copyright (c) 2005, Linus Torvalds
  # Copyright (c) 2005, Junio C Hamano
-#
+#
  # Clone a repository into a different directory that does not yet exist.

  # See git-sh-setup why.
@@ -98,7 +98,7 @@ while
  	*,--na|*,--nak|*,--nake|*,--naked|\
  	*,-b|*,--b|*,--ba|*,--bar|*,--bare) bare=yes ;;
  	*,-l|*,--l|*,--lo|*,--loc|*,--loca|*,--local) use_local=yes ;;
-        *,-s|*,--s|*,--sh|*,--sha|*,--shar|*,--share|*,--shared)
+        *,-s|*,--s|*,--sh|*,--sha|*,--shar|*,--share|*,--shared)
            local_shared=yes; use_local=yes ;;
  	1,--template) usage ;;
  	*,--template)
@@ -410,4 +410,3 @@ fi
  rm -f "$GIT_DIR/CLONE_HEAD" "$GIT_DIR/REMOTE_HEAD"

  trap - 0
-
diff --git a/git-commit.sh b/git-commit.sh
index f28fc24..5b560f9 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -557,7 +557,7 @@ then
  	} >>"$GIT_DIR"/COMMIT_EDITMSG
  else
  	# we need to check if there is anything to commit
-	run_status >/dev/null
+	run_status >/dev/null
  fi
  if [ "$?" != "0" -a ! -f "$GIT_DIR/MERGE_HEAD" -a -z "$amend" ]
  then
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 7d62d79..254d210 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -88,7 +88,7 @@ case "${1:-.}${2:-.}${3:-.}" in
  		# remove lines that are unique to ours.
  		orig=`git-unpack-file $2`
  		sz0=`wc -c <"$orig"`
-		diff -u -La/$orig -Lb/$orig $orig $src2 | git-apply --no-add
+		diff -u -La/$orig -Lb/$orig $orig $src2 | git-apply --no-add
  		sz1=`wc -c <"$orig"`

  		# If we do not have enough common material, it is not
diff --git a/git-tag.sh b/git-tag.sh
index 4a0a7b6..3f080bf 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -36,7 +36,7 @@ do
  	exit $?
  	;;
      -m)
-    	annotate=1
+	annotate=1
  	shift
  	message="$1"
  	if test "$#" = "0"; then
@@ -62,7 +62,7 @@ do
  	username="$1"
  	;;
      -d)
-    	shift
+	shift
  	had_error=0
  	for tag
  	do
@@ -150,4 +150,3 @@ if [ "$annotate" ]; then
  fi

  git update-ref "refs/tags/$name" "$object" "$prev"
-
diff --git a/git-verify-tag.sh b/git-verify-tag.sh
index 8db7dd0..f2d5597 100755
--- a/git-verify-tag.sh
+++ b/git-verify-tag.sh
@@ -42,4 +42,3 @@ cat "$GIT_DIR/.tmp-vtag" |
  sed '/-----BEGIN PGP/Q' |
  gpg --verify "$GIT_DIR/.tmp-vtag" - || exit 1
  rm -f "$GIT_DIR/.tmp-vtag"
-
-- 
1.5.2.rc3.90.gf33e-dirty
