From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 36/86] attr: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:29 +0100
Message-ID: <20131109070720.18178.76499.chriscool@tuxfamily.org>
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
	id 1Vf2gr-0004XO-6I
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933351Ab3KIHK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:10:29 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:65445 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933271Ab3KIHIf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:35 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id CA702A8;
	Sat,  9 Nov 2013 08:08:34 +0100 (CET)
X-git-sha1: 395493e821f6bd064c5a566a29920e3fe39c87a8 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237518>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 0e774c6..4c11f30 100644
--- a/attr.c
+++ b/attr.c
@@ -211,7 +211,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 	name = cp;
 	namelen = strcspn(name, blank);
 	if (strlen(ATTRIBUTE_MACRO_PREFIX) < namelen &&
-	    !prefixcmp(name, ATTRIBUTE_MACRO_PREFIX)) {
+	    has_prefix(name, ATTRIBUTE_MACRO_PREFIX)) {
 		if (!macro_ok) {
 			fprintf(stderr, "%s not allowed: %s:%d\n",
 				name, src, lineno);
-- 
1.8.4.1.566.geca833c
