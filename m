From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/5] Various cleanups
Date: Tue, 29 Jan 2008 04:02:25 +0100
Message-ID: <20080129030059.926.29897.stgit@yoghurt>
References: <20080129025821.GA1373@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 04:03:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgkb-0003yk-8G
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 04:03:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbYA2DCe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2008 22:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753678AbYA2DCe
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 22:02:34 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1913 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbYA2DCe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 22:02:34 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JJgjw-0000W8-00; Tue, 29 Jan 2008 03:02:25 +0000
In-Reply-To: <20080129025821.GA1373@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71926>

Some of these are very tiny, others are a bit bigger. They're all in
kha/safe, since they should be perfectly safe.

---

Karl Hasselstr=C3=B6m (5):
      Let the caller supply the diff text to diffstat()
      Simplify editor selection logic
      Eliminate temp variable that's used just once
      Wrap excessively long line
      Create index and worktree objects just once


 stgit/commands/coalesce.py |    2 +-
 stgit/commands/commit.py   |    2 +-
 stgit/commands/common.py   |    3 ++-
 stgit/commands/diff.py     |    9 ++++-----
 stgit/commands/edit.py     |    2 +-
 stgit/commands/export.py   |   10 +++++-----
 stgit/commands/files.py    |    2 +-
 stgit/commands/goto.py     |    2 +-
 stgit/commands/mail.py     |   16 +++++++---------
 stgit/git.py               |    9 +++------
 stgit/lib/git.py           |   34 ++++++++++++++++++++++++----------
 stgit/lib/transaction.py   |    3 +--
 stgit/utils.py             |    8 ++------
 13 files changed, 53 insertions(+), 49 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
