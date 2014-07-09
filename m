From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 28/32] gc: style change -- no SP before closing bracket
Date: Wed,  9 Jul 2014 14:33:13 +0700
Message-ID: <1404891197-18067-29-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:36:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mQ7-0004Sh-Hr
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128AbaGIHf7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 03:35:59 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:47040 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017AbaGIHf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:35:58 -0400
Received: by mail-pa0-f51.google.com with SMTP id hz1so8778535pad.38
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=N7M+JG7IbxnWn7+1fAOQp6lQ8nHomsiO7ebAxY8rqEQ=;
        b=Y+i58vLOsd/BeZVRs5G538N6btLIW6GaHzyOgv7f3j40tIQD9osxcxfuijfNI59yf2
         0d9G4HiuvABL68KJwecLcdDUgoEbsLYJBuFDk+G2jyk+7ExYp7orbI6T9zFXayTcYuYW
         x9XQA3iQMCAF4BM5X/cNdtohRJkqT30RtgKzfBCvNqx+IoMwusrXhFWmtJ5dHLbC5p/v
         VJHMvnxFN2HR1GVA3Q4cvRpk/wDF9zAYitjlZRXpCvEfadFuf+MSOC1ojn22pcgK5QSi
         kqgdl7VnDKUB0F53mJi0KOpSTGqc/gScN8Yf59gEc3xUw+KE/rrpxs2WMkxrhRfrrhtz
         +vfw==
X-Received: by 10.66.132.3 with SMTP id oq3mr40319731pab.33.1404891358056;
        Wed, 09 Jul 2014 00:35:58 -0700 (PDT)
Received: from lanh ([115.73.209.165])
        by mx.google.com with ESMTPSA id zx1sm57930919pbc.60.2014.07.09.00.35.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2014 00:35:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Jul 2014 14:35:55 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253103>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 8d219d8..53f1302 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -285,7 +285,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
 		{ OPTION_STRING, 0, "prune", &prune_expire, N_("date"),
 			N_("prune unreferenced objects"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
+			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire},
 		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increas=
ed runtime)")),
 		OPT_BOOL(0, "auto", &auto_gc, N_("enable auto-gc mode")),
 		OPT_BOOL(0, "force", &force, N_("force running gc even if there may =
be another gc running")),
@@ -298,7 +298,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 	argv_array_pushl(&pack_refs_cmd, "pack-refs", "--all", "--prune", NUL=
L);
 	argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
-	argv_array_pushl(&prune, "prune", "--expire", NULL );
+	argv_array_pushl(&prune, "prune", "--expire", NULL);
 	argv_array_pushl(&rerere, "rerere", "gc", NULL);
=20
 	git_config(gc_config, NULL);
--=20
1.9.1.346.ga2b5940
