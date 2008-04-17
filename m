From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/5] Use hardcoded author and committer names in tests
Date: Thu, 17 Apr 2008 23:12:53 +0200
Message-ID: <20080417211253.12809.71209.stgit@yoghurt>
References: <20080417210137.12809.88457.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 23:27:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmbQK-000513-1D
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 23:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbYDQVM5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2008 17:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbYDQVM4
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 17:12:56 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4503 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbYDQVM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 17:12:56 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JmbPY-0003dP-00; Thu, 17 Apr 2008 22:12:52 +0100
In-Reply-To: <20080417210137.12809.88457.stgit@yoghurt>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79827>

There seems to be no reason for these to stay commented out -- in
fact, commit v0.12-4-g5cd9e87 which introduced these lines seems to
have left them commented out by mistake.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/test-lib.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2d12f1b..5e4c7a1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -20,11 +20,11 @@ unset COMMIT_AUTHOR_NAME
 unset EMAIL
 unset GIT_ALTERNATE_OBJECT_DIRECTORIES
 unset GIT_AUTHOR_DATE
-#GIT_AUTHOR_EMAIL=3Dauthor@example.com
-#GIT_AUTHOR_NAME=3D'A U Thor'
+GIT_AUTHOR_EMAIL=3Dauthor@example.com
+GIT_AUTHOR_NAME=3D'A U Thor'
 unset GIT_COMMITTER_DATE
-#GIT_COMMITTER_EMAIL=3Dcommitter@example.com
-#GIT_COMMITTER_NAME=3D'C O Mitter'
+GIT_COMMITTER_EMAIL=3Dcommitter@example.com
+GIT_COMMITTER_NAME=3D'C O Mitter'
 unset GIT_DIFF_OPTS
 unset GIT_DIR
 unset GIT_EXTERNAL_DIFF
