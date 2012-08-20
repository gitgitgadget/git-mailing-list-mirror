From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 34/66] i18n: merge-file: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:23 +0700
Message-ID: <1345465975-16927-35-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:43:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RJv-0007cJ-HI
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337Ab2HTMm6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:42:58 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab2HTMm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:42:56 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=k/WiApNZthcuL0/C6ZIEoCevXZhDB4dDkfc7uVYg6LY=;
        b=dyuo6kh5UX6PUmgCb3wctqd7vT7WgjLxhzS/ysSONGoZqJBrxyo+1a4QEsxmprVAnl
         3rVhXDCn5903Ena/p4nuP9kb+/3+qTWMyUl0Y7RFGF4rJMTDvC9of8t04BDI0tXQmuUi
         Yoib4n2qC7ofbVJkXCaRzEpDeFrxOSP4boUayujD2i6rjrECWU1T3HcvTOv91X0e0Hbv
         UUFhzJTXDJxam+H0pDMB4TAJebCihLfmicfgbe5jlGBRcMI2ZK2LGgDHWZnji+4jQCqf
         v73gIkDfUr6TF6zsurIp0iBEUyy+eP+m9ERW9rxC1RDsl/fWUh5ctLT6jrCFhJ/EI9sQ
         IR6Q==
Received: by 10.68.239.164 with SMTP id vt4mr34453256pbc.118.1345466576690;
        Mon, 20 Aug 2012 05:42:56 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id mu8sm11037981pbc.49.2012.08.20.05.42.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:42:56 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:36:56 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203806>

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
1.7.12.rc2.18.g61b472e
