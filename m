From: Peter Colberg <peter@colberg.org>
Subject: [PATCH] Fix spelling of "occurred"
Date: Fri, 10 Jun 2016 10:22:31 -0400
Message-ID: <1465568551-5819-1-git-send-email-peter@colberg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Colberg <peter@colberg.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 10 16:32:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBNTX-0006d9-BS
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 16:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbcFJOaO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 10:30:14 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.98]:34112 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099AbcFJOaN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 10:30:13 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jun 2016 10:30:12 EDT
Received: from [144.76.164.56] (helo=pleione.colberg.org)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <peter@colberg.org>)
	id 1bBNLj-0008Aq-PX; Fri, 10 Jun 2016 16:23:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=colberg.org;
	s=20160215; t=1465568631;
	bh=J63ohHpJT/OtZo+HcNL5lcP5pLeOY5FFkB8m0Ce/QUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding;
	b=mRb0j7pwpdW3InbBhPpDKfv28iHyHhU4Hkt2WBlhThXEOM4DHopSDCE0QXhBRRR1f
	 EVwz3XQTiHKQjpqBQjrLedNEp2R9RRahqKnchn567FEge/uiT1eI9Q+SQkOsuxH/1Y
	 gxO2GryCL8Pf54GIAlmEaCRjELNJTUfLop4Gokdip7sKXNUpdPIMgPNNsSLcVU2uS0
	 gnbHMwBovss3FrgQtpU/GzbC7RrVhSa1wLMTZ0ILH/1fO0KbPBsRKxhlPnVRzT8r0b
	 4H4xdI4A7gcF8O8ajn6mhtiEmuIMtOTy1CxYlStIXV6Z6h5wajJeSdO+KSIJoE/N/g
	 69ceUZlF6GHAQ==
X-Mailer: git-send-email 2.8.1
X-Df-Sender: MTAwMjE5OA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297005>

Signed-off-by: Peter Colberg <peter@colberg.org>
---
 config.c    | 2 +-
 po/bg.po    | 2 +-
 po/ca.po    | 2 +-
 po/de.po    | 2 +-
 po/fr.po    | 2 +-
 po/git.pot  | 2 +-
 po/ko.po    | 2 +-
 po/pt_PT.po | 2 +-
 po/ru.po    | 2 +-
 po/sv.po    | 2 +-
 po/vi.po    | 2 +-
 po/zh_CN.po | 2 +-
 refs.h      | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/config.c b/config.c
index f51c56b..d7ce34b 100644
--- a/config.c
+++ b/config.c
@@ -1281,7 +1281,7 @@ static void git_config_raw(config_fn_t fn, void *=
data)
 		 * something went really wrong and we should stop
 		 * immediately.
 		 */
-		die(_("unknown error occured while reading the configuration files")=
);
+		die(_("unknown error occurred while reading the configuration files"=
));
 }
=20
 static void configset_iter(struct config_set *cs, config_fn_t fn, void=
 *data)
diff --git a/po/bg.po b/po/bg.po
index ac6f103..462eb9a 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -498,7 +498,7 @@ msgid "unable to parse command-line config"
 msgstr "=D0=BD=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D0=BD=D0=B8 =D0=
=BD=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8 =D0=BE=D1=82 =D0=BA=
=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=BD=D0=B8=D1=8F =D1=80=D0=B5=D0=B4"
=20
 #: config.c:1277
-msgid "unknown error occured while reading the configuration files"
+msgid "unknown error occurred while reading the configuration files"
 msgstr "=D0=BD=D0=B5=D0=BE=D1=87=D0=B0=D0=BA=D0=B2=D0=B0=D0=BD=D0=B0 =D0=
=B3=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B8=D0=B7=D1=87=
=D0=B8=D1=82=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 =D0=BA=D0=BE=D0=
=BD=D1=84=D0=B8=D0=B3=D1=83=D1=80=D0=B0=D1=86=D0=B8=D0=BE=D0=BD=D0=BD=D0=
=B8=D1=82=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=B5"
=20
 #: config.c:1601
diff --git a/po/ca.po b/po/ca.po
index 46000d7..b3dbba7 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -419,7 +419,7 @@ msgid "unable to parse command-line config"
 msgstr "no s'ha pogut analitzar la configuraci=C3=B3 de la l=C3=ADnia =
d'ordres"
=20
 #: config.c:1281
-msgid "unknown error occured while reading the configuration files"
+msgid "unknown error occurred while reading the configuration files"
 msgstr "ha ocorregut un error desconegut en llegir els fitxers de conf=
iguraci=C3=B3"
=20
 #: config.c:1629
diff --git a/po/de.po b/po/de.po
index 0eadf34..5bf91a0 100644
--- a/po/de.po
+++ b/po/de.po
@@ -417,7 +417,7 @@ msgstr ""
 "Konnte die =C3=BCber die Befehlszeile angegebene Konfiguration nicht =
parsen."
=20
 #: config.c:1281
-msgid "unknown error occured while reading the configuration files"
+msgid "unknown error occurred while reading the configuration files"
 msgstr ""
 "Es trat ein unbekannter Fehler beim Lesen der Konfigurationsdateien a=
uf."
=20
diff --git a/po/fr.po b/po/fr.po
index 55ca387..81465a9 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -483,7 +483,7 @@ msgid "unable to parse command-line config"
 msgstr "lecture de la configuration de ligne de commande impossible"
=20
 #: config.c:1281
-msgid "unknown error occured while reading the configuration files"
+msgid "unknown error occurred while reading the configuration files"
 msgstr "erreur inconnue pendant la lecture des fichiers de configurati=
on"
=20
 #: config.c:1629
diff --git a/po/git.pot b/po/git.pot
index 72ef798..7a3e9ba 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -390,7 +390,7 @@ msgid "unable to parse command-line config"
 msgstr ""
=20
 #: config.c:1281
-msgid "unknown error occured while reading the configuration files"
+msgid "unknown error occurred while reading the configuration files"
 msgstr ""
=20
 #: config.c:1629
diff --git a/po/ko.po b/po/ko.po
index 3ff3b9b..f1017b8 100644
--- a/po/ko.po
+++ b/po/ko.po
@@ -460,7 +460,7 @@ msgid "unable to parse command-line config"
 msgstr "=EB=AA=85=EB=A0=B9=ED=96=89 =EC=84=A4=EC=A0=95=EC=9D=84 =ED=8C=
=8C=EC=8B=B1=ED=95=A0 =EC=88=98 =EC=97=86=EC=8A=B5=EB=8B=88=EB=8B=A4"
=20
 #: config.c:1281
-msgid "unknown error occured while reading the configuration files"
+msgid "unknown error occurred while reading the configuration files"
 msgstr "=EC=84=A4=EC=A0=95 =ED=8C=8C=EC=9D=BC=EC=9D=84 =EC=9D=BD=EB=8A=
=94 =EC=A4=91 =EC=95=8C =EC=88=98 =EC=97=86=EB=8A=94 =EC=98=A4=EB=A5=98=
=EA=B0=80 =EC=83=9D=EA=B2=BC=EC=8A=B5=EB=8B=88=EB=8B=A4"
=20
 #: config.c:1629
diff --git a/po/pt_PT.po b/po/pt_PT.po
index 321b553..896eb2a 100644
--- a/po/pt_PT.po
+++ b/po/pt_PT.po
@@ -410,7 +410,7 @@ msgid "unable to parse command-line config"
 msgstr "n=C3=A3o =C3=A9 poss=C3=ADvel analisar configura=C3=A7=C3=A3o =
de linha de comandos"
=20
 #: config.c:1281
-msgid "unknown error occured while reading the configuration files"
+msgid "unknown error occurred while reading the configuration files"
 msgstr ""
 "ocorreu um erro desconhecido durante a leitura dos ficheiros de confi=
gura=C3=A7=C3=A3o"
=20
diff --git a/po/ru.po b/po/ru.po
index c0a838b..974b9ee 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -398,7 +398,7 @@ msgid "unable to parse command-line config"
 msgstr "=D0=BD=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D1=80=
=D0=B0=D0=B7=D0=BE=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D0=BA=D0=BE=D0=BD=D1=84=
=D0=B8=D0=B3=D1=83=D1=80=D0=B0=D1=86=D0=B8=D1=8E =D0=B8=D0=B7 =D0=BA=D0=
=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=BD=D0=BE=D0=B9 =D1=81=D1=82=D1=80=D0=BE=D0=
=BA=D0=B8"
=20
 #: config.c:1281
-msgid "unknown error occured while reading the configuration files"
+msgid "unknown error occurred while reading the configuration files"
 msgstr "=D0=BF=D1=80=D0=BE=D0=B8=D0=B7=D0=BE=D1=88=D0=BB=D0=B0 =D0=BD=D0=
=B5=D0=B8=D0=B7=D0=B2=D0=B5=D1=81=D1=82=D0=BD=D0=B0=D1=8F =D0=BE=D1=88=D0=
=B8=D0=B1=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D1=87=D1=82=D0=B5=D0=BD=D0=B8=
=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2 =D0=BA=D0=BE=D0=BD=D1=84=D0=
=B8=D0=B3=D1=83=D1=80=D0=B0=D1=86=D0=B8=D0=B8"
=20
 #: config.c:1629
diff --git a/po/sv.po b/po/sv.po
index 32bcaba..3d89dcc 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -410,7 +410,7 @@ msgid "unable to parse command-line config"
 msgstr "kan inte tolka kommandoradskonfiguration"
=20
 #: config.c:1281
-msgid "unknown error occured while reading the configuration files"
+msgid "unknown error occurred while reading the configuration files"
 msgstr "ok=C3=A4nt fel uppstod vid l=C3=A4sning av konfigurationsfiler=
na"
=20
 #: config.c:1629
diff --git a/po/vi.po b/po/vi.po
index edd8e29..9ef203c 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -414,7 +414,7 @@ msgid "unable to parse command-line config"
 msgstr "kh=C3=B4ng th=E1=BB=83 ph=C3=A2n t=C3=ADch c=E1=BA=A5u h=C3=AC=
nh d=C3=B2ng l=E1=BB=87nh"
=20
 #: config.c:1281
-msgid "unknown error occured while reading the configuration files"
+msgid "unknown error occurred while reading the configuration files"
 msgstr "=C4=91=C3=A3 c=C3=B3 l=E1=BB=97i ch=C6=B0a bi=E1=BA=BFt x=E1=BA=
=A3y ra trong khi =C4=91=E1=BB=8Dc c=C3=A1c t=E1=BA=ADp tin c=E1=BA=A5u=
 h=C3=ACnh"
=20
 #: config.c:1629
diff --git a/po/zh_CN.po b/po/zh_CN.po
index a6b06f9..3a429c8 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -531,7 +531,7 @@ msgid "unable to parse command-line config"
 msgstr "=E6=97=A0=E6=B3=95=E8=A7=A3=E6=9E=90=E5=91=BD=E4=BB=A4=E8=A1=8C=
=E4=B8=AD=E7=9A=84=E9=85=8D=E7=BD=AE"
=20
 #: config.c:1281
-msgid "unknown error occured while reading the configuration files"
+msgid "unknown error occurred while reading the configuration files"
 msgstr "=E5=9C=A8=E8=AF=BB=E5=8F=96=E9=85=8D=E7=BD=AE=E6=96=87=E4=BB=B6=
=E6=97=B6=E9=81=87=E5=88=B0=E6=9C=AA=E7=9F=A5=E9=94=99=E8=AF=AF"
=20
 #: config.c:1629
diff --git a/refs.h b/refs.h
index 9230d47..56089d5 100644
--- a/refs.h
+++ b/refs.h
@@ -345,7 +345,7 @@ struct ref_transaction *ref_transaction_begin(struc=
t strbuf *err);
  *     msg -- a message describing the change (for the reflog).
  *
  *     err -- a strbuf for receiving a description of any error that
- *         might have occured.
+ *         might have occurred.
  *
  * The functions make internal copies of refname and msg, so the
  * caller retains ownership of these parameters.
--=20
2.8.1
