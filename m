From: tboegi@web.de
Subject: [PATCH v3 2/7] convert.c: remove unused parameter 'path'
Date: Fri,  5 Feb 2016 17:13:22 +0100
Message-ID: <1454688802-20753-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 17:12:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRizt-00029f-Fv
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 17:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573AbcBEQMZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 11:12:25 -0500
Received: from mout.web.de ([212.227.17.11]:60454 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752921AbcBEQMT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 11:12:19 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MeSGJ-1agnHC1stz-00QFJg; Fri, 05 Feb 2016 17:12:17
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:IBzeMgew31bY6pUyJKKH7j4tvMBGSlBWaspNPsH/H39CqYdIsw1
 LiSeH9daUJK9QCIMHKymhWytfIEcAIyNj0i5L3eASKt+/sDTmKdrZrGOMnRZmtaJvjQcwHZ
 rTL1RS+57C6jFWB1sy7iOzs0RbM2yxHFmBZI6YUFfdLwmjWs0W2S0vRRFPActEMxCYD7v3v
 fwIxmZ9Gqv6b+LE/O75TA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G5eiJXz/Y1Q=:2him3OMiLLLIg7w4c5bODt
 MbEQOIRkjptzf1IvITWgRfwLW9qtzgYLT1Wvb9zIXdAy2Vybnfmtw2Y+edA1XpZvlWbaFnDyS
 7k+cvGDvkVatGiW2lr2o1VQuJjCXMsDS+mnbhq0tlU7sy1GqV8aJUHmgfFJybciYf8FdMGuWs
 yY20rY4jImSD1UiCue54eDOb7GKm4PWEAC1dy+0uWXlMaKxTmzExusEPhpIzd64okJvHAVKBr
 POUefBiMIfcyBcACrD7CYxohIj4SfFsx/5JDgrCEDywkL7xnneZiZVj+2P6oz08149BtvcDv7
 YtNg1US9bWKOLEmVpiyRC4+wS7SRjJsMWj998x2W9ETlq3GZKWINGJm/pCU7wYfqi66/NzoBk
 CyXsJ74kiUJgVvcF2FQ2Kwq8wO2ZPQ+kyY3D3pL0A6gxz0H0gZ3E1xnRhDoASyn1jE6/z6IK3
 Yl/URgEhaWLV+/1jHuoAiPRXX2i/Idc0uVQ00Ro9UT4qxbhpQZAtd2X2h2wn1xWiIAeAw1scI
 RKQhHiqDJbLrWxRspAlwgRL1dva67OkHqfCtT3Wkkm1CybklQvvDqGRUKwjOEUBnY8ZeAQC8m
 8gfLqTvuTXMvg2p7Ee7+sxLyQv37pcrVjLO8RGiDFyVHipOLJoXrhuUBlgHBuhOzfkL1KDD3r
 uu3uCeXGOKrL+DGVy8mDQE/j4Wpv9v29Feu0xob6bQMXNeht1joPd2NA8Rz75gyuYLGNwtwOo
 MCaKZSY/UkunmmNLE5FSTFPcZSZ69FzgUDHvdvfKqEBDjFVEdwY2kZWxjpfkWGA5ap7LR/Ab 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285583>

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
