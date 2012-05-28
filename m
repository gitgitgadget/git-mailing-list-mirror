From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 28/65] i18n: hash-object: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:40 +0700
Message-ID: <1338203657-26486-26-git-send-email-pclouds@gmail.com>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 28 13:22:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy1e-0001RN-LH
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780Ab2E1LWJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:22:09 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43145 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab2E1LWI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:22:08 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4539054pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3N/Y/dpPBeIH7U/hRIY/dNAiPEwD9E/v3x+Rj1YCMHo=;
        b=IYb+sWVl6dcjDbMD4/QfYSQkOeXH9d+R1Avt77WLkeF7O4vsAAb7fCvxuiEVJDA1qw
         CaFX8qiJgTMWEhLigvefQpi6LxOPPVywiezU+yPmHFLPEavarMxA9eEBZ8P4D0oed7Th
         4nTqErLgMhyqnD8vo/nfc5kdnenV28WN43MHHMaNwRGV1uca7nzSZnhUCm5iuFqKTgev
         m+7geMrpIIlIGCiRSqZhDmV1kZb3Rk7hZZpZt11XT+M2bFUsfZjgn1l6/2R3OiFL0OLF
         vgxe+5QJcuTJa2VjebBMSODFf0Uox5XE6R1ZgDZC5/VSDrO9A0Uh3M7b7jhApwXkwdTl
         98kQ==
Received: by 10.68.204.227 with SMTP id lb3mr26936999pbc.92.1338204127482;
        Mon, 28 May 2012 04:22:07 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id kd6sm19005073pbc.24.2012.05.28.04.22.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:22:06 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:18:02 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198664>

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
1.7.10.2.549.g9354186
