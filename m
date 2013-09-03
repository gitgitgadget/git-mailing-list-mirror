From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 09/11] replace: allow long option names
Date: Tue, 03 Sep 2013 09:10:23 +0200
Message-ID: <20130903071026.29838.44765.chriscool@tuxfamily.org>
References: <20130903070551.29838.43576.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 09:17:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGks4-0008IL-W8
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 09:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553Ab3ICHRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 03:17:40 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:45651 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932537Ab3ICHRU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 03:17:20 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 2C0CB42;
	Tue,  3 Sep 2013 09:17:20 +0200 (CEST)
X-git-sha1: ec722a0338070081303d6ace2f4729fe79dafbab 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130903070551.29838.43576.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233695>

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
