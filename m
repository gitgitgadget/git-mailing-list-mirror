From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 34/65] i18n: merge-base: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:46 +0700
Message-ID: <1338203657-26486-32-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:23:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy2X-0002XH-S6
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781Ab2E1LXE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:23:04 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58121 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab2E1LXC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:23:02 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4036469dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TftWLDioLypWTIiSK5p7ohi28dF15UWGtbTL1TGhzyo=;
        b=0DRtJY9tpiB940BKIRdRetqCsPfnByF2rybNKwSzMJ0HcGdfAlOLMzw0J8iXc1TdQs
         Pl+3H5wPgyLCU0DA3R4h5PQaZZl6x/xitH4c6k0XMYR5qQhYsel0m4eyNNn2kjv03ujp
         Ixj3nFllbg2hGQyBNBPeu8B9weAIhKrhN47/dQrSUSfrqXOVPrDWj6qyEO0zcj34YZJy
         qnaKfHzjqFd5KAvFGlilH5X8IW+9K7rjiBjZVjGU69cwG15fLH0O56c+MGbSHaW4xE5a
         /EyQObunlf0VwlYZOBuf2ErI/8G3qCtaRBJZL/MhIMuCaLO1JpgRlV0LrFVMg6lzl3at
         QD+A==
Received: by 10.68.226.99 with SMTP id rr3mr26458808pbc.48.1338204182684;
        Mon, 28 May 2012 04:23:02 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id wn3sm18983793pbc.74.2012.05.28.04.22.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:23:01 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:18:56 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198670>

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
1.7.10.2.549.g9354186
