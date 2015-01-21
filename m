From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] i18n: bundle: mark git-bundle usage for translation
Date: Thu, 22 Jan 2015 01:03:43 +0600
Message-ID: <1421867023-31730-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 20:03:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0ZF-0006dQ-By
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbbAUTDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 14:03:50 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:60371 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbbAUTDs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 14:03:48 -0500
Received: by mail-la0-f54.google.com with SMTP id hv19so2588191lab.13
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 11:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dC13yPM4LvaGiVcn1IPfjqTUupI28aR3nHERh7gQeuM=;
        b=iRTULObpd+DfS0GkRrR0xx7SyUEj0onRtJqi4miERaFqCLWC0ALvHKbgT9pdqar9Zs
         hq1n5epKHj9+cMyQnwfWp/eR/dTWTxsabl0EvI/DTTaSxgs5YGv5nyVdgd21DYGKLUpX
         pNBc2hORzmSSVy543brgsyUBM1buqXjoIEFpQ7lofxkVAUn74ovBUzNvvnJO1wG702EE
         TyQEkCXS48l9xanxUaoMGzwArTI7dmHMMQTUC/nrVkGu8L9vCotMppwfBJ8lcD+MpzlM
         sKAIjGte5GReJV0rArQMoH9ZYoDHPsw+ySmddkTCtCsf8YQ0VrA828B2398nTRcttenX
         8dGg==
X-Received: by 10.112.133.4 with SMTP id oy4mr2618437lbb.83.1421867027140;
        Wed, 21 Jan 2015 11:03:47 -0800 (PST)
Received: from localhost.localdomain ([147.30.87.232])
        by mx.google.com with ESMTPSA id ya4sm5135213lbb.32.2015.01.21.11.03.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jan 2015 11:03:46 -0800 (PST)
X-Mailer: git-send-email 2.3.0-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262743>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/bundle.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 92a8a60..ca4a6a4 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -10,10 +10,10 @@
  */
 
 static const char builtin_bundle_usage[] =
-  "git bundle create <file> <git-rev-list args>\n"
-  "   or: git bundle verify <file>\n"
-  "   or: git bundle list-heads <file> [<refname>...]\n"
-  "   or: git bundle unbundle <file> [<refname>...]";
+	N_("git bundle create <file> <git-rev-list args>\n"
+	   "   or: git bundle verify <file>\n"
+	   "   or: git bundle list-heads <file> [<refname>...]\n"
+	   "   or: git bundle unbundle <file> [<refname>...]");
 
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
-- 
2.3.0.rc1.246.g8d68d51.dirty
