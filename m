From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 27/66] i18n: hash-object: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:16 +0700
Message-ID: <1345465975-16927-28-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:42:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RJH-0007CN-BX
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200Ab2HTMmP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:42:15 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37322 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129Ab2HTMmN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:42:13 -0400
Received: by dady13 with SMTP id y13so2155685dad.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WAMbuafObWgunaVbLpnEnWRttJ8Pmik1c2xGlzIjzZk=;
        b=OeYsRinnt1JwewOKMvnadEILomPqW7N1rvS0kpzDK2s7mikzATog43dWIB2OsDRe33
         F9spT6ttJ1246IVKNt1WK84QIyDN+3d9vxnTGKDHfrAjLyzb3lwdgTkbs09VItRxKVSc
         ZSdlpLs+Uu/OhyrN3bQkKJeTnbypDFZTpsFBSc68q+WAgFQyagAHelu487rGXP0akpCk
         kSVxVBlPsvfcTbDb+ikg+LWC+B8DvmanH4/4PJf7joGH2Oqj2C7wOaKHkZCTHxxQha/c
         ZiKx1L5ysbUMlVlMz9MeoJgOrKldkUSZFNE6gTY9MS2SCxycuOtpy+7P8Nemb+fOFPDz
         NG1g==
Received: by 10.68.116.48 with SMTP id jt16mr34029421pbb.101.1345466533354;
        Mon, 20 Aug 2012 05:42:13 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id wn1sm11032388pbc.57.2012.08.20.05.42.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:42:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:36:13 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203799>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/hash-object.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 33911fd..8d184f1 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -57,8 +57,8 @@ static void hash_stdin_paths(const char *type, int wr=
ite_objects)
 }
=20
 static const char * const hash_object_usage[] =3D {
-	"git hash-object [-t <type>] [-w] [--path=3D<file>|--no-filters] [--s=
tdin] [--] <file>...",
-	"git hash-object  --stdin-paths < <list-of-paths>",
+	N_("git hash-object [-t <type>] [-w] [--path=3D<file>|--no-filters] [=
--stdin] [--] <file>..."),
+	N_("git hash-object  --stdin-paths < <list-of-paths>"),
 	NULL
 };
=20
@@ -69,12 +69,12 @@ static int stdin_paths;
 static const char *vpath;
=20
 static const struct option hash_object_options[] =3D {
-	OPT_STRING('t', NULL, &type, "type", "object type"),
-	OPT_BOOLEAN('w', NULL, &write_object, "write the object into the obje=
ct database"),
-	OPT_BOOLEAN( 0 , "stdin", &hashstdin, "read the object from stdin"),
-	OPT_BOOLEAN( 0 , "stdin-paths", &stdin_paths, "read file names from s=
tdin"),
-	OPT_BOOLEAN( 0 , "no-filters", &no_filters, "store file as is without=
 filters"),
-	OPT_STRING( 0 , "path", &vpath, "file", "process file as it were from=
 this path"),
+	OPT_STRING('t', NULL, &type, N_("type"), N_("object type")),
+	OPT_BOOLEAN('w', NULL, &write_object, N_("write the object into the o=
bject database")),
+	OPT_BOOLEAN( 0 , "stdin", &hashstdin, N_("read the object from stdin"=
)),
+	OPT_BOOLEAN( 0 , "stdin-paths", &stdin_paths, N_("read file names fro=
m stdin")),
+	OPT_BOOLEAN( 0 , "no-filters", &no_filters, N_("store file as is with=
out filters")),
+	OPT_STRING( 0 , "path", &vpath, N_("file"), N_("process file as it we=
re from this path")),
 	OPT_END()
 };
=20
--=20
1.7.12.rc2.18.g61b472e
