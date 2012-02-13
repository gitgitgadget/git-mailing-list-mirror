From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 4/5] t5541: use configured port number
Date: Mon, 13 Feb 2012 21:17:14 +0100
Message-ID: <1329164235-29955-5-git-send-email-drizzd@aon.at>
References: <7vhazobto3.fsf@alter.siamese.dyndns.org>
 <1329164235-29955-1-git-send-email-drizzd@aon.at>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 21:26:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx2TD-0002HE-Ih
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 21:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758041Ab2BMUZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 15:25:52 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:6922 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757971Ab2BMUZs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 15:25:48 -0500
Received: from localhost (p5B22E0DA.dip.t-dialin.net [91.34.224.218])
	by bsmtp.bon.at (Postfix) with ESMTP id 0373AA7EBB;
	Mon, 13 Feb 2012 21:26:25 +0100 (CET)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1329164235-29955-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190659>


Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/t5541-http-push.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index d66ed24..cc6f081 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -106,7 +106,7 @@ cat >exp <<EOF
 remote: error: hook declined to update refs/heads/dev2
 To http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git
  ! [remote rejected] dev2 -> dev2 (hook declined)
-error: failed to push some refs to 'http://127.0.0.1:5541/smart/test_repo.git'
+error: failed to push some refs to 'http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git'
 EOF
 
 test_expect_success 'rejected update prints status' '
-- 
1.7.9
