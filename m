From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] l10n: de.po: translate 68 new messages
Date: Fri, 25 Dec 2015 20:38:18 +0100
Message-ID: <1451072298-5412-1-git-send-email-ralf.thielow@gmail.com>
References: <567D9577.9050809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: phillip.szelat@gmail.com
X-From: git-owner@vger.kernel.org Fri Dec 25 20:39:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aCYCd-0008Lk-I4
	for gcvg-git-2@plane.gmane.org; Fri, 25 Dec 2015 20:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662AbbLYTiZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Dec 2015 14:38:25 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38268 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523AbbLYTiX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2015 14:38:23 -0500
Received: by mail-wm0-f54.google.com with SMTP id l126so213271822wml.1
        for <git@vger.kernel.org>; Fri, 25 Dec 2015 11:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XBVXruoFioNAI/VViTeshYRfY6KDu/ky+MBQAQyTXhA=;
        b=iYU6V3DfkIGzvbZKbWU9cKKyztyqrBEPTzQ+uVl6tFI5MZ/LvjKwEkSGFejp0RC5Ly
         oKqgb64Lkd8TWm3frq9To5ucJhyA/UMjsE30ptXE5IoMdHlqFMAvu1/YZivl51MFgaL4
         M0n0EwbNaOZM72oWnTzR9pBZb79dWdKmwdk3inhUpbs4pMiyugXzA4IJDUYcz0WC7E13
         qeh4I2hWleJFf1LiaSWxD8do2w2rzi8tAUI4oaHqKSUg0V5kY6u3dZ57BdW17HiDtyzo
         58WqILHSufb8hTUqt311q06rWWBHKRzZNLgk5im12psQRYXrociBlGZ/abQiMA0OXdRy
         iwzw==
X-Received: by 10.194.5.231 with SMTP id v7mr46435510wjv.52.1451072301368;
        Fri, 25 Dec 2015 11:38:21 -0800 (PST)
Received: from localhost (cable-62-117-31-92.cust.telecolumbus.net. [62.117.31.92])
        by smtp.gmail.com with ESMTPSA id q4sm46340095wja.6.2015.12.25.11.38.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 25 Dec 2015 11:38:20 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc2.212.g788e337
In-Reply-To: <567D9577.9050809@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282992>

Translate 68 new messages came from git.pot update in
f4f2c8f (l10n: git.pot: v2.7.0 round 1 (66 new, 29 removed)) and
2c0ca05 (l10n: git.pot: v2.7.0 round 2 (2 new, 2 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
2015-12-25 20:13 GMT+01:00 Phillip Sz <phillip.szelat@gmail.com>:
> Hi,
>
> Just some comments, the rest looks fine.

Thanks for review, Phillip! Merry Christmas to you, too.
Here's v2.

 po/de.po | 190 ++++++++++++++++++++++++++++---------------------------=
--------
 1 file changed, 84 insertions(+), 106 deletions(-)

diff --git a/po/de.po b/po/de.po
index 1ce4193..2324605 100644
--- a/po/de.po
+++ b/po/de.po
@@ -32,17 +32,16 @@ msgstr ""
 "und zu committen."
=20
 #: advice.c:101 builtin/merge.c:1225
 msgid "You have not concluded your merge (MERGE_HEAD exists)."
 msgstr "Sie haben Ihren Merge nicht abgeschlossen (MERGE_HEAD existier=
t)."
=20
 #: advice.c:103
-#, fuzzy
 msgid "Please, commit your changes before merging."
-msgstr "Bitte committen Sie Ihre =C3=84nderungen, bevor Sie den Merge =
ausf=C3=BChren."
+msgstr "Bitte committen Sie Ihre =C3=84nderungen, bevor Sie mergen."
=20
 #: advice.c:104
 msgid "Exiting because of unfinished merge."
 msgstr "Beende wegen nicht abgeschlossenem Merge."
=20
 #: archive.c:12
 msgid "git archive [<options>] <tree-ish> [<path>...]"
@@ -1110,54 +1109,54 @@ msgstr "Konnte Referenzen nicht entfernen: %s"
 #, c-format
 msgid "could not remove reference %s"
 msgstr "Konnte Referenz %s nicht l=C3=B6schen"
=20
 #: ref-filter.c:245
 #, c-format
 msgid "format: %%(end) atom used without corresponding atom"
-msgstr ""
+msgstr "format: %%(end) Atom ohne zugeh=C3=B6riges Atom verwendet"
=20
 #: ref-filter.c:704
 #, c-format
 msgid "positive value expected contents:lines=3D%s"
-msgstr ""
+msgstr "Positiver Wert erwartet contents:lines=3D%s"
=20
 #: ref-filter.c:833
 #, c-format
 msgid "expected format: %%(color:<color>)"
-msgstr ""
+msgstr "Erwartetes Format: %%(color:<Farbe>)"
=20
 #: ref-filter.c:835
 msgid "unable to parse format"
 msgstr "Konnte Format nicht parsen."
=20
 #: ref-filter.c:870
 #, c-format
 msgid "expected format: %%(align:<width>,<position>)"
-msgstr ""
+msgstr "Erwartetes Format: %%(align:<Breite>,<Position>)"
=20
 #: ref-filter.c:893
 #, c-format
 msgid "improper format entered align:%s"
-msgstr ""
+msgstr "Sie haben ein ung=C3=BCltiges Format eingegeben align:%s"
=20
 #: ref-filter.c:898
 #, c-format
 msgid "positive width expected with the %%(align) atom"
-msgstr ""
+msgstr "Positive Breitenangabe f=C3=BCr %%(align) erwartet"
=20
 #: ref-filter.c:1219
 #, c-format
 msgid "malformed object at '%s'"
 msgstr "fehlerhaftes Objekt bei '%s'"
=20
 #: ref-filter.c:1561
 #, c-format
 msgid "format: %%(end) atom missing"
-msgstr ""
+msgstr "Format: %%(end) Atom fehlt"
=20
 #: ref-filter.c:1615
 #, c-format
 msgid "malformed object name %s"
 msgstr "Missgebildeter Objektname %s"
=20
 #: remote.c:756
@@ -2632,22 +2631,20 @@ msgstr ""
=20
 #: builtin/am.c:2220
 #, c-format
 msgid "Invalid value for --patch-format: %s"
 msgstr "Ung=C3=BCltiger Wert f=C3=BCr --patch-format: %s"
=20
 #: builtin/am.c:2253
-#, fuzzy
 msgid "git am [<options>] [(<mbox>|<Maildir>)...]"
-msgstr "git am [Optionen] [(<mbox>|<E-Mail-Verzeichnis>)...]"
+msgstr "git am [<Optionen>] [(<mbox>|<E-Mail-Verzeichnis>)...]"
=20
 #: builtin/am.c:2254
-#, fuzzy
 msgid "git am [<options>] (--continue | --skip | --abort)"
-msgstr "git am [Optionen] (--continue | --skip | --abort)"
+msgstr "git am [<Optionen>] (--continue | --skip | --abort)"
=20
 #: builtin/am.c:2260
 msgid "run interactively"
 msgstr "interaktiv ausf=C3=BChren"
=20
 #: builtin/am.c:2262
 msgid "historical option -- no-op"
@@ -3476,17 +3473,16 @@ msgid "git branch [<options>] [-r] (-d | -D) <b=
ranch-name>..."
 msgstr "git branch [<Optionen>] [-r] (-d | -D) <Branchname>..."
=20
 #: builtin/branch.c:28
 msgid "git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"
 msgstr "git branch [<Optionen>] (-m | -M) [<alter-Branch>] <neuer-Bran=
ch>"
=20
 #: builtin/branch.c:29
-#, fuzzy
 msgid "git branch [<options>] [-r | -a] [--points-at]"
-msgstr "git branch [<Optionen>] [-r | -a] [--merged | --no-merged]"
+msgstr "git branch [<Optionen>] [-r | -a] [--points-at]"
=20
 #: builtin/branch.c:142
 #, c-format
 msgid ""
 "deleting branch '%s' that has been merged to\n"
 "         '%s', but not yet merged to HEAD."
 msgstr ""
@@ -3738,22 +3734,20 @@ msgid "edit the description for the branch"
 msgstr "die Beschreibung f=C3=BCr den Branch bearbeiten"
=20
 #: builtin/branch.c:644
 msgid "force creation, move/rename, deletion"
 msgstr "Erstellung, Verschiebung/Umbenennung oder L=C3=B6schung erzwin=
gen"
=20
 #: builtin/branch.c:645
-#, fuzzy
 msgid "print only branches that are merged"
-msgstr "nur Branches ausgeben, welche diesen Commit beinhalten"
+msgstr "nur zusammengef=C3=BChrte Branches ausgeben"
=20
 #: builtin/branch.c:646
-#, fuzzy
 msgid "print only branches that are not merged"
-msgstr "nur Branches ausgeben, welche diesen Commit beinhalten"
+msgstr "nur nicht zusammengef=C3=BChrte Branches ausgeben"
=20
 #: builtin/branch.c:647
 msgid "list branches in columns"
 msgstr "Branches in Spalten auflisten"
=20
 #: builtin/branch.c:648 builtin/for-each-ref.c:38 builtin/tag.c:366
 msgid "key"
@@ -3766,17 +3760,16 @@ msgstr "sortiere nach diesem Feld"
 #: builtin/branch.c:651 builtin/for-each-ref.c:41 builtin/notes.c:398
 #: builtin/notes.c:401 builtin/notes.c:561 builtin/notes.c:564
 #: builtin/tag.c:369
 msgid "object"
 msgstr "Objekt"
=20
 #: builtin/branch.c:652
-#, fuzzy
 msgid "print only branches of the object"
-msgstr "nur Tags von dem Objekt ausgeben"
+msgstr "nur Branches von diesem Objekt ausgeben"
=20
 #: builtin/branch.c:670
 msgid "Failed to resolve HEAD as a valid ref."
 msgstr "Konnte HEAD nicht als g=C3=BCltige Referenz aufl=C3=B6sen."
=20
 #: builtin/branch.c:674 builtin/clone.c:697
 msgid "HEAD not found below refs/heads!"
@@ -3908,19 +3901,16 @@ msgid ""
 "git cat-file (-t [--allow-unknown-type]|-s [--allow-unknown-type]|-e|=
-p|"
 "<type>|--textconv) <object>"
 msgstr ""
 "git cat-file (-t [--allow-unknown-type]|-s [--allow-unknown-type]|-e|=
-p|"
 "<Art>|--textconv) <Objekt>"
=20
 #: builtin/cat-file.c:429
-#, fuzzy
 msgid "git cat-file (--batch | --batch-check) [--follow-symlinks]"
-msgstr ""
-"git cat-file (--batch | --batch-check) [--follow-symlinks] < <Liste-v=
on-"
-"Objekten"
+msgstr "git cat-file (--batch | --batch-check) [--follow-symlinks]"
=20
 #: builtin/cat-file.c:466
 msgid "<type> can be one of: blob, tree, commit, tag"
 msgstr "<Art> kann sein: blob, tree, commit, tag"
=20
 #: builtin/cat-file.c:467
 msgid "show object type"
@@ -3972,18 +3962,16 @@ msgid "show all objects with --batch or --batch=
-check"
 msgstr "alle Objekte mit --batch oder --batch-check anzeigen"
=20
 #: builtin/check-attr.c:11
 msgid "git check-attr [-a | --all | <attr>...] [--] <pathname>..."
 msgstr "git check-attr [-a | --all | <Attribut>...] [--] <Pfadname>...=
"
=20
 #: builtin/check-attr.c:12
-#, fuzzy
 msgid "git check-attr --stdin [-z] [-a | --all | <attr>...]"
-msgstr ""
-"git check-attr --stdin [-z] [-a | --all | <Attribut>...] < <Liste-von=
-Pfaden>"
+msgstr "git check-attr --stdin [-z] [-a | --all | <Attribut>...]"
=20
 #: builtin/check-attr.c:19
 msgid "report all attributes set on file"
 msgstr "alle Attribute einer Datei ausgeben"
=20
 #: builtin/check-attr.c:20
 msgid "use .gitattributes only from the index"
@@ -4697,17 +4685,18 @@ msgid "key=3Dvalue"
 msgstr "Schl=C3=BCssel=3DWert"
=20
 #: builtin/clone.c:94
 msgid "set config inside the new repository"
 msgstr "Konfiguration innerhalb des neuen Repositories setzen"
=20
 #: builtin/clone.c:300
-#, fuzzy, c-format
+#, c-format
 msgid "reference repository '%s' as a linked checkout is not supported=
 yet."
-msgstr "Referenziertes Repository '%s' ist kein lokales Repository."
+msgstr "Referenziertes Repository '%s' wird noch nicht als verkn=C3=BC=
pftes\n"
+"Arbeitsverzeichnis unterst=C3=BCtzt."
=20
 #: builtin/clone.c:302
 #, c-format
 msgid "reference repository '%s' is not a local repository."
 msgstr "Referenziertes Repository '%s' ist kein lokales Repository."
=20
 #: builtin/clone.c:307
@@ -6228,27 +6217,24 @@ msgid "file to read from"
 msgstr "Datei zum Einlesen"
=20
 #: builtin/for-each-ref.c:9
 msgid "git for-each-ref [<options>] [<pattern>]"
 msgstr "git for-each-ref [<Optionen>] [<Muster>]"
=20
 #: builtin/for-each-ref.c:10
-#, fuzzy
 msgid "git for-each-ref [--points-at <object>]"
-msgstr "git for-each-ref [<Optionen>] [<Muster>]"
+msgstr "git for-each-ref [--points-at <Objekt>]"
=20
 #: builtin/for-each-ref.c:11
-#, fuzzy
 msgid "git for-each-ref [(--merged | --no-merged) [<object>]]"
-msgstr "git branch [<Optionen>] [-r | -a] [--merged | --no-merged]"
+msgstr "git for-each-ref [(--merged | --no-merged) [<Objekt>]]"
=20
 #: builtin/for-each-ref.c:12
-#, fuzzy
 msgid "git for-each-ref [--contains [<object>]]"
-msgstr "git for-each-ref [<Optionen>] [<Muster>]"
+msgstr "git for-each-ref [--contains [<Objekt>]]"
=20
 #: builtin/for-each-ref.c:27
 msgid "quote placeholders suitably for shells"
 msgstr "Platzhalter als Shell-String formatieren"
=20
 #: builtin/for-each-ref.c:29
 msgid "quote placeholders suitably for perl"
@@ -6267,32 +6253,28 @@ msgid "show only <n> matched refs"
 msgstr "nur <n> passende Referenzen anzeigen"
=20
 #: builtin/for-each-ref.c:37 builtin/tag.c:372
 msgid "format to use for the output"
 msgstr "f=C3=BCr die Ausgabe zu verwendendes Format"
=20
 #: builtin/for-each-ref.c:41
-#, fuzzy
 msgid "print only refs which points at the given object"
-msgstr "nur Tags von dem Objekt ausgeben"
+msgstr "nur auf dieses Objekt zeigende Referenzen ausgeben"
=20
 #: builtin/for-each-ref.c:43
-#, fuzzy
 msgid "print only refs that are merged"
-msgstr "nur Branches ausgeben, welche diesen Commit beinhalten"
+msgstr "nur zusammengef=C3=BChrte Referenzen ausgeben"
=20
 #: builtin/for-each-ref.c:44
-#, fuzzy
 msgid "print only refs that are not merged"
-msgstr "nur Branches ausgeben, die nicht zusammengef=C3=BChrt sind"
+msgstr "nur nicht zusammengef=C3=BChrte Referenzen ausgeben"
=20
 #: builtin/for-each-ref.c:45
-#, fuzzy
 msgid "print only refs which contain the commit"
-msgstr "nur Branches ausgeben, welche diesen Commit beinhalten"
+msgstr "nur Referenzen ausgeben, die diesen Commit enthalten"
=20
 #: builtin/fsck.c:156 builtin/prune.c:140
 msgid "Checking connectivity"
 msgstr "Pr=C3=BCfe Konnektivit=C3=A4t"
=20
 #: builtin/fsck.c:486
 msgid "Checking object directories"
@@ -6369,14 +6351,20 @@ msgstr "zu langes Objekt-Verzeichnis %.*s"
 msgid ""
 "The last gc run reported the following. Please correct the root cause=
\n"
 "and remove %s.\n"
 "Automatic cleanup will not be performed until the file is removed.\n"
 "\n"
 "%s"
 msgstr ""
+"Die letzte Ausf=C3=BChrung von \"gc run\" enthielt die folgenden Meld=
ungen.\n"
+"Bitte beheben Sie das Hauptproblem und l=C3=B6schen Sie %s.\n"
+"Ein automatischer Cleanup wird nicht ausgef=C3=BChrt, bis diese Datei=
 entfernt\n"
+"wurde.\n"
+"\n"
+"%s"
=20
 #: builtin/gc.c:327
 msgid "prune unreferenced objects"
 msgstr "unreferenzierte Objekte entfernen"
=20
 #: builtin/gc.c:329
 msgid "be more thorough (increased runtime)"
@@ -6664,17 +6652,16 @@ msgid ""
 "git hash-object [-t <type>] [-w] [--path=3D<file> | --no-filters] [--=
stdin] "
 "[--] <file>..."
 msgstr ""
 "git hash-object [-t <Art>] [-w] [--path=3D<Datei> | --no-filters] [--=
stdin] "
 "[--] <Datei>..."
=20
 #: builtin/hash-object.c:81
-#, fuzzy
 msgid "git hash-object  --stdin-paths"
-msgstr "git hash-object  --stdin-paths < <Liste-von-Pfaden>"
+msgstr "git hash-object  --stdin-paths"
=20
 #: builtin/hash-object.c:92
 msgid "type"
 msgstr "Art"
=20
 #: builtin/hash-object.c:92
 msgid "object type"
@@ -7397,15 +7384,15 @@ msgstr "[PATCH] nicht entfernen/hinzuf=C3=BCgen=
"
=20
 #: builtin/log.c:1239
 msgid "don't output binary diffs"
 msgstr "keine bin=C3=A4ren Unterschiede ausgeben"
=20
 #: builtin/log.c:1241
 msgid "output all-zero hash in From header"
-msgstr ""
+msgstr "Hash mit Nullen in \"From\"-Header ausgeben"
=20
 #: builtin/log.c:1243
 msgid "don't include a patch matching a commit upstream"
 msgstr ""
 "keine Patches einschlie=C3=9Fen, die einem Commit im Upstream-Branch =
entsprechen"
=20
 #: builtin/log.c:1245
@@ -8825,20 +8812,18 @@ msgid "report pruned objects"
 msgstr "gel=C3=B6schte Objekte melden"
=20
 #: builtin/prune.c:109 builtin/worktree.c:127
 msgid "expire objects older than <time>"
 msgstr "Objekte =C3=A4lter als <Zeit> verfallen lassen"
=20
 #: builtin/prune.c:123
-#, fuzzy
 msgid "cannot prune in a precious-objects repo"
-msgstr "Kann existierendes Objekt %s nicht lesen."
+msgstr "kann \"prune\" in precious-objects Repository nicht ausf=C3=BC=
hren"
=20
 #: builtin/pull.c:69
-#, fuzzy
 msgid "git pull [<options>] [<repository> [<refspec>...]]"
 msgstr "git pull [<Optionen>] [<Repository> [<Refspec>...]]"
=20
 #: builtin/pull.c:113
 msgid "Options related to merging"
 msgstr "Optionen bezogen auf Merge"
=20
@@ -9300,17 +9285,16 @@ msgid "refname>:<expect"
 msgstr "Referenzname>:<Erwartungswert"
=20
 #: builtin/push.c:548 builtin/send-pack.c:176
 msgid "require old value of ref to be at this value"
 msgstr "Referenz muss sich auf dem angegebenen Wert befinden"
=20
 #: builtin/push.c:550
-#, fuzzy
 msgid "check|on-demand|no"
-msgstr "bei-Bedarf"
+msgstr "check|on-demand|no"
=20
 #: builtin/push.c:551
 msgid "control recursive pushing of submodules"
 msgstr "rekursiven \"push\" von Submodulen steuern"
=20
 #: builtin/push.c:553 builtin/send-pack.c:169
 msgid "use thin pack"
@@ -9477,17 +9461,16 @@ msgstr ""
 "git remote [-v | --verbose] update [-p | --prune] [(<Gruppe> | <Remot=
e>)...]"
=20
 #: builtin/remote.c:20
 msgid "git remote set-branches [--add] <name> <branch>..."
 msgstr "git remote set-branches [--add] <Name> <Branch>..."
=20
 #: builtin/remote.c:21 builtin/remote.c:70
-#, fuzzy
 msgid "git remote get-url [--push] [--all] <name>"
-msgstr "git remote set-url [--push] <Name> <neueURL> [<alteURL>]"
+msgstr "git remote get-url [--push] [--all] <Name>"
=20
 #: builtin/remote.c:22 builtin/remote.c:75
 msgid "git remote set-url [--push] <name> <newurl> [<oldurl>]"
 msgstr "git remote set-url [--push] <Name> <neueURL> [<alteURL>]"
=20
 #: builtin/remote.c:23 builtin/remote.c:76
 msgid "git remote set-url --add <name> <newurl>"
@@ -9903,24 +9886,24 @@ msgstr "Branch hinzuf=C3=BCgen"
=20
 #: builtin/remote.c:1468
 msgid "no remote specified"
 msgstr "kein Remote-Repository angegeben"
=20
 #: builtin/remote.c:1485
 msgid "query push URLs rather than fetch URLs"
-msgstr ""
+msgstr "nur URLs f=C3=BCr Push ausgeben"
=20
 #: builtin/remote.c:1487
 msgid "return all URLs"
-msgstr ""
+msgstr "alle URLs ausgeben"
=20
 #: builtin/remote.c:1515
-#, fuzzy, c-format
+#, c-format
 msgid "no URLs configured for remote '%s'"
-msgstr "Kein Upstream-Branch f=C3=BCr Branch '%s' konfiguriert."
+msgstr "Keine URLs f=C3=BCr Remote-Repository '%s' konfiguriert."
=20
 #: builtin/remote.c:1541
 msgid "manipulate push URLs"
 msgstr "URLs f=C3=BCr \"push\" manipulieren"
=20
 #: builtin/remote.c:1543
 msgid "add URL"
@@ -10022,15 +10005,15 @@ msgstr "maximale Gr=C3=B6=C3=9Fe f=C3=BCr jed=
e Paketdatei"
 #: builtin/repack.c:187
 msgid "repack objects in packs marked with .keep"
 msgstr ""
 "Objekte umpacken, die sich in mit .keep markierten Pack-Dateien befin=
den"
=20
 #: builtin/repack.c:197
 msgid "cannot delete packs in a precious-objects repo"
-msgstr ""
+msgstr "kann Pack-Dateien in precious-objects Repository nicht l=C3=B6=
schen"
=20
 #: builtin/repack.c:381
 #, c-format
 msgid "removing '%s' failed"
 msgstr "L=C3=B6schen von '%s' fehlgeschlagen"
=20
 #: builtin/replace.c:19
@@ -10628,17 +10611,16 @@ msgid ""
 "git show-ref [-q | --quiet] [--verify] [--head] [-d | --dereference] =
[-s | --"
 "hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags] [--heads] [--] [<pattern>..=
=2E]"
 msgstr ""
 "git show-ref [-q | --quiet] [--verify] [--head] [-d | --dereference] =
[-s | --"
 "hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags] [--heads] [--] [<Muster>...=
] "
=20
 #: builtin/show-ref.c:11
-#, fuzzy
 msgid "git show-ref --exclude-existing[=3D<pattern>]"
-msgstr "git show-ref --exclude-existing[=3D<Muster>] < <Referenzliste>=
"
+msgstr "git show-ref --exclude-existing[=3D<Muster>]"
=20
 #: builtin/show-ref.c:165
 msgid "only show tags (can be combined with heads)"
 msgstr "nur Tags anzeigen (kann mit \"heads\" kombiniert werden)"
=20
 #: builtin/show-ref.c:166
 msgid "only show heads (can be combined with tags)"
@@ -10670,104 +10652,104 @@ msgstr ""
 msgid "show refs from stdin that aren't in local repository"
 msgstr ""
 "Referenzen von der Standard-Eingabe anzeigen, die sich nicht im lokal=
en "
 "Repository befinden"
=20
 #: builtin/stripspace.c:17
 msgid "git stripspace [-s | --strip-comments]"
-msgstr ""
+msgstr "git stripspace [-s | --strip-comments]"
=20
 #: builtin/stripspace.c:18
 msgid "git stripspace [-c | --comment-lines]"
-msgstr ""
+msgstr "git stripspace [-c | --comment-lines]"
=20
 #: builtin/stripspace.c:35
 msgid "skip and remove all lines starting with comment character"
-msgstr ""
+msgstr "alle Zeilen, die mit dem Kommentarzeichen beginnen, =C3=BCbers=
pringen und "
+"entfernen"
=20
 #: builtin/stripspace.c:38
 msgid "prepend comment character and blank to each line"
-msgstr ""
+msgstr "Kommentarzeichen mit Leerzeichen an jeder Zeile voranstellen"
=20
 #: builtin/submodule--helper.c:79 builtin/submodule--helper.c:167
 msgid "alternative anchor for relative paths"
-msgstr ""
+msgstr "Alternativer Anker f=C3=BCr relative Pfade"
=20
 #: builtin/submodule--helper.c:84
 msgid "git submodule--helper list [--prefix=3D<path>] [<path>...]"
-msgstr ""
+msgstr "git submodule--helper list [--prefix=3D<Pfad>] [<Pfad>...]"
=20
 #: builtin/submodule--helper.c:114
 msgid "git submodule--helper name <path>"
-msgstr ""
+msgstr "git submodule--helper name <Pfad>"
=20
 #: builtin/submodule--helper.c:120
-#, fuzzy, c-format
+#, c-format
 msgid "no submodule mapping found in .gitmodules for path '%s'"
-msgstr "Keine Submodul-Zuordnung in .gitmodules f=C3=BCr Pfad '$sm_pat=
h' gefunden"
+msgstr "Keine Submodul-Zuordnung in .gitmodules f=C3=BCr Pfad '%s' gef=
unden"
=20
 #: builtin/submodule--helper.c:170
 msgid "where the new submodule will be cloned to"
-msgstr ""
+msgstr "Pfad f=C3=BCr neues Submodul"
=20
 #: builtin/submodule--helper.c:173
-#, fuzzy
 msgid "name of the new submodule"
-msgstr "Aktualisierung: ignoriert Submodule"
+msgstr "Name des neuen Submoduls"
=20
 #: builtin/submodule--helper.c:176
 msgid "url where to clone the submodule from"
-msgstr ""
+msgstr "URL von der das Submodul geklont wird"
=20
 #: builtin/submodule--helper.c:182
-#, fuzzy
 msgid "depth for shallow clones"
-msgstr ""
-"die Historie eines Klons mit unvollst=C3=A4ndiger Historie (shallow) =
vertiefen"
+msgstr "Tiefe des Klons mit unvollst=C3=A4ndiger Historie (shallow)"
=20
 #: builtin/submodule--helper.c:188
 msgid ""
 "git submodule--helper clone [--prefix=3D<path>] [--quiet] [--referenc=
e "
 "<repository>] [--name <name>] [--url <url>][--depth <depth>] [--] [<p=
ath>...]"
 msgstr ""
+"git submodule--helper clone [--prefix=3D<Pfad>] [--quiet] [--referenc=
e "
+"<Repository>] [--name <Name>] [--url <URL>][--depth <Tiefe>] [--] [<P=
fad>...]"
=20
 #: builtin/submodule--helper.c:202 builtin/submodule--helper.c:208
 #: builtin/submodule--helper.c:216
-#, fuzzy, c-format
+#, c-format
 msgid "could not create directory '%s'"
 msgstr "Konnte Verzeichnis '%s' nicht erstellen."
=20
 #: builtin/submodule--helper.c:204
-#, fuzzy, c-format
+#, c-format
 msgid "clone of '%s' into submodule path '%s' failed"
-msgstr "Klonen von '$url' in Submodul-Pfad '$sm_path' fehlgeschlagen"
+msgstr "Klonen von '%s' in Submodul-Pfad '%s' fehlgeschlagen"
=20
 #: builtin/submodule--helper.c:227
-#, fuzzy, c-format
+#, c-format
 msgid "cannot open file '%s'"
-msgstr "Kann Paketdatei '%s' nicht =C3=B6ffnen"
+msgstr "Kann Datei '%s' nicht =C3=B6ffnen"
=20
 #: builtin/submodule--helper.c:232
-#, fuzzy, c-format
+#, c-format
 msgid "could not close file %s"
-msgstr "Konnte '%s' nicht schlie=C3=9Fen."
+msgstr "Konnte Datei '%s' nicht schlie=C3=9Fen."
=20
 #: builtin/submodule--helper.c:247
-#, fuzzy, c-format
+#, c-format
 msgid "could not get submodule directory for '%s'"
-msgstr "Konnte Verzeichnis '%s' nicht erstellen."
+msgstr "Konnte Submodul-Verzeichnis '%s' nicht finden."
=20
 #: builtin/submodule--helper.c:273
 msgid "fatal: submodule--helper subcommand must be called with a subco=
mmand"
-msgstr ""
+msgstr "fatal: submodule-helper muss mit einem Unterkommando aufgerufe=
n werden"
=20
 #: builtin/submodule--helper.c:280
 #, c-format
 msgid "fatal: '%s' is not a valid submodule--helper subcommand"
-msgstr ""
+msgstr "fatal: '%s' ist kein g=C3=BCltiges Unterkommando von submodule=
-helper"
=20
 #: builtin/symbolic-ref.c:7
 msgid "git symbolic-ref [<options>] <name> [<ref>]"
 msgstr "git symbolic-ref [<Optionen>] <Name> [<Referenz>]"
=20
 #: builtin/symbolic-ref.c:8
 msgid "git symbolic-ref -d [-q] <name>"
@@ -10803,21 +10785,20 @@ msgstr ""
 "<Tagname> [<Commit>]"
=20
 #: builtin/tag.c:24
 msgid "git tag -d <tagname>..."
 msgstr "git tag -d <Tagname>..."
=20
 #: builtin/tag.c:25
-#, fuzzy
 msgid ""
 "git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]\n=
"
 "\t\t[--format=3D<format>] [--[no-]merged [<commit>]] [<pattern>...]"
 msgstr ""
 "git tag -l [-n[<Nummer>]] [--contains <Commit>] [--points-at <Objekt>=
]\n"
-"\t\t[<Muster>...]"
+"\t\t[--format=3D<Muster>] [--[no-]merged [<Commit>]] [<Muster>...]"
=20
 #: builtin/tag.c:27
 msgid "git tag -v <tagname>..."
 msgstr "git tag -v <Tagname>..."
=20
 #: builtin/tag.c:80
 #, c-format
@@ -10945,22 +10926,20 @@ msgid "show tag list in columns"
 msgstr "Liste der Tags in Spalten anzeigen"
=20
 #: builtin/tag.c:362 builtin/tag.c:363
 msgid "print only tags that contain the commit"
 msgstr "nur Tags ausgeben, die diesen Commit beinhalten"
=20
 #: builtin/tag.c:364
-#, fuzzy
 msgid "print only tags that are merged"
-msgstr "nur Tags ausgeben, die diesen Commit beinhalten"
+msgstr "nur Tags ausgeben, die gemerged wurden"
=20
 #: builtin/tag.c:365
-#, fuzzy
 msgid "print only tags that are not merged"
-msgstr "nur Tags ausgeben, die diesen Commit beinhalten"
+msgstr "nur Tags ausgeben, die nicht gemerged wurden"
=20
 #: builtin/tag.c:370
 msgid "print only tags of the object"
 msgstr "nur Tags von dem Objekt ausgeben"
=20
 #: builtin/tag.c:399
 msgid "--column and -n are incompatible"
@@ -10975,17 +10954,16 @@ msgid "--contains option is only allowed with=
 -l."
 msgstr "--contains Option ist nur erlaubt mit -l."
=20
 #: builtin/tag.c:423
 msgid "--points-at option is only allowed with -l."
 msgstr "--points-at Option ist nur erlaubt mit -l."
=20
 #: builtin/tag.c:425
-#, fuzzy
 msgid "--merged and --no-merged option are only allowed with -l"
-msgstr "-n Option ist nur erlaubt mit -l."
+msgstr "Die Optionen --merged und --no-merged sind nur mit -l erlaubt.=
"
=20
 #: builtin/tag.c:433
 msgid "only one -F or -m option is allowed."
 msgstr "nur eine -F oder -m Option ist erlaubt."
=20
 #: builtin/tag.c:453
 msgid "too many params"
@@ -11276,26 +11254,24 @@ msgid "git verify-tag [-v | --verbose] <tag>.=
=2E."
 msgstr "git verify-tag [-v | --verbose] <Tag>..."
=20
 #: builtin/verify-tag.c:83
 msgid "print tag contents"
 msgstr "Tag-Inhalte ausgeben"
=20
 #: builtin/worktree.c:15
-#, fuzzy
 msgid "git worktree add [<options>] <path> [<branch>]"
-msgstr "git worktree add [<Optionen>] <Pfad> <Branch>"
+msgstr "git worktree add [<Optionen>] <Pfad> [<Branch>]"
=20
 #: builtin/worktree.c:16
 msgid "git worktree prune [<options>]"
 msgstr "git worktree prune [<Optionen>]"
=20
 #: builtin/worktree.c:17
-#, fuzzy
 msgid "git worktree list [<options>]"
-msgstr "git worktree prune [<Optionen>]"
+msgstr "git worktree list [<Optionen>]"
=20
 #: builtin/worktree.c:39
 #, c-format
 msgid "Removing worktrees/%s: not a valid directory"
 msgstr "L=C3=B6sche worktrees/%s: kein g=C3=BCltiges Verzeichnis"
=20
 #: builtin/worktree.c:45
@@ -11692,48 +11668,50 @@ msgstr ""
=20
 #: git-bisect.sh:538
 msgid "bisect run success"
 msgstr "'bisect run' erfolgreich ausgef=C3=BChrt"
=20
 #: git-bisect.sh:565
 msgid "please use two different terms"
-msgstr ""
+msgstr "Bitte verwenden Sie zwei verschiedene Begriffe."
=20
 #: git-bisect.sh:575
-#, fuzzy, sh-format
+#, sh-format
 msgid "'$term' is not a valid term"
-msgstr "'%s' ist kein g=C3=BCltiger Zeitstempel"
+msgstr "'$term' ist kein g=C3=BCltiger Begriff"
=20
 #: git-bisect.sh:578
 #, sh-format
 msgid "can't use the builtin command '$term' as a term"
-msgstr ""
+msgstr "Kann eingebautes Kommando '$term' nicht als Begriff verwenden"
=20
 #: git-bisect.sh:587 git-bisect.sh:593
 #, sh-format
 msgid "can't change the meaning of term '$term'"
-msgstr ""
+msgstr "Kann Bedeutung von '$term' nicht =C3=A4ndern."
=20
 #: git-bisect.sh:606
 #, sh-format
 msgid "Invalid command: you're currently in a $TERM_BAD/$TERM_GOOD bis=
ect."
 msgstr ""
 "Ung=C3=BCltiges Kommando: Sie sind gerade bei einer bin=C3=A4ren $TER=
M_BAD/$TERM_GOOD "
 "Suche."
=20
 #: git-bisect.sh:636
 msgid "no terms defined"
-msgstr ""
+msgstr "Keine Begriffe definiert."
=20
 #: git-bisect.sh:653
 #, sh-format
 msgid ""
 "invalid argument $arg for 'git bisect terms'.\n"
 "Supported options are: --term-good|--term-old and --term-bad|--term-n=
ew."
 msgstr ""
+"Ung=C3=BCltiges Argument $arg f=C3=BCr 'git bisect terms'.\n"
+"Unterst=C3=BCtzte Optionen sind: --term-good|--term-old und --term-ba=
d|--term-new."
=20
 #: git-rebase.sh:57
 msgid ""
 "When you have resolved this problem, run \"git rebase --continue\".\n=
"
 "If you prefer to skip this patch, run \"git rebase --skip\" instead.\=
n"
 "To check out the original branch and stop rebasing, run \"git rebase =
--abort"
 "\"."
--=20
2.7.0.rc2.212.g788e337
