From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.5-rc1
Date: Wed, 06 Apr 2011 13:04:17 -0700
Message-ID: <7vd3kzi1tq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 06 22:04:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Yxu-0008Bb-Lo
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 22:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756757Ab1DFUE1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 16:04:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455Ab1DFUE0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 16:04:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 39B424898;
	Wed,  6 Apr 2011 16:06:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=MNQ2j8e0fyITnCqDQrxVEkEfv
	ME=; b=oCx2k5M3IUXs0NPFgDFS7feFJWIWw4/9hjtyPply6RxBchU87RVbx7LZD
	O61a1DhXjVFKIEwpomIwAaI2yEP0PtBQOKy29ugvzD9Uif1k/HHQaUZQfrmeessc
	y+twy3H2pu7cuEmC4Li0R9F97/KVIaRxPMTxSrujKOcQNHC5Zk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=fL0AYEsk8YwHVJc9VtZ
	7NpQq7LbfmntHl5OkHMMF9dGLREsnlmyRqmrmyg5i3/bkIU5Dvq6MLEgfQjX0IJV
	9o+42ncEBespdV5YsVr9z+IFmn+8RfXVGqo5L6yTR7UY3Pd6tE+kwLLr26ojpco8
	A7IrUhgegx8agoMXclf2rcYQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 253344897;
	Wed,  6 Apr 2011 16:06:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E65AB4895; Wed,  6 Apr 2011
 16:06:13 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5432FD50-6089-11E0-947D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171012>

A release candidate Git 1.7.5-rc1 is available at the usual places
for testing:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.5.rc1.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.5.rc1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.5.rc1.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  testing/git-*-1.7.5.rc1-1.fc13.$arch.rpm	(RPM)

Please hunt for regressions and have fun.  Thanks.

Git v1.7.5 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Updates since v1.7.4
--------------------

 * Various MinGW portability fixes.

 * Various git-p4 enhancements (in contrib).

 * Various vcs-svn enhancements.

 * Various git-gui updates (0.14.0).

 * Update to more modern HP-UX port.

 * The codebase is getting prepared for i18n/l10n; no translated
   strings nor translation mechanism in the code yet, but the strings
   are being marked for l10n.

 * The bash completion script can now complete symmetric difference
   for "git diff" command, e.g. "git diff ...bra<TAB>".

 * The default minimum length of abbreviated and unique object names
   can now be configured by setting the core.abbrev configuration
   variable.

 * "git apply -v" reports offset lines when the patch does not apply at
   the exact location recorded in the diff output.

 * "git config" used to be also known as "git repo-config", but the old
   name is now officially deprecated.

 * "git checkout --detach <commit>" is a more user friendly synonym for
   "git checkout <commit>^0".

 * "git checkout" performed on detached HEAD gives a warning and
   advice when the commit being left behind will become unreachable fro=
m
   any branch or tag.

 * "git cherry-pick" and "git revert" can be told to use a custom merge
   strategy, similar to "git rebase".

 * "git cherry-pick" remembers which commit failed to apply when it is
   stopped by conflicts, making it unnecessary to use "commit -c $commi=
t"
   to conclude it.

 * "git cvsimport" bails out immediately when the cvs server cannot be
   reached, without spewing unnecessary error messages that complain ab=
out
   the server response it never got.

 * "git fetch" vs "git upload-pack" transfer learned 'no-done'
   protocol extension to save one round-trip after the content
   negotiation is done. This saves one HTTP RPC, reducing the overall
   latency for a trivial fetch.

 * "git fetch" can be told to recursively fetch submodules on-demand.

 * "git grep -f <filename>" learned to treat "-" as "read from the
   standard input stream".

 * "git grep --no-index" did not honor pathspecs correctly, returning
   paths outside the specified area.

 * "git init" learned the --separate-git-dir option to allow the git
   directory for a new repository created elsewhere and linked via the
   gitdir mechanism. This is primarily to help submodule support later
   to switch between a branch of superproject that has the submodule
   and another that does not.

 * "git log" type commands now understand globbing pathspecs.  You
   can say "git log -- '*.txt'" for example.

 * "git log" family of commands learned --cherry and --cherry-mark
   options that can be used to view two diverged branches while omittin=
g
   or highlighting equivalent changes that appear on both sides of a
   symmetric difference (e.g. "log --cherry A...B").

 * A lazy "git merge" that didn't say what to merge used to be an error=
=2E
   When run on a branch that has an upstream defined, however, the comm=
and
   now merges from the configured upstream.

 * "git mergetool" learned how to drive "beyond compare 3" as well.

 * "git rerere forget" without pathspec used to forget all the saved
   conflicts that relate to the current merge; it now requires you to
   give it pathspecs.

 * "git rev-list --objects $revs -- $pathspec" now limits the objects l=
isted
   in its output properly with the pathspec, in preparation for narrow
   clones.

 * "git push" with no parameters gives better advice messages when
   "tracking" is used as the push.default semantics or there is no remo=
te
   configured yet.

 * A possible value to the "push.default" configuration variable,
   'tracking', gained a synonym that more naturally describes what it
   does, 'upstream'.

 * "git rerere" learned a new subcommand "remaining" that is similar to
   "status" and lists the paths that had conflicts which are known to
   rerere, but excludes the paths that have already been marked as
   resolved in the index from its output.  "git mergetool" has been
   updated to use this facility.

Also contains various documentation updates.


=46ixes since v1.7.4
------------------

All of the fixes in the v1.7.4.X maintenance series are included in thi=
s
release, unless otherwise noted.

 * "git fetch" from a client that is mostly following the remote
   needlessly told all of its refs to the server for both sides to
   compute the set of objects that need to be transferred efficiently,
   instead of stopping when the server heard enough. In a project with
   many tags, this turns out to be extremely wasteful, especially over
   the smart HTTP transport (sp/maint-{upload,fetch}-pack-stop-early~1)=
=2E

 * "git fetch" run from a repository that uses the same repository as
   its alternate object store as the repository it is fetching from
   did not tell the server that it already has access to objects
   reachable from the refs in their common alternate object store,
   causing it to fetch unnecessary objects (jc/maint-fetch-alt).

 * "git remote add --mirror" created a configuration that is suitable f=
or
   doing both a mirror fetch and a mirror push at the same time, which
   made little sense.  We now warn and require the command line to spec=
ify
   either --mirror=3Dfetch or --mirror=3Dpush.

----------------------------------------------------------------

Changes since v1.7.5-rc0 are as follows:

Dan McGee (2):
      Remove old binaries from .gitignore
      Fix two unused variable warnings in gcc 4.6

Jakub Narebski (1):
      gitweb: Fix parsing of negative fractional timezones in JavaScrip=
t

Jared Hance (1):
      merge: match the help text with the documentation

Jeff King (7):
      merge: merge unborn index before setting ref
      pull: do not clobber untracked files on initial pull
      remote: disallow some nonsensical option combinations
      remote: separate the concept of push and fetch mirrors
      remote: deprecate --mirror
      docs: fix filter-branch subdir example for exotic repo names
      pull: do not clobber untracked files on initial pull

Jens Lehmann (7):
      fetch/pull: recurse into submodules when necessary
      fetch/pull: Add the 'on-demand' value to the --recurse-submodules=
 option
      config: teach the fetch.recurseSubmodules option the 'on-demand' =
value
      Submodules: Add 'on-demand' value for the 'fetchRecurseSubmodule'=
 option
      fetch/pull: Don't recurse into a submodule when commits are alrea=
dy present
      submodule update: Don't fetch when the submodule commit is alread=
y present
      fetch/pull: Describe --recurse-submodule restrictions in the BUGS=
 section

Joe Ratterman (1):
      grep: allow -E and -n to be turned on by default via configuratio=
n

Jonathan Nieder (1):
      compat: add missing #include <sys/resource.h>

Junio C Hamano (8):
      merge: merge with the default upstream branch without argument
      "log --cherry-pick" documentation regression fix
      Doc: mention --delta-base-offset is the default for Porcelain com=
mands
      Git 1.7.4.3
      Update release notes
      Start preparing for 1.7.4.4
      Git 1.7.4.4
      Git 1.7.5-rc1

Lawrence Mitchell (1):
      git.el: Don't use font-lock-compile-keywords

Michael J Gruber (3):
      revisions.txt: consistent use of quotes
      revisions.txt: structure with a labelled list
      revisions.txt: language improvements

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
      git-init.txt: move description section up
      init, clone: support --separate-git-dir for .git file

Nicolas Morey-Chaisemartin (1):
      submodule: process conflicting submodules only once

SZEDER G=C3=A1bor (1):
      Documentation: trivial grammar fix in core.worktree description

Stephen Boyd (2):
      Makefile: Cover more files with make check
      sparse: Fix errors and silence warnings

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (70):
      i18n: git-init basic messages
      i18n: git-init "Initialized [...] repository" message
      i18n: git-clone basic messages
      i18n: git-clone "Cloning into" message
      i18n: git-clone "Cloning into" message
      i18n: git-add basic messages
      i18n: git-add "The following paths are ignored" message
      i18n: git-add "did not match any files" message
      i18n: git-add "remove '%s'" message
      i18n: git-add "Unstaged changes" message
      i18n: git-branch basic messages
      i18n: git-branch "remote branch '%s' not found" message
      i18n: git-branch "Deleted branch [...]" message
      i18n: git-branch "git branch -v" messages
      i18n: git-branch "(no branch)" message
      i18n: git-checkout basic messages
      i18n: git-checkout: our/their version message
      i18n: git-checkout describe_detached_head messages
      i18n: git-checkout "HEAD is now at" message
      i18n: git-checkout "Switched to a .. branch" message
      i18n: git-commit basic messages
      i18n: git-commit "middle of a merge" message
      i18n: git-commit formatting messages
      i18n: git-commit print_summary messages
      i18n: git-commit "enter the commit message" message
      i18n: git-commit advice messages
      i18n: git-diff basic messages
      i18n: git-fetch basic messages
      i18n: git-fetch formatting messages
      i18n: git-fetch update_local_ref messages
      i18n: git-fetch split up "(non-fast-forward)" message
      i18n: git-grep basic messages
      i18n: git-grep "--open-files-in-pager" message
      i18n: git-log basic messages
      i18n: git-log "--OPT does not make sense" messages
      i18n: git-merge basic messages
      i18n: git-merge "Updating %s..%s" message
      i18n: git-merge "You have not concluded your merge" messages
      i18n: git-merge "Wonderful" message
      i18n: git-mv basic messages
      i18n: git-mv "bad" messages
      i18n: git-rm basic messages
      i18n: git-reset basic messages
      i18n: git-reset reset_type_names messages
      i18n: git-reset "Unstaged changes after reset" message
      i18n: git-tag basic messages
      i18n: git-tag tag_template message
      i18n: git-push basic messages
      i18n: git-push "prevent you from losing" message
      i18n: git-status basic messages
      i18n: git-status "nothing to commit" messages
      i18n: git-status shortstatus messages
      i18n: git-status "Changes to be committed" message
      i18n: git-status "Initial commit" message
      i18n: git-status "renamed: " message
      i18n: git-archive basic messages
      i18n: git-bundle basic messages
      i18n: git-clean basic messages
      i18n: git-clean clean.requireForce messages
      i18n: git-describe basic messages
      i18n: git-gc basic messages
      i18n: git-gc "Auto packing the repository" message
      i18n: git-notes basic commands
      i18n: git-notes GIT_NOTES_REWRITE_MODE error message
      i18n: git-revert basic messages
      i18n: git-revert "Your local changes" message
      i18n: git-revert literal "me" messages
      i18n: git-revert split up "could not revert/apply" message
      i18n: git-shortlog basic messages
      t2019-checkout-ambiguous-ref.sh: depend on C_LOCALE_OUTPUT
