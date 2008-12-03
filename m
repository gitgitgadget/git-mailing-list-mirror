From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Dec 2008, #01; Tue, 02)
Date: Tue, 02 Dec 2008 22:23:58 -0800
Message-ID: <7vvdu1hj41.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 07:25:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7lAq-0001C1-0s
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 07:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbYLCGYH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Dec 2008 01:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752288AbYLCGYG
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 01:24:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbYLCGYE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2008 01:24:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5A26383C80;
	Wed,  3 Dec 2008 01:24:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3DB4983C7F; Wed,
  3 Dec 2008 01:24:00 -0500 (EST)
X-maint-at: 25e30fa08e687d584d9dd87d13acf84bb1e1858c
X-master-at: 757c7f60a78004fc3d0ea62f44320d54ef430c10
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FA3FD192-C102-11DD-A996-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102217>

We'll probably have 1.6.0.5 by the end of this week.

The tip of the 'master' branch is at 1.6.1-rc1 with a few more fixes.
Hopefully we will have the final 1.6.1 by the end of the year.

* The 'maint' branch has these fixes since the last announcement.

Joey Hess (1):
  sha1_file: avoid bogus "file exists" error message

Johannes Schindelin (1):
  fast-export: use an unsorted string list for extra_refs

Junio C Hamano (1):
  Update draft release notes to 1.6.0.5

Martin Koegler (1):
  git push: Interpret $GIT_DIR/branches in a Cogito compatible way

Matt McCutchen (1):
  git checkout: don't warn about unborn branch if -f is already passed

Miklos Vajna (2):
  Add new testcase to show fast-export does not always exports all tags
  User's Manual: remove duplicated url at the end of Appendix B

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  generate-cmdlist.sh: avoid selecting synopsis at wrong place

Pete Wyckoff (1):
  git-p4: fix keyword-expansion regex

Ralf Wildenhues (1):
  Fix typos in the documentation.

SZEDER G=C3=A1bor (2):
  bash: remove dashed command leftovers
  bash: offer refs instead of filenames for 'git revert'

Sam Vilain (1):
  sha1_file.c: resolve confusion EACCES vs EPERM

Samuel Tardieu (2):
  tag: Check that options are only allowed in the appropriate mode
  tag: Add more tests about mixing incompatible modes and options


* The 'master' branch has these since the last announcement
  in addition to the above.

Alexander Gavrilov (3):
  gitk: Avoid handling the Return key twice in Add Branch
  gitk: Make line origin search update the busy status
  gitk: Add a menu option to start git gui

Cheng Renquan (1):
  git-remote: add verbose mode to git remote update

Christian Couder (4):
  git-gui: french translation update
  bisect: teach "skip" to accept special arguments like "A..B"
  bisect: fix "git bisect skip <commit>" and add tests cases
  Documentation: describe how to "bisect skip" a range of commits

Christian Stimming (1):
  gitk: Update German translation

Giuseppe Bilotta (2):
  gitweb: make gitweb_check_feature a boolean wrapper
  Update comment on gitweb_check/get_feature

Johannes Schindelin (1):
  Document levenshtein.c

Johannes Sixt (2):
  compat/mingw.c: Teach mingw_rename() to replace read-only files
  t4030-diff-textconv: Make octal escape sequence more portable

Junio C Hamano (6):
  gitweb: fix 'ctags' feature check and others
  gitweb: rename gitweb_check_feature to gitweb_get_feature
  send-email: do not reverse the command line arguments
  Include git-gui--askpass in git-gui RPM package
  GIT 1.6.1-rc1
  Makefile: introduce NO_PTHREADS

Linus Torvalds (3):
  Add cache preload facility
  Fix index preloading for racy dirty case
  Add backslash to list of 'crud' characters in real name

Mark Burton (1):
  git-gui: Teach start_push_anywhere_action{} to notice when remote is =
a
    mirror.

Michele Ballabio (1):
  git gui: update Italian translation

Miklos Vajna (5):
  Update Hungarian translation. 100% completed.
  builtin-clone: use strbuf in guess_dir_name()
  builtin-clone: use strbuf in clone_local() and copy_or_link_directory=
()
  builtin_clone: use strbuf in cmd_clone()
  git-stash: use git rev-parse -q

Nanako Shiraishi (1):
  git-gui: update Japanese translation

Paul Mackerras (6):
  gitk: Index line[hnd]tag arrays by id rather than row number
  gitk: Fix switch statement in parseviewargs
  gitk: Show local changes properly when we have a path limit
  gitk: Fix context menu items for generating diffs when in tree mode
  gitk: Highlight only when search type is "containing:".
  gitk: Fix bug in accessing undefined "notflag" variable

Peter Krefting (1):
  Updated Swedish translation (514t0f0u).

Pierre Habouzit (4):
  git send-email: make the message file name more specific.
  git send-email: interpret unknown files as revision lists
  git send-email: add --annotate option
  git send-email: ask less questions when --compose is used.

Ralf Wildenhues (1):
  Fix typos in the documentation.

Ren=C3=A9 Scharfe (6):
  add strbuf_expand_dict_cb(), a helper for simple cases
  merge-recursive: use strbuf_expand() instead of interpolate()
  daemon: use strbuf_expand() instead of interpolate()
  daemon: inline fill_in_extra_table_entries()
  daemon: deglobalize variable 'directory'
  remove the unused files interpolate.c and interpolate.h

SZEDER G=C3=A1bor (1):
  bash: complete full refs

Samuel Tardieu (1):
  Fix deletion of last character in levenshtein distance

Scott Chacon (1):
  Add a built-in alias for 'stage' to the 'add' command

Tuncer Ayaz (2):
  Teach/Fix pull/fetch -q/-v options
  Retain multiple -q/-v occurrences in git pull
