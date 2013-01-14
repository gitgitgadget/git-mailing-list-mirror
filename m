From: Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH/RFC v2 1/8] contrib/subtree: Fix whitespaces
Date: Mon, 14 Jan 2013 11:52:14 +0800
Message-ID: <1358135541-10349-2-git-send-email-techlivezheng@gmail.com>
References: <1358041958-1998-1-git-send-email-techlivezheng@gmail.com>
 <1358135541-10349-1-git-send-email-techlivezheng@gmail.com>
Cc: apenwarr@gmail.com, greened@obbligato.org,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 04:58:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TubC9-0005rR-Uo
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 04:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460Ab3AND60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 22:58:26 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:42193 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755455Ab3AND6X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 22:58:23 -0500
Received: by mail-pa0-f48.google.com with SMTP id fa1so2004533pad.7
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 19:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=bdKd3Q/ZmuLIak+T6gyfwRz7i48rbDrstqrVoXoWg3A=;
        b=VotnbtuGupyGR7cR5Hsi09pKVC5aKXGS+9OqISz9PcLleifd1x7NFWVRlAQFM190kB
         sUBBxa0vhDoJLChM9X2eqy0YX2X8LowVOxwB84rH4APlPJfC5r0L/CmS2UuPIi4HVkW8
         Do2MO0HcDJYShG0AyX/fFpQANdK+MUBbesBlJokAKkcq25OkSyzWLlmMQF+iOmiRCaVX
         kM1/u+FMGZFO4aI9NzB6UKSdC52WFYlkWJCu8rjllEN9R1PBpHyf/IM6JLlEevAC1lTg
         hmX0KQh7FPybekifHOY7AEr809j7D04pDyy7Aqw7SrLjaeWOnwsGVcdLiwN1aXYjjfog
         Th5g==
X-Received: by 10.66.73.68 with SMTP id j4mr46503447pav.84.1358135902582;
        Sun, 13 Jan 2013 19:58:22 -0800 (PST)
Received: from home.techlive.me ([122.244.159.146])
        by mx.google.com with ESMTPS id kl3sm7400598pbc.15.2013.01.13.19.58.14
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 19:58:21 -0800 (PST)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <1358135541-10349-1-git-send-email-techlivezheng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213422>

Previous code does not fulfill Git's whitespace policy.

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
---
 contrib/subtree/git-subtree.sh     |  68 ++++----
 contrib/subtree/git-subtree.txt    |  42 ++---
 contrib/subtree/t/t7900-subtree.sh | 314 ++++++++++++++++++-------------------
 3 files changed, 212 insertions(+), 212 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 920c664..70f86ea 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -5,7 +5,7 @@
 # Copyright (C) 2009 Avery Pennarun <apenwarr@gmail.com>
 #
 if [ $# -eq 0 ]; then
-    set -- -h
+	set -- -h
 fi
 OPTS_SPEC="\
 git subtree add   --prefix=<prefix> <commit>
@@ -110,9 +110,9 @@ if [ -z "$prefix" ]; then
 fi
 
 case "$command" in
-	add) [ -e "$prefix" ] && 
+	add) [ -e "$prefix" ] &&
 		die "prefix '$prefix' already exists." ;;
-	*)   [ -e "$prefix" ] || 
+	*)   [ -e "$prefix" ] ||
 		die "'$prefix' does not exist; use 'git subtree add'" ;;
 esac
 
@@ -181,8 +181,8 @@ cache_set()
 	oldrev="$1"
 	newrev="$2"
 	if [ "$oldrev" != "latest_old" \
-	     -a "$oldrev" != "latest_new" \
-	     -a -e "$cachedir/$oldrev" ]; then
+		-a "$oldrev" != "latest_new" \
+		-a -e "$cachedir/$oldrev" ]; then
 		die "cache for $oldrev already exists!"
 	fi
 	echo "$newrev" >"$cachedir/$oldrev"
@@ -304,7 +304,7 @@ copy_commit()
 		read GIT_COMMITTER_NAME
 		read GIT_COMMITTER_EMAIL
 		read GIT_COMMITTER_DATE
-		export  GIT_AUTHOR_NAME \
+		export GIT_AUTHOR_NAME \
 			GIT_AUTHOR_EMAIL \
 			GIT_AUTHOR_DATE \
 			GIT_COMMITTER_NAME \
@@ -327,7 +327,7 @@ add_msg()
 	fi
 	cat <<-EOF
 		$commit_message
-		
+
 		git-subtree-dir: $dir
 		git-subtree-mainline: $latest_old
 		git-subtree-split: $latest_new
@@ -355,7 +355,7 @@ rejoin_msg()
 	fi
 	cat <<-EOF
 		$commit_message
-		
+
 		git-subtree-dir: $dir
 		git-subtree-mainline: $latest_old
 		git-subtree-split: $latest_new
@@ -368,7 +368,7 @@ squash_msg()
 	oldsub="$2"
 	newsub="$3"
 	newsub_short=$(git rev-parse --short "$newsub")
-	
+
 	if [ -n "$oldsub" ]; then
 		oldsub_short=$(git rev-parse --short "$oldsub")
 		echo "Squashed '$dir/' changes from $oldsub_short..$newsub_short"
@@ -378,7 +378,7 @@ squash_msg()
 	else
 		echo "Squashed '$dir/' content from commit $newsub_short"
 	fi
-	
+
 	echo
 	echo "git-subtree-dir: $dir"
 	echo "git-subtree-split: $newsub"
@@ -427,7 +427,7 @@ new_squash_commit()
 	newsub="$3"
 	tree=$(toptree_for_commit $newsub) || exit $?
 	if [ -n "$old" ]; then
-		squash_msg "$dir" "$oldsub" "$newsub" | 
+		squash_msg "$dir" "$oldsub" "$newsub" |
 			git commit-tree "$tree" -p "$old" || exit $?
 	else
 		squash_msg "$dir" "" "$newsub" |
@@ -455,7 +455,7 @@ copy_or_skip()
 		else
 			nonidentical="$parent"
 		fi
-		
+
 		# sometimes both old parents map to the same newparent;
 		# eliminate duplicates
 		is_new=1
@@ -470,7 +470,7 @@ copy_or_skip()
 			p="$p -p $parent"
 		fi
 	done
-	
+
 	if [ -n "$identical" ]; then
 		echo $identical
 	else
@@ -495,14 +495,14 @@ cmd_add()
 	fi
 
 	ensure_clean
-	
+
 	if [ $# -eq 1 ]; then
 		"cmd_add_commit" "$@"
 	elif [ $# -eq 2 ]; then
 		"cmd_add_repository" "$@"
 	else
-	    say "error: parameters were '$@'"
-	    die "Provide either a refspec or a repository and refspec."
+		say "error: parameters were '$@'"
+		die "Provide either a refspec or a repository and refspec."
 	fi
 }
 
@@ -522,19 +522,19 @@ cmd_add_commit()
 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
 	set -- $revs
 	rev="$1"
-	
+
 	debug "Adding $dir as '$rev'..."
 	git read-tree --prefix="$dir" $rev || exit $?
 	git checkout -- "$dir" || exit $?
 	tree=$(git write-tree) || exit $?
-	
+
 	headrev=$(git rev-parse HEAD) || exit $?
 	if [ -n "$headrev" -a "$headrev" != "$rev" ]; then
 		headp="-p $headrev"
 	else
 		headp=
 	fi
-	
+
 	if [ -n "$squash" ]; then
 		rev=$(new_squash_commit "" "" "$rev") || exit $?
 		commit=$(add_squashed_msg "$rev" "$dir" |
@@ -544,7 +544,7 @@ cmd_add_commit()
 			 git commit-tree $tree $headp -p "$rev") || exit $?
 	fi
 	git reset "$commit" || exit $?
-	
+
 	say "Added dir '$dir'"
 }
 
@@ -552,7 +552,7 @@ cmd_split()
 {
 	debug "Splitting $dir..."
 	cache_setup || exit $?
-	
+
 	if [ -n "$onto" ]; then
 		debug "Reading history for --onto=$onto..."
 		git rev-list $onto |
@@ -563,13 +563,13 @@ cmd_split()
 			cache_set $rev $rev
 		done
 	fi
-	
+
 	if [ -n "$ignore_joins" ]; then
 		unrevs=
 	else
 		unrevs="$(find_existing_splits "$dir" "$revs")"
 	fi
-	
+
 	# We can't restrict rev-list to only $dir here, because some of our
 	# parents have the $dir contents the root, and those won't match.
 	# (and rev-list --follow doesn't seem to solve this)
@@ -591,12 +591,12 @@ cmd_split()
 		debug "  parents: $parents"
 		newparents=$(cache_get $parents)
 		debug "  newparents: $newparents"
-		
+
 		tree=$(subtree_for_commit $rev "$dir")
 		debug "  tree is: $tree"
 
 		check_parents $parents
-		
+
 		# ugly.  is there no better way to tell if this is a subtree
 		# vs. a mainline commit?  Does it matter?
 		if [ -z $tree ]; then
@@ -617,7 +617,7 @@ cmd_split()
 	if [ -z "$latest_new" ]; then
 		die "No new revisions were found"
 	fi
-	
+
 	if [ -n "$rejoin" ]; then
 		debug "Merging split branch into HEAD..."
 		latest_old=$(cache_get latest_old)
@@ -645,13 +645,13 @@ cmd_merge()
 {
 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
 	ensure_clean
-	
+
 	set -- $revs
 	if [ $# -ne 1 ]; then
 		die "You must provide exactly one revision.  Got: '$revs'"
 	fi
 	rev="$1"
-	
+
 	if [ -n "$squash" ]; then
 		first_split="$(find_latest_squash "$dir")"
 		if [ -z "$first_split" ]; then
@@ -697,15 +697,15 @@ cmd_pull()
 cmd_push()
 {
 	if [ $# -ne 2 ]; then
-	    die "You must provide <repository> <refspec>"
+		die "You must provide <repository> <refspec>"
 	fi
 	if [ -e "$dir" ]; then
-	    repository=$1
-	    refspec=$2
-	    echo "git push using: " $repository $refspec
-	    git push $repository $(git subtree split --prefix=$prefix):refs/heads/$refspec
+		repository=$1
+		refspec=$2
+		echo "git push using: " $repository $refspec
+		git push $repository $(git subtree split --prefix=$prefix):refs/heads/$refspec
 	else
-	    die "'$dir' must already exist. Try 'git subtree add'."
+		die "'$dir' must already exist. Try 'git subtree add'."
 	fi
 }
 
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index c5bce41..72be8e4 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -86,15 +86,15 @@ merge::
 	go back in time from v2.5 to v2.4, for example.  If your
 	merge introduces a conflict, you can resolve it in the
 	usual ways.
-	
+
 pull::
 	Exactly like 'merge', but parallels 'git pull' in that
 	it fetches the given commit from the specified remote
 	repository.
-	
+
 push::
 	Does a 'split' (see below) using the <prefix> supplied
-	and then does a 'git push' to push the result to the 
+	and then does a 'git push' to push the result to the
 	repository and refspec. This can be used to push your
 	subtree to different branches of the remote repository.
 
@@ -106,19 +106,19 @@ split::
 	contents of <prefix> at the root of the project instead
 	of in a subdirectory.  Thus, the newly created history
 	is suitable for export as a separate git repository.
-	
+
 	After splitting successfully, a single commit id is
 	printed to stdout.  This corresponds to the HEAD of the
 	newly created tree, which you can manipulate however you
 	want.
-	
+
 	Repeated splits of exactly the same history are
 	guaranteed to be identical (ie. to produce the same
 	commit ids).  Because of this, if you add new commits
 	and then re-split, the new commits will be attached as
 	commits on top of the history you generated last time,
 	so 'git merge' and friends will work as expected.
-	
+
 	Note that if you use '--squash' when you merge, you
 	should usually not just '--rejoin' when you split.
 
@@ -155,26 +155,26 @@ OPTIONS FOR add, merge, push, pull
 	project, produce only a single commit that contains all
 	the differences you want to merge, and then merge that
 	new commit into your project.
-	
+
 	Using this option helps to reduce log clutter. People
 	rarely want to see every change that happened between
 	v1.0 and v1.1 of the library they're using, since none of the
 	interim versions were ever included in their application.
-	
+
 	Using '--squash' also helps avoid problems when the same
 	subproject is included multiple times in the same
 	project, or is removed and then re-added.  In such a
 	case, it doesn't make sense to combine the histories
 	anyway, since it's unclear which part of the history
 	belongs to which subtree.
-	
+
 	Furthermore, with '--squash', you can switch back and
 	forth between different versions of a subtree, rather
 	than strictly forward.  'git subtree merge --squash'
 	always adjusts the subtree to match the exactly
 	specified commit, even if getting to that commit would
 	require undoing some changes that were added earlier.
-	
+
 	Whether or not you use '--squash', changes made in your
 	local repository remain intact and can be later split
 	and send upstream to the subproject.
@@ -190,11 +190,11 @@ OPTIONS FOR split
 	commits with the same commit message, but possibly
 	different content, from the original commits, this can help
 	to differentiate them and avoid confusion.
-	
+
 	Whenever you split, you need to use the same
 	<annotation>, or else you don't have a guarantee that
 	the new re-created history will be identical to the old
-	one.  That will prevent merging from working correctly. 
+	one.  That will prevent merging from working correctly.
 	git subtree tries to make it work anyway, particularly
 	if you use --rejoin, but it may not always be effective.
 
@@ -203,8 +203,8 @@ OPTIONS FOR split
 	This option is only valid for the split command.
 
 	After generating the synthetic history, create a new
-	branch called <branch> that contains the new history. 
-	This is suitable for immediate pushing upstream. 
+	branch called <branch> that contains the new history.
+	This is suitable for immediate pushing upstream.
 	<branch> must not already exist.
 
 --ignore-joins::
@@ -227,7 +227,7 @@ OPTIONS FOR split
 	revision of the subproject's history that was imported
 	into your project, and git subtree will attempt to build
 	its history from there.
-	
+
 	If you used 'git subtree add', you should never need
 	this option.
 
@@ -238,18 +238,18 @@ OPTIONS FOR split
 	history back into your main project.  That way, future
 	splits can search only the part of history that has
 	been added since the most recent --rejoin.
-	
+
 	If your split commits end up merged into the upstream
 	subproject, and then you want to get the latest upstream
 	version, this will allow git's merge algorithm to more
 	intelligently avoid conflicts (since it knows these
 	synthetic commits are already part of the upstream
 	repository).
-	
+
 	Unfortunately, using this option results in 'git log'
 	showing an extra copy of every new commit that was
 	created (the original, and the synthetic one).
-	
+
 	If you do all your merges with '--squash', don't use
 	'--rejoin' when you split, because you don't want the
 	subproject's history to be part of your project anyway.
@@ -284,7 +284,7 @@ First, get your own copy of the git.git repository:
 	$ cd test-git
 
 gitweb (commit 1130ef3) was merged into git as of commit
-0a8f4f0, after which it was no longer maintained separately. 
+0a8f4f0, after which it was no longer maintained separately.
 But imagine it had been maintained separately, and we wanted to
 extract git's changes to gitweb since that time, to share with
 the upstream.  You could do this:
@@ -294,7 +294,7 @@ the upstream.  You could do this:
         	--branch gitweb-latest
         $ gitk gitweb-latest
         $ git push git@github.com:whatever/gitweb.git gitweb-latest:master
-        
+
 (We use '0a8f4f0^..' because that means "all the changes from
 0a8f4f0 to the current version, including 0a8f4f0 itself.")
 
@@ -328,7 +328,7 @@ And fast forward again:
 	$ git subtree merge --prefix=gitweb --squash gitweb-latest
 
 And notice that your change is still intact:
-	
+
 	$ ls -l gitweb/myfile
 
 And you can split it out and look at your changes versus
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index bc2eeb0..b98f7d0 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -23,7 +23,7 @@ check_equal()
 {
 	test_debug 'echo'
 	test_debug "echo \"check a:\" \"{$1}\""
-	test_debug "echo \"      b:\" \"{$2}\""
+	test_debug "echo \"		 b:\" \"{$2}\""
 	if [ "$1" = "$2" ]; then
 		return 0
 	else
@@ -62,7 +62,7 @@ last_commit_message()
 
 # 1
 test_expect_success 'init subproj' '
-        test_create_repo subproj
+		test_create_repo subproj
 '
 
 # To the subproject!
@@ -70,24 +70,24 @@ cd subproj
 
 # 2
 test_expect_success 'add sub1' '
-        create sub1 &&
-        git commit -m "sub1" &&
-        git branch sub1 &&
-        git branch -m master subproj
+		create sub1 &&
+		git commit -m "sub1" &&
+		git branch sub1 &&
+		git branch -m master subproj
 '
 
 # 3
 test_expect_success 'add sub2' '
-        create sub2 &&
-        git commit -m "sub2" &&
-        git branch sub2
+		create sub2 &&
+		git commit -m "sub2" &&
+		git branch sub2
 '
 
 # 4
 test_expect_success 'add sub3' '
-        create sub3 &&
-        git commit -m "sub3" &&
-        git branch sub3
+		create sub3 &&
+		git commit -m "sub3" &&
+		git branch sub3
 '
 
 # Back to mainline
@@ -95,173 +95,173 @@ cd ..
 
 # 5
 test_expect_success 'add main4' '
-        create main4 &&
-        git commit -m "main4" &&
-        git branch -m master mainline &&
-        git branch subdir
+		create main4 &&
+		git commit -m "main4" &&
+		git branch -m master mainline &&
+		git branch subdir
 '
 
 # 6
 test_expect_success 'fetch subproj history' '
-        git fetch ./subproj sub1 &&
-        git branch sub1 FETCH_HEAD
+		git fetch ./subproj sub1 &&
+		git branch sub1 FETCH_HEAD
 '
 
 # 7
 test_expect_success 'no subtree exists in main tree' '
-        test_must_fail git subtree merge --prefix=subdir sub1
+		test_must_fail git subtree merge --prefix=subdir sub1
 '
 
 # 8
 test_expect_success 'no pull from non-existant subtree' '
-        test_must_fail git subtree pull --prefix=subdir ./subproj sub1
+		test_must_fail git subtree pull --prefix=subdir ./subproj sub1
 '
 
 # 9
 test_expect_success 'check if --message works for add' '
-        git subtree add --prefix=subdir --message="Added subproject" sub1 &&
-        check_equal ''"$(last_commit_message)"'' "Added subproject" &&
-        undo
+		git subtree add --prefix=subdir --message="Added subproject" sub1 &&
+		check_equal ''"$(last_commit_message)"'' "Added subproject" &&
+		undo
 '
 
 # 10
 test_expect_success 'check if --message works as -m and --prefix as -P' '
-        git subtree add -P subdir -m "Added subproject using git subtree" sub1 &&
-        check_equal ''"$(last_commit_message)"'' "Added subproject using git subtree" &&
-        undo
+		git subtree add -P subdir -m "Added subproject using git subtree" sub1 &&
+		check_equal ''"$(last_commit_message)"'' "Added subproject using git subtree" &&
+		undo
 '
 
 # 11
 test_expect_success 'check if --message works with squash too' '
-        git subtree add -P subdir -m "Added subproject with squash" --squash sub1 &&
-        check_equal ''"$(last_commit_message)"'' "Added subproject with squash" &&
-        undo
+		git subtree add -P subdir -m "Added subproject with squash" --squash sub1 &&
+		check_equal ''"$(last_commit_message)"'' "Added subproject with squash" &&
+		undo
 '
 
 # 12
 test_expect_success 'add subproj to mainline' '
-        git subtree add --prefix=subdir/ FETCH_HEAD &&
-        check_equal ''"$(last_commit_message)"'' "Add '"'subdir/'"' from commit '"'"'''"$(git rev-parse sub1)"'''"'"'"
+		git subtree add --prefix=subdir/ FETCH_HEAD &&
+		check_equal ''"$(last_commit_message)"'' "Add '"'subdir/'"' from commit '"'"'''"$(git rev-parse sub1)"'''"'"'"
 '
 
 # 13
 # this shouldn't actually do anything, since FETCH_HEAD is already a parent
 test_expect_success 'merge fetched subproj' '
-        git merge -m "merge -s -ours" -s ours FETCH_HEAD
+		git merge -m "merge -s -ours" -s ours FETCH_HEAD
 '
 
 # 14
 test_expect_success 'add main-sub5' '
-        create subdir/main-sub5 &&
-        git commit -m "main-sub5"
+		create subdir/main-sub5 &&
+		git commit -m "main-sub5"
 '
 
 # 15
 test_expect_success 'add main6' '
-        create main6 &&
-        git commit -m "main6 boring"
+		create main6 &&
+		git commit -m "main6 boring"
 '
 
 # 16
 test_expect_success 'add main-sub7' '
-        create subdir/main-sub7 &&
-        git commit -m "main-sub7"
+		create subdir/main-sub7 &&
+		git commit -m "main-sub7"
 '
 
 # 17
 test_expect_success 'fetch new subproj history' '
-        git fetch ./subproj sub2 &&
-        git branch sub2 FETCH_HEAD
+		git fetch ./subproj sub2 &&
+		git branch sub2 FETCH_HEAD
 '
 
 # 18
 test_expect_success 'check if --message works for merge' '
-        git subtree merge --prefix=subdir -m "Merged changes from subproject" sub2 &&
-        check_equal ''"$(last_commit_message)"'' "Merged changes from subproject" &&
-        undo
+		git subtree merge --prefix=subdir -m "Merged changes from subproject" sub2 &&
+		check_equal ''"$(last_commit_message)"'' "Merged changes from subproject" &&
+		undo
 '
 
 # 19
 test_expect_success 'check if --message for merge works with squash too' '
-        git subtree merge --prefix subdir -m "Merged changes from subproject using squash" --squash sub2 &&
-        check_equal ''"$(last_commit_message)"'' "Merged changes from subproject using squash" &&
-        undo
+		git subtree merge --prefix subdir -m "Merged changes from subproject using squash" --squash sub2 &&
+		check_equal ''"$(last_commit_message)"'' "Merged changes from subproject using squash" &&
+		undo
 '
 
 # 20
 test_expect_success 'merge new subproj history into subdir' '
-        git subtree merge --prefix=subdir FETCH_HEAD &&
-        git branch pre-split &&
-        check_equal ''"$(last_commit_message)"'' "Merge commit '"'"'"$(git rev-parse sub2)"'"'"' into mainline"
+		git subtree merge --prefix=subdir FETCH_HEAD &&
+		git branch pre-split &&
+		check_equal ''"$(last_commit_message)"'' "Merge commit '"'"'"$(git rev-parse sub2)"'"'"' into mainline"
 '
 
 # 21
 test_expect_success 'Check that prefix argument is required for split' '
-        echo "You must provide the --prefix option." > expected &&
-        test_must_fail git subtree split > actual 2>&1 &&
-        test_debug "echo -n expected: " &&
-        test_debug "cat expected" &&
-        test_debug "echo -n actual: " &&
-        test_debug "cat actual" &&
-        test_cmp expected actual &&
-        rm -f expected actual
+		echo "You must provide the --prefix option." > expected &&
+		test_must_fail git subtree split > actual 2>&1 &&
+		test_debug "echo -n expected: " &&
+		test_debug "cat expected" &&
+		test_debug "echo -n actual: " &&
+		test_debug "cat actual" &&
+		test_cmp expected actual &&
+		rm -f expected actual
 '
 
 # 22
 test_expect_success 'Check that the <prefix> exists for a split' '
-        echo "'"'"'non-existent-directory'"'"'" does not exist\; use "'"'"'git subtree add'"'"'" > expected &&
-        test_must_fail git subtree split --prefix=non-existent-directory > actual 2>&1 &&
-        test_debug "echo -n expected: " &&
-        test_debug "cat expected" &&
-        test_debug "echo -n actual: " &&
-        test_debug "cat actual" &&
-        test_cmp expected actual
-#        rm -f expected actual
+		echo "'"'"'non-existent-directory'"'"'" does not exist\; use "'"'"'git subtree add'"'"'" > expected &&
+		test_must_fail git subtree split --prefix=non-existent-directory > actual 2>&1 &&
+		test_debug "echo -n expected: " &&
+		test_debug "cat expected" &&
+		test_debug "echo -n actual: " &&
+		test_debug "cat actual" &&
+		test_cmp expected actual
+#		 rm -f expected actual
 '
 
 # 23
 test_expect_success 'check if --message works for split+rejoin' '
-        spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
-        git branch spl1 "$spl1" &&
-        check_equal ''"$(last_commit_message)"'' "Split & rejoin" &&
-        undo
+		spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
+		git branch spl1 "$spl1" &&
+		check_equal ''"$(last_commit_message)"'' "Split & rejoin" &&
+		undo
 '
 
 # 24
 test_expect_success 'check split with --branch' '
-        spl1=$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin) &&
-        undo &&
-        git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --branch splitbr1 &&
-        check_equal ''"$(git rev-parse splitbr1)"'' "$spl1"
+		spl1=$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin) &&
+		undo &&
+		git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --branch splitbr1 &&
+		check_equal ''"$(git rev-parse splitbr1)"'' "$spl1"
 '
 
 # 25
 test_expect_success 'check split with --branch for an existing branch' '
-        spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
-        undo &&
-        git branch splitbr2 sub1 &&
-        git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --branch splitbr2 &&
-        check_equal ''"$(git rev-parse splitbr2)"'' "$spl1"
+		spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
+		undo &&
+		git branch splitbr2 sub1 &&
+		git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --branch splitbr2 &&
+		check_equal ''"$(git rev-parse splitbr2)"'' "$spl1"
 '
 
 # 26
 test_expect_success 'check split with --branch for an incompatible branch' '
-        test_must_fail git subtree split --prefix subdir --onto FETCH_HEAD --branch subdir
+		test_must_fail git subtree split --prefix subdir --onto FETCH_HEAD --branch subdir
 '
 
 
 # 27
 test_expect_success 'check split+rejoin' '
-        spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
-        undo &&
-        git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --rejoin &&
-        check_equal ''"$(last_commit_message)"'' "Split '"'"'subdir/'"'"' into commit '"'"'"$spl1"'"'"'"
+		spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
+		undo &&
+		git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --rejoin &&
+		check_equal ''"$(last_commit_message)"'' "Split '"'"'subdir/'"'"' into commit '"'"'"$spl1"'"'"'"
 '
 
 # 28
 test_expect_success 'add main-sub8' '
-        create subdir/main-sub8 &&
-        git commit -m "main-sub8"
+		create subdir/main-sub8 &&
+		git commit -m "main-sub8"
 '
 
 # To the subproject!
@@ -269,15 +269,15 @@ cd ./subproj
 
 # 29
 test_expect_success 'merge split into subproj' '
-        git fetch .. spl1 &&
-        git branch spl1 FETCH_HEAD &&
-        git merge FETCH_HEAD
+		git fetch .. spl1 &&
+		git branch spl1 FETCH_HEAD &&
+		git merge FETCH_HEAD
 '
 
 # 30
 test_expect_success 'add sub9' '
-        create sub9 &&
-        git commit -m "sub9"
+		create sub9 &&
+		git commit -m "sub9"
 '
 
 # Back to mainline
@@ -285,20 +285,20 @@ cd ..
 
 # 31
 test_expect_success 'split for sub8' '
-        split2=''"$(git subtree split --annotate='"'*'"' --prefix subdir/ --rejoin)"''
-        git branch split2 "$split2"
+		split2=''"$(git subtree split --annotate='"'*'"' --prefix subdir/ --rejoin)"''
+		git branch split2 "$split2"
 '
 
 # 32
 test_expect_success 'add main-sub10' '
-        create subdir/main-sub10 &&
-        git commit -m "main-sub10"
+		create subdir/main-sub10 &&
+		git commit -m "main-sub10"
 '
 
 # 33
 test_expect_success 'split for sub10' '
-        spl3=''"$(git subtree split --annotate='"'*'"' --prefix subdir --rejoin)"'' &&
-        git branch spl3 "$spl3"
+		spl3=''"$(git subtree split --annotate='"'*'"' --prefix subdir --rejoin)"'' &&
+		git branch spl3 "$spl3"
 '
 
 # To the subproject!
@@ -306,10 +306,10 @@ cd ./subproj
 
 # 34
 test_expect_success 'merge split into subproj' '
-        git fetch .. spl3 &&
-        git branch spl3 FETCH_HEAD &&
-        git merge FETCH_HEAD &&
-        git branch subproj-merge-spl3
+		git fetch .. spl3 &&
+		git branch spl3 FETCH_HEAD &&
+		git merge FETCH_HEAD &&
+		git branch subproj-merge-spl3
 '
 
 chkm="main4 main6"
@@ -320,14 +320,14 @@ chks_sub=$(echo $chks | multiline | sed 's,^,subdir/,' | fixnl)
 
 # 35
 test_expect_success 'make sure exactly the right set of files ends up in the subproj' '
-        subfiles=''"$(git ls-files | fixnl)"'' &&
-        check_equal "$subfiles" "$chkms $chks"
+		subfiles=''"$(git ls-files | fixnl)"'' &&
+		check_equal "$subfiles" "$chkms $chks"
 '
 
 # 36
 test_expect_success 'make sure the subproj history *only* contains commits that affect the subdir' '
-        allchanges=''"$(git log --name-only --pretty=format:'"''"' | sort | fixnl)"'' &&
-        check_equal "$allchanges" "$chkms $chks"
+		allchanges=''"$(git log --name-only --pretty=format:'"''"' | sort | fixnl)"'' &&
+		check_equal "$allchanges" "$chkms $chks"
 '
 
 # Back to mainline
@@ -335,35 +335,35 @@ cd ..
 
 # 37
 test_expect_success 'pull from subproj' '
-        git fetch ./subproj subproj-merge-spl3 &&
-        git branch subproj-merge-spl3 FETCH_HEAD &&
-        git subtree pull --prefix=subdir ./subproj subproj-merge-spl3
+		git fetch ./subproj subproj-merge-spl3 &&
+		git branch subproj-merge-spl3 FETCH_HEAD &&
+		git subtree pull --prefix=subdir ./subproj subproj-merge-spl3
 '
 
 # 38
 test_expect_success 'make sure exactly the right set of files ends up in the mainline' '
-        mainfiles=''"$(git ls-files | fixnl)"'' &&
-        check_equal "$mainfiles" "$chkm $chkms_sub $chks_sub"
+		mainfiles=''"$(git ls-files | fixnl)"'' &&
+		check_equal "$mainfiles" "$chkm $chkms_sub $chks_sub"
 '
 
 # 39
 test_expect_success 'make sure each filename changed exactly once in the entire history' '
-        # main-sub?? and /subdir/main-sub?? both change, because those are the
-        # changes that were split into their own history.  And subdir/sub?? never
-        # change, since they were *only* changed in the subtree branch.
-        allchanges=''"$(git log --name-only --pretty=format:'"''"' | sort | fixnl)"'' &&
-        check_equal "$allchanges" ''"$(echo $chkms $chkm $chks $chkms_sub | multiline | sort | fixnl)"''
+		# main-sub?? and /subdir/main-sub?? both change, because those are the
+		# changes that were split into their own history.  And subdir/sub?? never
+		# change, since they were *only* changed in the subtree branch.
+		allchanges=''"$(git log --name-only --pretty=format:'"''"' | sort | fixnl)"'' &&
+		check_equal "$allchanges" ''"$(echo $chkms $chkm $chks $chkms_sub | multiline | sort | fixnl)"''
 '
 
 # 40
 test_expect_success 'make sure the --rejoin commits never make it into subproj' '
-        check_equal ''"$(git log --pretty=format:'"'%s'"' HEAD^2 | grep -i split)"'' ""
+		check_equal ''"$(git log --pretty=format:'"'%s'"' HEAD^2 | grep -i split)"'' ""
 '
 
 # 41
 test_expect_success 'make sure no "git subtree" tagged commits make it into subproj' '
-        # They are meaningless to subproj since one side of the merge refers to the mainline
-        check_equal ''"$(git log --pretty=format:'"'%s%n%b'"' HEAD^2 | grep "git-subtree.*:")"'' ""
+		# They are meaningless to subproj since one side of the merge refers to the mainline
+		check_equal ''"$(git log --pretty=format:'"'%s%n%b'"' HEAD^2 | grep "git-subtree.*:")"'' ""
 '
 
 # prepare second pair of repositories
@@ -372,30 +372,30 @@ cd test2
 
 # 42
 test_expect_success 'init main' '
-        test_create_repo main
+		test_create_repo main
 '
 
 cd main
 
 # 43
 test_expect_success 'add main1' '
-        create main1 &&
-        git commit -m "main1"
+		create main1 &&
+		git commit -m "main1"
 '
 
 cd ..
 
 # 44
 test_expect_success 'init sub' '
-        test_create_repo sub
+		test_create_repo sub
 '
 
 cd sub
 
 # 45
 test_expect_success 'add sub2' '
-        create sub2 &&
-        git commit -m "sub2"
+		create sub2 &&
+		git commit -m "sub2"
 '
 
 cd ../main
@@ -404,37 +404,37 @@ cd ../main
 
 # 46
 test_expect_success 'add sub as subdir in main' '
-        git fetch ../sub master &&
-        git branch sub2 FETCH_HEAD &&
-        git subtree add --prefix subdir sub2
+		git fetch ../sub master &&
+		git branch sub2 FETCH_HEAD &&
+		git subtree add --prefix subdir sub2
 '
 
 cd ../sub
 
 # 47
 test_expect_success 'add sub3' '
-        create sub3 &&
-        git commit -m "sub3"
+		create sub3 &&
+		git commit -m "sub3"
 '
 
 cd ../main
 
 # 48
 test_expect_success 'merge from sub' '
-        git fetch ../sub master &&
-        git branch sub3 FETCH_HEAD &&
-        git subtree merge --prefix subdir sub3
+		git fetch ../sub master &&
+		git branch sub3 FETCH_HEAD &&
+		git subtree merge --prefix subdir sub3
 '
 
 # 49
 test_expect_success 'add main-sub4' '
-        create subdir/main-sub4 &&
-        git commit -m "main-sub4"
+		create subdir/main-sub4 &&
+		git commit -m "main-sub4"
 '
 
 # 50
 test_expect_success 'split for main-sub4 without --onto' '
-        git subtree split --prefix subdir --branch mainsub4
+		git subtree split --prefix subdir --branch mainsub4
 '
 
 # at this point, the new commit parent should be sub3 if it is not,
@@ -444,23 +444,23 @@ test_expect_success 'split for main-sub4 without --onto' '
 
 # 51
 test_expect_success 'check that the commit parent is sub3' '
-        check_equal ''"$(git log --pretty=format:%P -1 mainsub4)"'' ''"$(git rev-parse sub3)"''
+		check_equal ''"$(git log --pretty=format:%P -1 mainsub4)"'' ''"$(git rev-parse sub3)"''
 '
 
 # 52
 test_expect_success 'add main-sub5' '
-        mkdir subdir2 &&
-        create subdir2/main-sub5 &&
-        git commit -m "main-sub5"
+		mkdir subdir2 &&
+		create subdir2/main-sub5 &&
+		git commit -m "main-sub5"
 '
 
 # 53
 test_expect_success 'split for main-sub5 without --onto' '
-        # also test that we still can split out an entirely new subtree
-        # if the parent of the first commit in the tree is not empty,
-        # then the new subtree has accidently been attached to something
-        git subtree split --prefix subdir2 --branch mainsub5 &&
-        check_equal ''"$(git log --pretty=format:%P -1 mainsub5)"'' ""
+		# also test that we still can split out an entirely new subtree
+		# if the parent of the first commit in the tree is not empty,
+		# then the new subtree has accidently been attached to something
+		git subtree split --prefix subdir2 --branch mainsub5 &&
+		check_equal ''"$(git log --pretty=format:%P -1 mainsub5)"'' ""
 '
 
 # make sure no patch changes more than one file.  The original set of commits
@@ -489,20 +489,20 @@ joincommits()
 
 # 54
 test_expect_success 'verify one file change per commit' '
-        x= &&
-        list=''"$(git log --pretty=format:'"'commit: %H'"' | joincommits)"'' &&
-#        test_debug "echo HERE" &&
-#        test_debug "echo ''"$list"''" &&
-        (git log --pretty=format:'"'commit: %H'"' | joincommits |
-        (       while read commit a b; do
-		        test_debug "echo Verifying commit "''"$commit"''
-		        test_debug "echo a: "''"$a"''
-		        test_debug "echo b: "''"$b"''
-		        check_equal "$b" ""
-		        x=1
-	        done
-	        check_equal "$x" 1
-        ))
+		x= &&
+		list=''"$(git log --pretty=format:'"'commit: %H'"' | joincommits)"'' &&
+#		 test_debug "echo HERE" &&
+#		 test_debug "echo ''"$list"''" &&
+		(git log --pretty=format:'"'commit: %H'"' | joincommits |
+		(		while read commit a b; do
+				test_debug "echo Verifying commit "''"$commit"''
+				test_debug "echo a: "''"$a"''
+				test_debug "echo b: "''"$b"''
+				check_equal "$b" ""
+				x=1
+			done
+			check_equal "$x" 1
+		))
 '
 
 test_done
-- 
1.8.1
