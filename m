From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 51/86] builtin/column: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:44 +0100
Message-ID: <20131109070720.18178.99199.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:09:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2fw-0003XL-9G
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933324Ab3KIHJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:09:40 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54160 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933289Ab3KIHIn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:43 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 2368E6D;
	Sat,  9 Nov 2013 08:08:41 +0100 (CET)
X-git-sha1: 3846063273f9ee4818396d53c76cbec6740950a5 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237502>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/column.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/column.c b/builtin/column.c
index e125a55..3664cc1 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -34,7 +34,7 @@ int cmd_column(int argc, const char **argv, const char *prefix)
 	};
 
 	/* This one is special and must be the first one */
-	if (argc > 1 && !prefixcmp(argv[1], "--command=")) {
+	if (argc > 1 && has_prefix(argv[1], "--command=")) {
 		command = argv[1] + 10;
 		git_config(column_config, (void *)command);
 	} else
-- 
1.8.4.1.566.geca833c
