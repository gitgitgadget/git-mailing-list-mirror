From: tboegi@web.de
Subject: [PATCH v4 2/6] convert.c: remove unused parameter 'path'
Date: Wed, 10 Feb 2016 17:24:37 +0100
Message-ID: <1455121477-16312-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 17:23:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTXY2-0000Yi-FR
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 17:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbcBJQXS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2016 11:23:18 -0500
Received: from mout.web.de ([212.227.15.3]:54251 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160AbcBJQXR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 11:23:17 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LgYdx-1Zi5hO15NN-00nwoW; Wed, 10 Feb 2016 17:23:15
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:88d/ET3lTQJ2IbWYPtDGe5YqsoKg3+lrvPhVpDeZC7GLi4hpTKX
 Ql4rq0Tpp1OmEe2GxxVAKIh+LL7feTzZUx4zJGGHmzSPrrGj+QoSYqRdUb96R0nLTQekRWJ
 9ABRmsdIOPxi6Vc9f9z/llrobJdT0UFII/tW8xYDttOzTTOcmSrWeP09nteRJwi6qalDhB+
 G9Qm+dSkh/hyHUI2u/3zA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4TVUs4LUI2Y=:x45xvj8THY0tgGJfc3DvaK
 z46tpff/vRCwZXKH1Psda03yu/uX+JNBgv1+z8gWnOFH+Q4Rlw0QfmHuhR7N8DfYIfIrvpcke
 +lI0Tq4R1Mb2Xan0s2h+neXON6GFe00LlSLyIjKJo2dhIX8jKYUZoOWEP/YoRuw4e3L0jADiF
 UesTCJ7Z/6MNtSMMJ2O2k3EbxidCgvQiJnBkkSy7WOF53vWRjk/6tNXZ/M/ibhqRTjXMRs26Q
 WBUWymADSbZ4JcmFcWBg5hvPjVKaqmNf8RJtXiu2nQpIdbzhPOlErpqaxhl931YfC8PK6nP7t
 JscXAoeDlUhjTiJekS3eSucBuWDQb5FE54gvZg0+I6Yd/BMEMAgu1D/97I06Ojdaly+fIpXQr
 XdPx+Tn6HljwRgXtrw0/w9uCNEiYxqxCRY1IEpvHhXAPJc94kUlvt1ONnxMySVMzWZnpU8sqF
 JyTUFBV0fzCtB9a7FyIwSfmL5A1yRNY837rAtJewi9N8TJ6sURq286R20oUqFeLsQWrGJZc7m
 jr8p17xIhsGU3O0rOk1HzF5xVNB1tEpX2Pm/CmI3395OgIk+emseKS+pqrWcpFwCzN/GayKas
 9DTbzITzIKhu/Z13yg/AttZg+dmu93z+KAEeapjtuaT0UZyS5oOV3wWqC4WXK356JWcELamQK
 46scD7uKV6ejJo1+XrAkDsVo1d2PLAx+tG/LE9mZhQKhc8EJgCJMdvWdgZJRB+LFL6vockRs/
 BLCFsTGlh8EJ+HkspUw5AOVZ+o+VsnNVnIdOAz3ATvb1IVRKjAnnisQNqwXg8mUfdH9e9KSP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285909>

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
