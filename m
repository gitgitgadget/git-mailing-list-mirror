From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v5 6/9] rebase: don't try to match -M option
Date: Fri, 14 Feb 2014 19:51:50 +0000
Message-ID: <1392407513-37443-7-git-send-email-sandals@crustytoothpaste.net>
References: <1392407513-37443-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 14 20:52:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEOoI-0002zD-Hz
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 20:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbaBNTwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 14:52:21 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51933 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752807AbaBNTwB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Feb 2014 14:52:01 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A4F1628087;
	Fri, 14 Feb 2014 19:51:59 +0000 (UTC)
X-Mailer: git-send-email 1.9.0.rc3.1008.gd08b47c.dirty
In-Reply-To: <1392407513-37443-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242135>

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
1.9.0.rc3.1008.gd08b47c.dirty
