From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 09/10] replace: add --edit to usage string
Date: Sat, 17 May 2014 14:16:38 +0200
Message-ID: <20140517121640.27582.23844.chriscool@tuxfamily.org>
References: <20140517120649.27582.58609.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 17:57:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wlgzi-0001TK-Qd
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 17:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbaEQP5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 11:57:47 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:54521 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932115AbaEQP5l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 11:57:41 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 06C5268;
	Sat, 17 May 2014 17:57:39 +0200 (CEST)
X-git-sha1: f45eee410c4dc2a6d76fe1c8d8891296abd856d8 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140517120649.27582.58609.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249478>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/replace.c b/builtin/replace.c
index 4ee3d92..1bb491d 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -16,6 +16,7 @@
 
 static const char * const git_replace_usage[] = {
 	N_("git replace [-f] <object> <replacement>"),
+	N_("git replace [-f] --edit <object>"),
 	N_("git replace -d <object>..."),
 	N_("git replace [--format=<format>] [-l [<pattern>]]"),
 	NULL
-- 
1.9.rc0.17.g651113e
