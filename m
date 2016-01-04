From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.7.0
Date: Mon, 04 Jan 2016 15:43:58 -0800
Message-ID: <xmqqlh84lxkx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Jan 05 00:44:32 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aGEne-0003Ha-Us
	for glk-linux-kernel-3@plane.gmane.org; Tue, 05 Jan 2016 00:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbcADXoO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 4 Jan 2016 18:44:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56745 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753863AbcADXoC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jan 2016 18:44:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5373E38ADF;
	Mon,  4 Jan 2016 18:44:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=0Pffzgo2EikyiGDBs1xnk2shi
	Gk=; b=aFdKcicl6Z1Y9420tiSDrSGBuI60jUAtN38mNlpY/oH6SEtGginQOV9/b
	e80EWbUKJNsuQu2gmoc0L9w4bzlE5lF8c8smIE91E/Ro2cY+nrCTtF7utt0UBmxs
	gfGV5+Hf6qUrz6+vcwJgBckc9Jxes5uNeyv2ugsE4+yZrO28JM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=a1oozxKHTxGo0TowIkF
	AX+5OsFdoNS+/g/VxmbBIWUUdb54VZviGOfTUHuGmw2kGrE1ZPjO4HDNE3NxI9RW
	+Ps/bkZ+7x8pgshjxnEdLs31Xs2YpTx8Y2HRkpg9EOYk4lkrO8nyKPH0Y/nlJ7BT
	E0q+wqm+iIqV1n+EeAqGimZE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 470F538ADE;
	Mon,  4 Jan 2016 18:44:01 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C0D9838ADD;
	Mon,  4 Jan 2016 18:43:59 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0718016C-B33D-11E5-80D9-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283334>

The latest feature release Git v2.7.0 is now available at the
usual places.  It is comprised of 539 non-merge commits since
v2.6.0, contributed by 81 people, 26 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.7.0'
tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.6.0 are as follows.
Welcome to the Git development community!

  Atousa Pahlevan Duprat, Audric Schiltknecht, Ben Boeckel,
  Blake Burkhart, Dair Grant, Edmundo Carmona Antoranz, =C3=89lie
  Bouttier, Eric N. Vander Weele, Fabio Porcedda, Gabor Bernat,
  GIRARD Etienne, James McCoy, Juerg Haefliger, Noam Postavsky,
  Rainer M. Canavan, Ray Donnelly, Remi Pommarel, Renee Margaret
  McConahy, Sidhant Sharma, Stefan Agner, Takashi Iwai, Tobias
  Klauser, Waldek Maleska, Xue Fuqiao, YOKOTA Hiroshi, and
  =D0=90=D0=BD=D0=B4=D1=80=D0=B5=D0=B9 =D0=A0=D1=8B=D0=B1=D0=B0=D0=BA.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Alexander Shopov, Alexey Shumkin, Alex Henrie, Alex Riesen,
  Antoine Delaite, Beat Bolli, brian m. carlson, Charles Bailey,
  Christian Couder, Clemens Buchacher, Daniel Knittl-Frank, David
  Aguilar, David Turner, Dennis Kaarsemaker, Dimitriy Ryazantcev,
  Doug Kelly, Elia Pinto, Fabian Ruch, Fredrik Medley, Giuseppe
  Bilotta, Jacob Keller, Jean-Noel Avila, Jeff King, Jiang Xin,
  Johannes Schindelin, Johannes Sixt, John Keeping, Junio C Hamano,
  Karthik Nayak, Lars Schneider, Lukas Fleischer, Luke Diamand,
  Matthieu Moy, Max Kirillov, Michael Haggerty, Michael J Gruber,
  Michael Rappazzo, Mike Crowe, Namhyung Kim, Nguy=E1=BB=85n Th=C3=A1i =
Ng=E1=BB=8Dc
  Duy, Pat Thoyts, Paul Mackerras, Peter Krefting, Ralf Thielow,
  Ramsay Jones, Ren=C3=A9 Scharfe, Ronnie Sahlberg, Sam Hocevar,
  Stefan Beller, Stefan Naewe, Stephan Beyer, SZEDER G=C3=A1bor,
  Techlive Zheng, Torsten B=C3=B6gershausen, and Tr=E1=BA=A7n Ng=E1=BB=8D=
c Qu=C3=A2n.

----------------------------------------------------------------

Git 2.7 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Updates since v2.6
------------------

UI, Workflows & Features

 * The appearance of "gitk", particularly on high DPI monitors, have
   been improved.  "gitk" also comes with an undated translation for
   Swedish and Japanese.

 * "git remote" learned "get-url" subcommand to show the URL for a
   given remote name used for fetching and pushing.

 * There was no way to defeat a configured rebase.autostash variable
   from the command line, as "git rebase --no-autostash" was missing.

 * "git log --date=3Dlocal" used to only show the normal (default)
   format in the local timezone.  The command learned to take 'local'
   as an instruction to use the local timezone with other formats,

 * The refs used during a "git bisect" session is now per-worktree so
   that independent bisect sessions can be done in different worktrees
   created with "git worktree add".

 * Users who are too busy to type three extra keystrokes to ask for
   "git stash show -p" can now set stash.showPatch configuration
   variable to true to always see the actual patch, not just the list
   of paths affected with feel for the extent of damage via diffstat.

 * "quiltimport" allows to specify the series file by honoring the
   $QUILT_SERIES environment and also --series command line option.

 * The use of 'good/bad' in "git bisect" made it confusing to use when
   hunting for a state change that is not a regression (e.g. bugfix).
   The command learned 'old/new' and then allows the end user to
   say e.g. "bisect start --term-old=3Dfast --term-new=3Dslow" to find =
a
   performance regression.

 * "git interpret-trailers" can now run outside of a Git repository.

 * "git p4" learned to reencode the pathname it uses to communicate
   with the p4 depot with a new option.

 * Give progress meter to "git filter-branch".

 * Allow a later "!/abc/def" to override an earlier "/abc" that
   appears in the same .gitignore file to make it easier to express
   "everything in /abc directory is ignored, except for ...".

 * Teach "git p4" to send large blobs outside the repository by
   talking to Git LFS.

 * Prepare for Git on-disk repository representation to undergo
   backward incompatible changes by introducing a new repository
   format version "1", with an extension mechanism.

 * "git worktree" learned a "list" subcommand.

 * "git clone --dissociate" learned that it can be used even when
   "--reference" was not used at the same time.

 * "git blame" learnt to take "--first-parent" and "--reverse" at the
   same time when it makes sense.

 * "git checkout" did not follow the usual "--[no-]progress"
   convention and implemented only "--quiet" that is essentially
   a superset of "--no-progress".  Extend the command to support the
   usual "--[no-]progress".

 * The semantics of transfer.hideRefs configuration variable have been
   extended to work better with the ref "namespace" feature that lets
   you throw unrelated bunches of repositories in a single physical
   repository and virtually serve them as separate ones.

 * send-email config variables whose values are pathnames now go
   through the ~username/ expansion.

 * bash completion learnt to TAB-complete recipient addresses given
   to send-email.

 * The credential-cache daemon can be told to ignore SIGHUP to work
   around issue when running Git from inside emacs.

 * "git push" learned new configuration for doing "--recurse-submodules=
"
   on each push.

 * "format-patch" has learned a new option to zero-out the commit
   object name on the mbox "From " line.


Performance, Internal Implementation, Development Support etc.

 * The infrastructure to rewrite "git submodule" in C is being built
   incrementally.  Let's polish these early parts well enough and make
   them graduate to 'next' and 'master', so that the more involved
   follow-up can start cooking on a solid ground.

 * Some features from "git tag -l" and "git branch -l" have been made
   available to "git for-each-ref" so that eventually the unified
   implementation can be shared across all three.  The version merged
   to the 'master' branch earlier had a performance regression in "tag
   --contains", which has since been corrected.

 * Because "test_when_finished" in our test framework queues the
   clean-up tasks to be done in a shell variable, it should not be
   used inside a subshell.  Add a mechanism to allow 'bash' to catch
   such uses, and fix the ones that were found.

 * The debugging infrastructure for pkt-line based communication has
   been improved to mark the side-band communication specifically.

 * Update "git branch" that list existing branches, using the
   ref-filter API that is shared with "git tag" and "git
   for-each-ref".

 * The test for various line-ending conversions has been enhanced.

 * A few test scripts around "git p4" have been improved for
   portability.

 * Many allocations that is manually counted (correctly) that are
   followed by strcpy/sprintf have been replaced with a less error
   prone constructs such as xstrfmt.

 * The internal stripspace() function has been moved to where it
   logically belongs to, i.e. strbuf API, and the command line parser
   of "git stripspace" has been updated to use the parse_options API.

 * "git am" used to spawn "git mailinfo" via run_command() API once
   per each patch, but learned to make a direct call to mailinfo()
   instead.

 * The implementation of "git mailinfo" was refactored so that a
   mailinfo() function can be directly called from inside a process.

 * With a "debug" helper, debugging of a single "git" invocation in
   our test scripts has become a lot easier.

 * The "configure" script did not test for -lpthread correctly, which
   upset some linkers.

 * Cross completed task off of subtree project's todo list.

 * Test cleanups for the subtree project.

 * Clean up style in an ancient test t9300.

 * Work around some test flakiness with p4d.

 * Fsck did not correctly detect a NUL-truncated header in a tag.

 * Use a safer behavior when we hit errors verifying remote certificate=
s.

 * Speed up filter-branch for cases where we only care about rewriting
   commits, not tree data.

 * The parse-options API has been updated to make "-h" command line
   option work more consistently in all commands.

 * "git svn rebase/mkdirs" got optimized by keeping track of empty
   directories better.

 * Fix some racy client/server tests by treating SIGPIPE the same as a
   normal non-zero exit.

 * The necessary infrastructure to build topics using the free Travis
   CI has been added. Developers forking from this topic (and enabling
   Travis) can do their own builds, and we can turn on auto-builds for
   git/git (including build-status for pull requests that people
   open).

 * The write(2) emulation for Windows learned to set errno to EPIPE
   when necessary.


Also contains various documentation updates and code clean-ups.


=46ixes since v2.6
----------------

Unless otherwise noted, all the fixes since v2.6 in the maintenance
track are contained in this release (see the maintenance releases'
notes for details).

 * Very small number of options take a parameter that is optional
   (which is not a great UI element as they can only appear at the end
   of the command line).  Add notice to documentation of each and
   every one of them.

 * "git blame --first-parent v1.0..v2.0" was not rejected but did not
   limit the blame to commits on the first parent chain.

 * "git subtree" (in contrib/) now can take whitespaces in the
   pathnames, not only in the in-tree pathname but the name of the
   directory that the repository is in.

 * The ssh transport, just like any other transport over the network,
   did not clear GIT_* environment variables, but it is possible to
   use SendEnv and AcceptEnv to leak them to the remote invocation of
   Git, which is not a good idea at all.  Explicitly clear them just
   like we do for the local transport.

 * Correct "git p4 --detect-labels" so that it does not fail to create
   a tag that points at a commit that is also being imported.

 * The Makefile always runs the library archiver with hardcoded "crs"
   options, which was inconvenient for exotic platforms on which
   people want to use programs with totally different set of command
   line options.

 * Customization to change the behaviour with "make -w" and "make -s"
   in our Makefile was broken when they were used together.

 * Allocation related functions and stdio are unsafe things to call
   inside a signal handler, and indeed killing the pager can cause
   glibc to deadlock waiting on allocation mutex as our signal handler
   tries to free() some data structures in wait_for_pager().  Reduce
   these unsafe calls.

 * The way how --ref/--notes to specify the notes tree reference are
   DWIMmed was not clearly documented.

 * "git gc" used to barf when a symbolic ref has gone dangling
   (e.g. the branch that used to be your upstream's default when you
   cloned from it is now gone, and you did "fetch --prune").

 * "git clone --dissociate" runs a big "git repack" process at the
   end, and it helps to close file descriptors that are open on the
   packs and their idx files before doing so on filesystems that
   cannot remove a file that is still open.

 * Description of the "log.follow" configuration variable in "git log"
   documentation is now also copied to "git config" documentation.

 * "git rebase -i" had a minor regression recently, which stopped
   considering a line that begins with an indented '#' in its insn
   sheet not a comment. Further, the code was still too picky on
   Windows where CRLF left by the editor is turned into a trailing CR
   on the line read via the "read" built-in command of bash.  Both of
   these issues are now fixed.

 * After "git checkout --detach", "git status" reported a fairly
   useless "HEAD detached at HEAD", instead of saying at which exact
   commit.

 * When "git send-email" wanted to talk over Net::SMTP::SSL,
   Net::Cmd::datasend() did not like to be fed too many bytes at the
   same time and failed to send messages.  Send the payload one line
   at a time to work around the problem.

 * When "git am" was rewritten as a built-in, it stopped paying
   attention to user.signingkey, which was fixed.

 * It was not possible to use a repository-lookalike created by "git
   worktree add" as a local source of "git clone".

 * On a case insensitive filesystems, setting GIT_WORK_TREE variable
   using a random cases that does not agree with what the filesystem
   thinks confused Git that it wasn't inside the working tree.

 * Performance-measurement tests did not work without an installed Git.

 * A test script for the HTTP service had a timing dependent bug,
   which was fixed.

 * There were some classes of errors that "git fsck" diagnosed to its
   standard error that did not cause it to exit with non-zero status.

 * Work around "git p4" failing when the P4 depot records the contents
   in UTF-16 without UTF-16 BOM.

 * When "git gc --auto" is backgrounded, its diagnosis message is
   lost.  Save it to a file in $GIT_DIR and show it next time the "gc
   --auto" is run.

 * The submodule code has been taught to work better with separate
   work trees created via "git worktree add".

 * "git gc" is safe to run anytime only because it has the built-in
   grace period to protect young objects.  In order to run with no
   grace period, the user must make sure that the repository is
   quiescent.

 * A recent "filter-branch --msg-filter" broke skipping of the commit
   object header, which is fixed.

 * The normalize_ceiling_entry() function does not muck with the end
   of the path it accepts, and the real world callers do rely on that,
   but a test insisted that the function drops a trailing slash.

 * A test for interaction between untracked cache and sparse checkout
   added in Git 2.5 days were flaky.

 * A couple of commands still showed "[options]" in their usage string
   to note where options should come on their command line, but we
   spell that "[<options>]" in most places these days.

 * The synopsis text and the usage string of subcommands that read
   list of things from the standard input are often shown as if they
   only take input from a file on a filesystem, which was misleading.

 * "git am -3" had a small regression where it is aborted in its error
   handling codepath when underlying merge-recursive failed in certain
   ways, as it assumed that the internal call to merge-recursive will
   never die, which is not the case (yet).

 * The linkage order of libraries was wrong in places around libcurl.

 * The name-hash subsystem that is used to cope with case insensitive
   filesystems keeps track of directories and their on-filesystem
   cases for all the paths in the index by holding a pointer to a
   randomly chosen cache entry that is inside the directory (for its
   ce->ce_name component).  This pointer was not updated even when the
   cache entry was removed from the index, leading to use after free.
   This was fixed by recording the path for each directory instead of
   borrowing cache entries and restructuring the API somewhat.

 * "git merge-file" tried to signal how many conflicts it found, which
   obviously would not work well when there are too many of them.

 * The error message from "git blame --contents --reverse" incorrectly
   talked about "--contents --children".

 * "git imap-send" did not compile well with older version of cURL libr=
ary.

 * Merging a branch that removes a path and another that changes the
   mode bits on the same path should have conflicted at the path, but
   it didn't and silently favoured the removal.

 * "git --literal-pathspecs add -u/-A" without any command line
   argument misbehaved ever since Git 2.0.

 * "git daemon" uses "run_command()" without "finish_command()", so it
   needs to release resources itself, which it forgot to do.

 * "git status --branch --short" accessed beyond the constant string
   "HEAD", which has been corrected.

 * We peek objects from submodule's object store by linking it to the
   list of alternate object databases, but the code to do so forgot to
   correctly initialize the list.

 * The code to prepare the working tree side of temporary directory
   for the "dir-diff" feature forgot that symbolic links need not be
   copied (or symlinked) to the temporary area, as the code already
   special cases and overwrites them.  Besides, it was wrong to try
   computing the object name of the target of symbolic link, which may
   not even exist or may be a directory.

 * A Range: request can be responded with a full response and when
   asked properly libcurl knows how to strip the result down to the
   requested range.  However, we were hand-crafting a range request
   and it did not kick in.

 * Having a leftover .idx file without corresponding .pack file in
   the repository hurts performance; "git gc" learned to prune them.

 * Apple's common crypto implementation of SHA1_Update() does not take
   more than 4GB at a time, and we now have a compile-time workaround
   for it.

 * Produce correct "dirty" marker for shell prompts, even when we
   are on an orphan or an unborn branch.

 * A build without NO_IPv6 used to use gethostbyname() when guessing
   user's hostname, instead of getaddrinfo() that is used in other
   codepaths in such a build.

 * The exit code of git-fsck did not reflect some types of errors
   found in packed objects, which has been corrected.

 * The helper used to iterate over loose object directories to prune
   stale objects did not closedir() immediately when it is done with a
   directory--a callback such as the one used for "git prune" may want
   to do rmdir(), but it would fail on open directory on platforms
   such as WinXP.

 * "git p4" used to import Perforce CLs that touch only paths outside
   the client spec as empty commits.  It has been corrected to ignore
   them instead, with a new configuration git-p4.keepEmptyCommits as a
   backward compatibility knob.

 * The completion script (in contrib/) used to list "git column"
   (which is not an end-user facing command) as one of the choices
   (merge 160fcdb sg/completion-no-column later to maint).

 * The error reporting from "git send-email", when SMTP TLS fails, has
   been improved.
   (merge 9d60524 jk/send-email-ssl-errors later to maint).

 * When getpwuid() on the system returned NULL (e.g. the user is not
   in the /etc/passwd file or other uid-to-name mappings), the
   codepath to find who the user is to record it in the reflog barfed
   and died.  Loosen the check in this codepath, which already accepts
   questionable ident string (e.g. host part of the e-mail address is
   obviously bogus), and in general when we operate fmt_ident() functio=
n
   in non-strict mode.
   (merge 92bcbb9 jk/ident-loosen-getpwuid later to maint).

 * "git symbolic-ref" forgot to report a failure with its exit status.
   (merge f91b273 jk/symbolic-ref-maint later to maint).

 * History traversal with "git log --source" that starts with an
   annotated tag failed to report the tag as "source", due to an
   old regression in the command line parser back in v2.2 days.
   (merge 728350b jk/pending-keep-tag-name later to maint).

 * "git p4" when interacting with multiple depots at the same time
   used to incorrectly drop changes.

 * Code clean-up, minor fixes etc.

----------------------------------------------------------------

Changes since v2.6.0 are as follows:

Alex Henrie (5):
      merge: grammofix in please-commit-before-merge message
      pull: enclose <options> in brackets in the usage string
      gitk: l10n: Update Catalan translation
      l10n: ca.po: update translation
      l10n: ca.po: update translation

Alex Riesen (1):
      clone: allow "--dissociate" without reference

Alexander Shopov (2):
      l10n: Updated Bulgarian translation of git (2477t,0f,0u)
      l10n: Updated Bulgarian translation of git (2477t,0f,0u)

Alexey Shumkin (2):
      t7900-subtree: test the "space in a subdirectory name" case
      contrib/subtree: respect spaces in a repository path

Antoine Delaite (1):
      bisect: add the terms old/new

Atousa Pahlevan Duprat (2):
      sha1: provide another level of indirection for the SHA-1 function=
s
      sha1: allow limiting the size of the data passed to SHA1_Update()

Audric Schiltknecht (1):
      l10n: fr.po: Fix typo

Beat Bolli (1):
      gitk: Add missing accelerators

Ben Boeckel (1):
      remote: add get-url subcommand

Blake Burkhart (2):
      http: limit redirection to protocol-whitelist
      http: limit redirection depth

Charles Bailey (2):
      http: treat config options sslCAPath and sslCAInfo as paths
      t3404: fix quoting of redirect for some versions of bash

Christian Couder (4):
      quote: fix broken sq_quote_buf() related comment
      quote: move comment before sq_quote_buf()
      Documentation/git-update-index: add missing opts to synopsys
      Documentation/git-update-index: add missing opts to synopsis

Clemens Buchacher (1):
      allow hooks to ignore their standard input stream

Dair Grant (1):
      git-svn: improve rebase/mkdirs performance

Daniel Knittl-Frank (1):
      Escape Git's exec path in contrib/rerere-train.sh script

David Aguilar (1):
      difftool: ignore symbolic links in use_wt_file

David Turner (11):
      refs: clean up common_list
      path: optimize common dir checking
      refs: make refs/bisect/* per-worktree
      t7063: fix flaky untracked-cache test
      name-hash: don't reuse cache_entry in dir_entry
      http.c: use CURLOPT_RANGE for range requests
      copy_msg(): rename to copy_reflog_msg()
      initdb: make safe_create_dir public
      files_log_ref_write: new function
      refs: break out ref conflict checks
      verify_pack: do not ignore return value of verification function

Dennis Kaarsemaker (3):
      git-p4: import the ctypes module
      t5813: avoid creating urls that break on cygwin
      check-ignore: correct documentation about output

Dimitriy Ryazantcev (3):
      l10n: ru.po: update Russian translation
      gitk: Update Russian translation
      l10n: ru.po: update Russian translation

Doug Kelly (2):
      t5304: test cleaning pack garbage
      gc: remove garbage .idx files from pack dir

Edmundo Carmona Antoranz (1):
      checkout: add --progress option

Elia Pinto (1):
      ident.c: add support for IPv6

Eric N. Vander Weele (1):
      log: Update log.follow doc and add to config.txt

=46abian Ruch (1):
      rebase -i: remember merge options beyond continue actions

=46abio Porcedda (1):
      contrib/subtree: remove "push" command from the "todo" file

=46redrik Medley (1):
      rebase-i-exec: Allow space in SHELL_PATH

GIRARD Etienne (1):
      git-p4: clean up after p4 submit failure

Gabor Bernat (1):
      filter-branch: add passed/remaining seconds on progress

Giuseppe Bilotta (2):
      gitk: Match ttk fonts to gitk fonts
      gitk: Let .bleft.mid widgets 'breathe'

Jacob Keller (3):
      notes: correct documentation of DWIMery for notes references
      sendemail: teach git-send-email to dump alias names
      completion: add support for completing email aliases

James McCoy (1):
      filter-branch: remove multi-line headers in msg filter

Jean-Noel Avila (2):
      l10n: fr v2.7.0 round 1 (2477t)
      l10n: fr.po v2.7.0 round 2 (2477t)

Jeff King (100):
      introduce "extensions" form of core.repositoryformatversion
      introduce "preciousObjects" repository extension
      run-command: provide in_async query function
      pkt-line: show packets in async processes as "sideband"
      fast-import: switch crash-report date to iso8601
      date: make "local" orthogonal to date format
      git_connect: clear GIT_* environment for ssh
      git_connect: clarify conn->use_shell flag
      blame: handle --first-parent
      transport: add a protocol-whitelist environment variable
      submodule: allow only certain protocols for submodule fetches
      show-branch: avoid segfault with --reflog of unborn branch
      mailsplit: fix FILE* leak in split_maildir
      archive-tar: fix minor indentation violation
      fsck: don't fsck alternates for connectivity-only check
      add xsnprintf helper function
      add git_path_buf helper function
      strbuf: make strbuf_complete_line more generic
      add reentrant variants of sha1_to_hex and find_unique_abbrev
      fsck: use strbuf to generate alternate directories
      mailsplit: make PATH_MAX buffers dynamic
      trace: use strbuf for quote_crnl output
      progress: store throughput display in a strbuf
      test-dump-cache-tree: avoid overflow of cache-tree name
      compat/inet_ntop: fix off-by-one in inet_ntop4
      convert trivial sprintf / strcpy calls to xsnprintf
      archive-tar: use xsnprintf for trivial formatting
      use xsnprintf for generating git object headers
      find_short_object_filename: convert sprintf to xsnprintf
      stop_progress_msg: convert sprintf to xsnprintf
      compat/hstrerror: convert sprintf to snprintf
      grep: use xsnprintf to format failure message
      entry.c: convert strcpy to xsnprintf
      add_packed_git: convert strcpy into xsnprintf
      http-push: replace strcat with xsnprintf
      receive-pack: convert strncpy to xsnprintf
      replace trivial malloc + sprintf / strcpy calls with xstrfmt
      config: use xstrfmt in normalize_value
      fetch: replace static buffer with xstrfmt
      use strip_suffix and xstrfmt to replace suffix
      ref-filter: drop sprintf and strcpy calls
      help: drop prepend function in favor of xstrfmt
      mailmap: replace strcpy with xstrdup
      read_branches_file: simplify string handling
      read_remotes_file: simplify string handling
      resolve_ref: use strbufs for internal buffers
      upload-archive: convert sprintf to strbuf
      remote-ext: simplify git pkt-line generation
      http-push: use strbuf instead of fwrite_buffer
      http-walker: store url in a strbuf
      sha1_get_pack_name: use a strbuf
      transport: refactor protocol whitelist code
      react to errors in xdi_diff
      xdiff: reject files larger than ~1GB
      merge-file: enforce MAX_XDIFF_SIZE on incoming files
      precompose_utf8: drop unused variable
      probe_utf8_pathname_composition: use internal strbuf
      init: use strbufs to store paths
      apply: convert root string to strbuf
      transport: use strbufs for status table "quickref" strings
      merge-recursive: convert malloc / strcpy to strbuf
      enter_repo: convert fixed-size buffers to strbufs
      remove_leading_path: use a strbuf for internal storage
      write_loose_object: convert to strbuf
      diagnose_invalid_index_path: use strbuf to avoid strcpy/strcat
      fetch-pack: use argv_array for index-pack / unpack-objects
      http-push: use an argv_array for setup_revisions
      stat_tracking_info: convert to argv_array
      daemon: use cld->env_array when re-spawning
      use sha1_to_hex_r() instead of strcpy
      drop strcpy in favor of raw sha1_to_hex
      color: add overflow checks for parsing colors
      use alloc_ref rather than hand-allocating "struct ref"
      avoid sprintf and strcpy with flex arrays
      receive-pack: simplify keep_arg computation
      help: clean up kfmclient munging
      prefer memcpy to strcpy
      color: add color_set helper for copying raw colors
      notes: document length of fanout path with a constant
      convert strncpy to memcpy
      fsck: drop inode-sorting code
      Makefile: drop D_INO_IN_DIRENT build knob
      fsck: use for_each_loose_file_in_objdir
      use strbuf_complete to conditionally append slash
      name-rev: use strip_suffix to avoid magic numbers
      t6031: move triple-rename test to t3030
      t6031: generalize for recursive and resolve strategies
      merge: detect delete/modechange conflict
      add_submodule_odb: initialize alt_odb list earlier
      merge-file: clamp exit code to maximum 127
      http: use off_t to store partial file size
      filter-branch: skip index read/write when possible
      blame: fix object casting regression
      ident: make xgetpwuid_self() a static local helper
      ident: keep a flag for bogus default_email
      ident: loosen getpwuid error in non-strict mode
      ident: fix undefined variable when NO_IPV6 is set
      revision.c: propagate tag names from pending array
      symbolic-ref: propagate error code from create_symref()
      t1401: test reflog creation for git-symbolic-ref

Jiang Xin (4):
      l10n: git.pot: v2.7.0 round 1 (66 new, 29 removed)
      l10n: zh_CN: for git v2.7.0 l10n round 1
      l10n: git.pot: v2.7.0 round 2 (2 new, 2 removed)
      l10n: zh_CN: for git v2.7.0 l10n round 2

Johannes Schindelin (13):
      setup: fix "inside work tree" detection on case-insensitive files=
ystems
      t5700: demonstrate a Windows file locking issue with `git clone -=
-dissociate`
      sha1_file: consolidate code to close a pack's file descriptor
      gc: demonstrate failure with stale remote HEAD
      sha1_file.c: add a function to release all packs
      clone --dissociate: avoid locking pack files
      pack-objects: do not get distracted by broken symrefs
      imap-send: only use CURLOPT_LOGIN_OPTIONS if it is actually avail=
able
      Squelch warning about an integer overflow
      Silence GCC's "cast of pointer to integer of a different size" wa=
rning
      t3404: "rebase -i" gets broken when insn sheet uses CR/LF line en=
dings
      test: facilitate debugging Git executables in tests with gdb
      mingw: emulate write(2) that fails with a EPIPE

Johannes Sixt (10):
      prune: close directory earlier during loose-object directory trav=
ersal
      read_branches_file: plug a FILE* leak
      compat/mingw.c: remove printf format warning
      modernize t9300: single-quote placement and indentation
      modernize t9300: use test_must_fail
      modernize t9300: use test_must_be_empty
      modernize t9300: wrap lines after &&
      modernize t9300: use test_when_finished for clean-up
      modernize t9300: mark here-doc words to ignore tab indentation
      modernize t9300: move test preparations into test_expect_success

John Keeping (22):
      Documentation/blame-options: don't list date formats
      Documentation/config: don't list date formats
      Documentation/git-for-each-ref: don't list date formats
      Documentation/rev-list: don't list date formats
      t6300: introduce test_date() helper
      t6300: add test for "raw" date format
      date: check for "local" before anything else
      t6300: make UTC and local dates different
      t6300: add tests for "-local" date formats
      t7610: don't use test_config in a subshell
      t5801: don't use test_when_finished in a subshell
      test-lib-functions: support "test_config -C <dir> ..."
      t7800: don't use test_config in a subshell
      test-lib-functions: detect test_when_finished in subshell
      interpret-trailers: allow running outside a repository
      Makefile: fix MAKEFLAGS tests with multiple flags
      rebase: support --no-autostash
      Documentation/git-rebase: fix --no-autostash formatting
      Documentation: fix section header mark-up
      send-email: expand path in sendemail.smtpsslcertpath config
      send-email: die if CA path doesn't exist
      send-email: enable SSL level 1 debug output

Juerg Haefliger (1):
      git-quiltimport: add commandline option --series <file>

Junio C Hamano (100):
      rerere: fix an off-by-one non-bug
      rerere: handle conflicts with multiple stage #1 entries
      rerere: plug conflict ID leaks
      rerere: lift PATH_MAX limitation
      rerere: write out each record of MERGE_RR in one go
      rerere: report autoupdated paths only after actually updating the=
m
      rerere: drop want_sp parameter from is_cmarker()
      rerere: stop looping unnecessarily
      rerere: do not leak mmfile[] for a path with multiple stage #1 en=
tries
      rerere: explain the rerere I/O abstraction
      rerere: fix benign off-by-one non-bug and clarify code
      rerere: explain MERGE_RR management helpers
      rerere: explain the primary codepath
      rerere: explain "rerere forget" codepath
      rerere: explain the remainder
      rerere: refactor "replay" part of do_plain_rerere()
      rerere: further de-dent do_plain_rerere()
      rerere: further clarify do_rerere_one_path()
      rerere: call conflict-ids IDs
      rerere: use "struct rerere_id" instead of "char *" for conflict I=
D
      rerere: un-nest merge() further
      prepare_packed_git(): refactor garbage reporting in pack director=
y
      Makefile: allow $(ARFLAGS) specified from the command line
      filter-branch: make report-progress more readable
      fsck: exit with non-zero when problems are found
      Git 2.3.10
      Git 2.4.10
      Git 2.5.4
      Git 2.6.1
      Start cycle toward 2.7
      Second batch for 2.7
      am -3: do not let failed merge from completing the error codepath
      Documentation/gc: warn against --prune=3D<now>
      Third batch for 2.7
      Fourth batch for 2.7
      Git 2.6.2
      Fifth batch for 2.7
      usage: do not insist that standard input must come from a file
      mailinfo: remove a no-op call convert_to_utf8(it, "")
      mailinfo: fold decode_header_bq() into decode_header()
      mailinfo: fix an off-by-one error in the boundary stack
      mailinfo: explicitly close file handle to the patch output
      Sixth batch for 2.7
      mailinfo: plug strbuf leak during continuation line handling
      mailinfo: move handle_boundary() lower
      mailinfo: move read_one_header_line() closer to its callers
      mailinfo: move check_header() after the helpers it uses
      mailinfo: move cleanup_space() before its users
      mailinfo: move definition of MAX_HDR_PARSED closer to its use
      mailinfo: get rid of function-local static states
      mailinfo: do not let handle_body() touch global "line" directly
      mailinfo: do not let handle_boundary() touch global "line" direct=
ly
      mailinfo: do not let find_boundary() touch global "line" directly
      mailinfo: move global "line" into mailinfo() function
      mailinfo: introduce "struct mailinfo" to hold globals
      mailinfo: move keep_subject & keep_non_patch_bracket to struct ma=
ilinfo
      mailinfo: move global "FILE *fin, *fout" to struct mailinfo
      mailinfo: move filter/header stage to struct mailinfo
      mailinfo: move patch_lines to struct mailinfo
      mailinfo: move add_message_id and message_id to struct mailinfo
      mailinfo: move use_scissors and use_inbody_headers to struct mail=
info
      mailinfo: move metainfo_charset to struct mailinfo
      mailinfo: move check for metainfo_charset to convert_to_utf8()
      mailinfo: move transfer_encoding to struct mailinfo
      mailinfo: move charset to struct mailinfo
      mailinfo: move cmitmsg and patchfile to struct mailinfo
      mailinfo: move [ps]_hdr_data to struct mailinfo
      mailinfo: move content/content_top to struct mailinfo
      mailinfo: handle_commit_msg() shouldn't be called after finding p=
atchbreak
      mailinfo: keep the parsed log message in a strbuf
      mailinfo: libify
      mailinfo: handle charset conversion errors in the caller
      am: make direct call to mailinfo
      mailinfo: remove calls to exit() and die() deep in the callchain
      Documentation/everyday: match undefline with the text
      Documentation: match underline with the text
      Documentation: match undefline with the text in old release notes
      Documentation: AsciiDoc spells em-dash as double-dashes, not trip=
le
      add: simplify -u/-A without pathspec
      Seventh batch for 2.7
      rebase-i: work around Windows CRLF line endings
      Eighth batch for 2.7
      Ninth batch for 2.7
      Tenth batch for 2.7
      Git 2.6.3
      Eleventh batch for 2.7
      RelNotes update for 2.7
      Prepare for 2.6.4
      Git 2.6.4
      Update release notes to 2.7
      Git 2.7-rc0
      Prepare for 2.6.5
      Update release notes to 2.7
      Update draft release notes to 2.6.5
      Git 2.7-rc1
      Update release notes to 2.7
      Git 2.7-rc2
      Git 2.7-rc3
      Git 2.6.5
      Git 2.7

Karthik Nayak (35):
      t6302: for-each-ref tests for ref-filter APIs
      tag: libify parse_opt_points_at()
      ref-filter: implement '--points-at' option
      for-each-ref: add '--points-at' option
      ref-filter: add parse_opt_merge_filter()
      ref-filter: implement '--merged' and '--no-merged' options
      for-each-ref: add '--merged' and '--no-merged' options
      parse-option: rename parse_opt_with_commit()
      parse-options.h: add macros for '--contains' option
      ref-filter: implement '--contains' option
      for-each-ref: add '--contains' option
      ref-filter: move `struct atom_value` to ref-filter.c
      ref-filter: introduce ref_formatting_state and ref_formatting_sta=
ck
      utf8: add function to align a string into given strbuf
      ref-filter: introduce handler function for each atom
      ref-filter: introduce match_atom_name()
      ref-filter: implement an `align` atom
      ref-filter: add option to filter out tags, branches and remotes
      ref-filter: add support for %(contents:lines=3DX)
      ref-filter: add support to sort by version
      ref-filter: add option to match literal pattern
      tag.c: use 'ref-filter' data structures
      tag.c: use 'ref-filter' APIs
      tag.c: implement '--format' option
      tag.c: implement '--merged' and '--no-merged' options
      branch: refactor width computation
      branch: bump get_head_description() to the top
      branch: roll show_detached HEAD into regular ref_list
      branch: move 'current' check down to the presentation layer
      branch: drop non-commit error reporting
      branch.c: use 'ref-filter' data structures
      branch.c: use 'ref-filter' APIs
      branch: add '--points-at' option
      tag.c: use the correct algorithm for the '--contains' option
      ref-filter: fallback on alphabetical comparison

Lars Schneider (21):
      git-p4: add config git-p4.pathEncoding
      git-p4: improve path encoding verbose output
      git-p4: use replacement character for non UTF-8 characters in pat=
hs
      git-p4: add test case for "Translation of file content failed" er=
ror
      git-p4: handle "Translation of file content failed"
      git-p4: add optional type specifier to gitConfig reader
      git-p4: add gitConfigInt reader
      git-p4: return an empty list if a list config has no values
      git-p4: add file streaming progress in verbose mode
      git-p4: check free space during streaming
      git-p4: add support for large file systems
      git-p4: add Git LFS backend for large file system
      git-p4: avoid "stat" command in t9815 git-p4-submit-fail
      git-p4: skip t9819 test case on case insensitive file systems
      git-p4: retry kill/cleanup operations in tests with timeout
      git-p4: add p4d timeout in tests
      git-p4: add trap to kill p4d on test exit
      implement test_might_fail using a refactored test_must_fail
      add "ok=3Dsigpipe" to test_must_fail and use it to fix flaky test=
s
      Add Travis CI support
      git-p4: add option to keep empty commits

Lukas Fleischer (4):
      config.txt: document the semantics of hideRefs with namespaces
      upload-pack: strip refs before calling ref_is_hidden()
      hideRefs: add support for matching full refs
      t5509: add basic tests for hideRefs

Luke Diamand (7):
      git-p4: failing test for ignoring invalid p4 labels
      git-p4: do not terminate creating tag for unknown commit
      git-p4: fix P4 label import for unprocessed commits
      git-p4: add failing test for submit from detached head
      git-p4: add option to system() to return subshell status
      git-p4: work with a detached head
      git-p4: failing test case for skipping changes with multiple depo=
ts

Matthieu Moy (12):
      bisect: sanity check on terms
      bisect: add 'git bisect terms' to view the current terms
      bisect: allow setting any user-specified in 'git bisect start'
      strtoul_ui: reject negative values
      Documentation: use 'keyid' consistently, not 'key-id'
      Documentation/grep: fix documentation of -O
      Documentation: explain optional arguments better
      t3203: test 'detached at' after checkout --detach
      status: don't say 'HEAD detached at HEAD'
      rebase-i: explicitly accept tab as separator in commands
      rebase-i: loosen over-eager check_bad_cmd check
      git-multimail: update to release 1.2.0

Max Kirillov (6):
      submodule refactor: use strbuf_git_path_submodule() in add_submod=
ule_odb()
      path: implement common_dir handling in git_pathdup_submodule()
      blame: fix option name in error message
      blame: test to describe use of blame --reverse --first-parent
      blame: extract find_single_final
      blame: allow blame --reverse --first-parent when it makes sense

Michael Haggerty (4):
      pack_if_possible_fn(): use ref_type() instead of is_per_worktree_=
ref()
      refname_is_safe(): improve docstring
      refs/refs-internal.h: new header file
      refs: split filesystem-based refs code into a new file

Michael J Gruber (2):
      t2026: rename worktree prune test
      Documentation/diff: give --word-diff-regex=3D. example

Michael Rappazzo (5):
      worktree: add top-level worktree.c
      worktree: refactor find_linked_symref function
      worktree: add a function to get worktree details
      worktree: add details to the worktree struct
      worktree: add 'list' command

Mike Crowe (3):
      push: add recurseSubmodules config option
      push: test that --recurse-submodules on command line overrides co=
nfig
      push: follow the "last one wins" convention for --recurse-submodu=
les

Namhyung Kim (1):
      stash: allow "stash show" diff output configurable

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (12):
      path.c: delete an extra space
      gc: save log from daemonized gc --auto and print it next time
      dir.c: make last_exclude_matching_from_list() run til the end
      dir.c: don't exclude whole dir prematurely if neg pattern may mat=
ch
      t0002: add test for enter_repo(), non-strict mode
      enter_repo: avoid duplicating logic, use is_git_directory() inste=
ad
      enter_repo: allow .git files in strict mode
      clone: allow --local from a linked checkout
      clone: better error when --reference is a linked checkout
      ls-remote.txt: delete unsupported option
      mailinfo: fix passing wrong address to git_mailinfo_config
      git-check-ref-format.txt: typo, s/avoids/avoid/

Noam Postavsky (1):
      credential-cache: new option to ignore sighup

Pat Thoyts (1):
      remote-http(s): support SOCKS proxies

Peter Krefting (4):
      gitk: sv.po: Update Swedish translation (311t)
      l10n: sv.po: Update Swedish translation (2477t0f0u)
      l10n: sv: Fix bad translation
      l10n: sv.po: Update Swedish translation (2477t0f0u)

Rainer M. Canavan (1):
      configure.ac: use $LIBS not $CFLAGS when testing -lpthread

Ralf Thielow (4):
      am, credential-cache: add angle brackets to usage string
      push: don't mark options of recurse-submodules for translation
      l10n: de.po: improve some translations
      l10n: de.po: translate 68 new messages

Ramsay Jones (1):
      http: fix some printf format warnings

Ray Donnelly (1):
      test-path-utils.c: remove incorrect assumption

Remi Pommarel (3):
      Makefile: link libcurl before zlib
      Makefile: make curl-config path configurable
      configure.ac: detect ssl need with libcurl

Renee Margaret McConahy (1):
      am: configure gpg at startup

Ren=C3=A9 Scharfe (17):
      use pop_commit() for consuming the first entry of a struct commit=
_list
      t7060: add test for status --branch on a detached HEAD
      wt-status: exit early using goto in wt_shortstatus_print_tracking=
()
      wt-status: avoid building bogus branch name with detached HEAD
      wt-status: don't skip a magical number of characters blindly
      wt-status: use skip_prefix() to get rid of magic string length co=
nstants
      show-branch: use argv_array for default arguments
      run-command: factor out child_process_clear()
      daemon: plug memory leak
      parse-options: deduplicate parse_options_usage() calls
      parse-options: inline parse_options_usage() at its only remaining=
 caller
      parse-options: allow -h as a short option
      t1450: add tests for NUL in headers of commits and tags
      grep: stop using PARSE_OPT_NO_INTERNAL_HELP
      fsck: treat a NUL in a tag header as an error
      show-ref: stop using PARSE_OPT_NO_INTERNAL_HELP
      wt-status: correct and simplify check for detached HEAD

Ronnie Sahlberg (2):
      verify_refname_available(): rename function
      verify_refname_available(): new function

SZEDER G=C3=A1bor (8):
      bash prompt: test dirty index and worktree while on an orphan bra=
nch
      bash prompt: remove a redundant 'git diff' option
      bash prompt: indicate dirty index even on orphan branches
      filter-branch: deal with object name vs. pathname ambiguity in tr=
ee-filter
      Make error message after failing commit_lock_file() less confusin=
g
      completion: remove 'git column' from porcelain commands
      completion: fix completing unstuck email alias arguments
      credential-store: don't pass strerror to die_errno()

Sam Hocevar (2):
      git-p4: support multiple depot paths in p4 submit
      git-p4: reduce number of server queries for fetches

Sidhant Sharma (1):
      worktree: usage: denote <branch> as optional with 'add'

Stefan Agner (1):
      git-send-email.perl: Fixed sending of many/huge changes/patches

Stefan Beller (5):
      submodule: rewrite `module_list` shell function in C
      submodule: rewrite `module_name` shell function in C
      submodule: rewrite `module_clone` shell function in C
      submodule-config: "goto" removal in parse_config()
      document submodule sync --recursive

Stefan Naewe (1):
      revision.c: fix possible null pointer arithmetic

Stephan Beyer (2):
      t5561: get rid of racy appending to logfile
      t/perf: make runner work even if Git is not installed

Takashi Iwai (4):
      pager: don't use unsafe functions in signal handlers
      gitk: Update msgid's for menu items with accelerator
      gitk: Add accelerators to Japanese locale
      gitk: Add accelerator to German locale

Techlive Zheng (7):
      contrib/subtree: Clean and refactor test code
      contrib/subtree: Add test for missing subtree
      contrib/subtree: Add tests for subtree add
      contrib/subtree: Add merge tests
      contrib/subtree: Add split tests
      contrib/subtree: Make each test self-contained
      contrib/subtree: Handle '--prefix' argument with a slash appended

Tobias Klauser (8):
      connect: fix typo in result string of prot_name()
      Documentation/interpret-trailers: Grammar fix
      strbuf: make stripspace() part of strbuf
      stripspace: use parse-options for command-line parsing
      credential-cache--daemon: remove unused #include "sigchain.h"
      diff: remove unused #include "sigchain.h"
      read-cache: remove unused #include "sigchain.h"
      shallow: remove unused #include "sigchain.h"

Torsten B=C3=B6gershausen (1):
      t0027: improve test for not-normalized files

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (2):
      Updated Vietnamese translation
      l10n: vi.po: Updated translation (2477t)

Waldek Maleska (1):
      Correct fscanf formatting string for I64u values

Xue Fuqiao (2):
      Documentation: fix header markup
      user-manual: fix the description of fast-forward

YOKOTA Hiroshi (16):
      gitk: Color name update
      gitk: Re-sync line number in Japanese message catalogue
      gitk: Update Japanese message catalog
      gitk: Translate more to Japanese catalog
      gitk: Translate Japanese catalog
      gitk: Fix wrong translation
      gitk: Update Japanese translation
      gitk: Fix translation around copyright sign
      gitk: Update Japanese translation
      gitk: Update fuzzy messages
      gitk: Change last translator line
      gitk: Update year
      gitk: Remove unused line
      gitk: Improve translation message
      gitk: Update "Language:" header
      gitk: Update revision date in Japanese PO file

brian m. carlson (15):
      sha1_file: introduce has_object_file helper.
      Convert struct ref to use object_id.
      add_sought_entry_mem: convert to struct object_id
      parse_fetch: convert to use struct object_id
      get_remote_heads: convert to struct object_id
      push_refs_with_export: convert to struct object_id
      ref_newer: convert to use struct object_id
      object: introduce get_object_hash macro.
      Add several uses of get_object_hash.
      Convert struct object to object_id
      Remove get_object_hash.
      remote: convert functions to struct object_id
      sha1_file.c: introduce a null_oid constant
      format-patch: add an option to suppress commit hash
      format-patch: check that header line has expected format

=C3=89lie Bouttier (1):
      l10n: fr.po: Fix typo

=D0=90=D0=BD=D0=B4=D1=80=D0=B5=D0=B9 =D0=A0=D1=8B=D0=B1=D0=B0=D0=BA (1)=
:
      Documentation: make environment variable formatting more consiste=
nt
