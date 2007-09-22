From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/4] Fix "stg branch --delete"
Date: Sat, 22 Sep 2007 10:46:13 +0200
Message-ID: <20070922084334.29884.60506.stgit@yoghurt>
References: <20070921094830.GB26307@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Aneesh Kumar <aneesh.kumar@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 10:46:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZ0dE-0005X2-0m
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 10:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbXIVIq0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Sep 2007 04:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbXIVIq0
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 04:46:26 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4103 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbXIVIqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 04:46:25 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IZ0cx-0001mc-00; Sat, 22 Sep 2007 09:46:15 +0100
In-Reply-To: <20070921094830.GB26307@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58922>

This fixes the two issues Aneesh reported (failed branch deletion,
leftover config stuff), and adds a test. The test is added after the
fixes this time, so the test suite passes at every step.

Also available from

  git://repo.or.cz/stgit/kha.git safe

---

Karl Hasselstr=C3=B6m (4):
      Add simple test for "stg branch --delete"
      Properly remove all config for a deleted branch
      Don't try to delete the branch twice
      Don't special-case the "master" branch during branch delete


 stgit/commands/branch.py |   10 +---------
 stgit/config.py          |    7 +++++++
 stgit/stack.py           |    9 ++-------
 t/t1005-branch-delete.sh |   29 +++++++++++++++++++++++++++++
 4 files changed, 39 insertions(+), 16 deletions(-)
 create mode 100755 t/t1005-branch-delete.sh

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
