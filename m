Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 923B5203E2
	for <e@80x24.org>; Tue, 26 Jul 2016 04:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbcGZEO2 (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 00:14:28 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33661 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739AbcGZEO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 00:14:26 -0400
Received: by mail-pa0-f66.google.com with SMTP id q2so12535111pap.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 21:14:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RLZKue87C1JEKwmFNF2022cKzca6R01fooDeAUlo6Vk=;
        b=aNzvL+tyh+dAGB+UcM5A4GeX8iBV5oiYQLrDdlV0nobstlZlto8bqDQ74janm1gJ/f
         dLlIC8BqS4TbDjCUrGEAVBl4Rh8ceW87Y0f6f1txizy4Gp5677S37POJQ6PJ7u/Ssazf
         c2xRlFf+MWSqIcB/nzUODeADNs/ZzNhyz8pyVC3lY/5Q6SZmWfvn305npWlRt6xx0ZXc
         TgTTtL0ndfDgLWX0b22JJciyqYL0keAGw51Nu4szlzZSvb1R2f5jrQUqZzAso3W6WJCX
         X6KemVikP0BFoM6vvpi+ZcxOJHQ3XO+bt08R6w/cmcxRpc1xNYio/J7qaI8vJbCRlAcU
         TaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RLZKue87C1JEKwmFNF2022cKzca6R01fooDeAUlo6Vk=;
        b=gv81Nm/+0OFyX17V6YB1bR2WyDr2/12eZrflN3FZXQvPsio9Dh3J4yRhpGnBiVv/Ho
         yKvhIVyJEa2e5tdHQN49qqtX8iN2/FKcXLYXFnPZ0DzYtAYgm6YZNUtLqkMt4Jd+BnV0
         zWR5iIX3ut2k27g1MmITnkrpi6pdbLxL76VD2YpJw3xMhhN25a0OIsKOWFajDQuBMa6z
         4AfhTGhZ/od47k5Y68ZETnI6dCAiWLs98Y0yq+aKxC6+GRTW/eC97yM7aqiEThdd+Exl
         kVDxo35gltQPihuHGXfe9DIvh3xPezKUpExkt5QxFSf0/CRBOgqTduTn3vjfYd+F9195
         FY0Q==
X-Gm-Message-State: AEkoouukW4+1b4Y6Iq0J+ab4iSzVlud0hBkMCq6+UrFpr8KKF5ucjnBgZO/owcipafMumQ==
X-Received: by 10.66.111.164 with SMTP id ij4mr35510422pab.18.1469506464058;
        Mon, 25 Jul 2016 21:14:24 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id a21sm8759877pfe.81.2016.07.25.21.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Jul 2016 21:14:23 -0700 (PDT)
From:	David Aguilar <davvid@gmail.com>
To:	Git Mailing List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brett Cundal <brett.cundal@iugome.com>,
	"David A . Greene" <greened@obbligato.org>,
	Charles Bailey <cbailey32@bloomberg.net>,
	Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH 3/3] subtree: adjust style to match CodingGuidelines
Date:	Mon, 25 Jul 2016 21:14:16 -0700
Message-Id: <20160726041416.9438-3-davvid@gmail.com>
X-Mailer: git-send-email 2.9.2.466.g8c6d1f9.dirty
In-Reply-To: <20160726041416.9438-1-davvid@gmail.com>
References: <20160726041416.9438-1-davvid@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Prefer "test" over "[ ... ]", use double-quotes around variables, break
long lines, and properly indent "case" statements.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/subtree/git-subtree.sh | 544 ++++++++++++++++++++++++++---------------
 1 file changed, 341 insertions(+), 203 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index b567eae..084c884 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -4,8 +4,9 @@
 #
 # Copyright (C) 2009 Avery Pennarun <apenwarr@gmail.com>
 #
-if [ $# -eq 0 ]; then
-    set -- -h
+if test $# -eq 0
+then
+	set -- -h
 fi
 OPTS_SPEC="\
 git subtree add   --prefix=<prefix> <commit>
@@ -50,87 +51,145 @@ prefix=
 
 debug()
 {
-	if [ -n "$debug" ]; then
-		printf "%s\n" "$*" >&2
+	if test -n "$debug"
+	then
+		printf "%s\n" "$@" >&2
 	fi
 }
 
 say()
 {
-	if [ -z "$quiet" ]; then
-		printf "%s\n" "$*" >&2
+	if test -z "$quiet"
+	then
+		printf "%s\n" "$@" >&2
 	fi
 }
 
 progress()
 {
-	if [ -z "$quiet" ]; then
-		printf "%s\r" "$*" >&2
+	if test -z "$quiet"
+	then
+		printf "%s\r" "$@" >&2
 	fi
 }
 
 assert()
 {
-	if "$@"; then
-		:
-	else
+	if ! "$@"
+	then
 		die "assertion failed: " "$@"
 	fi
 }
 
 
-#echo "Options: $*"
-
-while [ $# -gt 0 ]; do
+while test $# -gt 0
+do
 	opt="$1"
 	shift
+
 	case "$opt" in
-		-q) quiet=1 ;;
-		-d) debug=1 ;;
-		--annotate) annotate="$1"; shift ;;
-		--no-annotate) annotate= ;;
-		-b) branch="$1"; shift ;;
-		-P) prefix="${1%/}"; shift ;;
-		-m) message="$1"; shift ;;
-		--no-prefix) prefix= ;;
-		--onto) onto="$1"; shift ;;
-		--no-onto) onto= ;;
-		--rejoin) rejoin=1 ;;
-		--no-rejoin) rejoin= ;;
-		--ignore-joins) ignore_joins=1 ;;
-		--no-ignore-joins) ignore_joins= ;;
-		--squash) squash=1 ;;
-		--no-squash) squash= ;;
-		--) break ;;
-		*) die "Unexpected option: $opt" ;;
+	-q)
+		quiet=1
+		;;
+	-d)
+		debug=1
+		;;
+	--annotate)
+		annotate="$1"
+		shift
+		;;
+	--no-annotate)
+		annotate=
+		;;
+	-b)
+		branch="$1"
+		shift
+		;;
+	-P)
+		prefix="${1%/}"
+		shift
+		;;
+	-m)
+		message="$1"
+		shift
+		;;
+	--no-prefix)
+		prefix=
+		;;
+	--onto)
+		onto="$1"
+		shift
+		;;
+	--no-onto)
+		onto=
+		;;
+	--rejoin)
+		rejoin=1
+		;;
+	--no-rejoin)
+		rejoin=
+		;;
+	--ignore-joins)
+		ignore_joins=1
+		;;
+	--no-ignore-joins)
+		ignore_joins=
+		;;
+	--squash)
+		squash=1
+		;;
+	--no-squash)
+		squash=
+		;;
+	--)
+		break
+		;;
+	*)
+		die "Unexpected option: $opt"
+		;;
 	esac
 done
 
 command="$1"
 shift
+
 case "$command" in
-	add|merge|pull) default= ;;
-	split|push) default="--default HEAD" ;;
-	*) die "Unknown command '$command'" ;;
+add|merge|pull)
+	default=
+	;;
+split|push)
+	default="--default HEAD"
+	;;
+*)
+	die "Unknown command '$command'"
+	;;
 esac
 
-if [ -z "$prefix" ]; then
+if test -z "$prefix"
+then
 	die "You must provide the --prefix option."
 fi
 
 case "$command" in
-	add) [ -e "$prefix" ] && 
-		die "prefix '$prefix' already exists." ;;
-	*)   [ -e "$prefix" ] || 
-		die "'$prefix' does not exist; use 'git subtree add'" ;;
+add)
+	test -e "$prefix" && die "prefix '$prefix' already exists."
+	;;
+*)
+	test -e "$prefix" ||
+	die "'$prefix' does not exist; use 'git subtree add'"
+	;;
 esac
 
 dir="$(dirname "$prefix/.")"
 
-if [ "$command" != "pull" -a "$command" != "add" -a "$command" != "push" ]; then
+if test "$command" != "pull" &&
+		test "$command" != "add" &&
+		test "$command" != "push"
+then
 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
 	dirs="$(git rev-parse --no-revs --no-flags "$@")" || exit $?
-	if [ -n "$dirs" ]; then
+	if test -n "$dirs"
+	then
 		die "Error: Use --prefix instead of bare filenames."
 	fi
 fi
@@ -139,22 +198,27 @@ debug "command: {$command}"
 debug "quiet: {$quiet}"
 debug "revs: {$revs}"
 debug "dir: {$dir}"
-debug "opts: {$*}"
+debug "opts: {$@}"
 debug
 
 cache_setup()
 {
 	cachedir="$GIT_DIR/subtree-cache/$$"
-	rm -rf "$cachedir" || die "Can't delete old cachedir: $cachedir"
-	mkdir -p "$cachedir" || die "Can't create new cachedir: $cachedir"
-	mkdir -p "$cachedir/notree" || die "Can't create new cachedir: $cachedir/notree"
+	rm -rf "$cachedir" ||
+		die "Can't delete old cachedir: $cachedir"
+	mkdir -p "$cachedir" ||
+		die "Can't create new cachedir: $cachedir"
+	mkdir -p "$cachedir/notree" ||
+		die "Can't create new cachedir: $cachedir/notree"
 	debug "Using cachedir: $cachedir" >&2
 }
 
 cache_get()
 {
-	for oldrev in $*; do
-		if [ -r "$cachedir/$oldrev" ]; then
+	for oldrev in "$@"
+	do
+		if test -r "$cachedir/$oldrev"
+		then
 			read newrev <"$cachedir/$oldrev"
 			echo $newrev
 		fi
@@ -163,8 +227,10 @@ cache_get()
 
 cache_miss()
 {
-	for oldrev in $*; do
-		if [ ! -r "$cachedir/$oldrev" ]; then
+	for oldrev in "$@"
+	do
+		if ! test -r "$cachedir/$oldrev"
+		then
 			echo $oldrev
 		fi
 	done
@@ -172,9 +238,11 @@ cache_miss()
 
 check_parents()
 {
-	missed=$(cache_miss $*)
-	for miss in $missed; do
-		if [ ! -r "$cachedir/notree/$miss" ]; then
+	missed=$(cache_miss "$@")
+	for miss in $missed
+	do
+		if ! test -r "$cachedir/notree/$miss"
+		then
 			debug "  incorrect order: $miss"
 		fi
 	done
@@ -189,9 +257,10 @@ cache_set()
 {
 	oldrev="$1"
 	newrev="$2"
-	if [ "$oldrev" != "latest_old" \
-	     -a "$oldrev" != "latest_new" \
-	     -a -e "$cachedir/$oldrev" ]; then
+	if test "$oldrev" != "latest_old" &&
+		test "$oldrev" != "latest_new" &&
+		test -e "$cachedir/$oldrev"
+	then
 		die "cache for $oldrev already exists!"
 	fi
 	echo "$newrev" >"$cachedir/$oldrev"
@@ -199,7 +268,8 @@ cache_set()
 
 rev_exists()
 {
-	if git rev-parse "$1" >/dev/null 2>&1; then
+	if git rev-parse "$1" >/dev/null 2>&1
+	then
 		return 0
 	else
 		return 1
@@ -213,7 +283,8 @@ rev_is_descendant_of_branch()
 	branch_hash=$(git rev-parse $branch)
 	match=$(git rev-list -1 $branch_hash ^$newrev)
 
-	if [ -z "$match" ]; then
+	if test -z "$match"
+	then
 		return 0
 	else
 		return 1
@@ -225,7 +296,8 @@ rev_is_descendant_of_branch()
 # be there anyway, so do nothing in that case.
 try_remove_previous()
 {
-	if rev_exists "$1^"; then
+	if rev_exists "$1^"
+	then
 		echo "^$1^"
 	fi
 }
@@ -239,31 +311,38 @@ find_latest_squash()
 	sub=
 	git log --grep="^git-subtree-dir: $dir/*\$" \
 		--pretty=format:'START %H%n%s%n%n%b%nEND%n' HEAD |
-	while read a b junk; do
+	while read a b junk
+	do
 		debug "$a $b $junk"
 		debug "{{$sq/$main/$sub}}"
 		case "$a" in
-			START) sq="$b" ;;
-			git-subtree-mainline:) main="$b" ;;
-			git-subtree-split:)
-				sub="$(git rev-parse "$b^0")" ||
-				    die "could not rev-parse split hash $b from commit $sq"
-				;;
-			END)
-				if [ -n "$sub" ]; then
-					if [ -n "$main" ]; then
-						# a rejoin commit?
-						# Pretend its sub was a squash.
-						sq="$sub"
-					fi
-					debug "Squash found: $sq $sub"
-					echo "$sq" "$sub"
-					break
+		START)
+			sq="$b"
+			;;
+		git-subtree-mainline:)
+			main="$b"
+			;;
+		git-subtree-split:)
+			sub="$(git rev-parse "$b^0")" ||
+			die "could not rev-parse split hash $b from commit $sq"
+			;;
+		END)
+			if test -n "$sub"
+			then
+				if test -n "$main"
+				then
+					# a rejoin commit?
+					# Pretend its sub was a squash.
+					sq="$sub"
 				fi
-				sq=
-				main=
-				sub=
-				;;
+				debug "Squash found: $sq $sub"
+				echo "$sq" "$sub"
+				break
+			fi
+			sq=
+			main=
+			sub=
+			;;
 		esac
 	done
 }
@@ -277,31 +356,38 @@ find_existing_splits()
 	sub=
 	git log --grep="^git-subtree-dir: $dir/*\$" \
 		--pretty=format:'START %H%n%s%n%n%b%nEND%n' $revs |
-	while read a b junk; do
+	while read a b junk
+	do
 		case "$a" in
-			START) sq="$b" ;;
-			git-subtree-mainline:) main="$b" ;;
-			git-subtree-split:)
-				sub="$(git rev-parse "$b^0")" ||
-				    die "could not rev-parse split hash $b from commit $sq"
-				;;
-			END)
-				debug "  Main is: '$main'"
-				if [ -z "$main" -a -n "$sub" ]; then
-					# squash commits refer to a subtree
-					debug "  Squash: $sq from $sub"
-					cache_set "$sq" "$sub"
-				fi
-				if [ -n "$main" -a -n "$sub" ]; then
-					debug "  Prior: $main -> $sub"
-					cache_set $main $sub
-					cache_set $sub $sub
-					try_remove_previous "$main"
-					try_remove_previous "$sub"
-				fi
-				main=
-				sub=
-				;;
+		START)
+			sq="$b"
+			;;
+		git-subtree-mainline:)
+			main="$b"
+			;;
+		git-subtree-split:)
+			sub="$(git rev-parse "$b^0")" ||
+			die "could not rev-parse split hash $b from commit $sq"
+			;;
+		END)
+			debug "  Main is: '$main'"
+			if test -z "$main" -a -n "$sub"
+			then
+				# squash commits refer to a subtree
+				debug "  Squash: $sq from $sub"
+				cache_set "$sq" "$sub"
+			fi
+			if test -n "$main" -a -n "$sub"
+			then
+				debug "  Prior: $main -> $sub"
+				cache_set $main $sub
+				cache_set $sub $sub
+				try_remove_previous "$main"
+				try_remove_previous "$sub"
+			fi
+			main=
+			sub=
+			;;
 		esac
 	done
 }
@@ -325,7 +411,10 @@ copy_commit()
 			GIT_COMMITTER_NAME \
 			GIT_COMMITTER_EMAIL \
 			GIT_COMMITTER_DATE
-		(printf "%s" "$annotate"; cat ) |
+		(
+			printf "%s" "$annotate"
+			cat
+		) |
 		git commit-tree "$2" $3  # reads the rest of stdin
 	) || die "Can't copy commit $1"
 }
@@ -335,14 +424,15 @@ add_msg()
 	dir="$1"
 	latest_old="$2"
 	latest_new="$3"
-	if [ -n "$message" ]; then
+	if test -n "$message"
+	then
 		commit_message="$message"
 	else
 		commit_message="Add '$dir/' from commit '$latest_new'"
 	fi
 	cat <<-EOF
 		$commit_message
-		
+
 		git-subtree-dir: $dir
 		git-subtree-mainline: $latest_old
 		git-subtree-split: $latest_new
@@ -351,7 +441,8 @@ add_msg()
 
 add_squashed_msg()
 {
-	if [ -n "$message" ]; then
+	if test -n "$message"
+	then
 		echo "$message"
 	else
 		echo "Merge commit '$1' as '$2'"
@@ -363,14 +454,15 @@ rejoin_msg()
 	dir="$1"
 	latest_old="$2"
 	latest_new="$3"
-	if [ -n "$message" ]; then
+	if test -n "$message"
+	then
 		commit_message="$message"
 	else
 		commit_message="Split '$dir/' into commit '$latest_new'"
 	fi
 	cat <<-EOF
 		$commit_message
-		
+
 		git-subtree-dir: $dir
 		git-subtree-mainline: $latest_old
 		git-subtree-split: $latest_new
@@ -383,8 +475,9 @@ squash_msg()
 	oldsub="$2"
 	newsub="$3"
 	newsub_short=$(git rev-parse --short "$newsub")
-	
-	if [ -n "$oldsub" ]; then
+
+	if test -n "$oldsub"
+	then
 		oldsub_short=$(git rev-parse --short "$oldsub")
 		echo "Squashed '$dir/' changes from $oldsub_short..$newsub_short"
 		echo
@@ -393,7 +486,7 @@ squash_msg()
 	else
 		echo "Squashed '$dir/' content from commit $newsub_short"
 	fi
-	
+
 	echo
 	echo "git-subtree-dir: $dir"
 	echo "git-subtree-split: $newsub"
@@ -410,10 +503,11 @@ subtree_for_commit()
 	commit="$1"
 	dir="$2"
 	git ls-tree "$commit" -- "$dir" |
-	while read mode type tree name; do
-		assert [ "$name" = "$dir" ]
-		assert [ "$type" = "tree" -o "$type" = "commit" ]
-		[ "$type" = "commit" ] && continue  # ignore submodules
+	while read mode type tree name
+	do
+		assert test "$name" = "$dir"
+		assert test "$type" = "tree" -o "$type" = "commit"
+		test "$type" = "commit" && continue  # ignore submodules
 		echo $tree
 		break
 	done
@@ -423,11 +517,13 @@ tree_changed()
 {
 	tree=$1
 	shift
-	if [ $# -ne 1 ]; then
+	if test $# -ne 1
+	then
 		return 0   # weird parents, consider it changed
 	else
 		ptree=$(toptree_for_commit $1)
-		if [ "$ptree" != "$tree" ]; then
+		if test "$ptree" != "$tree"
+		then
 			return 0   # changed
 		else
 			return 1   # not changed
@@ -441,8 +537,9 @@ new_squash_commit()
 	oldsub="$2"
 	newsub="$3"
 	tree=$(toptree_for_commit $newsub) || exit $?
-	if [ -n "$old" ]; then
-		squash_msg "$dir" "$oldsub" "$newsub" | 
+	if test -n "$old"
+	then
+		squash_msg "$dir" "$oldsub" "$newsub" |
 			git commit-tree "$tree" -p "$old" || exit $?
 	else
 		squash_msg "$dir" "" "$newsub" |
@@ -455,46 +552,54 @@ copy_or_skip()
 	rev="$1"
 	tree="$2"
 	newparents="$3"
-	assert [ -n "$tree" ]
+	assert test -n "$tree"
 
 	identical=
 	nonidentical=
 	p=
 	gotparents=
-	for parent in $newparents; do
+	for parent in $newparents
+	do
 		ptree=$(toptree_for_commit $parent) || exit $?
-		[ -z "$ptree" ] && continue
-		if [ "$ptree" = "$tree" ]; then
+		test -z "$ptree" && continue
+		if test "$ptree" = "$tree"
+		then
 			# an identical parent could be used in place of this rev.
 			identical="$parent"
 		else
 			nonidentical="$parent"
 		fi
-		
+
 		# sometimes both old parents map to the same newparent;
 		# eliminate duplicates
 		is_new=1
-		for gp in $gotparents; do
-			if [ "$gp" = "$parent" ]; then
+		for gp in $gotparents
+		do
+			if test "$gp" = "$parent"
+			then
 				is_new=
 				break
 			fi
 		done
-		if [ -n "$is_new" ]; then
+		if test -n "$is_new"
+		then
 			gotparents="$gotparents $parent"
 			p="$p -p $parent"
 		fi
 	done
 
 	copycommit=
-	if [ -n "$identical" ] && [ -n "$nonidentical" ]; then
+	if test -n "$identical" && test -n "$nonidentical"
+	then
 		extras=$(git rev-list --count $identical..$nonidentical)
-		if [ "$extras" -ne 0 ]; then
+		if test "$extras" -ne 0
+		then
 			# we need to preserve history along the other branch
 			copycommit=1
 		fi
 	fi
-	if [ -n "$identical" ] && [ -z "$copycommit" ]; then
+	if test -n "$identical" && test -z "$copycommit"
+	then
 		echo $identical
 	else
 		copy_commit $rev $tree "$p" || exit $?
@@ -503,10 +608,12 @@ copy_or_skip()
 
 ensure_clean()
 {
-	if ! git diff-index HEAD --exit-code --quiet 2>&1; then
+	if ! git diff-index HEAD --exit-code --quiet 2>&1
+	then
 		die "Working tree has modifications.  Cannot add."
 	fi
-	if ! git diff-index --cached HEAD --exit-code --quiet 2>&1; then
+	if ! git diff-index --cached HEAD --exit-code --quiet 2>&1
+	then
 		die "Index has modifications.  Cannot add."
 	fi
 }
@@ -514,34 +621,38 @@ ensure_clean()
 ensure_valid_ref_format()
 {
 	git check-ref-format "refs/heads/$1" ||
-	    die "'$1' does not look like a ref"
+		die "'$1' does not look like a ref"
 }
 
 cmd_add()
 {
-	if [ -e "$dir" ]; then
+	if test -e "$dir"
+	then
 		die "'$dir' already exists.  Cannot add."
 	fi
 
 	ensure_clean
-	
-	if [ $# -eq 1 ]; then
-	    git rev-parse -q --verify "$1^{commit}" >/dev/null ||
-	    die "'$1' does not refer to a commit"
-
-	    "cmd_add_commit" "$@"
-	elif [ $# -eq 2 ]; then
-	    # Technically we could accept a refspec here but we're
-	    # just going to turn around and add FETCH_HEAD under the
-	    # specified directory.  Allowing a refspec might be
-	    # misleading because we won't do anything with any other
-	    # branches fetched via the refspec.
-	    ensure_valid_ref_format "$2"
-
-	    "cmd_add_repository" "$@"
+
+	if test $# -eq 1
+	then
+		git rev-parse -q --verify "$1^{commit}" >/dev/null ||
+			die "'$1' does not refer to a commit"
+
+		cmd_add_commit "$@"
+
+	elif test $# -eq 2
+	then
+		# Technically we could accept a refspec here but we're
+		# just going to turn around and add FETCH_HEAD under the
+		# specified directory.  Allowing a refspec might be
+		# misleading because we won't do anything with any other
+		# branches fetched via the refspec.
+		ensure_valid_ref_format "$2"
+
+		cmd_add_repository "$@"
 	else
-	    say "error: parameters were '$@'"
-	    die "Provide either a commit or a repository and commit."
+		say "error: parameters were '$@'"
+		die "Provide either a commit or a repository and commit."
 	fi
 }
 
@@ -561,30 +672,32 @@ cmd_add_commit()
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
-	if [ -n "$headrev" -a "$headrev" != "$rev" ]; then
+	if test -n "$headrev" && test "$headrev" != "$rev"
+	then
 		headp="-p $headrev"
 	else
 		headp=
 	fi
-	
-	if [ -n "$squash" ]; then
+
+	if test -n "$squash"
+	then
 		rev=$(new_squash_commit "" "" "$rev") || exit $?
 		commit=$(add_squashed_msg "$rev" "$dir" |
-			 git commit-tree $tree $headp -p "$rev") || exit $?
+			git commit-tree $tree $headp -p "$rev") || exit $?
 	else
 		revp=$(peel_committish "$rev") &&
 		commit=$(add_msg "$dir" "$headrev" "$rev" |
-			 git commit-tree $tree $headp -p "$revp") || exit $?
+			git commit-tree $tree $headp -p "$revp") || exit $?
 	fi
 	git reset "$commit" || exit $?
-	
+
 	say "Added dir '$dir'"
 }
 
@@ -592,24 +705,27 @@ cmd_split()
 {
 	debug "Splitting $dir..."
 	cache_setup || exit $?
-	
-	if [ -n "$onto" ]; then
+
+	if test -n "$onto"
+	then
 		debug "Reading history for --onto=$onto..."
 		git rev-list $onto |
-		while read rev; do
+		while read rev
+		do
 			# the 'onto' history is already just the subdir, so
 			# any parent we find there can be used verbatim
 			debug "  cache: $rev"
 			cache_set $rev $rev
 		done
 	fi
-	
-	if [ -n "$ignore_joins" ]; then
+
+	if test -n "$ignore_joins"
+	then
 		unrevs=
 	else
 		unrevs="$(find_existing_splits "$dir" "$revs")"
 	fi
-	
+
 	# We can't restrict rev-list to only $dir here, because some of our
 	# parents have the $dir contents the root, and those won't match.
 	# (and rev-list --follow doesn't seem to solve this)
@@ -618,12 +734,14 @@ cmd_split()
 	revcount=0
 	createcount=0
 	eval "$grl" |
-	while read rev parents; do
+	while read rev parents
+	do
 		revcount=$(($revcount + 1))
 		progress "$revcount/$revmax ($createcount)"
 		debug "Processing commit: $rev"
 		exists=$(cache_get $rev)
-		if [ -n "$exists" ]; then
+		if test -n "$exists"
+		then
 			debug "  prior: $exists"
 			continue
 		fi
@@ -631,17 +749,19 @@ cmd_split()
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
-		if [ -z $tree ]; then
+		if test -z $tree
+		then
 			set_notree $rev
-			if [ -n "$newparents" ]; then
+			if test -n "$newparents"
+			then
 				cache_set $rev $rev
 			fi
 			continue
@@ -653,12 +773,15 @@ cmd_split()
 		cache_set latest_new $newrev
 		cache_set latest_old $rev
 	done || exit $?
+
 	latest_new=$(cache_get latest_new)
-	if [ -z "$latest_new" ]; then
+	if test -z "$latest_new"
+	then
 		die "No new revisions were found"
 	fi
-	
-	if [ -n "$rejoin" ]; then
+
+	if test -n "$rejoin"
+	then
 		debug "Merging split branch into HEAD..."
 		latest_old=$(cache_get latest_old)
 		git merge -s ours \
@@ -666,16 +789,20 @@ cmd_split()
 			-m "$(rejoin_msg "$dir" $latest_old $latest_new)" \
 			$latest_new >&2 || exit $?
 	fi
-	if [ -n "$branch" ]; then
-		if rev_exists "refs/heads/$branch"; then
-			if ! rev_is_descendant_of_branch $latest_new $branch; then
+	if test -n "$branch"
+	then
+		if rev_exists "refs/heads/$branch"
+		then
+			if ! rev_is_descendant_of_branch $latest_new $branch
+			then
 				die "Branch '$branch' is not an ancestor of commit '$latest_new'."
 			fi
 			action='Updated'
 		else
 			action='Created'
 		fi
-		git update-ref -m 'subtree split' "refs/heads/$branch" $latest_new || exit $?
+		git update-ref -m 'subtree split' \
+			"refs/heads/$branch" $latest_new || exit $?
 		say "$action branch '$branch'"
 	fi
 	echo $latest_new
@@ -686,22 +813,26 @@ cmd_merge()
 {
 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
 	ensure_clean
-	
+
 	set -- $revs
-	if [ $# -ne 1 ]; then
+	if test $# -ne 1
+	then
 		die "You must provide exactly one revision.  Got: '$revs'"
 	fi
 	rev="$1"
-	
-	if [ -n "$squash" ]; then
+
+	if test -n "$squash"
+	then
 		first_split="$(find_latest_squash "$dir")"
-		if [ -z "$first_split" ]; then
+		if test -z "$first_split"
+		then
 			die "Can't squash-merge: '$dir' was never added."
 		fi
 		set $first_split
 		old=$1
 		sub=$2
-		if [ "$sub" = "$rev" ]; then
+		if test "$sub" = "$rev"
+		then
 			say "Subtree is already at commit $rev."
 			exit 0
 		fi
@@ -711,15 +842,19 @@ cmd_merge()
 	fi
 
 	version=$(git version)
-	if [ "$version" \< "git version 1.7" ]; then
-		if [ -n "$message" ]; then
-			git merge -s subtree --message="$message" $rev
+	if test "$version" \< "git version 1.7"
+	then
+		if test -n "$message"
+		then
+			git merge -s subtree --message="$message" "$rev"
 		else
-			git merge -s subtree $rev
+			git merge -s subtree "$rev"
 		fi
 	else
-		if [ -n "$message" ]; then
-			git merge -Xsubtree="$prefix" --message="$message" $rev
+		if test -n "$message"
+		then
+			git merge -Xsubtree="$prefix" \
+				--message="$message" "$rev"
 		else
 			git merge -Xsubtree="$prefix" $rev
 		fi
@@ -728,8 +863,9 @@ cmd_merge()
 
 cmd_pull()
 {
-	if [ $# -ne 2 ]; then
-	    die "You must provide <repository> <ref>"
+	if test $# -ne 2
+	then
+		die "You must provide <repository> <ref>"
 	fi
 	ensure_clean
 	ensure_valid_ref_format "$2"
@@ -741,18 +877,20 @@ cmd_pull()
 
 cmd_push()
 {
-	if [ $# -ne 2 ]; then
-	    die "You must provide <repository> <ref>"
+	if test $# -ne 2
+	then
+		die "You must provide <repository> <ref>"
 	fi
 	ensure_valid_ref_format "$2"
-	if [ -e "$dir" ]; then
-	    repository=$1
-	    refspec=$2
-	    echo "git push using: " $repository $refspec
-	    localrev=$(git subtree split --prefix="$prefix") || die
-	    git push "$repository" $localrev:refs/heads/$refspec
+	if test -e "$dir"
+	then
+		repository=$1
+		refspec=$2
+		echo "git push using: " "$repository" "$refspec"
+		localrev=$(git subtree split --prefix="$prefix") || die
+		git push "$repository" "$localrev":"refs/heads/$refspec"
 	else
-	    die "'$dir' must already exist. Try 'git subtree add'."
+		die "'$dir' must already exist. Try 'git subtree add'."
 	fi
 }
 
-- 
2.9.2.466.g8c6d1f9.dirty

