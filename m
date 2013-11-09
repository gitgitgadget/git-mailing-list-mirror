From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 53/86] builtin/describe: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:46 +0100
Message-ID: <20131109070720.18178.41233.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:09:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2g4-0003eY-Ky
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933322Ab3KIHJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:09:39 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36412 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933259Ab3KIHIn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:43 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id F32413A;
	Sat,  9 Nov 2013 08:08:41 +0100 (CET)
X-git-sha1: 320d8f5ace6cc63980d7541c80f9413287c220e1 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237505>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/describe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index b9d3603..102d958 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -141,7 +141,7 @@ static void add_to_known_names(const char *path,
 
 static int get_name(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
-	int is_tag = !prefixcmp(path, "refs/tags/");
+	int is_tag = has_prefix(path, "refs/tags/");
 	unsigned char peeled[20];
 	int is_annotated, prio;
 
-- 
1.8.4.1.566.geca833c
