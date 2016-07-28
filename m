Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AF981F855
	for <e@80x24.org>; Thu, 28 Jul 2016 00:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162362AbcG1AQ7 (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 20:16:59 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33687 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161875AbcG1AQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 20:16:57 -0400
Received: by mail-pa0-f65.google.com with SMTP id q2so2518205pap.0
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 17:16:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+9Zu7eQy7uTolDN3zYxGnyHhOc8jbMfVhV8P46lBDyA=;
        b=bEdtfJRx26tFpsYQk8TD/VotqXYFl2jRn2J20fRTDryPHJC8E2IzyyLUWLMlSzc6d1
         EbJwhVrdLbcjuOaKMz+sMtKxCfymOtEeEAqCWf9S8JYZKizbfzhhwNSeEvq3mTICuozj
         CoMFzltFTsvXK+vIT/lUcA7D9g+ILbAw7TjnlN2EjNEVhARbxf2ZMUNwRInqha8+qkkQ
         IafPlK6wSaAm+HRjfS/v2+Ad4wEpZsCGPeSWLDC20noOqc28Y9UINeI4sy8351qanmzN
         gzw1Pab6q0rOKsfJCt7gpLWRhUMqf8IgHWTu1pdJeDwzCJdWio8tLbcSWaJDprx11N6X
         UFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+9Zu7eQy7uTolDN3zYxGnyHhOc8jbMfVhV8P46lBDyA=;
        b=UDdj5fYVJ8bMM18Wegjx87D4pOBrcw4mvHTVdjqOSVchXelJ14bkSuiM9DkiymtsWq
         8S8uqWBEGywKqu17c+CkgPwCbkS3HT5ORuJ40e195ta2qANEa+qzd6OLLzQVzDTpj2Tm
         vMQjb4CMDrAqUWfVefvvf50INbgV0i5/MAGFS4z+N8uEA2c9LxzYeTqCOd+e7/7wauLj
         VKLWE5ukXBmcD88Knk66CNvLXK0upkd6g9N7Owe+DmAfELEcSyUDkZwzlGA+/2VFiJIt
         aykvhE2LF7fw24H6uolZHM438heldfqPSmBJ36Km3pcYKbafA7+53xhInsDUNCJZ3lF9
         mFKg==
X-Gm-Message-State: AEkoouudKWwqoq1zcC6169EjDBltSGNQB36vkhqoq4hpJ9AGF2fAddityb+UZulwiQPINA==
X-Received: by 10.66.245.1 with SMTP id xk1mr55216842pac.58.1469665016104;
        Wed, 27 Jul 2016 17:16:56 -0700 (PDT)
Received: from raptor.fas.fa.disney.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by smtp.gmail.com with ESMTPSA id v124sm11879757pfb.14.2016.07.27.17.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jul 2016 17:16:55 -0700 (PDT)
From:	David Aguilar <davvid@gmail.com>
To:	Git Mailing List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brett Cundal <brett.cundal@iugome.com>,
	"David A . Greene" <greened@obbligato.org>,
	Charles Bailey <cbailey32@bloomberg.net>,
	Techlive Zheng <techlivezheng@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 4/4] subtree: adjust function definitions to match CodingGuidelines
Date:	Wed, 27 Jul 2016 17:16:50 -0700
Message-Id: <20160728001650.21482-2-davvid@gmail.com>
X-Mailer: git-send-email 2.9.2.469.ga693980
In-Reply-To: <20160728001650.21482-1-davvid@gmail.com>
References: <20160728001650.21482-1-davvid@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We prefer a space between the function name and the parentheses, and no
space inside the parentheses.

The opening "{" should also be on the same line.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
This says "v3" but this is actually a branch new patch that wasn't included
in the previous iteration... calling it v3 since it's split out from the
previous patch.

They can be squashed together if desired, but this makes it a little
easier to review separately.

 contrib/subtree/git-subtree.sh | 102 ++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 68 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index de49eb0..dec085a 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -49,32 +49,28 @@ squash=
 message=
 prefix=
 
-debug()
-{
+debug () {
 	if test -n "$debug"
 	then
 		printf "%s\n" "$*" >&2
 	fi
 }
 
-say()
-{
+say () {
 	if test -z "$quiet"
 	then
 		printf "%s\n" "$*" >&2
 	fi
 }
 
-progress()
-{
+progress () {
 	if test -z "$quiet"
 	then
 		printf "%s\r" "$*" >&2
 	fi
 }
 
-assert()
-{
+assert () {
 	if ! "$@"
 	then
 		die "assertion failed: " "$@"
@@ -202,8 +198,7 @@ debug "dir: {$dir}"
 debug "opts: {$*}"
 debug
 
-cache_setup()
-{
+cache_setup () {
 	cachedir="$GIT_DIR/subtree-cache/$$"
 	rm -rf "$cachedir" ||
 		die "Can't delete old cachedir: $cachedir"
@@ -214,8 +209,7 @@ cache_setup()
 	debug "Using cachedir: $cachedir" >&2
 }
 
-cache_get()
-{
+cache_get () {
 	for oldrev in "$@"
 	do
 		if test -r "$cachedir/$oldrev"
@@ -226,8 +220,7 @@ cache_get()
 	done
 }
 
-cache_miss()
-{
+cache_miss () {
 	for oldrev in "$@"
 	do
 		if ! test -r "$cachedir/$oldrev"
@@ -237,8 +230,7 @@ cache_miss()
 	done
 }
 
-check_parents()
-{
+check_parents () {
 	missed=$(cache_miss "$@")
 	for miss in $missed
 	do
@@ -249,13 +241,11 @@ check_parents()
 	done
 }
 
-set_notree()
-{
+set_notree () {
 	echo "1" > "$cachedir/notree/$1"
 }
 
-cache_set()
-{
+cache_set () {
 	oldrev="$1"
 	newrev="$2"
 	if test "$oldrev" != "latest_old" &&
@@ -267,8 +257,7 @@ cache_set()
 	echo "$newrev" >"$cachedir/$oldrev"
 }
 
-rev_exists()
-{
+rev_exists () {
 	if git rev-parse "$1" >/dev/null 2>&1
 	then
 		return 0
@@ -277,8 +266,7 @@ rev_exists()
 	fi
 }
 
-rev_is_descendant_of_branch()
-{
+rev_is_descendant_of_branch () {
 	newrev="$1"
 	branch="$2"
 	branch_hash=$(git rev-parse "$branch")
@@ -295,16 +283,14 @@ rev_is_descendant_of_branch()
 # if a commit doesn't have a parent, this might not work.  But we only want
 # to remove the parent from the rev-list, and since it doesn't exist, it won't
 # be there anyway, so do nothing in that case.
-try_remove_previous()
-{
+try_remove_previous () {
 	if rev_exists "$1^"
 	then
 		echo "^$1^"
 	fi
 }
 
-find_latest_squash()
-{
+find_latest_squash () {
 	debug "Looking for latest squash ($dir)..."
 	dir="$1"
 	sq=
@@ -348,8 +334,7 @@ find_latest_squash()
 	done
 }
 
-find_existing_splits()
-{
+find_existing_splits () {
 	debug "Looking for prior splits..."
 	dir="$1"
 	revs="$2"
@@ -393,8 +378,7 @@ find_existing_splits()
 	done
 }
 
-copy_commit()
-{
+copy_commit () {
 	# We're going to set some environment vars here, so
 	# do it in a subshell to get rid of them safely later
 	debug copy_commit "{$1}" "{$2}" "{$3}"
@@ -420,8 +404,7 @@ copy_commit()
 	) || die "Can't copy commit $1"
 }
 
-add_msg()
-{
+add_msg () {
 	dir="$1"
 	latest_old="$2"
 	latest_new="$3"
@@ -440,8 +423,7 @@ add_msg()
 	EOF
 }
 
-add_squashed_msg()
-{
+add_squashed_msg () {
 	if test -n "$message"
 	then
 		echo "$message"
@@ -450,8 +432,7 @@ add_squashed_msg()
 	fi
 }
 
-rejoin_msg()
-{
+rejoin_msg () {
 	dir="$1"
 	latest_old="$2"
 	latest_new="$3"
@@ -470,8 +451,7 @@ rejoin_msg()
 	EOF
 }
 
-squash_msg()
-{
+squash_msg () {
 	dir="$1"
 	oldsub="$2"
 	newsub="$3"
@@ -493,14 +473,12 @@ squash_msg()
 	echo "git-subtree-split: $newsub"
 }
 
-toptree_for_commit()
-{
+toptree_for_commit () {
 	commit="$1"
 	git log -1 --pretty=format:'%T' "$commit" -- || exit $?
 }
 
-subtree_for_commit()
-{
+subtree_for_commit () {
 	commit="$1"
 	dir="$2"
 	git ls-tree "$commit" -- "$dir" |
@@ -514,8 +492,7 @@ subtree_for_commit()
 	done
 }
 
-tree_changed()
-{
+tree_changed () {
 	tree=$1
 	shift
 	if test $# -ne 1
@@ -532,8 +509,7 @@ tree_changed()
 	fi
 }
 
-new_squash_commit()
-{
+new_squash_commit () {
 	old="$1"
 	oldsub="$2"
 	newsub="$3"
@@ -548,8 +524,7 @@ new_squash_commit()
 	fi
 }
 
-copy_or_skip()
-{
+copy_or_skip () {
 	rev="$1"
 	tree="$2"
 	newparents="$3"
@@ -607,8 +582,7 @@ copy_or_skip()
 	fi
 }
 
-ensure_clean()
-{
+ensure_clean () {
 	if ! git diff-index HEAD --exit-code --quiet 2>&1
 	then
 		die "Working tree has modifications.  Cannot add."
@@ -619,14 +593,12 @@ ensure_clean()
 	fi
 }
 
-ensure_valid_ref_format()
-{
+ensure_valid_ref_format () {
 	git check-ref-format "refs/heads/$1" ||
 		die "'$1' does not look like a ref"
 }
 
-cmd_add()
-{
+cmd_add () {
 	if test -e "$dir"
 	then
 		die "'$dir' already exists.  Cannot add."
@@ -657,8 +629,7 @@ cmd_add()
 	fi
 }
 
-cmd_add_repository()
-{
+cmd_add_repository () {
 	echo "git fetch" "$@"
 	repository=$1
 	refspec=$2
@@ -668,8 +639,7 @@ cmd_add_repository()
 	cmd_add_commit "$@"
 }
 
-cmd_add_commit()
-{
+cmd_add_commit () {
 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
 	set -- $revs
 	rev="$1"
@@ -702,8 +672,7 @@ cmd_add_commit()
 	say "Added dir '$dir'"
 }
 
-cmd_split()
-{
+cmd_split () {
 	debug "Splitting $dir..."
 	cache_setup || exit $?
 
@@ -810,8 +779,7 @@ cmd_split()
 	exit 0
 }
 
-cmd_merge()
-{
+cmd_merge () {
 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
 	ensure_clean
 
@@ -862,8 +830,7 @@ cmd_merge()
 	fi
 }
 
-cmd_pull()
-{
+cmd_pull () {
 	if test $# -ne 2
 	then
 		die "You must provide <repository> <ref>"
@@ -876,8 +843,7 @@ cmd_pull()
 	cmd_merge "$@"
 }
 
-cmd_push()
-{
+cmd_push () {
 	if test $# -ne 2
 	then
 		die "You must provide <repository> <ref>"
-- 
2.9.2.469.ga693980

