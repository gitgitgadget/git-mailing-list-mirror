From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH] t/t7502-commit.sh : remove a repeated test
Date: Thu, 10 Mar 2016 22:51:33 +0000
Message-ID: <0102015362ba5bb6-8212f758-f2fa-4272-8337-1cc669e7e8f4-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 00:05:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae9e8-00060J-I4
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 00:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932864AbcCJXF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 18:05:28 -0500
Received: from a6-245.smtp-out.eu-west-1.amazonses.com ([54.240.6.245]:35197
	"EHLO a6-245.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932465AbcCJXF1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2016 18:05:27 -0500
X-Greylist: delayed 831 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Mar 2016 18:05:26 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1457650293;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=3uD3We4Jf5jbYabLMgC2J/F8dZnyxgdynqLsqsEjRmU=;
	b=Ju8tym25cWe0SuEMV7H/LlPgRBMog3JRJpTYTRnizNx6jxviofLiIrb0pSzOOv+V
	Kxd8nZ02MBod+6PgrhFCZ24PpVzhkoNajxROdGFxjSmGacaEqfwBqu4i/pOXELQjP/1
	BOHZpB3P6mHpN/kuLv5NGzNiqFqQOqcyM9bbyVas=
X-SES-Outgoing: 2016.03.10-54.240.6.245
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288662>

This extra test was introducted in the commit f9c01817

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t7502-commit.sh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index b39e313..725687d 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -527,11 +527,6 @@ try_commit_status_combo () {
 		test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
-	test_expect_success 'commit' '
-		try_commit "" &&
-		test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG
-	'
-
 	test_expect_success 'commit --status' '
 		try_commit --status &&
 		test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG

--
https://github.com/git/git/pull/207
