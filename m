From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 2 new, 3 fuzzy messages
Date: Sun, 3 Jun 2012 12:45:13 +0800
Message-ID: <CANYiYbFCTkx2JdvMbMtGHqqFz4rQMNXamicwRu2kZ3P6rtgSQQ@mail.gmail.com>
References: <1338659582-6864-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de,
	Git List <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 06:46:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sb2hT-0006WC-FN
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 06:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659Ab2FCEpQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Jun 2012 00:45:16 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64123 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab2FCEpP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jun 2012 00:45:15 -0400
Received: by obbtb18 with SMTP id tb18so5269075obb.19
        for <git@vger.kernel.org>; Sat, 02 Jun 2012 21:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=skh2n1hwUxR5fRfW/YhiLHarjYFbcpcy33qHKwiONg8=;
        b=iLZqzj9gyF2OnkknHCiZr60cmk+e04PbE2nTSmwhFWi7O/QZ/Mn3BA6K17gxPOXsm0
         7gfKrVF6CCCZWaqpVGIxqPZbO5yZ0AWoLhz3QPXVUhVuNTqJexwP7hODHqmr/vDtV8je
         e6L/8HB9UlKOQufpt+Tpda83iYQLEd9e4O5v08+5CFJSH5PcWHPMvX3tHIGLjBz0a+LD
         jDc9NLeklPSBeY9Zz2AeGw+uJjHwBImoU4jLLKCDY9YdKokTU/sQ1zhl44SwYC/BVRoz
         WiyB41pNt2W85JcYBSxHQr5rIMjcmuLlNBb6U+n0/A3oXELX/oxewWX6aVVUe7uxfM99
         d4IA==
Received: by 10.50.209.73 with SMTP id mk9mr5106216igc.66.1338698713544; Sat,
 02 Jun 2012 21:45:13 -0700 (PDT)
Received: by 10.50.111.194 with HTTP; Sat, 2 Jun 2012 21:45:13 -0700 (PDT)
In-Reply-To: <1338659582-6864-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199067>

2012/6/3 Ralf Thielow <ralf.thielow@googlemail.com>:
> Translate 2 new and 3 fuzzy messages came from git.pot update
> in 75f7b4b (l10n: Update git.pot (5 new, 3 removed messages)).
>
> Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
> ---
> =A0po/de.po | 474 +++++++++++++++++++++++++++++++++------------------=
------------
> =A01 Datei ge=E4ndert, 247 Zeilen hinzugef=FCgt(+), 227 Zeilen entfer=
nt(-)
>
> diff --git a/po/de.po b/po/de.po
> index 7b3cce8..a7774e0 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -48,7 +48,7 @@ msgstr "'%s' sieht nicht wie eine v2 Paketdatei aus=
"
> =A0msgid "unrecognized header: %s%s (%d)"
> =A0msgstr "nicht erkannter Kopfbereich: %s%s (%d)"
>
> -#: bundle.c:89 builtin/commit.c:697
> +#: bundle.c:89 builtin/commit.c:696
> =A0#, c-format
> =A0msgid "could not open '%s'"
> =A0msgstr "Konnte '%s' nicht =F6ffnen"

The modifications of location lines (#: filename:line) are tedious.
You can exclude them out of the diff file by a little:

 1. Creae a diff driver with a textconv program:

     $ git config --global diff.podiff.textconv "sed -e '/^#/ d'"

 2. Set attribute for '.po' files

     $ echo "*.po diff=3Dpodiff" >> $(git rev-parse --git-dir)/info/att=
ributes

Next time the diff you generated is more clear.

commit ada19d9a366892bac424ff4a70e7edc0af48d4de
Author: Ralf Thielow <ralf.thielow@googlemail.com>
Date:   Sat Jun 2 19:53:02 2012 +0200

    l10n: de.po: translate 2 new, 3 fuzzy messages

    Translate 2 new and 3 fuzzy messages came from git.pot update
    in 75f7b4b (l10n: Update git.pot (5 new, 3 removed messages)).

    Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>

diff --git a/po/de.po b/po/de.po
index f6e84f..d1187 100644
--- a/po/de.po
+++ b/po/de.po
@@ -2,7 +2,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git 1.7.11\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
-"POT-Creation-Date: 2012-05-21 08:57+0800\n"
+"POT-Creation-Date: 2012-06-02 07:03+0800\n"
 "PO-Revision-Date: 2012-03-28 18:46+0200\n"
 "Last-Translator: Ralf Thielow <ralf.thielow@googlemail.com>\n"
 "Language-Team: German\n"
@@ -455,6 +455,12 @@ msgid "Upstream branch '%s' not stored as a
remote-tracking branch"
 msgstr ""
 "Zweig '%s' des entfernten Projektarchivs ist kein gefolgter =DCbernah=
mezweig"

+msgid "unable to look up current user in the passwd file: %s"
+msgstr "konnte aktuellen Benutzer nicht in Passwort-Datei finden: %s"
+
+msgid "no such user"
+msgstr "kein solcher Benutzer"
+
 msgid "Unmerged paths:"
 msgstr "Nicht zusammengef=FChrte Pfade:"

@@ -853,8 +859,11 @@ msgstr "%s ist vom Typ %o, erwartete %o"
 msgid "%s: already exists in index"
 msgstr "%s ist bereits bereitgestellt"

-msgid "new mode (%o) of %s does not match old mode (%o)%s%s"
-msgstr "neuer Modus (%o) von %s entspricht nicht dem alten Modus (%o)%=
s%s"
+msgid "new mode (%o) of %s does not match old mode (%o)"
+msgstr "neuer Modus (%o) von %s entspricht nicht dem alten Modus (%o)"
+
+msgid "new mode (%o) of %s does not match old mode (%o) of %s"
+msgstr "neuer Modus (%o) von %s entspricht nicht dem alten Modus (%o) =
von %s"

 msgid "%s: patch does not apply"
 msgstr "%s: Patch konnte nicht angewendet werden"
@@ -925,31 +934,35 @@ msgid "num"
 msgstr "Anzahl"

 msgid "remove <num> leading slashes from traditional diff paths"
-msgstr "entfernt <Anzahl> vorrangestellte Schr=E4gstriche von herk=F6m=
mlichen "
+msgstr ""
+"entfernt <Anzahl> vorrangestellte Schr=E4gstriche von herk=F6mmlichen=
 "
 "Differenzpfaden"

 msgid "ignore additions made by the patch"
 msgstr "ignoriert hinzugef=FCgte Zeilen des Patches"

 msgid "instead of applying the patch, output diffstat for the input"
-msgstr "anstatt der Anwendung des Patches, wird der \"diffstat\" f=FCr
die Eingabe "
+msgstr ""
+"anstatt der Anwendung des Patches, wird der \"diffstat\" f=FCr die Ei=
ngabe "
 "ausgegeben"

 msgid "shows number of added and deleted lines in decimal notation"
-msgstr "zeigt die Anzahl von hinzugef=FCgten/entfernten Zeilen in "
-"Dezimalnotation"
+msgstr ""
+"zeigt die Anzahl von hinzugef=FCgten/entfernten Zeilen in Dezimalnota=
tion"

 msgid "instead of applying the patch, output a summary for the input"
-msgstr "anstatt der Anwendung des Patches, wird eine Zusammenfassung f=
=FCr die "
-"Eingabe ausgegeben"
+msgstr ""
+"anstatt der Anwendung des Patches, wird eine Zusammenfassung f=FCr di=
e Eingabe "
+"ausgegeben"

 msgid "instead of applying the patch, see if the patch is applicable"
-msgstr "anstatt der Anwendung des Patches, zeige ob Patch angewendet w=
erden "
-"kann"
+msgstr ""
+"anstatt der Anwendung des Patches, zeige ob Patch angewendet werden k=
ann"

 msgid "make sure the patch is applicable to the current index"
-msgstr "stellt sicher, dass der Patch in der aktuellen Bereitstellung =
"
-"angewendet werden kann"
+msgstr ""
+"stellt sicher, dass der Patch in der aktuellen Bereitstellung angewen=
det "
+"werden kann"

 msgid "apply a patch without touching the working tree"
 msgstr "wendet einen Patch an, ohne =C4nderungen im Arbeitszweig vorzu=
nehmen"
@@ -958,15 +971,16 @@ msgid "also apply the patch (use with
--stat/--summary/--check)"
 msgstr "wendet den Patch an (Benutzung mit --stat/--summary/--check)"

 msgid "build a temporary index based on embedded index information"
-msgstr "erstellt eine tempor=E4re Bereitstellung basierend auf den int=
egrierten "
+msgstr ""
+"erstellt eine tempor=E4re Bereitstellung basierend auf den integriert=
en "
 "Bereitstellungsinformationen"

 msgid "paths are separated with NUL character"
 msgstr "Pfade sind getrennt durch NUL Zeichen"

 msgid "ensure at least <n> lines of context match"
-msgstr "stellt sicher, dass mindestens <Anzahl> Zeilen des Kontextes "
-"=FCbereinstimmen"
+msgstr ""
+"stellt sicher, dass mindestens <Anzahl> Zeilen des Kontextes =FCberei=
nstimmen"

 msgid "action"
 msgstr "Aktion"
@@ -984,7 +998,8 @@ msgid "don't expect at least one line of context"
 msgstr "erwartet keinen Kontext"

 msgid "leave the rejected hunks in corresponding *.rej files"
-msgstr "hinterl=E4sst zur=FCckgewiesene Patch-Bereiche in den
entsprechenden *.rej "
+msgstr ""
+"hinterl=E4sst zur=FCckgewiesene Patch-Bereiche in den entsprechenden =
*.rej "
 "Dateien"

 msgid "allow overlapping hunks"
@@ -2315,9 +2330,6 @@ msgstr "Brauche genau einen Versionsbereich."
 msgid "Not a range."
 msgstr "Kein Versionsbereich."

-msgid "Could not extract email from committer identity."
-msgstr "Konnte E-Mail-Adresse des Einreichers nicht extrahieren."
-
 msgid "Cover letter needs email format"
 msgstr "Anschreiben ben=F6tigt E-Mail-Format"

@@ -2937,12 +2949,13 @@ msgid "Could not remove config section '%s'"
 msgstr "Konnte Sektion '%s' nicht aus Konfiguration entfernen"

 msgid ""
-"Not updating non-default fetch respec\n"
+"Not updating non-default fetch refspec\n"
 "\t%s\n"
 "\tPlease update the configuration manually if necessary."
 msgstr ""
 "Keine Aktualisierung der nicht standardm=E4=DFigen Referenzspezifikat=
ion zum "
-"Abholen\t%s\n"
+"Abholen\n"
+"\t%s\n"
 "\tBitte aktualisiere, falls notwendig, die Konfiguration manuell."

 msgid "Could not append '%s'"
@@ -3702,14 +3715,14 @@ msgstr "Keine URL f=FCr Unterprojekt-Pfad
'$sm_path' in .gitmodules gefunden"
 msgid "Failed to register url for submodule path '$sm_path'"
 msgstr "Registrierung der URL f=FCr Unterprojekt-Pfad '$sm_path' fehlg=
eschlagen"

+msgid "Submodule '$name' ($url) registered for path '$sm_path'"
+msgstr "Unterprojekt '$name' ($url) ist f=FCr Pfad '$sm_path' registri=
ert"
+
 msgid "Failed to register update mode for submodule path '$sm_path'"
 msgstr ""
 "Registrierung des Aktualisierungsmodus f=FCr Unterprojekt-Pfad '$sm_p=
ath' "
 "fehlgeschlagen"

-msgid "Submodule '$name' ($url) registered for path '$sm_path'"
-msgstr "Unterprojekt '$name' ($url) ist f=FCr Pfad '$sm_path' registri=
ert"
-
 msgid ""
 "Submodule path '$sm_path' not initialized\n"
 "Maybe you want to use 'update --init'?"
@@ -3770,3 +3783,4 @@ msgstr "Synchronisiere Unterprojekt-URL f=FCr '$n=
ame'"



+



--=20
JIang Xin
