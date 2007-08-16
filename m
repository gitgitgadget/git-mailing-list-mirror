From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Wed, 15 Aug 2007 22:02:55 -0700
Message-ID: <7v1we4m5q8.fsf@gitster.siamese.dyndns.org>
References: <7vir7mo42w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 07:03:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILXVm-0008Ou-IV
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 07:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbXHPFDH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 16 Aug 2007 01:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753111AbXHPFDH
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 01:03:07 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:51238 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbXHPFDF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Aug 2007 01:03:05 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C109E120F4C;
	Thu, 16 Aug 2007 01:03:24 -0400 (EDT)
X-maint-at: b13ef4916ac5a25cc5897f85ba0b4c5953cff609
X-master-at: 312efe9b58edb428132f0bf0fdc7f3d6a41f1183
In-Reply-To: <7vir7mo42w.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 11 Aug 2007 01:41:59 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55978>

Maintenance release 1.5.2.5 is out, so that a fix for "add -u"
breakage can be propagated out to a released version without
waiting for the 1.5.3 final.

The 'master' branch has a few more fixes since -rc5.  Notable
are:

 - fix "add -u" (in 'maint');
 - fix "read-tree -m base1 base2 ours theirs";
 - fix "clone --bare";
 - teach "git apply" to handle submodule patches;

I would like to ask subsystem people to give a pull request
destined for the 1.5.3 final by the end of the week, so that we
can do -rc6 and make it the last rc in this cycle.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

Junio C Hamano (2):
  Fix "git add -u" data corruption.
  GIT 1.5.2.5

Salikh Zakirov (1):
  git-add -u paths... now works from subdirectory


* The 'master' branch has these since the last announcement
  in addition to the above.

Alberto Bertogli (1):
  Allow git-svnimport to take "" as the trunk directory.

Alex Riesen (2):
  gitk: Continue and show error message in new repos
  gitk: Show an error and exit if no .git could be found

Alexandre Julliard (3):
  git.el: Add support for interactive diffs.
  git.el: Always set the current directory in the git-diff buffer.
  git-add: Add support for --refresh option.

Brian Downing (1):
  Add read_cache to builtin-check-attr

Brian Gernhardt (1):
  Fix t5701-clone-local for white space from wc

David Kastrup (2):
  git-sh-setup.sh: make GIT_DIR absolute
  Add a test for git-commit being confused by relative GIT_DIR

Eric Wong (1):
  git-svn: fix log with single revision against a non-HEAD branch

Junio C Hamano (10):
  t3404: fix "fake-editor"
  builtin-bundle create - use lock_file
  git-diff: squelch "empty" diffs
  merge-recursive: do not rudely die on binary merge
  attr.c: refactoring
  attr.c: read .gitattributes from index as well.
  GIT 1.5.3-rc5
  Fix read-tree merging more than 3 trees using 3-way merge
  Update documentation links for older releases.
  git-clone: allow --bare clone

Luiz Fernando N. Capitulino (3):
  Avoid ambiguous error message if pack.idx header is wrong
  Introduces xmkstemp()
  Use xmkstemp() instead of mkstemp()

Marco Costalba (1):
  Add --log-size to git log to print message size

Mark Levedahl (3):
  gitk: Enable selected patch text on Windows
  gitk: Handle MouseWheel events on Windows
  t3902 - skip test if file system doesn't support HT in names

Nicolas Pitre (1):
  pack-objects: remove bogus arguments to delta_cacheable()

Paul Mackerras (4):
  gitk: Add a context menu for file list entries
  gitk: Fix bug causing the "can't unset idinlist(...)" error
  gitk: Fix bug introduced in commit 67a4f1a7
  gitk: Fix bug causing Tcl error when updating graph

Reece H. Dunn (1):
  git-p4: Fix the sorting of changelists when cloning a Perforce
      repository.

Ren=C3=A9 Scharfe (3):
  diff: don't run pager if user asked for a diff style exit code
  diff: squelch empty diffs even more
  path-list.c: always free strdup'ed paths

Steffen Prohaska (1):
  Improved hint on how to set identity

Sven Verdoolaege (1):
  git-apply: apply submodule changes
