Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 539771F406
	for <e@80x24.org>; Fri, 29 Dec 2017 04:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754928AbdL2Eaj (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 23:30:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57809 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754164AbdL2Eaf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 23:30:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B600ECA830;
        Thu, 28 Dec 2017 23:30:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=3NugxVYgevM7zgr7l/Ot455V/
        BU=; b=K21J+0+t2JW9Eocccjz3c8bjBmsbZHWlKBDsWGq5BQXKUkyV/dtjjksiy
        ClCgcKFdwIfoG2kCi/Igttg/odYotBelbTCpau+xStinUYy0JAdBmJv+liby/lu4
        iloJxUFYr6A6iG/ZjpOLGUdTUV1a4bN8564kPLaNWo1Sfu9kPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=dZ4PMV2KDUOvyvwLWPM
        JMQScfasWu0GjMdNC1iZ3A4AkpZlAeku2Kx+qZviXDwkHxcTFXaENA7x0zMQKuPF
        7qd4LRAY+CYHBg6YFnJLrvD+DJHE/3rUEsVE9P+khhxucnBPxSjK4FiGzR+pFDiM
        2NJMca2E27548kyC9dh1aJBk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD199CA82F;
        Thu, 28 Dec 2017 23:30:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC08ACA82E;
        Thu, 28 Dec 2017 23:30:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.16.0-rc0
Date:   Thu, 28 Dec 2017 20:30:32 -0800
Message-ID: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 02A86E2E-EC51-11E7-9F68-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An early preview release Git v2.16.0-rc0 is now available for
testing at the usual places.  It is comprised of 435 non-merge
commits since v2.15.0, contributed by 76 people, 22 of which are
new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.16.0-rc0' tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.15.0 are as follows.
Welcome to the Git development community!

  Albert Astals Cid, Antoine Beaupr=C3=A9, Damien Mari=C3=A9, Daniel
  Bensoussan, Florian Klink, Gennady Kupava, Guillaume Castagnino,
  Haaris Mehmood, Hans Jerry Illikainen, Ingo Ruhnke, Jakub
  Bere=C5=BCa=C5=84ski, Jean Carlo Machado, J Wyman, Kevin, =C5=81ukasz
  Stelmach, Marius Paliga, Olga Telezhnaya, Rafael Ascens=C3=A3o,
  Robert Abel, Robert P. J. Day, Shuyu Wei, and Wei Shuyu.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Adam Dinwoodie, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Alex Vandiver,
  Anders Kaseorg, Andrey Okoshkin, Ann T Ropea, Beat Bolli, Ben
  Peart, Brandon Williams, brian m. carlson, Carlos Mart=C3=ADn Nieto,
  Charles Bailey, Christian Couder, Dennis Kaarsemaker, Derrick
  Stolee, Elijah Newren, Emily Xie, Eric Sunshine, Eric Wong,
  Heiko Voigt, Jacob Keller, Jameson Miller, Jean-Noel Avila,
  Jeff Hostetler, Jeff King, Johannes Schindelin, Jonathan Nieder,
  Jonathan Tan, Junio C Hamano, Kaartic Sivaraam, Kevin Daudt,
  Lars Schneider, Liam Beguin, Martin =C3=85gren, Michael Haggerty,
  Nicolas Morey-Chaisemartin, Phil Hord, Phillip Wood, Pranit
  Bauva, Prathamesh Chavan, Ramsay Jones, Randall S. Becker,
  Rasmus Villemoes, Ren=C3=A9 Scharfe, Simon Ruderich, Stefan Beller,
  Steffen Prohaska, Stephan Beyer, SZEDER G=C3=A1bor, Thomas Braun,
  Thomas Gummerer, Todd Zullinger, Torsten B=C3=B6gershausen, and
  W. Trevor King.

----------------------------------------------------------------

Git 2.16 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Backward compatibility notes and other notable changes.

 * Use of an empty string as a pathspec element that is used for
   'everything matches' is now an error.


Updates since v2.15
-------------------

UI, Workflows & Features

 * An empty string as a pathspec element that means "everything"
   i.e. 'git add ""', is now illegal.  We started this by first
   deprecating and warning a pathspec that has such an element in
   2.11 (Nov 2016).

 * A hook script that is set unexecutable is simply ignored.  Git
   notifies when such a file is ignored, unless the message is
   squelched via advice.ignoredHook configuration.

 * "git pull" has been taught to accept "--[no-]signoff" option and
   pass it down to "git merge".

 * The "--push-option=3D<string>" option to "git push" now defaults to a
   list of strings configured via push.pushOption variable.

 * "gitweb" checks if a directory is searchable with Perl's "-x"
   operator, which can be enhanced by using "filetest 'access'"
   pragma, which now we do.

 * "git stash save" has been deprecated in favour of "git stash push".

 * The set of paths output from "git status --ignored" was tied
   closely with its "--untracked=3D<mode>" option, but now it can be
   controlled more flexibly.  Most notably, a directory that is
   ignored because it is listed to be ignored in the ignore/exclude
   mechanism can be handled differently from a directory that ends up
   to be ignored only because all files in it are ignored.

 * The remote-helper for talking to MediaWiki has been updated to
   truncate an overlong pagename so that ".mw" suffix can still be
   added.

 * The remote-helper for talking to MediaWiki has been updated to
   work with mediawiki namespaces.

 * The "--format=3D..." option "git for-each-ref" takes learned to show
   the name of the 'remote' repository and the ref at the remote side
   that is affected for 'upstream' and 'push' via "%(push:remotename)"
   and friends.

 * Doc and message updates to teach users "bisect view" is a synonym
   for "bisect visualize".

 * "git bisect run" that did not specify any command to run used to go
   ahead and treated all commits to be tested as 'good'.  This has
   been corrected by making the command error out.

 * The SubmittingPatches document has been converted to produce an
   HTML version via AsciiDoc/Asciidoctor.

 * We learned to talk to watchman to speed up "git status" and other
   operations that need to see which paths have been modified.

 * The "diff" family of commands learned to ignore differences in
   carriage return at the end of line.

 * Places that know about "sendemail.to", like documentation and shell
   completion (in contrib/) have been taught about "sendemail.tocmd",
   too.

 * "git add --renormalize ." is a new and safer way to record the fact
   that you are correcting the end-of-line convention and other
   "convert_to_git()" glitches in the in-repository data.

 * "git branch" and "git checkout -b" are now forbidden from creating
   a branch whose name is "HEAD".

 * "git branch --list" learned to show its output through the pager by
   default when the output is going to a terminal, which is controlled
   by the pager.branch configuration variable.  This is similar to a
   recent change to "git tag --list".

 * "git grep -W", "git diff -W" and their friends learned a heuristic
   to extend a pre-context beyond the line that matches the "function
   pattern" (aka "diff.*.xfuncname") to include a comment block, if
   exists, that immediately precedes it.

 * "git config --expiry-date gc.reflogexpire" can read "2.weeks" from
   the configuration and report it as a timestamp, just like "--int"
   would read "1k" and report 1024, to help consumption by scripts.

 * The shell completion (in contrib/) learned that "git pull" can take
   the "--autostash" option.

 * The tagnames "git log --decorate" uses to annotate the commits can
   now be limited to subset of available refs with the two additional
   options, --decorate-refs[-exclude]=3D<pattern>.

 * "git grep" compiled with libpcre2 sometimes triggered a segfault,
   which is being fixed.

 * "git send-email" tries to see if the sendmail program is available
   in /usr/lib and /usr/sbin; extend the list of locations to be
   checked to also include directories on $PATH.

 * "git diff" learned, "--anchored", a variant of the "--patience"
   algorithm, to which the user can specify which 'unique' line to be
   used as anchoring points.

 * The way "git worktree add" determines what branch to create from
   where and checkout in the new worktree has been updated a bit.

 * Ancient part of codebase still shows dots after an abbreviated
   object name just to show that it is not a full object name, but
   these ellipses are confusing to people who newly discovered Git
   who are used to seeing abbreviated object names and find them
   confusing with the range syntax.

 * With a configuration variable rebase.abbreviateCommands set,
   "git rebase -i" produces the todo list with a single-letter
   command names.

 * "git worktree add" learned to run the post-checkout hook, just like
   "git checkout" does, after the initial checkout.

 * "git svn" has been updated to strip CRs in the commit messages, as
   recent versions of Subversion rejects them.

 * "git imap-send" did not correctly quote the folder name when
   making a request to the server, which has been corrected.

 * Error messages from "git rebase" have been somewhat cleaned up.

 * Git has been taught to support an https:// URL used for http.proxy
   when using recent versions of libcurl.

 * "git merge" learned to pay attention to merge.verifySignatures
   configuration variable and pretend as if '--verify-signatures'
   option was given from the command line.

 * "git describe" was taught to dig trees deeper to find a
   <commit-ish>:<path> that refers to a given blob object.


Performance, Internal Implementation, Development Support etc.

 * An earlier update made it possible to use an on-stack in-core
   lockfile structure (as opposed to having to deliberately leak an
   on-heap one).  Many codepaths have been updated to take advantage
   of this new facility.

 * Calling cmd_foo() as if it is a general purpose helper function is
   a no-no.  Correct two instances of such to set an example.

 * We try to see if somebody runs our test suite with a shell that
   does not support "local" like bash/dash does.

 * An early part of piece-by-piece rewrite of "git bisect" in C.

 * GSoC to piece-by-piece rewrite "git submodule" in C.

 * Optimize the code to find shortest unique prefix of object names.

 * Pathspec-limited revision traversal was taught not to keep finding
   unneeded differences once it knows two trees are different inside
   given pathspec.

 * Conversion from uchar[20] to struct object_id continues.

 * Code cleanup.

 * A single-word "unsigned flags" in the diff options is being split
   into a structure with many bitfields.

 * TravisCI build updates.

 * Parts of a test to drive the long-running content filter interface
   has been split into its own module, hopefully to eventually become
   reusable.

 * Drop (perhaps overly cautious) sanity check before using the index
   read from the filesystem at runtime.

 * The build procedure has been taught to avoid some unnecessary
   instability in the build products.

 * A new mechanism to upgrade the wire protocol in place is proposed
   and demonstrated that it works with the older versions of Git
   without harming them.

 * An infrastructure to define what hash function is used in Git is
   introduced, and an effort to plumb that throughout various
   codepaths has been started.

 * The code to iterate over loose object files got optimized.

 * An internal function that was left for backward compatibility has
   been removed, as there is no remaining callers.

 * Historically, the diff machinery for rename detection had a
   hardcoded limit of 32k paths; this is being lifted to allow users
   trade cycles with a (possibly) easier to read result.

 * The tracing infrastructure has been optimized for cases where no
   tracing is requested.

 * In preparation for implementing narrow/partial clone, the object
   walking machinery has been taught a way to tell it to "filter" some
   objects from enumeration.

 * A few structures and variables that are implementation details of
   the decorate API have been renamed and then the API got documented
   better.

 * Assorted updates for TravisCI integration.
   (merge 4f26366679 sg/travis-fixes later to maint).

 * Introduce a helper to simplify code to parse a common pattern that
   expects either "--key" or "--key=3D<something>".

 * "git version --build-options" learned to report the host CPU and
   the exact commit object name the binary was built from.

Also contains various documentation updates and code clean-ups.


Fixes since v2.15
-----------------

 * "auto" as a value for the columnar output configuration ought to
   judge "is the output consumed by humans?" with the same criteria as
   "auto" for coloured output configuration, i.e. either the standard
   output stream is going to tty, or a pager is in use.  We forgot the
   latter, which has been fixed.

 * The experimental "color moved lines differently in diff output"
   feature was buggy around "ignore whitespace changes" edges, which
   has been corrected.

 * Instead of using custom line comparison and hashing functions to
   implement "moved lines" coloring in the diff output, use the pair
   of these functions from lower-layer xdiff/ code.

 * Some codepaths did not check for errors when asking what branch the
   HEAD points at, which have been fixed.

 * "git commit", after making a commit, did not check for errors when
   asking on what branch it made the commit, which has been corrected.

 * "git status --ignored -u" did not stop at a working tree of a
   separate project that is embedded in an ignored directory and
   listed files in that other project, instead of just showing the
   directory itself as ignored.

 * A broken access to object databases in recent update to "git grep
   --recurse-submodules" has been fixed.

 * A recent regression in "git rebase -i" that broke execution of git
   commands from subdirectories via "exec" instruction has been fixed.

 * A (possibly flakey) test fix.

 * "git check-ref-format --branch @{-1}" bit a "BUG()" when run
   outside a repository for obvious reasons; clarify the documentation
   and make sure we do not even try to expand the at-mark magic in
   such a case, but still call the validation logic for branch names.

 * "git fetch --recurse-submodules" now knows that submodules can be
   moved around in the superproject in addition to getting updated,
   and finds the ones that need to be fetched accordingly.

 * Command line completion (in contrib/) update.

 * Description of blame.{showroot,blankboundary,showemail,date}
   configuration variables have been added to "git config --help".

 * After an error from lstat(), diff_populate_filespec() function
   sometimes still went ahead and used invalid data in struct stat,
   which has been fixed.

 * UNC paths are also relevant in Cygwin builds and they are now
   tested just like Mingw builds.

 * Correct start-up sequence so that a repository could be placed
   immediately under the root directory again (which was broken at
   around Git 2.13).

 * The credential helper for libsecret (in contrib/) has been improved
   to allow possibly prompting the end user to unlock secrets that are
   currently locked (otherwise the secrets may not be loaded).

 * MinGW updates.

 * Error checking in "git imap-send" for empty response has been
   improved.

 * Recent update to the refs infrastructure implementation started
   rewriting packed-refs file more often than before; this has been
   optimized again for most trivial cases.

 * Some error messages did not quote filenames shown in it, which have
   been fixed.

 * "git rebase -i" recently started misbehaving when a submodule that
   is configured with 'submodule.<name>.ignore' is dirty; this has
   been corrected.

 * Building with NO_LIBPCRE1_JIT did not disable it, which has been fixed=
.

 * We used to add an empty alternate object database to the system
   that does not help anything; it has been corrected.

 * Doc update around use of "format-patch --subject-prefix" etc.

 * A fix for an ancient bug in "git apply --ignore-space-change" codepath=
.

 * Clarify and enhance documentation for "merge-base --fork-point", as
   it was clear what it computed but not why/what for.

 * A few scripts (both in production and tests) incorrectly redirected
   their error output.  These have been corrected.

 * "git notes" sent its error message to its standard output stream,
   which was corrected.

 * The three-way merge performed by "git cherry-pick" was confused
   when a new submodule was added in the meantime, which has been
   fixed (or "papered over").

 * The sequencer machinery (used by "git cherry-pick A..B", and "git
   rebase -i", among other things) would have lost a commit if stopped
   due to an unlockable index file, which has been fixed.

 * "git apply --inaccurate-eof" when used with "--ignore-space-change"
   triggered an internal sanity check, which has been fixed.

 * Command line completion (in contrib/) has been taught about the
   "--copy" option of "git branch".

 * When "git rebase" prepared an mailbox of changes and fed it to "git
   am" to replay them, it was confused when a stray "From " happened
   to be in the log message of one of the replayed changes.  This has
   been corrected.

 * There was a recent semantic mismerge in the codepath to write out a
   section of a configuration section, which has been corrected.

 * Mentions of "git-rebase" and "git-am" (dashed form) still remained
   in end-user visible strings emitted by the "git rebase" command;
   they have been corrected.

 * Contrary to the documentation, "git pull -4/-6 other-args" did not
   ask the underlying "git fetch" to go over IPv4/IPv6, which has been
   corrected.

 * "git checkout --recursive" may overwrite and rewind the history of
   the branch that happens to be checked out in submodule
   repositories, which might not be desirable.  Detach the HEAD but
   still allow the recursive checkout to succeed in such a case.
   (merge 57f22bf997 sb/submodule-recursive-checkout-detach-head later to=
 maint).

 * "git branch --set-upstream" has been deprecated and (sort of)
   removed, as "--set-upstream-to" is the preferred one these days.
   The documentation still had "--set-upstream" listed on its
   synopsis section, which has been corrected.
   (merge a060f3d3d8 tz/branch-doc-remove-set-upstream later to maint).

 * Internally we use 0{40} as a placeholder object name to signal the
   codepath that there is no such object (e.g. the fast-forward check
   while "git fetch" stores a new remote-tracking ref says "we know
   there is no 'old' thing pointed at by the ref, as we are creating
   it anew" by passing 0{40} for the 'old' side), and expect that a
   codepath to locate an in-core object to return NULL as a sign that
   the object does not exist.  A look-up for an object that does not
   exist however is quite costly with a repository with large number
   of packfiles.  This access pattern has been optimized.
   (merge 87b5e236a1 jk/fewer-pack-rescan later to maint).

 * In addition to "git stash -m message", the command learned to
   accept "git stash -mmessage" form.
   (merge 5675473fcb ph/stash-save-m-option-fix later to maint).

 * @{-N} in "git checkout @{-N}" may refer to a detached HEAD state,
   but the documentation was not clear about it, which has been fixed.
   (merge 75ce149575 ks/doc-checkout-previous later to maint).

 * A regression in the progress eye-candy was fixed.
   (merge 9c5951cacf jk/progress-delay-fix later to maint).

 * The code internal to the recursive merge strategy was not fully
   prepared to see a path that is renamed to try overwriting another
   path that is only different in case on case insensitive systems.
   This does not matter in the current code, but will start to matter
   once the rename detection logic starts taking hints from nearby
   paths moving to some directory and moves a new path along with them.
   (merge 4cba2b0108 en/merge-recursive-icase-removal later to maint).

 * An v2.12-era regression in pathspec match logic, which made it look
   into submodule tree even when it is not desired, has been fixed.
   (merge eef3df5a93 bw/pathspec-match-submodule-boundary later to maint)=
.

 * Amending commits in git-gui broke the author name that is non-ascii
   due to incorrect enconding conversion.

 * Recent update to the submodule configuration code broke "diff-tree"
   by accidentally stopping to read from the index upfront.
   (merge fd66bcc31f bw/submodule-config-cleanup later to maint).

 * Git shows a message to tell the user that it is waiting for the
   user to finish editing when spawning an editor, in case the editor
   opens to a hidden window or somewhere obscure and the user gets
   lost.
   (merge abfb04d0c7 ls/editor-waiting-message later to maint).

 * The "safe crlf" check incorrectly triggered for contents that does
   not use CRLF as line endings, which has been corrected.
   (merge 649f1f0948 tb/check-crlf-for-safe-crlf later to maint).

 * "git clone --shared" to borrow from a (secondary) worktree did not
   work, even though "git clone --local" did.  Both are now accepted.
   (merge b3b05971c1 es/clone-shared-worktree later to maint).

 * The build procedure now allows not just the repositories but also
   the refs to be used to take pre-formatted manpages and html
   documents to install.
   (merge 65289e9dcd rb/quick-install-doc later to maint).

 * Update the shell prompt script (in contrib/) to strip trailing CR
   from strings read from various "state" files.
   (merge 041fe8fc83 ra/prompt-eread-fix later to maint).

 * Other minor doc, test and build updates and code cleanups.
   (merge 1a1fc2d5b5 rd/man-prune-progress later to maint).
   (merge 0ba014035a rd/man-reflog-add-n later to maint).
   (merge e54b63359f rd/doc-notes-prune-fix later to maint).
   (merge ff4c9b413a sp/doc-info-attributes later to maint).
   (merge 7db2cbf4f1 jc/receive-pack-hook-doc later to maint).
   (merge 5a0526264b tg/t-readme-updates later to maint).
   (merge 5e83cca0b8 jk/no-optional-locks later to maint).
   (merge 826c778f7c js/hashmap-update-sample later to maint).
   (merge 176b2d328c sg/setup-doc-update later to maint).
   (merge 1b09073514 rs/am-builtin-leakfix later to maint).
   (merge addcf6cfde rs/fmt-merge-msg-string-leak-fix later to maint).
   (merge c3ff8f6c14 rs/strbuf-read-once-reset-length later to maint).
   (merge 6b0eb884f9 db/doc-workflows-neuter-the-maintainer later to main=
t).
   (merge 8c87bdfb21 jk/cvsimport-quoting later to maint).
   (merge 176cb979fe rs/fmt-merge-msg-leakfix later to maint).
   (merge 5a03360e73 tb/delimit-pretty-trailers-args-with-comma later to =
maint).
   (merge d0e6326026 ot/pretty later to maint).
   (merge 44103f4197 sb/test-helper-excludes later to maint).
   (merge 170078693f jt/transport-no-more-rsync later to maint).
   (merge c07b3adff1 bw/path-doc later to maint).
   (merge bf9d7df950 tz/lib-git-svn-svnserve-tests later to maint).
   (merge dec366c9a8 sr/http-sslverify-config-doc later to maint).

----------------------------------------------------------------

Changes since v2.15.0 are as follows:

Adam Dinwoodie (3):
      t5580: add Cygwin support
      rebase -i: fix comment typo
      doc/SubmittingPatches: correct subject guidance

Albert Astals Cid (1):
      completion: add --autostash and --no-autostash to pull

Alex Vandiver (7):
      fsmonitor: read entirety of watchman output
      fsmonitor: set the PWD to the top of the working tree
      fsmonitor: don't bother pretty-printing JSON from watchman
      fsmonitor: document GIT_TRACE_FSMONITOR
      fsmonitor: delay updating state until after split index is merged
      fsmonitor: read from getcwd(), not the PWD environment variable
      fsmonitor: store fsmonitor bitmap before splitting index

Anders Kaseorg (1):
      git-gui: sort entries in optimized tclIndex

Andrey Okoshkin (3):
      commit: check result of resolve_ref_unsafe
      diff: fix lstat() error handling in diff_populate_filespec()
      merge-recursive: check GIT_MERGE_VERBOSITY only once

Ann T Ropea (7):
      Documentation: revisions: fix typo: "three dot" ---> "three-dot" (i=
n line with "two-dot").
      Documentation: user-manual: limit usage of ellipsis
      print_sha1_ellipsis: introduce helper
      checkout: describe_detached_head: remove ellipsis after committish
      t4013: prepare for upcoming "diff --raw --abbrev" output format cha=
nge
      diff: diff_aligned_abbrev: remove ellipsis after abbreviated SHA-1 =
value
      t4013: test new output from diff --abbrev --raw

Antoine Beaupr=C3=A9 (6):
      remote-mediawiki: limit filenames to legal
      remote-mediawiki: show known namespace choices on failure
      remote-mediawiki: skip virtual namespaces
      remote-mediawiki: support fetching from (Main) namespace
      remote-mediawiki: process namespaces in order
      remote-mediawiki: show progress while fetching namespaces

Beat Bolli (1):
      contrib/git-jump: allow to configure the grep command

Ben Peart (16):
      bswap: add 64 bit endianness helper get_be64
      preload-index: add override to enable testing preload-index
      update-index: add a new --force-write-index option
      fsmonitor: teach git to optionally utilize a file system monitor to=
 speed up detecting new or changed files.
      fsmonitor: add documentation for the fsmonitor extension.
      ls-files: Add support in ls-files to display the fsmonitor valid bi=
t
      update-index: add fsmonitor support to update-index
      fsmonitor: add a test tool to dump the index extension
      split-index: disable the fsmonitor extension when running the split=
 index test
      fsmonitor: add test cases for fsmonitor extension
      fsmonitor: add a sample integration script for Watchman
      fsmonitor: add a performance test
      fsmonitor: MINGW support for watchman integration
      fsmonitor: preserve utf8 filenames in fsmonitor-watchman log
      read_index_from(): speed index loading by skipping verification of =
the entry order
      fsmonitor: simplify determining the git worktree under Windows

Brandon Williams (24):
      pkt-line: add packet_write function
      protocol: introduce protocol extension mechanisms
      daemon: recognize hidden request arguments
      upload-pack, receive-pack: introduce protocol version 1
      connect: teach client to recognize v1 server response
      connect: tell server that the client understands v1
      http: tell server that the client understands v1
      i5700: add interop test for protocol transition
      ssh: introduce a 'simple' ssh variant
      add, reset: use DIFF_OPT_SET macro to set a diff flag
      diff: convert flags to be stored in bitfields
      diff: add flag to indicate textconv was set via cmdline
      diff: remove touched flags
      diff: remove DIFF_OPT_TST macro
      diff: remove DIFF_OPT_SET macro
      diff: remove DIFF_OPT_CLR macro
      diff: make struct diff_flags members lowercase
      wt-status: actually ignore submodules when requested
      pathspec: only match across submodule boundaries when requested
      diff-tree: read the index so attribute checks work in bare reposito=
ries
      submodule: convert stage_updated_gitmodules to take a struct index_=
state
      submodule: used correct index in is_staging_gitmodules_ok
      submodule: convert get_next_submodule to not rely on the_index
      path: document path functions

Carlos Mart=C3=ADn Nieto (1):
      diff: --indent-heuristic is no longer experimental

Charles Bailey (2):
      t4201: make use of abbreviation in the test more robust
      grep: fix NO_LIBPCRE1_JIT to fully disable JIT

Christian Couder (24):
      perf/run: add '--config' option to the 'run' script
      perf/run: add get_var_from_env_or_config()
      perf/run: add GIT_PERF_DIRS_OR_REVS
      perf/run: add calls to get_var_from_env_or_config()
      perf/run: add get_subsections()
      perf/run: update get_var_from_env_or_config() for subsections
      perf/run: add run_subsection()
      perf/run: show name of rev being built
      perf: store subsection results in "test-results/$GIT_PERF_SUBSECTIO=
N/"
      t0021/rot13-filter: fix list comparison
      t0021/rot13-filter: refactor packet reading functions
      t0021/rot13-filter: improve 'if .. elsif .. else' style
      t0021/rot13-filter: improve error message
      t0021/rot13-filter: add packet_initialize()
      t0021/rot13-filter: refactor checking final lf
      t0021/rot13-filter: add capability functions
      Git/Packet.pm: extract parts of t0021/rot13-filter.pl for reuse
      Git/Packet: clarify that packet_required_key_val_read allows EOF
      Git/Packet.pm: use 'if' instead of 'unless'
      list-objects-filter-options: fix 'keword' typo in comment
      git-compat-util: introduce skip_to_optional_arg()
      index-pack: use skip_to_optional_arg()
      diff: use skip_to_optional_arg()
      diff: use skip_to_optional_arg_default()

Damien Mari=C3=A9 (1):
      run-command: add hint when a hook is ignored

Daniel Bensoussan (1):
      doc: reword gitworkflows.txt for neutrality

Dennis Kaarsemaker (1):
      credential-libsecret: unlock locked secrets

Derrick Stolee (5):
      p4211-line-log.sh: add log --online --raw --parents perf test
      sha1_name: unroll len loop in find_unique_abbrev_r()
      sha1_name: parse less while finding common prefix
      sha1_name: minimize OID comparisons during disambiguation
      sha1_file: use strbuf_add() instead of strbuf_addf()

Elijah Newren (7):
      sequencer: warn when internal merge may be suboptimal due to rename=
Limit
      merge-recursive: handle addition of submodule on our side of histor=
y
      progress: fix progress meters when dealing with lots of work
      diff: remove silent clamp of renameLimit
      sequencer: show rename progress during cherry picks
      merge-recursive: ignore_case shouldn't reject intentional removals
      strbuf: remove unused stripspace function alias

Emily Xie (1):
      pathspec: die on empty strings as pathspec

Eric Sunshine (3):
      worktree: invoke post-checkout hook (unless --no-checkout)
      clone: support 'clone --shared' from a worktree
      version --build-options: also report host CPU

Eric Wong (2):
      rebase: use mboxrd format to avoid split errors
      git-svn: convert CRLF to LF in commit message to SVN

Florian Klink (1):
      git-send-email: honor $PATH for sendmail binary

Gennady Kupava (2):
      trace: remove trace key normalization
      trace: improve performance while category is disabled

Guillaume Castagnino (1):
      gitweb: use filetest to allow ACLs

Haaris Mehmood (1):
      config: add --expiry-date

Hans Jerry Illikainen (2):
      merge: add config option for verifySignatures
      t: add tests for pull --verify-signatures

Heiko Voigt (3):
      fetch: add test to make sure we stay backwards compatible
      implement fetching of moved submodules
      submodule: simplify decision tree whether to or not to fetch

Ingo Ruhnke (1):
      remote-mediawiki: allow fetching namespaces with spaces

J Wyman (1):
      for-each-ref: let upstream/push report the remote ref name

Jacob Keller (2):
      sequencer: pass absolute GIT_DIR to exec commands
      diff: add tests for --relative without optional prefix value

Jakub Bere=C5=BCa=C5=84ski (2):
      t0302: check helper can handle empty credentials
      wincred: handle empty username/password correctly

Jameson Miller (4):
      status: add option to show ignored files differently
      status: report matching ignored and normal untracked
      status: document options to show matching ignored files
      status: test ignored modes

Jean Carlo Machado (1):
      fix typos in 2.15.0 release notes

Jean-Noel Avila (1):
      submodule--helper.c: i18n: add a missing space in message

Jeff Hostetler (9):
      dir: allow exclusions from blob in addition to file
      oidmap: add oidmap iterator methods
      oidset: add iterator methods to oidset
      list-objects: filter objects in traverse_commit_list
      rev-list: add list-objects filtering support
      pack-objects: add list-objects filtering
      list-objects-filter-options: support --no-filter
      rev-list: support --no-filter argument
      partial-clone: design doc

Jeff King (22):
      revision: quit pruning diff more quickly when possible
      t4015: refactor --color-moved whitespace test
      t4015: check "negative" case for "-w --color-moved"
      t4015: test the output of "diff --color-moved -b"
      diff: fix whitespace-skipping with --color-moved
      diff: handle NULs in get_string_hash()
      test-ref-store: avoid passing NULL to printf
      remote: handle broken symrefs
      log: handle broken HEAD in decoration check
      worktree: handle broken symrefs in find_shared_symref()
      setup: avoid double slashes when looking for HEAD
      link_alt_odb_entries: make empty input a noop
      git-jump: give contact instructions in the README
      p5550: factor out nonsense-pack creation
      t/perf/lib-pack: use fast-import checkpoint to create packs
      p5551: add a script to test fetch pack-dir rescans
      everything_local: use "quick" object existence check
      sha1_file: fast-path null sha1 as a missing object
      git-status.txt: mention --no-optional-locks
      progress: set default delay threshold to 100%, not 0%
      docs/pretty-formats: mention commas in %(trailers) syntax
      cvsimport: apply shell-quoting regex globally

Johannes Schindelin (9):
      for-each-ref: let upstream/push optionally report the remote name
      status: do not get confused by submodules in excluded directories
      mingw: include the full version information in the resources
      mingw: add experimental feature to redirect standard handles
      mingw: optionally redirect stderr/stdout via the same handle
      mingw: document the standard handle redirection
      for-each-ref: test :remotename and :remoteref
      hashmap: adjust documentation to reflect reality
      version --build-options: report commit, too, if possible

Jonathan Nieder (10):
      ssh test: make copy_ssh_wrapper_as clean up after itself
      connect: move no_fork fallback to git_tcp_connect
      connect: split git:// setup into a separate function
      connect: split ssh command line options into separate function
      connect: split ssh option computation to its own function
      ssh: 'auto' variant to select between 'ssh' and 'simple'
      ssh: 'simple' variant does not support -4/-6
      ssh: 'simple' variant does not support --port
      connect: correct style of C-style comment
      generate-cmdlist: avoid non-deterministic output

Jonathan Tan (10):
      connect: in ref advertisement, shallows are last
      Documentation: document Extra Parameters
      Tests: clean up and document submodule helpers
      Tests: clean up submodule recursive helpers
      diff: support anchoring line(s)
      diffcore-rename: make diff-tree -l0 mean -l<large>
      decorate: clean up and document API
      transport: remove unused "push" in vtable
      clone, fetch: remove redundant transport check
      transport: make transport vtable more private

Junio C Hamano (37):
      t0027: do not use an empty string as a pathspec element
      describe: do not use cmd_*() as a subroutine
      merge-ours: do not use cmd_*() as a subroutine
      branch: streamline "attr_only" handling in validate_new_branchname(=
)
      branch: split validate_new_branchname() into two
      t5601: rm the target file of cp that could still be executing
      check-ref-format --branch: do not expand @{...} outside repository
      check-ref-format --branch: strip refs/heads/ using skip_prefix
      check-ref-format doc: --branch validates and expands <branch>
      column: do not include pager.c
      xdiff: reassign xpparm_t.flags bits
      The first batch for 2.16
      RelNotes: the second batch post 2.15 comes
      diff: --ignore-cr-at-eol
      merge-base --fork-point doc: clarify the example and failure modes
      RelNotes: the third batch for 2.16
      branch: correctly reject refs/heads/{-dash,HEAD}
      Start preparation for 2.15.1
      RelNotes: the fourth batch for 2.16
      Almost ready for 2.15.1
      RelNotes: the fifth batch for 2.16
      hooks doc: clarify when receive-pack invokes its hooks
      A bit more fixes for 2.15.1
      RelNotes: the sixth batch for 2.16
      Git 2.15.1
      RelNotes: the seventh batch
      t2020: test variations that matter
      Prepare for 2.15.2
      RelNotes: the eighth batch
      diff: use skip_to_optional_arg_default() in parsing --relative
      t4045: reindent to make helpers readable
      RelNotes: the ninth batch
      RelNotes: the tenth batch
      t5573, t7612: clean up after unexpected success of 'pull' and 'merg=
e'
      sequencer.c: drop 'const' from function return type
      RelNotes: the eleventh batch
      Git 2.16-rc0

Kaartic Sivaraam (12):
      mailmap: use Kaartic Sivaraam's new address
      builtin/branch: remove redundant check for HEAD
      git-rebase: clean up dashed-usages in messages
      Doc/checkout: checking out using @{-N} can lead to detached state
      branch: improve documentation and naming of create_branch() paramet=
ers
      branch: group related arguments of create_branch()
      branch: update warning message shown when copying a misnamed branch
      builtin/branch: strip refs/heads/ using skip_prefix
      Doc/check-ref-format: clarify information about @{-N} syntax
      rebase: consistently use branch_name variable
      rebase: distinguish user input by quoting it
      rebase: rebasing can also be done when HEAD is detached

Kevin (1):
      remote-mediawiki: add namespace support

Kevin Daudt (1):
      column: show auto columns when pager is active

Lars Schneider (3):
      refactor "dumb" terminal determination
      progress: drop delay-threshold code
      launch_editor(): indicate that Git waits for user input

Liam Beguin (9):
      Documentation: move rebase.* configs to new file
      Documentation: use preferred name for the 'todo list' script
      rebase -i: set commit to null in exec commands
      rebase -i: refactor transform_todo_ids
      rebase -i: replace reference to sha1 with oid
      rebase -i: update functions to use a flags parameter
      rebase -i -x: add exec commands via the rebase--helper
      rebase -i: learn to abbreviate command names
      t3404: add test case for abbreviated commands

Marius Paliga (1):
      builtin/push.c: add push.pushOption config

Martin =C3=85gren (22):
      sha1_file: do not leak `lock_file`
      treewide: prefer lockfiles on the stack
      lockfile: fix documentation on `close_lock_file_gently()`
      tempfile: fix documentation on `delete_tempfile()`
      checkout-index: simplify locking logic
      cache-tree: simplify locking logic
      apply: move lockfile into `apply_state`
      apply: remove `newfd` from `struct apply_state`
      cache.h: document `write_locked_index()`
      read-cache: drop explicit `CLOSE_LOCK`-flag
      read-cache: leave lock in right state in `write_locked_index()`
      read_cache: roll back lock in `update_index_if_able()`
      grep: take the read-lock when adding a submodule
      bisect: change calling-convention of `find_bisection()`
      bisect: fix memory leak in `find_bisection()`
      bisect: fix off-by-one error in `best_bisection_sorted()`
      bisect: fix memory leak when returning best element
      builtin/merge-base: free commit lists
      reduce_heads: fix memory leaks
      t7006: add tests for how git branch paginates
      branch: respect `pager.branch` in list-mode only
      branch: change default of `pager.branch` to "on"

Michael Haggerty (12):
      t1409: check that `packed-refs` is not rewritten unnecessarily
      files-backend: don't rewrite the `packed-refs` file unnecessarily
      t0000: check whether the shell supports the "local" keyword
      files_transaction_prepare(): don't leak flags to packed transaction
      prune_ref(): call `ref_transaction_add_update()` directly
      ref_transaction_update(): die on disallowed flags
      ref_transaction_add_update(): remove a check
      refs: tidy up and adjust visibility of the `ref_update` flags
      refs: rename constant `REF_NODEREF` to `REF_NO_DEREF`
      refs: rename constant `REF_ISPRUNING` to `REF_IS_PRUNING`
      write_packed_entry(): take `object_id` arguments
      refs: update some more docs to use "oid" rather than "sha1"

Nicolas Morey-Chaisemartin (1):
      imap-send: URI encode server folder

Olga Telezhnaya (2):
      format: create pretty.h file
      format: create docs for pretty.h

Phil Hord (2):
      doc: prefer 'stash push' over 'stash save'
      stash: learn to parse -m/--message like commit does

Phillip Wood (2):
      config: avoid "write_in_full(fd, buf, len) !=3D len" pattern
      sequencer: reschedule pick if index can't be locked

Pranit Bauva (6):
      bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
      bisect--helper: rewrite `check_term_format` shell function in C
      bisect--helper: `write_terms` shell function in C
      bisect--helper: `bisect_clean_state` shell function in C
      t6030: explicitly test for bisection cleanup
      bisect--helper: `is_expected_rev` & `check_expected_revs` shell fun=
ction in C

Prathamesh Chavan (3):
      submodule--helper: introduce get_submodule_displaypath()
      submodule--helper: introduce for_each_listed_submodule()
      submodule: port submodule subcommand 'status' from shell to C

Rafael Ascens=C3=A3o (1):
      log: add option to choose which refs to decorate

Ramsay Jones (1):
      repository: fix a sparse 'using integer as NULL pointer' warning

Randall S. Becker (1):
      install-doc-quick: allow specifying what ref to install

Rasmus Villemoes (2):
      Documentation/config: add sendemail.tocmd to list preceding "See gi=
t-send-email(1)"
      completion: add git config sendemail.tocmd

Ren=C3=A9 Scharfe (21):
      notes: move hex_to_bytes() to hex.c and export it
      http-push: use hex_to_bytes()
      sha1_file: use hex_to_bytes()
      sequencer: factor out rewrite_file()
      sequencer: use O_TRUNC to truncate files
      imap-send: handle NULL return of next_arg()
      imap-send: handle missing response codes gracefully
      apply: avoid out-of-bounds access in fuzzy_matchlines()
      apply: update line lengths for --inaccurate-eof
      config: flip return value of write_section()
      t4051: add test for comments preceding function lines
      xdiff: factor out is_func_rec()
      xdiff: show non-empty lines before functions with -W
      t7810: improve check of -W with user-defined function lines
      grep: update boundary variable for pre-context
      grep: show non-empty lines before functions with -W
      am: release strbuf after use in split_mail_mbox()
      fmt-merge-msg: avoid leaking strbuf in shortlog()
      strbuf: release memory on read error in strbuf_read_once()
      transport-helper: plug strbuf and string_list leaks
      p7519: improve check for prerequisite WATCHMAN

Robert Abel (2):
      git-prompt: make __git_eread intended use explicit
      git-prompt: fix reading files with windows line endings

Robert P. J. Day (4):
      bisect: mention "view" as an alternative to "visualize"
      doc: add missing "-n" (dry-run) option to reflog man page
      prune: add "--progress" to man page and usage msg
      notes: correct 'git notes prune' options to '[-n] [-v]'

SZEDER G=C3=A1bor (7):
      travis-ci: fix running P4 and Git LFS tests in Linux build jobs
      travis-ci: don't build Git for the static analysis job
      setup.c: fix comment about order of .git directory discovery
      travis-ci: introduce a $jobname variable for 'ci/*' scripts
      travis-ci: move setting environment variables to 'ci/lib-travisci.s=
h'
      travis-ci: set GIT_TEST_HTTPD in 'ci/lib-travisci.sh'
      travis-ci: use 'set -x' in 'ci/*' scripts for extra tracing output

Shuyu Wei (1):
      pull: pass -4/-6 option to 'git fetch'

Simon Ruderich (3):
      sequencer.c: check return value of close() in rewrite_file()
      wrapper.c: consistently quote filenames in error messages
      config: document default value of http.sslVerify

Stefan Beller (15):
      recursive submodules: detach HEAD from new state
      Documentation/checkout: clarify submodule HEADs to be detached
      xdiff-interface: export comparing and hashing strings
      diff.c: get rid of duplicate implementation
      t6120: fix typo in test name
      list-objects.c: factor out traverse_trees_and_blobs
      config: document blame configuration
      t/3512: demonstrate unrelated submodule/file conflict as cherry-pic=
k failure
      revision.h: introduce blob/tree walking in order of the commits
      builtin/describe.c: rename `oid` to avoid variable shadowing
      builtin/describe.c: print debug statements earlier
      builtin/describe.c: factor out describe_commit
      Documentation/git-clone: improve description for submodule recursin=
g
      t/helper: ignore everything but sources
      builtin/describe.c: describe a blob

Steffen Prohaska (1):
      doc: Mention info/attributes in gitrepository-layout

Stephan Beyer (1):
      bisect run: die if no command is given

Thomas Braun (1):
      completion: add remaining flags to checkout

Thomas Gummerer (11):
      stash: replace "git stash save" with "git stash push" in the docume=
ntation
      stash: mark "git stash save" deprecated in the man page
      stash: remove now superfluos help for "stash push"
      checkout: factor out functions to new lib file
      worktree: add can be created from any commit-ish
      worktree: add --[no-]track option to the add subcommand
      worktree: make add <path> <branch> dwim
      t/README: remove mention of adding copyright notices
      t/README: document test_cmp_rev
      worktree: add --guess-remote flag to add subcommand
      add worktree.guessRemote config option

Todd Zullinger (11):
      Replace Free Software Foundation address in license notices
      Replace Free Software Foundation address in license notices
      t/lib-gpg: fix gpgconf stderr redirect to /dev/null
      rebase: fix stderr redirect in apply_autostash()
      notes: send "Automatic notes merge failed" messages to stderr
      branch doc: remove --set-upstream from synopsis
      completion: add '--copy' option to 'git branch'
      RelNotes: minor typo fixes in 2.15.1 draft
      t/lib-git-svn: cleanup inconsistent tab/space usage
      t/lib-git-svn.sh: improve svnserve tests with parallel make test
      RelNotes: minor typo fixes in 2.16.0 draft

Torsten B=C3=B6gershausen (3):
      add: introduce "--renormalize"
      convert: tighten the safe autocrlf handling
      t0027: Adapt the new MIX tests to Windows

W. Trevor King (1):
      pull: pass --signoff/--no-signoff to "git merge"

Wei Shuyu (1):
      http: support CURLPROXY_HTTPS

brian m. carlson (31):
      walker: convert to struct object_id
      refs/files-backend: convert struct ref_to_prune to object_id
      refs: convert delete_ref and refs_delete_ref to struct object_id
      refs: convert update_ref and refs_update_ref to use struct object_i=
d
      refs: prevent accidental NULL dereference in write_pseudoref
      refs: update ref transactions to use struct object_id
      Convert check_connected to use struct object_id
      refs: convert resolve_refdup and refs_resolve_refdup to struct obje=
ct_id
      refs: convert read_ref and read_ref_full to object_id
      refs: convert dwim_ref and expand_ref to struct object_id
      builtin/reflog: convert remaining unsigned char uses to object_id
      refs: convert dwim_log to struct object_id
      pack-bitmap: convert traverse_bitmap_commit_list to object_id
      builtin/pack-objects: convert to struct object_id
      refs: convert peel_ref to struct object_id
      refs: convert read_ref_at to struct object_id
      refs: convert reflog_expire parameter to struct object_id
      sha1_file: convert index_path and index_fd to struct object_id
      Convert remaining callers of resolve_gitlink_ref to object_id
      refs: convert resolve_gitlink_ref to struct object_id
      worktree: convert struct worktree to object_id
      refs: convert resolve_ref_unsafe to struct object_id
      refs: convert peel_object to struct object_id
      refs: convert read_raw_ref backends to struct object_id
      refs/files-backend: convert static functions to object_id
      Documentation: enable compat-mode for Asciidoctor
      setup: expose enumerated repo info
      Add structure representing hash algorithm
      Integrate hash algorithm support with repo setup
      Switch empty tree and blob lookups to use hash abstraction
      Documentation: convert SubmittingPatches to AsciiDoc

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
      test-lib: add LIBPCRE1 & LIBPCRE2 prerequisites
      grep: fix segfault under -P + PCRE2 <=3D10.30 + (*NO_JIT)

=C5=81ukasz Stelmach (1):
      git-gui: prevent double UTF-8 conversion

