From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 05/10] git p4 test: rename some "git-p4 command" strings
Date: Wed, 27 Jun 2012 08:00:58 -0400
Message-ID: <1340798463-14499-6-git-send-email-pw@padd.com>
References: <1340798463-14499-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 14:02:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjqxQ-00051n-1J
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 14:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756628Ab2F0MCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 08:02:48 -0400
Received: from honk.padd.com ([74.3.171.149]:52780 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756602Ab2F0MCr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 08:02:47 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 5B1CF70BC;
	Wed, 27 Jun 2012 05:02:46 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 109B631383; Wed, 27 Jun 2012 08:02:43 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.130.gb957a79
In-Reply-To: <1340798463-14499-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200718>

Use the actual command name; git-p4 is gone.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9810-git-p4-rcs.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index c7313b0..d8bb3d0 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git-p4 rcs keywords'
+test_description='git p4 rcs keywords'
 
 . ./lib-git-p4.sh
 
@@ -147,7 +147,7 @@ test_expect_success 'scrub ko files differently' '
 	)
 '
 
-# hack; git-p4 submit should do it on its own
+# hack; git p4 submit should do it on its own
 test_expect_success 'cleanup after failure' '
 	(
 		cd "$cli" &&
@@ -193,7 +193,7 @@ test_expect_success 'do not scrub plain text' '
 	)
 '
 
-# hack; git-p4 submit should do it on its own
+# hack; git p4 submit should do it on its own
 test_expect_success 'cleanup after failure 2' '
 	(
 		cd "$cli" &&
-- 
1.7.11.1.69.gd505fd2
