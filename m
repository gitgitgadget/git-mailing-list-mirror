From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: StGit kha safe branch updated
Date: Mon, 24 Sep 2007 02:02:44 +0200
Message-ID: <20070924000244.GA24403@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 02:02:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZbPb-0008Hi-Ta
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 02:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459AbXIXACu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2007 20:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755446AbXIXACu
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 20:02:50 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2395 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389AbXIXACt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 20:02:49 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IZbPQ-0006MX-00; Mon, 24 Sep 2007 01:02:44 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59007>

These are the first ten patches of David's latest series (including
the fixup he suggested) -- that is, only the cleanup part -- plus the
three patches I just mailed out.

The following changes since commit ead8e89297dfabf7c290338a86c89f19c5ba=
7401:
  Catalin Marinas (1):
        Print 'updating patch' earlier in 'edit'

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git safe

David K=E5gedal (10):
      Add some more tests of "stg status" output
      Clear up semantics of tree_status
      Moved that status function to the status command file
      Split Series.push_patch in two
      Remove dead code from push_empty_patch
      Refactor Series.push_patch
      Clean up Series.refresh_patch
      Add a 'bottom' parameter to Series.refresh_patch and use it
      Clear up the semantics of Series.new_patch
      Refactor Series.new_patch

Karl Hasselstr=F6m (3):
      New test: make sure tha we can run "stg help"
      Make sure that the output of "stg status" is sorted
      New policy: Only use test_expect_failure for broken tests

 stgit/commands/common.py      |    2 +-
 stgit/commands/status.py      |   45 +++++++++++-
 stgit/commands/uncommit.py    |    1 +
 stgit/git.py                  |   61 ++++------------
 stgit/stack.py                |  155 ++++++++++++++++++++++-----------=
-------
 t/README                      |    9 +--
 t/t0001-subdir-branches.sh    |    9 ++-
 t/t0002-status.sh             |   36 ++++++++++
 t/t0100-help.sh               |   15 ++++
 t/t1000-branch-create.sh      |    8 +-
 t/t1001-branch-rename.sh      |    4 +-
 t/t1002-branch-clone.sh       |    4 +-
 t/t1200-push-modified.sh      |    4 +-
 t/t1202-push-undo.sh          |    4 +-
 t/t2000-sync.sh               |    8 +-
 t/t2100-pull-policy-fetch.sh  |    4 +-
 t/t2102-pull-policy-rebase.sh |   12 ++--
 t/t2200-rebase.sh             |    4 +-
 18 files changed, 230 insertions(+), 155 deletions(-)
 create mode 100755 t/t0100-help.sh

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
