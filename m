From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 82/86] builtin/tar-tree: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:07:15 +0100
Message-ID: <20131109070720.18178.93247.chriscool@tuxfamily.org>
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
	id 1Vf2l4-00014x-3H
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933479Ab3KIHO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:14:57 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:33998 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933464Ab3KIHOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:25 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 6937C9C;
	Sat,  9 Nov 2013 08:14:23 +0100 (CET)
X-git-sha1: 18769ea0a25705d5ab358b817716c397c21615e7 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237550>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/tar-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/tar-tree.c b/builtin/tar-tree.c
index ba3ffe6..7f225cc 100644
--- a/builtin/tar-tree.c
+++ b/builtin/tar-tree.c
@@ -34,7 +34,7 @@ int cmd_tar_tree(int argc, const char **argv, const char *prefix)
 	nargv[nargc++] = "archive";
 	nargv[nargc++] = "--format=tar";
 
-	if (2 <= argc && !prefixcmp(argv[1], "--remote=")) {
+	if (2 <= argc && has_prefix(argv[1], "--remote=")) {
 		nargv[nargc++] = argv[1];
 		argv++;
 		argc--;
-- 
1.8.4.1.566.geca833c
