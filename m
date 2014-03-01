From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 25/27] gc: style change -- no SP before closing bracket
Date: Sat,  1 Mar 2014 19:13:01 +0700
Message-ID: <1393675983-3232-26-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:23:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJix9-0002rF-Qo
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbaCAMX1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:23:27 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33946 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbaCAMXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:23:25 -0500
Received: by mail-pa0-f43.google.com with SMTP id bj1so1834314pad.30
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/b1xsnQ+fmRHx3wSZupx+X7eswwZHwe3obfjgDeIfsU=;
        b=RA7NlLc5HcMG3g8NTwvfbJoSRVIL+Ty6lo5oDRNSp0kEw7WEhVszoSfaV7m0cdC2yC
         jXHxzlDYdu5i/VbQXVDQo7B7inWbNI0lFRfzIcifat6QvjLZJBagJ9Lc1eHElYbXbGa5
         A6UOfXJN5BNMY3aGn0EV+nqD8fs8wRSK7kjfU5+O3eiAFQGIOruOGsBn9KN5HipAkRyr
         Y4JAq3vGZ+PGY3FhI2+N5uQa8tEr5SqIUzBpmr/DSERXRE12IoGCbozavziD7vk7sOxy
         aCPVWc1QKqqVcjnMi0g0c6dxGndhUDh0yMrmhJlEI5g5EsDVVvTKZ7d5gXDgA6LNycSE
         T2hA==
X-Received: by 10.68.198.36 with SMTP id iz4mr9204321pbc.109.1393676604958;
        Sat, 01 Mar 2014 04:23:24 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id vn10sm15919672pbc.21.2014.03.01.04.23.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:23:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:23:50 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243089>

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
