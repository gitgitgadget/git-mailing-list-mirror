From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/5] test suite update
Date: Thu, 17 Apr 2008 23:12:40 +0200
Message-ID: <20080417210137.12809.88457.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 23:34:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmbQJ-000513-Cc
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 23:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbYDQVMy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2008 17:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbYDQVMy
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 17:12:54 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4500 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbYDQVMx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 17:12:53 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JmbPM-0003d5-00; Thu, 17 Apr 2008 22:12:40 +0100
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79833>

This patch series pulls in updates to test-lib.sh from git (we now get
colored output!), and does some other assorted test suite updates.

---

Karl Hasselstr=C3=B6m (5):
      Use test_cmp instead of diff -u in the test suite
      Get rid of backticks in test-lib.sh
      Steal more test-lib.sh updates from git
      Use hardcoded author and committer names in tests
      If a patch is not changed when pushing, reuse the same commit obj=
ect


 stgit/lib/transaction.py |   11 ++-
 t/t0002-status.sh        |   32 ++++----
 t/t1201-pull-trailing.sh |    2=20
 t/t2700-refresh.sh       |   12 +--
 t/t2800-goto-subdir.sh   |    8 +-
 t/test-lib.sh            |  189 +++++++++++++++++++++++++++++++++++---=
--------
 6 files changed, 179 insertions(+), 75 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
