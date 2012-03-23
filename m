From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.10-rc2
Date: Fri, 23 Mar 2012 16:15:14 -0700
Message-ID: <7vr4wisyd9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sat Mar 24 00:16:04 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1SBDiE-0004lT-Rt
	for glk-linux-kernel-3@plane.gmane.org; Sat, 24 Mar 2012 00:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801Ab2CWXPj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 23 Mar 2012 19:15:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49411 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757802Ab2CWXPT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Mar 2012 19:15:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C8356594;
	Fri, 23 Mar 2012 19:15:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=kR3k8SHKJEK93kUAnkVvSWA1h
	1M=; b=BQ9XTDMSxEzXr+Qpx5gi3QwsWv7u4GufI0ximOUS9ONqKCzxTt4BmUiAU
	l7rNhwA3yiFIWNjJJViNYbHJGhjukaNtqqA3eqUNTw1dhIPNz+23fm0RfDWpIwAk
	6qIQUA+bbcQXf0im7jzGF9H3XMS/0aSnufob72EMQ8xwVCxQwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=cEqQ2QKO48iWa2QeDk7
	gzh+7JBaJCSSxx+0/G18Vzx2vOup6ZC4inMXvO4mf3yIktlm3plCkd5h9Pb5lvC+
	EGFAgmTx4ln/5lVX0barba+ZtZCZ94ZvyOlwezvamjuwKU75umtOkkUoKrCVl7D/
	Iae5A/aSHGTyM8X/LotqZsQA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23BF96593;
	Fri, 23 Mar 2012 19:15:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2808B6591; Fri, 23 Mar 2012
 19:15:16 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0CD85A0C-753E-11E1-B5C5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193813>

A release candidate Git 1.7.10-rc2 is now available for testing at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

b32514ad69bb3100b6b5038bc88798d56ebe1e1d  git-1.7.10.rc2.tar.gz
f66bc63ed3e98df6c7ad205e06878e9cfc9084fc  git-htmldocs-1.7.10.rc2.tar.g=
z
130601149f97e9414467bb3d6a722aa37b8205af  git-manpages-1.7.10.rc2.tar.g=
z

Also the following public repositories all have a copy of the v1.7.10.r=
c2
tag and the master branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v1.7.10 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

Compatibility Notes
-------------------

 * From this release on, the "git merge" command in an interactive
   session will start an editor when it automatically resolves the
   merge for the user to explain the resulting commit, just like the
   "git commit" command does when it wasn't given a commit message.

   If you have a script that runs "git merge" and keeps its standard
   input and output attached to the user's terminal, and if you do not
   want the user to explain the resulting merge commits, you can
   export GIT_MERGE_AUTOEDIT environment variable set to "no", like
   this:

	#!/bin/sh
	GIT_MERGE_AUTOEDIT=3Dno
	export GIT_MERGE_AUTOEDIT

   to disable this behaviour (if you want your users to explain their
   merge commits, you do not have to do anything).  Alternatively, you
   can give the "--no-edit" option to individual invocations of the
   "git merge" command if you know everybody who uses your script has
   Git v1.7.8 or newer.

 * The "--binary/-b" options to "git am" have been a no-op for quite a
   while and were deprecated in mid 2008 (v1.6.0).  When you give these
   options to "git am", it will now warn and ask you not to use them.

 * When you do not tell which branches and tags to push to the "git pus=
h"
   command in any way, the command used "matching refs" rule to update
   remote branches and tags with branches and tags with the same name y=
ou
   locally have.  In future versions of Git, this will change to use th=
e
   "upstream" rule to update the branch at the remote you would "pull"
   from into your current branch with your local current branch.  The
   release after 1.7.10 will start issuing a warning about this change,
   to encourage you to tell the command what to push out, e.g. by setti=
ng
   push.default configuration.


Updates since v1.7.9
--------------------

UI, Workflows & Features

 * Teams for localizing the messages from the Porcelain layer of
   commands are starting to form, thanks to Jiang Xin who volunteered
   to be the localization coordinator.  An initial set of translated
   messages for simplified chinese is available.

 * The configuration mechanism learned an "include" facility; an
   assignment to the include.path pseudo-variable causes the named
   file to be included in-place when Git looks up configuration
   variables.

 * A content filter (clean/smudge) used to be just a way to make the
   recorded contents "more useful", and allowed to fail; a filter can
   now optionally be marked as "required".

 * Options whose names begin with "--no-" (e.g. the "--no-verify"
   option of the "git commit" command) can be negated by omitting
   "no-" from its name, e.g. "git commit --verify".

 * "git am" learned to pass "-b" option to underlying "git mailinfo", s=
o
   that a bracketed string other than "PATCH" at the beginning can be k=
ept.

 * "git clone" learned "--single-branch" option to limit cloning to a
   single branch (surprise!); tags that do not point into the history
   of the branch are not fetched.

 * "git clone" learned to detach the HEAD in the resulting repository
   when the user specifies a tag with "--branch" (e.g., "--branch=3Dv1.=
0").
   Clone also learned to print the usual "detached HEAD" advice in such
   a case, similar to "git checkout v1.0".

 * When showing a patch while ignoring whitespace changes, the context
   lines are taken from the postimage, in order to make it easier to
   view the output.

 * "git diff --stat" learned to adjust the width of the output on
   wider terminals, and give more columns to pathnames as needed.

 * "diff-highlight" filter (in contrib/) was updated to produce more
   aesthetically pleasing output.

 * "fsck" learned "--no-dangling" option to omit dangling object
   information.

 * "git log -G" and "git log -S" learned to pay attention to the "-i"
   option.  With "-i", "log -G" ignores the case when finding patch
   hunks that introduce or remove a string that matches the given
   pattern.  Similarly with "-i", "log -S" ignores the case when
   finding the commit the given block of text appears or disappears
   from the file.

 * "git merge" in an interactive session learned to spawn the editor
   by default to let the user edit the auto-generated merge message,
   to encourage people to explain their merges better. Legacy scripts
   can export GIT_MERGE_AUTOEDIT=3Dno to retain the historical behavior=
=2E
   Both "git merge" and "git pull" can be given --no-edit from the
   command line to accept the auto-generated merge message.

 * The advice message given when the user didn't give enough clue on
   what to merge to "git pull" and "git merge" has been updated to
   be more concise and easier to understand.

 * "git push" learned the "--prune" option, similar to "git fetch".

 * The whole directory that houses a top-level superproject managed by
   "git submodule" can be moved to another place.

 * "git symbolic-ref" learned the "--short" option to abbreviate the
   refname it shows unambiguously.

 * "git tag --list" can be given "--points-at <object>" to limit its
   output to those that point at the given object.

 * "gitweb" allows intermediate entries in the directory hierarchy
   that leads to a project to be clicked, which in turn shows the
   list of projects inside that directory.

 * "gitweb" learned to read various pieces of information for the
   repositories lazily, instead of reading everything that could be
   needed (including the ones that are not necessary for a specific
   task).

 * Project search in "gitweb" shows the substring that matched in the
   project name and description highlighted.

 * A new script "diffall" is added to contrib/; it drives an
   external tool to perform a directory diff of two Git revisions
   in one go, unlike "difftool" that compares one file at a time.

=46oreign Interface

 * Improved handling of views, labels and branches in "git-p4" (in cont=
rib).

 * "git-p4" (in contrib) suffered from unnecessary merge conflicts when
   p4 expanded the embedded $RCS$-like keywords; it can be now told to
   unexpand them.

 * Some "git-svn" updates.

 * "vcs-svn"/"svn-fe" learned to read dumps with svn-deltas and
   support incremental imports.

 * "git difftool/mergetool" learned to drive DeltaWalker.

Performance

 * Unnecessary calls to parse_object() "git upload-pack" makes in
   response to "git fetch", have been eliminated, to help performance
   in repositories with excessive number of refs.

Internal Implementation (please report possible regressions)

 * Recursive call chains in "git index-pack" to deal with long delta
   chains have been flattened, to reduce the stack footprint.

 * Use of add_extra_ref() API is now gone, to make it possible to
   cleanly restructure the overall refs API.

 * The command line parser of "git pack-objects" now uses parse-options
   API.

 * The test suite supports the new "test_pause" helper function.

 * Parallel to the test suite, there is a beginning of performance
   benchmarking framework.

 * t/Makefile is adjusted to prevent newer versions of GNU make from
   running tests in seemingly random order.

 * The code to check if a path points at a file beyond a symbolic link
   has been restructured to be thread-safe.

 * When pruning directories that has become empty during "git prune"
   and "git prune-packed", call closedir() that iterates over a
   directory before rmdir() it.

Also contains minor documentation updates and code clean-ups.


=46ixes since v1.7.9
------------------

Unless otherwise noted, all the fixes since v1.7.9 in the maintenance
releases are contained in this release (see release notes to them for
details).

 * Build with NO_PERL_MAKEMAKER was broken and Git::I18N did not work
   with versions of Perl older than 5.8.3.
   (merge 5eb660e ab/perl-i18n later to maint).

 * "git fast-import" accepted "ls" command with an empty path by
   mistake.
   (merge 178e1de jn/maint-fast-import-empty-ls later to maint).

 * The "remaining" subcommand to "git rerere" was not documented.
   (merge 3e7a1df ph/rerere-doc later to maint).

 * "git tag -s" honored "gpg.program" configuration variable since
   1.7.9, but "git tag -v" and "git verify-tag" didn't.
   (merge a2c2506 az/verify-tag-use-gpg-config later to maint).

 * When "git config" diagnoses an error in a configuration file and
   shows the line number for the offending line, it miscounted if the
   error was at the end of line.
   (merge 4b34059 ms/maint-config-error-at-eol-linecount later to maint=
).

 * "configure" script learned to take "--sane-tool-path" from the
   command line to record SANE_TOOL_PATH (used to avoid broken
   platform tools in /usr/bin) in config.mak-autogen.  This may be usef=
ul
   for people on Solaris who have saner tools outside /usr/xpg[46]/bin.

 * zsh port of bash completion script needed another workaround.

 * "gitweb" used to drop warnings in the log file when "heads" view is
   accessed in a repository whose HEAD does not point at a valid
   branch.

----------------------------------------------------------------

Changes since v1.7.10-rc1 are as follows:

Alex Merry (1):
      contrib/completion: "local var=3D()" is misinterpreted as func-de=
cl by zsh

D Waitzman (1):
      Documentation/gitweb: trivial English fixes

Jonathan Nieder (2):
      fast-import: leakfix for 'ls' of dirty trees
      fast-import: don't allow 'ls' of path with empty components

Junio C Hamano (4):
      fetch/receive: remove over-pessimistic connectivity check
      Update draft release notes to 1.7.10
      .mailmap: unify various old mail addresses of gitster
      Git 1.7.10-rc2

Stefano Lattarini (1):
      configure: allow user to prevent $PATH "sanitization" on Solaris

Tim Henigan (7):
      Documentation/diff-options: reword description of --submodule opt=
ion
      contrib/diffall: comment actual reason for 'cdup'
      contrib/diffall: create tmp dirs without mktemp
      contrib/diffall: eliminate use of tar
      contrib/diffall: eliminate duplicate while loops
      contrib/diffall: fix cleanup trap on Windows
      Documentation/difftool: add deltawalker to list of valid diff too=
ls

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
      Git::I18N: compatibility with perl <5.8.3
      perl/Makefile: install Git::I18N under NO_PERL_MAKEMAKER
