From: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
Subject: [PATCH] Random typofixes.
Date: Mon, 22 Jul 2013 23:02:23 +0200
Message-ID: <20130722210223.GA26492@domone.kolej.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 22 23:02:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1NFe-0004eA-F1
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 23:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757279Ab3GVVCe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jul 2013 17:02:34 -0400
Received: from popelka.ms.mff.cuni.cz ([195.113.20.131]:35966 "EHLO
	popelka.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755781Ab3GVVCc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 17:02:32 -0400
Received: from domone.kolej.mff.cuni.cz (popelka.ms.mff.cuni.cz [195.113.20.131])
	by popelka.ms.mff.cuni.cz (Postfix) with ESMTPS id ED97E45619
	for <git@vger.kernel.org>; Mon, 22 Jul 2013 23:02:23 +0200 (CEST)
Received: by domone.kolej.mff.cuni.cz (Postfix, from userid 1000)
	id C31875FB95; Mon, 22 Jul 2013 23:02:23 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230991>

Hi, this is refactored version of my previous typofix patch. I avoid
here controversional fixes.
I am writing a https://github.com/neleai/stylepp tool to handle
various style issues.

To simplify review I wrote a utility:

stylepp_strip_diff

That takes a patch file, strips surrounding lines and prints intervals
that were changes.

Its output is below and patch follows:

-     right), to make sure that lefts and rights of descendents
-     correspond properly to bit masks.  We use the rightmost descenden=
t
+     right), to make sure that lefts and rights of descendants
+     correspond properly to bit masks.  We use the rightmost descendan=
t

                                       -Acknowledgements
                                       +Acknowledgments
                                        ^        ^
 to Dmitry Chichkov for reporting this. Futher thanks to Aleksey Sanin.
 to Dmitry Chichkov for reporting this. Further thanks to Aleksey Sanin=
=2E
                                        ^ ^
                                    -   acccumulate the prefix paths.
                                    +   accumulate the prefix paths.
                                        ^^
ions->file to /dev/null should be safe, becaue we
ions->file to /dev/null should be safe, because we
                                        ^    ^
                               -both as cloneable Git URL and as browse=
able gitweb interface.  If you then
                               +both as clonable Git URL and as browsea=
ble gitweb interface.  If you then
                                        ^  ^
  -   dependency automatically when the complier supports it.
  +   dependency automatically when the compiler supports it.
                                        ^    ^
                          - * Streaming converison support
                          + * Streaming conversion support
                                        ^      ^
                          - * Streaming converison support
                          + * Streaming conversion support
                                        ^      ^
                                -       could't accept the current inpu=
t `multi byte'.   */
                                +       couldn't accept the current inp=
ut `multi byte'.   */
                                        ^    ^
                  -     node that has a descendent on the current label=
=2E */
                  +     node that has a descendant on the current label=
=2E */
                                        ^      ^
           -   /* Enqueue the immediate descendents in the level order =
queue. */
           +   /* Enqueue the immediate descendants in the level order =
queue. */
                                        ^      ^
  -   /* Update the delta table for the descendents of this node. */
  +   /* Update the delta table for the descendants of this node. */
                                        ^      ^
                       -   fail and its descendents should be no larger=
 than the
                       +   fail and its descendants should be no larger=
 than the
                                        ^      ^
nt maxshift;   /* Max shift of self and descendents. */
nt maxshift;   /* Max shift of self and descendants. */
                                        ^      ^
ion for parse_bracket_exp used in _LIBC environement.
ion for parse_bracket_exp used in _LIBC environment.
                                        ^     ^
ion for parse_bracket_exp used in _LIBC environement.
ion for parse_bracket_exp used in _LIBC environment.
                                        ^     ^
ion for parse_bracket_exp used in _LIBC environement.
ion for parse_bracket_exp used in _LIBC environment.
                                        ^     ^
            -   that it was told to add everthing ('a') when up-arrow w=
as pressed by
            +   that it was told to add everything ('a') when up-arrow =
was pressed by
                                        ^   ^
            -([PATCH] Sync in core time granuality with filesystems,
            +([PATCH] Sync in core time granularity with filesystems,
                                        ^      ^
  like we warn when more than one refs/ hierachies share the same
  like we warn when more than one refs/ hierarchies share the same
                                        ^    ^
                    - * The replacement implemention for snprintf used =
on platforms with
                    + * The replacement implementation for snprintf use=
d on platforms with
                                        ^        ^
                           -* `X` is an indpendent root commit that add=
ed a new file `side`, and `Y`
                           +* `X` is an independent root commit that ad=
ded a new file `side`, and `Y`
                                        ^  ^
it with GCC 2.95.  While they were well intentioned
it with GCC 2.95.  While they were well intended
                                        ^    ^
              -   unmodified path).  It learnt to use a more git-aware =
logic to
              +   unmodified path).  It learned to use a more git-aware=
 logic to
                                        ^     ^
  Note that the matcher assume that the maching starts from the current
  Note that the matcher assume that the matching starts from the curren=
t
                                        ^ ^
    -   since we stopped using the diff minimalization by default in v1=
=2E7.2
    +   since we stopped using the diff minimization by default in v1.7=
=2E2
                                        ^   ^
n add "^{type}" peeling operator to the parmeter.
n add "^{type}" peeling operator to the parameter.
                                        ^  ^
      -   any message as its one of the prerequistes.
      +   any message as its one of the prerequisites.
                                        ^        ^
      - * "git daemon" gives more human readble error messages to clien=
ts
      + * "git daemon" gives more human readable error messages to clie=
nts
                                        ^   ^
       - * On Cygwin, "cygstart" is now recognised as a possible way to=
 start
       + * On Cygwin, "cygstart" is now recognized as a possible way to=
 start
                                        ^      ^
removed and a stage-0 entry with proper resoluton
removed and a stage-0 entry with proper resolution
                                        ^      ^
card the candidate; we know it does not satisify fn */
card the candidate; we know it does not satisfy fn */
                                        ^   ^
cset->range_ends, is a pointer argument sinse we may
cset->range_ends, is a pointer argument since we may
                                        ^  ^
cset->range_ends, is a pointer argument sinse we may
cset->range_ends, is a pointer argument since we may
                                        ^  ^
                 -     pointer argument sinse we may update it.  */
                 +     pointer argument since we may update it.  */
                                        ^  ^
            -     is a pointer argument sinse we may update it.  */
            +     is a pointer argument since we may update it.  */
                                        ^  ^
            -     is a pointer argument sinse we may update it.  */
            +     is a pointer argument since we may update it.  */
                                        ^  ^
                                 -   be techinically correct but not fr=
iendly to people who are trying
                                 +   be technically correct but not fri=
endly to people who are trying
                                        ^  ^
           -  /* I hope we needn't fill ther regs with -1's when no mat=
ch was found.  */
           +  /* I hope we needn't fill their regs with -1's when no ma=
tch was found.  */
                                        ^   ^

Signed-off-by: Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz>

---
 Documentation/RelNotes/1.7.10.1.txt          |  2 +-
 Documentation/RelNotes/1.7.5.4.txt           |  2 +-
 Documentation/RelNotes/1.7.8.2.txt           |  4 ++--
 Documentation/RelNotes/1.7.8.txt             |  4 ++--
 Documentation/RelNotes/1.8.2.1.txt           |  2 +-
 Documentation/RelNotes/1.8.2.2.txt           |  2 +-
 Documentation/RelNotes/1.8.2.txt             |  2 +-
 Documentation/RelNotes/1.8.4.txt             |  4 ++--
 Documentation/git-bisect-lk2009.txt          |  2 +-
 Documentation/git-rev-parse.txt              |  2 +-
 Documentation/gitweb.txt                     |  2 +-
 Documentation/howto/revert-branch-rebase.txt |  2 +-
 Documentation/rev-list-options.txt           |  2 +-
 Documentation/technical/index-format.txt     |  2 +-
 Documentation/technical/racy-git.txt         |  2 +-
 compat/nedmalloc/Readme.txt                  |  2 +-
 compat/nedmalloc/malloc.c.h                  |  4 ++--
 compat/regex/regcomp.c                       | 16 ++++++++--------
 compat/regex/regexec.c                       |  6 +++---
 convert.c                                    |  2 +-
 convert.h                                    |  2 +-
 diff.c                                       |  2 +-
 kwset.c                                      | 10 +++++-----
 sha1_name.c                                  |  2 +-
 24 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/Documentation/RelNotes/1.7.10.1.txt b/Documentation/RelNot=
es/1.7.10.1.txt
index 806a965..be68524 100644
--- a/Documentation/RelNotes/1.7.10.1.txt
+++ b/Documentation/RelNotes/1.7.10.1.txt
@@ -14,7 +14,7 @@ Fixes since v1.7.10
    not exclude them and tried to apply funny patches only to fail.
=20
  * "git blame" started missing quite a few changes from the origin
-   since we stopped using the diff minimalization by default in v1.7.2
+   since we stopped using the diff minimization by default in v1.7.2
    era.
=20
  * When PATH contains an unreadable directory, alias expansion code
diff --git a/Documentation/RelNotes/1.7.5.4.txt b/Documentation/RelNote=
s/1.7.5.4.txt
index cf3f455..7796df3 100644
--- a/Documentation/RelNotes/1.7.5.4.txt
+++ b/Documentation/RelNotes/1.7.5.4.txt
@@ -5,7 +5,7 @@ Fixes since v1.7.5.3
 --------------------
=20
  * The single-key mode of "git add -p" was easily fooled into thinking
-   that it was told to add everthing ('a') when up-arrow was pressed b=
y
+   that it was told to add everything ('a') when up-arrow was pressed =
by
    mistake.
=20
  * Setting a git command that uses custom configuration via "-c var=3D=
val"
diff --git a/Documentation/RelNotes/1.7.8.2.txt b/Documentation/RelNote=
s/1.7.8.2.txt
index e74f4ef..b9c66aa 100644
--- a/Documentation/RelNotes/1.7.8.2.txt
+++ b/Documentation/RelNotes/1.7.8.2.txt
@@ -12,11 +12,11 @@ Fixes since v1.7.8.1
  * The configuration file parser used for sizes (e.g. bigFileThreshold=
)
    did not correctly interpret 'g' suffix.
=20
- * The replacement implemention for snprintf used on platforms with
+ * The replacement implementation for snprintf used on platforms with
    native snprintf that is broken did not use va_copy correctly.
=20
  * LF-to-CRLF streaming filter replaced all LF with CRLF, which might
-   be techinically correct but not friendly to people who are trying
+   be technically correct but not friendly to people who are trying
    to recover from earlier mistakes of using CRLF in the repository
    data in the first place. It now refrains from doing so for LF that
    follows a CR.
diff --git a/Documentation/RelNotes/1.7.8.txt b/Documentation/RelNotes/=
1.7.8.txt
index b4d90bb..2493113 100644
--- a/Documentation/RelNotes/1.7.8.txt
+++ b/Documentation/RelNotes/1.7.8.txt
@@ -9,7 +9,7 @@ Updates since v1.7.7
  * Updates to bash completion scripts.
=20
  * The build procedure has been taught to take advantage of computed
-   dependency automatically when the complier supports it.
+   dependency automatically when the compiler supports it.
=20
  * The date parser now accepts timezone designators that lack minutes
    part and also has a colon between "hh:mm".
@@ -31,7 +31,7 @@ Updates since v1.7.7
  * Variants of "git cherry-pick" and "git revert" that take multiple
    commits learned to "--continue" and "--abort".
=20
- * "git daemon" gives more human readble error messages to clients
+ * "git daemon" gives more human readable error messages to clients
    using ERR packets when appropriate.
=20
  * Errors at the network layer is logged by "git daemon".
diff --git a/Documentation/RelNotes/1.8.2.1.txt b/Documentation/RelNote=
s/1.8.2.1.txt
index 1354ad0..769a6fc 100644
--- a/Documentation/RelNotes/1.8.2.1.txt
+++ b/Documentation/RelNotes/1.8.2.1.txt
@@ -49,7 +49,7 @@ Fixes since v1.8.2
    common prefix and suffix between the two filenames overlapped.
=20
  * "git submodule update", when recursed into sub-submodules, did not
-   acccumulate the prefix paths.
+   accumulate the prefix paths.
=20
  * "git am $maildir/" applied messages in an unexpected order; sort
    filenames read from the maildir/ in a way that is more likely to
diff --git a/Documentation/RelNotes/1.8.2.2.txt b/Documentation/RelNote=
s/1.8.2.2.txt
index dab4831..708df1a 100644
--- a/Documentation/RelNotes/1.8.2.2.txt
+++ b/Documentation/RelNotes/1.8.2.2.txt
@@ -58,4 +58,4 @@ Fixes since v1.8.2.1
    conflicts have been applied.
=20
  * "git bundle" did not like a bundle created using a commit without
-   any message as its one of the prerequistes.
+   any message as its one of the prerequisites.
diff --git a/Documentation/RelNotes/1.8.2.txt b/Documentation/RelNotes/=
1.8.2.txt
index fc606ae..5da2a9d 100644
--- a/Documentation/RelNotes/1.8.2.txt
+++ b/Documentation/RelNotes/1.8.2.txt
@@ -67,7 +67,7 @@ UI, Workflows & Features
  * The completion script (in contrib/completion) used to let the
    default completer to suggest pathnames, which gave too many
    irrelevant choices (e.g. "git add" would not want to add an
-   unmodified path).  It learnt to use a more git-aware logic to
+   unmodified path).  It learned to use a more git-aware logic to
    enumerate only relevant ones.
=20
  * In bare repositories, "git shortlog" and other commands now read
diff --git a/Documentation/RelNotes/1.8.4.txt b/Documentation/RelNotes/=
1.8.4.txt
index 2226abe..fc903f4 100644
--- a/Documentation/RelNotes/1.8.4.txt
+++ b/Documentation/RelNotes/1.8.4.txt
@@ -149,7 +149,7 @@ UI, Workflows & Features
    thing after you set "user.name/email" to introduce yourselves to
    Git.  Now the variable defaults to "auto".
=20
- * On Cygwin, "cygstart" is now recognised as a possible way to start
+ * On Cygwin, "cygstart" is now recognized as a possible way to start
    a web browser (used in "help -w" and "instaweb" among others).
=20
  * "git status" learned status.branch and status.short configuration
@@ -160,7 +160,7 @@ UI, Workflows & Features
    directly uses the 40-hex string as an object name, even if a ref
    "refs/<some hierarchy>/<name>" exists.  This disambiguation order
    is unlikely to change, but we should warn about the ambiguity just
-   like we warn when more than one refs/ hierachies share the same
+   like we warn when more than one refs/ hierarchies share the same
    name.
=20
  * "git rebase" learned "--[no-]autostash" option to save local
diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bi=
sect-lk2009.txt
index 0eed3e3..afeb86c 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -1320,7 +1320,7 @@ So git bisect is unconditional goodness - and fee=
l free to quote that
 ;-)
 _____________
=20
-Acknowledgements
+Acknowledgments
 ----------------
=20
 Many thanks to Junio Hamano for his help in reviewing this paper, for
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index 993903c..2b126c0 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -83,7 +83,7 @@ eval "set -- $(git rev-parse --sq --prefix "$prefix" =
"$@")"
 +
 If you want to make sure that the output actually names an object in
 your object database and/or can be used as a specific type of object
-you require, you can add "^{type}" peeling operator to the parmeter.
+you require, you can add "^{type}" peeling operator to the parameter.
 For example, `git rev-parse "$VAR^{commit}"` will make sure `$VAR`
 names an existing object that is a commit-ish (i.e. a commit, or an
 annotated tag that points at a commit).  To make sure that `$VAR`
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 40969f1..cca14b8 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -504,7 +504,7 @@ repositories, you can configure Apache like this:
=20
 The above configuration expects your public repositories to live under
 '/pub/git' and will serve them as `http://git.domain.org/dir-under-pub=
-git`,
-both as cloneable Git URL and as browseable gitweb interface.  If you =
then
+both as clonable Git URL and as browseable gitweb interface.  If you t=
hen
 start your linkgit:git-daemon[1] with `--base-path=3D/pub/git --export=
-all`
 then you can even use the `git://` URL with exactly the same path.
=20
diff --git a/Documentation/howto/revert-branch-rebase.txt b/Documentati=
on/howto/revert-branch-rebase.txt
index 84dd839..29a7cfa 100644
--- a/Documentation/howto/revert-branch-rebase.txt
+++ b/Documentation/howto/revert-branch-rebase.txt
@@ -12,7 +12,7 @@ How to revert an existing commit
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
=20
 One of the changes I pulled into the 'master' branch turns out to
-break building Git with GCC 2.95.  While they were well intentioned
+break building Git with GCC 2.95.  While they were well intended
 portability fixes, keeping things working with gcc-2.95 was also
 important.  Here is what I did to revert the change in the 'master'
 branch and to adjust the 'pu' branch, using core Git tools and
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index e157ec3..60a65a7 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -369,7 +369,7 @@ each merge.  The commits are:
 * `E` changes `quux` to "xyzzy", and its merge `P` combines the
   strings to "quux xyzzy".  `P` is TREESAME to `O`, but not to `E`.
=20
-* `X` is an indpendent root commit that added a new file `side`, and `=
Y`
+* `X` is an independent root commit that added a new file `side`, and =
`Y`
   modified it. `Y` is TREESAME to `X`. Its merge `Q` added `side` to `=
P`, and
   `Q` is TREESAME to `P`, but not to `Y`.
=20
diff --git a/Documentation/technical/index-format.txt b/Documentation/t=
echnical/index-format.txt
index 0810251..f352a9b 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -175,7 +175,7 @@ Git index format
=20
   A conflict is represented in the index as a set of higher stage entr=
ies.
   When a conflict is resolved (e.g. with "git add path"), these higher
-  stage entries will be removed and a stage-0 entry with proper resolu=
ton
+  stage entries will be removed and a stage-0 entry with proper resolu=
tion
   is added.
=20
   When these higher stage entries are removed, they are saved in the
diff --git a/Documentation/technical/racy-git.txt b/Documentation/techn=
ical/racy-git.txt
index f716d6d..242a044 100644
--- a/Documentation/technical/racy-git.txt
+++ b/Documentation/technical/racy-git.txt
@@ -46,7 +46,7 @@ because in-core timestamps can have finer granularity=
 than
 on-disk timestamps, resulting in meaningless changes when an
 inode is evicted from the inode cache.  See commit 8ce13b0
 of git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
-([PATCH] Sync in core time granuality with filesystems,
+([PATCH] Sync in core time granularity with filesystems,
 2005-01-04).
=20
 Racy Git
diff --git a/compat/nedmalloc/Readme.txt b/compat/nedmalloc/Readme.txt
index e46d8f1..07cbf50 100644
--- a/compat/nedmalloc/Readme.txt
+++ b/compat/nedmalloc/Readme.txt
@@ -97,7 +97,7 @@ Chew for reporting this.
=20
 v1.04alpha_svn915 7th October 2006:
  * Fixed failure to unlock thread cache list if allocating a new list =
failed.
-Thanks to Dmitry Chichkov for reporting this. Futher thanks to Aleksey=
 Sanin.
+Thanks to Dmitry Chichkov for reporting this. Further thanks to Alekse=
y Sanin.
  * Fixed realloc(0, <size>) segfaulting. Thanks to Dmitry Chichkov for
 reporting this.
  * Made config defines #ifndef so they can be overridden by the build =
system.
diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index 5a44dea..ed4f1fa 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -3602,8 +3602,8 @@ static void internal_malloc_stats(mstate m) {
      and choose its bk node as its replacement.
   2. If x was the last node of its size, but not a leaf node, it must
      be replaced with a leaf node (not merely one with an open left or
-     right), to make sure that lefts and rights of descendents
-     correspond properly to bit masks.  We use the rightmost descenden=
t
+     right), to make sure that lefts and rights of descendants
+     correspond properly to bit masks.  We use the rightmost descendan=
t
      of x.  We could use any other leaf, but this is easy to locate an=
d
      tends to counteract removal of leftmosts elsewhere, and so keeps
      paths shorter than minimally guaranteed.  This doesn't loop much
diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index d0025bd..b2c5d46 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -2617,7 +2617,7 @@ parse_dup_op (bin_tree_t *elem, re_string_t *rege=
xp, re_dfa_t *dfa,
      Build the range expression which starts from START_ELEM, and ends
      at END_ELEM.  The result are written to MBCSET and SBCSET.
      RANGE_ALLOC is the allocated size of mbcset->range_starts, and
-     mbcset->range_ends, is a pointer argument sinse we may
+     mbcset->range_ends, is a pointer argument since we may
      update it.  */
=20
 static reg_errcode_t
@@ -2788,7 +2788,7 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t =
*dfa, re_token_t *token,
   const int32_t *symb_table;
   const unsigned char *extra;
=20
-  /* Local function for parse_bracket_exp used in _LIBC environement.
+  /* Local function for parse_bracket_exp used in _LIBC environment.
      Seek the collating symbol entry correspondings to NAME.
      Return the index of the symbol in the SYMB_TABLE.  */
=20
@@ -2892,11 +2892,11 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_=
t *dfa, re_token_t *token,
       return UINT_MAX;
     }
=20
-  /* Local function for parse_bracket_exp used in _LIBC environement.
+  /* Local function for parse_bracket_exp used in _LIBC environment.
      Build the range expression which starts from START_ELEM, and ends
      at END_ELEM.  The result are written to MBCSET and SBCSET.
      RANGE_ALLOC is the allocated size of mbcset->range_starts, and
-     mbcset->range_ends, is a pointer argument sinse we may
+     mbcset->range_ends, is a pointer argument since we may
      update it.  */
=20
   auto inline reg_errcode_t
@@ -2976,11 +2976,11 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_=
t *dfa, re_token_t *token,
       return REG_NOERROR;
     }
=20
-  /* Local function for parse_bracket_exp used in _LIBC environement.
+  /* Local function for parse_bracket_exp used in _LIBC environment.
      Build the collating element which is represented by NAME.
      The result are written to MBCSET and SBCSET.
      COLL_SYM_ALLOC is the allocated size of mbcset->coll_sym, is a
-     pointer argument sinse we may update it.  */
+     pointer argument since we may update it.  */
=20
   auto inline reg_errcode_t
   __attribute ((always_inline))
@@ -3419,7 +3419,7 @@ parse_bracket_symbol (bracket_elem_t *elem, re_st=
ring_t *regexp,
      Build the equivalence class which is represented by NAME.
      The result are written to MBCSET and SBCSET.
      EQUIV_CLASS_ALLOC is the allocated size of mbcset->equiv_classes,
-     is a pointer argument sinse we may update it.  */
+     is a pointer argument since we may update it.  */
=20
 static reg_errcode_t
 #ifdef RE_ENABLE_I18N
@@ -3515,7 +3515,7 @@ build_equiv_class (bitset_t sbcset, const unsigne=
d char *name)
      Build the character class which is represented by NAME.
      The result are written to MBCSET and SBCSET.
      CHAR_CLASS_ALLOC is the allocated size of mbcset->char_classes,
-     is a pointer argument sinse we may update it.  */
+     is a pointer argument since we may update it.  */
=20
 static reg_errcode_t
 #ifdef RE_ENABLE_I18N
diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index 0cd6e0e..9d5f1c6 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -455,7 +455,7 @@ re_search_stub (struct re_pattern_buffer *bufp,
=20
   rval =3D 0;
=20
-  /* I hope we needn't fill ther regs with -1's when no match was foun=
d.  */
+  /* I hope we needn't fill their regs with -1's when no match was fou=
nd.  */
   if (result !=3D REG_NOERROR)
     rval =3D -1;
   else if (regs !=3D NULL)
@@ -1071,7 +1071,7 @@ acquire_init_state_context (reg_errcode_t *err, c=
onst re_match_context_t *mctx,
    FL_LONGEST_MATCH means we want the POSIX longest matching.
    If P_MATCH_FIRST is not NULL, and the match fails, it is set to the
    next place where we may want to try matching.
-   Note that the matcher assume that the maching starts from the curre=
nt
+   Note that the matcher assume that the matching starts from the curr=
ent
    index of the buffer.  */
=20
 static int
@@ -2239,7 +2239,7 @@ sift_states_iter_mb (const re_match_context_t *mc=
tx, re_sift_context_t *sctx,
 			    dfa->nexts[node_idx]))
     /* The node can't accept the `multi byte', or the
        destination was already thrown away, then the node
-       could't accept the current input `multi byte'.   */
+       couldn't accept the current input `multi byte'.   */
     naccepted =3D 0;
   /* Otherwise, it is sure that the node could accept
      `naccepted' bytes input.  */
diff --git a/convert.c b/convert.c
index 2a2e46c..11a95fc 100644
--- a/convert.c
+++ b/convert.c
@@ -835,7 +835,7 @@ int renormalize_buffer(const char *path, const char=
 *src, size_t len, struct str
=20
 /*****************************************************************
  *
- * Streaming converison support
+ * Streaming conversion support
  *
  *****************************************************************/
=20
diff --git a/convert.h b/convert.h
index ec5fd69..0c2143c 100644
--- a/convert.h
+++ b/convert.h
@@ -48,7 +48,7 @@ static inline int would_convert_to_git(const char *pa=
th, const char *src,
=20
 /*****************************************************************
  *
- * Streaming converison support
+ * Streaming conversion support
  *
  *****************************************************************/
=20
diff --git a/diff.c b/diff.c
index e53ddad..71ee39c 100644
--- a/diff.c
+++ b/diff.c
@@ -4460,7 +4460,7 @@ void diff_flush(struct diff_options *options)
 	    DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
 		/*
 		 * run diff_flush_patch for the exit status. setting
-		 * options->file to /dev/null should be safe, becaue we
+		 * options->file to /dev/null should be safe, because we
 		 * aren't supposed to produce any output anyway.
 		 */
 		if (options->close_file)
diff --git a/kwset.c b/kwset.c
index 5800999..a0f49b3 100644
--- a/kwset.c
+++ b/kwset.c
@@ -65,7 +65,7 @@ struct trie
   struct trie *fail;		/* Aho-Corasick failure function. */
   int depth;			/* Depth of this node from the root. */
   int shift;			/* Shift function for search failures. */
-  int maxshift;			/* Max shift of self and descendents. */
+  int maxshift;			/* Max shift of self and descendants. */
 };
=20
 /* Structure returned opaquely to the caller, containing everything. *=
/
@@ -308,7 +308,7 @@ treefails (register struct tree const *tree, struct=
 trie const *fail,
   treefails(tree->rlink, fail, recourse);
=20
   /* Find, in the chain of fails going back to the root, the first
-     node that has a descendent on the current label. */
+     node that has a descendant on the current label. */
   while (fail)
     {
       link =3D fail->links;
@@ -426,13 +426,13 @@ kwsprep (kwset_t kws)
 	 computing the delta table, failure function, and shift function. */
       for (curr =3D last =3D kwset->trie; curr; curr =3D curr->next)
 	{
-	  /* Enqueue the immediate descendents in the level order queue. */
+	  /* Enqueue the immediate descendants in the level order queue. */
 	  enqueue(curr->links, &last);
=20
 	  curr->shift =3D kwset->mind;
 	  curr->maxshift =3D kwset->mind;
=20
-	  /* Update the delta table for the descendents of this node. */
+	  /* Update the delta table for the descendants of this node. */
 	  treedelta(curr->links, curr->depth, delta);
=20
 	  /* Compute the failure function for the descendants of this node. *=
/
@@ -450,7 +450,7 @@ kwsprep (kwset_t kws)
 		  fail->shift =3D curr->depth - fail->depth;
=20
 	      /* If the current node is accepting then the shift at the
-		 fail and its descendents should be no larger than the
+		 fail and its descendants should be no larger than the
 		 difference of their depths. */
 	      if (curr->accepting && fail->maxshift > curr->depth - fail->dep=
th)
 		fail->maxshift =3D curr->depth - fail->depth;
diff --git a/sha1_name.c b/sha1_name.c
index 1a75fac..551d9cb 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -52,7 +52,7 @@ static void update_candidates(struct disambiguate_sta=
te *ds, const unsigned char
 	}
=20
 	if (!ds->candidate_ok) {
-		/* discard the candidate; we know it does not satisify fn */
+		/* discard the candidate; we know it does not satisfy fn */
 		hashcpy(ds->candidate, current);
 		ds->candidate_checked =3D 0;
 		return;
--=20
1.8.3.2
