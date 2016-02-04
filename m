From: tboegi@web.de
Subject: [PATCH v2 2/7] convert.c: remove unused parameter 'path'
Date: Thu,  4 Feb 2016 18:49:51 +0100
Message-ID: <1454608191-5339-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 18:49:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRO1a-0001B4-Ap
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 18:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758023AbcBDRsy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 12:48:54 -0500
Received: from mout.web.de ([212.227.17.12]:55626 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758005AbcBDRsw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 12:48:52 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0McnuP-1aimJf0D0D-00HzGd; Thu, 04 Feb 2016 18:48:50
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:T5w9vREeXh+qG6W6oLkVXG9DyBxQtPsxAm55f4KWgKnSgVfmxHo
 6XWRR/70ARNyn5vNMd1WDYYj/kVWO3QrOApH5cBQHl5k0HjgoPPNuf1QNypc2xAUpktEBzO
 DpDpwpeE2Sp2xwY3gx+Iew2upHHQQCO5NHsu6VH/Aqpjph5Jopj03wFpDUmItCUeSoYObw4
 jsubDebLdB+bhaWWMe0Ow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2PNRVnIi7hE=:WJAsWR44xHiTFaIaQvwXKj
 3Ff6cD+u3JTXxWPglRp0gyAHmvGeZQOc49ne1Rvjw+Buqy1CTIgI+IeYXzwXko2Vh9SyV/irW
 Ts33H8oIdQanOGNiV1aIz15j7IRNH/Nk8tG+RzUca5Ddb8TWO+FCTUS/Cu2e+1DacBDg6HxUi
 FGEX4fkWZrBsAaLXuFx/wqpUa6q0uehNicNB0o8MnnCOi1/eXgBNPuHP8GSwr/hsEc1NUYrkH
 V5bLoED1oXQd6urqUjtIY8PQo6kx9L/14860kVDxrUUnYjirJRiwLBiKfwqkHqX8keA0NE5+k
 /tVMTNeU8Q+3DXiE03cgN6fxoS6CYENivYs+SOKcs/XvwGDLoSh3AUE1a/m9QE8h88YldLhiq
 cj/Qpg4ZkePmLgfCvT2tAImzLMbNJvMuYuOQqMSOvgWawIxK7hvUFLr3aJdGwbVv3fK3RqLYa
 FywDwvU8l5bpP+HEDopLuBs9kH33aAtAKWYhlVJW2xtP7IwvosIFrNR7stiiR/XnXAY7FeCwZ
 Oo5VehJsG9EK2QT9UBcFV8SJLKF2/N2Ix8o/9h0Y0UenwvMl7Xc8iBqmuLOyEOs5SSlt0zTQB
 YZcT0ucwhvSh/bmf/mZ+fj641JpvVEEWHWdd3r3zpW+LIiAIBsjas2y6a7F7Q2lnAbTcxz5H8
 I0niwMlIRVUI0s+Et0FAbHMN1ym5Rja9LISFgFMMdEpjbjtXiNNOhxkmRmRGzJ2H7ve0ra5bf
 2ujzMzH9+nKfYNxFQwnthshEVSJq63sT2iH12IPWBYWjGAkrM4Bcd/t2QguTacN7Afxp/U+3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285470>

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
