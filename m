From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 33/66] i18n: merge-base: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:22 +0700
Message-ID: <1345465975-16927-34-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:43:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RJq-0007aM-HF
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325Ab2HTMmw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:42:52 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231Ab2HTMmu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:42:50 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=14S0CFg2Pj1IiIlMAuLmyi0SVAaAarIn0EQPxTdMarM=;
        b=T8X8ky18xnOAupchnY7zSYkbixf+HKH0gbSzkNC5XDZeZPZYTWu8Ed0EOxu3UsIo3J
         iaDihLDPrL9TthtFEGgmb4V91J3v6FRdKouEldevoedwHBpMO6LPLQqQhkLoBD9AbuRO
         KTln8dfWU+de3h7EOcfI3JRF3T1Y9lJ7TnDJy5Q+IyvBej3OVUc0s4Imriivrko97rHe
         mqv3YTmBOLjsBYGLjou8w+BZVVxAkutgPWjFpyoG3UQWm04WtyCK5bVkhuG5XtQj9T/7
         xNy0+Zvr+4OZtQEDALzsSLvzD+ab8i0jLDyM09DQOa/D2NXz42lWaD/W+V21uqmtWNeo
         Kjcg==
Received: by 10.68.203.200 with SMTP id ks8mr34378190pbc.142.1345466570653;
        Mon, 20 Aug 2012 05:42:50 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id kt8sm11048284pbc.1.2012.08.20.05.42.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:42:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:36:50 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203805>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge-base.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 4f30f1b..2f223a6 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -23,9 +23,9 @@ static int show_merge_base(struct commit **rev, int r=
ev_nr, int show_all)
 }
=20
 static const char * const merge_base_usage[] =3D {
-	"git merge-base [-a|--all] <commit> <commit>...",
-	"git merge-base [-a|--all] --octopus <commit>...",
-	"git merge-base --independent <commit>...",
+	N_("git merge-base [-a|--all] <commit> <commit>..."),
+	N_("git merge-base [-a|--all] --octopus <commit>..."),
+	N_("git merge-base --independent <commit>..."),
 	NULL
 };
=20
@@ -79,9 +79,9 @@ int cmd_merge_base(int argc, const char **argv, const=
 char *prefix)
 	int reduce =3D 0;
=20
 	struct option options[] =3D {
-		OPT_BOOLEAN('a', "all", &show_all, "output all common ancestors"),
-		OPT_BOOLEAN(0, "octopus", &octopus, "find ancestors for a single n-w=
ay merge"),
-		OPT_BOOLEAN(0, "independent", &reduce, "list revs not reachable from=
 others"),
+		OPT_BOOLEAN('a', "all", &show_all, N_("output all common ancestors")=
),
+		OPT_BOOLEAN(0, "octopus", &octopus, N_("find ancestors for a single =
n-way merge")),
+		OPT_BOOLEAN(0, "independent", &reduce, N_("list revs not reachable f=
rom others")),
 		OPT_END()
 	};
=20
--=20
1.7.12.rc2.18.g61b472e
