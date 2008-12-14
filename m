From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Dec 2008, #02; Sun, 14)
Date: Sun, 14 Dec 2008 00:24:44 -0800
Message-ID: <7v8wqj2mgj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 14 09:26:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBmIj-0001w1-W2
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 09:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbYLNIYv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Dec 2008 03:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbYLNIYv
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 03:24:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbYLNIYu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Dec 2008 03:24:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CE1D387E6D;
	Sun, 14 Dec 2008 03:24:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C48EE87E6C; Sun,
 14 Dec 2008 03:24:46 -0500 (EST)
X-maint-at: 544ddb045a4bd49da9ffc1d9da80bdc0d71b2518
X-master-at: 7e76aba317b690932c8236311219b0faf97f1571
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AC07804C-C9B8-11DD-A9B4-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103051>

There are a handful fixes since 1.6.1-rc2 on 'master' and I am hoping t=
hat
we can do -rc3 later today, and declare the 1.6.1 final on the 20th or
so.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

Brandon Casey (11):
  t7700: demonstrate mishandling of objects in packs with a .keep file
  packed_git: convert pack_local flag into a bitfield and add pack_keep
  pack-objects: new option --honor-pack-keep
  repack: don't repack local objects in packs with .keep file
  repack: do not fall back to incremental repacking with [-a|-A]
  builtin-gc.c: use new pack_keep bitfield to detect .keep file existen=
ce
  t7700: demonstrate mishandling of loose objects in an alternate ODB
  sha1_file.c: split has_loose_object() into local and non-local
    counterparts
  pack-objects: extend --local to mean ignore non-local loose objects t=
oo
  t7700: test that 'repack -a' packs alternate packed objects
  repack: only unpack-unreachable if we are deleting redundant packs

Davide Libenzi (1):
  xdiff: give up scanning similar lines early

Deskin Miller (1):
  git-svn: Make following parents atomic

Jakub Narebski (1):
  gitweb: Make project specific override for 'grep' feature work

Jeff King (2):
  commit: Fix stripping of patch in verbose mode.
  tag: delete TAG_EDITMSG only on successful tag

Jim Meyering (1):
  git-config.txt: fix a typo

Johannes Sixt (1):
  compat/mingw.c: Teach mingw_rename() to replace read-only files

Junio C Hamano (2):
  GIT 1.6.0.5
  work around Python warnings from AsciiDoc

Linus Torvalds (1):
  fsck: reduce stack footprint

Matt McCutchen (1):
  "git diff <tree>{3,}": do not reverse order of arguments

Miklos Vajna (1):
  http.c: use 'git_config_string' to get 'curl_http_proxy'

Nicolas Pitre (1):
  make sure packs to be replaced are closed beforehand

Thomas Rast (1):
  fetch-pack: Avoid memcpy() with src=3D=3Ddst


* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (3):
  Make some of fwrite/fclose/write/close failures visible
  Make chdir failures visible
  Report symlink failures in merge-recursive

Alexander Potashev (2):
  Fix typos in documentation
  Fix typo in comment in builtin-add.c

Alexey Borzenkov (1):
  Define linkgit macro in [macros] section

Brandon Casey (1):
  git-branch: display sha1 on branch deletion

Deskin Miller (1):
  git-svn: Make branch use correct svn-remote

Jakub Narebski (2):
  gitweb: Fix handling of non-ASCII characters in inserted HTML files
  gitweb: Fix bug in insert_file() subroutine

Jeff King (6):
  add stage to gitignore
  reorder ALLOW_TEXTCONV option setting
  diff: allow turning on textconv explicitly for plumbing
  diff: fix handling of binary rewrite diffs
  diff: respect textconv in rewrite diffs
  rebase: improve error messages about dirty state

Junio C Hamano (16):
  builtin-rm.c: explain and clarify the "local change" logic
  git add --intent-to-add: fix removal of cached emptiness
  git add --intent-to-add: do not let an empty blob be committed by
    accident
  Install git-stage in exec-path
  git-am --whitespace: do not lose the command line option
  git-am: propagate -C<n>, -p<n> options as well
  git-am: propagate --3way options as well
  Test that git-am does not lose -C/-p/--whitespace options
  git-am: rename apply_opt_extra file to apply-opt
  Update draft release notes to 1.6.1
  Update draft release notes for 1.6.1
  Revert "git-stash: use git rev-parse -q"
  Point "stale" 1.6.0.5 documentation from the main git documentation p=
age
  builtin-checkout.c: check error return from read_cache()
  read-cache.c: typofix in comment
  Fix t4031

Markus Heidelberg (1):
  builtin-commit: remove unused message variable

Miklos Vajna (5):
  filter-branch: use git rev-parse -q
  lost-found: use git rev-parse -q
  pull: use git rev-parse -q
  rebase: use git rev-parse -q
  submodule: use git rev-parse -q

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  Extend index to save more flags

Ralf Wildenhues (1):
  Improve language in git-merge.txt and related docs

Tor Arvid Lund (2):
  git-p4: Fix bug in p4Where method.
  git-p4: Fix regression in p4Where method.
