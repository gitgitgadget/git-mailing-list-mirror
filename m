From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] push mirroring update test titles
Date: Mon, 12 Nov 2007 15:48:02 +0000
Message-ID: <20071112154802.GK301@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 16:48:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrbWP-0003UA-2g
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 16:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbXKLPrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 10:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753406AbXKLPrv
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 10:47:51 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:4561 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbXKLPru (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 10:47:50 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1IrbVt-0006sH-AN; Mon, 12 Nov 2007 15:47:49 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64643>

Fix up the test titles which are incorrectly in the negative.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
	This probabally should be folded down into the
	current tests patch.  If you want me to do that
	and resubmit, yell at me.

 t/t5517-push-mirror.sh |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index 0fc6778..ed3fec1 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -31,7 +31,7 @@ mk_repo_pair () {
 
 
 # BRANCH tests
-test_expect_success 'push mirror does not create new branches' '
+test_expect_success 'push mirror creates new branches' '
 
 	mk_repo_pair &&
 	(
@@ -45,7 +45,7 @@ test_expect_success 'push mirror does not create new branches' '
 
 '
 
-test_expect_success 'push mirror does not update existing branches' '
+test_expect_success 'push mirror updates existing branches' '
 
 	mk_repo_pair &&
 	(
@@ -61,7 +61,7 @@ test_expect_success 'push mirror does not update existing branches' '
 
 '
 
-test_expect_success 'push mirror does not force update existing branches' '
+test_expect_success 'push mirror force updates existing branches' '
 
 	mk_repo_pair &&
 	(
@@ -79,7 +79,7 @@ test_expect_success 'push mirror does not force update existing branches' '
 
 '
 
-test_expect_success 'push mirror does not remove branches' '
+test_expect_success 'push mirror removes branches' '
 
 	mk_repo_pair &&
 	(
@@ -97,7 +97,7 @@ test_expect_success 'push mirror does not remove branches' '
 
 '
 
-test_expect_success 'push mirror does not add, update and remove branches together' '
+test_expect_success 'push mirror adds, updates and removes branches together' '
 
 	mk_repo_pair &&
 	(
@@ -125,7 +125,7 @@ test_expect_success 'push mirror does not add, update and remove branches togeth
 
 
 # TAG tests
-test_expect_success 'push mirror does not create new tags' '
+test_expect_success 'push mirror creates new tags' '
 
 	mk_repo_pair &&
 	(
@@ -140,7 +140,7 @@ test_expect_success 'push mirror does not create new tags' '
 
 '
 
-test_expect_success 'push mirror does not update existing tags' '
+test_expect_success 'push mirror updates existing tags' '
 
 	mk_repo_pair &&
 	(
@@ -158,7 +158,7 @@ test_expect_success 'push mirror does not update existing tags' '
 
 '
 
-test_expect_success 'push mirror does not force update existing tags' '
+test_expect_success 'push mirror force updates existing tags' '
 
 	mk_repo_pair &&
 	(
@@ -179,7 +179,7 @@ test_expect_success 'push mirror does not force update existing tags' '
 
 '
 
-test_expect_success 'push mirror does not remove tags' '
+test_expect_success 'push mirror removes tags' '
 
 	mk_repo_pair &&
 	(
@@ -197,7 +197,7 @@ test_expect_success 'push mirror does not remove tags' '
 
 '
 
-test_expect_success 'push mirror does not add, update and remove tags together' '
+test_expect_success 'push mirror adds, updates and removes tags together' '
 
 	mk_repo_pair &&
 	(
