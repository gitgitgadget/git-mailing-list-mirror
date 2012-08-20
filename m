From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/66] i18n: cat-file: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:31:56 +0700
Message-ID: <1345465975-16927-8-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:39:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RGj-0005QB-SQ
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615Ab2HTMjm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:39:42 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433Ab2HTMjl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:39:41 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6883151pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dv9/L6KxVpCVM7dApPdxoYHGnqfrJ0JJUJsLzgKWOg0=;
        b=vmrIXQYCLe3SIf9IT11+JVsXUp0HPViUTaI+p/ocCyNv4yvxCw2zAQZhGDa3sZta5o
         mQFG7xl3gt5gEw2yJzLs6mwdWOJCq1paCOZnEpaY49FYLpm+Ud/DdO/HcakQiBcYSUB7
         5kpOysHVdLw/Zt1yXsXIHXyHAa9Jxq5Hr0wY8Wj9+wGLn8ChOZ25sWqbKgMoeOv5ygSY
         cpqLsXdkbRQCmXLRyTAPzNukoQnL//TaZcBMrtSxxr8S5/0TCJp/m7m28E22uMxjxC93
         mvCwLhBQqxBAIuw5KaDIM1uo5hT7IwYYX+eZ2sUD2VPLv3jmCDLcoOjhsfZxeDiCr7et
         tCtw==
Received: by 10.66.81.202 with SMTP id c10mr18097341pay.80.1345466381100;
        Mon, 20 Aug 2012 05:39:41 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id nr8sm11035198pbc.43.2012.08.20.05.39.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:39:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:33:41 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203779>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/cat-file.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index af74e77..512072a 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -244,8 +244,8 @@ static int batch_objects(int print_contents)
 }
=20
 static const char * const cat_file_usage[] =3D {
-	"git cat-file (-t|-s|-e|-p|<type>|--textconv) <object>",
-	"git cat-file (--batch|--batch-check) < <list_of_objects>",
+	N_("git cat-file (-t|-s|-e|-p|<type>|--textconv) <object>"),
+	N_("git cat-file (--batch|--batch-check) < <list_of_objects>"),
 	NULL
 };
=20
@@ -263,19 +263,19 @@ int cmd_cat_file(int argc, const char **argv, con=
st char *prefix)
 	const char *exp_type =3D NULL, *obj_name =3D NULL;
=20
 	const struct option options[] =3D {
-		OPT_GROUP("<type> can be one of: blob, tree, commit, tag"),
-		OPT_SET_INT('t', NULL, &opt, "show object type", 't'),
-		OPT_SET_INT('s', NULL, &opt, "show object size", 's'),
+		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
+		OPT_SET_INT('t', NULL, &opt, N_("show object type"), 't'),
+		OPT_SET_INT('s', NULL, &opt, N_("show object size"), 's'),
 		OPT_SET_INT('e', NULL, &opt,
-			    "exit with zero when there's no error", 'e'),
-		OPT_SET_INT('p', NULL, &opt, "pretty-print object's content", 'p'),
+			    N_("exit with zero when there's no error"), 'e'),
+		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p=
'),
 		OPT_SET_INT(0, "textconv", &opt,
-			    "for blob objects, run textconv on object's content", 'c'),
+			    N_("for blob objects, run textconv on object's content"), 'c'),
 		OPT_SET_INT(0, "batch", &batch,
-			    "show info and content of objects fed from the standard input",
+			    N_("show info and content of objects fed from the standard inpu=
t"),
 			    BATCH),
 		OPT_SET_INT(0, "batch-check", &batch,
-			    "show info about objects fed from the standard input",
+			    N_("show info about objects fed from the standard input"),
 			    BATCH_CHECK),
 		OPT_END()
 	};
--=20
1.7.12.rc2.18.g61b472e
