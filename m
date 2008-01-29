From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/2] "stg clean" test+bugfix
Date: Tue, 29 Jan 2008 04:10:09 +0100
Message-ID: <20080129030752.1095.27968.stgit@yoghurt>
References: <20080129025821.GA1373@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 04:10:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgs1-0005Uv-N7
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 04:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbYA2DKN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2008 22:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752801AbYA2DKM
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 22:10:12 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1863 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781AbYA2DKL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 22:10:11 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JJgrP-0000b7-00; Tue, 29 Jan 2008 03:10:07 +0000
In-Reply-To: <20080129025821.GA1373@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71934>

This is the test by Pavel, followed by a fix by me.

They're in kha/safe, since they should be low-risk, and because losing
a conflicting patch (even though you still have all the changes in
your worktree) is unpleasant.

---

Karl Hasselstr=C3=B6m (1):
      Don't clean away patches with conflicts

Pavel Roskin (1):
      Add test to ensure that "stg clean" preserves conflicting patches


 stgit/commands/clean.py |    7 +++++++
 stgit/lib/git.py        |    8 ++++++++
 t/t2500-clean.sh        |   17 +++++++++++++++++
 3 files changed, 32 insertions(+), 0 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
