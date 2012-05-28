From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 35/65] i18n: merge-file: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:47 +0700
Message-ID: <1338203657-26486-33-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:23:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy2g-0002gT-9P
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599Ab2E1LXN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:23:13 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58121 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909Ab2E1LXL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:23:11 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4036469dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eqxq1ncPW+Qkonc1hplWuhLvZ6kuV/AfNjs0F6cj4ms=;
        b=caFHAs19jPISYAR9/GI7xUoPia5s2FrzXlYfADCnEQXhJCQ6xdPM6ArF9TAOdtb1Bh
         KNVcDh41jRoqxytAi2XPd2maVx1Chcz51K7RNnBEUNrF23Kl1DcF2m7E9eDF15vb8zjV
         USBHwFyhdrWkvKCdxn2qsE7hx/vvuxR/U0lmdbbDC+ytLYhsHzlZ0w02oCEpThwDtzgH
         621d/L/ghRWtTCdQKE6js2Be2ksg3O+UUDCDdgq6xgz2r3YYfNSShljj6dAmPfr5RF8S
         h5IFE5FY7/ryMyhQ9VJzhq5NcjMHp6DNsRS135R9EcXxsUUmsrCt51+p3PEqm9s9LWJX
         PL6A==
Received: by 10.68.238.68 with SMTP id vi4mr4076979pbc.123.1338204191449;
        Mon, 28 May 2012 04:23:11 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id or7sm18987069pbb.60.2012.05.28.04.23.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:23:10 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:19:05 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198671>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge-file.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 6f0efef..c0570f2 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -5,7 +5,7 @@
 #include "parse-options.h"
=20
 static const char *const merge_file_usage[] =3D {
-	"git merge-file [options] [-L name1 [-L orig [-L name2]]] file1 orig_=
file file2",
+	N_("git merge-file [options] [-L name1 [-L orig [-L name2]]] file1 or=
ig_file file2"),
 	NULL
 };
=20
@@ -30,19 +30,19 @@ int cmd_merge_file(int argc, const char **argv, con=
st char *prefix)
 	int quiet =3D 0;
 	int prefixlen =3D 0;
 	struct option options[] =3D {
-		OPT_BOOLEAN('p', "stdout", &to_stdout, "send results to standard out=
put"),
-		OPT_SET_INT(0, "diff3", &xmp.style, "use a diff3 based merge", XDL_M=
ERGE_DIFF3),
-		OPT_SET_INT(0, "ours", &xmp.favor, "for conflicts, use our version",
+		OPT_BOOLEAN('p', "stdout", &to_stdout, N_("send results to standard =
output")),
+		OPT_SET_INT(0, "diff3", &xmp.style, N_("use a diff3 based merge"), X=
DL_MERGE_DIFF3),
+		OPT_SET_INT(0, "ours", &xmp.favor, N_("for conflicts, use our versio=
n"),
 			    XDL_MERGE_FAVOR_OURS),
-		OPT_SET_INT(0, "theirs", &xmp.favor, "for conflicts, use their versi=
on",
+		OPT_SET_INT(0, "theirs", &xmp.favor, N_("for conflicts, use their ve=
rsion"),
 			    XDL_MERGE_FAVOR_THEIRS),
-		OPT_SET_INT(0, "union", &xmp.favor, "for conflicts, use a union vers=
ion",
+		OPT_SET_INT(0, "union", &xmp.favor, N_("for conflicts, use a union v=
ersion"),
 			    XDL_MERGE_FAVOR_UNION),
 		OPT_INTEGER(0, "marker-size", &xmp.marker_size,
-			    "for conflicts, use this marker size"),
-		OPT__QUIET(&quiet, "do not warn about conflicts"),
-		OPT_CALLBACK('L', NULL, names, "name",
-			     "set labels for file1/orig_file/file2", &label_cb),
+			    N_("for conflicts, use this marker size")),
+		OPT__QUIET(&quiet, N_("do not warn about conflicts")),
+		OPT_CALLBACK('L', NULL, names, N_("name"),
+			     N_("set labels for file1/orig_file/file2"), &label_cb),
 		OPT_END(),
 	};
=20
--=20
1.7.10.2.549.g9354186
