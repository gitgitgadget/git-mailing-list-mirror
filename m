From: "Jason St. John" <jstjohn@purdue.edu>
Subject: [PATCH 2/4] Emphasize options and force ASCIIDOC escaping of "--"
Date: Fri,  8 Nov 2013 19:48:51 -0500
Message-ID: <1383958133-4207-1-git-send-email-jstjohn@purdue.edu>
Cc: "Jason St. John" <jstjohn@purdue.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 09 01:49:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VewjV-0003Ir-C1
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 01:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756919Ab3KIAs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 19:48:57 -0500
Received: from mailhub128.itcs.purdue.edu ([128.210.5.128]:50083 "EHLO
	mailhub128.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752445Ab3KIAs4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Nov 2013 19:48:56 -0500
Received: from megahurtz.itap.purdue.edu (pal-nat184-053-008.itap.purdue.edu [10.184.53.8])
	(authenticated bits=0)
	by mailhub128.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id rA90ms56022232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 8 Nov 2013 19:48:54 -0500
X-Mailer: git-send-email 1.8.4.2
X-PMX-Version: 6.0.2.2308539
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237477>

rev-list-options.txt: replace e.g. `--foo` with '\--foo'
rev-list-options.txt: emphasize, instead of quote, some option arguments
    (e.g. "foo-option" becomes 'foo-option')
rev-list-options.txt: force ASCIIDOC escaping of "--" (e.g. '--bar'
    becomes '\--bar')
rev-list-options.txt: add single quote chars around options missing them
    (e.g. --grep becomes '\--grep')
rev-list-options.txt: replaced one instance of "regexp" with "regular
    expressions"
rev-list-options.txt: fix typo in "--no-walk" description ("show" -->
"shown")
rev-list-options.txt: replaced some instances of double quotes with
    their ASCIIDOC equivalent (e.g. """a "-" character""" becomes
    """a ``-'' character""",

Signed-off-by: Jason St. John <jstjohn@purdue.edu>
---
Sorry for the messy quoting in the last set of examples in the commit message.
There wasn't really any way to work around it other than omitting the quotes
around the before and after parts, which I didn't want to do.


 Documentation/rev-list-options.txt | 136 ++++++++++++++++++-------------------
 1 file changed, 68 insertions(+), 68 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5bdfb42..32c40ae 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -6,12 +6,12 @@ special notations explained in the description, additional commit
 limiting may be applied.
 
 Using more options generally further limits the output (e.g.
-`--since=<date1>` limits to commits newer than `<date1>`, and using it
-with `--grep=<pattern>` further limits to commits whose log message
+'\--since=<date1>' limits to commits newer than `<date1>`, and using it
+with '\--grep=<pattern>' further limits to commits whose log message
 has a line that matches `<pattern>`), unless otherwise noted.
 
 Note that these are applied before commit
-ordering and formatting options, such as `--reverse`.
+ordering and formatting options, such as '\--reverse'.
 
 --
 
@@ -47,31 +47,31 @@ endif::git-rev-list[]
 
 	Limit the commits output to ones with author/committer
 	header lines that match the specified pattern (regular
-	expression).  With more than one `--author=<pattern>`,
+	expression).  With more than one '\--author=<pattern>',
 	commits whose author matches any of the given patterns are
-	chosen (similarly for multiple `--committer=<pattern>`).
+	chosen (similarly for multiple '\--committer=<pattern>').
 
 --grep-reflog=<pattern>::
 
 	Limit the commits output to ones with reflog entries that
 	match the specified pattern (regular expression). With
-	more than one `--grep-reflog`, commits whose reflog message
+	more than one '\--grep-reflog', commits whose reflog message
 	matches any of the given patterns are chosen.  It is an
-	error to use this option unless `--walk-reflogs` is in use.
+	error to use this option unless '\--walk-reflogs' is in use.
 
 --grep=<pattern>::
 
 	Limit the commits output to ones with log message that
 	matches the specified pattern (regular expression).  With
-	more than one `--grep=<pattern>`, commits whose message
+	more than one '\--grep=<pattern>', commits whose message
 	matches any of the given patterns are chosen (but see
-	`--all-match`).
+	'\--all-match').
 +
-When `--show-notes` is in effect, the message from the notes as
+When '\--show-notes' is in effect, the message from the notes as
 if it is part of the log message.
 
 --all-match::
-	Limit the commits output to ones that match all given --grep,
+	Limit the commits output to ones that match all given '\--grep',
 	instead of ones that match at least one.
 
 -i::
@@ -98,7 +98,7 @@ if it is part of the log message.
 
 --perl-regexp::
 
-	Consider the limiting patterns to be Perl-compatible regexp.
+	Consider the limiting patterns to be Perl-compatible regular expressions.
 	Requires libpcre to be compiled in.
 
 --remove-empty::
@@ -107,12 +107,12 @@ if it is part of the log message.
 
 --merges::
 
-	Print only merge commits. This is exactly the same as `--min-parents=2`.
+	Print only merge commits. This is exactly the same as '\--min-parents=2'.
 
 --no-merges::
 
 	Do not print commits with more than one parent. This is
-	exactly the same as `--max-parents=1`.
+	exactly the same as '\--max-parents=1'.
 
 --min-parents=<number>::
 --max-parents=<number>::
@@ -120,13 +120,13 @@ if it is part of the log message.
 --no-max-parents::
 
 	Show only commits which have at least (or at most) that many parent
-	commits. In particular, `--max-parents=1` is the same as `--no-merges`,
-	`--min-parents=2` is the same as `--merges`.  `--max-parents=0`
-	gives all root commits and `--min-parents=3` all octopus merges.
+	commits. In particular, '\--max-parents=1' is the same as '\--no-merges',
+	'\--min-parents=2` is the same as '\--merges'.  '\--max-parents=0'
+	gives all root commits and '\--min-parents=3' all octopus merges.
 +
-`--no-min-parents` and `--no-max-parents` reset these limits (to no limit)
-again.  Equivalent forms are `--min-parents=0` (any commit has 0 or more
-parents) and `--max-parents=-1` (negative numbers denote no upper limit).
+'\--no-min-parents' and '\--no-max-parents' reset these limits (to no limit)
+again.  Equivalent forms are '\--min-parents=0' (any commit has 0 or more
+parents) and '\--max-parents=-1' (negative numbers denote no upper limit).
 
 --first-parent::
 	Follow only the first parent commit upon seeing a merge
@@ -140,7 +140,7 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 --not::
 
 	Reverses the meaning of the '{caret}' prefix (or lack thereof)
-	for all following revision specifiers, up to the next '--not'.
+	for all following revision specifiers, up to the next '\--not'.
 
 --all::
 
@@ -183,7 +183,7 @@ ifndef::git-rev-list[]
 --bisect::
 
 	Pretend as if the bad bisection ref `refs/bisect/bad`
-	was listed and as if it was followed by `--not` and the good
+	was listed and as if it was followed by '\--not' and the good
 	bisection refs `refs/bisect/good-*` on the command
 	line.
 endif::git-rev-list[]
@@ -207,7 +207,7 @@ endif::git-rev-list[]
 
 --cherry-mark::
 
-	Like `--cherry-pick` (see below) but mark equivalent commits
+	Like '\--cherry-pick' (see below) but mark equivalent commits
 	with `=` rather than omitting them, and inequivalent ones with `+`.
 
 --cherry-pick::
@@ -218,8 +218,8 @@ endif::git-rev-list[]
 +
 For example, if you have two branches, `A` and `B`, a usual way
 to list all commits on only one side of them is with
-`--left-right` (see the example below in the description of
-the `--left-right` option).  It however shows the commits that were cherry-picked
+'\--left-right' (see the example below in the description of
+the '\--left-right' option). It however shows the commits that were cherry-picked
 from the other branch (for example, "3rd on b" may be cherry-picked
 from branch A).  With this option, such pairs of commits are
 excluded from the output.
@@ -229,21 +229,21 @@ excluded from the output.
 
 	List only commits on the respective side of a symmetric range,
 	i.e. only those which would be marked `<` resp. `>` by
-	`--left-right`.
+	'\--left-right'.
 +
-For example, `--cherry-pick --right-only A...B` omits those
+For example, '\--cherry-pick \--right-only A...B' omits those
 commits from `B` which are in `A` or are patch-equivalent to a commit in
 `A`. In other words, this lists the `+` commits from `git cherry A B`.
-More precisely, `--cherry-pick --right-only --no-merges` gives the exact
+More precisely, '\--cherry-pick \--right-only \--no-merges' gives the exact
 list.
 
 --cherry::
 
-	A synonym for `--right-only --cherry-mark --no-merges`; useful to
+	A synonym for '\--right-only \--cherry-mark \--no-merges'; useful to
 	limit the output to the commits on our side and mark those that
 	have been applied to the other side of a forked history with
-	`git log --cherry upstream...mybranch`, similar to
-	`git cherry upstream mybranch`.
+	'git log \--cherry upstream...mybranch', similar to
+	'git cherry upstream mybranch'.
 
 -g::
 --walk-reflogs::
@@ -254,7 +254,7 @@ list.
 	exclude (that is, '{caret}commit', 'commit1..commit2',
 	nor 'commit1\...commit2' notations cannot be used).
 +
-With '\--pretty' format other than oneline (for obvious reasons),
+With '\--pretty' format other than 'oneline' (for obvious reasons),
 this causes the output to have two extra lines of information
 taken from the reflog.  By default, 'commit@\{Nth}' notation is
 used in the output.  When the starting commit is specified as
@@ -320,7 +320,7 @@ Default mode::
 
 --simplify-merges::
 
-	Additional option to '--full-history' to remove some needless
+	Additional option to '\--full-history' to remove some needless
 	merges from the resulting history, as there are no selected
 	commits contributing to this merge.
 
@@ -400,7 +400,7 @@ available, removed `B` from consideration entirely.  `C` was
 considered via `N`, but is TREESAME.  Root commits are compared to an
 empty tree, so `I` is !TREESAME.
 +
-Parent/child relations are only visible with --parents, but that does
+Parent/child relations are only visible with '\--parents', but that does
 not affect the commits selected in default mode, so we have shown the
 parent lines.
 
@@ -494,7 +494,7 @@ The effect of this is best shown by way of comparing to
 	  `---------'
 -----------------------------------------------------------------------
 +
-Note the major differences in `N`, `P` and `Q` over '--full-history':
+Note the major differences in `N`, `P` and `Q` over '\--full-history':
 +
 --
 * `N`'s parent list had `I` removed, because it is an ancestor of the
@@ -537,7 +537,7 @@ of course).
 When we want to find out what commits in `M` are contaminated with the
 bug introduced by `D` and need fixing, however, we might want to view
 only the subset of 'D..M' that are actually descendants of `D`, i.e.
-excluding `C` and `K`. This is exactly what the '--ancestry-path'
+excluding `C` and `K`. This is exactly what the '\--ancestry-path'
 option does. Applied to the 'D..M' range, it results in:
 +
 -----------------------------------------------------------------------
@@ -587,7 +587,7 @@ one.
 
 --bisect-vars::
 
-This calculates the same as `--bisect`, except that refs in
+This calculates the same as '\--bisect', except that refs in
 `refs/bisect/` are not used, and except that this outputs
 text ready to be eval'ed by the shell. These lines will assign the
 name of the midpoint revision to the variable `bisect_rev`, and the
@@ -604,15 +604,15 @@ This outputs all the commit objects between the included and excluded
 commits, ordered by their distance to the included and excluded
 commits. Refs in `refs/bisect/` are not used. The farthest
 from them is displayed first. (This is the only one displayed by
-`--bisect`.)
+'\--bisect'.)
 +
 This is useful because it makes it easy to choose a good commit to
 test when you want to avoid to test some of them for some reason (they
 may not compile for example).
 +
-This option can be used along with `--bisect-vars`, in this case,
+This option can be used along with '\--bisect-vars', in this case,
 after all the sorted commit objects, there will be the same text as if
-`--bisect-vars` had been used alone.
+'\--bisect-vars' had been used alone.
 endif::git-rev-list[]
 
 
@@ -645,10 +645,10 @@ For example, in a commit history like this:
 ----------------------------------------------------------------
 +
 where the numbers denote the order of commit timestamps, `git
-rev-list` and friends with `--date-order` show the commits in the
+rev-list` and friends with '\--date-order' show the commits in the
 timestamp order: 8 7 6 5 4 3 2 1.
 +
-With `--topo-order`, they would show 8 6 5 3 7 4 2 1 (or 8 7 4 2 6 5
+With '\--topo-order', they would show 8 6 5 3 7 4 2 1 (or 8 7 4 2 6 5
 3 1); some older commits are shown before newer ones in order to
 avoid showing the commits from two parallel development track mixed
 together.
@@ -666,35 +666,35 @@ These options are mostly targeted for packing of Git repositories.
 --objects::
 
 	Print the object IDs of any object referenced by the listed
-	commits.  '--objects foo ^bar' thus means "send me
+	commits.  '\--objects foo ^bar' thus means "send me
 	all object IDs which I need to download if I have the commit
 	object 'bar', but not 'foo'".
 
 --objects-edge::
 
-	Similar to '--objects', but also print the IDs of excluded
-	commits prefixed with a "-" character.  This is used by
-	linkgit:git-pack-objects[1] to build "thin" pack, which records
+	Similar to '\--objects', but also print the IDs of excluded
+	commits prefixed with a ``-'' character.  This is used by
+	linkgit:git-pack-objects[1] to build ``thin'' pack, which records
 	objects in deltified form based on objects contained in these
 	excluded commits to reduce network traffic.
 
 --unpacked::
 
-	Only useful with '--objects'; print the object IDs that are not
+	Only useful with '\--objects'; print the object IDs that are not
 	in packs.
 
 --no-walk[=(sorted|unsorted)]::
 
 	Only show the given commits, but do not traverse their ancestors.
 	This has no effect if a range is specified. If the argument
-	"unsorted" is given, the commits are show in the order they were
-	given on the command line. Otherwise (if "sorted" or no argument
-	was given), the commits are show in reverse chronological order
+	'unsorted' is given, the commits are show in the order they were
+	given on the command line. Otherwise (if 'sorted' or no argument
+	was given), the commits are shown in reverse chronological order
 	by commit time.
 
 --do-walk::
 
-	Overrides a previous --no-walk.
+	Overrides a previous '\--no-walk'.
 
 Commit Formatting
 ~~~~~~~~~~~~~~~~~
@@ -709,29 +709,29 @@ include::pretty-options.txt[]
 
 --relative-date::
 
-	Synonym for `--date=relative`.
+	Synonym for '\--date=relative'.
 
 --date=(relative|local|default|iso|rfc|short|raw)::
 
 	Only takes effect for dates shown in human-readable format, such
-	as when using "--pretty". `log.date` config variable sets a default
-	value for log command's --date option.
+	as when using '\--pretty'. The `log.date` config variable sets a
+	default value for the log command's '\--date' option.
 +
-`--date=relative` shows dates relative to the current time,
+'\--date=relative' shows dates relative to the current time,
 e.g. "2 hours ago".
 +
-`--date=local` shows timestamps in user's local timezone.
+'\--date=local' shows timestamps in user's local timezone.
 +
-`--date=iso` (or `--date=iso8601`) shows timestamps in ISO 8601 format.
+'\--date=iso' (or '\--date=iso8601') shows timestamps in ISO 8601 format.
 +
-`--date=rfc` (or `--date=rfc2822`) shows timestamps in RFC 2822
+'\--date=rfc' (or '\--date=rfc2822') shows timestamps in RFC 2822
 format, often found in E-mail messages.
 +
-`--date=short` shows only date but not time, in `YYYY-MM-DD` format.
+'\--date=short' shows only the date but not the time, in `YYYY-MM-DD` format.
 +
-`--date=raw` shows the date in the internal raw Git format `%s %z` format.
+'\--date=raw' shows the date in the internal raw Git format `%s %z` format.
 +
-`--date=default` shows timestamps in the original timezone
+'\--date=default' shows timestamps in the original timezone
 (either committer's or author's).
 
 ifdef::git-rev-list[]
@@ -760,8 +760,8 @@ endif::git-rev-list[]
 
 	Mark which side of a symmetric diff a commit is reachable from.
 	Commits from the left side are prefixed with `<` and those from
-	the right with `>`.  If combined with `--boundary`, those
-	commits are prefixed with `-`.
+	the right with `>`.  If combined with '\--boundary', those
+	commits are prefixed with ``-''.
 +
 For example, if you have this topology:
 +
@@ -795,16 +795,16 @@ you would get an output like this:
 +
 This enables parent rewriting, see 'History Simplification' below.
 +
-This implies the '--topo-order' option by default, but the
-'--date-order' option may also be specified.
+This implies the '\--topo-order' option by default, but the
+'\--date-order' option may also be specified.
 
 ifdef::git-rev-list[]
 --count::
 	Print a number stating how many commits would have been
 	listed, and suppress all other output.  When used together
-	with '--left-right', instead print the counts for left and
+	with '\--left-right', instead print the counts for left and
 	right commits, separated by a tab. When used together with
-	'--cherry-mark', omit patch equivalent commits from these
+	'\--cherry-mark', omit patch equivalent commits from these
 	counts and print the count for equivalent commits separated
 	by a tab.
 endif::git-rev-list[]
@@ -838,7 +838,7 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 	This flag makes the merge commits show the full diff like
 	regular commits; for each merge parent, a separate log entry
 	and diff is generated. An exception is that only diff against
-	the first parent is shown when '--first-parent' option is given;
+	the first parent is shown when '\--first-parent' option is given;
 	in that case, the output represents the changes the merge
 	brought _into_ the then-current branch.
 
-- 
1.8.4.2
