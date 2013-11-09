From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 44/86] test-string-list: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:37 +0100
Message-ID: <20131109070720.18178.89929.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:10:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2gQ-00044O-LC
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933333Ab3KIHKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:10:02 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54204 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933255Ab3KIHIj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:39 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 2A2E1A1;
	Sat,  9 Nov 2013 08:08:38 +0100 (CET)
X-git-sha1: 213ac399874e00dcd690a6268de70db2e1071268 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237511>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 test-string-list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test-string-list.c b/test-string-list.c
index 00ce6c9..e04a37c 100644
--- a/test-string-list.c
+++ b/test-string-list.c
@@ -38,7 +38,7 @@ static void write_list_compact(const struct string_list *list)
 static int prefix_cb(struct string_list_item *item, void *cb_data)
 {
 	const char *prefix = (const char *)cb_data;
-	return !prefixcmp(item->string, prefix);
+	return has_prefix(item->string, prefix);
 }
 
 int main(int argc, char **argv)
-- 
1.8.4.1.566.geca833c
