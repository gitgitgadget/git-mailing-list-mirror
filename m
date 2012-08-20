From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/66] i18n: clean: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:01 +0700
Message-ID: <1345465975-16927-13-git-send-email-pclouds@gmail.com>
References: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 14:40:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RHL-0005sB-Vm
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856Ab2HTMkS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:40:18 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306Ab2HTMkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:40:16 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6883151pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KSlxQVX+BoDcE/X5eUzvFZZK4BLqLakG+BxU5SQKmfQ=;
        b=WrbM8dmd0YHy/Nk7Uo9cNHioYMISB0In5W4MPdlbnR+X0M3fsh5H7cg0m6cdjE+1tT
         5izLPBbOacLJF90NZfVXkJyjsfPoJ6fN5Ukb/6eewKVYDSbLmbnPHNw807BSQu9XZ38b
         Dus8ZKSjGTrENPfrLQJStrbvStmBhKFPjmkj9lATVYjLDg7g2z07s2QDL7kxqh6pt7tL
         eFv5eIub257D1IZaGUYUhNSV50Hk5d+06n5apLeD/bDvbvYxn1aSUTeoUxc27vwqoJzN
         rEn709JLNpTEP0wtjsfTOFjMKfVNuOvUhRgpyQNdmIqJCo13Z4nauh57fz3OLAWaqGuC
         pq1A==
Received: by 10.68.136.137 with SMTP id qa9mr33901790pbb.140.1345466416207;
        Mon, 20 Aug 2012 05:40:16 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id gh9sm11044114pbc.20.2012.08.20.05.40.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:40:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:34:15 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203784>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clean.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 0c7b3d0..69c1cda 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -16,7 +16,7 @@
 static int force =3D -1; /* unset */
=20
 static const char *const builtin_clean_usage[] =3D {
-	"git clean [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>.=
=2E.",
+	N_("git clean [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path=
s>..."),
 	NULL
 };
=20
@@ -48,16 +48,16 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 	const char *qname;
 	char *seen =3D NULL;
 	struct option options[] =3D {
-		OPT__QUIET(&quiet, "do not print names of files removed"),
-		OPT__DRY_RUN(&show_only, "dry run"),
-		OPT__FORCE(&force, "force"),
+		OPT__QUIET(&quiet, N_("do not print names of files removed")),
+		OPT__DRY_RUN(&show_only, N_("dry run")),
+		OPT__FORCE(&force, N_("force")),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
-				"remove whole directories"),
-		{ OPTION_CALLBACK, 'e', "exclude", &exclude_list, "pattern",
-		  "add <pattern> to ignore rules", PARSE_OPT_NONEG, exclude_cb },
-		OPT_BOOLEAN('x', NULL, &ignored, "remove ignored files, too"),
+				N_("remove whole directories")),
+		{ OPTION_CALLBACK, 'e', "exclude", &exclude_list, N_("pattern"),
+		  N_("add <pattern> to ignore rules"), PARSE_OPT_NONEG, exclude_cb }=
,
+		OPT_BOOLEAN('x', NULL, &ignored, N_("remove ignored files, too")),
 		OPT_BOOLEAN('X', NULL, &ignored_only,
-				"remove only ignored files"),
+				N_("remove only ignored files")),
 		OPT_END()
 	};
=20
--=20
1.7.12.rc2.18.g61b472e
