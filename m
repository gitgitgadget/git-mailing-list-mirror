From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Wed, 22 Aug 2007 17:37:21 -0700
Message-ID: <7vejhvw0fy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 02:37:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO0hk-0002M8-EA
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 02:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbXHWAhl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 22 Aug 2007 20:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbXHWAhl
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 20:37:41 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:53482 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbXHWAhj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 20:37:39 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 845AF1264D3
	for <git@vger.kernel.org>; Wed, 22 Aug 2007 20:38:00 -0400 (EDT)
X-maint-at: b13ef4916ac5a25cc5897f85ba0b4c5953cff609
X-master-at: aabb2e515c334cbca9d9ae9873a188cef2c9b3ba
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56440>

Many documentation updates, fast-import fixes and enhancements,
updated gitk.

Hopefully we can do the final without another -rc sometime early
next week.

----------------------------------------------------------------

* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (3):
  Fix whitespace in "Format of STDIN stream" of fast-import
  Avoid using va_copy in fast-import: it seems to be unportable.
  Fix git-remote for ActiveState Perl

Alexandre Julliard (1):
  git.el: Avoid a lisp error when there's no current branch (detached
      HEAD).

Arjen Laarhoven (2):
  gitk: Make the date/time display configurable
  t1301-shared-repo.sh: fix 'stat' portability issue

Brian Downing (1):
  Clarify actual behavior of 'git add' and ignored files

Brian Gernhardt (1):
  Minor clarifications to git-filter-branch usage and doc

Dave Watson (1):
  Fix misspelling of 'suppress' in docs

Eric Wong (1):
  git-svn: update documentation with CAVEATS section

Johannes Sixt (1):
  gitk: Handle 'copy from' and 'copy to' in diff headers.

Junio C Hamano (5):
  Documentation/git-rebase: fix an example
  Clean-up read-tree error condition.
  fast-import pull request
  git clone: do not issue warning while cloning locally across
      filesystems
  GIT 1.5.3-rc6

Lars Hjemli (1):
  git-submodule: re-enable 'status' as the default subcommand

Linus Torvalds (2):
  Make thin-pack generation subproject aware.
  Take binary diffs into account for "git rebase"

Lukas Sandstr=C3=B6m (1):
  Add the word reflog to
      Documentation/config.txt:core.logAllRefUpdates

Mark Levedahl (1):
  git-completion.bash - add support for git-bundle

Matthieu Moy (1):
  Add and document a global --no-pager option for git.

Mike Hommey (1):
  Clarify commit-tree documentation

Paul Mackerras (3):
  gitk: Fix warning when removing a branch
  gitk: Fix bug in fix for warning when removing a branch
  gitk: Add a window to list branches, tags and other references

Quy Tonthat (1):
  Fix breakage in git-rev-list.txt

Ren=C3=A9 Scharfe (1):
  Documentation: update tar.umask default

Sean Estabrooks (2):
  Fix small typo in git send-email man page.
  Reset terminal attributes when terminating git send-email

Shawn O. Pearce (13):
  git-gui: Avoid Tcl error in popup menu on diff viewer
  Actually allow TAG_FIXUP branches in fast-import
  Use handy ALLOC_GROW macro in fast-import when possible
  Teach fast-import to ignore lines starting with '#'
  Make trailing LF following fast-import `data` commands optional
  Make trailing LF optional for all fast-import commands
  Allow frontends to bidirectionally communicate with fast-import
  Generate crash reports on die in fast-import
  Include recent command history in fast-import crash reports
  Correct documentation of 'reflog show' to explain it shows HEAD
  Don't allow combination of -g and --reverse as it doesn't work
  Fix new-workdir (again) to work on bare repositories
  Suggest unsetting core.bare when using new-workdir on a bare
      repository

Stefan Sperling (1):
  Document -u option in git-svnimport man page

Steffen Prohaska (1):
  gitk: Let user easily specify lines of context in diff view

Steven Grimm (1):
  Document what the stage numbers in the :$n:path syntax mean.

V=C3=A4in=C3=B6 J=C3=A4rvel=C3=A4 (1):
  git-gui: Added support for OS X right click
