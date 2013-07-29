From: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
Subject: [PATCH] More typofixes.
Date: Mon, 29 Jul 2013 10:18:21 +0200
Message-ID: <20130729081821.GA6758@domone.kolej.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 29 10:18:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3if5-0005iJ-Vn
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 10:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab3G2ISb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jul 2013 04:18:31 -0400
Received: from popelka.ms.mff.cuni.cz ([195.113.20.131]:33440 "EHLO
	popelka.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab3G2IS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 04:18:29 -0400
Received: from domone.kolej.mff.cuni.cz (popelka.ms.mff.cuni.cz [195.113.20.131])
	by popelka.ms.mff.cuni.cz (Postfix) with ESMTPS id EADEB68298
	for <git@vger.kernel.org>; Mon, 29 Jul 2013 10:18:21 +0200 (CEST)
Received: by domone.kolej.mff.cuni.cz (Postfix, from userid 1000)
	id C299B60135; Mon, 29 Jul 2013 10:18:21 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.97.6 at popelka.ms.mff.cuni.cz
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	UNPARSEABLE_RELAY autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	popelka.ms.mff.cuni.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231277>

Hi,

I improved my tool and it catched following additional typos.

As with any big project best way to catch errors is to have automated
checks that catch them ( Other possibility would be to read everything =
ten
times to get error rate down but nobody wants to do it).

If you want you could add a pre-commit hook=20
stylepp-spellcheck --hook
that checks comments for likely typos (misspells by aspell and not
occurring in code). It uses aspell to identify them so you need to=20
teach aspell which words are valid.=20

I would like make possible to share dictionaries so teaching phase can
be done only once instead for each person but I did not found suitable
workflow yet.


Signed-off-by: Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz>

diff --git a/pathspec.c b/pathspec.c
index 6ea0867..27ffe77 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -40,7 +40,7 @@ void add_pathspec_matches_against_index(const char **=
pathspec,
 /*
  * Finds which of the given pathspecs match items in the index.
  *
- * This is a one-shot wrapper around add_pathspec_matches_against_inde=
x()
+ * This is an one-shot wrapper around add_pathspec_matches_against_ind=
ex()
  * which allocates, populates, and returns a seen[] array indicating t=
he
  * nature of the "closest" (i.e. most specific) matches which each of =
the
  * given pathspecs achieves against all items in the index.
diff --git a/builtin/log.c b/builtin/log.c
index 2625f98..01b49b3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -304,7 +304,7 @@ static void setup_early_output(struct rev_info *rev=
)
 	 * tenth of a second, don't even bother doing the
 	 * early-output thing..
 	 *
-	 * This is a one-time-only trigger.
+	 * This is an one-time-only trigger.
 	 */
 	early_output_timer.it_value.tv_sec =3D 0;
 	early_output_timer.it_value.tv_usec =3D 100000;
diff --git a/transport-helper.c b/transport-helper.c
index 45a35df..63cabc3 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1132,7 +1132,7 @@ static void *udt_copy_task_routine(void *udt)
 #ifndef NO_PTHREADS
=20
 /*
- * Join thread, with apporiate errors on failure. Name is name for the
+ * Join thread, with appropriate errors on failure. Name is name for t=
he
  * thread (for error messages). Returns 0 on success, 1 on failure.
  */
 static int tloop_join(pthread_t thread, const char *name)
diff --git a/transport-helper.c b/transport-helper.c
index 45a35df..63cabc3 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1198,7 +1198,7 @@ static void udt_kill_transfer(struct unidirection=
al_transfer *t)
 }
=20
 /*
- * Join process, with apporiate errors on failure. Name is name for th=
e
+ * Join process, with appropriate errors on failure. Name is name for =
the
  * process (for error messages). Returns 0 on success, 1 on failure.
  */
 static int tloop_join(pid_t pid, const char *name)
diff --git a/Documentation/RelNotes/1.7.11.7.txt b/Documentation/RelNot=
es/1.7.11.7.txt
index e7e79d9..e743a2a 100644
--- a/Documentation/RelNotes/1.7.11.7.txt
+++ b/Documentation/RelNotes/1.7.11.7.txt
@@ -25,7 +25,7 @@ Fixes since v1.7.11.6
    references" nor "Reload" did not update what is shown as the
    contents of it, when the user overwrote the tag with "git tag -f".
=20
- * "git for-each-ref" did not currectly support more than one --sort
+ * "git for-each-ref" did not correctly support more than one --sort
    option.
=20
  * "git log .." errored out saying it is both rev range and a path
diff --git a/t/t9112-git-svn-md5less-file.sh b/t/t9112-git-svn-md5less-=
file.sh
index a61d671..9861c71 100755
--- a/t/t9112-git-svn-md5less-file.sh
+++ b/t/t9112-git-svn-md5less-file.sh
@@ -7,7 +7,7 @@ test_description=3D'test that git handles an svn reposi=
tory with missing md5sums'
 # Loading a node from a svn dumpfile without a Text-Content-Length
 # field causes svn to neglect to store or report an md5sum.  (it will
 # calculate one if you had put Text-Content-Length: 0).  This showed
-# up in a repository creted with cvs2svn.
+# up in a repository created with cvs2svn.
=20
 cat > dumpfile.svn <<EOF
 SVN-fs-dump-format-version: 1
diff --git a/read-cache.c b/read-cache.c
index d4474ea..c3d5e35 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -489,7 +489,7 @@ int remove_index_entry_at(struct index_state *istat=
e, int pos)
 }
=20
 /*
- * Remove all cache ententries marked for removal, that is where
+ * Remove all cache entries marked for removal, that is where
  * CE_REMOVE is set in ce_flags.  This is much more effective than
  * calling remove_index_entry_at() for each entry to be removed.
  */
diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
index d9f6b73..4d81ba1 100755
--- a/t/t9020-remote-svn.sh
+++ b/t/t9020-remote-svn.sh
@@ -24,7 +24,7 @@ init_git () {
 	rm -fr .git &&
 	git init &&
 	#git remote add svnsim testsvn::sim:///$TEST_DIRECTORY/t9020/example.=
svnrdump
-	# let's reuse an exisiting dump file!?
+	# let's reuse an existing dump file!?
 	git remote add svnsim testsvn::sim://$TEST_DIRECTORY/t9154/svn.dump
 	git remote add svnfile testsvn::file://$TEST_DIRECTORY/t9154/svn.dump
 }
diff --git a/builtin/push.c b/builtin/push.c
index 6d36c24..04f0eaf 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -92,7 +92,7 @@ static NORETURN int die_push_simple(struct branch *br=
anch, struct remote *remote
 	if (!short_upstream)
 		short_upstream =3D branch->merge[0]->src;
 	/*
-	 * Don't show advice for people who explicitely set
+	 * Don't show advice for people who explicitly set
 	 * push.default.
 	 */
 	if (push_default =3D=3D PUSH_DEFAULT_UNSPECIFIED)
diff --git a/Documentation/howto/new-command.txt b/Documentation/howto/=
new-command.txt
index 2abc3a0..d7de5a3 100644
--- a/Documentation/howto/new-command.txt
+++ b/Documentation/howto/new-command.txt
@@ -94,7 +94,7 @@ your language, document it in the INSTALL file.
 6. There is a file command-list.txt in the distribution main directory
 that categorizes commands by type, so they can be listed in appropriat=
e
 subsections in the documentation's summary command list.  Add an entry
-for yours.  To understand the categories, look at git-cmmands.txt
+for yours.  To understand the categories, look at git-commands.txt
 in the main directory.
=20
 7. Give the maintainer one paragraph to include in the RelNotes file
diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
index 4ffd901..97c6ace 100644
--- a/t/lib-t6000.sh
+++ b/t/lib-t6000.sh
@@ -34,7 +34,7 @@ save_tag () {
 	mv sed.script.tmp sed.script
 }
=20
-# Replace unhelpful sha1 hashses with their symbolic equivalents
+# Replace unhelpful sha1 hashes with their symbolic equivalents
 entag () {
 	sed -f sed.script
 }
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d1d68e9..8e19058 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -379,7 +379,7 @@ static void handle_tag(const char *name, struct tag=
 *tag)
 	int tagged_mark;
 	struct commit *p;
=20
-	/* Trees have no identifer in fast-export output, thus we have no way
+	/* Trees have no identifier in fast-export output, thus we have no wa=
y
 	 * to output tags of trees, tags of tags of trees, etc.  Simply omit
 	 * such tags.
 	 */
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subt=
ree.txt
index 7ba853e..e0957ee 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -270,7 +270,7 @@ git-extensions repository in ~/git-extensions/:
 name
=20
 You can omit the --squash flag, but doing so will increase the number
-of commits that are incldued in your local repository.
+of commits that are included in your local repository.
=20
 We now have a ~/git-extensions/git-subtree directory containing code
 from the master branch of git://github.com/apenwarr/git-subtree.git
diff --git a/commit-slab.h b/commit-slab.h
index 7d48163..4f1c796 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -22,7 +22,7 @@
  *
  *   Initializes the indegree slab that associates an array of integer=
s
  *   to each commit. 'stride' specifies how big each array is.  The sl=
ab
- *   that id initialied by the variant without "_with_stride" associat=
es
+ *   that id initialized by the variant without "_with_stride" associa=
tes
  *   each commit with an array of one integer.
  */
=20
diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index ae2dc46..9e381e0 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -36,7 +36,7 @@ EOF
=20
 	# You can set the GITWEB_TEST_INSTALLED environment variable to
 	# the gitwebdir (the directory where gitweb is installed / deployed t=
o)
-	# of an existing gitweb instalation to test that installation,
+	# of an existing gitweb installation to test that installation,
 	# or simply to pathname of installed gitweb script.
 	if test -n "$GITWEB_TEST_INSTALLED" ; then
 		if test -d $GITWEB_TEST_INSTALLED; then
diff --git a/Documentation/RelNotes/1.7.9.1.txt b/Documentation/RelNote=
s/1.7.9.1.txt
index 6957183..e8fddb8 100644
--- a/Documentation/RelNotes/1.7.9.1.txt
+++ b/Documentation/RelNotes/1.7.9.1.txt
@@ -20,7 +20,7 @@ Fixes since v1.7.9
    submodule that only has uncommitted local changes in the patch
    prepared by for the user to edit.
=20
- * Typo in "git branch --edit-description my-tpoic" was not diagnosed.
+ * Typo in "git branch --edit-description my-topic" was not diagnosed.
=20
  * Using "git grep -l/-L" together with options -W or --break may not
    make much sense as the output is to only count the number of hits
diff --git a/contrib/ciabot/ciabot.py b/contrib/ciabot/ciabot.py
index 36b5665..befa0c3 100755
--- a/contrib/ciabot/ciabot.py
+++ b/contrib/ciabot/ciabot.py
@@ -70,7 +70,7 @@ tinyifier =3D "http://tinyurl.com/api-create.php?url=3D=
"
=20
 # The template used to generate the XML messages to CIA.  You can make
 # visible changes to the IRC-bot notification lines by hacking this.
-# The default will produce a notfication line that looks like this:
+# The default will produce a notification line that looks like this:
 #
 # ${project}: ${author} ${repo}:${branch} * ${rev} ${files}: ${logmsg}=
 ${url}
 #
diff --git a/contrib/ciabot/ciabot.sh b/contrib/ciabot/ciabot.sh
index 3fbbc53..dfb71a1 100755
--- a/contrib/ciabot/ciabot.sh
+++ b/contrib/ciabot/ciabot.sh
@@ -39,7 +39,7 @@
 #       done
 #
 # The reason for the tac call is that git rev-list emits commits from
-# most recent to least - better to ship notifactions from oldest to ne=
west.
+# most recent to least - better to ship notifications from oldest to n=
ewest.
 #
 # Configuration variables affecting this script:
 #
diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
index 4ffd901..97c6ace 100644
--- a/t/lib-t6000.sh
+++ b/t/lib-t6000.sh
@@ -65,7 +65,7 @@ commit_date () {
 }
=20
 # Assign the value of fake date to a variable, but
-# allow fairly common "1971-08-16 00:00" to be omittd
+# allow fairly common "1971-08-16 00:00" to be omitted
 assign_fake_date () {
 	case "$2" in
 	??:??:??)	eval "$1=3D'1971-08-16 $2'" ;;
diff --git a/read-cache.c b/read-cache.c
index d4474ea..c3d5e35 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1760,7 +1760,7 @@ static int has_racy_timestamp(struct index_state =
*istate)
 }
=20
 /*
- * Opportunisticly update the index but do not complain if we can't
+ * Opportunistically update the index but do not complain if we can't
  */
 void update_index_if_able(struct index_state *istate, struct lock_file=
 *lockfile)
 {
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 6a72106..feee6a4 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -144,7 +144,7 @@ setup_user_tool () {
 setup_tool () {
 	tool=3D"$1"
=20
-	# Fallback definitions, to be overriden by tools.
+	# Fallback definitions, to be overridden by tools.
 	can_merge () {
 		return 0
 	}
diff --git a/Documentation/RelNotes/1.7.10.4.txt b/Documentation/RelNot=
es/1.7.10.4.txt
index 326670d..57597f2 100644
--- a/Documentation/RelNotes/1.7.10.4.txt
+++ b/Documentation/RelNotes/1.7.10.4.txt
@@ -7,7 +7,7 @@ Fixes since v1.7.10.3
  * The message file for Swedish translation has been updated a bit.
=20
  * A name taken from mailmap was copied into an internal buffer
-   incorrectly and could overun the buffer if it is too long.
+   incorrectly and could overrun the buffer if it is too long.
=20
  * A malformed commit object that has a header line chomped in the
    middle could kill git with a NULL pointer dereference.
diff --git a/git-p4.py b/git-p4.py
index 88fcf23..31e71ff 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1786,7 +1786,7 @@ class P4Submit(Command, P4UserMap):
             missingGitTags =3D gitTags - p4Labels
             self.exportGitTags(missingGitTags)
=20
-        # exit with error unless everything applied perfecly
+        # exit with error unless everything applied perfectly
         if len(commits) !=3D len(applied):
                 sys.exit(1)
=20
diff --git a/combine-diff.c b/combine-diff.c
index 6dc0609..88525b3 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -165,7 +165,7 @@ static struct lline *coalesce_lines(struct lline *b=
ase, int *lenbase,
=20
 	/*
 	 * Coalesce new lines into base by finding the LCS
-	 * - Create the table to run dynamic programing
+	 * - Create the table to run dynamic programming
 	 * - Compute the LCS
 	 * - Then reverse read the direction structure:
 	 *   - If we have MATCH, assign parent to base flag, and consume
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index b0d1d94..1962d3a 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -28,7 +28,7 @@ test_expect_success 'p4 client newlines, unix' '
 		test_cmp f-unix-orig f-unix &&
=20
 		# make sure stored in repo as unix newlines
-		# use sed to eat python-appened newline
+		# use sed to eat python-appended newline
 		p4 -G print //depot/f-unix | marshal_dump data 2 |\
 		    sed \$d >f-unix-p4-print &&
 		test_cmp f-unix-orig f-unix-p4-print &&
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index b0d1d94..1962d3a 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -55,7 +55,7 @@ test_expect_success 'p4 client newlines, win' '
 		test_cmp f-win-orig f-win &&
=20
 		# make sure stored in repo as unix newlines
-		# use sed to eat python-appened newline
+		# use sed to eat python-appended newline
 		p4 -G print //depot/f-win | marshal_dump data 2 |\
 		    sed \$d >f-win-p4-print &&
 		test_cmp f-win-as-lf f-win-p4-print &&
diff --git a/notes.h b/notes.h
index 3324c48..2a3f923 100644
--- a/notes.h
+++ b/notes.h
@@ -77,7 +77,7 @@ const char *default_notes_ref(void);
  * variable is used, and if that is missing, the default notes ref is =
used
  * ("refs/notes/commits").
  *
- * If you need to re-intialize a notes_tree structure (e.g. when switc=
hing from
+ * If you need to re-initialize a notes_tree structure (e.g. when swit=
ching from
  * one notes ref to another), you must first de-initialize the notes_t=
ree
  * structure by calling free_notes(struct notes_tree *).
  *
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.s=
h
index 25dac79..830a4c3 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -109,7 +109,7 @@ test_expect_success 'setup conflicted merge' '
 '
=20
 # First do the merge with resolve and recursive then verify that
-# recusive is chosen.
+# recursive is chosen.
=20
 test_expect_success 'merge picks up the best result' '
 	git config --unset-all pull.twohead &&
diff --git a/cache.h b/cache.h
index 3a69638..85b544f 100644
--- a/cache.h
+++ b/cache.h
@@ -491,7 +491,7 @@ extern void *read_blob_data_from_index(struct index=
_state *, const char *, unsig
 extern int ie_match_stat(const struct index_state *, const struct cach=
e_entry *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, const struct cache_=
entry *, struct stat *, unsigned int);
=20
-#define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONE=
STAR */
+#define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONES=
TAR */
=20
 struct pathspec {
 	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
diff --git a/Documentation/technical/api-revision-walking.txt b/Documen=
tation/technical/api-revision-walking.txt
index b7d0d9a..55b878a 100644
--- a/Documentation/technical/api-revision-walking.txt
+++ b/Documentation/technical/api-revision-walking.txt
@@ -59,7 +59,7 @@ function.
 `reset_revision_walk`::
=20
 	Reset the flags used by the revision walking api. You can use
-	this to do multiple sequencial revision walks.
+	this to do multiple sequential revision walks.
=20
 Data structures
 ---------------
diff --git a/Documentation/config.txt b/Documentation/config.txt
index e0b923f..8420aff 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -434,11 +434,11 @@ core.repositoryFormatVersion::
 	version.
=20
 core.sharedRepository::
-	When 'group' (or 'true'), the repository is made shareable between
+	When 'group' (or 'true'), the repository is made sharable between
 	several users in a group (making sure all the files and objects are
 	group-writable). When 'all' (or 'world' or 'everybody'), the
 	repository will be readable by all users, additionally to being
-	group-shareable. When 'umask' (or 'false'), Git will use permissions
+	group-sharable. When 'umask' (or 'false'), Git will use permissions
 	reported by umask(2). When '0xxx', where '0xxx' is an octal number,
 	files in the repository will have this mode value. '0xxx' will overri=
de
 	user's umask value (whereas the other options will only override
diff --git a/contrib/ciabot/ciabot.sh b/contrib/ciabot/ciabot.sh
index 3fbbc53..dfb71a1 100755
--- a/contrib/ciabot/ciabot.sh
+++ b/contrib/ciabot/ciabot.sh
@@ -64,7 +64,7 @@
 # down. It is unknown whether this is still an issue in 2010, but
 # XML-RPC would be annoying to do from sh in any case. (XML-RPC does
 # have the advantage that it guarantees notification of multiple commi=
ts
-# shpped from an update in their actual order.)
+# shipped from an update in their actual order.)
 #
=20
 # The project as known to CIA. You can set this with a -p option,
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 75fb543..1d3a082 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -98,7 +98,7 @@ clean::
 filter by pattern::
=20
    This shows the files and directories to be deleted and issues an
-   "Input ignore patterns>>" prompt. You can input space-seperated
+   "Input ignore patterns>>" prompt. You can input space-separated
    patterns to exclude files and directories from deletion.
    E.g. "*.c *.h" will excludes files end with ".c" and ".h" from
    deletion. When you are satisfied with the filtered result, press
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
index fe723e4..1491d69 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3116,7 +3116,7 @@ Trust
 If you receive the SHA-1 name of a blob from one source, and its conte=
nts
 from another (possibly untrusted) source, you can still trust that tho=
se
 contents are correct as long as the SHA-1 name agrees.  This is becaus=
e
-the SHA-1 is designed so that it is infeasible to find different conte=
nts
+the SHA-1 is designed so that it is unfeasible to find different conte=
nts
 that produce the same hash.
=20
 Similarly, you need only trust the SHA-1 name of a top-level tree obje=
ct
