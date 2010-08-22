From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Typos in code comments, an error message, documentation
Date: Sun, 22 Aug 2010 13:12:12 +0200
Organization: Institute for Numerical Simulation, University of Bonn
Message-ID: <20100822111212.GJ11809@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 22 13:12:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1On8TO-00082W-N5
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 13:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab0HVLMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 07:12:18 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:55175 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752055Ab0HVLMP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 07:12:15 -0400
Received: (qmail invoked by alias); 22 Aug 2010 11:12:13 -0000
Received: from xdsl-89-0-177-77.netcologne.de (EHLO localhost.localdomain) [89.0.177.77]
  by mail.gmx.net (mp040) with SMTP; 22 Aug 2010 13:12:13 +0200
X-Authenticated: #13673931
X-Provags-ID: V01U2FsdGVkX1+3V1hwEPu3J+LDgk9FJ6xXv0ADZmUowL3EGzd6zx
	COtJY5f/3m1SaX
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1On8TE-0004Al-EQ
	for git@vger.kernel.org; Sun, 22 Aug 2010 13:12:12 +0200
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2010-04-22)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154180>

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---

Based on master not maint as the former has more typos.

Thanks,
Ralf

 Documentation/RelNotes-1.5.6.3.txt            |    2 +-
 Documentation/RelNotes-1.6.0.2.txt            |    2 +-
 Documentation/RelNotes-1.6.4.3.txt            |    2 +-
 Documentation/RelNotes-1.6.5.4.txt            |    2 +-
 Documentation/RelNotes-1.6.5.7.txt            |    2 +-
 Documentation/RelNotes-1.6.6.txt              |    4 ++--
 Documentation/RelNotes-1.7.0.txt              |    2 +-
 Documentation/config.txt                      |    2 +-
 Documentation/gitmodules.txt                  |    2 +-
 Documentation/howto/revert-a-faulty-merge.txt |    2 +-
 builtin/blame.c                               |    4 ++--
 compat/mingw.c                                |    2 +-
 compat/nedmalloc/malloc.c.h                   |    2 +-
 compat/regex/regex.c                          |    2 +-
 contrib/workdir/git-new-workdir               |    4 ++--
 git-gui/git-gui.sh                            |    6 +++---
 gitweb/README                                 |    4 ++--
 gitweb/gitweb.perl                            |   12 ++++++------
 graph.c                                       |    2 +-
 pack-check.c                                  |    2 +-
 20 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/Documentation/RelNotes-1.5.6.3.txt b/Documentation/RelNotes-1.5.6.3.txt
index 9426112..f61dd35 100644
--- a/Documentation/RelNotes-1.5.6.3.txt
+++ b/Documentation/RelNotes-1.5.6.3.txt
@@ -4,7 +4,7 @@ GIT v1.5.6.3 Release Notes
 Fixes since v1.5.6.2
 --------------------
 
-* Setting core.sharerepository to traditional "true" value was supposed to make
+* Setting core.sharedrepository to traditional "true" value was supposed to make
   the repository group writable but should not affect permission for others.
   However, since 1.5.6, it was broken to drop permission for others when umask is
   022, making the repository unreadable by others.
diff --git a/Documentation/RelNotes-1.6.0.2.txt b/Documentation/RelNotes-1.6.0.2.txt
index 51b32f5..66e4c58 100644
--- a/Documentation/RelNotes-1.6.0.2.txt
+++ b/Documentation/RelNotes-1.6.0.2.txt
@@ -17,7 +17,7 @@ Fixes since v1.6.0.1
 * Many commands did not use the correct working tree location when used
   with GIT_WORK_TREE environment settings.
 
-* Some systems needs to use compatibility fnmach and regex libraries
+* Some systems needs to use compatibility fnmatch and regex libraries
   independent from each other; the compat/ area has been reorganized to
   allow this.
 
diff --git a/Documentation/RelNotes-1.6.4.3.txt b/Documentation/RelNotes-1.6.4.3.txt
index 4f29bab..5643e65 100644
--- a/Documentation/RelNotes-1.6.4.3.txt
+++ b/Documentation/RelNotes-1.6.4.3.txt
@@ -11,7 +11,7 @@ Fixes since v1.6.4.2
   been deprecated.
 
 * "git fetch" and "git clone" had an extra sanity check to verify the
-  presense of the corresponding *.pack file before downloading *.idx
+  presence of the corresponding *.pack file before downloading *.idx
   file by issuing a HEAD request.  Github server however sometimes
   gave 500 (Internal server error) response to HEAD even if a GET
   request for *.pack file to the same URL would have succeeded, and broke
diff --git a/Documentation/RelNotes-1.6.5.4.txt b/Documentation/RelNotes-1.6.5.4.txt
index e42f8b2..d3a2a3e 100644
--- a/Documentation/RelNotes-1.6.5.4.txt
+++ b/Documentation/RelNotes-1.6.5.4.txt
@@ -26,7 +26,7 @@ Fixes since v1.6.5.3
    future versions, but not in this release,
 
  * "git merge -m <message> <branch>..." added the standard merge message
-   on its own after user-supplied message, which should have overrided the
+   on its own after user-supplied message, which should have overridden the
    standard one.
 
 Other minor documentation updates are included.
diff --git a/Documentation/RelNotes-1.6.5.7.txt b/Documentation/RelNotes-1.6.5.7.txt
index 5b49ea5..dc5302c 100644
--- a/Documentation/RelNotes-1.6.5.7.txt
+++ b/Documentation/RelNotes-1.6.5.7.txt
@@ -10,7 +10,7 @@ Fixes since v1.6.5.6
   an older version of git should just ignore them.  Instead we diagnosed
   it as an error.
 
-* With help.autocorrect set to non-zero value, the logic to guess typoes
+* With help.autocorrect set to non-zero value, the logic to guess typos
   in the subcommand name misfired and ran a random nonsense command.
 
 * If a command is run with an absolute path as a pathspec inside a bare
diff --git a/Documentation/RelNotes-1.6.6.txt b/Documentation/RelNotes-1.6.6.txt
index 04e205c..c50b59c 100644
--- a/Documentation/RelNotes-1.6.6.txt
+++ b/Documentation/RelNotes-1.6.6.txt
@@ -29,7 +29,7 @@ or adjust to the new behaviour, on the day their sysadmin decides to install
 the new version of git.  When we switched from "git-foo" to "git foo" in
 1.6.0, even though the change had been advertised and the transition
 guide had been provided for a very long time, the users procrastinated
-during the entire transtion period, and ended up panicking on the day
+during the entire transition period, and ended up panicking on the day
 their sysadmins updated their git installation.  We are trying to avoid
 repeating that unpleasantness in the 1.7.0 release.
 
@@ -94,7 +94,7 @@ users will fare this time.
  * "git diff" traditionally treated various "ignore whitespace" options
    only as a way to filter the patch output.  "git diff --exit-code -b"
    exited with non-zero status even if all changes were about changing the
-   ammount of whitespace and nothing else.  and "git diff -b" showed the
+   amount of whitespace and nothing else.  and "git diff -b" showed the
    "diff --git" header line for such a change without patch text.
 
    In 1.7.0, the "ignore whitespaces" will affect the semantics of the
diff --git a/Documentation/RelNotes-1.7.0.txt b/Documentation/RelNotes-1.7.0.txt
index 43e3f33..0bb8c0b 100644
--- a/Documentation/RelNotes-1.7.0.txt
+++ b/Documentation/RelNotes-1.7.0.txt
@@ -202,7 +202,7 @@ release, unless otherwise noted.
    the branch is fully merged to its upstream branch if it is not merged
    to the current branch.  It now deletes it in such a case.
 
- * "fiter-branch" command incorrectly said --prune-empty and --filter-commit
+ * "filter-branch" command incorrectly said --prune-empty and --filter-commit
    were incompatible; the latter should be read as --commit-filter.
 
  * When using "git status" or asking "git diff" to compare the work tree
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0b4011f..05ec3fe 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1773,7 +1773,7 @@ submodule.<name>.ignore::
 	Using "none" (the default when this option is not set) also shows
 	submodules that have untracked files in their work tree as changed.
 	This setting overrides any setting made in .gitmodules for this submodule,
-	both settings can be overriden on the command line by using the
+	both settings can be overridden on the command line by using the
 	"--ignore-submodules" option.
 
 tar.umask::
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 8ae107d..bcffd95 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -56,7 +56,7 @@ submodule.<name>.ignore::
 	If this option is also present in the submodules entry in .git/config of
 	the superproject, the setting there will override the one found in
 	.gitmodules.
-	Both settings can be overriden on the command line by using the
+	Both settings can be overridden on the command line by using the
 	"--ignore-submodule" option.
 
 
diff --git a/Documentation/howto/revert-a-faulty-merge.txt b/Documentation/howto/revert-a-faulty-merge.txt
index ff5c0bc..6fd7119 100644
--- a/Documentation/howto/revert-a-faulty-merge.txt
+++ b/Documentation/howto/revert-a-faulty-merge.txt
@@ -229,7 +229,7 @@ reverting W.  Mainline's history would look like this:
    A---B---C
 
 But if you don't actually need to change commit A, then you need some way to
-recreate it as a new commit with the same changes in it.  The rebase commmand's
+recreate it as a new commit with the same changes in it.  The rebase command's
 --no-ff option provides a way to do this:
 
     $ git rebase [-i] --no-ff P
diff --git a/builtin/blame.c b/builtin/blame.c
index 437b1a4..6b201ff 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2368,11 +2368,11 @@ parse_done:
 	 *
 	 * The remaining are:
 	 *
-	 * (1) if dashdash_pos != 0, its either
+	 * (1) if dashdash_pos != 0, it's either
 	 *     "blame [revisions] -- <path>" or
 	 *     "blame -- <path> <rev>"
 	 *
-	 * (2) otherwise, its one of the two:
+	 * (2) otherwise, it's one of the two:
 	 *     "blame [revisions] <path>"
 	 *     "blame <path> <rev>"
 	 *
diff --git a/compat/mingw.c b/compat/mingw.c
index 9a8e336..96be8a0 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -641,7 +641,7 @@ static char *lookup_prog(const char *dir, const char *cmd, int isexe, int exe_on
 }
 
 /*
- * Determines the absolute path of cmd using the the split path in path.
+ * Determines the absolute path of cmd using the split path in path.
  * If cmd contains a slash or backslash, no lookup is performed.
  */
 static char *path_lookup(const char *cmd, char **path, int exe_only)
diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index 74c42e3..87260d2 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -2069,7 +2069,7 @@ static void init_malloc_global_mutex() {
   Each freshly allocated chunk must have both cinuse and pinuse set.
   That is, each allocated chunk borders either a previously allocated
   and still in-use chunk, or the base of its memory arena. This is
-  ensured by making all allocations from the the `lowest' part of any
+  ensured by making all allocations from the `lowest' part of any
   found chunk.  Further, no free chunk physically borders another one,
   so each free chunk is known to be preceded and followed by either
   inuse chunks or the ends of memory.
diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index 556d8ab..be851fc 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -3122,7 +3122,7 @@ re_match (bufp, string, size, pos, regs)
 
 
 /* re_match_2 matches the compiled pattern in BUFP against the
-   the (virtual) concatenation of STRING1 and STRING2 (of length SIZE1
+   (virtual) concatenation of STRING1 and STRING2 (of length SIZE1
    and SIZE2, respectively).  We start matching at POS, and stop
    matching at STOP.
 
diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 993cacf..3ad2c0c 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -54,13 +54,13 @@ then
 	die "destination directory '$new_workdir' already exists."
 fi
 
-# make sure the the links use full paths
+# make sure the links use full paths
 git_dir=$(cd "$git_dir"; pwd)
 
 # create the workdir
 mkdir -p "$new_workdir/.git" || die "unable to create \"$new_workdir\"!"
 
-# create the links to the original repo.  explictly exclude index, HEAD and
+# create the links to the original repo.  explicitly exclude index, HEAD and
 # logs/HEAD from the list since they are purely related to the current working
 # directory, and should not be shared.
 for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache svn
diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index bb10489..96680e5 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -477,7 +477,7 @@ proc _open_stdout_stderr {cmd} {
 			} {
 			# Older versions of Tcl 8.4 don't have this 2>@1 IO
 			# redirect operator.  Fallback to |& cat for those.
-			# The command was not actually started, so its safe
+			# The command was not actually started, so it's safe
 			# to try to start it a second time.
 			#
 			set fd [open [concat \
@@ -2163,13 +2163,13 @@ proc do_quit {{rc {1}}} {
 			}
 		}
 
-		# -- Cancel our spellchecker if its running.
+		# -- Cancel our spellchecker if it's running.
 		#
 		if {[info exists ui_comm_spell]} {
 			$ui_comm_spell stop
 		}
 
-		# -- Remove our editor backup, its not needed.
+		# -- Remove our editor backup, it's not needed.
 		#
 		after cancel $GITGUI_BCK_i
 		if {$GITGUI_BCK_exists} {
diff --git a/gitweb/README b/gitweb/README
index 0e19be8..d481198 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -95,7 +95,7 @@ You can specify the following configuration variables when building GIT:
    in the browser's URL bar and next to site name in bookmarks).  Relative
    to base URI of gitweb.  [Default: static/git-favicon.png]
  * GITWEB_JS
-   Points to the localtion where you put gitweb.js on your web server
+   Points to the location where you put gitweb.js on your web server
    (or to be more generic URI of JavaScript code used by gitweb).
    Relative to base URI of gitweb.  [Default: static/gitweb.js (or
    static/gitweb.min.js if JSMIN build variable is defined / JavaScript
@@ -233,7 +233,7 @@ not include variables usually directly set during build):
    is false.
  * $maxload
    Used to set the maximum load that we will still respond to gitweb queries.
-   If server load exceed this value then return "503 Service Unavaliable" error.
+   If server load exceed this value then return "503 Service Unavailable" error.
    Server load is taken to be 0 if gitweb cannot determine its value.  Set it to
    undefined value to turn it off.  The default is 300.
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 898b121..d0687f4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -268,7 +268,7 @@ our %feature = (
 	# return value of feature-sub indicates if to enable specified feature
 	#
 	# if there is no 'sub' key (no feature-sub), then feature cannot be
-	# overriden
+	# overridden
 	#
 	# use gitweb_get_feature(<feature>) to retrieve the <feature> value
 	# (an array) or gitweb_check_feature(<feature>) to check if <feature>
@@ -1346,7 +1346,7 @@ sub esc_param {
 	return $str;
 }
 
-# quote unsafe chars in whole URL, so some charactrs cannot be quoted
+# quote unsafe chars in whole URL, so some characters cannot be quoted
 sub esc_url {
 	my $str = shift;
 	return undef unless defined $str;
@@ -3781,9 +3781,9 @@ sub git_print_authorship {
 }
 
 # Outputs table rows containing the full author or committer information,
-# in the format expected for 'commit' view (& similia).
+# in the format expected for 'commit' view (& similar).
 # Parameters are a commit hash reference, followed by the list of people
-# to output information for. If the list is empty it defalts to both
+# to output information for. If the list is empty it defaults to both
 # author and committer.
 sub git_print_authorship_rows {
 	my $co = shift;
@@ -4512,8 +4512,8 @@ sub git_patchset_body {
 		print "</div>\n"; # class="patch"
 	}
 
-	# for compact combined (--cc) format, with chunk and patch simpliciaction
-	# patchset might be empty, but there might be unprocessed raw lines
+	# for compact combined (--cc) format, with chunk and patch simplification
+	# the patchset might be empty, but there might be unprocessed raw lines
 	for (++$patch_idx if $patch_number > 0;
 	     $patch_idx < @$difftree;
 	     ++$patch_idx) {
diff --git a/graph.c b/graph.c
index e2a5860..f1a63c2 100644
--- a/graph.c
+++ b/graph.c
@@ -443,7 +443,7 @@ static void graph_update_width(struct git_graph *graph,
 		max_cols++;
 
 	/*
-	 * We added a column for the the current commit as part of
+	 * We added a column for the current commit as part of
 	 * graph->num_parents.  If the current commit was already in
 	 * graph->columns, then we have double counted it.
 	 */
diff --git a/pack-check.c b/pack-check.c
index 395fb95..9d0cb9a 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -77,7 +77,7 @@ static int verify_packfile(struct packed_git *p,
 		err = error("%s SHA1 checksum mismatch",
 			    p->pack_name);
 	if (hashcmp(index_base + index_size - 40, pack_sig))
-		err = error("%s SHA1 does not match its inddex",
+		err = error("%s SHA1 does not match its index",
 			    p->pack_name);
 	unuse_pack(w_curs);
 
-- 
1.7.2.1.222.g9988
