From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 6/9] rebase: don't try to match -M option
Date: Fri, 24 Jan 2014 00:51:03 +0000
Message-ID: <1390524666-51274-7-git-send-email-sandals@crustytoothpaste.net>
References: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 01:51:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6UzV-0001ez-1P
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 01:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799AbaAXAvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 19:51:22 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51338 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753720AbaAXAvV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jan 2014 19:51:21 -0500
Received: from vauxhall.elevennetworks.com (unknown [209.118.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3299C28083;
	Fri, 24 Jan 2014 00:51:20 +0000 (UTC)
X-Mailer: git-send-email 1.9.rc0.1002.gd081c64.dirty
In-Reply-To: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240983>

From: Nicolas Vigier <boklm@mars-attacks.org>

The -M option does not exist in OPTIONS_SPEC, so there is no use to try
to find it.

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index d1835ba..3b55211 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -267,7 +267,7 @@ do
 	--no-fork-point)
 		fork_point=
 		;;
-	-M|-m)
+	-m)
 		do_merge=t
 		;;
 	-X)
-- 
1.9.rc0.1002.gd081c64.dirty
