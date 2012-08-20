From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 38/66] i18n: name-rev: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:27 +0700
Message-ID: <1345465975-16927-39-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:43:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RKL-0007xs-12
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402Ab2HTMnY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:43:24 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377Ab2HTMnW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:43:22 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tgpf0iejENh1KQkoDMOTxu6rdCC6uUoR5j9y+6OJ95c=;
        b=Cob4E0/SkUqY7v+VLLezqPd8qObjDdGoJxxBwdwfkWLkpzXjpp3RWmvN8Bi/+MrHjV
         WQnwKEKM1PbSrWpBMd2//6o8U4O34py/GWYRvICj/4i8kGOS1nEDTBCQyJZUyz+fMSvV
         0/vz9wuhlX2dcTDjV+ZSGeXIYH47FIuN2X9g1gDbVVsADWAu/jyibrs+fl7PHW9u6gPF
         qNPVxWPJUeNeBg6ph2x0QsSqdHN16VZbr/LKdGB/bFA8N3YWtLTZEYhHlm6YQRwzr1Ts
         rK0n8qVEM6jxFGyHqaExFsQK+xhtZHpRI6eogAikEFioSpRSkzjUO9qp/yNzYt8NAbeI
         X/Og==
Received: by 10.66.75.104 with SMTP id b8mr29465724paw.21.1345466602390;
        Mon, 20 Aug 2012 05:43:22 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id qr2sm11044234pbc.35.2012.08.20.05.43.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:43:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:37:20 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203810>

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
1.7.12.rc2.18.g61b472e
