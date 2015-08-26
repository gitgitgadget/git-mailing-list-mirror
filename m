From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] i18n: am: fix typo in description of -b option
Date: Wed, 26 Aug 2015 23:51:19 +0800
Message-ID: <4a9b76e9b4e32a1eedb98a284d8e3faa4fd417ca.1440603650.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 17:51:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUczF-0005Kk-RX
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 17:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223AbbHZPvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 11:51:37 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35907 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756148AbbHZPvg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 11:51:36 -0400
Received: by qgeb6 with SMTP id b6so128802452qge.3
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 08:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wJrmXIHWtkkkBDf2zToZ0oOrwq3nFpl3ludVwiSyJM4=;
        b=Z6C8lnG/IABRuRtyCOTvrO0/JqF/85Y3cm97UP+wGLJWoIWcZaHJzg1FvhdtHp59W7
         f8H2CHqP/YHupcWSwHYZanbXlXAvXpHbu1E1vv+gZpNVv25bXezZOFNu8KmjKSyK+fBN
         1GawHTzaJn7L7+7/D8sJra1oZb1JzCd9CyP64XCMTiw4tX2bkVLgcUXY/4oKakcI8VWi
         N8NplFrfJ+ct8tNV4c70iKkXilZbvK+8Q07PP99d40YlPf0733EV7CzRoNkr/dw3T4Zc
         aE5vxkBKj5cSFuQWrucXu/Uoi37X4vV29NhUE27rmOAjt6kFAX0u/QuyFF82IKfCE09r
         TZHA==
X-Received: by 10.140.133.69 with SMTP id 66mr83297886qhf.12.1440604295392;
        Wed, 26 Aug 2015 08:51:35 -0700 (PDT)
Received: from localhost.localdomain ([69.85.93.163])
        by smtp.googlemail.com with ESMTPSA id w190sm16551515qha.0.2015.08.26.08.51.32
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Aug 2015 08:51:34 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.416.gf01ac32
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276612>

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/am.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index b9c62e3..699a924 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2168,7 +2168,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('i', "interactive", &state.interactive,
 			N_("run interactively")),
 		OPT_HIDDEN_BOOL('b', "binary", &binary,
-			N_("(historical option -- no-op")),
+			N_("historical option -- no-op")),
 		OPT_BOOL('3', "3way", &state.threeway,
 			N_("allow fall back on 3way merging if needed")),
 		OPT__QUIET(&state.quiet, N_("be quiet")),
-- 
2.5.0.416.gf01ac32
