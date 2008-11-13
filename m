From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Nov 2008, #02; Wed, 12)
Date: Wed, 12 Nov 2008 18:16:39 -0800
Message-ID: <7v3ahwjrp4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 03:18:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Rmb-0004r1-VZ
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 03:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbYKMCQz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Nov 2008 21:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbYKMCQy
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 21:16:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56138 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbYKMCQx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Nov 2008 21:16:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8647F168D6;
	Wed, 12 Nov 2008 21:16:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DE07A168D8; Wed, 12 Nov 2008 21:16:41 -0500 (EST)
X-maint-at: c14639f7b14d3d856c7c1f6c097dd1cb9615a5d0
X-master-at: 171d7661eda111d3e35f6e8097a1a3a07b30026c
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 22BA0532-B129-11DD-92F4-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100846>

The last maintenance release 1.6.0.4 was released a few days ago.  Ther=
e
are a few fixes already on 'maint', and also a handful more fixes cooki=
ng
in 'next', for 1.6.0.5.

I'd like to start closing the cycle for 1.6.1 by declaring -rc0 by the =
end
of this week.  In early next month, hopefully -rc1 can contain everythi=
ng
we have in 'next' tonight, plus a handful more topics that are currentl=
y
parked in 'pu'.

* The 'maint' branch has these fixes since the last announcement.

Alex Riesen (7):
  Add mksnpath which allows you to specify the output buffer
  Fix mkpath abuse in dwim_ref and dwim_log of sha1_name.c
  Fix potentially dangerous uses of mkpath and git_path
  Add git_snpath: a .git path formatting routine with output buffer
  Fix potentially dangerous use of git_path in ref.c
  git_pathdup: returns xstrdup-ed copy of the formatted path
  Use git_pathdup instead of xstrdup(git_path(...))

Alexandre Julliard (2):
  checkout: Don't crash when switching away from an invalid branch.
  git-submodule: Avoid printing a spurious message.

Christian Couder (2):
  Documentation: rev-list: change a few instances of "git-cmd" to "git =
cmd"
  Documentation: bisect: change a few instances of "git-cmd" to "git cm=
d"

Christian Jaeger (1):
  Git.pm: do not break inheritance

Clemens Buchacher (2):
  do not force write of packed refs
  push: fix local refs update if already up-to-date

Daniel Lowe (1):
  Fix non-literal format in printf-style calls

Jeff King (1):
  refactor handling of "other" files in ls-files and status

Johannes Schindelin (1):
  Fix fetch/pull when run without --update-head-ok

Junio C Hamano (11):
  pull: allow "git pull origin $something:$current_branch" into an unbo=
rn
    branch
  Fix "checkout --track -b newbranch" on detached HEAD
  reset --hard/read-tree --reset -u: remove unmerged new paths
  demonstrate breakage of detached checkout with symbolic link HEAD
  Enhance hold_lock_file_for_{update,append}() API
  Update draft 1.6.0.4 release notes
  format-patch documentation: mention the special case of showing a sin=
gle
    commit
  GIT 1.6.0.4
  Makefile: help people who run 'make check' by mistake
  checkout: Fix "initial checkout" detection
  Start 1.6.0.5 cycle

Matt Kraai (1):
  Remove the period after the git-check-attr summary

Mikael Magnusson (1):
  Document that git-log takes --all-match.

Miklos Vajna (5):
  Fix git branch -m for symrefs.
  rename_ref(): handle the case when the reflog of a ref does not exist
  Fix git update-ref --no-deref -d.
  git branch -m: forbid renaming of a symref
  update-ref --no-deref -d: handle the case when the pointed ref is pac=
ked

Nicolas Pitre (1):
  Fix pack.packSizeLimit and --max-pack-size handling

Quy Tonthat (1):
  Update RPM spec for the new location of git-cvsserver.

Stefan Naewe (1):
  git ls-remote: make usage string match manpage

Yann Dirson (1):
  Add reference for status letters in documentation.


* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (1):
  Fix potentially dangerous uses of mkpath and git_path

Alexander Gavrilov (5):
  builtin-blame: Reencode commit messages according to git-log rules.
  Windows: Make OpenSSH properly detect tty detachment.
  gitweb: Use single implementation of export_ok check.
  gitweb: Add a per-repository authorization hook.
  gitweb: Fix mod_perl support.

Brian Downing (2):
  Always initialize xpparam_t to 0
  Allow alternate "low-level" emit function from xdl_diff

Christian Couder (1):
  bisect: fix missing "exit"

Daniel Lowe (1):
  Fix non-literal format in printf-style calls

David M. Syzdek (1):
  autoconf: Add link tests to each AC_CHECK_FUNC() test

David Symonds (1):
  git-diff: Add --staged as a synonym for --cached.

Giuseppe Bilotta (5):
  gitweb: parse project/action/hash_base:filename PATH_INFO
  gitweb: generate project/action/hash URLs
  gitweb: use_pathinfo filenames start with /
  gitweb: parse parent..current syntax from PATH_INFO
  gitweb: generate parent..current URLs

Jeff King (1):
  t5400: expect success for denying deletion

John Chapman (2):
  git-p4: Support purged files and optimize memory usage
  git-p4: Cache git config for performance

Junio C Hamano (6):
  Fix reading of cloud tags
  rebase-i-p: minimum fix to obvious issues
  git-rebase--interactive.sh: comparision with =3D=3D is bashism
  Update draft release notes to 1.6.1
  Update draft release notes to 1.6.1
  git.html: Update the links to stale versions

Markus Heidelberg (1):
  Makefile: add install-man rules (quick and normal)

Miklos Vajna (1):
  parse-opt: migrate builtin-checkout-index.

Nicolas Pitre (5):
  index-pack: rationalize delta resolution code
  index-pack: smarter memory usage during delta resolution
  fix multiple issues in index-pack
  improve index-pack tests
  index-pack: don't leak leaf delta result

Pete Harlan (2):
  contrib/hooks/post-receive-email: Put rev display in separate functio=
n
  contrib/hooks/post-receive-email: Make revision display configurable

Ren=C3=A9 Scharfe (3):
  blame: inline get_patch()
  add xdi_diff_hunks() for callers that only need hunk lengths
  blame: use xdi_diff_hunks(), get rid of struct patch

Stephen Haberman (7):
  rebase-i-p: test to exclude commits from todo based on its parents
  rebase-i-p: use HEAD for updating the ref instead of mapping OLDHEAD
  rebase-i-p: delay saving current-commit to REWRITTEN if squashing
  rebase-i-p: fix 'no squashing merges' tripping up non-merges
  rebase-i-p: only list commits that require rewriting in todo
  rebase-i-p: do not include non-first-parent commits touching UPSTREAM
  rebase-i-p: if todo was reordered use HEAD as the rewritten parent
