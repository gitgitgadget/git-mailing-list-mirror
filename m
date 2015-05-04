From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] clean: describe --dry-run option in a more clear way in the usage string
Date: Mon,  4 May 2015 18:36:44 +0600
Message-ID: <1430743004-30721-1-git-send-email-kuleshovmail@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 04 14:37:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpFcL-0003Pt-5B
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 14:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbbEDMg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 08:36:56 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:33276 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548AbbEDMgy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 08:36:54 -0400
Received: by layy10 with SMTP id y10so102982078lay.0
        for <git@vger.kernel.org>; Mon, 04 May 2015 05:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=njI3+A30v8sMDTTlxXIIazyPOYIRjjuznyXNl2CIW4Y=;
        b=i9L411Yh+8aeOp1urrkXFYgJgLXCf4/MGFEnc10KferlnDQxmhZyTrrC0/Req5HEld
         0MiBoQ6rZP8cKgxFjDU7kzoqR9n4oCmjH7FS5uRpOtw1rTQzeTVntZBuioP6yriaRL0I
         x2s8vw2fDYkkAR/KJtPZANUxHiE9eh15B9lURK8FJhUB16jYNt/pVj7T2cyLjxw0XT1g
         HVOUqJjudlFreLFvYS4gGX2VRnnxZSdTrkkRXCo/q9mcn84JDeA+9uMXcKVGwYLiWgHt
         YMfrYgn55RazLq7Pv+qUaoUhsYTEbYwx/g3vhux5n4Q+NUFrzJmWNksRMvUya3Yx9wtt
         693w==
X-Received: by 10.112.234.163 with SMTP id uf3mr19758703lbc.9.1430743012833;
        Mon, 04 May 2015 05:36:52 -0700 (PDT)
Received: from localhost.localdomain ([37.151.39.249])
        by mx.google.com with ESMTPSA id ci10sm3333221lad.35.2015.05.04.05.36.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 May 2015 05:36:51 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268319>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/clean.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 17a1c13..01aae96 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -891,7 +891,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	const char *qname;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("do not print names of files removed")),
-		OPT__DRY_RUN(&dry_run, N_("dry run")),
+		OPT__DRY_RUN(&dry_run, N_("do not remove anything, only show what would be removed")),
 		OPT__FORCE(&force, N_("force")),
 		OPT_BOOL('i', "interactive", &interactive, N_("interactive cleaning")),
 		OPT_BOOL('d', NULL, &remove_directories,
-- 
2.4.0.dirty
