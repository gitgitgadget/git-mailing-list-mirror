From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/3] Set a couple more tags in the original repository.
Date: Fri,  4 Dec 2009 15:36:29 +0100
Message-ID: <5482fe5eb1141d925dd4df20cc00416e09813ff7.1259934977.git.mhagger@alum.mit.edu>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 15:37:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGZHo-00060u-SW
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 15:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836AbZLDOhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 09:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbZLDOhU
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 09:37:20 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:45780 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbZLDOhU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 09:37:20 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (ssh.berlin.jpk.com [212.222.128.135])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id nB4EafCf020736;
	Fri, 4 Dec 2009 15:36:56 +0100
X-Mailer: git-send-email 1.6.5.4
In-Reply-To: <cover.1259934977.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1259934977.git.mhagger@alum.mit.edu>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134513>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t3404-rebase-interactive.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 073674f..236d698 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -23,7 +23,7 @@ set_fake_editor
 #         I             (branch2)
 #
 # where B, D and G touch the same file.  In addition, set tags at
-# points A, F, and I.
+# points A, E, F, H, and I.
 
 test_expect_success 'setup' '
 	: > file1 &&
@@ -45,6 +45,7 @@ test_expect_success 'setup' '
 	git add file3 &&
 	test_tick &&
 	git commit -m E &&
+	git tag E &&
 	git checkout -b branch1 A &&
 	: > file4 &&
 	git add file4 &&
@@ -58,6 +59,7 @@ test_expect_success 'setup' '
 	git add file5 &&
 	test_tick &&
 	git commit -m H &&
+	git tag H &&
 	git checkout -b branch2 F &&
 	: > file6 &&
 	git add file6 &&
-- 
1.6.5.4
