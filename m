From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH] Various typofixes
Date: Thu, 11 Apr 2013 22:55:59 +0200
Message-ID: <4cb23e38819d620f53be032d0765fbe374ddb717.1365712583.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 22:56:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQOXo-0003V9-FA
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 22:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986Ab3DKU4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 16:56:20 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:39774 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932221Ab3DKU4M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 16:56:12 -0400
Received: by mail-ee0-f53.google.com with SMTP id c13so935812eek.26
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 13:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=G6uRPLhZcEb5t8+/Ql24ihTN7qNJZhO+DxbkWhVGGCM=;
        b=P37ippIrUfWfJgyFahQNlTusMBQFmts2Jiv3WxOZQgAAuTxuYAQbguves9QvwouQ36
         v7x0BUemdeHnCUV23dnbJfrOtPfGFG2qLV87/uHnZl+SXRfF8EcaDNMm3sCxmopGRL1U
         Clk58EHvi722ozyFkBPyuTC53AjrQBoipOgIqiT9PKBK1GakRojqFri48dZtwc7gqFMr
         RWTaAX4JurF00BiSg50FSZoZvZw/T1K6T86USk8mY8H+YZNJFjdHJx3yQ0OLdpdyMLTG
         i5XWYbR6FdSDyhuRK7ICxorI2JSpdJwwWS4ZFQ9m3TUWiP0gPWREf1Gm0meLZImawPi0
         2aeQ==
X-Received: by 10.14.182.137 with SMTP id o9mr20620815eem.13.1365713770652;
        Thu, 11 Apr 2013 13:56:10 -0700 (PDT)
Received: from localhost.localdomain (host93-95-dynamic.6-79-r.retail.telecomitalia.it. [79.6.95.93])
        by mx.google.com with ESMTPS id r48sm3016892eeg.2.2013.04.11.13.56.07
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 13:56:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.373.g961c512
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220927>

Mostly suggested by codespell <https://github.com/lucasdemarchi/codespell>

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 Documentation/git-credential.txt                   |  2 +-
 Documentation/git-remote-ext.txt                   |  2 +-
 Documentation/git-svn.txt                          |  4 ++--
 Documentation/git-tools.txt                        |  2 +-
 Documentation/revisions.txt                        |  2 +-
 Documentation/technical/api-argv-array.txt         |  2 +-
 Documentation/technical/api-credentials.txt        |  2 +-
 Documentation/technical/api-ref-iteration.txt      |  2 +-
 builtin/apply.c                                    |  6 +++---
 commit.c                                           |  2 +-
 commit.h                                           |  2 +-
 compat/nedmalloc/Readme.txt                        |  2 +-
 compat/nedmalloc/malloc.c.h                        |  6 +++---
 compat/obstack.h                                   |  2 +-
 compat/precompose_utf8.c                           |  2 +-
 compat/regex/regcomp.c                             |  4 ++--
 compat/regex/regex.c                               |  2 +-
 compat/regex/regex_internal.c                      |  6 +++---
 contrib/mw-to-git/git-remote-mediawiki.perl        |  6 +++---
 contrib/mw-to-git/t/README                         |  6 +++---
 contrib/mw-to-git/t/install-wiki/LocalSettings.php |  2 +-
 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh       |  2 +-
 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh        | 10 +++++-----
 contrib/subtree/t/t7900-subtree.sh                 |  2 +-
 diff.c                                             |  2 +-
 git-add--interactive.perl                          |  2 +-
 git-cvsserver.perl                                 |  4 ++--
 git-gui/lib/blame.tcl                              |  2 +-
 git-gui/lib/index.tcl                              |  2 +-
 git-gui/lib/spellcheck.tcl                         |  4 ++--
 git-quiltimport.sh                                 |  2 +-
 gitweb/INSTALL                                     |  2 +-
 gitweb/gitweb.perl                                 |  6 +++---
 kwset.c                                            |  4 ++--
 perl/Git.pm                                        |  2 +-
 perl/Git/I18N.pm                                   |  2 +-
 perl/private-Error.pm                              |  2 +-
 po/README                                          |  6 +++---
 sequencer.c                                        |  2 +-
 t/t1006-cat-file.sh                                |  2 +-
 t/t3511-cherry-pick-x.sh                           |  4 ++--
 t/t3701-add-interactive.sh                         |  2 +-
 t/t4014-format-patch.sh                            |  6 +++---
 t/t4124-apply-ws-rule.sh                           |  2 +-
 t/t6030-bisect-porcelain.sh                        |  2 +-
 t/t7601-merge-pull-config.sh                       |  2 +-
 t/t7610-mergetool.sh                               |  2 +-
 t/t9001-send-email.sh                              |  4 ++--
 transport-helper.c                                 |  2 +-
 transport.h                                        |  2 +-
 xdiff/xdiffi.c                                     |  2 +-
 xdiff/xhistogram.c                                 |  2 +-
 52 files changed, 79 insertions(+), 79 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 472f00f..7da0f13 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -56,7 +56,7 @@ For example, if we want a password for
 `https://example.com/foo.git`, we might generate the following
 credential description (don't forget the blank line at the end; it
 tells `git credential` that the application finished feeding all the
-infomation it has):
+information it has):
 
 	 protocol=https
 	 host=example.com
diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
index 58b7fac..8cfc748 100644
--- a/Documentation/git-remote-ext.txt
+++ b/Documentation/git-remote-ext.txt
@@ -86,7 +86,7 @@ begins with `ext::`.  Examples:
 	edit .ssh/config.
 
 "ext::socat -t3600 - ABSTRACT-CONNECT:/git-server %G/somerepo"::
-	Represents repository with path /somerepo accessable over
+	Represents repository with path /somerepo accessible over
 	git protocol at abstract namespace address /git-server.
 
 "ext::git-server-alias foo %G/repo"::
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 1b8b649..7706d41 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -245,7 +245,7 @@ first have already been pushed into SVN.
 	patch), "all" (accept all patches), or "quit".
 	+
 	'git svn dcommit' returns immediately if answer if "no" or "quit", without
-	commiting anything to SVN.
+	committing anything to SVN.
 
 'branch'::
 	Create a branch in the SVN repository.
@@ -856,7 +856,7 @@ HANDLING OF SVN BRANCHES
 ------------------------
 If 'git svn' is configured to fetch branches (and --follow-branches
 is in effect), it sometimes creates multiple Git branches for one
-SVN branch, where the addtional branches have names of the form
+SVN branch, where the additional branches have names of the form
 'branchname@nnn' (with nnn an SVN revision number).  These additional
 branches are created if 'git svn' cannot find a parent commit for the
 first commit in an SVN branch, to connect the branch to the history of
diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
index ad8b823..78a0d95 100644
--- a/Documentation/git-tools.txt
+++ b/Documentation/git-tools.txt
@@ -109,7 +109,7 @@ Others
 
    - *git.el* (contrib/)
 
-   This is an Emacs interface for Git. The user interface is modeled on
+   This is an Emacs interface for Git. The user interface is modelled on
    pcl-cvs. It has been developed on Emacs 21 and will probably need some
    tweaking to work on XEmacs.
 
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 1707d45..8855b1a 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -55,7 +55,7 @@ when you run `git cherry-pick`.
 +
 Note that any of the 'refs/*' cases above may come either from
 the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
-While the ref name encoding is unspecified, UTF-8 is prefered as
+While the ref name encoding is unspecified, UTF-8 is preferred as
 some output processing may assume ref names in UTF-8.
 
 '<refname>@\{<date>\}', e.g. 'master@\{yesterday\}', 'HEAD@\{5 minutes ago\}'::
diff --git a/Documentation/technical/api-argv-array.txt b/Documentation/technical/api-argv-array.txt
index a959517..a6b7d83 100644
--- a/Documentation/technical/api-argv-array.txt
+++ b/Documentation/technical/api-argv-array.txt
@@ -55,7 +55,7 @@ Functions
 	initial, empty state.
 
 `argv_array_detach`::
-	Detach the argv array from the `struct argv_array`, transfering
+	Detach the argv array from the `struct argv_array`, transferring
 	ownership of the allocated array and strings.
 
 `argv_array_free_detached`::
diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index 516fda7..c1b42a4 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -160,7 +160,7 @@ int foo_login(struct foo_connection *f)
 		break;
 	default:
 		/*
-		 * Some other error occured. We don't know if the
+		 * Some other error occurred. We don't know if the
 		 * credential is good or bad, so report nothing to the
 		 * credential subsystem.
 		 */
diff --git a/Documentation/technical/api-ref-iteration.txt b/Documentation/technical/api-ref-iteration.txt
index dbbea95..aa1c50f 100644
--- a/Documentation/technical/api-ref-iteration.txt
+++ b/Documentation/technical/api-ref-iteration.txt
@@ -35,7 +35,7 @@ Iteration functions
 * `head_ref_submodule()`, `for_each_ref_submodule()`,
   `for_each_ref_in_submodule()`, `for_each_tag_ref_submodule()`,
   `for_each_branch_ref_submodule()`, `for_each_remote_ref_submodule()`
-  do the same as the functions descibed above but for a specified
+  do the same as the functions described above but for a specified
   submodule.
 
 * `for_each_rawref()` can be used to learn about broken ref and symref.
diff --git a/builtin/apply.c b/builtin/apply.c
index 5b882d0..30eefc3 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1921,7 +1921,7 @@ static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
 }
 
 /*
- * Read the patch text in "buffer" taht extends for "size" bytes; stop
+ * Read the patch text in "buffer" that extends for "size" bytes; stop
  * reading after seeing a single patch (i.e. changes to a single file).
  * Create fragments (i.e. patch hunks) and hang them to the given patch.
  * Return the number of bytes consumed, so that the caller can call us
@@ -3029,7 +3029,7 @@ static struct patch *in_fn_table(const char *name)
  *
  * The latter is needed to deal with a case where two paths A and B
  * are swapped by first renaming A to B and then renaming B to A;
- * moving A to B should not be prevented due to presense of B as we
+ * moving A to B should not be prevented due to presence of B as we
  * will remove it in a later patch.
  */
 #define PATH_TO_BE_DELETED ((struct patch *) -2)
@@ -3513,7 +3513,7 @@ static int check_patch(struct patch *patch)
 	 *
 	 * A patch to swap-rename between A and B would first rename A
 	 * to B and then rename B to A.  While applying the first one,
-	 * the presense of B should not stop A from getting renamed to
+	 * the presence of B should not stop A from getting renamed to
 	 * B; ask to_be_deleted() about the later rename.  Removal of
 	 * B and rename from A to B is handled the same way by asking
 	 * was_deleted().
diff --git a/commit.c b/commit.c
index 516a4ff..888e02a 100644
--- a/commit.c
+++ b/commit.c
@@ -841,7 +841,7 @@ struct commit_list *get_merge_bases(struct commit *one, struct commit *two,
 }
 
 /*
- * Is "commit" a decendant of one of the elements on the "with_commit" list?
+ * Is "commit" a descendant of one of the elements on the "with_commit" list?
  */
 int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
 {
diff --git a/commit.h b/commit.h
index 87b4b6c..057ff80 100644
--- a/commit.h
+++ b/commit.h
@@ -166,7 +166,7 @@ extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *r
 extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struct commit **twos, int cleanup);
 extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
-/* largest postive number a signed 32-bit integer can contain */
+/* largest positive number a signed 32-bit integer can contain */
 #define INFINITE_DEPTH 0x7fffffff
 
 extern int register_shallow(const unsigned char *sha1);
diff --git a/compat/nedmalloc/Readme.txt b/compat/nedmalloc/Readme.txt
index e46d8f1..07cbf50 100644
--- a/compat/nedmalloc/Readme.txt
+++ b/compat/nedmalloc/Readme.txt
@@ -97,7 +97,7 @@ Chew for reporting this.
 
 v1.04alpha_svn915 7th October 2006:
  * Fixed failure to unlock thread cache list if allocating a new list failed.
-Thanks to Dmitry Chichkov for reporting this. Futher thanks to Aleksey Sanin.
+Thanks to Dmitry Chichkov for reporting this. Further thanks to Aleksey Sanin.
  * Fixed realloc(0, <size>) segfaulting. Thanks to Dmitry Chichkov for
 reporting this.
  * Made config defines #ifndef so they can be overridden by the build system.
diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index ff7c2c4..1401a67 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -4778,7 +4778,7 @@ void* dlmalloc(size_t bytes) {
 
 void dlfree(void* mem) {
   /*
-     Consolidate freed chunks with preceeding or succeeding bordering
+     Consolidate freed chunks with preceding or succeeding bordering
      free chunks, if they exist, and then place in a bin.  Intermixed
      with special cases for top, dv, mmapped chunks, and usage errors.
   */
@@ -5680,10 +5680,10 @@ History:
 	Wolfram Gloger (Gloger@lrz.uni-muenchen.de).
       * Use last_remainder in more cases.
       * Pack bins using idea from  colin@nyx10.cs.du.edu
-      * Use ordered bins instead of best-fit threshhold
+      * Use ordered bins instead of best-fit threshold
       * Eliminate block-local decls to simplify tracing and debugging.
       * Support another case of realloc via move into top
-      * Fix error occuring when initial sbrk_base not word-aligned.
+      * Fix error occurring when initial sbrk_base not word-aligned.
       * Rely on page size for units instead of SBRK_UNIT to
 	avoid surprises about sbrk alignment conventions.
       * Add mallinfo, mallopt. Thanks to Raymond Nijssen
diff --git a/compat/obstack.h b/compat/obstack.h
index d178bd6..ceb4bdb 100644
--- a/compat/obstack.h
+++ b/compat/obstack.h
@@ -128,7 +128,7 @@ extern "C" {
 
 #define __BPTR_ALIGN(B, P, A) ((B) + (((P) - (B) + (A)) & ~(A)))
 
-/* Similiar to _BPTR_ALIGN (B, P, A), except optimize the common case
+/* Similar to _BPTR_ALIGN (B, P, A), except optimize the common case
    where pointers can be converted to integers, aligned as integers,
    and converted back again.  If PTR_INT_TYPE is narrower than a
    pointer (e.g., the AS/400), play it safe and compute the alignment
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 8cf5955..030174d 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -134,7 +134,7 @@ struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
 			if (prec_dir->ic_precompose == (iconv_t)-1) {
 				die("iconv_open(%s,%s) failed, but needed:\n"
 						"    precomposed unicode is not supported.\n"
-						"    If you wnat to use decomposed unicode, run\n"
+						"    If you want to use decomposed unicode, run\n"
 						"    \"git config core.precomposeunicode false\"\n",
 						repo_encoding, path_encoding);
 			} else {
diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 8c96ed9..aab8153 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -2095,7 +2095,7 @@ peek_token_bracket (re_token_t *token, re_string_t *input, reg_syntax_t syntax)
 
 /* Entry point of the parser.
    Parse the regular expression REGEXP and return the structure tree.
-   If an error is occured, ERR is set by error code, and return NULL.
+   If an error is occurred, ERR is set by error code, and return NULL.
    This function build the following tree, from regular expression <reg_exp>:
 	   CAT
 	   / \
@@ -3715,7 +3715,7 @@ build_charclass_op (re_dfa_t *dfa, RE_TRANSLATE_TYPE trans,
 /* This is intended for the expressions like "a{1,3}".
    Fetch a number from `input', and return the number.
    Return -1, if the number field is empty like "{,1}".
-   Return -2, If an error is occured.  */
+   Return -2, If an error is occurred.  */
 
 static int
 fetch_number (re_string_t *input, re_token_t *token, reg_syntax_t syntax)
diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index 3dd8dfa..6aaae00 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -22,7 +22,7 @@
 #include "config.h"
 #endif
 
-/* Make sure noone compiles this code with a C++ compiler.  */
+/* Make sure no one compiles this code with a C++ compiler.  */
 #ifdef __cplusplus
 # error "This is C code, use a C compiler"
 #endif
diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
index 193854c..237642c 100644
--- a/compat/regex/regex_internal.c
+++ b/compat/regex/regex_internal.c
@@ -1284,7 +1284,7 @@ re_node_set_merge (re_node_set *dest, const re_node_set *src)
 
 /* Insert the new element ELEM to the re_node_set* SET.
    SET should not already have ELEM.
-   return -1 if an error is occured, return 1 otherwise.  */
+   return -1 if an error is occurred, return 1 otherwise.  */
 
 static int
 internal_function
@@ -1341,7 +1341,7 @@ re_node_set_insert (re_node_set *set, int elem)
 
 /* Insert the new element ELEM to the re_node_set* SET.
    SET should not already have any element greater than or equal to ELEM.
-   Return -1 if an error is occured, return 1 otherwise.  */
+   Return -1 if an error is occurred, return 1 otherwise.  */
 
 static int
 internal_function
@@ -1416,7 +1416,7 @@ re_node_set_remove_at (re_node_set *set, int idx)
 
 
 /* Add the token TOKEN to dfa->nodes, and return the index of the token.
-   Or return -1, if an error will be occured.  */
+   Or return -1, if an error will be occurred.  */
 
 static int
 internal_function
diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 094129d..9c14c1f 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -28,7 +28,7 @@ use warnings;
 use constant SLASH_REPLACEMENT => "%2F";
 
 # It's not always possible to delete pages (may require some
-# priviledges). Deleted pages are replaced with this content.
+# privileges). Deleted pages are replaced with this content.
 use constant DELETED_CONTENT => "[[Category:Deleted]]\n";
 
 # It's not possible to create empty pages. New empty files in Git are
@@ -841,7 +841,7 @@ sub mw_import_ref {
 	if ($fetch_from == 1 && $n == 0) {
 		print STDERR "You appear to have cloned an empty MediaWiki.\n";
 		# Something has to be done remote-helper side. If nothing is done, an error is
-		# thrown saying that HEAD is refering to unknown object 0000000000000000000
+		# thrown saying that HEAD is referring to unknown object 0000000000000000000
 		# and the clone fails.
 	}
 }
@@ -1067,7 +1067,7 @@ sub mw_push_file {
 		my $file_content;
 		if ($page_deleted) {
 			# Deleting a page usually requires
-			# special priviledges. A common
+			# special privileges. A common
 			# convention is to replace the page
 			# with this content instead:
 			$file_content = DELETED_CONTENT;
diff --git a/contrib/mw-to-git/t/README b/contrib/mw-to-git/t/README
index 96e9739..03f6ee5 100644
--- a/contrib/mw-to-git/t/README
+++ b/contrib/mw-to-git/t/README
@@ -25,7 +25,7 @@ Principles and Technical Choices
 
 The test environment makes it easy to install and manipulate one or
 several MediaWiki instances. To allow developers to run the testsuite
-easily, the environment does not require root priviledge (except to
+easily, the environment does not require root privilege (except to
 install the required packages if needed). It starts a webserver
 instance on the user's account (using lighttpd greatly helps for
 that), and does not need a separate database daemon (thanks to the use
@@ -81,7 +81,7 @@ parameters, please refer to the `test-gitmw-lib.sh` and
 
 ** `test_check_wiki_precond`:
 Check if the tests must be skipped or not. Please use this function
-at the beggining of each new test file.
+at the beginning of each new test file.
 
 ** `wiki_getpage`:
 Fetch a given page from the wiki and puts its content in the
@@ -113,7 +113,7 @@ Tests if a given page exists on the wiki.
 
 ** `wiki_reset`:
 Reset the wiki, i.e. flush the database. Use this function at the
-begining of each new test, except if the test re-uses the same wiki
+beginning of each new test, except if the test re-uses the same wiki
 (and history) as the previous test.
 
 How to write a new test
diff --git a/contrib/mw-to-git/t/install-wiki/LocalSettings.php b/contrib/mw-to-git/t/install-wiki/LocalSettings.php
index 29f1251..745e47e 100644
--- a/contrib/mw-to-git/t/install-wiki/LocalSettings.php
+++ b/contrib/mw-to-git/t/install-wiki/LocalSettings.php
@@ -88,7 +88,7 @@ $wgShellLocale = "en_US.utf8";
 
 ## Set $wgCacheDirectory to a writable directory on the web server
 ## to make your wiki go slightly faster. The directory should not
-## be publically accessible from the web.
+## be publicly accessible from the web.
 #$wgCacheDirectory = "$IP/cache";
 
 # Site language code, should be one of the list in ./languages/Names.php
diff --git a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
index 811a90c..a54621c 100755
--- a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
+++ b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
@@ -125,7 +125,7 @@ test_expect_success 'Git clone works with one specific page cloned ' '
 	wiki_editpage foo "I will not be cloned" false &&
 	wiki_editpage bar "Do not clone me" false &&
 	wiki_editpage namnam "I will be cloned :)" false  -s="this log must stay" &&
-	wiki_editpage nyancat "nyan nyan nyan you cant clone me" false &&
+	wiki_editpage nyancat "nyan nyan nyan you cannot clone me" false &&
 	git clone -c remote.origin.pages=namnam \
 		mediawiki::'"$WIKI_URL"' mw_dir_8 &&
 	test_contains_N_files mw_dir_8 1 &&
diff --git a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh b/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
index b6405ce..e764ddc 100755
--- a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
+++ b/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
@@ -139,7 +139,7 @@ test_expect_success 'character $ in file name (git -> mw) ' '
 '
 
 
-test_expect_failure 'capital at the begining of file names' '
+test_expect_failure 'capital at the beginning of file names' '
 	wiki_reset &&
 	git clone mediawiki::'"$WIKI_URL"' mw_dir_10 &&
 	(
@@ -156,7 +156,7 @@ test_expect_failure 'capital at the begining of file names' '
 '
 
 
-test_expect_failure 'special character at the begining of file name from mw to git' '
+test_expect_failure 'special character at the beginning of file name from mw to git' '
 	wiki_reset &&
 	git clone mediawiki::'"$WIKI_URL"' mw_dir_11 &&
 	wiki_editpage {char_1 "expect to be renamed {char_1" false &&
@@ -207,7 +207,7 @@ test_expect_success 'test of correct formating for file name from mw to git' '
 '
 
 
-test_expect_failure 'test of correct formating for file name begining with special character' '
+test_expect_failure 'test of correct formating for file name beginning with special character' '
 	wiki_reset &&
 	git clone mediawiki::'"$WIKI_URL"' mw_dir_13 &&
 	(
@@ -215,7 +215,7 @@ test_expect_failure 'test of correct formating for file name begining with speci
 		echo "my new file {char_1" >\{char_1.mw &&
 		echo "my new file [char_2" >\[char_2.mw &&
 		git add . &&
-		git commit -am "commiting some exotic file name..." &&
+		git commit -am "committing some exotic file name..." &&
 		git push &&
 		git pull
 	) &&
@@ -234,7 +234,7 @@ test_expect_success 'test of correct formating for file name from git to mw' '
 		echo "my new file char{_1" >Char\{_1.mw &&
 		echo "my new file char[_2" >Char\[_2.mw &&
 		git add . &&
-		git commit -m "commiting some exotic file name..." &&
+		git commit -m "committing some exotic file name..." &&
 		git push
 	) &&
 	wiki_getallpage ref_page_14 &&
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 80d3399..4729521 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -419,7 +419,7 @@ test_expect_success 'add main-sub5' '
 test_expect_success 'split for main-sub5 without --onto' '
         # also test that we still can split out an entirely new subtree
         # if the parent of the first commit in the tree is not empty,
-        # then the new subtree has accidently been attached to something
+        # then the new subtree has accidentally been attached to something
         git subtree split --prefix subdir2 --branch mainsub5 &&
         check_equal ''"$(git log --pretty=format:%P -1 mainsub5)"'' ""
 '
diff --git a/diff.c b/diff.c
index db952a5..0eb2653 100644
--- a/diff.c
+++ b/diff.c
@@ -1565,7 +1565,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 * Binary files are displayed with "Bin XXX -> YYY bytes"
 	 * instead of the change count and graph. This part is treated
 	 * similarly to the graph part, except that it is not
-	 * "scaled". If total width is too small to accomodate the
+	 * "scaled". If total width is too small to accommodate the
 	 * guaranteed minimum width of the filename part and the
 	 * separators and this message, this message will "overflow"
 	 * making the line longer than the maximum width.
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 710764a..d2c4ce6 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1247,7 +1247,7 @@ sub summarize_hunk {
 
 
 # Print a one-line summary of each hunk in the array ref in
-# the first argument, starting wih the index in the 2nd.
+# the first argument, starting with the index in the 2nd.
 sub display_hunks {
 	my ($hunks, $i) = @_;
 	my $ctr = 0;
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index f1c3f49..a0d796e 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2911,7 +2911,7 @@ sub filenamesplit
 }
 
 # Cleanup various junk in filename (try to canonicalize it), and
-# add prependdir to accomodate running CVS client from a
+# add prependdir to accommodate running CVS client from a
 # subdirectory (so the output is relative to top directory of the project).
 sub filecleanup
 {
@@ -4583,7 +4583,7 @@ sub getmeta
     #     the numerical value of the corresponding byte plus
     #     100.
     #      - "plus 100" avoids "0"s, and also reduces the
-    #        likelyhood of a collision in the case that someone someday
+    #        likelihood of a collision in the case that someone someday
     #        writes an import tool that tries to preserve original
     #        CVS revision numbers, and the original CVS data had done
     #        lots of branches off of branches and other strangeness to
diff --git a/git-gui/lib/blame.tcl b/git-gui/lib/blame.tcl
index 324f774..b1d15f4 100644
--- a/git-gui/lib/blame.tcl
+++ b/git-gui/lib/blame.tcl
@@ -5,7 +5,7 @@ class blame {
 
 image create photo ::blame::img_back_arrow -data {R0lGODlhGAAYAIUAAPwCBEzKXFTSZIz+nGzmhGzqfGTidIT+nEzGXHTqhGzmfGzifFzadETCVES+VARWDFzWbHzyjAReDGTadFTOZDSyRDyyTCymPARaFGTedFzSbDy2TCyqRCyqPARaDAyCHES6VDy6VCyiPAR6HCSeNByWLARyFARiDARqFGTifARiFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAAYABgAAAajQIBwSCwaj8ikcsk0BppJwRPqHEypQwHBis0WDAdEFyBIKBaMAKLBdjQeSkFBYTBAIvgEoS6JmhUTEwIUDQ4VFhcMGEhyCgoZExoUaxsWHB0THkgfAXUGAhoBDSAVFR0XBnCbDRmgog0hpSIiDJpJIyEQhBUcJCIlwA22SSYVogknEg8eD82qSigdDSknY0IqJQXPYxIl1dZCGNvWw+Dm510GQQAh/mhDcmVhdGVkIGJ5IEJNUFRvR0lGIFBybyB2ZXJzaW9uIDIuNQ0KqSBEZXZlbENvciAxOTk3LDE5OTguIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQpodHRwOi8vd3d3LmRldmVsY29yLmNvbQA7}
 
-# Persistant data (survives loads)
+# Persistent data (survives loads)
 #
 field history {}; # viewer history: {commit path}
 field header    ; # array commit,key -> header field
diff --git a/git-gui/lib/index.tcl b/git-gui/lib/index.tcl
index 8efbbdd..74a81a7 100644
--- a/git-gui/lib/index.tcl
+++ b/git-gui/lib/index.tcl
@@ -414,7 +414,7 @@ proc revert_helper {txt paths} {
 	# such distinction is needed in some languages. Previously, the
 	# code used "Revert changes in" for both, but that can't work
 	# in languages where 'in' must be combined with word from
-	# rest of string (in diffrent way for both cases of course).
+	# rest of string (in different way for both cases of course).
 	#
 	# FIXME: Unfortunately, even that isn't enough in some languages
 	# as they have quite complex plural-form rules. Unfortunately,
diff --git a/git-gui/lib/spellcheck.tcl b/git-gui/lib/spellcheck.tcl
index e612030..538d61c 100644
--- a/git-gui/lib/spellcheck.tcl
+++ b/git-gui/lib/spellcheck.tcl
@@ -14,7 +14,7 @@ field w_menu      ; # context menu for the widget
 field s_menuidx 0 ; # last index of insertion into $w_menu
 
 field s_i           {} ; # timer registration for _run callbacks
-field s_clear        0 ; # did we erase mispelled tags yet?
+field s_clear        0 ; # did we erase misspelled tags yet?
 field s_seen    [list] ; # lines last seen from $w_text in _run
 field s_checked [list] ; # lines already checked
 field s_pending [list] ; # [$line $data] sent to ispell/aspell
@@ -259,7 +259,7 @@ method _run {} {
 		if {$n == $cur_line
 		 && ![regexp {^\W$} [$w_text get $cur_pos insert]]} {
 
-			# If the current word is mispelled remove the tag
+			# If the current word is misspelled remove the tag
 			# but force a spellcheck later.
 			#
 			set tags [$w_text tag names $cur_pos]
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 9a6ba2b..8e17525 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -59,7 +59,7 @@ tmp_patch="$tmp_dir/patch"
 tmp_info="$tmp_dir/info"
 
 
-# Find the intial commit
+# Find the initial commit
 commit=$(git rev-parse HEAD)
 
 mkdir $tmp_dir || exit 2
diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 6d45406..08f3dda 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -244,7 +244,7 @@ for gitweb (in gitweb/README), and gitweb.conf(5) manpage.
   through the GITWEB_CONFIG_SYSTEM environment variable.
 
   Note that if per-instance configuration file exists, then system-wide
-  configuration is _not used at all_.  This is quite untypical and suprising
+  configuration is _not used at all_.  This is quite untypical and surprising
   behavior.  On the other hand changing current behavior would break backwards
   compatibility and can lead to unexpected changes in gitweb behavior.
   Therefore gitweb also looks for common system-wide configuration file,
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1309196..80950c0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -683,7 +683,7 @@ sub evaluate_gitweb_config {
 	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
 	our $GITWEB_CONFIG_COMMON = $ENV{'GITWEB_CONFIG_COMMON'} || "++GITWEB_CONFIG_COMMON++";
 
-	# Protect agains duplications of file names, to not read config twice.
+	# Protect against duplications of file names, to not read config twice.
 	# Only one of $GITWEB_CONFIG and $GITWEB_CONFIG_SYSTEM is used, so
 	# there possibility of duplication of filename there doesn't matter.
 	$GITWEB_CONFIG = ""        if ($GITWEB_CONFIG eq $GITWEB_CONFIG_COMMON);
@@ -1136,7 +1136,7 @@ sub handle_errors_html {
 
 	# to avoid infinite loop where error occurs in die_error,
 	# change handler to default handler, disabling handle_errors_html
-	set_message("Error occured when inside die_error:\n$msg");
+	set_message("Error occurred when inside die_error:\n$msg");
 
 	# you cannot jump out of die_error when called as error handler;
 	# the subroutine set via CGI::Carp::set_message is called _after_
@@ -7485,7 +7485,7 @@ sub git_object {
 		system(git_cmd(), "cat-file", '-e', $hash_base) == 0
 			or die_error(404, "Base object does not exist");
 
-		# here errors should not hapen
+		# here errors should not happen
 		open my $fd, "-|", git_cmd(), "ls-tree", $hash_base, "--", $file_name
 			or die_error(500, "Open git-ls-tree failed");
 		my $line = <$fd>;
diff --git a/kwset.c b/kwset.c
index 51b2ab6..5800999 100644
--- a/kwset.c
+++ b/kwset.c
@@ -26,7 +26,7 @@
    The author may be reached (Email) at the address mike@ai.mit.edu,
    or (US mail) as Mike Haertel c/o Free Software Foundation. */
 
-/* The algorithm implemented by these routines bears a startling resemblence
+/* The algorithm implemented by these routines bears a startling resemblance
    to one discovered by Beate Commentz-Walter, although it is not identical.
    See "A String Matching Algorithm Fast on the Average," Technical Report,
    IBM-Germany, Scientific Center Heidelberg, Tiergartenstrasse 15, D-6900
@@ -435,7 +435,7 @@ kwsprep (kwset_t kws)
 	  /* Update the delta table for the descendents of this node. */
 	  treedelta(curr->links, curr->depth, delta);
 
-	  /* Compute the failure function for the decendents of this node. */
+	  /* Compute the failure function for the descendants of this node. */
 	  treefails(curr->links, curr->fail, kwset->trie);
 
 	  /* Update the shifts at each node in the current node's chain
diff --git a/perl/Git.pm b/perl/Git.pm
index 96cac39..650db90 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1180,7 +1180,7 @@ my (%TEMP_FILEMAP, %TEMP_FILES);
 
 =item temp_acquire ( NAME )
 
-Attempts to retreive the temporary file mapped to the string C<NAME>. If an
+Attempts to retrieve the temporary file mapped to the string C<NAME>. If an
 associated temp file has not been created this session or was closed, it is
 created, cached, and set for autoflush and binmode.
 
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 40dd897..f889fd6 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -68,7 +68,7 @@ Git::I18N - Perl interface to Git's Gettext localizations
 
 	print __("Welcome to Git!\n");
 
-	printf __("The following error occured: %s\n"), $error;
+	printf __("The following error occurred: %s\n"), $error;
 
 =head1 DESCRIPTION
 
diff --git a/perl/private-Error.pm b/perl/private-Error.pm
index 11e9cd9..9a0c567 100644
--- a/perl/private-Error.pm
+++ b/perl/private-Error.pm
@@ -769,7 +769,7 @@ is a numeric value. These values are what will be returned by the
 overload methods.
 
 If the text value ends with C<at file line 1> as $@ strings do, then
-this infomation will be used to set the C<-file> and C<-line> arguments
+this information will be used to set the C<-file> and C<-line> arguments
 of the error object.
 
 This class is used internally if an eval'd block die's with an error
diff --git a/po/README b/po/README
index c1520e8..d8c9111 100644
--- a/po/README
+++ b/po/README
@@ -232,7 +232,7 @@ Shell:
 
        # To interpolate variables:
        details="oh noes"
-       eval_gettext "An error occured: \$details"; echo
+       eval_gettext "An error occurred: \$details"; echo
 
    In addition we have wrappers for messages that end with a trailing
    newline. I.e. you could write the above as:
@@ -242,7 +242,7 @@ Shell:
 
        # To interpolate variables:
        details="oh noes"
-       eval_gettextln "An error occured: \$details"
+       eval_gettextln "An error occurred: \$details"
 
    More documentation about the interface is available in the GNU info
    page: `info '(gettext)sh'`. Looking at git-am.sh (the first shell
@@ -257,7 +257,7 @@ Perl:
 
        use Git::I18N;
        print __("Welcome to Git!\n");
-       printf __("The following error occured: %s\n"), $error;
+       printf __("The following error occurred: %s\n"), $error;
 
    Run `perldoc perl/Git/I18N.pm` for more info.
 
diff --git a/sequencer.c b/sequencer.c
index baa0310..ee4f8c6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -216,7 +216,7 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 	if (msg) {
 		fprintf(stderr, "%s\n", msg);
 		/*
-		 * A conflict has occured but the porcelain
+		 * A conflict has occurred but the porcelain
 		 * (typically rebase --interactive) wants to take care
 		 * of the commit itself so remove CHERRY_PICK_HEAD
 		 */
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index d8b7f2f..f8a08b7 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -116,7 +116,7 @@ tree_pretty_content="100644 blob $hello_sha1	hello"
 
 run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
 
-commit_message="Intial commit"
+commit_message="Initial commit"
 commit_sha1=$(echo_without_newline "$commit_message" | git commit-tree $tree_sha1)
 commit_size=176
 commit_content="tree $tree_sha1
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index f977279..25f8938 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -133,7 +133,7 @@ test_expect_success 'cherry-pick -x -s inserts blank line when conforming footer
 	test_cmp expect actual
 '
 
-test_expect_success 'cherry-pick -s adds sob when last sob doesnt match committer' '
+test_expect_success 'cherry-pick -s adds sob when last sob does not match committer' '
 	pristine_detach initial &&
 	git cherry-pick -s mesg-with-footer &&
 	cat <<-EOF >expect &&
@@ -144,7 +144,7 @@ test_expect_success 'cherry-pick -s adds sob when last sob doesnt match committe
 	test_cmp expect actual
 '
 
-test_expect_success 'cherry-pick -x -s adds sob when last sob doesnt match committer' '
+test_expect_success 'cherry-pick -x -s adds sob when last sob does not match committer' '
 	pristine_detach initial &&
 	sha1=`git rev-parse mesg-with-footer^0` &&
 	git cherry-pick -x -s mesg-with-footer &&
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 098a6ae..9fab25c 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -319,7 +319,7 @@ test_expect_success PERL 'split hunk "add -p (edit)"' '
 	# times to get out.
 	#
 	# 2. Correct version applies the (not)edited version, and asks
-	#    about the next hunk, against wich we say q and program
+	#    about the next hunk, against which we say q and program
 	#    exits.
 	for a in s e     q n q q
 	do
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index b993dae..86ee077 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -742,21 +742,21 @@ test_expect_success 'format-patch --signature --cover-letter' '
 	test 2 = $(grep "my sig" output | wc -l)
 '
 
-test_expect_success 'format.signature="" supresses signatures' '
+test_expect_success 'format.signature="" suppresses signatures' '
 	git config format.signature "" &&
 	git format-patch --stdout -1 >output &&
 	check_patch output &&
 	! grep "^-- \$" output
 '
 
-test_expect_success 'format-patch --no-signature supresses signatures' '
+test_expect_success 'format-patch --no-signature suppresses signatures' '
 	git config --unset-all format.signature &&
 	git format-patch --stdout --no-signature -1 >output &&
 	check_patch output &&
 	! grep "^-- \$" output
 '
 
-test_expect_success 'format-patch --signature="" supresses signatures' '
+test_expect_success 'format-patch --signature="" suppresses signatures' '
 	git format-patch --stdout --signature="" -1 >output &&
 	check_patch output &&
 	! grep "^-- \$" output
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 0bbcf06..5d0c598 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -47,7 +47,7 @@ test_fix () {
 	# find touched lines
 	$DIFF file target | sed -n -e "s/^> //p" >fixed
 
-	# the changed lines are all expeced to change
+	# the changed lines are all expected to change
 	fixed_cnt=$(wc -l <fixed)
 	case "$1" in
 	'') expect_cnt=$fixed_cnt ;;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 2fce99a..8bf53de 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -190,7 +190,7 @@ test_expect_success 'bisect start: no ".git/BISECT_START" if checkout error' '
 # $HASH1 is good, $HASH4 is bad, we skip $HASH3
 # but $HASH2 is bad,
 # so we should find $HASH2 as the first bad commit
-test_expect_success 'bisect skip: successfull result' '
+test_expect_success 'bisect skip: successful result' '
 	git bisect reset &&
 	git bisect start $HASH4 $HASH1 &&
 	git bisect skip &&
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index b44b293..25dac79 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -109,7 +109,7 @@ test_expect_success 'setup conflicted merge' '
 '
 
 # First do the merge with resolve and recursive then verify that
-# recusive is choosen.
+# recusive is chosen.
 
 test_expect_success 'merge picks up the best result' '
 	git config --unset-all pull.twohead &&
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index bc38737..d526b1d 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -237,7 +237,7 @@ test_expect_success 'mergetool takes partial path' '
     git submodule update -N &&
     test_must_fail git merge master &&
 
-    #shouldnt need these lines
+    #should not need these lines
     #( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
     #( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
     #( yes "l" | git mergetool submod >/dev/null 2>&1 ) &&
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 97d6f4c..ebd5c5d 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -101,7 +101,7 @@ test_expect_success $PREREQ \
 
 test_expect_success $PREREQ 'Send patches with --envelope-sender' '
     clean_fake_sendmail &&
-     git send-email --envelope-sender="Patch Contributer <patch@example.com>" --suppress-cc=sob --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
+     git send-email --envelope-sender="Patch Contributor <patch@example.com>" --suppress-cc=sob --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
 '
 
 test_expect_success $PREREQ 'setup expect' '
@@ -787,7 +787,7 @@ test_expect_success $PREREQ 'confirm detects EOF (auto causes failure)' '
 	test $ret = "0"
 '
 
-test_expect_success $PREREQ 'confirm doesnt loop forever' '
+test_expect_success $PREREQ 'confirm does not loop forever' '
 	CONFIRM=$(git config --get sendemail.confirm) &&
 	git config sendemail.confirm auto &&
 	GIT_SEND_EMAIL_NOTTY=1 &&
diff --git a/transport-helper.c b/transport-helper.c
index cb3ef7d..dcd8d97 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -991,7 +991,7 @@ struct unidirectional_transfer {
 	int src_is_sock;
 	/* Is destination socket? */
 	int dest_is_sock;
-	/* Transfer state (TRANSFERING/FLUSHING/FINISHED) */
+	/* Transfer state (TRANSFERRING/FLUSHING/FINISHED) */
 	int state;
 	/* Buffer. */
 	char buf[BUFFERSIZE];
diff --git a/transport.h b/transport.h
index 9354462..fcb1d25 100644
--- a/transport.h
+++ b/transport.h
@@ -74,7 +74,7 @@ struct transport {
 		       const char *executable, int fd[2]);
 
 	/** get_refs_list(), fetch(), and push_refs() can keep
-	 * resources (such as a connection) reserved for futher
+	 * resources (such as a connection) reserved for further
 	 * use. disconnect() releases these resources.
 	 **/
 	int (*disconnect)(struct transport *connection);
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 1b7012a..b2eb6db 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -490,7 +490,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 
 		/*
 		 * Try to move back the possibly merged group of changes, to match
-		 * the recorded postion in the other file.
+		 * the recorded position in the other file.
 		 */
 		while (ixref < ix) {
 			rchg[--ixs] = 1;
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index bf99787..73210cb 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -55,7 +55,7 @@ struct histindex {
 	struct record {
 		unsigned int ptr, cnt;
 		struct record *next;
-	} **records, /* an ocurrence */
+	} **records, /* an occurrence */
 	  **line_map; /* map of line to record chain */
 	chastore_t rcha;
 	unsigned int *next_ptrs;
-- 
1.8.2.373.g961c512
