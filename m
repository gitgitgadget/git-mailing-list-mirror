From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 05/11] git p4 test: is_cli_file_writeable succeeds
Date: Tue, 21 Jan 2014 18:16:42 -0500
Message-ID: <1390346208-9207-6-git-send-email-pw@padd.com>
References: <1390346208-9207-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 00:18:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5kaZ-0001qD-GI
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 00:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbaAUXSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 18:18:32 -0500
Received: from honk.padd.com ([74.3.171.149]:46544 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753373AbaAUXSb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 18:18:31 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 232D87112;
	Tue, 21 Jan 2014 15:18:31 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 9A22C200F7; Tue, 21 Jan 2014 18:18:28 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2.364.g6ac45cd
In-Reply-To: <1390346208-9207-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240795>

Commit e9df0f9 (git p4: cygwin p4 client does not mark read-only,
2013-01-26) fixed a problem with "test -w" on cygwin, but mistakenly
marked the new test as failing.  Fix this.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9807-git-p4-submit.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 1fb7bc7..4caf36e 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -17,7 +17,7 @@ test_expect_success 'init depot' '
 	)
 '
 
-test_expect_failure 'is_cli_file_writeable function' '
+test_expect_success 'is_cli_file_writeable function' '
 	(
 		cd "$cli" &&
 		echo a >a &&
-- 
1.8.5.2.320.g99957e5
