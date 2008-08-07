From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.0-rc2
Date: Wed, 06 Aug 2008 17:31:54 -0700
Message-ID: <7vskthll6t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:33:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQtRF-0004yZ-Vk
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 02:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbYHGAcH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 20:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbYHGAcH
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 20:32:07 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62315 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbYHGAcE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Aug 2008 20:32:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F14154D9A1;
	Wed,  6 Aug 2008 20:32:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 344374D9A0; Wed,  6 Aug 2008 20:31:56 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 40C72D9C-6418-11DD-A233-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91554>

GIT 1.6.0-rc2 is the second (or should we call it the third?) preview o=
f
the upcoming release.  It is available at the usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.0-rc2.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.0-rc2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.0-rc2.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are also provided
as courtesy.

  testing/RPMS/$arch/*-1.6.0.rc2-1.fc9.$arch.rpm	(RPM)

----------------------------------------------------------------

Changes since v1.6.0-rc1 are as follows:

Abhijit Menon-Sen (7):
      `git submodule add` now requires a <path>
      Make it clear that push can take multiple refspecs
      Make the DESCRIPTION match <x>... items in the SYNOPSIS
      Git.pm: localise $? in command_close_bidi_pipe()
      Fix hash slice syntax error
      Fix typo in perl/Git.pm
      Fix typos in INSTALL

Alex Riesen (1):
      Make use of stat.ctime configurable

Alexander Gavrilov (9):
      git-gui: Fix the Remote menu separator.
      git-gui: Preserve scroll position on reshow_diff.
      Support copy and rename detection in fast-export.
      gitk: Kill back-end processes on window close
      gitk: Arrange to kill diff-files & diff-index on quit
      gitk: On Windows, use a Cygwin-specific flag for kill
      gitk: Fixed broken exception handling in diff
      gitk: Fixed automatic row selection during load
      gitk: Fallback to selecting the head commit upon load

Anders Melchiorsen (4):
      Advertise the ability to abort a commit
      Documentation: fix diff.external example
      Flush output in start_async
      Add output flushing before fork()

Avery Pennarun (2):
      Teach "git diff -p" Pascal/Delphi funcname pattern
      git-svn: Abort with an error if 'fetch' parameter is invalid.

Brandon Casey (3):
      t/t4202-log.sh: add newline at end of file
      Teach fsck and prune that tmp_obj_ file names may not be 14 bytes=
 long
      perl/Makefile: handle paths with spaces in the NO_PERL_MAKEMAKER =
section

Brian Gernhardt (1):
      Documentation: Remove mentions of git-svnimport.

Cesar Eduardo Barros (1):
      Documentation/git-rev-parse.txt: update for new git-describe outp=
ut format

Christian Couder (2):
      merge-base: die with an error message if not passed a commit ref
      documentation: user-manual: update "using-bisect" section

Christian Stimming (2):
      git-gui: Update German translation
      gitk: Updated German translation

Ciaran McCreesh (1):
      Make git-add -i accept ranges like 7-

David D. Kilzer (1):
      Fix race condition in t9119-git-svn-info.sh

Dmitry Potapov (1):
      correct access right for git-svn-dcommit test

Eric Wong (2):
      git-svn: properly set path for "info" command
      t9119: conditionally re-enable test depending on svn(1) version

Giuseppe Bilotta (2):
      diff: add ruby funcname pattern
      diff: chapter and part in funcname for tex

Jeff King (3):
      init: handle empty "template" parameter
      Compact commit template message
      init: handle empty "template" parameter

Jim Meyering (1):
      git-cvsimport.perl: Print "UNKNOWN LINE..." on stderr, not stdout=
=2E

Johannes Schindelin (3):
      sort_in_topological_order(): avoid setting a commit flag
      clone: Add an option to set up a mirror
      clone --bare: Add ".git" suffix to the directory name to clone in=
to

Johannes Sixt (1):
      git-gui: Adapt discovery of oguilib to execdir 'libexec/git-core'

Jon Jensen (1):
      Fix reference to Everyday Git, which is an HTML document and not =
a man page.

Jonathan Nieder (1):
      git-diff(1): "--c" -> "--cc" typo fix

Junio C Hamano (19):
      Allow building without any git installed
      Allow installing in the traditional way
      ls-tree documentation: enhance notes on subdirectory and pathspec=
 behaviour
      Documentation: clarify what is shown in "git-ls-files -s" output
      t7001: fix "git mv" test
      Teach gitlinks to ie_modified() and ce_modified_check_fs()
      Fix merge name generation in "merge in C"
      Fix test-parse-options "integer" test
      Teach --find-copies-harder to "git blame"
      make sure parsed wildcard refspec ends with slash
      Documentation: clarify diff --cc
      Update my e-mail address
      Start 1.5.6.5 RelNotes to describe accumulated fixes
      builtin-name-rev.c: split deeply nested part from the main functi=
on
      RelNotes 1.5.6.5 updates
      fix diff-tree --stdin documentation
      Files given on the command line are relative to $cwd
      GIT 1.5.6.5
      GIT 1.6.0-rc2

Kevin Ballard (1):
      format-patch: Produce better output with --inline or --attach

Lee Marlow (11):
      bash completion: remove unused function _git_diff_tree
      bash completion: Add more long options for 'git log'
      bash completion: Add completion for 'git grep'
      bash completion: Add completion for 'git clone'
      bash completion: Add completion for 'git clean'
      bash completion: Add completion for 'git init'
      bash completion: Add completion for 'git revert'
      bash completion: More completions for 'git stash'
      bash completion: Add completion for 'git archive'
      bash completion: Add completion for 'git ls-files'
      bash completion: Add completion for 'git mv'

Linus Torvalds (1):
      diff.renamelimit is a basic diff configuration

Michele Ballabio (2):
      git-gui: update po/it.po
      git-gui: add a part about format strings in po/README

Mikael Magnusson (2):
      git-gui: Update swedish translation.
      gitk: Update swedish translation.

Mike Ralphson (2):
      Documentation: typos / spelling fixes in older RelNotes
      Documentation: typos / spelling fixes

Nanako Shiraishi (1):
      git-gui: update Japanese translation

Olivier Marin (1):
      builtin-verify-tag: fix -v option parsing

Pierre Habouzit (2):
      Allow "non-option" revision options in parse_option-enabled comma=
nds
      git-submodule: move ill placed shift.

Pieter de Bie (1):
      git-name-rev: allow --name-only in combination with --stdin

Ren=C3=A9 Scharfe (2):
      archive: allow --exec and --remote without equal sign
      git-name-rev: don't use printf without format

Shawn O. Pearce (2):
      git-gui: Fix gitk search in $PATH to work on Windows
      git-gui: Update git-gui.pot for 0.11 nearing release

Steffen Prohaska (6):
      Refactor, adding prepare_git_cmd(const char **argv)
      run-command (Windows): Run dashless "git <cmd>"
      git-gui: Correct installation of library to be $prefix/share
      git-gui (Windows): Switch to relative discovery of oguilib
      git-gui (Windows): Change wrapper to execdir 'libexec/git-core'
      Modify mingw_main() workaround to avoid link errors

Stephan Beyer (1):
      builtin-revert.c: typofix

Steve Haslam (1):
      Propagate -u/--upload-pack option of "git clone" to transport.

Steven Grimm (1):
      Optimize sha1_object_info for loose objects, not concurrent repac=
ks

Todd Zullinger (1):
      Replace uses of "git-var" with "git var"
