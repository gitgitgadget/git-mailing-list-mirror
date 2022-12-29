Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39527C4332F
	for <git@archiver.kernel.org>; Thu, 29 Dec 2022 12:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiL2MvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 07:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbiL2Muc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 07:50:32 -0500
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434F313F80
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 04:50:21 -0800 (PST)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4NjSsm4x7KzDqvJ
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 12:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1672318220; bh=U2MXytnFR/9UHHAoNpV4vm677mai+61ZBfbPBAVkekI=;
        h=Date:From:To:Subject:From;
        b=J4FP5Q8KkPL0GsJdBcypalQmbKhz+ag+ROVb2KHqDS4SZfqIhLe3GxAZ7VhetflI3
         qf7umd7r0cAeWAWsiboYdVL6gV8tcoMuUz2B6kaQL6tqd0PBg5fyrBuP8w5AnQ8Dqw
         4zXdUIcZY/q53uJ+BojSWDauEudz+tG0gwz2ryKQ=
X-Riseup-User-ID: 35E886573C775B0EFCF9387C121540BE74C83D22623D043AD553700FF9E2D548
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4NjSsl37s2z20SJ
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 12:50:19 +0000 (UTC)
Date:   Thu, 29 Dec 2022 12:50:12 +0000
From:   Samanta Navarro <ferivoz@riseup.net>
To:     git@vger.kernel.org
Subject: [PATCH] maintenance: fix typos
Message-ID: <20221229125012.cp5tjdlnvxbln44l@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Typos found with codespell.

Signed-off-by: Samanta Navarro <ferivoz@riseup.net>
---
 Documentation/CodingGuidelines           | 2 +-
 Documentation/config.txt                 | 2 +-
 Documentation/fsck-msgids.txt            | 2 +-
 Documentation/git-cvsserver.txt          | 2 +-
 Documentation/git-describe.txt           | 2 +-
 Documentation/git-format-patch.txt       | 2 +-
 Documentation/git-ls-tree.txt            | 2 +-
 Documentation/git-mktag.txt              | 2 +-
 Documentation/git-sparse-checkout.txt    | 2 +-
 Documentation/git-stash.txt              | 2 +-
 Documentation/gitformat-commit-graph.txt | 2 +-
 Documentation/gitweb.txt                 | 2 +-
 bloom.h                                  | 2 +-
 builtin/help.c                           | 2 +-
 builtin/name-rev.c                       | 2 +-
 cache.h                                  | 2 +-
 cbtree.c                                 | 2 +-
 commit-graph.h                           | 2 +-
 compat/fsmonitor/fsm-listen-win32.c      | 4 ++--
 compat/precompose_utf8.c                 | 2 +-
 compat/simple-ipc/ipc-unix-socket.c      | 2 +-
 config.mak.dev                           | 2 +-
 contrib/coccinelle/unused.cocci          | 2 +-
 contrib/completion/git-completion.bash   | 2 +-
 contrib/subtree/git-subtree.sh           | 2 +-
 contrib/subtree/t/t7900-subtree.sh       | 2 +-
 diffcore-rename.c                        | 4 ++--
 fsmonitor-settings.c                     | 2 +-
 fsmonitor.c                              | 2 +-
 git-gui/lib/themed.tcl                   | 2 +-
 git-instaweb.sh                          | 2 +-
 git-p4.py                                | 4 ++--
 gpg-interface.c                          | 2 +-
 http.c                                   | 2 +-
 merge-ort.c                              | 6 +++---
 object-file.c                            | 2 +-
 perl/Git/I18N.pm                         | 2 +-
 rebase.c                                 | 2 +-
 refs.h                                   | 4 ++--
 reftable/reader.h                        | 2 +-
 revision.h                               | 2 +-
 run-command.h                            | 2 +-
 setup.c                                  | 2 +-
 sideband.c                               | 2 +-
 trace2/tr2_ctr.c                         | 2 +-
 trace2/tr2_tls.h                         | 2 +-
 46 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 9d5c27807a..6c7465d690 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -683,7 +683,7 @@ Writing Documentation:
    Do: [-q | --quiet]
    Don't: [-q|--quiet]
 
- Don't use spacing around "|" tokens when they're used to seperate the
+ Don't use spacing around "|" tokens when they're used to separate the
  alternate arguments of an option:
     Do: --track[=(direct|inherit)]
     Don't: --track[=(direct | inherit)]
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e93aef862..229b63a454 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -182,7 +182,7 @@ included, Git breaks the cycle by prohibiting these files from affecting
 the resolution of these conditions (thus, prohibiting them from
 declaring remote URLs).
 +
-As for the naming of this keyword, it is for forwards compatibiliy with
+As for the naming of this keyword, it is for forwards compatibility with
 a naming scheme that supports more variable-based include conditions,
 but currently Git only supports the exact keyword described above.
 
diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 7af76ff99a..841ffeee38 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -155,7 +155,7 @@
 	(FATAL) Missing end-of-line in the object header.
 
 `zeroPaddedDate`::
-	(ERROR) Found a zero padded date in an author/commiter line.
+	(ERROR) Found a zero padded date in an author/committer line.
 
 `zeroPaddedFilemode`::
 	(WARN) Found a zero padded filemode in a tree.
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 53f111bc0a..cf4a5a283e 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -118,7 +118,7 @@ for example:
    myuser:$5$.NqmNH1vwfzGpV8B$znZIcumu1tNLATgV2l6e1/mY8RzhUDHMOaVOeL1cxV3
 ------
 You can use the 'htpasswd' facility that comes with Apache to make these
-files, but only with the -d option (or -B if your system suports it).
+files, but only with the -d option (or -B if your system supports it).
 
 Preferably use the system specific utility that manages password hash
 creation in your platform (e.g. mkpasswd in Linux, encrypt in OpenBSD or
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index c6a79c2a0f..8ace8fb78a 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -140,7 +140,7 @@ at the end.
 
 The number of additional commits is the number
 of commits which would be displayed by "git log v1.0.4..parent".
-The hash suffix is "-g" + an unambigous abbreviation for the tip commit
+The hash suffix is "-g" + an unambiguous abbreviation for the tip commit
 of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`). The
 length of the abbreviation scales as the repository grows, using the
 approximate number of objects in the repository and a bit of math
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index dfcc7da4c2..f4b6dbd2e1 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -246,7 +246,7 @@ populated with placeholder text.
 	or "--reroll-count=4rev2" are allowed), but the downside of
 	using such a reroll-count is that the range-diff/interdiff
 	with the previous version does not state exactly which
-	version the new interation is compared against.
+	version the new iteration is compared against.
 
 --to=<email>::
 	Add a `To:` header to the email headers. This is in addition
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 0240adb8ee..fa9a6b9f2c 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -145,7 +145,7 @@ FIELD NAMES
 -----------
 
 Various values from structured fields can be used to interpolate
-into the resulting output. For each outputing line, the following
+into the resulting output. For each outputting line, the following
 names can be used:
 
 objectmode::
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 466a697519..b2a2e80d42 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -33,7 +33,7 @@ from warnings to errors (so e.g. a missing "tagger" line is an error).
 
 Extra headers in the object are also an error under mktag, but ignored
 by linkgit:git-fsck[1]. This extra check can be turned off by setting
-the appropriate `fsck.<msg-id>` varible:
+the appropriate `fsck.<msg-id>` variable:
 
     git -c fsck.extraHeaderEntry=ignore mktag <my-tag-with-headers
 
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 68392d2a56..d6d4d42fbd 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -263,7 +263,7 @@ patterns in non-cone mode has a number of shortcomings:
     problem above?  Also, if it suggests paths, what if the user has a
     file or directory that begins with either a '!' or '#' or has a '*',
     '\', '?', '[', or ']' in its name?  And if it suggests paths, will
-    it complete "/pro" to "/proc" (in the root filesytem) rather than to
+    it complete "/pro" to "/proc" (in the root filesystem) rather than to
     "/progress.txt" in the current directory?  (Note that users are
     likely to want to start paths with a leading '/' in non-cone mode,
     for the same reason that .gitignore files often have one.)
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index f4bb6114d9..06fb7f1d18 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -366,7 +366,7 @@ only the commit ends-up being in the stash and not on the current branch.
 # ... hack hack hack ...
 $ git add --patch foo           # add unrelated changes to the index
 $ git stash push --staged       # save these changes to the stash
-# ... hack hack hack, finish curent changes ...
+# ... hack hack hack, finish current changes ...
 $ git commit -m 'Massive'       # commit fully tested changes
 $ git switch fixup-branch       # switch to another branch
 $ git stash pop                 # to finish work on the saved changes
diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
index 31cad585e2..76312fa249 100644
--- a/Documentation/gitformat-commit-graph.txt
+++ b/Documentation/gitformat-commit-graph.txt
@@ -122,7 +122,7 @@ All multi-byte numbers are in network byte order.
       for commits with corrected commit date offsets that cannot be
       stored within 31 bits.
     * Generation Data Overflow chunk is present only when Generation Data
-      chunk is present and atleast one corrected commit date offset cannot
+      chunk is present and at least one corrected commit date offset cannot
       be stored within 31 bits.
 
 ==== Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 7cee9d3689..74c35e8953 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -234,7 +234,7 @@ from the template during repository creation, usually installed in
 configuration variable, but the file takes precedence.
 
 category (or `gitweb.category`)::
-	Singe line category of a project, used to group projects if
+	Single line category of a project, used to group projects if
 	`$projects_list_group_categories` is enabled.  By default (file and
 	configuration variable absent), uncategorized projects are put in the
 	`$project_list_default_category` category.  You can use the
diff --git a/bloom.h b/bloom.h
index adde6dfe21..83eb989d85 100644
--- a/bloom.h
+++ b/bloom.h
@@ -15,7 +15,7 @@ struct bloom_filter_settings {
 
 	/*
 	 * The number of times a path is hashed, i.e. the
-	 * number of bit positions tht cumulatively
+	 * number of bit positions that cumulatively
 	 * determine whether a path is present in the
 	 * Bloom filter.
 	 */
diff --git a/builtin/help.c b/builtin/help.c
index 53f2812dfb..bad3344016 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -536,7 +536,7 @@ static void open_html(const char *path)
 
 static void show_html_page(const char *page)
 {
-	struct strbuf page_path; /* it leaks but we exec bellow */
+	struct strbuf page_path; /* it leaks but we exec below */
 
 	get_html_page_path(&page_path, page);
 
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 15535e914a..210c6a8e86 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -59,7 +59,7 @@ static void set_commit_cutoff(struct commit *commit)
 static void adjust_cutoff_timestamp_for_slop(void)
 {
 	if (cutoff) {
-		/* check for undeflow */
+		/* check for underflow */
 		if (cutoff > TIME_MIN + CUTOFF_DATE_SLOP)
 			cutoff = cutoff - CUTOFF_DATE_SLOP;
 		else
diff --git a/cache.h b/cache.h
index fcf49706ad..631b2c5854 100644
--- a/cache.h
+++ b/cache.h
@@ -321,7 +321,7 @@ enum sparse_index_mode {
 
 	/*
 	 * The index has already been collapsed to sparse directories
-	 * whereever possible.
+	 * wherever possible.
 	 */
 	INDEX_COLLAPSED,
 
diff --git a/cbtree.c b/cbtree.c
index 336e46dbba..caeb232a79 100644
--- a/cbtree.c
+++ b/cbtree.c
@@ -11,7 +11,7 @@ static struct cb_node *cb_node_of(const void *p)
 	return (struct cb_node *)((uintptr_t)p - 1);
 }
 
-/* locate the best match, does not do a final comparision */
+/* locate the best match, does not do a final comparison */
 static struct cb_node *cb_internal_best_match(struct cb_node *p,
 					const uint8_t *k, size_t klen)
 {
diff --git a/commit-graph.h b/commit-graph.h
index 37faee6b66..aea51b57a0 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -13,7 +13,7 @@
  * This method is only used to enhance coverage of the commit-graph
  * feature in the test suite with the GIT_TEST_COMMIT_GRAPH and
  * GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS environment variables. Do not
- * call this method oustide of a builtin, and only if you know what
+ * call this method outside of a builtin, and only if you know what
  * you are doing!
  */
 void git_test_write_commit_graph_or_die(void);
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 03df8d951b..6a1b6435a8 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -430,9 +430,9 @@ static int recv_rdcw_watch(struct one_watch *watch)
 	 * but I observed ERROR_ACCESS_DENIED (0x05) errors during
 	 * testing.
 	 *
-	 * Note that we only get notificaiton events for events
+	 * Note that we only get notification events for events
 	 * *within* the directory, not *on* the directory itself.
-	 * (These might be properies of the parent directory, for
+	 * (These might be properties of the parent directory, for
 	 * example).
 	 *
 	 * NEEDSWORK: We might try to check for the deleted directory
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index cce1d57a46..e330904497 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -80,7 +80,7 @@ const char *precompose_string_if_needed(const char *in)
 		out = reencode_string_iconv(in, inlen, ic_prec, 0, &outlen);
 		if (out) {
 			if (outlen == inlen && !memcmp(in, out, outlen))
-				free(out); /* no need to return indentical */
+				free(out); /* no need to return identical */
 			else
 				in = out;
 		}
diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index 28a79289d4..bffe6eacce 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -711,7 +711,7 @@ static int accept_thread__wait_for_connection(
  * Block SIGPIPE in this thread for the life of the thread.  This
  * avoids any stray SIGPIPE signals when closing pipe fds under
  * extremely heavy loads (such as when the fifo queue is full and we
- * drop incomming connections).
+ * drop incoming connections).
  */
 static void *accept_thread_proc(void *_accept_thread_data)
 {
diff --git a/config.mak.dev b/config.mak.dev
index 981304727c..055e1a6799 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -69,7 +69,7 @@ DEVELOPER_CFLAGS += -Wno-missing-braces
 endif
 endif
 
-# Old versions of clang complain about initializaing a
+# Old versions of clang complain about initializing a
 # struct-within-a-struct using just "{0}" rather than "{{0}}".  This
 # error is considered a false-positive and not worth fixing, because
 # new clang versions do not, so just disable it.
diff --git a/contrib/coccinelle/unused.cocci b/contrib/coccinelle/unused.cocci
index d84046f82e..142a5a1f02 100644
--- a/contrib/coccinelle/unused.cocci
+++ b/contrib/coccinelle/unused.cocci
@@ -1,4 +1,4 @@
-// This rule finds sequences of "unused" declerations and uses of a
+// This rule finds sequences of "unused" declarations and uses of a
 // variable, where "unused" is defined to include only calling the
 // equivalent of alloc, init & free functions on the variable.
 @@
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dc95c34cc8..f414639f52 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3330,7 +3330,7 @@ _git_worktree ()
 		# Here we are not completing an --option, it's either the
 		# path or a ref.
 		case "$prev" in
-		-b|-B)	# Complete refs for branch to be created/reseted.
+		-b|-B)	# Complete refs for branch to be created/resetted.
 			__git_complete_refs
 			;;
 		-*)	# The previous word is an -o|--option without an
diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 10c9c87839..8c4e2c0460 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -921,7 +921,7 @@ cmd_split () {
 		rev=$(git rev-parse -q --verify "$1^{commit}") ||
 			die "fatal: '$1' does not refer to a commit"
 	else
-		die "fatal: you must provide exactly one revision, and optionnally a repository.  Got: '$*'"
+		die "fatal: you must provide exactly one revision, and optionally a repository.  Got: '$*'"
 	fi
 	repository=""
 	if test "$#" = 2
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 341c169eca..fa5bd9b7af 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -47,7 +47,7 @@ last_commit_subject () {
 # pre-2.32.0 versions of 'git subtree' would write the hash of the tag
 # (sub1 below), instead of the commit (sub1^{commit}) in the
 # "git-subtree-split" trailer.
-# We immitate this behaviour below using a replace ref.
+# We imitate this behaviour below using a replace ref.
 # This function creates 3 repositories:
 # - $1
 # - $1-sub (added as subtree "sub" in $1)
diff --git a/diffcore-rename.c b/diffcore-rename.c
index c0422d9e70..3f6bc98375 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -926,7 +926,7 @@ static int find_basename_matches(struct diff_options *options,
 	 * spend more cycles to find similarities between files, so it may
 	 * be less likely that this heuristic is wanted.  If someone is
 	 * doing break detection, that means they do not want filename
-	 * similarity to imply any form of content similiarity, and thus
+	 * similarity to imply any form of content similarity, and thus
 	 * this heuristic would definitely be incompatible.
 	 */
 
@@ -1527,7 +1527,7 @@ void diffcore_rename_extended(struct diff_options *options,
 		 *   - remove ones not found in relevant_sources
 		 * and
 		 *   - remove ones in relevant_sources which are needed only
-		 *     for directory renames IF no ancestory directory
+		 *     for directory renames IF no ancestry directory
 		 *     actually needs to know any more individual path
 		 *     renames under them
 		 */
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index ee63a97dc5..ce23659dbd 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -6,7 +6,7 @@
 #include "fsmonitor-path-utils.h"
 
 /*
- * We keep this structure defintion private and have getters
+ * We keep this structure definition private and have getters
  * for all fields so that we can lazy load it as needed.
  */
 struct fsmonitor_settings {
diff --git a/fsmonitor.c b/fsmonitor.c
index 08af00c738..d48e089c9b 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -215,7 +215,7 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 		}
 
 		/*
-		 * We need to remove the traling "/" from the path
+		 * We need to remove the trailing "/" from the path
 		 * for the untracked cache.
 		 */
 		name[len - 1] = '\0';
diff --git a/git-gui/lib/themed.tcl b/git-gui/lib/themed.tcl
index f43d84e54f..68c999a9be 100644
--- a/git-gui/lib/themed.tcl
+++ b/git-gui/lib/themed.tcl
@@ -4,7 +4,7 @@
 
 namespace eval color {
 	# Variable colors
-	# Preffered way to set widget colors is using add_option.
+	# Preferred way to set widget colors is using add_option.
 	# In some cases, like with tags in_diff/in_sel, we use these colors.
 	variable select_bg				lightgray
 	variable select_fg				black
diff --git a/git-instaweb.sh b/git-instaweb.sh
index c68f49454c..652d0b2dd3 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -612,7 +612,7 @@ python_conf() {
 	ln -sf "$root/static" "$fqgitdir/gitweb/$httpd_only/"
 
 	# generate a standalone 'python http.server' script in $fqgitdir/gitweb
-	# This asumes that python is in user's $PATH
+	# This assumes that python is in user's $PATH
 	# This script is Python 2 and 3 compatible
 	cat > "$fqgitdir/gitweb/gitweb.py" <<EOF
 #!/usr/bin/env python
diff --git a/git-p4.py b/git-p4.py
index d26a980e5a..595a2dad37 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -54,7 +54,7 @@
 import zipfile
 import zlib
 
-# On python2.7 where raw_input() and input() are both availble,
+# On python2.7 where raw_input() and input() are both available,
 # we want raw_input's semantics, but aliased to input for python3
 # compatibility
 # support basestring in python3
@@ -1800,7 +1800,7 @@ def __init__(self):
     status from the script will abort the process.
 
     The purpose of the hook is to edit the message file in place, and it is not
-    supressed by the `--no-verify` option. This hook is called even if
+    suppressed by the `--no-verify` option. This hook is called even if
     `--prepare-p4-only` is set.
 
     The `p4-changelist` hook is executed after the changelist message has been
diff --git a/gpg-interface.c b/gpg-interface.c
index f877a1ea56..89c2ec08be 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -379,7 +379,7 @@ static void parse_ssh_output(struct signature_check *sigc)
 	 * Note that "PRINCIPAL" can contain whitespace, "RSA" and
 	 * "SHA256" part could be a different token that names of
 	 * the algorithms used, and "FINGERPRINT" is a hexadecimal
-	 * string.  By finding the last occurence of " with ", we can
+	 * string.  By finding the last occurrence of " with ", we can
 	 * reliably parse out the PRINCIPAL.
 	 */
 	sigc->result = 'B';
diff --git a/http.c b/http.c
index 8a5ba3f477..77ac7ce24e 100644
--- a/http.c
+++ b/http.c
@@ -1425,7 +1425,7 @@ void run_active_slot(struct active_request_slot *slot)
 	 * The value of slot->finished we set before the loop was used
 	 * to set our "finished" variable when our request completed.
 	 *
-	 * 1. The slot may not have been reused for another requst
+	 * 1. The slot may not have been reused for another request
 	 *    yet, in which case it still has &finished.
 	 *
 	 * 2. The slot may already be in-use to serve another request,
diff --git a/merge-ort.c b/merge-ort.c
index d1611ca400..73b1321dd0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1121,7 +1121,7 @@ static void collect_rename_info(struct merge_options *opt,
 	 * Update dir_rename_mask (determines ignore-rename-source validity)
 	 *
 	 * dir_rename_mask helps us keep track of when directory rename
-	 * detection may be relevant.  Basically, whenver a directory is
+	 * detection may be relevant.  Basically, whenever a directory is
 	 * removed on one side of history, and a file is added to that
 	 * directory on the other side of history, directory rename
 	 * detection is relevant (meaning we have to detect renames for all
@@ -2042,7 +2042,7 @@ static int handle_content_merge(struct merge_options *opt,
 	 * the three blobs to merge on various sides of history.
 	 *
 	 * extra_marker_size is the amount to extend conflict markers in
-	 * ll_merge; this is neeed if we have content merges of content
+	 * ll_merge; this is needed if we have content merges of content
 	 * merges, which happens for example with rename/rename(2to1) and
 	 * rename/add conflicts.
 	 */
@@ -3726,7 +3726,7 @@ static int write_completed_directory(struct merge_options *opt,
 	 *     	   src/moduleB  2
 	 *
 	 *     which is used to know that xtract.c & token.txt are from the
-	 *     toplevel dirctory, while umm.c & stuff.h & baz.c are from the
+	 *     toplevel directory, while umm.c & stuff.h & baz.c are from the
 	 *     src/moduleB directory.  Again, following the example above,
 	 *     once we need to process src/moduleB, then info->offsets is
 	 *     updated to
diff --git a/object-file.c b/object-file.c
index c1b71c2834..149039745c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2177,7 +2177,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 
 	/*
 	 * Common steps for write_loose_object and stream_loose_object to
-	 * end writing loose oject:
+	 * end writing loose object:
 	 *
 	 *  - End the compression of zlib stream.
 	 *  - Get the calculated oid.
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 895e759c57..228e4d6659 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -111,7 +111,7 @@ =head2 __n($$$)
 =head2 N__($)
 
 No-operation that only returns its argument. Use this if you want xgettext to
-extract the text to the pot template but do not want to trigger retrival of the
+extract the text to the pot template but do not want to trigger retrieval of the
 translation at run time.
 
 =head1 AUTHOR
diff --git a/rebase.c b/rebase.c
index 6775cddb28..4711863c81 100644
--- a/rebase.c
+++ b/rebase.c
@@ -10,7 +10,7 @@
  * The callers that care if (any) rebase is requested should say
  *   if (REBASE_TRUE <= rebase_parse_value(string))
  *
- * The callers that want to differenciate an unrecognised value and
+ * The callers that want to differentiate an unrecognised value and
  * false can do so by treating _INVALID and _FALSE differently.
  */
 enum rebase_type rebase_parse_value(const char *value)
diff --git a/refs.h b/refs.h
index 935cdd1ece..1301f33629 100644
--- a/refs.h
+++ b/refs.h
@@ -477,7 +477,7 @@ int delete_reflog(const char *refname);
  * from UTC.  Its absolute value is formed by multiplying the hour
  * part by 100 and adding the minute part.  For example, 1 hour ahead
  * of UTC, CET == "+0100", is represented as positive one hundred (not
- * postiive sixty).
+ * positive sixty).
  *
  * The msg parameter is a single complete line; a reflog message given
  * to refs_delete_ref, refs_update_ref, etc. is returned to the
@@ -955,7 +955,7 @@ struct ref_store *get_worktree_ref_store(const struct worktree *wt);
 
 /*
  * Some of the names specified by refs have special meaning to Git.
- * Organize these namespaces in a comon 'ref_namespace' array for
+ * Organize these namespaces in a common 'ref_namespace' array for
  * reference from multiple places in the codebase.
  */
 
diff --git a/reftable/reader.h b/reftable/reader.h
index e869165f23..8d69ff3d0e 100644
--- a/reftable/reader.h
+++ b/reftable/reader.h
@@ -30,7 +30,7 @@ struct reftable_reader_offsets {
 
 /* The state for reading a reftable file. */
 struct reftable_reader {
-	/* for convience, associate a name with the instance. */
+	/* for convenience, associate a name with the instance. */
 	char *name;
 	struct reftable_block_source source;
 
diff --git a/revision.h b/revision.h
index 30febad09a..1786ead648 100644
--- a/revision.h
+++ b/revision.h
@@ -541,7 +541,7 @@ int rewrite_parents(struct rev_info *revs,
  * The log machinery saves the original parent list so that
  * get_saved_parents() can later tell what the real parents of the
  * commits are, when commit->parents has been modified by history
- * simpification.
+ * simplification.
  *
  * get_saved_parents() will transparently return commit->parents if
  * history simplification is off.
diff --git a/run-command.h b/run-command.h
index 072db56a4d..b27743be29 100644
--- a/run-command.h
+++ b/run-command.h
@@ -523,7 +523,7 @@ enum start_bg_result {
 	/* timeout expired waiting for child to become "ready" */
 	SBGR_TIMEOUT,
 
-	/* child process exited or was signalled before becomming "ready" */
+	/* child process exited or was signalled before becoming "ready" */
 	SBGR_DIED,
 };
 
diff --git a/setup.c b/setup.c
index cefd5f63c4..f883a238ae 100644
--- a/setup.c
+++ b/setup.c
@@ -452,7 +452,7 @@ static void setup_original_cwd(void)
 	 * directory we inherited from our parent process, which is a
 	 * directory we want to avoid removing.
 	 *
-	 * For convience, we would like to have the path relative to the
+	 * For convenience, we would like to have the path relative to the
 	 * worktree instead of an absolute path.
 	 *
 	 * Yes, startup_info->original_cwd is usually the same as 'prefix',
diff --git a/sideband.c b/sideband.c
index 85bddfdcd4..faea1dd100 100644
--- a/sideband.c
+++ b/sideband.c
@@ -184,7 +184,7 @@ int demultiplex_sideband(const char *me, int status,
 			int linelen = brk - b;
 
 			/*
-			 * For message accross packet boundary, there would have
+			 * For message across packet boundary, there would have
 			 * a nonempty "scratch" buffer from last call of this
 			 * function, and there may have a leading CR/LF in "buf".
 			 * For this case we should add a clear-to-eol suffix to
diff --git a/trace2/tr2_ctr.c b/trace2/tr2_ctr.c
index 483ca7c308..22aae61f54 100644
--- a/trace2/tr2_ctr.c
+++ b/trace2/tr2_ctr.c
@@ -5,7 +5,7 @@
 #include "trace2/tr2_ctr.h"
 
 /*
- * A global counter block to aggregrate values from the partial sums
+ * A global counter block to aggregate values from the partial sums
  * from each thread.
  */
 static struct tr2_counter_block final_counter_block; /* access under tr2tls_mutex */
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index f9049805d4..a72dd54561 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -12,7 +12,7 @@
  */
 
 /*
- * Arbitry limit for thread names for column alignment.
+ * Arbitrary limit for thread names for column alignment.
  */
 #define TR2_MAX_THREAD_NAME (24)
 
-- 
2.39.0

