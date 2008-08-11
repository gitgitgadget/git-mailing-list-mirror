From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Aug 2008, #02; Mon, 11)
Date: Mon, 11 Aug 2008 15:06:53 -0700
Message-ID: <7vy733urya.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 00:08:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSfZM-0005N8-Lh
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 00:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128AbYHKWHB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Aug 2008 18:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755048AbYHKWHA
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 18:07:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41355 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbYHKWG7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Aug 2008 18:06:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 580955C763;
	Mon, 11 Aug 2008 18:06:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 990F35C762; Mon, 11 Aug 2008 18:06:56 -0400 (EDT)
X-maint-at: 4f80b27d48fee1c588810f3341ffe5d14558cea2
X-master-at: 10d9d887ecdc81197162d7bbe5dfc0d028498fd6
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D11365A0-67F1-11DD-9286-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92009>

Minor fixes toward 1.6.0 final continue to flow in, but many of them ar=
e
also applicable to 'maint'.

Also on 'maint' branch, there are a few backmerges of topics that have
already been in 'master' for a while.  Not all of them are "fixes",
though.  We may or may not have 1.5.6.6 before 1.6.0 happens.

* The 'maint' branch has these fixes since the last announcement.

Alexander Gavrilov (1):
  Fix quadratic performance in rewrite_one.

Ivan Stankovic (1):
  Documentation: fix invalid reference to 'mybranch' in user manual

Junio C Hamano (7):
  Per-ref reflog expiry configuration
  Make default expiration period of reflog used for stash infinite
  fix diff-tree --stdin documentation
  Files given on the command line are relative to $cwd
  GIT 1.5.6.5
  asciidoc markup fixes
  Fix deleting reflog entries from HEAD reflog

Linus Torvalds (4):
  Split up default "core" config parsing into helper routine
  Split up default "user" config parsing into helper routine
  Split up default "i18n" and "branch" config parsing into helper routi=
nes
  Add config option to enable 'fsync()' of object files

Petr Baudis (1):
  Fail properly when cloning from invalid HTTP URL

Pieter de Bie (1):
  reflog test: add more tests for 'reflog delete'

Thomas Rast (1):
  Documentation: rev-list-options: Fix -g paragraph formatting


* The 'master' branch has these since the last announcement
  in addition to the above.

Alexander Gavrilov (6):
  gitk: Kill back-end processes on window close
  gitk: Arrange to kill diff-files & diff-index on quit
  gitk: On Windows, use a Cygwin-specific flag for kill
  gitk: Fixed broken exception handling in diff
  gitk: Fixed automatic row selection during load
  gitk: Fallback to selecting the head commit upon load

Brandon Casey (3):
  perl/Makefile: handle paths with spaces in the NO_PERL_MAKEMAKER sect=
ion
  Makefile: set SHELL to value of SHELL_PATH
  Makefile: add a target which will abort compilation with ancient shel=
ls

Christian Stimming (2):
  git-gui: Update German translation
  gitk: Updated German translation

Eric Wong (2):
  git-svn: add ability to specify --commit-url for dcommit
  git-svn: wrap long lines in a few places

Johannes Schindelin (1):
  clone --mirror: avoid storing repeated tags

Johannes Sixt (1):
  git-gui: Adapt discovery of oguilib to execdir 'libexec/git-core'

Jonathan Nieder (1):
  Documentation: user-manual: "git commit -a" doesn't motivate .gitigno=
re

Junio C Hamano (4):
  GIT 1.6.0-rc2
  GIT-VERSION-GEN: mark the version 'dirty' only if there are modified
    files
  mailinfo: fix MIME multi-part message boundary handling
  Update draft RelNotes for 1.6.0

Marcus Griep (2):
  Fix multi-glob assertion in git-svn
  git-svn: Allow deep branch names by supporting multi-globs

Michele Ballabio (2):
  git-gui: update po/it.po
  git-gui: add a part about format strings in po/README

Mikael Magnusson (2):
  git-gui: Update swedish translation.
  gitk: Update swedish translation.

Nanako Shiraishi (1):
  git-gui: update Japanese translation

Pieter de Bie (1):
  builtin-rm: Add a --force flag

Ren=C3=A9 Scharfe (1):
  archive: allow --exec and --remote without equal sign

SZEDER G=C3=A1bor (1):
  bash: remove redundant check for 'git stash apply' options

Shawn O. Pearce (1):
  git-gui: Update git-gui.pot for 0.11 nearing release

Thomas Rast (3):
  Documentation: commit-tree: remove 16 parents restriction
  Documentation: filter-branch: document how to filter all refs
  filter-branch: be more helpful when an annotated tag changes
