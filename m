From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/65] i18n: archive: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:15 +0700
Message-ID: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:18:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYxy8-0005LL-Eh
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843Ab2E1LSc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:18:32 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43442 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab2E1LSb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:18:31 -0400
Received: by dady13 with SMTP id y13so4032956dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hWEaArBPabkHnGOlDJfjqMZjeKYF0r2V6pOaMHAO+yU=;
        b=xgcE5HSLDRhgbOE9ksQspyy5G7+jyWMMQBs24INvKSKpG7hZlwBmQH8LTljKOmp9m0
         RgEShnDJGN+FlnKGD83PXUSpzP7sBNG6L8z8edGt7/N979BUrXja8NwOMPgILGViUR7V
         ch04OVKcXuGr1bwKt8y8I3975sJDmI9SjjLsCPYowaa4b+vW0Uj+KVu/VibutkmHy8si
         KTGCP8raFqbt7pN+qfpuCtc4vyRlgijtQFw8YQOiSUtqNVDTZFND1iXm3nZHfYy3TGT4
         ySovewtB+ib3odUbC1mHLgObfRRexDAgIUuXqXtnfkK5/4Ys9te/jBEOTMGo5SEoKXy9
         t2Lg==
Received: by 10.68.203.7 with SMTP id km7mr26514387pbc.7.1338203910914;
        Mon, 28 May 2012 04:18:30 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id wd10sm18980321pbc.70.2012.05.28.04.18.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:18:29 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:14:20 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198639>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 rc times are usually more quiet times, let's slip the series in..
 minor conflict with revert topic in pu, but should be easy to
 resolve.

 archive.c         | 38 +++++++++++++++++++-------------------
 builtin/archive.c | 12 ++++++------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/archive.c b/archive.c
index a484433..2584324 100644
--- a/archive.c
+++ b/archive.c
@@ -7,10 +7,10 @@
 #include "unpack-trees.h"
=20
 static char const * const archive_usage[] =3D {
-	"git archive [options] <tree-ish> [<path>...]",
-	"git archive --list",
-	"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [<pa=
th>...]",
-	"git archive --remote <repo> [--exec <cmd>] --list",
+	N_("git archive [options] <tree-ish> [<path>...]"),
+	N_("git archive --list"),
+	N_("git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [=
<path>...]"),
+	N_("git archive --remote <repo> [--exec <cmd>] --list"),
 	NULL
 };
=20
@@ -319,16 +319,16 @@ static int parse_archive_args(int argc, const cha=
r **argv,
 	int worktree_attributes =3D 0;
 	struct option opts[] =3D {
 		OPT_GROUP(""),
-		OPT_STRING(0, "format", &format, "fmt", "archive format"),
-		OPT_STRING(0, "prefix", &base, "prefix",
-			"prepend prefix to each pathname in the archive"),
-		OPT_STRING('o', "output", &output, "file",
-			"write the archive to this file"),
+		OPT_STRING(0, "format", &format, N_("fmt"), N_("archive format")),
+		OPT_STRING(0, "prefix", &base, N_("prefix"),
+			N_("prepend prefix to each pathname in the archive")),
+		OPT_STRING('o', "output", &output, N_("file"),
+			N_("write the archive to this file")),
 		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
-			"read .gitattributes in working directory"),
-		OPT__VERBOSE(&verbose, "report archived files on stderr"),
-		OPT__COMPR('0', &compression_level, "store only", 0),
-		OPT__COMPR('1', &compression_level, "compress faster", 1),
+			N_("read .gitattributes in working directory")),
+		OPT__VERBOSE(&verbose, N_("report archived files on stderr")),
+		OPT__COMPR('0', &compression_level, N_("store only"), 0),
+		OPT__COMPR('1', &compression_level, N_("compress faster"), 1),
 		OPT__COMPR_HIDDEN('2', &compression_level, 2),
 		OPT__COMPR_HIDDEN('3', &compression_level, 3),
 		OPT__COMPR_HIDDEN('4', &compression_level, 4),
@@ -336,15 +336,15 @@ static int parse_archive_args(int argc, const cha=
r **argv,
 		OPT__COMPR_HIDDEN('6', &compression_level, 6),
 		OPT__COMPR_HIDDEN('7', &compression_level, 7),
 		OPT__COMPR_HIDDEN('8', &compression_level, 8),
-		OPT__COMPR('9', &compression_level, "compress better", 9),
+		OPT__COMPR('9', &compression_level, N_("compress better"), 9),
 		OPT_GROUP(""),
 		OPT_BOOL('l', "list", &list,
-			"list supported archive formats"),
+			N_("list supported archive formats")),
 		OPT_GROUP(""),
-		OPT_STRING(0, "remote", &remote, "repo",
-			"retrieve the archive from remote repository <repo>"),
-		OPT_STRING(0, "exec", &exec, "cmd",
-			"path to the remote git-upload-archive command"),
+		OPT_STRING(0, "remote", &remote, N_("repo"),
+			N_("retrieve the archive from remote repository <repo>")),
+		OPT_STRING(0, "exec", &exec, N_("cmd"),
+			N_("path to the remote git-upload-archive command")),
 		OPT_END()
 	};
=20
diff --git a/builtin/archive.c b/builtin/archive.c
index 931956d..e7965bf 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -88,12 +88,12 @@ int cmd_archive(int argc, const char **argv, const =
char *prefix)
 	const char *output =3D NULL;
 	const char *remote =3D NULL;
 	struct option local_opts[] =3D {
-		OPT_STRING('o', "output", &output, "file",
-			"write the archive to this file"),
-		OPT_STRING(0, "remote", &remote, "repo",
-			"retrieve the archive from remote repository <repo>"),
-		OPT_STRING(0, "exec", &exec, "cmd",
-			"path to the remote git-upload-archive command"),
+		OPT_STRING('o', "output", &output, N_("file"),
+			N_("write the archive to this file")),
+		OPT_STRING(0, "remote", &remote, N_("repo"),
+			N_("retrieve the archive from remote repository <repo>")),
+		OPT_STRING(0, "exec", &exec, N_("cmd"),
+			N_("path to the remote git-upload-archive command")),
 		OPT_END()
 	};
=20
--=20
1.7.10.2.549.g9354186
