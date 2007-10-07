From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/8] Miscellaneous fixes and improvements
Date: Mon, 08 Oct 2007 01:17:12 +0200
Message-ID: <20071007231446.12626.14259.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:17:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefNJ-0003IS-Dg
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406AbXJGXRT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 19:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755076AbXJGXRT
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:17:19 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1355 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753AbXJGXRS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:17:18 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IefN3-0000KS-00; Mon, 08 Oct 2007 00:17:13 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60240>

Also available from

  git://repo.or.cz/stgit/kha.git safe

---

Karl Hasselstr=C3=B6m (8):
      Remove the --force flag to "stg rebase" and "stg pull"
      Discard stderr output from git-rev-parse
      Simplify debug level error checking
      Make a common superclass for all StGit exceptions
      Don't split long and short description in "stg edit"
      Fix up the help text for "stg edit"
      New test: "stg pop --keep"
      Add --ack/--sign options to "stg new"


 stgit/commands/common.py      |   14 ++++----------
 stgit/commands/edit.py        |   33 +++++++++++++++-----------------
 stgit/commands/new.py         |    6 ++++--
 stgit/commands/pull.py        |    5 +----
 stgit/commands/rebase.py      |    5 +----
 stgit/config.py               |    3 ++-
 stgit/exception.py            |    3 +++
 stgit/git.py                  |    6 ++++--
 stgit/gitmergeonefile.py      |    3 ++-
 stgit/main.py                 |   15 ++++-----------
 stgit/run.py                  |    5 +++--
 stgit/stack.py                |   14 +++++++++-----
 stgit/utils.py                |    3 ++-
 t/t1204-pop-keep.sh           |   42 +++++++++++++++++++++++++++++++++=
++++++++
 t/t2100-pull-policy-fetch.sh  |   14 --------------
 t/t2102-pull-policy-rebase.sh |   24 -----------------------
 16 files changed, 96 insertions(+), 99 deletions(-)
 create mode 100644 stgit/exception.py
 create mode 100755 t/t1204-pop-keep.sh

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
