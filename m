From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 26/28] gc: style change -- no SP before closing bracket
Date: Sat,  8 Mar 2014 09:48:18 +0700
Message-ID: <1394246900-31535-27-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:50:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7LU-0006KF-IH
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710AbaCHCud convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 21:50:33 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:43433 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673AbaCHCub (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:50:31 -0500
Received: by mail-pb0-f51.google.com with SMTP id uo5so4967982pbc.38
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/b1xsnQ+fmRHx3wSZupx+X7eswwZHwe3obfjgDeIfsU=;
        b=oJuPGF3eVJLC9/0KtqJHo07bmD75W913D9czZNIyxYEJ67vMYutpcuPS6g8xgzhS7n
         hW2G5LrqOIDXdsuAgT9woH1gQuW4aqOnDbxunkIyPMZ19tTp2KmixxAY4qANAxlfFEbC
         ngZv+PIqi7lLWIjKhjrSErmp2CrZHzuUbL6ttovkzxrUcuOBhFF/1WSw0DF2dbqm7pnq
         EvjUJyf3pnqUt43/6XTFlAfJ9hEoI7/nptP6Lvuk3n66rbKvibeC3HOOWyEe2sYVQRwc
         ZuwfO3AcfnGZYljDlxZrHyjhgffel/e85vTHkhPZXHEhUoAjKgKYSzYFOwhel2Ag7crl
         WQog==
X-Received: by 10.66.171.76 with SMTP id as12mr26331250pac.52.1394247030917;
        Fri, 07 Mar 2014 18:50:30 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id pi1sm18718497pac.14.2014.03.07.18.50.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:50:30 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:51:04 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243667>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c19545d..39d9b27 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -260,7 +260,7 @@ int cmd_gc(int argc, const char **argv, const char =
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
@@ -273,7 +273,7 @@ int cmd_gc(int argc, const char **argv, const char =
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
1.9.0.40.gaa8c3ea
