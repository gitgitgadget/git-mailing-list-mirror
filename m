From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/65] i18n: cherry: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:24 +0700
Message-ID: <1338203657-26486-10-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:20:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYxzS-0006vv-FP
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828Ab2E1LTx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:19:53 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59749 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab2E1LTv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:19:51 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4033567dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=b+cZ3hqWuV/rTviI42FSd+yWFR5f66cjATqJG9EJ/iw=;
        b=NVVjDgIi/0dyacJS4m5LrQdPpWcqg796rARUkOT/8Fig5w+Tx5a82QQG4uWBGZz63Y
         hXm9Xz29bcbkMaDY4LejF3XIghUVYQAYTmQfUhf5yHViCG6qxNOvtQiB3rUN40QWuiTW
         waHfjQobLIN1KQ3wPgXYwqyUsA5dXNCWzpifQBHM1uMnRy9nTW0c76SaGHvzaprwInlL
         ndwSSAwGC0bfPK5MPQlO7JwGmNxSN9fh5ZJEAJy4aCSyikGF/NTxwJxJvKBG0FnX8Ogo
         DjLcqTp7goWZROlwj4mdPFUKF+8zm1ZoWm3pC8YutsJhYHnco6Ym25hqWgr5S6eEoG6c
         FcdA==
Received: by 10.68.202.234 with SMTP id kl10mr26831604pbc.108.1338203990879;
        Mon, 28 May 2012 04:19:50 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id qq2sm18994233pbc.27.2012.05.28.04.19.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:19:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:15:45 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198647>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 690caa7..6282ed2 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1462,7 +1462,7 @@ static int add_pending_commit(const char *arg, st=
ruct rev_info *revs, int flags)
 }
=20
 static const char * const cherry_usage[] =3D {
-	"git cherry [-v] [<upstream> [<head> [<limit>]]]",
+	N_("git cherry [-v] [<upstream> [<head> [<limit>]]]"),
 	NULL
 };
=20
@@ -1496,7 +1496,7 @@ int cmd_cherry(int argc, const char **argv, const=
 char *prefix)
=20
 	struct option options[] =3D {
 		OPT__ABBREV(&abbrev),
-		OPT__VERBOSE(&verbose, "be verbose"),
+		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_END()
 	};
=20
--=20
1.7.10.2.549.g9354186
