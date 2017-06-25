Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F35CC207D2
	for <e@80x24.org>; Sun, 25 Jun 2017 10:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbdFYKUu (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 06:20:50 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35235 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdFYKUq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 06:20:46 -0400
Received: by mail-lf0-f66.google.com with SMTP id n136so10452703lfn.2
        for <git@vger.kernel.org>; Sun, 25 Jun 2017 03:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gmHJNm1WrgoPkYlaVBLaM2Es+/NJA/yDZROQ1DPE7ig=;
        b=aeDZsCv5ykSQ7odhvea3/s54r89pakAiujHF0CJ+BFIpzEsNrtKYb8VPw7R99NzorF
         NGvzmhMU6gP/5MVSOeLX18tIzRbgVRL2M6bAmw5eFzpqubyXCWrhyZvUjQxqMUh8VTHC
         uxB1Z8Zz4ty6D5edkw8OeplhpT/iKikZ7vNGlSiyjS26iUWd1kvwQWrGXqHdMHwv0l+t
         sRCvLcXzGxlQ6QxICHowFJnqGETg200/FgCSR7/pGwD+s8i/OpfoNuJWq2ixlQGMajL2
         c3GYBQXM+R4hA1YTm6C1r4idH5qTuqLERJ+eqyP2yj8L+gj74mWsVy0WTnV7Zzpr4qm4
         ULqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=gmHJNm1WrgoPkYlaVBLaM2Es+/NJA/yDZROQ1DPE7ig=;
        b=fwz4cUeuuVAy+OrGCxDBb+vBWW/0GwkRfx0qPubmbzlrJTbtd2iuPe+AhQvsJTnPG7
         HzTlqNhEV7yNoYnp4+Q6azSW1N+Ol9fYzFA/yNtiSjidjySYrFZBMqJdaUbGsys1PC9w
         NDn/SIDlcEERW2x3qxlXoEb1wVNED4yq8Pbw2Zskzc3kqEU55mwQeMSrOEpbthksIfoU
         2BwddGvfFLJVmDd3JTg7O00L+Qr6OyheAd0+AdxYt5g0MKf/QMLFzmBDNn+zTMlpBXr0
         tnXN/GmQmoE/U0nlurh6DkoUz8VFrubs1sN24rXLGwmfj8/XIYzqw8Owcyp7r7Y5bhKL
         B+9Q==
X-Gm-Message-State: AKS2vOyp+fbljFGHBtL06BOIvs2AS8f4mc+yWEzSG1jlViSI3u1tVmB6
        Ojl3iZ+NpETcCFqWLUk=
X-Received: by 10.25.25.19 with SMTP id 19mr6034621lfz.109.1498386044010;
        Sun, 25 Jun 2017 03:20:44 -0700 (PDT)
Received: from viper.dy.fi (dtdxj8yfbbjt5c9yktgty-3.rev.dnainternet.fi. [2001:14ba:80e6:7e00:8109:e191:7408:8160])
        by smtp.gmail.com with ESMTPSA id 19sm2213585lju.69.2017.06.25.03.20.43
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jun 2017 03:20:43 -0700 (PDT)
From:   =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To:     git@vger.kernel.org
Subject: [PATCH] Spelling fixes
Date:   Sun, 25 Jun 2017 13:20:41 +0300
Message-Id: <20170625102041.32015-1-ville.skytta@iki.fi>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 Documentation/RelNotes/1.7.10.1.txt         |  2 +-
 Documentation/RelNotes/2.12.0.txt           |  2 +-
 Documentation/RelNotes/2.14.0.txt           |  2 +-
 Documentation/git-reset.txt                 |  2 +-
 Documentation/git-submodule.txt             |  2 +-
 abspath.c                                   |  2 +-
 builtin/grep.c                              |  2 +-
 compat/regex/regexec.c                      |  2 +-
 contrib/hooks/multimail/git_multimail.py    |  2 +-
 contrib/mw-to-git/git-remote-mediawiki.perl |  2 +-
 contrib/mw-to-git/t/README                  |  2 +-
 gitweb/gitweb.perl                          |  4 ++--
 mailinfo.c                                  | 16 ++++++++--------
 pathspec.c                                  |  2 +-
 perl/Git/I18N.pm                            |  2 +-
 refs.h                                      |  4 ++--
 send-pack.c                                 |  2 +-
 sha1dc/sha1.c                               |  2 +-
 submodule.c                                 |  4 ++--
 t/helper/test-strcmp-offset.c               |  2 +-
 t/t2203-add-intent.sh                       |  6 +++---
 t/t3070-wildmatch.sh                        |  2 +-
 t/t4213-log-tabexpand.sh                    |  2 +-
 t/t5614-clone-submodules-shallow.sh         |  4 ++--
 t/t6120-describe.sh                         |  2 +-
 t/t7412-submodule-absorbgitdirs.sh          |  2 +-
 t/t7413-submodule-is-active.sh              |  2 +-
 t/t9300-fast-import.sh                      |  2 +-
 28 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/Documentation/RelNotes/1.7.10.1.txt b/Documentation/RelNotes/1.7.10.1.txt
index be68524..71a86cb 100644
--- a/Documentation/RelNotes/1.7.10.1.txt
+++ b/Documentation/RelNotes/1.7.10.1.txt
@@ -69,7 +69,7 @@ Fixes since v1.7.10
  * The 'push to upstream' implementation was broken in some corner
    cases. "git push $there" without refspec, when the current branch
    is set to push to a remote different from $there, used to push to
-   $there using the upstream information to a remote unreleated to
+   $there using the upstream information to a remote unrelated to
    $there.
 
  * Giving "--continue" to a conflicted "rebase -i" session skipped a
diff --git a/Documentation/RelNotes/2.12.0.txt b/Documentation/RelNotes/2.12.0.txt
index 2915480..ef8b97d 100644
--- a/Documentation/RelNotes/2.12.0.txt
+++ b/Documentation/RelNotes/2.12.0.txt
@@ -264,7 +264,7 @@ notes for details).
    needed it so far.
 
  * Git 2.11 had a minor regression in "merge --ff-only" that competed
-   with another process that simultanously attempted to update the
+   with another process that simultaneously attempted to update the
    index. We used to explain what went wrong with an error message,
    but the new code silently failed.  The error message has been
    resurrected.
diff --git a/Documentation/RelNotes/2.14.0.txt b/Documentation/RelNotes/2.14.0.txt
index f57a7ec..e47ec4e 100644
--- a/Documentation/RelNotes/2.14.0.txt
+++ b/Documentation/RelNotes/2.14.0.txt
@@ -54,7 +54,7 @@ UI, Workflows & Features
    even when the other side hasn't enabled allowTipSHA1InWant.
 
  * The recently introduced "[includeIf "gitdir:$dir"] path=..."
-   mechansim has further been taught to take symlinks into account.
+   mechanism has further been taught to take symlinks into account.
    The directory "$dir" specified in "gitdir:$dir" may be a symlink to
    a real location, not something that $(getcwd) may return.  In such
    a case, a realpath of "$dir" is compared with the real path of the
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 70f3753..1d697d9 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -294,7 +294,7 @@ $ git reset --keep start                    <3>
 
 Split a commit apart into a sequence of commits::
 +
-Suppose that you have created lots of logically separate changes and commited
+Suppose that you have created lots of logically separate changes and committed
 them together. Then, later you decide that it might be better to have each
 logical chunk associated with its own commit. You can use git reset to rewind
 history without changing the contents of your local files, and then successively
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 74bc620..2aea2c1 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -141,7 +141,7 @@ you can also just use `git submodule update --init` without
 the explicit 'init' step if you do not intend to customize
 any submodule locations.
 +
-See the add subcommand for the defintion of default remote.
+See the add subcommand for the definition of default remote.
 
 deinit [-f|--force] (--all|[--] <path>...)::
 	Unregister the given submodules, i.e. remove the whole
diff --git a/abspath.c b/abspath.c
index 7f1cfe9..708aff8 100644
--- a/abspath.c
+++ b/abspath.c
@@ -183,7 +183,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 
 			/*
 			 * use the symlink as the remaining components that
-			 * need to be resloved
+			 * need to be resolved
 			 */
 			strbuf_swap(&symlink, &remaining);
 		}
diff --git a/builtin/grep.c b/builtin/grep.c
index f61a9d9..f752f64 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -647,7 +647,7 @@ static int grep_submodule(struct grep_opt *opt, const struct object_id *oid,
 		return 0;
 	if (!is_submodule_populated_gently(path, NULL)) {
 		/*
-		 * If searching history, check for the presense of the
+		 * If searching history, check for the presence of the
 		 * submodule's gitdir before skipping the submodule.
 		 */
 		if (oid) {
diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index eb5e1d4..0a745d9 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -4102,7 +4102,7 @@ extend_buffers (re_match_context_t *mctx)
   if (BE (INT_MAX / 2 / sizeof (re_dfastate_t *) <= pstr->bufs_len, 0))
     return REG_ESPACE;
 
-  /* Double the lengthes of the buffers.  */
+  /* Double the lengths of the buffers.  */
   ret = re_string_realloc_buffers (pstr, pstr->bufs_len * 2);
   if (BE (ret != REG_NOERROR, 0))
     return ret;
diff --git a/contrib/hooks/multimail/git_multimail.py b/contrib/hooks/multimail/git_multimail.py
index c7f8640..73fdda6 100755
--- a/contrib/hooks/multimail/git_multimail.py
+++ b/contrib/hooks/multimail/git_multimail.py
@@ -2964,7 +2964,7 @@ class StaticRecipientsEnvironmentMixin(Environment):
 
 
 class CLIRecipientsEnvironmentMixin(Environment):
-    """Mixin storing recipients information comming from the
+    """Mixin storing recipients information coming from the
     command-line."""
 
     def __init__(self, cli_recipients=None, **kw):
diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 41e74fb..e7f857c 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -857,7 +857,7 @@ sub mw_import_revids {
 
 	my $n = 0;
 	my $n_actual = 0;
-	my $last_timestamp = 0; # Placeholer in case $rev->timestamp is undefined
+	my $last_timestamp = 0; # Placeholder in case $rev->timestamp is undefined
 
 	foreach my $pagerevid (@{$revision_ids}) {
 	        # Count page even if we skip it, since we display
diff --git a/contrib/mw-to-git/t/README b/contrib/mw-to-git/t/README
index 03f6ee5..2ee34be 100644
--- a/contrib/mw-to-git/t/README
+++ b/contrib/mw-to-git/t/README
@@ -121,4 +121,4 @@ How to write a new test
 
 Please, follow the standards given by git. See git/t/README.
 New file should be named as t936[0-9]-*.sh.
-Be sure to reset your wiki regulary with the function `wiki_reset`.
+Be sure to reset your wiki regularly with the function `wiki_reset`.
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d8209c7..3d4a8ee 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3125,7 +3125,7 @@ sub git_get_projects_list {
 	return @list;
 }
 
-# written with help of Tree::Trie module (Perl Artistic License, GPL compatibile)
+# written with help of Tree::Trie module (Perl Artistic License, GPL compatible)
 # as side effects it sets 'forks' field to list of forks for forked projects
 sub filter_forks_from_projects_list {
 	my $projects = shift;
@@ -4376,7 +4376,7 @@ sub git_print_page_nav {
 	      "</div>\n";
 }
 
-# returns a submenu for the nagivation of the refs views (tags, heads,
+# returns a submenu for the navigation of the refs views (tags, heads,
 # remotes) with the current view disabled and the remotes view only
 # available if the feature is enabled
 sub format_ref_views {
diff --git a/mailinfo.c b/mailinfo.c
index 1652ec1..bd574cb 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -58,17 +58,17 @@ static void parse_bogus_from(struct mailinfo *mi, const struct strbuf *line)
 static const char *unquote_comment(struct strbuf *outbuf, const char *in)
 {
 	int c;
-	int take_next_litterally = 0;
+	int take_next_literally = 0;
 
 	strbuf_addch(outbuf, '(');
 
 	while ((c = *in++) != 0) {
-		if (take_next_litterally == 1) {
-			take_next_litterally = 0;
+		if (take_next_literally == 1) {
+			take_next_literally = 0;
 		} else {
 			switch (c) {
 			case '\\':
-				take_next_litterally = 1;
+				take_next_literally = 1;
 				continue;
 			case '(':
 				in = unquote_comment(outbuf, in);
@@ -88,15 +88,15 @@ static const char *unquote_comment(struct strbuf *outbuf, const char *in)
 static const char *unquote_quoted_string(struct strbuf *outbuf, const char *in)
 {
 	int c;
-	int take_next_litterally = 0;
+	int take_next_literally = 0;
 
 	while ((c = *in++) != 0) {
-		if (take_next_litterally == 1) {
-			take_next_litterally = 0;
+		if (take_next_literally == 1) {
+			take_next_literally = 0;
 		} else {
 			switch (c) {
 			case '\\':
-				take_next_litterally = 1;
+				take_next_literally = 1;
 				continue;
 			case '"':
 				return in;
diff --git a/pathspec.c b/pathspec.c
index a5f4df3..e2a23eb 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -606,7 +606,7 @@ void parse_pathspec(struct pathspec *pathspec,
 
 	/*
 	 * If everything is an exclude pattern, add one positive pattern
-	 * that matches everyting. We allocated an extra one for this.
+	 * that matches everything. We allocated an extra one for this.
 	 */
 	if (nr_exclude == n) {
 		int plen = (!(flags & PATHSPEC_PREFER_CWD)) ? 0 : prefixlen;
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index c41425c..836a5c2 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -74,7 +74,7 @@ Git::I18N - Perl interface to Git's Gettext localizations
 
 	printf __("The following error occurred: %s\n"), $error;
 
-	printf __n("commited %d file\n", "commited %d files\n", $files), $files;
+	printf __n("committed %d file\n", "committed %d files\n", $files), $files;
 
 
 =head1 DESCRIPTION
diff --git a/refs.h b/refs.h
index 4be14c4..a24f596 100644
--- a/refs.h
+++ b/refs.h
@@ -571,7 +571,7 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 #define TRANSACTION_GENERIC_ERROR -2
 
 /*
- * Perform the preparatory stages of commiting `transaction`. Acquire
+ * Perform the preparatory stages of committing `transaction`. Acquire
  * any needed locks, check preconditions, etc.; basically, do as much
  * as possible to ensure that the transaction will be able to go
  * through, stopping just short of making any irrevocable or
@@ -583,7 +583,7 @@ int ref_transaction_verify(struct ref_transaction *transaction,
  * On failure, abort the transaction, write an error message to `err`,
  * and return one of the `TRANSACTION_*` constants.
  *
- * Callers who don't need such fine-grained control over commiting
+ * Callers who don't need such fine-grained control over committing
  * reference transactions should just call `ref_transaction_commit()`.
  */
 int ref_transaction_prepare(struct ref_transaction *transaction,
diff --git a/send-pack.c b/send-pack.c
index ed3cee3..11d6f3d 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -133,7 +133,7 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *extra, struc
 		 * For a normal non-zero exit, we assume pack-objects wrote
 		 * something useful to stderr. For death by signal, though,
 		 * we should mention it to the user. The exception is SIGPIPE
-		 * (141), because that's a normal occurence if the remote end
+		 * (141), because that's a normal occurrence if the remote end
 		 * hangs up (and we'll report that by trying to read the unpack
 		 * status).
 		 */
diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index facea1b..3a1735e 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -918,7 +918,7 @@ static void sha1recompress_fast_ ## t (uint32_t ihvin[5], uint32_t ihvout[5], co
 
 #ifdef _MSC_VER
 #pragma warning(push)
-#pragma warning(disable: 4127)  /* Complier complains about the checks in the above macro being constant. */
+#pragma warning(disable: 4127)  /* Compiler complains about the checks in the above macro being constant. */
 #endif
 
 #ifdef DOSTORESTATE0
diff --git a/submodule.c b/submodule.c
index da0b805..71e0c5a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -846,9 +846,9 @@ static int submodule_has_commits(const char *path, struct oid_array *commits)
 	int has_commit = 1;
 
 	/*
-	 * Perform a cheap, but incorrect check for the existance of 'commits'.
+	 * Perform a cheap, but incorrect check for the existence of 'commits'.
 	 * This is done by adding the submodule's object store to the in-core
-	 * object store, and then querying for each commit's existance.  If we
+	 * object store, and then querying for each commit's existence.  If we
 	 * do not have the commit object anywhere, there is no chance we have
 	 * it in the object store of the correct submodule and have it
 	 * reachable from a ref, so we can fail early without spawning rev-list
diff --git a/t/helper/test-strcmp-offset.c b/t/helper/test-strcmp-offset.c
index 4a45a54..e159c9a 100644
--- a/t/helper/test-strcmp-offset.c
+++ b/t/helper/test-strcmp-offset.c
@@ -11,7 +11,7 @@ int cmd_main(int argc, const char **argv)
 	result = strcmp_offset(argv[1], argv[2], &offset);
 
 	/*
-	 * Because differnt CRTs behave differently, only rely on signs
+	 * Because different CRTs behave differently, only rely on signs
 	 * of the result values.
 	 */
 	result = (result < 0 ? -1 :
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 84a9028..1bdf38e 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -129,10 +129,10 @@ test_expect_success 'cache-tree does skip dir that becomes empty' '
 	)
 '
 
-test_expect_success 'commit: ita entries ignored in empty intial commit check' '
-	git init empty-intial-commit &&
+test_expect_success 'commit: ita entries ignored in empty initial commit check' '
+	git init empty-initial-commit &&
 	(
-		cd empty-intial-commit &&
+		cd empty-initial-commit &&
 		: >one &&
 		git add -N one &&
 		test_must_fail git commit -m nothing-new-here
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 8fd70d3..163a14a 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -235,7 +235,7 @@ pathmatch 1 abcXdefXghi '*X*i'
 pathmatch 1 ab/cXd/efXg/hi '*/*X*/*/*i'
 pathmatch 1 ab/cXd/efXg/hi '*Xg*i'
 
-# Case-sensitivy features
+# Case-sensitivity features
 match 0 x 'a' '[A-Z]'
 match 1 x 'A' '[A-Z]'
 match 0 x 'A' '[a-z]'
diff --git a/t/t4213-log-tabexpand.sh b/t/t4213-log-tabexpand.sh
index e01a8f6..7f90f58 100755
--- a/t/t4213-log-tabexpand.sh
+++ b/t/t4213-log-tabexpand.sh
@@ -37,7 +37,7 @@ count_expand ()
 
 	# Prefix the output with the command line arguments, and
 	# replace SP with a dot both in the expecte and actual output
-	# so that test_cmp would show the differene together with the
+	# so that test_cmp would show the difference together with the
 	# breakage in a way easier to consume by the debugging user.
 	{
 		echo "git show -s $*"
diff --git a/t/t5614-clone-submodules-shallow.sh b/t/t5614-clone-submodules-shallow.sh
index a87d329..e4e6ea4 100755
--- a/t/t5614-clone-submodules-shallow.sh
+++ b/t/t5614-clone-submodules-shallow.sh
@@ -71,7 +71,7 @@ test_expect_success 'clone follows shallow recommendation' '
 	test_when_finished "rm -rf super_clone" &&
 	git config -f .gitmodules submodule.sub.shallow true &&
 	git add .gitmodules &&
-	git commit -m "recommed shallow for sub" &&
+	git commit -m "recommend shallow for sub" &&
 	git clone --recurse-submodules --no-local "file://$pwd/." super_clone &&
 	(
 		cd super_clone &&
@@ -105,7 +105,7 @@ test_expect_success 'clone follows non shallow recommendation' '
 	test_when_finished "rm -rf super_clone" &&
 	git config -f .gitmodules submodule.sub.shallow false &&
 	git add .gitmodules &&
-	git commit -m "recommed non shallow for sub" &&
+	git commit -m "recommend non shallow for sub" &&
 	git clone --recurse-submodules --no-local "file://$pwd/." super_clone &&
 	(
 		cd super_clone &&
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 16952e4..aa74eb8 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -244,7 +244,7 @@ test_expect_success 'setup and absorb a submodule' '
 	test_cmp expect out
 '
 
-test_expect_success 'describe chokes on severly broken submodules' '
+test_expect_success 'describe chokes on severely broken submodules' '
 	mv .git/modules/sub1/ .git/modules/sub_moved &&
 	test_must_fail git describe --dirty
 '
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index e2bbb44..ce74c12 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -33,7 +33,7 @@ test_expect_success 'absorb the git dir' '
 	test_cmp expect.2 actual.2
 '
 
-test_expect_success 'absorbing does not fail for deinitalized submodules' '
+test_expect_success 'absorbing does not fail for deinitialized submodules' '
 	test_when_finished "git submodule update --init" &&
 	git submodule deinit --all &&
 	git submodule absorbgitdirs &&
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index 9c785b0..c8e7e98 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -2,7 +2,7 @@
 
 test_description='Test submodule--helper is-active
 
-This test verifies that `git submodue--helper is-active` correclty identifies
+This test verifies that `git submodue--helper is-active` correctly identifies
 submodules which are "active" and interesting to the user.
 '
 
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2e0ba3e..67b8c50 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2822,7 +2822,7 @@ test_expect_success 'S: filemodify with garbage after sha1 must fail' '
 #
 # notemodify, three ways to say dataref
 #
-test_expect_success 'S: notemodify with garabge after mark dataref must fail' '
+test_expect_success 'S: notemodify with garbage after mark dataref must fail' '
 	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
 	commit refs/heads/S
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-- 
2.9.4

