From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: kha/safe updated
Date: Wed, 19 Dec 2007 23:46:38 +0100
Message-ID: <20071219224638.GB15119@diana.vm.bytemark.co.uk>
References: <20071219221848.29455.50676.stgit@yoghurt> <20071219221957.29455.27315.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 23:47:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J57gz-0004zt-Ih
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 23:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbXLSWqo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 17:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752891AbXLSWqo
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 17:46:44 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4449 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbXLSWqo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 17:46:44 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J57gU-00044B-00; Wed, 19 Dec 2007 22:46:38 +0000
Content-Disposition: inline
In-Reply-To: <20071219221957.29455.27315.stgit@yoghurt>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68950>

On 2007-12-19 23:24:49 +0100, Karl Hasselstr=F6m wrote:

> And here it is!

And with that, I don't see any reason to not recommend that you pull
every patch I have. Which is:

The following changes since commit 5be69cd8d89bd89be31364e9c0fd9e947b6e=
f644:
  Karl Hasselstr=F6m (1):
        Name the exit codes to improve legibility

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git safe

David K=E5gedal (19):
      Add an StGit mode for emacs
      Emacs mode: Improve the output buffer state
      Emacs mode: Bind n and p
      Emacs mode: add stgit-repair
      Emacs mode: added stgit-commit and stgit-uncommit
      Emacs mode: Add stgit-edit command
      Emacs mode: added fontification
      Emacs mode: Added stgit-new
      Check bottom and invariants
      Remove the 'bottom' field
      Remove the 'top' field
      Split git.merge into two functions
      Leave working dir and index alone after failed (conflicting) push
      Added a test case to check what happens when push finds a conflic=
t
      Simplify merge_recursive
      Use the output from merge-recursive to list conflicts
      Ask git about unmerged files
      Emacs mode: Add mark command
      Emacs mode: coalesce command

Karl Hasselstr=F6m (36):
      Emacs mode: Show keybindings when user presses "h" or "?"
      Emacs mode: Add an explanatory header
      Emacs mode: Makefile for building stgit.el
      Emacs mode: push/pop next patch, not patch at point
      Emacs mode: Let "P" push or pop patch at point
      Emacs mode: Bind "G" to "stg goto"
      Emacs mode: show patches' short description
      Write removed fields for backwards compatibility
      Nicer conflict markers
      Better error message if merge fails
      Fix "stg resolved" to work with new conflict representation
      Refactoring: pass more than one file to resolved()
      We keep the different stages of a conflict in the index now
      "stg status --reset" is not needed anymore
      Remove "stg add"
      Remove "stg rm"
      Remove "stg cp"
      Remove "stg resolved"
      New StGit core infrastructure: repository operations
      Write metadata files used by the old infrastructure
      Upgrade older stacks to newest version
      Let "stg clean" use the new infrastructure
      Add "stg coalesce"
      Let "stg applied" and "stg unapplied" use the new infrastructure
      Teach the new infrastructure about the index and worktree
      Let "stg clean" use the new transaction primitives
      Let "stg goto" use the new infrastructure
      Convert "stg uncommit" to the new infrastructure
      New infrastructure: Make sure that the branch is initialized
      Expose transaction abort function
      stg coalesce: Support --file and --save-template
      Set exit code to 3 on merge conflict
      Convert "stg commit" to new infrastructure
      Make "stg commit" fancier
      Test that "stg goto" can be called from a subdirectory
      Make "stg goto" subdirectory safe

 Documentation/stg-cp.txt      |   63 -------
 Documentation/stg.txt         |    2 -
 Documentation/tutorial.txt    |   31 ++--
 contrib/Makefile              |   19 ++
 contrib/stgit-completion.bash |    4 +-
 contrib/stgit.el              |  377 +++++++++++++++++++++++++++++++++=
++++++
 examples/gitconfig            |   19 +--
 setup.py                      |    2 +-
 stgit/commands/add.py         |   44 -----
 stgit/commands/applied.py     |   27 ++--
 stgit/commands/clean.py       |   49 ++----
 stgit/commands/coalesce.py    |  122 +++++++++++++
 stgit/commands/commit.py      |  111 ++++++++-----
 stgit/commands/common.py      |   39 ++---
 stgit/commands/copy.py        |   45 -----
 stgit/commands/goto.py        |   52 ++----
 stgit/commands/pick.py        |    2 +-
 stgit/commands/resolved.py    |   94 ----------
 stgit/commands/rm.py          |   48 -----
 stgit/commands/status.py      |   31 ++--
 stgit/commands/sync.py        |    1 -
 stgit/commands/unapplied.py   |   23 ++--
 stgit/commands/uncommit.py    |   81 ++++-----
 stgit/config.py               |    1 -
 stgit/git.py                  |   75 +++++---
 stgit/gitmergeonefile.py      |   97 +----------
 stgit/lib/__init__.py         |   18 ++
 stgit/lib/git.py              |  388 +++++++++++++++++++++++++++++++++=
++++++++
 stgit/lib/stack.py            |  176 +++++++++++++++++++
 stgit/lib/stackupgrade.py     |   98 +++++++++++
 stgit/lib/transaction.py      |  209 ++++++++++++++++++++++
 stgit/main.py                 |   14 +-
 stgit/run.py                  |   12 +-
 stgit/stack.py                |  156 ++++-------------
 stgit/utils.py                |   25 +++
 t/t0002-status.sh             |   15 +-
 t/t1200-push-modified.sh      |    2 +-
 t/t1202-push-undo.sh          |    6 +-
 t/t1203-push-conflict.sh      |   70 ++++++++
 t/t1204-pop-keep.sh           |    2 +-
 t/t1205-push-subdir.sh        |    8 +-
 t/t1300-uncommit.sh           |   16 +-
 t/t1301-repair.sh             |    2 +-
 t/t1400-patch-history.sh      |    4 +-
 t/t1500-float.sh              |   14 +-
 t/t1600-delete-one.sh         |   12 +-
 t/t1601-delete-many.sh        |    2 +-
 t/t1700-goto-top.sh           |    2 +-
 t/t2000-sync.sh               |   12 +-
 t/t2100-pull-policy-fetch.sh  |    4 +-
 t/t2101-pull-policy-pull.sh   |    4 +-
 t/t2102-pull-policy-rebase.sh |    4 +-
 t/t2300-refresh-subdir.sh     |    2 +-
 t/t2600-coalesce.sh           |   31 ++++
 t/t2800-goto-subdir.sh        |   59 ++++++
 55 files changed, 1959 insertions(+), 867 deletions(-)
 delete mode 100644 Documentation/stg-cp.txt
 create mode 100644 contrib/Makefile
 create mode 100644 contrib/stgit.el
 delete mode 100644 stgit/commands/add.py
 create mode 100644 stgit/commands/coalesce.py
 delete mode 100644 stgit/commands/copy.py
 delete mode 100644 stgit/commands/resolved.py
 delete mode 100644 stgit/commands/rm.py
 create mode 100644 stgit/lib/__init__.py
 create mode 100644 stgit/lib/git.py
 create mode 100644 stgit/lib/stack.py
 create mode 100644 stgit/lib/stackupgrade.py
 create mode 100644 stgit/lib/transaction.py
 create mode 100755 t/t1203-push-conflict.sh
 create mode 100755 t/t2600-coalesce.sh
 create mode 100755 t/t2800-goto-subdir.sh

kha/experimental points to the same commit as kha/safe, for now.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
