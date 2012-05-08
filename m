From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH 07/10] l10n: de.po: translate "remote" as "extern"
Date: Tue,  8 May 2012 19:33:42 +0200
Message-ID: <1336498425-17890-8-git-send-email-ralf.thielow@googlemail.com>
References: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worldhello.net@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Tue May 08 19:35:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRoJV-0002G2-I3
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 19:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518Ab2EHRey convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 13:34:54 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56002 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961Ab2EHRef (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 13:34:35 -0400
Received: by wgbdr13 with SMTP id dr13so6226478wgb.1
        for <git@vger.kernel.org>; Tue, 08 May 2012 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LBntuQw/B04qg50m7dtE9ibpAXpc0PrAbyd2cP8naWI=;
        b=uMsDY4D9qFcgC/qTkw+ywsm6CKMt8+nU+zImbKwymIXEt4fR/4o83QVl5kBFWIZCEl
         /b6wWIaXpzwzel44W3OLPBbuJEcQkdCiwktWs8rvHkHNjA/e1CPs819+pIjmhFMizdZC
         rU1GTLaVLtHP4XAfk3UlRFaVIklfR6qQNWRW+Ww4++rhLBIb5odJXmIouJilCMHXyZ90
         VwejtdYF/9fhzjQFBu04cYI2bHaVwPDR+XFAKK2Bl5/m2+2jW1od4z/8XMohZLfvTYmS
         Pv0uSAQPOZ2MN0Ao6bJBqpWmqZxni17Zn6+Gh3pWsjGP/8AC6N5LbWuxlEbsdH2ZSYs4
         HU+Q==
Received: by 10.180.97.41 with SMTP id dx9mr46613666wib.9.1336498474603;
        Tue, 08 May 2012 10:34:34 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id ff2sm47784452wib.9.2012.05.08.10.34.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 May 2012 10:34:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.129.g1ec31a3
In-Reply-To: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197407>

The word "remote" was translated as "entfernt"
and "anders". Both of them aren't really good
because "anders" in German means "other" and
"entfernt" has two different meanings and could
result in confusion to the users.
We've changed the translation to "extern".

Suggested-by: Jan Kr=C3=BCger <jk@jk.gs>
Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po |   46 +++++++++++++++++++++++-----------------------
 1 Datei ge=C3=A4ndert, 23 Zeilen hinzugef=C3=BCgt(+), 23 Zeilen entfer=
nt(-)

diff --git a/po/de.po b/po/de.po
index 00fe020..8db663d 100644
--- a/po/de.po
+++ b/po/de.po
@@ -779,7 +779,7 @@ msgstr "Konnte Ausgabe nicht umleiten."
=20
 #: builtin/archive.c:37
 msgid "git archive: Remote with no URL"
-msgstr "git archive: Anderes Archiv ohne URL"
+msgstr "git archive: Externes Archiv ohne URL"
=20
 #: builtin/archive.c:58
 msgid "git archive: expected ACK/NAK, got EOF"
@@ -825,7 +825,7 @@ msgstr ""
 #. TRANSLATORS: This is "remote " in "remote branch '%s' not found"
 #: builtin/branch.c:163
 msgid "remote "
-msgstr "entfernter "
+msgstr "externer "
=20
 #: builtin/branch.c:171
 msgid "cannot use -a with -d"
@@ -1301,12 +1301,12 @@ msgstr "Fertig.\n"
 #: builtin/clone.c:440
 #, c-format
 msgid "Could not find remote branch %s to clone."
-msgstr "Entfernter Zweig %s konnte nicht zum Klonen gefunden werden."
+msgstr "Externer Zweig %s konnte nicht zum Klonen gefunden werden."
=20
 #: builtin/clone.c:549
 msgid "remote HEAD refers to nonexistent ref, unable to checkout.\n"
 msgstr ""
-"Entfernte Zweigspitze (HEAD) bezieht sich auf eine nicht existierende=
 "
+"Externe Zweigspitze (HEAD) bezieht sich auf eine nicht existierende "
 "Referenz und kann nicht ausgecheckt werden.\n"
=20
 #: builtin/clone.c:639
@@ -1369,7 +1369,7 @@ msgstr "Wei=C3=9F nicht wie %s zu klonen ist."
 #: builtin/clone.c:835
 #, c-format
 msgid "Remote branch %s not found in upstream %s"
-msgstr "entfernten Zweig %s nicht im anderen Projektarchiv %s gefunden=
"
+msgstr "externer Zweig %s nicht im anderen Projektarchiv %s gefunden"
=20
 #: builtin/clone.c:842
 msgid "You appear to have cloned an empty repository."
@@ -1846,7 +1846,7 @@ msgstr "unbehandeltes Objekt '%s' gegeben"
=20
 #: builtin/fetch.c:200
 msgid "Couldn't find remote ref HEAD"
-msgstr "Konnte entfernte Referenz der Zweigspitze (HEAD) nicht finden.=
"
+msgstr "Konnte externe Referenz der Zweigspitze (HEAD) nicht finden."
=20
 #: builtin/fetch.c:252
 #, c-format
@@ -1973,8 +1973,8 @@ msgid ""
 "No remote repository specified.  Please, specify either a URL or a\n"
 "remote name from which new revisions should be fetched."
 msgstr ""
-"Kein entferntes Projektarchiv spezifiziert. Bitte spezifiziere entwed=
er\n"
-"eine URL oder den Namen eines entfernten Archivs, von welchem neue\n"
+"Kein externes Projektarchiv spezifiziert. Bitte spezifiziere entweder=
\n"
+"eine URL oder den Namen eines externen Archivs, von welchem neue\n"
 "Revisionen angefordert werden sollen."
=20
 #: builtin/fetch.c:918
@@ -1992,7 +1992,7 @@ msgstr "fetch --all macht keinen Sinn mit Referen=
zspezifikationen"
 #: builtin/fetch.c:983
 #, c-format
 msgid "No such remote or remote group: %s"
-msgstr "Keine solche Entfernung oder Entfernungsgruppe: %s"
+msgstr "Kein externes Archiv (einzeln oder Gruppe): %s"
=20
 #: builtin/fetch.c:991
 msgid "Fetching a group and specifying refspecs does not make sense"
@@ -2338,7 +2338,7 @@ msgstr "Fehler beim Erstellen der Ausgabedateien.=
"
 msgid ""
 "Could not find a tracked remote branch, please specify <upstream> man=
ually.\n"
 msgstr ""
-"Konnte gefolgten entfernten Zweig nicht finden, bitte spezifiziere "
+"Konnte gefolgten externen Zweig nicht finden, bitte spezifiziere "
 "<upstream> manuell.\n"
=20
 #: builtin/log.c:1530 builtin/log.c:1532 builtin/log.c:1544
@@ -2463,7 +2463,7 @@ msgid ""
 msgstr ""
 "Bitte gebe eine Versionsbeschreibung ein um zu erkl=C3=A4ren, warum d=
iese "
 "Zusammenf=C3=BChrung erforderlich ist,\n"
-"insbesondere wenn es einen aktualisierten entfernten Zweig mit einem =
"
+"insbesondere wenn es einen aktualisierten, externen Zweig mit einem "
 "Thema-Zweig zusammenf=C3=BChrt.\n"
 "\n"
 "Zeilen beginnend mit '#' werden ignoriert, und eine leere Beschreibun=
g "
@@ -2496,17 +2496,17 @@ msgstr "Kein aktueller Zweig."
=20
 #: builtin/merge.c:1059
 msgid "No remote for the current branch."
-msgstr "Kein anderes Archiv f=C3=BCr den aktuellen Zweig."
+msgstr "Kein externes Archiv f=C3=BCr den aktuellen Zweig."
=20
 #: builtin/merge.c:1061
 msgid "No default upstream defined for the current branch."
-msgstr "Kein entferntes Standard-Projektarchiv f=C3=BCr den aktuellen =
Zweig "
+msgstr "Kein externes Standard-Projektarchiv f=C3=BCr den aktuellen Zw=
eig "
 "definiert."
=20
 #: builtin/merge.c:1066
 #, c-format
 msgid "No remote tracking branch for %s from %s"
-msgstr "Kein entfernter =C3=9Cbernahmezweig f=C3=BCr %s von %s"
+msgstr "Kein externer =C3=9Cbernahmezweig f=C3=BCr %s von %s"
=20
 #: builtin/merge.c:1188
 msgid "There is no merge to abort (MERGE_HEAD missing)."
@@ -2882,7 +2882,7 @@ msgstr ""
 "Um die Historie, f=C3=BChrend zum aktuellen (freistehende Zweigspitze=
 (HEAD))\n"
 "Status zu versenden, benutze\n"
 "\n"
-"    git push %s HEAD:<Name-des-entfernten-Zweiges>\n"
+"    git push %s HEAD:<Name-des-externen-Zweiges>\n"
=20
 #: builtin/push.c:90
 #, c-format
@@ -2892,9 +2892,9 @@ msgid ""
 "\n"
 "    git push --set-upstream %s %s\n"
 msgstr ""
-"Der aktuelle Zweig %s hat keinen Zweig im entfernten Projektarchiv.\n=
"
-"Um den aktuellen Zweig zu versenden und die Entfernung als entferntes=
\n"
-"Projektarchiv zu setzen, benutze\n"
+"Der aktuelle Zweig %s hat keinen Zweig im externen Projektarchiv.\n"
+"Um den aktuellen Zweig zu versenden und das Fernarchiv als externes\n=
"
+"Projektarchiv zu verwenden, benutze\n"
 "\n"
 "    git push --set-upstream %s %s\n"
=20
@@ -2902,7 +2902,7 @@ msgstr ""
 #, c-format
 msgid "The current branch %s has multiple upstream branches, refusing =
to push."
 msgstr ""
-"Der aktuelle Zweig %s hat mehrere entfernte Zweige, Versand verweiger=
t."
+"Der aktuelle Zweig %s hat mehrere externe Zweige, Versand verweigert.=
"
=20
 #: builtin/push.c:101
 #, c-format
@@ -2911,9 +2911,9 @@ msgid ""
 "your current branch '%s', without telling me what to push\n"
 "to update which remote branch."
 msgstr ""
-"Du versendest nach '%s', welches kein entferntes Projektarchiv deines=
\n"
+"Du versendest nach '%s', welches kein externes Projektarchiv deines\n=
"
 "aktuellen Zweiges '%s' ist, ohne mir mitzuteilen, was ich versenden\n=
"
-"soll, um welchen entfernten Zweig zu aktualisieren."
+"soll, um welchen externen Zweig zu aktualisieren."
=20
 #: builtin/push.c:127
 msgid ""
@@ -2941,7 +2941,7 @@ msgid ""
 msgstr ""
 "Um dich vor Verlust von Historie zu bewahren, wurden nicht vorzuspule=
nde "
 "Aktualisierungen zur=C3=BCckgewiesen.\n"
-"F=C3=BChre die entfernten =C3=84nderungen zusammen (z.B. 'git pull') =
bevor du erneut "
+"F=C3=BChre die externen =C3=84nderungen zusammen (z.B. 'git pull') be=
vor du erneut "
 "versendest. Siehe auch die 'Note about fast-forwards' Sektion von \n"
 "'git push --help' f=C3=BCr weitere Details.\n"
=20
@@ -2964,7 +2964,7 @@ msgid ""
 msgstr ""
 "Kein Ziel zum Versenden konfiguriert.\n"
 "Entweder spezifizierst du die URL von der Kommandozeile oder konfigur=
ierst "
-"ein entferntes Projektarchiv unter Benutzung von\n"
+"ein externes Projektarchiv unter Benutzung von\n"
 "\n"
 "    git remote add <Name> <URL>\n"
 "\n"
--=20
1.7.10.129.g1ec31a3
