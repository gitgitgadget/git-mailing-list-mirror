From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] GIT-VERSION-GEN: don't convert - delimiter to .'s
Date: Sat, 30 Jun 2007 20:56:15 +1200
Message-ID: <11831937823982-git-send-email-sam.vilain@catalyst.net.nz>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 10:56:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4Yku-00065T-1e
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 10:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbXF3I41 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 04:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753809AbXF3I40
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 04:56:26 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:56649 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbXF3I4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 04:56:25 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1I4Ykg-0008U0-Cc; Sat, 30 Jun 2007 20:56:22 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 51A8E62CEA; Sat, 30 Jun 2007 20:56:22 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.1.1131.g3b90-dirty
In-Reply-To: <11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51199>

Otherwise, a custom "v1.5.2.42.gb1ff" is considered newer than a
"v1.5.2.1.69.gcafe"

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 GIT-VERSION-GEN |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 06c360b..ac6a062 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -18,7 +18,7 @@ elif test -d .git &&
 	v[0-9]*) : happy ;;
 	esac
 then
-	VN=$(echo "$VN" | sed -e 's/-/./g');
+	:;
 else
 	VN="$DEF_VER"
 fi
-- 
1.5.2.1.1131.g3b90
