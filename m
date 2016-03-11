From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v2] t/t7502 : drop duplicate test
Date: Fri, 11 Mar 2016 00:49:58 +0000
Message-ID: <010201536326c56b-cd751f0b-f03f-4c9f-b834-20cee14b6eb5-000000@eu-west-1.amazonses.com>
References: <0102015362963f6a-626ad27e-e705-4a75-93a6-55a5f75d0226-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 02:07:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeBXe-0003fV-RW
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 02:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933011AbcCKBGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 20:06:52 -0500
Received: from a6-243.smtp-out.eu-west-1.amazonses.com ([54.240.6.243]:39884
	"EHLO a6-243.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932892AbcCKBGv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2016 20:06:51 -0500
X-Greylist: delayed 1011 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Mar 2016 20:06:51 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1457657398;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=NqgMN+jEVz6JBZpS/NJaaw+5auLvjdsQzYFZMShsmTQ=;
	b=Qq48sYNGvB8xOOTFFPfZi9DSi2kHWZbcOqidb4AtHiiSJsxfw8tFfV2y9sbTuQOS
	Ftcbv9xGTVA2lgIoU4o8pcQ6UPeUnvg4x7pq3ooazcD6n37XKbt1Sz2UYmFxX3/co7o
	3UmrUX2gVFCy/61Qr+DFt1VJYgkQ9i11BUZVfEQo=
In-Reply-To: <0102015362963f6a-626ad27e-e705-4a75-93a6-55a5f75d0226-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.03.11-54.240.6.243
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288668>

This extra test was introduced erroneously by
f9c0181 (t7502: test commit.status, --status and
--no-status, 2010-01-13)

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
https://github.com/git/git/pull/208
