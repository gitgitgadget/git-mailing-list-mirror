From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] gitk: update German translation
Date: Fri, 12 Feb 2016 19:40:39 +0100
Message-ID: <1455302439-9290-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stimming@tuhh.de, paulus@samba.org, phillip.szelat@gmail.com,
	matthias.ruester@gmail.com, Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 19:40:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUIeB-000300-MT
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 19:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbcBLSkr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2016 13:40:47 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33588 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbcBLSkp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 13:40:45 -0500
Received: by mail-wm0-f42.google.com with SMTP id g62so74000914wme.0
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 10:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=HGxB5gKV9jqPkOYtfVrmRgUJ88MJ2OchBdhvndeP7+I=;
        b=UC/FDpYgpipPxm36hSVItVKcBxtezShC9io5TJoNkwWcQf1E1H7HFZxMPJD5IBF8aY
         xxkf8mp3kah/12uoR6hVTF8PdriMqFHIMAD94KhdK0FNmU6rnk7eSQlIbv050oo34QnW
         FxUycfk/fPQVrsZxt2o7E7Z3CXommsr3onZy5ewU5GAdjn7xIiQLE8BqTECsLufwa6Cy
         4TPPIX+q63evgWe17wBjYsAgjkEH3pBbVHcvJwYwtwyPlM3t/sJV2XMxMjLGTQM5EcB9
         rehG+Uzh7di5Y77C4NMzSHJ93/Uqf2BfH/PFH99uQXeS4JGnifCEd+WP1QjtAsGPATJV
         ahcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=HGxB5gKV9jqPkOYtfVrmRgUJ88MJ2OchBdhvndeP7+I=;
        b=ONztIlTfhBMIJruX5yOYG+ikViudGL+3hu7hzi4ZgpTjEktRvrQ/nsJN3h/c+UEWrJ
         zp3mS/uN9xfFUsfYDzGIY98REAAFnJIOAS02wbjTgP8tVqEkFshzUPfXWlFkJ1EqtYcL
         L2VpeRHAtzED+bpI0ILQyqFl2Z+Zw5movg0XvEp62/2pYDybzNAzPzx91UHKqXwfRYVH
         IWrXn9VERhHTffDwmznxQsr5Z0uMOANK/X8KpXx/K3idPRF3DkfIewQHpKFl6Jjvc/bh
         7OHCaYRhMR3ESzyRJqTDS4zNF37cOkSOsphrRT1SHdPnDhHMABreEDByxTlMU+2NveyY
         t/VQ==
X-Gm-Message-State: AG10YOSx8jU1cbZYoDyRBaGWkCTmXrgg9NWGfXLH5oFIbed6SHSikx4cgHl6bu/mzgHWWw==
X-Received: by 10.194.58.169 with SMTP id s9mr3306430wjq.52.1455302444519;
        Fri, 12 Feb 2016 10:40:44 -0800 (PST)
Received: from localhost (cable-82-119-11-109.cust.telecolumbus.net. [82.119.11.109])
        by smtp.gmail.com with ESMTPSA id t8sm11870068wjy.41.2016.02.12.10.40.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 Feb 2016 10:40:43 -0800 (PST)
X-Mailer: git-send-email 2.7.1.397.g2a43f26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286068>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
Note:
Some translations in gitk may differ from translations in git-core
since gitk uses another glossary which I tried to follow here.

 po/de.po | 79 +++++++++++++++++++++++++++-----------------------------=
--------
 1 file changed, 33 insertions(+), 46 deletions(-)

diff --git a/po/de.po b/po/de.po
index d9ba405..bde749e 100644
--- a/po/de.po
+++ b/po/de.po
@@ -21,15 +21,15 @@ msgstr ""
 msgid "Couldn't get list of unmerged files:"
 msgstr "Liste der nicht zusammengef=C3=BChrten Dateien nicht gefunden:=
"
=20
 #: gitk:212 gitk:2381
 msgid "Color words"
-msgstr ""
+msgstr "W=C3=B6rter einf=C3=A4rben"
=20
 #: gitk:217 gitk:2381 gitk:8220 gitk:8253
 msgid "Markup words"
-msgstr ""
+msgstr "W=C3=B6rter kennzeichnen"
=20
 #: gitk:324
 msgid "Error parsing revisions:"
 msgstr "Fehler beim Laden der Versionen:"
=20
@@ -185,11 +185,11 @@ msgstr "Dateien:"
 msgid "adding/removing string:"
 msgstr "=C3=84nderungen:"
=20
 #: gitk:2304 gitk:4779
 msgid "changing lines matching:"
-msgstr ""
+msgstr "Ge=C3=A4nderte Zeilen entsprechen:"
=20
 #: gitk:2313 gitk:2315 gitk:4766
 msgid "Exact"
 msgstr "Exakt"
=20
@@ -246,11 +246,11 @@ msgstr "Kontextzeilen"
 msgid "Ignore space change"
 msgstr "Leerzeichen=C3=A4nderungen ignorieren"
=20
 #: gitk:2378 gitk:2380 gitk:7959 gitk:8206
 msgid "Line diff"
-msgstr ""
+msgstr "Zeilenunterschied"
=20
 #: gitk:2445
 msgid "Patch"
 msgstr "Patch"
=20
@@ -305,23 +305,20 @@ msgstr "Abk=C3=B6mmling von Lesezeichen und diese=
r Version finden"
 #: gitk:2628
 msgid "Compare with marked commit"
 msgstr "Mit Lesezeichen vergleichen"
=20
 #: gitk:2629 gitk:2640
-#, fuzzy
 msgid "Diff this -> marked commit"
-msgstr "Vergleich: diese -> gew=C3=A4hlte"
+msgstr "Vergleich: diese -> gew=C3=A4hlte Version"
=20
 #: gitk:2630 gitk:2641
-#, fuzzy
 msgid "Diff marked commit -> this"
-msgstr "Vergleich: gew=C3=A4hlte -> diese"
+msgstr "Vergleich: gew=C3=A4hlte -> diese Version"
=20
 #: gitk:2631
-#, fuzzy
 msgid "Revert this commit"
-msgstr "Lesezeichen setzen"
+msgstr "Version umkehren"
=20
 #: gitk:2647
 msgid "Check out this branch"
 msgstr "Auf diesen Zweig umstellen"
=20
@@ -329,11 +326,11 @@ msgstr "Auf diesen Zweig umstellen"
 msgid "Remove this branch"
 msgstr "Zweig l=C3=B6schen"
=20
 #: gitk:2649
 msgid "Copy branch name"
-msgstr ""
+msgstr "Zweigname kopieren"
=20
 #: gitk:2656
 msgid "Highlight this too"
 msgstr "Diesen auch hervorheben"
=20
@@ -349,22 +346,21 @@ msgstr "Externes Diff-Programm"
 msgid "Blame parent commit"
 msgstr "Annotieren der Elternversion"
=20
 #: gitk:2660
 msgid "Copy path"
-msgstr ""
+msgstr "Pfad kopieren"
=20
 #: gitk:2667
 msgid "Show origin of this line"
 msgstr "Herkunft dieser Zeile anzeigen"
=20
 #: gitk:2668
 msgid "Run git gui blame on this line"
 msgstr "Diese Zeile annotieren (=C2=BBgit gui blame=C2=AB)"
=20
 #: gitk:3014
-#, fuzzy
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
 "\n"
 "Copyright =C2=A9 2005-2014 Paul Mackerras\n"
@@ -372,11 +368,11 @@ msgid ""
 "Use and redistribute under the terms of the GNU General Public Licens=
e"
 msgstr ""
 "\n"
 "Gitk - eine Visualisierung der Git-Historie\n"
 "\n"
-"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
+"Copyright \\u00a9 2005-2014 Paul Mackerras\n"
 "\n"
 "Benutzung und Weiterverbreitung gem=C3=A4=C3=9F den Bedingungen der G=
NU General Public "
 "License"
=20
 #: gitk:3022 gitk:3089 gitk:9857
@@ -395,45 +391,42 @@ msgstr "Gitk-Tastaturbelegung:"
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tBeenden"
=20
 #: gitk:3049
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "<%s-W>\t\tClose window"
-msgstr "<%s-F>\t\tSuchen"
+msgstr "<%s-F>\t\tFenster schlie=C3=9Fen"
=20
 #: gitk:3050
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Pos1>\t\tZur neuesten Version springen"
=20
 #: gitk:3051
 msgid "<End>\t\tMove to last commit"
 msgstr "<Ende>\t\tZur =C3=A4ltesten Version springen"
=20
 #: gitk:3052
-#, fuzzy
 msgid "<Up>, p, k\tMove up one commit"
-msgstr "<Hoch>, p, i\tN=C3=A4chste neuere Version"
+msgstr "<Hoch>, p, k\tN=C3=A4chste neuere Version"
=20
 #: gitk:3053
-#, fuzzy
 msgid "<Down>, n, j\tMove down one commit"
-msgstr "<Runter>, n, k\tN=C3=A4chste =C3=A4ltere Version"
+msgstr "<Runter>, n, j\tN=C3=A4chste =C3=A4ltere Version"
=20
 #: gitk:3054
-#, fuzzy
 msgid "<Left>, z, h\tGo back in history list"
-msgstr "<Links>, z, j\tEine Version zur=C3=BCckgehen"
+msgstr "<Links>, z, h\tEine Version zur=C3=BCckgehen"
=20
 #: gitk:3055
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Rechts>, x, l\tEine Version weitergehen"
=20
 #: gitk:3056
 #, tcl-format
 msgid "<%s-n>\tGo to n-th parent of current commit in history list"
-msgstr ""
+msgstr "<%s-n>\tZu n-ter Elternversion in Versionshistorie springen"
=20
 #: gitk:3057
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<BildHoch>\tEine Seite nach oben bl=C3=A4ttern"
=20
@@ -512,13 +505,12 @@ msgstr "<%s-G>\t\tWeitersuchen"
 #: gitk:3074
 msgid "<Return>\tMove to next find hit"
 msgstr "<Eingabetaste>\tWeitersuchen"
=20
 #: gitk:3075
-#, fuzzy
 msgid "g\t\tGo to commit"
-msgstr "<Ende>\t\tZur =C3=A4ltesten Version springen"
+msgstr "g\t\tZu Version springen"
=20
 #: gitk:3076
 msgid "/\t\tFocus the search box"
 msgstr "/\t\tTastaturfokus ins Suchfeld"
=20
@@ -671,13 +663,12 @@ msgstr "Versionsbeschreibung:"
 #: gitk:4085
 msgid "Matches all Commit Info criteria"
 msgstr "Alle Versionsinformationen-Kriterien erf=C3=BCllen"
=20
 #: gitk:4086
-#, fuzzy
 msgid "Matches no Commit Info criteria"
-msgstr "Alle Versionsinformationen-Kriterien erf=C3=BCllen"
+msgstr "keine Versionsinformationen-Kriterien erf=C3=BCllen"
=20
 #: gitk:4087
 msgid "Changes to Files:"
 msgstr "Dateien:"
=20
@@ -800,11 +791,11 @@ msgstr "Lokale =C3=84nderungen bereitgestellt, ab=
er nicht eingetragen"
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Lokale =C3=84nderungen, nicht bereitgestellt"
=20
 #: gitk:7134
 msgid "and many more"
-msgstr ""
+msgstr "und weitere"
=20
 #: gitk:7137
 msgid "many"
 msgstr "viele"
=20
@@ -1064,38 +1055,35 @@ msgstr ""
 #: gitk:9566 gitk:9624
 msgid "No changes committed"
 msgstr "Keine =C3=84nderungen eingetragen"
=20
 #: gitk:9593
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Commit %s is not included in branch %s -- really revert it?"
 msgstr ""
-"Version =C2=BB%s=C2=AB ist bereits im Zweig =C2=BB%s=C2=AB enthalten =
-- trotzdem erneut "
-"eintragen?"
+"Version =C2=BB%s=C2=AB ist nicht im Zweig =C2=BB%s=C2=AB enthalten --=
 trotzdem umkehren?"
=20
 #: gitk:9598
-#, fuzzy
 msgid "Reverting"
-msgstr "Zur=C3=BCcksetzen"
+msgstr "Umkehren"
=20
 #: gitk:9606
-#, fuzzy, tcl-format
+#, tcl-format
 msgid ""
 "Revert failed because of local changes to the following files:%s Plea=
se "
 "commit, reset or stash  your changes and try again."
 msgstr ""
-"Pfl=C3=BCcken fehlgeschlagen, da noch lokale =C3=84nderungen in Datei=
 =C2=BB%s=C2=AB\n"
+"Umkehren fehlgeschlagen, da noch lokale =C3=84nderungen in Datei =C2=BB=
%s=C2=AB\n"
 "vorliegen. Bitte diese =C3=84nderungen eintragen, zur=C3=BCcksetzen o=
der\n"
 "zwischenspeichern (=C2=BBgit stash=C2=AB) und dann erneut versuchen."
=20
 #: gitk:9610
-#, fuzzy
 msgid ""
 "Revert failed because of merge conflict.\n"
 " Do you wish to run git citool to resolve it?"
 msgstr ""
-"Pfl=C3=BCcken fehlgeschlagen, da ein Zusammenf=C3=BChrungs-Konflikt a=
ufgetreten\n"
+"Umkehren fehlgeschlagen, da ein Zusammenf=C3=BChrungs-Konflikt aufget=
reten\n"
 "ist. Soll das Zusammenf=C3=BChrungs-Werkzeug (=C2=BBgit citool=C2=AB)=
 aufgerufen\n"
 "werden, um diesen Konflikt aufzul=C3=B6sen?"
=20
 #: gitk:9653
 msgid "Confirm reset"
@@ -1204,13 +1192,12 @@ msgstr "Maximale Graphenbreite (% des Fensters)=
"
 #: gitk:11358
 msgid "Show local changes"
 msgstr "Lokale =C3=84nderungen anzeigen"
=20
 #: gitk:11361
-#, fuzzy
 msgid "Auto-select SHA1 (length)"
-msgstr "SHA1-Hashwert automatisch ausw=C3=A4hlen"
+msgstr "SHA1-Hashwert (L=C3=A4nge) automatisch ausw=C3=A4hlen"
=20
 #: gitk:11365
 msgid "Hide remote refs"
 msgstr "Entfernte Zweige/Markierungen ausblenden"
=20
@@ -1221,17 +1208,16 @@ msgstr "Anzeige des Vergleichs"
 #: gitk:11371
 msgid "Tab spacing"
 msgstr "Tabulatorbreite"
=20
 #: gitk:11374
-#, fuzzy
 msgid "Display nearby tags/heads"
-msgstr "Naheliegende Markierungen anzeigen"
+msgstr "Naheliegende Markierungen/Zweigspitzen anzeigen"
=20
 #: gitk:11377
 msgid "Maximum # tags/heads to show"
-msgstr ""
+msgstr "Maximale Anzahl anzuzeigender Markierungen/Zweigspitzen"
=20
 #: gitk:11380
 msgid "Limit diffs to listed paths"
 msgstr "Vergleich nur f=C3=BCr angezeigte Pfade"
=20
@@ -1346,21 +1332,20 @@ msgstr "Beschriftungen"
 #: gitk:11485
 msgid "Gitk preferences"
 msgstr "Gitk-Einstellungen"
=20
 #: gitk:11494
-#, fuzzy
 msgid "General"
-msgstr "Erzeugen"
+msgstr "Allgemein"
=20
 #: gitk:11495
 msgid "Colors"
-msgstr ""
+msgstr "Farben"
=20
 #: gitk:11496
 msgid "Fonts"
-msgstr ""
+msgstr "Schriftarten"
=20
 #: gitk:11546
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: Farbe w=C3=A4hlen f=C3=BCr %s"
@@ -1368,10 +1353,12 @@ msgstr "Gitk: Farbe w=C3=A4hlen f=C3=BCr %s"
 #: gitk:12059
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
 msgstr ""
+"Entschuldigung, gitk kann nicht mit dieser Tcl/Tk Version ausgef=C3=BC=
hrt werden.\n"
+" Gitk erfordert mindestens Tcl/Tk 8.4."
=20
 #: gitk:12269
 msgid "Cannot find a git repository here."
 msgstr "Kein Git-Projektarchiv gefunden."
=20
--=20
2.7.1.397.g2a43f26
