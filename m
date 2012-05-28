From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 39/65] i18n: name-rev: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:51 +0700
Message-ID: <1338203657-26486-37-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:23:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy3D-0003PT-CA
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867Ab2E1LXr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:23:47 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58121 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662Ab2E1LXq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:23:46 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4036469dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+QelnfCge/IF3U8LMXVQtogqthMB9u2m514Bce9UDXw=;
        b=mOQV3wJvf1CJ+PLNUXOTzGg7uzm1GW+xDSA9GrWQMBgC63PKXw6R7yp3ul8vhWOzC6
         +mMpYkLlQm7vNKXKA7O+cnu8RL/Z+RVpVm7oF8B/qiEARNsAM5/wGeybn4eMEM5Q3M8z
         PLktwI4E8/MxNnXuSLckYk+XiQ0LfvlYDldkAi1pCnxDkyYLO9VTpEe7ovYvFvxvM3WW
         y0lQbAPx1jL6sxLkI2hsKCJAygj5FAK1C/hoKkhKgE6RYKLUN5iY4cNLNcVKVFodqszo
         2BIdGzFokKY7Ye5RcQPIy/54lbTW8Xa11S/brB1jUSPJ8S5f9POWFnAZakOkV7In4K5U
         t+7Q==
Received: by 10.68.135.229 with SMTP id pv5mr26559349pbb.70.1338204226079;
        Mon, 28 May 2012 04:23:46 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id ve6sm18979452pbc.75.2012.05.28.04.23.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:23:45 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:19:40 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198675>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/name-rev.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 1b37458..6238247 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -172,9 +172,9 @@ static void show_name(const struct object *obj,
 }
=20
 static char const * const name_rev_usage[] =3D {
-	"git name-rev [options] <commit>...",
-	"git name-rev [options] --all",
-	"git name-rev [options] --stdin",
+	N_("git name-rev [options] <commit>..."),
+	N_("git name-rev [options] --all"),
+	N_("git name-rev [options] --stdin"),
 	NULL
 };
=20
@@ -226,16 +226,16 @@ int cmd_name_rev(int argc, const char **argv, con=
st char *prefix)
 	int all =3D 0, transform_stdin =3D 0, allow_undefined =3D 1, always =3D=
 0;
 	struct name_ref_data data =3D { 0, 0, NULL };
 	struct option opts[] =3D {
-		OPT_BOOLEAN(0, "name-only", &data.name_only, "print only names (no S=
HA-1)"),
-		OPT_BOOLEAN(0, "tags", &data.tags_only, "only use tags to name the c=
ommits"),
-		OPT_STRING(0, "refs", &data.ref_filter, "pattern",
-				   "only use refs matching <pattern>"),
+		OPT_BOOLEAN(0, "name-only", &data.name_only, N_("print only names (n=
o SHA-1)")),
+		OPT_BOOLEAN(0, "tags", &data.tags_only, N_("only use tags to name th=
e commits")),
+		OPT_STRING(0, "refs", &data.ref_filter, N_("pattern"),
+				   N_("only use refs matching <pattern>")),
 		OPT_GROUP(""),
-		OPT_BOOLEAN(0, "all", &all, "list all commits reachable from all ref=
s"),
-		OPT_BOOLEAN(0, "stdin", &transform_stdin, "read from stdin"),
-		OPT_BOOLEAN(0, "undefined", &allow_undefined, "allow to print `undef=
ined` names"),
+		OPT_BOOLEAN(0, "all", &all, N_("list all commits reachable from all =
refs")),
+		OPT_BOOLEAN(0, "stdin", &transform_stdin, N_("read from stdin")),
+		OPT_BOOLEAN(0, "undefined", &allow_undefined, N_("allow to print `un=
defined` names")),
 		OPT_BOOLEAN(0, "always",     &always,
-			   "show abbreviated commit object as fallback"),
+			   N_("show abbreviated commit object as fallback")),
 		OPT_END(),
 	};
=20
--=20
1.7.10.2.549.g9354186
