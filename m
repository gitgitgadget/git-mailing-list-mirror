From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/5] Disable patchlog test for "stg new"
Date: Sun, 10 Feb 2008 21:43:26 +0100
Message-ID: <20080210204102.17683.632.stgit@yoghurt>
References: <20080210203846.17683.43153.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 21:44:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOJ2K-000560-04
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 21:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbYBJUna convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 15:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755403AbYBJUna
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 15:43:30 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4226 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366AbYBJUn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 15:43:29 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JOJ1J-0005Ca-00; Sun, 10 Feb 2008 20:43:25 +0000
In-Reply-To: <20080210203846.17683.43153.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73405>

This will be broken by the "stg new" rewrite, so stop testing it.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

I'm doing this rather than fixing the log since I hope to actually
create "stg undo" pretty soon, and that'll involve a new internal log
format. But I won't graduate this to kha/safe until it's resolved
either way.

 t/t1400-patch-history.sh |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)


diff --git a/t/t1400-patch-history.sh b/t/t1400-patch-history.sh
index 879b1a5..a693e75 100755
--- a/t/t1400-patch-history.sh
+++ b/t/t1400-patch-history.sh
@@ -35,9 +35,7 @@ test_expect_success \
 test_expect_success \
 	'Check the "new" and "refresh" logs' \
 	'
-	stg log --full foo | grep -q -e "^new" &&
 	stg log --full foo | grep -q -e "^refresh" &&
-	stg log --full | grep -q -e "^new" &&
 	stg log --full | grep -q -e "^refresh"
 	'
=20
