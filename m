From: tboegi@web.de
Subject: [PATCH v1 2/6] convert.c: Remove path when not needed
Date: Tue,  2 Feb 2016 17:53:10 +0100
Message-ID: <1454431990-1980-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 17:52:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQeBr-00033q-3e
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 17:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756638AbcBBQwY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2016 11:52:24 -0500
Received: from mout.web.de ([212.227.15.14]:57912 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756622AbcBBQwR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 11:52:17 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MTyEL-1aZgkA2Kfp-00Qj4K; Tue, 02 Feb 2016 17:52:15
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:Zj4mXjbAuv3fHJ1BStPW0KRzOb4rKAadEUbaVOwxdDJqh48G7MU
 MgNdR6t7+gmDDUm3zuuM1gx/6CIh4snceY/8OW/I1zB9bG8tzjIpFNuUD5U4VtTNlEVCE+5
 J4F5jT2BfOrQsD3NM787SniK3aWFfqlK64pHNO9YADxLxnXFewHXH49chAsXRQvE0WV3kNs
 wOi3SBTGLczY4dIYOe/bQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tC7BtM8veA0=:BXg+SK9xDPuoiXXs0jecVF
 xaohfeYdcxrZSyDhXO7xiTogwlFSxRBhN6+WK/fC0li+doU+DA0G1NA+Qk2x6wMPD6lyPu064
 nzFR8MrQlS/amuRkE3At/7rYcvjr07/09Jha+BXnIQPrvID9BXOlVrCn0keAuwj8otkgBPCeq
 IlM+KT5k7NxRbc+8MtfnaTwMzcFIUu2zv4dA17wrLkT837mObaBSMppxt7cbK6eQtX2zFrLfo
 LBiQaKBFLxH377+3W+3Yb7/W28fpJa7fNR3p9mfG/Rj0CDEwFbRFtlE8MNxnahDYYp9viwn2c
 6S2KEaFfZnu9NVkxBi7xzyOgvNOJSnsHKSKIbys1hYTfnHfSJ4HIZyO4Yk97j0/E3Z38VPung
 poDd8SrzALGvHfScWVcDup7iRQ1wlil3h4c9v/Fn8XH0K16+nAgJ5rbeRTzPvJb0Qr0w+Mbj5
 fgwQ22NGZmW6MSFc5gnUf4/I5+9DRaExYVXH5Tuu6WKPgJVG51RCWC2tY7DS7lyyZ1+IM5ujw
 Axk6Do6U5+QIuoiiBJChuA/2Q3kfIJOAlVNZgN1vmXSprlnDnkI3ODpHO9nntiWL3T3v4ptWv
 ULbZ5I6V60Fa9s0OHaF4GeOOFhK4BHJKLuIYJqYKYYaeCmpmgAM00edY3Im2W5BPmp4X3Iha4
 22m4Z+eAmbI0zBGqAYjJHPHJnzSwvYzevl3Jh9OAnk0kYwtuvi+IrswpOZwaTkEcchrmPr3Ok
 1wzP1RpanoD6JrCVAaOjSM1bk8owa36Qe/GUKFpbZXBJ7bOOuu+j9Q5RhYONkX/jW4H/jCTA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285276>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Some functions get a parameter path, but don't use it.
Remove the unused parameter.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/convert.c b/convert.c
index 4bb4ec1..a24c2a2 100644
--- a/convert.c
+++ b/convert.c
@@ -696,7 +696,7 @@ static int ident_to_worktree(const char *path, cons=
t char *src, size_t len,
 	return 1;
 }
=20
-static enum crlf_action git_path_check_crlf(const char *path, struct g=
it_attr_check *check)
+static enum crlf_action git_path_check_crlf(struct git_attr_check *che=
ck)
 {
 	const char *value =3D check->value;
=20
@@ -713,7 +713,7 @@ static enum crlf_action git_path_check_crlf(const c=
har *path, struct git_attr_ch
 	return CRLF_GUESS;
 }
=20
-static enum eol git_path_check_eol(const char *path, struct git_attr_c=
heck *check)
+static enum eol git_path_check_eol(struct git_attr_check *check)
 {
 	const char *value =3D check->value;
=20
@@ -726,8 +726,7 @@ static enum eol git_path_check_eol(const char *path=
, struct git_attr_check *chec
 	return EOL_UNSET;
 }
=20
-static struct convert_driver *git_path_check_convert(const char *path,
-					     struct git_attr_check *check)
+static struct convert_driver *git_path_check_convert(struct git_attr_c=
heck *check)
 {
 	const char *value =3D check->value;
 	struct convert_driver *drv;
@@ -740,7 +739,7 @@ static struct convert_driver *git_path_check_conver=
t(const char *path,
 	return NULL;
 }
=20
-static int git_path_check_ident(const char *path, struct git_attr_chec=
k *check)
+static int git_path_check_ident(struct git_attr_check *check)
 {
 	const char *value =3D check->value;
=20
@@ -783,12 +782,12 @@ static void convert_attrs(struct conv_attrs *ca, =
const char *path)
 	}
=20
 	if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
-		ca->crlf_action =3D git_path_check_crlf(path, ccheck + 4);
+		ca->crlf_action =3D git_path_check_crlf( ccheck + 4);
 		if (ca->crlf_action =3D=3D CRLF_GUESS)
-			ca->crlf_action =3D git_path_check_crlf(path, ccheck + 0);
-		ca->ident =3D git_path_check_ident(path, ccheck + 1);
-		ca->drv =3D git_path_check_convert(path, ccheck + 2);
-		ca->eol_attr =3D git_path_check_eol(path, ccheck + 3);
+			ca->crlf_action =3D git_path_check_crlf(ccheck + 0);
+		ca->ident =3D git_path_check_ident(ccheck + 1);
+		ca->drv =3D git_path_check_convert(ccheck + 2);
+		ca->eol_attr =3D git_path_check_eol(ccheck + 3);
 	} else {
 		ca->drv =3D NULL;
 		ca->crlf_action =3D CRLF_GUESS;
--=20
2.7.0.303.g2c4f448.dirty
