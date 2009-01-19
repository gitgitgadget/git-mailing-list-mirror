From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Jan 2009, #02; Mon, 19)
Date: Mon, 19 Jan 2009 01:13:38 -0800
Message-ID: <7vab9nr73x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 10:15:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOqE1-0001C1-0D
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 10:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbZASJNu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jan 2009 04:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754927AbZASJNr
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 04:13:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586AbZASJNq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 04:13:46 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1F36E91AC7;
	Mon, 19 Jan 2009 04:13:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1EE3B91AC6; Mon,
 19 Jan 2009 04:13:40 -0500 (EST)
X-maint-at: 9d3043cf333ee500e476a558acb234b42e43cc62
X-master-at: 28da86a58d7861626eb9d33a1bcfa3e1e79a4d13
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 790FD578-E609-11DD-A52E-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106337>

Tonight's pushout has some git-svn updates included, in addition to a
handful of new features.

Perhaps 1.6.1.1 mid next week.

* The 'maint' branch has these fixes since the last announcement.

Christian Couder (1):
  builtin-fsck: fix off by one head count

Johannes Schindelin (3):
  http-push: fix off-by-path_len
  http-push: when making directories, have a trailing slash in the path
    name
  t5540: clarify that http-push does not handle packed-refs on the remo=
te

Junio C Hamano (2):
  Update draft release notes to 1.6.1.1
  Update draft release notes for 1.6.1.1

Markus Heidelberg (1):
  Documentation: let asciidoc align related options

Michael J Gruber (2):
  add test cases for "git mv -k"
  fix handling of multiple untracked files for git mv -k

Miklos Vajna (1):
  Make t3411 executable

Stephan Beyer (5):
  t3501: check that commits are actually done
  t3404: Add test case for aborted --continue after "edit"
  t3404: Add test case for auto-amending only edited commits after "edi=
t"
  builtin-commit.c: do not remove COMMIT_EDITMSG
  githooks.txt: add missing word


* The 'master' branch has these since the last announcement
  in addition to the above.

Adeodato Sim=C3=B3 (1):
  git.c: make autocorrected aliases work

Alexander Potashev (2):
  add is_dot_or_dotdot inline function
  Allow cloning to an existing empty directory

Brandon Casey (1):
  t7700: demonstrate misbehavior of 'repack -a' when local packs exist

David Aguilar (3):
  contrib: add 'git difftool' for launching common merge tools
  difftool: fix documentation problems
  difftool: put the cursor on the editable file for Vim

David M. Syzdek (1):
  autoconf: Enable threaded delta search when pthreads are supported

Eric Wong (4):
  git-svn: handle empty files marked as symlinks in SVN
  git-svn: better attempt to handle broken symlink updates
  git-svn: fix SVN 1.1.x compatibility
  git-svn: avoid importing nested git repos

Giuseppe Bilotta (6):
  gitweb: add patch view
  gitweb: change call pattern for git_commitdiff
  gitweb: add patches view
  gitweb: link to patch(es) view in commit(diff) and (short)log view
  gitweb: don't use pathinfo for global actions
  gitweb: suggest name for OPML view

Junio C Hamano (2):
  Resurrect "git apply --flags -" to read from the standard input
  format-patch: show patch text for the root commit

Keith Cascio (1):
  test more combinations of ignore-whitespace options to diff

Marcel Koeppen (1):
  git-svn: Show UUID in svn info for added directories with svn 1.5.5

Markus Heidelberg (4):
  git-commit: color status output when color.ui is set
  git-status -v: color diff output when color.ui is set
  Documentation: let asciidoc align related options
  mergetool: put the cursor on the editable file for Vim

Miklos Vajna (1):
  parse-opt: migrate builtin-apply.

Pete Harlan (1):
  git-svn: Add --localtime option to "fetch"

Ren=C3=A9 Scharfe (3):
  shortlog: handle multi-line subjects like log --pretty=3Doneline et. =
al. do
  grep -w: forward to next possible position after rejected match
  grep: don't call regexec() for fixed strings

SZEDER G=C3=A1bor (3):
  bash: remove unnecessary checks for long options with argument
  bash: add missing format-patch command line options
  bash: refactor 'git log --pretty=3D<format>' options

Ted Pavlic (3):
  bash-completion: Support running when set -u is enabled
  bash-completion: Try bash completions before simple filetype
  bash-completion: Add comments to remind about required arguments

Thomas Rast (7):
  rebase -i: execute hook only after argument checking
  diff: accept -- when using --no-index
  diff --no-index: test for pager after option parsing
  diff --no-index -q: fix endless loop
  rebase: learn to rebase root commit
  rebase -i: learn to rebase root commit
  rebase: update documentation for --root
