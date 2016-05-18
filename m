From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] t6044: replace seq by test_seq
Date: Wed, 18 May 2016 07:51:39 +0200
Message-ID: <573C02EB.30801@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 07:51:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2uOa-00036K-Sg
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 07:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbcERFvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 01:51:44 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:38666 "EHLO bsmtp7.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbcERFvn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 01:51:43 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp7.bon.at (Postfix) with ESMTPSA id 3r8jxm4sWVz5tl9;
	Wed, 18 May 2016 07:51:40 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 1ED00528B;
	Wed, 18 May 2016 07:51:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294934>

seq is not available everywhere.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t6044-merge-unrelated-index-changes.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
index 20a3ffe..0102348 100755
--- a/t/t6044-merge-unrelated-index-changes.sh
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -20,7 +20,7 @@ test_description="merges with unrelated index changes"
 #   Commit E: renames a->subdir/a, adds subdir/e
 
 test_expect_success 'setup trivial merges' '
-	seq 1 10 >a &&
+	test_seq 1 10 >a &&
 	git add a &&
 	test_tick && git commit -m A &&
 
@@ -42,7 +42,7 @@ test_expect_success 'setup trivial merges' '
 	test_tick && git commit -m C &&
 
 	git checkout D &&
-	seq 2 10 >a &&
+	test_seq 2 10 >a &&
 	echo d >d &&
 	git add a d &&
 	test_tick && git commit -m D &&
-- 
2.7.0.118.g90056ae
