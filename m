From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.5-rc3
Date: Tue, 19 Apr 2011 15:52:28 -0700
Message-ID: <7v1v0x4zwz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:52:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCJmj-0000do-6V
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 00:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999Ab1DSWwg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2011 18:52:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab1DSWwf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2011 18:52:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 514824BE3;
	Tue, 19 Apr 2011 18:54:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=zJAhBhhH7Kzigv7wQ5QZnZrw3
	9E=; b=Uu6XdNusbPbhfUc9JRPrEVKo9zrSq5zvjzd7BW8QMpolVAPv8ZpMZpRRs
	JW9z8Et2ExE3TmOwhsB4nL1rwHkNr1UkVRLQcf2UOSE4Gax300dvWpxCZkc9qMdZ
	s18xXdW9lSFyBObI2fMChkc/a5hwuArGONlBNtVlk9NzySfDeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=REmr3SYgRilMKG7qq9R
	AHMM/MYLWDC1/JAfkcGBDwCzjw+dV8PquklxGSKjKkWhfdP7ARYY6BEkJnhAUuPd
	aQbQkZi8mxGdNoe/rZmO19uwagzKb/shEpUuMAs4a8dnggKZ7BjzuWVNysPxvvOr
	tBFWfc+xHNcjqPbc7KfsTgp4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2EA434BE2;
	Tue, 19 Apr 2011 18:54:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F37244BE0; Tue, 19 Apr 2011
 18:54:30 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDD9181E-6AD7-11E0-8F71-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171824>

A release candidate Git 1.7.5-rc3 is available at the usual places
for testing:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.5.rc3.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.5.rc3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.5.rc3.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  testing/git-*-1.7.5.rc3-1.fc13.$arch.rpm	(RPM)



Git v1.7.5 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Updates since v1.7.4
--------------------

 * Various MinGW portability fixes.

 * Various git-p4 enhancements (in contrib).

 * Various vcs-svn, git-svn and gitk enhancements and fixes.

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

Changes since v1.7.5-rc2 are as follows:

Junio C Hamano (3):
      Revert "run-command: prettify -D_FORTIFY_SOURCE workaround"
      Git 1.7.4.5
      Git 1.7.5-rc3

Michael J Gruber (3):
      git.txt: fix list continuation
      t3306,t5304: avoid clock skew issues
      git-svn.txt: Document --mergeinfo

Ren=C3=A9 Scharfe (1):
      archive: document limitation of tar.umask config setting
