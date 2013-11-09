From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 83/86] builtin/unpack-objects: replace prefixcmd() with
 has_prefix()
Date: Sat, 09 Nov 2013 08:07:16 +0100
Message-ID: <20131109070720.18178.51088.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:15:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2l2-00014x-WC
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933478Ab3KIHOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:14:54 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:37748 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933465Ab3KIHO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:26 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id D1E9037;
	Sat,  9 Nov 2013 08:14:23 +0100 (CET)
X-git-sha1: 5918b763720f4da4225f5c37039b85adce35dd03 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237549>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/unpack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 2217d7b..dc2dd77 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -523,7 +523,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 				strict = 1;
 				continue;
 			}
-			if (!prefixcmp(arg, "--pack_header=")) {
+			if (has_prefix(arg, "--pack_header=")) {
 				struct pack_header *hdr;
 				char *c;
 
-- 
1.8.4.1.566.geca833c
