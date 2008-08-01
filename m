From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Jul 2008, #09; Thu, 31)
Date: Thu, 31 Jul 2008 18:02:53 -0700
Message-ID: <7vljzhv96q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 03:04:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOj41-0002f5-42
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 03:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbYHABDG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2008 21:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752931AbYHABDG
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 21:03:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbYHABDF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 21:03:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 50B2C481EB;
	Thu, 31 Jul 2008 21:03:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 815E7481EA; Thu, 31 Jul 2008 21:03:00 -0400 (EDT)
X-maint-at: bfce5087ee01fdead5cdc52180c8eef22adbbd71
X-master-at: 0fe8c1381043ef64fce1b8372df19046a4b1518e
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 97261B42-5F65-11DD-9E3A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91014>

Some git-gui updates for 1.6.0 are included, and then many minor fixes.
Perhaps -rc2 this weekend.

* The 'master' branch has these since the last announcement.

Abhijit Menon-Sen (5):
  git-gui: Look for gitk in $PATH, not $LIBEXEC/git-core
  Clarify that "git log x.c y.h" lists commits that touch either file
  `git submodule add` now requires a <path>
  Make it clear that push can take multiple refspecs
  Make the DESCRIPTION match <x>... items in the SYNOPSIS

Alex Riesen (1):
  Make use of stat.ctime configurable

Alexander Gavrilov (7):
  Fix pre-commit hooks under MinGW/MSYS
  Add options to control the search for copies in blame.
  Kill the blame back-end on window close.
  Add a menu item to invoke full copy detection in blame.
  git-gui: Fix the Remote menu separator.
  git-gui: Preserve scroll position on reshow_diff.
  Support copy and rename detection in fast-export.

Anders Melchiorsen (2):
  Documentation: fix diff.external example
  Advertise the ability to abort a commit

Bj=C3=B6rn Steinbrink (1):
  rev-parse: Add support for the ^! and ^@ syntax

Brian Gernhardt (1):
  Documentation: Remove mentions of git-svnimport.

Cesar Eduardo Barros (2):
  Documentation/git-submodule.txt: fix doubled word
  Documentation/git-rev-parse.txt: update for new git-describe output
    format

Christian Couder (2):
  merge-base: die with an error message if not passed a commit ref
  documentation: user-manual: update "using-bisect" section

Jakub Narebski (1):
  gitweb: More about how gitweb gets 'owner' of repository

Jeff King (2):
  init: handle empty "template" parameter
  Compact commit template message

Johannes Schindelin (1):
  Avoid chdir() in list_commands_in_dir()

Johannes Sixt (2):
  git-gui: Fix "Stage/Unstage Line" with one line of context.
  git-gui: "Stage Line": Treat independent changes in adjacent lines be=
tter

Jonathan Nieder (1):
  t6030 (bisect): work around Mac OS X "ls"

Junio C Hamano (11):
  make sure parsed wildcard refspec ends with slash
  GIT 1.6.0-rc1
  Allow building without any git installed
  Allow installing in the traditional way
  ls-tree documentation: enhance notes on subdirectory and pathspec
    behaviour
  Documentation: clarify what is shown in "git-ls-files -s" output
  t7001: fix "git mv" test
  Teach gitlinks to ie_modified() and ce_modified_check_fs()
  Fix merge name generation in "merge in C"
  Fix test-parse-options "integer" test
  Teach --find-copies-harder to "git blame"

Kevin Ballard (1):
  format-patch: Produce better output with --inline or --attach

Lars Hjemli (3):
  builtin-branch: remove duplicated code
  builtin-branch: factor out merge_filter matching
  builtin-branch: fix -v for --[no-]merged

Lee Marlow (1):
  bash completion: Add completion for 'git help'

Olivier Marin (1):
  builtin-verify-tag: fix -v option parsing

Petr Baudis (2):
  git-mv: Remove dead code branch
  git-mv: Keep moved index entries inact

Pierre Habouzit (1):
  Allow "non-option" revision options in parse_option-enabled commands

Shawn O. Pearce (3):
  git-gui: Correct 'Visualize Branches' on Mac OS X to start gitk
  fsck: Don't require tmp_obj_ file names are 14 bytes in length
  git-gui: Fix gitk search in $PATH to work on Windows

Steffen Prohaska (5):
  Refactor, adding prepare_git_cmd(const char **argv)
  run-command (Windows): Run dashless "git <cmd>"
  git-gui: Correct installation of library to be $prefix/share
  git-gui (Windows): Switch to relative discovery of oguilib
  git-gui (Windows): Change wrapper to execdir 'libexec/git-core'

Thomas Rast (1):
  bash completion: Add long options for 'git describe'

Todd Zullinger (1):
  Replace uses of "git-var" with "git var"
