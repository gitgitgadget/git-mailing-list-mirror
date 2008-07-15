From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: StGit: kha/{stable,safe,experimental} updated
Date: Tue, 15 Jul 2008 21:58:36 +0200
Message-ID: <20080715195836.GA24378@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 21:59:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIqgb-0002Fy-C2
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 21:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757997AbYGOT6p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jul 2008 15:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757507AbYGOT6p
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 15:58:45 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4206 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756968AbYGOT6o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 15:58:44 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KIqfU-0006NA-00; Tue, 15 Jul 2008 20:58:36 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88590>

It's been a while since I sent one of these updates.

Catalin, you probably want to pull stable and safe, to get Miklos's
setup.py fixes (I backported them to stable, and then merged back to
the main branch). (The stable branch has a handful of fixes since
0.14.3; it might be time for 0.14.4?)


                                 -+-


The following changes since commit a6c4be12abcf0906a63de8a72c887c360f89=
ea82:
  Karl Hasselstr=F6m (1):
        Don't allow extra diff options with "stg status"

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git stable

Miklos Vajna (2):
      setup.py: don't try to import stgit.run before the python version=
 check
      setup.py: fix error message when running with python-2.3

 setup.py |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


                                 -+-


The following changes since commit 2e37b61d886ef21200007b57f496aaf182f4=
2705:
  Karl Hasselstr=F6m (1):
        Test for "stg edit"

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git safe

Karl Hasselstr=F6m (1):
      Merge branch 'stable'

Miklos Vajna (2):
      setup.py: don't try to import stgit.run before the python version=
 check
      setup.py: fix error message when running with python-2.3

 setup.py |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


                                 -+-


The following changes since commit d8461a9dfb9a34e582019de5a67798fad44f=
42c7:
  Karl Hasselstr=F6m (1):
        Merge branch 'stable'

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git experimental

Karl Hasselstr=F6m (21):
      Discard stderr output from git apply if the caller wants
      Do simple in-index merge with diff+apply instead of read-tree
      Reuse the same temp index in a transaction
      Library functions for tree and blob manipulation
      Write to a stack log when stack is modified
      Add utility function for reordering patches
      New command: stg reset
      Log conflicts separately
      Log conflicts separately for all commands
      Add a --hard flag to stg reset
      Don't write a log entry if there were no changes
      Move stack reset function to a shared location
      New command: stg undo
      New command: stg redo
      Log and undo external modifications
      Make "stg log" show stack log instead of patch log
      Convert "stg refresh" to the new infrastructure
      New refresh tests
      Remove --undo flags from stg commands and docs
      Refactor stgit.commands.edit
      Implement "stg refresh --edit" again

 Documentation/tutorial.txt   |    4 +-
 TODO                         |    2 -
 stgit/commands/branch.py     |   19 +-
 stgit/commands/clone.py      |    2 +-
 stgit/commands/coalesce.py   |    2 +-
 stgit/commands/common.py     |   18 +-
 stgit/commands/diff.py       |    6 +-
 stgit/commands/edit.py       |   82 +------
 stgit/commands/export.py     |    2 +-
 stgit/commands/files.py      |    6 +-
 stgit/commands/float.py      |    2 +-
 stgit/commands/fold.py       |    2 +-
 stgit/commands/goto.py       |    3 +-
 stgit/commands/hide.py       |    2 +-
 stgit/commands/id.py         |    2 +-
 stgit/commands/imprt.py      |    4 +-
 stgit/commands/log.py        |  169 ++++---------
 stgit/commands/mail.py       |    8 +-
 stgit/commands/new.py        |    3 +-
 stgit/commands/patches.py    |    2 +-
 stgit/commands/pick.py       |    2 +-
 stgit/commands/pop.py        |    4 +-
 stgit/commands/pull.py       |    2 +-
 stgit/commands/push.py       |   31 +--
 stgit/commands/rebase.py     |    4 +-
 stgit/commands/redo.py       |   52 ++++
 stgit/commands/refresh.py    |  338 +++++++++++++++++---------
 stgit/commands/rename.py     |    2 +-
 stgit/commands/repair.py     |   11 +-
 stgit/commands/reset.py      |   57 +++++
 stgit/commands/resolved.py   |    2 +-
 stgit/commands/show.py       |    2 +-
 stgit/commands/sink.py       |    2 +-
 stgit/commands/status.py     |    3 +-
 stgit/commands/sync.py       |   26 +--
 stgit/commands/undo.py       |   49 ++++
 stgit/commands/unhide.py     |    2 +-
 stgit/git.py                 |    4 -
 stgit/lib/edit.py            |   99 ++++++++
 stgit/lib/git.py             |  348 +++++++++++++++++++++++-----
 stgit/lib/log.py             |  537 ++++++++++++++++++++++++++++++++++=
++++++++
 stgit/lib/stack.py           |   25 ++
 stgit/lib/transaction.py     |  139 ++++++++---
 stgit/main.py                |    8 +
 stgit/stack.py               |   45 +----
 stgit/utils.py               |   18 +-
 t/t1200-push-modified.sh     |    2 +-
 t/t1201-pull-trailing.sh     |    2 +-
 t/t1202-push-undo.sh         |    8 +-
 t/t1400-patch-history.sh     |  103 --------
 t/t2300-refresh-subdir.sh    |   29 +++-
 t/t3100-reset.sh             |  151 ++++++++++++
 t/t3101-reset-hard.sh        |   56 +++++
 t/t3102-undo.sh              |   86 +++++++
 t/t3103-undo-hard.sh         |   56 +++++
 t/t3104-redo.sh              |  122 ++++++++++
 t/t3105-undo-external-mod.sh |   68 ++++++
 t/t3300-edit.sh              |    4 +-
 58 files changed, 2179 insertions(+), 660 deletions(-)
 create mode 100644 stgit/commands/redo.py
 create mode 100644 stgit/commands/reset.py
 create mode 100644 stgit/commands/undo.py
 create mode 100644 stgit/lib/edit.py
 create mode 100644 stgit/lib/log.py
 delete mode 100755 t/t1400-patch-history.sh
 create mode 100755 t/t3100-reset.sh
 create mode 100755 t/t3101-reset-hard.sh
 create mode 100755 t/t3102-undo.sh
 create mode 100755 t/t3103-undo-hard.sh
 create mode 100755 t/t3104-redo.sh
 create mode 100755 t/t3105-undo-external-mod.sh

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
