From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 37/65] i18n: mktree: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:49 +0700
Message-ID: <1338203657-26486-35-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:23:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy2v-00031p-Vg
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190Ab2E1LXa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:23:30 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58121 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867Ab2E1LX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:23:29 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4036469dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EHsRnW5I6dVo/PcWf7fLXvnbgDt6pdRpZnYQas0xQIM=;
        b=yxn+u5PpJDD0LRcOs7PrZ5Ow6wYLviXu+ypo536eLwH62LIdHxOMu6XqIZClf0eeWU
         s7p05wNCiFXQakuSYRbYRf/hoKshgWX9hQ2Uetx5Uavx1mvPXbLNICcSy2Ywl55h3Vgg
         g0OLwBzWjyXxJP8RimgeTwfaaosYdbnut2NSj9rT/f3HDDPrTh870M5dObfr/wkpr5wt
         voBZbEElfmqH9Ud/E08z+6xMzclObcPi7Oi/aPj6N7CHBL0dtC99fr7wSZlayl09AnKM
         mu2JHpFEEMvYDx3HAKwI8Bo2cvoNyUgBNqpZhFtnNDttzBymmo7wYE4+wxI4KZHyv4yK
         r3bQ==
Received: by 10.68.203.73 with SMTP id ko9mr26989281pbc.66.1338204208850;
        Mon, 28 May 2012 04:23:28 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id nw7sm18981360pbb.73.2012.05.28.04.23.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:23:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:19:23 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198673>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mktree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 4ae1c41..f92ba40 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -64,7 +64,7 @@ static void write_tree(unsigned char *sha1)
 }
=20
 static const char *mktree_usage[] =3D {
-	"git mktree [-z] [--missing] [--batch]",
+	N_("git mktree [-z] [--missing] [--batch]"),
 	NULL
 };
=20
@@ -150,9 +150,9 @@ int cmd_mktree(int ac, const char **av, const char =
*prefix)
 	int got_eof =3D 0;
=20
 	const struct option option[] =3D {
-		OPT_SET_INT('z', NULL, &line_termination, "input is NUL terminated",=
 '\0'),
-		OPT_SET_INT( 0 , "missing", &allow_missing, "allow missing objects",=
 1),
-		OPT_SET_INT( 0 , "batch", &is_batch_mode, "allow creation of more th=
an one tree", 1),
+		OPT_SET_INT('z', NULL, &line_termination, N_("input is NUL terminate=
d"), '\0'),
+		OPT_SET_INT( 0 , "missing", &allow_missing, N_("allow missing object=
s"), 1),
+		OPT_SET_INT( 0 , "batch", &is_batch_mode, N_("allow creation of more=
 than one tree"), 1),
 		OPT_END()
 	};
=20
--=20
1.7.10.2.549.g9354186
