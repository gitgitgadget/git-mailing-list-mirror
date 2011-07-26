From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/19] git-check-attr: Add missing "&&"
Date: Tue, 26 Jul 2011 16:12:48 +0200
Message-ID: <1311689582-3116-6-git-send-email-mhagger@alum.mit.edu>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 16:30:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qliev-0004gd-7Z
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 16:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355Ab1GZOaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 10:30:55 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40168 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab1GZOax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 10:30:53 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QliM6-0004aQ-KN; Tue, 26 Jul 2011 16:11:30 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177870>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t0003-attributes.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 8c76b79..dae76b3 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -35,7 +35,7 @@ test_expect_success 'setup' '
 		echo "h test=a/b/h" &&
 		echo "d/* test=a/b/d/*"
 		echo "d/yes notest"
-	) >a/b/.gitattributes
+	) >a/b/.gitattributes &&
 	(
 		echo "global test=global"
 	) >"$HOME"/global-gitattributes
-- 
1.7.6.8.gd2879
