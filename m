From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=20v2=5D=20l10n=3A=20de=2Epo=3A=20translate=2041=20new=20messages?=
Date: Wed, 30 May 2012 23:16:26 +0200
Message-ID: <1338412586-12116-1-git-send-email-ralf.thielow@googlemail.com>
References: <1338395981-8094-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jk@jk.gs, stimming@tuhh.de, worldhello.net@gmail.com,
	git@vger.kernel.org, Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch
X-From: git-owner@vger.kernel.org Wed May 30 23:16:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZqG4-0002Bx-8v
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 23:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192Ab2E3VQk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 May 2012 17:16:40 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:59163 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357Ab2E3VQi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 17:16:38 -0400
Received: by wibhn6 with SMTP id hn6so232845wib.1
        for <git@vger.kernel.org>; Wed, 30 May 2012 14:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fUSF3K2jSc8aVBsrBcPWzqF7oiE9Abndv8bDtDQuR5o=;
        b=fyP1Ke91HPYbIYuwfzfuQW/2SN602pEraPEvtiy6BOHoeS3cCCjzbUQMrqhsUe2dCs
         tAEMmZMcaUVfxc5E4IfQic/am35W9NWBfDlhGwwXUQAw3Z0vkhbnLQPkf0AvPY5xAuhQ
         /g6Mc0BHwg4XRzTFHOf/B+mUWmWAqkMnNAAxsZiVlutwaARs8Ed1GCnb6MixsvKZfIMb
         S+gcbp10UN0QeyEjI+G2VL5x3k7VARm3kN7zvHt20kXNvkmFPJSHKnxna0E1R18sdE7O
         ydOfm3OHy2BcYJWF3XOaTnYM3oTtDx0OaDakyPfFgHJVWXTl3nPG1ExH232JQUYiW0sx
         Y2zQ==
Received: by 10.216.226.233 with SMTP id b83mr11146508weq.204.1338412597386;
        Wed, 30 May 2012 14:16:37 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id i10sm2832656wiy.10.2012.05.30.14.16.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 May 2012 14:16:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.549.ga02ce85
In-Reply-To: <1338395981-8094-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198835>

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---

Instead of translate "num" with "Nummer", the word "Anzahl" is
indeed a better translation. This was suggested by Thomas on IRC.

 po/de.po | 221 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++------
 1 Datei ge=C3=A4ndert, 201 Zeilen hinzugef=C3=BCgt(+), 20 Zeilen entfe=
rnt(-)

diff --git a/po/de.po b/po/de.po
index 75668c6..47632a2 100644
--- a/po/de.po
+++ b/po/de.po
@@ -5,9 +5,9 @@
 #
 msgid ""
 msgstr ""
-"Project-Id-Version: git 1.7.10\n"
+"Project-Id-Version: git 1.7.11\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
-"POT-Creation-Date: 2012-05-15 06:42+0800\n"
+"POT-Creation-Date: 2012-05-21 08:57+0800\n"
 "PO-Revision-Date: 2012-03-28 18:46+0200\n"
 "Last-Translator: Ralf Thielow <ralf.thielow@googlemail.com>\n"
 "Language-Team: German\n"
@@ -343,6 +343,27 @@ msgstr[1] ""
 "\n"
 "Hast du eines von diesen gemeint?"
=20
+#: parse-options.c:493
+msgid "..."
+msgstr "..."
+
+#: parse-options.c:511
+#, c-format
+msgid "usage: %s"
+msgstr "Verwendung: %s"
+
+#. TRANSLATORS: the colon here should align with the
+#. one in "usage: %s" translation
+#: parse-options.c:515
+#, c-format
+msgid "   or: %s"
+msgstr "      oder: %s"
+
+#: parse-options.c:518
+#, c-format
+msgid "    %s"
+msgstr "    %s"
+
 #: remote.c:1607
 #, c-format
 msgid "Your branch is ahead of '%s' by %d commit.\n"
@@ -991,6 +1012,10 @@ msgstr "Bereitstellungsdatei besch=C3=A4digt"
 msgid "Unable to write new index file"
 msgstr "Konnte neue Bereitstellungsdatei nicht schreiben."
=20
+#: builtin/apply.c:53
+msgid "git apply [options] [<patch>...]"
+msgstr "git apply [Optionen] [<Patch>...]"
+
 #: builtin/apply.c:106
 #, c-format
 msgid "unrecognized whitespace option '%s'"
@@ -1320,6 +1345,127 @@ msgstr "nicht erkannte Eingabe"
 msgid "unable to read index file"
 msgstr "Konnte Bereitstellungsdatei nicht lesen"
=20
+#: builtin/apply.c:3962 builtin/apply.c:3965
+msgid "path"
+msgstr "Pfad"
+
+#: builtin/apply.c:3963
+msgid "don't apply changes matching the given path"
+msgstr "wendet keine =C3=84nderungen im angegebenen Pfad an"
+
+#: builtin/apply.c:3966
+msgid "apply changes matching the given path"
+msgstr "wendet =C3=84nderungen nur im angegebenen Pfad an"
+
+#: builtin/apply.c:3968
+msgid "num"
+msgstr "Anzahl"
+
+#: builtin/apply.c:3969
+msgid "remove <num> leading slashes from traditional diff paths"
+msgstr "entfernt <Anzahl> vorrangestellte Schr=C3=A4gstriche von herk=C3=
=B6mmlichen "
+"Differenzpfaden"
+
+#: builtin/apply.c:3972
+msgid "ignore additions made by the patch"
+msgstr "ignoriert hinzugef=C3=BCgte Zeilen des Patches"
+
+#: builtin/apply.c:3974
+msgid "instead of applying the patch, output diffstat for the input"
+msgstr "anstatt der Anwendung des Patches, wird die Differenz f=C3=BCr=
 die Eingabe "
+"ausgegeben"
+
+#: builtin/apply.c:3978
+msgid "shows number of added and deleted lines in decimal notation"
+msgstr "zeigt die Anzahl von hinzugef=C3=BCgten/entfernten Zeilen in "
+"Dezimalnotation"
+
+#: builtin/apply.c:3980
+msgid "instead of applying the patch, output a summary for the input"
+msgstr "anstatt der Anwendung des Patches, wird eine Zusammenfassung f=
=C3=BCr die "
+"Eingabe ausgegeben"
+
+#: builtin/apply.c:3982
+msgid "instead of applying the patch, see if the patch is applicable"
+msgstr "anstatt der Anwendung des Patches, zeige ob Patch angewendet w=
erden "
+"kann"
+
+#: builtin/apply.c:3984
+msgid "make sure the patch is applicable to the current index"
+msgstr "stellt sicher, dass der Patch in der aktuellen Bereitstellung =
"
+"angewendet werden kann"
+
+#: builtin/apply.c:3986
+msgid "apply a patch without touching the working tree"
+msgstr "wendet einen Patch an, ohne =C3=84nderungen im Arbeitszweig vo=
rzunehmen"
+
+#: builtin/apply.c:3988
+msgid "also apply the patch (use with --stat/--summary/--check)"
+msgstr "wendet den Patch an (Benutzung mit --stat/--summary/--check)"
+
+#: builtin/apply.c:3990
+msgid "build a temporary index based on embedded index information"
+msgstr "erstellt eine tempor=C3=A4re Bereitstellung basierend auf den =
integrierten "
+"Bereitstellungsinformationen"
+
+#: builtin/apply.c:3992
+msgid "paths are separated with NUL character"
+msgstr "Pfade sind getrennt durch NUL Zeichen"
+
+#: builtin/apply.c:3995
+msgid "ensure at least <n> lines of context match"
+msgstr "stellt sicher, dass mindestens <Anzahl> Zeilen des Kontextes "
+"=C3=BCbereinstimmen"
+
+#: builtin/apply.c:3996
+msgid "action"
+msgstr "Aktion"
+
+#: builtin/apply.c:3997
+msgid "detect new or modified lines that have whitespace errors"
+msgstr "ermittelt neue oder ge=C3=A4nderte Zeilen die Fehler in Leerze=
ichen haben"
+
+#: builtin/apply.c:4000 builtin/apply.c:4003
+msgid "ignore changes in whitespace when finding context"
+msgstr "ignoriert =C3=84nderungen in Leerzeichen bei der Suche des Kon=
textes"
+
+#: builtin/apply.c:4006
+msgid "apply the patch in reverse"
+msgstr "wendet den Patch in umgekehrter Reihenfolge an"
+
+#: builtin/apply.c:4008
+msgid "don't expect at least one line of context"
+msgstr "erwartet keinen Kontext"
+
+#: builtin/apply.c:4010
+msgid "leave the rejected hunks in corresponding *.rej files"
+msgstr "hinterl=C3=A4sst zur=C3=BCckgewiesene Patch-Bereiche in den en=
tsprechenden *.rej "
+"Dateien"
+
+#: builtin/apply.c:4012
+msgid "allow overlapping hunks"
+msgstr "erlaubt sich =C3=BCberlappende Patch-Bereiche"
+
+#: builtin/apply.c:4013
+msgid "be verbose"
+msgstr "erweiterte Ausgaben"
+
+#: builtin/apply.c:4015
+msgid "tolerate incorrectly detected missing new-line at the end of fi=
le"
+msgstr "toleriert fehlerhaft erkannten fehlenden Zeilenumbruch am Date=
iende"
+
+#: builtin/apply.c:4018
+msgid "do not trust the line counts in the hunk headers"
+msgstr "vertraut nicht den Zeilennummern im Kopf des Patch-Bereiches"
+
+#: builtin/apply.c:4020
+msgid "root"
+msgstr "Wurzelverzeichnis"
+
+#: builtin/apply.c:4021
+msgid "prepend <root> to all filenames"
+msgstr "stellt <Wurzelverzeichnis> vor alle Dateinamen"
+
 #: builtin/apply.c:4042
 msgid "--index outside a repository"
 msgstr "--index au=C3=9Ferhalb eines Projektarchivs"
@@ -2562,8 +2708,8 @@ msgstr "(nichts)"
 #, c-format
 msgid "Refusing to fetch into current branch %s of non-bare repository=
"
 msgstr ""
-"Das Anfordern in den aktuellen Zweig %s von einem nicht-blo=C3=9Fen "
-"Projektarchiv wurde verweigert."
+"Das Anfordern in den aktuellen Zweig %s von einem nicht-blo=C3=9Fen P=
rojektarchiv "
+"wurde verweigert."
=20
 #: builtin/fetch.c:709
 #, c-format
@@ -2851,8 +2997,8 @@ msgstr "Wert f=C3=BCr Versatz bei Differenzobjekt=
 =C3=BCbergelaufen"
=20
 #: builtin/index-pack.c:458
 msgid "delta base offset is out of bound"
-msgstr "Wert f=C3=BCr Versatz bei Differenzobjekt liegt au=C3=9Ferhalb=
 des g=C3=BCltigen "
-"Bereichs"
+msgstr ""
+"Wert f=C3=BCr Versatz bei Differenzobjekt liegt au=C3=9Ferhalb des g=C3=
=BCltigen Bereichs"
=20
 #: builtin/index-pack.c:466
 #, c-format
@@ -3798,8 +3944,8 @@ msgid ""
 "To choose either option permanently, see push.default in 'git help co=
nfig'."
 msgstr ""
 "\n"
-"Um eine Variante permanent zu verwenden, siehe push.default in "
-"'git help config'."
+"Um eine Variante permanent zu verwenden, siehe push.default in 'git h=
elp "
+"config'."
=20
 #: builtin/push.c:102
 #, c-format
@@ -3876,8 +4022,8 @@ msgstr ""
 msgid ""
 "You didn't specify any refspecs to push, and push.default is \"nothin=
g\"."
 msgstr ""
-"Du hast keine Referenzspezifikationen zum Versenden angegeben, und "
-"push.default ist \"nothing\"."
+"Du hast keine Referenzspezifikationen zum Versenden angegeben, und pu=
sh."
+"default ist \"nothing\"."
=20
 #: builtin/push.c:181
 msgid ""
@@ -3901,8 +4047,10 @@ msgid ""
 msgstr ""
 "Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze eines ve=
rsendeten\n"
 "Zweiges hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen is=
t. Wenn du nicht\n"
-"beabsichtigt hast, diesen Zweig zu versenden, kannst du auch den zu v=
ersendenden\n"
-"Zweig spezifizieren oder die Konfigurationsvariable 'push.default' zu=
 'current'\n"
+"beabsichtigt hast, diesen Zweig zu versenden, kannst du auch den zu "
+"versendenden\n"
+"Zweig spezifizieren oder die Konfigurationsvariable 'push.default' zu=
 "
+"'current'\n"
 "oder 'upstream' setzen, um nur den aktuellen Zweig zu versenden."
=20
 #: builtin/push.c:193
@@ -4008,8 +4156,9 @@ msgstr "Angabe eines Hauptzweiges macht mit --mir=
ror keinen Sinn"
=20
 #: builtin/remote.c:187
 msgid "specifying branches to track makes sense only with fetch mirror=
s"
-msgstr "die Angabe von zu folgenden Zweigen macht nur mit dem Abholen =
"
-"von Spiegelarchiven Sinn"
+msgstr ""
+"die Angabe von zu folgenden Zweigen macht nur mit dem Abholen von "
+"Spiegelarchiven Sinn"
=20
 #: builtin/remote.c:195 builtin/remote.c:646
 #, c-format
@@ -4072,8 +4221,7 @@ msgid ""
 "\tPlease update the configuration manually if necessary."
 msgstr ""
 "Keine Aktualisierung der nicht standardm=C3=A4=C3=9Figen Referenzspez=
ifikation zum "
-"Abholen"
-"\t%s\n"
+"Abholen\t%s\n"
 "\tBitte aktualisiere, falls notwendig, die Konfiguration manuell."
=20
 #: builtin/remote.c:683
@@ -4231,8 +4379,8 @@ msgstr "  Hauptzweig: %s"
 msgid ""
 "  HEAD branch (remote HEAD is ambiguous, may be one of the following)=
:\n"
 msgstr ""
-"  Hauptzweig (externer Hauptzweig ist mehrdeutig, k=C3=B6nnte einer d=
er "
-"folgenden sein):\n"
+"  Hauptzweig (externer Hauptzweig ist mehrdeutig, k=C3=B6nnte einer d=
er folgenden "
+"sein):\n"
=20
 #: builtin/remote.c:1151
 #, c-format
@@ -4635,6 +4783,38 @@ msgstr ""
 "Siehe 'git help <Kommando>' f=C3=BCr weitere Informationen zu einem s=
pezifischen "
 "Kommando"
=20
+#: parse-options.h:133 parse-options.h:235
+msgid "n"
+msgstr "Anzahl"
+
+#: parse-options.h:141
+msgid "time"
+msgstr "Zeit"
+
+#: parse-options.h:149
+msgid "file"
+msgstr "Datei"
+
+#: parse-options.h:151
+msgid "when"
+msgstr "wann"
+
+#: parse-options.h:156
+msgid "no-op (backward compatibility)"
+msgstr "Keine Operation (R=C3=BCckw=C3=A4rtskompatibilit=C3=A4t)"
+
+#: parse-options.h:228
+msgid "be more verbose"
+msgstr "erweiterte Ausgaben"
+
+#: parse-options.h:230
+msgid "be more quiet"
+msgstr "weniger Ausgaben"
+
+#: parse-options.h:236
+msgid "use <n> digits to display SHA-1s"
+msgstr "benutze <n> Ziffern zur Anzeige von SHA-1s"
+
 #: common-cmds.h:8
 msgid "Add file contents to the index"
 msgstr "stellt Dateiinhalte zur Eintragung bereit"
@@ -4693,8 +4873,9 @@ msgstr ""
=20
 #: common-cmds.h:21
 msgid "Fetch from and merge with another repository or a local branch"
-msgstr "Fordert Objekte von einem externen Projektarchiv an und f=C3=BC=
hrt sie "
-"mit einem anderen Projektarchiv oder einem lokalen Zweig zusammen"
+msgstr ""
+"Fordert Objekte von einem externen Projektarchiv an und f=C3=BChrt si=
e mit einem "
+"anderen Projektarchiv oder einem lokalen Zweig zusammen"
=20
 #: common-cmds.h:22
 msgid "Update remote refs along with associated objects"
--=20
1.7.10.2.549.ga02ce85
