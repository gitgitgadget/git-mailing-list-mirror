From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 09/11] replace: allow long option names
Date: Sat, 31 Aug 2013 21:12:12 +0200
Message-ID: <20130831191215.26699.17024.chriscool@tuxfamily.org>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 21:13:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFqcC-00015H-GS
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 21:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032Ab3HaTNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 15:13:39 -0400
Received: from [194.158.98.15] ([194.158.98.15]:48175 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752863Ab3HaTNf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 15:13:35 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 0E0FC78;
	Sat, 31 Aug 2013 21:12:55 +0200 (CEST)
X-git-sha1: 5ec8a25b7b57981e4f17375509ff6856f4fb3fb4 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130831190528.26699.33964.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233537>

It is now standard practice in Git to have both short and long option
names. So let's give a long option name to the git replace options too.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 95736d9..d4d1b75 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -128,9 +128,9 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 {
 	int list = 0, delete = 0, force = 0;
 	struct option options[] = {
-		OPT_BOOLEAN('l', NULL, &list, N_("list replace refs")),
-		OPT_BOOLEAN('d', NULL, &delete, N_("delete replace refs")),
-		OPT_BOOLEAN('f', NULL, &force, N_("replace the ref if it exists")),
+		OPT_BOOLEAN('l', "list", &list, N_("list replace refs")),
+		OPT_BOOLEAN('d', "delete", &delete, N_("delete replace refs")),
+		OPT_BOOLEAN('f', "force", &force, N_("replace the ref if it exists")),
 		OPT_END()
 	};
 
-- 
1.8.4.rc1.31.g530f5ce.dirty
