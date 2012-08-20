From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/66] i18n: archive: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:31:51 +0700
Message-ID: <1345465975-16927-3-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:39:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RGG-00056E-9k
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966Ab2HTMjM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:39:12 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802Ab2HTMjL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:39:11 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6883151pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hYqxg3BXJhWHHMx1+3IwFCxI3PGowwvwqCQmS0LILx4=;
        b=aY6HfKGEC4uuUwLb9Wh5Ss+e+dEZciKEvVTR6Yr8r02Pz5twKOVX+BfR24U4DZRD8r
         Ufy6xbcsjBgAreTQQ2r3PdEdKYaDyJdKxV2sUfO2yhx6NAdIdaxqZSbU4TPxWKZqpCy0
         G03qVuNH0QF1gZQ7xTMA6QlpbAmm4OvN57UtPYG4HtpIK1a3+Pw4467Us9JdMtDW1Sgs
         O+MtCDHzk3HLLXAnCHnJPDo4oRyGf8PF6BzA8wgONRhTLVvqOODyX/jHRjBhQswZbZ89
         d/dTk2Mc9uM/jLS8SauWMnp6xCKveKfr6VIuEL5pGBg2gyADGVNmLFXo0oMkteZhZ0Ds
         kmHw==
Received: by 10.68.217.202 with SMTP id pa10mr34491699pbc.15.1345466350844;
        Mon, 20 Aug 2012 05:39:10 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id os1sm11038741pbc.31.2012.08.20.05.39.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:39:10 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:33:10 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203774>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
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
1.7.12.rc2.18.g61b472e
