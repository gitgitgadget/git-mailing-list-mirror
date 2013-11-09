From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 39/86] convert: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:32 +0100
Message-ID: <20131109070720.18178.716.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:10:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2gq-0004XO-BL
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933350Ab3KIHK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:10:27 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36371 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933272Ab3KIHIh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:37 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 1471761;
	Sat,  9 Nov 2013 08:08:36 +0100 (CET)
X-git-sha1: bf93ec18bce009477c1acd2c33e45fba33807b9e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237519>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 convert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index 11a95fc..dc5d3ed 100644
--- a/convert.c
+++ b/convert.c
@@ -1121,7 +1121,7 @@ static int is_foreign_ident(const char *str)
 {
 	int i;
 
-	if (prefixcmp(str, "$Id: "))
+	if (!has_prefix(str, "$Id: "))
 		return 0;
 	for (i = 5; str[i]; i++) {
 		if (isspace(str[i]) && str[i+1] != '$')
-- 
1.8.4.1.566.geca833c
