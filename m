From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.7.0-rc0
Date: Thu, 10 Dec 2015 14:49:55 -0800
Message-ID: <xmqqh9jphqb0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu Dec 10 23:50:17 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1a7A2Q-0007il-LO
	for glk-linux-kernel-3@plane.gmane.org; Thu, 10 Dec 2015 23:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbbLJWuC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 10 Dec 2015 17:50:02 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57862 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752933AbbLJWt6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Dec 2015 17:49:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7893B338CC;
	Thu, 10 Dec 2015 17:49:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=YFpPLWW4kOIPqJjlQZXnjJ8P/
	2g=; b=UI0DNK3bSaJCZda40TcD+OIU1o9xYDahfhOkZXnhf7d3dkC0zTlbZX9Pb
	Ur2puNdkSByI3xVcr1qs6D6ZDCBArzWc2jm7rrAWEdWLZKKjT/vPItCZki7OdYRu
	F+RoBfS325prYN4l51ZznWuYg9kitkCtXFWvl3HwytSMONztCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=GkJ8jDzGnZKIfRIj0Bj
	QIKQd5Pl0Dx8/K8csgbRKf6niI8Y8Maxh6Mg07Ozl7mVQBX4aiLM8yvPrV1UxKN3
	zv/9fJ857xlovb9EGtJJjzgRlXoWlgcp7BkpNC2thkxo0foA8OTD8PCGBq8OM8iP
	zvJENZyK6LXpLHyng0211GJ0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6FFD7338CB;
	Thu, 10 Dec 2015 17:49:57 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ADFDB338CA;
	Thu, 10 Dec 2015 17:49:56 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 55BD63FE-9F90-11E5-BBB5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282236>

An early preview release Git v2.7.0-rc0 is now available for
testing at the usual places.  It is comprised of 463 non-merge
commits since v2.6.0, contributed by 69 people, 23 of which are
new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.7.0-rc0' tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.6.0 are as follows.
Welcome to the Git development community!

  Atousa Pahlevan Duprat, Ben Boeckel, Blake Burkhart, Dair Grant,
  Edmundo Carmona Antoranz, Eric N. Vander Weele, Fabio Porcedda,
  Gabor Bernat, GIRARD Etienne, James McCoy, Juerg Haefliger, Noam
  Postavsky, Rainer M. Canavan, Ray Donnelly, Remi Pommarel, Renee
  Margaret McConahy, Sidhant Sharma, Stefan Agner, Takashi Iwai,
  Tobias Klauser, Waldek Maleska, Xue Fuqiao, and =D0=90=D0=BD=D0=B4=D1=
=80=D0=B5=D0=B9
  =D0=A0=D1=8B=D0=B1=D0=B0=D0=BA.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Alexey Shumkin, Alex Henrie, Alex Riesen, Antoine Delaite,
  Beat Bolli, brian m. carlson, Charles Bailey, Christian Couder,
  Clemens Buchacher, Daniel Knittl-Frank, David Aguilar, David
  Turner, Dennis Kaarsemaker, Dimitriy Ryazantcev, Doug Kelly,
  Elia Pinto, Fredrik Medley, Jacob Keller, Jeff King, Johannes
  Schindelin, Johannes Sixt, John Keeping, Junio C Hamano, Karthik
  Nayak, Lars Schneider, Lukas Fleischer, Luke Diamand, Matthieu
  Moy, Max Kirillov, Michael Haggerty, Michael J Gruber, Michael
  Rappazzo, Namhyung Kim, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy, Pa=
t Thoyts,
  Paul Mackerras, Ralf Thielow, Ramsay Jones, Ren=C3=A9 Scharfe,
  Ronnie Sahlberg, Stefan Beller, Stephan Beyer, SZEDER G=C3=A1bor,
  Techlive Zheng, Torsten B=C3=B6gershausen, and Tr=E1=BA=A7n Ng=E1=BB=8D=
c Qu=C3=A2n.

----------------------------------------------------------------

Git 2.7 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Updates since v2.6
------------------

UI, Workflows & Features

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
   varible to true to always see the actual patch, not just the list
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

 * The semantics of tranfer.hideRefs configuration variable have been
   extended to work better with the ref "namespace" feature that lets
   you throw unrelated bunches of repositories in a single physical
   repository and virtually serve them as separate ones.

 * send-email config variables whose values are pathnames now go
   through the ~username/ expansion.

 * bash completion learnt to TAB-complete recipient addresses given
   to send-email.

 * The credential-cache daemon can be told to ignore SIGHUP to work
   around issue when running Git from inside emacs.


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

 * The exit code of git-fsck didnot reflect some types of errors found
   in packed objects, which has been corrected.

 * Code clean-up, minor fixes etc.
