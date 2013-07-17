From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCHv3 2/3] l10n: de.po: switch from pure German to German+English (part 2)
Date: Wed, 17 Jul 2013 07:51:18 +0200
Message-ID: <1374040279-4828-3-git-send-email-ralf.thielow@gmail.com>
References: <87bo631odi.fsf@hexa.v.cablecom.net>
 <1374040279-4828-1-git-send-email-ralf.thielow@gmail.com>
 <1374040279-4828-2-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jk@jk.gs, stimming@tuhh.de, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: trast@inf.ethz.ch
X-From: git-owner@vger.kernel.org Wed Jul 17 07:51:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzKeO-0003Se-25
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 07:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047Ab3GQFvj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jul 2013 01:51:39 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:37032 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab3GQFve (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 01:51:34 -0400
Received: by mail-ee0-f42.google.com with SMTP id c4so806640eek.1
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 22:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XJ7yqo1Wzbhp9iHR6o+mpiLIjrFUZ6H2ztSzy0be5c8=;
        b=psSAh8GT9oDLDHwzyFY577zdrZ/HGHuzLy+lmouHvewK4+aTF6Vj/xwXuTjM+KwK/F
         7T1IIqWIlXnkXFPZ5DwQD6gRQTTwcwzrFj3yunKyoRBWE+yHBoTlYGi3pQMcel1p1T+q
         4QEjLlO4GzgKpA33nbbXd7ixsvG1aeMp9/spoOCYWMWhTgPkKHMLJvFjrc4yhtl2S2lI
         K0VSo7k7o9MuWpaa338aBFdgrm7qw1JwApShwpEoyrvkQ5ShaxbqpwgfYXatifIbBzLQ
         O9s5F/WU57Co1vjHo/zaWM3Wx/hnakFp9igKEf4QASJvSPFW8rDzJs5XI1/Afoz7b+yi
         DiqQ==
X-Received: by 10.15.23.73 with SMTP id g49mr4801761eeu.8.1374040292895;
        Tue, 16 Jul 2013 22:51:32 -0700 (PDT)
Received: from localhost (dslb-188-103-254-174.pools.arcor-ip.net. [188.103.254.174])
        by mx.google.com with ESMTPSA id n42sm7877542eeh.15.2013.07.16.22.51.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 22:51:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1230.g519726a
In-Reply-To: <1374040279-4828-2-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230603>

This switches the translation from pure German to German+English.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 575 +++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 284 insertions(+), 291 deletions(-)

diff --git a/po/de.po b/po/de.po
index be45a88..2e0496b 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1459,7 +1459,7 @@ msgstr "Sie teilen gerade einen Commit w=C3=A4hre=
nd eines Rebase auf."
 #: wt-status.c:930
 msgid "  (Once your working directory is clean, run \"git rebase --con=
tinue\")"
 msgstr ""
-"  (Sobald Ihr Arbeitsverzeichnis sauber ist, f=C3=BChren Sie \"git re=
base --"
+"  (Sobald Ihr Arbeitsverzeichnis unver=C3=A4ndert ist, f=C3=BChren Si=
e \"git rebase --"
 "continue\" aus)"
=20
 #: wt-status.c:934
@@ -1628,7 +1628,7 @@ msgstr ""
 #: wt-status.c:1267
 #, c-format
 msgid "nothing to commit, working directory clean\n"
-msgstr "nichts zu committen, Arbeitsverzeichnis sauber\n"
+msgstr "nichts zu committen, Arbeitsverzeichnis unver=C3=A4ndert\n"
=20
 #: wt-status.c:1375
 msgid "HEAD (no branch)"
@@ -3339,7 +3339,7 @@ msgstr "erzwingt Auschecken (verwirft lokale =C3=84=
nderungen)"
=20
 #: builtin/checkout.c:1059
 msgid "perform a 3-way merge with the new branch"
-msgstr "f=C3=BChrt eine 3-Wege-Zusammenf=C3=BChrung mit dem neuen Zwei=
g aus"
+msgstr "f=C3=BChrt einen 3-Wege-Merge mit dem neuen Branch aus"
=20
 #: builtin/checkout.c:1060 builtin/merge.c:217
 msgid "update ignored files (default)"
@@ -3367,11 +3367,11 @@ msgstr "Die Optionen -b, -B und --orphan schlie=
=C3=9Fen sich gegenseitig aus."
=20
 #: builtin/checkout.c:1108
 msgid "--track needs a branch name"
-msgstr "Bei der Option --track muss ein Zweigname angegeben werden."
+msgstr "Bei der Option --track muss ein Branchname angegeben werden."
=20
 #: builtin/checkout.c:1115
 msgid "Missing branch name; try -b"
-msgstr "Vermisse Zweignamen; versuchen Sie -b"
+msgstr "Vermisse Branchnamen; versuchen Sie -b"
=20
 #: builtin/checkout.c:1150
 msgid "invalid path specification"
@@ -3383,8 +3383,8 @@ msgid ""
 "Cannot update paths and switch to branch '%s' at the same time.\n"
 "Did you intend to checkout '%s' which can not be resolved as commit?"
 msgstr ""
-"Kann nicht gleichzeitig Pfade aktualisieren und zu Zweig '%s' wechsel=
n.\n"
-"Haben Sie beabsichtigt '%s' auszuchecken, welcher nicht als Version "
+"Kann nicht gleichzeitig Pfade aktualisieren und zu Branch '%s' wechse=
ln.\n"
+"Haben Sie beabsichtigt '%s' auszuchecken, welcher nicht als Commit "
 "aufgel=C3=B6st werden kann?"
=20
 #: builtin/checkout.c:1162
@@ -3398,7 +3398,7 @@ msgid ""
 "checking out of the index."
 msgstr ""
 "git checkout: --ours/--theirs, --force und --merge sind inkompatibel =
wenn\n"
-"Sie aus der Bereitstellung auschecken."
+"Sie aus der Staging-Area auschecken."
=20
 #: builtin/clean.c:20
 msgid "git clean [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <pa=
ths>..."
@@ -3417,12 +3417,12 @@ msgstr "W=C3=BCrde %s l=C3=B6schen\n"
 #: builtin/clean.c:26
 #, c-format
 msgid "Skipping repository %s\n"
-msgstr "=C3=9Cberspringe Projektarchiv %s\n"
+msgstr "=C3=9Cberspringe Repository %s\n"
=20
 #: builtin/clean.c:27
 #, c-format
 msgid "Would skip repository %s\n"
-msgstr "W=C3=BCrde Projektarchiv %s =C3=BCberspringen\n"
+msgstr "W=C3=BCrde Repository %s =C3=BCberspringen\n"
=20
 #: builtin/clean.c:28
 #, c-format
@@ -3467,7 +3467,7 @@ msgid ""
 "clean.requireForce set to true and neither -n nor -f given; refusing =
to clean"
 msgstr ""
 "clean.requireForce auf \"true\" gesetzt und weder -n noch -f gegeben;=
 "
-"S=C3=A4uberung verweigert"
+"\"clean\" verweigert"
=20
 #: builtin/clean.c:194
 msgid ""
@@ -3475,11 +3475,11 @@ msgid ""
 "clean"
 msgstr ""
 "clean.requireForce standardm=C3=A4=C3=9Fig auf \"true\" gesetzt und w=
eder -n noch -f "
-"gegeben; S=C3=A4uberung verweigert"
+"gegeben; \"clean\" verweigert"
=20
 #: builtin/clone.c:37
 msgid "git clone [options] [--] <repo> [<dir>]"
-msgstr "git clone [Optionen] [--] <Projektarchiv> [<Verzeichnis>]"
+msgstr "git clone [Optionen] [--] <Repository> [<Verzeichnis>]"
=20
 #: builtin/clone.c:65 builtin/fetch.c:82 builtin/merge.c:214
 #: builtin/push.c:436
@@ -3492,23 +3492,23 @@ msgstr "kein Auschecken"
=20
 #: builtin/clone.c:68 builtin/clone.c:70 builtin/init-db.c:488
 msgid "create a bare repository"
-msgstr "erstellt ein blo=C3=9Fes Projektarchiv"
+msgstr "erstellt ein Bare-Repository"
=20
 #: builtin/clone.c:73
 msgid "create a mirror repository (implies bare)"
-msgstr "erstellt ein Spiegelarchiv (impliziert blo=C3=9Fes Projektarch=
iv)"
+msgstr "erstellt ein Spiegelarchiv (impliziert --bare)"
=20
 #: builtin/clone.c:75
 msgid "to clone from a local repository"
-msgstr "um von einem lokalen Projektarchiv zu klonen"
+msgstr "um von einem lokalen Repository zu klonen"
=20
 #: builtin/clone.c:77
 msgid "don't use local hardlinks, always copy"
-msgstr "verwendet lokal keine harten Links, immer Kopien"
+msgstr "verwendet lokal keine harten Verweise, immer Kopien"
=20
 #: builtin/clone.c:79
 msgid "setup as shared repository"
-msgstr "Einrichtung als verteiltes Projektarchiv"
+msgstr "Einrichtung als verteiltes Repository"
=20
 #: builtin/clone.c:81 builtin/clone.c:83
 msgid "initialize submodules in the clone"
@@ -3524,7 +3524,7 @@ msgstr "Verzeichnis, von welchem die Vorlagen ver=
wendet werden"
=20
 #: builtin/clone.c:87
 msgid "reference repository"
-msgstr "referenziert Projektarchiv"
+msgstr "referenziert Repository"
=20
 #: builtin/clone.c:88 builtin/column.c:26 builtin/merge-file.c:44
 msgid "name"
@@ -3532,12 +3532,12 @@ msgstr "Name"
=20
 #: builtin/clone.c:89
 msgid "use <name> instead of 'origin' to track upstream"
-msgstr "verwendet <Name> statt 'origin' f=C3=BCr externes Projektarchi=
v"
+msgstr "verwendet <Name> statt 'origin' f=C3=BCr Upstream-Repository"
=20
 #: builtin/clone.c:91
 msgid "checkout <branch> instead of the remote's HEAD"
 msgstr ""
-"checkt <Zweig> aus, anstatt Zweigspitze (HEAD) des externen Projektar=
chivs"
+"checkt <Branch> aus, anstatt HEAD des Remote-Repositories"
=20
 #: builtin/clone.c:93
 msgid "path to git-upload-pack on the remote"
@@ -3553,7 +3553,7 @@ msgstr "erstellt einen flachen Klon mit dieser Ti=
efe"
=20
 #: builtin/clone.c:97
 msgid "clone only one branch, HEAD or --branch"
-msgstr "klont nur einen Zweig, Zweigspitze (HEAD) oder --branch"
+msgstr "klont nur einen Branch, HEAD oder --branch"
=20
 #: builtin/clone.c:98 builtin/init-db.c:494
 msgid "gitdir"
@@ -3561,7 +3561,7 @@ msgstr ".git-Verzeichnis"
=20
 #: builtin/clone.c:99 builtin/init-db.c:495
 msgid "separate git dir from working tree"
-msgstr "separiert Git-Verzeichnis vom Arbeitsbaum"
+msgstr "separiert Git-Verzeichnis vom Arbeitsverzeichnis"
=20
 #: builtin/clone.c:100
 msgid "key=3Dvalue"
@@ -3569,12 +3569,12 @@ msgstr "Schl=C3=BCssel=3DWert"
=20
 #: builtin/clone.c:101
 msgid "set config inside the new repository"
-msgstr "setzt Konfiguration innerhalb des neuen Projektarchivs"
+msgstr "setzt Konfiguration innerhalb des neuen Repositories"
=20
 #: builtin/clone.c:254
 #, c-format
 msgid "reference repository '%s' is not a local repository."
-msgstr "Referenziertes Projektarchiv '%s' ist kein lokales Projektarch=
iv."
+msgstr "Referenziertes Repository '%s' ist kein lokales Repository."
=20
 #: builtin/clone.c:317
 #, c-format
@@ -3599,7 +3599,7 @@ msgstr "Konnte %s nicht lesen\n"
 #: builtin/clone.c:357
 #, c-format
 msgid "failed to create link '%s'"
-msgstr "Konnte Verkn=C3=BCpfung '%s' nicht erstellen"
+msgstr "Konnte Verweis '%s' nicht erstellen"
=20
 #: builtin/clone.c:361
 #, c-format
@@ -3624,21 +3624,21 @@ msgstr ""
 #: builtin/clone.c:476
 #, c-format
 msgid "Could not find remote branch %s to clone."
-msgstr "Konnte zu klonenden externer Zweig %s nicht finden."
+msgstr "Konnte zu klonenden Remote-Branch %s nicht finden."
=20
 #: builtin/clone.c:550
 msgid "remote did not send all necessary objects"
-msgstr "Fernarchiv hat nicht alle erforderlichen Objekte gesendet."
+msgstr "Remote-Repository hat nicht alle erforderlichen Objekte gesend=
et."
=20
 #: builtin/clone.c:610
 msgid "remote HEAD refers to nonexistent ref, unable to checkout.\n"
 msgstr ""
-"Externe Zweigspitze (HEAD) bezieht sich auf eine nicht existierende R=
eferenz "
+"Externer HEAD bezieht sich auf eine nicht existierende Referenz "
 "und kann nicht ausgecheckt werden.\n"
=20
 #: builtin/clone.c:641
 msgid "unable to checkout working tree"
-msgstr "Arbeitsbaum konnte nicht ausgecheckt werden"
+msgstr "Arbeitsverzeichnis konnte nicht ausgecheckt werden"
=20
 #: builtin/clone.c:749
 msgid "Too many arguments."
@@ -3646,7 +3646,7 @@ msgstr "Zu viele Argumente."
=20
 #: builtin/clone.c:753
 msgid "You must specify a repository to clone."
-msgstr "Sie m=C3=BCssen ein Projektarchiv zum Klonen angeben."
+msgstr "Sie m=C3=BCssen ein Repository zum Klonen angeben."
=20
 #: builtin/clone.c:764
 #, c-format
@@ -3660,7 +3660,7 @@ msgstr "Die Optionen --bare und --separate-git-di=
r sind inkompatibel."
 #: builtin/clone.c:780
 #, c-format
 msgid "repository '%s' does not exist"
-msgstr "Projektarchiv '%s' existiert nicht."
+msgstr "Repository '%s' existiert nicht."
=20
 #: builtin/clone.c:785
 msgid "--depth is ignored in local clones; use file:// instead."
@@ -3676,7 +3676,7 @@ msgstr "Zielpfad '%s' existiert bereits und ist k=
ein leeres Verzeichnis."
 #: builtin/clone.c:805
 #, c-format
 msgid "working tree '%s' already exists."
-msgstr "Arbeitsbaum '%s' existiert bereits."
+msgstr "Arbeitsverzeichnis '%s' existiert bereits."
=20
 #: builtin/clone.c:818 builtin/clone.c:830
 #, c-format
@@ -3691,7 +3691,7 @@ msgstr "Konnte Arbeitsverzeichnis '%s' nicht erst=
ellen."
 #: builtin/clone.c:840
 #, c-format
 msgid "Cloning into bare repository '%s'...\n"
-msgstr "Klone in blo=C3=9Fes Projektarchiv '%s'...\n"
+msgstr "Klone in Bare-Repository '%s'...\n"
=20
 #: builtin/clone.c:842
 #, c-format
@@ -3706,11 +3706,11 @@ msgstr "Wei=C3=9F nicht wie %s zu klonen ist."
 #: builtin/clone.c:926
 #, c-format
 msgid "Remote branch %s not found in upstream %s"
-msgstr "externer Zweig %s nicht im anderen Projektarchiv %s gefunden"
+msgstr "Remote-Branch %s nicht im Upstream-Repository %s gefunden"
=20
 #: builtin/clone.c:933
 msgid "You appear to have cloned an empty repository."
-msgstr "Sie scheinen ein leeres Projektarchiv geklont zu haben."
+msgstr "Sie scheinen ein leeres Repository geklont zu haben."
=20
 #: builtin/column.c:9
 msgid "git column [options]"
@@ -3773,7 +3773,7 @@ msgstr ""
 "    git config --global user.name \"Ihr Name\"\n"
 "    git config --global user.email ihre@emailadresse.de\n"
 "\n"
-"Nachdem Sie das getan hast, k=C3=B6nnen Sie Ihre Identit=C3=A4t f=C3=BC=
r diese Version "
+"Nachdem Sie das getan hast, k=C3=B6nnen Sie Ihre Identit=C3=A4t f=C3=BC=
r diesen Commit "
 "=C3=A4ndern mit:\n"
 "\n"
 "    git commit --amend --reset-author\n"
@@ -3784,9 +3784,9 @@ msgid ""
 "it empty. You can repeat your command with --allow-empty, or you can\=
n"
 "remove the commit entirely with \"git reset HEAD^\".\n"
 msgstr ""
-"Sie fragten die j=C3=BCngste Version nachzubessern, aber das w=C3=BCr=
de diese leer\n"
-"machen. Sie k=C3=B6nnen Ihr Kommando mit --allow-empty wiederholen, o=
der die\n"
-"Version mit \"git reset HEAD^\" vollst=C3=A4ndig entfernen.\n"
+"Sie fragten den j=C3=BCngsten Commit nachzubessern, aber das w=C3=BCr=
de diesen leer\n"
+"machen. Sie k=C3=B6nnen Ihr Kommando mit --allow-empty wiederholen, o=
der diesen\n"
+"Commit mit \"git reset HEAD^\" vollst=C3=A4ndig entfernen.\n"
=20
 #: builtin/commit.c:61
 msgid ""
@@ -3799,7 +3799,7 @@ msgid ""
 msgstr ""
 "Der letzte \"cherry-pick\" ist jetzt leer, m=C3=B6glicherweise durch =
eine "
 "Konfliktaufl=C3=B6sung.\n"
-"Wenn Sie dies trotzdem eintragen wollen, benutzen Sie:\n"
+"Wenn Sie dies trotzdem committen wollen, benutzen Sie:\n"
 "\n"
 "    git commit --allow-empty\n"
 "\n"
@@ -3807,11 +3807,11 @@ msgstr ""
=20
 #: builtin/commit.c:260
 msgid "failed to unpack HEAD tree object"
-msgstr "Fehler beim Entpacken des Baum-Objektes der Zweigspitze (HEAD)=
=2E"
+msgstr "Fehler beim Entpacken des \"Tree\"-Objektes von HEAD."
=20
 #: builtin/commit.c:302
 msgid "unable to create temporary index"
-msgstr "Konnte tempor=C3=A4re Bereitstellung nicht erstellen."
+msgstr "Konnte tempor=C3=A4re Staging-Area nicht erstellen."
=20
 #: builtin/commit.c:308
 msgid "interactive add failed"
@@ -3824,27 +3824,25 @@ msgstr "Konnte new_index Datei nicht schreiben"
 #: builtin/commit.c:393
 msgid "cannot do a partial commit during a merge."
 msgstr ""
-"Kann keine partielle Eintragung durchf=C3=BChren, w=C3=A4hrend eine Z=
usammenf=C3=BChrung im "
-"Gange ist."
+"Kann keinen Teil-Commit durchf=C3=BChren, w=C3=A4hrend ein Merge im G=
ange ist."
=20
 #: builtin/commit.c:395
 msgid "cannot do a partial commit during a cherry-pick."
 msgstr ""
-"Kann keine partielle Eintragung durchf=C3=BChren, w=C3=A4hrend \"cher=
ry-pick\" im "
-"Gange ist."
+"Kann keinen Teil-Commit durchf=C3=BChren, w=C3=A4hrend \"cherry-pick\=
" im Gange ist."
=20
 #: builtin/commit.c:405
 msgid "cannot read the index"
-msgstr "Kann Bereitstellung nicht lesen"
+msgstr "Kann Staging-Area nicht lesen"
=20
 #: builtin/commit.c:425
 msgid "unable to write temporary index file"
-msgstr "Konnte tempor=C3=A4re Bereitstellungsdatei nicht schreiben."
+msgstr "Konnte tempor=C3=A4re Staging-Area-Datei nicht schreiben."
=20
 #: builtin/commit.c:513 builtin/commit.c:519
 #, c-format
 msgid "invalid commit: %s"
-msgstr "Ung=C3=BCltige Version: %s"
+msgstr "Ung=C3=BCltiger Commit: %s"
=20
 #: builtin/commit.c:542
 msgid "malformed --author parameter"
@@ -3858,7 +3856,7 @@ msgstr "Fehlerhafte Identifikations-String: '%s'"
 #: builtin/commit.c:600 builtin/commit.c:633 builtin/commit.c:956
 #, c-format
 msgid "could not lookup commit %s"
-msgstr "Konnte Version %s nicht nachschlagen"
+msgstr "Konnte Commit %s nicht nachschlagen"
=20
 #: builtin/commit.c:612 builtin/shortlog.c:270
 #, c-format
@@ -3876,7 +3874,7 @@ msgstr "Konnte Log-Datei '%s' nicht lesen"
=20
 #: builtin/commit.c:624
 msgid "commit has empty message"
-msgstr "Version hat eine leere Beschreibung"
+msgstr "Commit hat eine leere Beschreibung"
=20
 #: builtin/commit.c:640
 msgid "could not read MERGE_MSG"
@@ -3893,7 +3891,7 @@ msgstr "Konnte '%s' nicht lesen"
=20
 #: builtin/commit.c:709
 msgid "could not write commit template"
-msgstr "Konnte Versionsvorlage nicht schreiben"
+msgstr "Konnte Commit-Vorlage nicht schreiben"
=20
 #: builtin/commit.c:720
 #, c-format
@@ -3905,7 +3903,7 @@ msgid ""
 "and try again.\n"
 msgstr ""
 "\n"
-"Es sieht so aus, als tragen Sie eine Zusammenf=C3=BChrung ein.\n"
+"Es sieht so aus, als committen Sie einen Merge.\n"
 "Falls das nicht korrekt ist, l=C3=B6schen Sie bitte die Datei\n"
 "\t%s\n"
 "und versuchen Sie es erneut.\n"
@@ -3920,7 +3918,7 @@ msgid ""
 "and try again.\n"
 msgstr ""
 "\n"
-"Es sieht so aus, als tragen Sie ein \"cherry-pick\" ein.\n"
+"Es sieht so aus, als committen Sie einen \"cherry-pick\".\n"
 "Falls das nicht korrekt ist, l=C3=B6schen Sie bitte die Datei\n"
 "\t%s\n"
 "und versuchen Sie es erneut.\n"
@@ -3931,10 +3929,10 @@ msgid ""
 "Please enter the commit message for your changes. Lines starting\n"
 "with '%c' will be ignored, and an empty message aborts the commit.\n"
 msgstr ""
-"Bitte geben Sie eine Versionsbeschreibung f=C3=BCr Ihre =C3=84nderung=
en ein. Zeilen,\n"
+"Bitte geben Sie eine Commit-Beschreibung f=C3=BCr Ihre =C3=84nderunge=
n ein. Zeilen,\n"
 "die mit '%c' beginnen, werden ignoriert, und eine leere "
-"Versionsbeschreibung\n"
-"bricht die Eintragung ab.\n"
+"Beschreibung\n"
+"bricht den Commit ab.\n"
=20
 #: builtin/commit.c:742
 #, c-format
@@ -3943,11 +3941,11 @@ msgid ""
 "with '%c' will be kept; you may remove them yourself if you want to.\=
n"
 "An empty message aborts the commit.\n"
 msgstr ""
-"Bitte geben Sie eine Versionsbeschreibung f=C3=BCr Ihre =C3=84nderung=
en ein. Zeilen, "
+"Bitte geben Sie eine Commit-Beschreibung f=C3=BCr Ihre =C3=84nderunge=
n ein. Zeilen, "
 "die\n"
 "mit '%c' beginnen, werden beibehalten; wenn Sie m=C3=B6chten, k=C3=B6=
nnen Sie diese "
 "entfernen.\n"
-"Eine leere Versionsbeschreibung bricht die Eintragung ab.\n"
+"Eine leere Beschreibung bricht den Commit ab.\n"
=20
 #: builtin/commit.c:755
 #, c-format
@@ -3957,20 +3955,20 @@ msgstr "%sAutor:    %s"
 #: builtin/commit.c:762
 #, c-format
 msgid "%sCommitter: %s"
-msgstr "%sEintragender: %s"
+msgstr "%sCommit-Ersteller: %s"
=20
 #: builtin/commit.c:782
 msgid "Cannot read index"
-msgstr "Kann Bereitstellung nicht lesen"
+msgstr "Kann Staging-Area nicht lesen"
=20
 #: builtin/commit.c:819
 msgid "Error building trees"
-msgstr "Fehler beim Erzeugen der Zweige"
+msgstr "Fehler beim Erzeugen der \"Tree\"-Objekte"
=20
 #: builtin/commit.c:834 builtin/tag.c:359
 #, c-format
 msgid "Please supply the message using either -m or -F option.\n"
-msgstr "Bitte liefere eine Beschreibung entweder mit der Option -m ode=
r -F.\n"
+msgstr "Bitte liefern Sie eine Beschreibung entweder mit der Option -m=
 oder -F.\n"
=20
 #: builtin/commit.c:931
 #, c-format
@@ -3990,15 +3988,15 @@ msgstr ""
=20
 #: builtin/commit.c:987
 msgid "You have nothing to amend."
-msgstr "Sie haben nichts zum nachbessern."
+msgstr "Sie haben nichts f=C3=BCr \"--amend\"."
=20
 #: builtin/commit.c:990
 msgid "You are in the middle of a merge -- cannot amend."
-msgstr "Eine Zusammenf=C3=BChrung ist im Gange -- kann nicht nachbesse=
rn."
+msgstr "Ein Merge ist im Gange -- kann \"--amend\" nicht ausf=C3=BChre=
n."
=20
 #: builtin/commit.c:992
 msgid "You are in the middle of a cherry-pick -- cannot amend."
-msgstr "\"cherry-pick\" ist im Gange -- kann nicht nachbessern."
+msgstr "\"cherry-pick\" ist im Gange -- kann \"--amend\" nicht ausf=C3=
=BChren."
=20
 #: builtin/commit.c:995
 msgid "Options --squash and --fixup cannot be used together"
@@ -4033,7 +4031,7 @@ msgstr ""
 #: builtin/commit.c:1036
 msgid "Clever... amending the last one with dirty index."
 msgstr ""
-"Klug... die letzte Version mit einer unsauberen Bereitstellung nachbe=
ssern."
+"Klug... den letzten Commit mit einer ge=C3=A4nderten Staging-Area nac=
hbessern."
=20
 #: builtin/commit.c:1038
 msgid "Explicit paths specified without -i nor -o; assuming --only pat=
hs..."
@@ -4060,7 +4058,7 @@ msgstr "zeigt Status im Kurzformat"
=20
 #: builtin/commit.c:1156 builtin/commit.c:1392
 msgid "show branch information"
-msgstr "zeigt Zweiginformationen"
+msgstr "zeigt Branchinformationen"
=20
 #: builtin/commit.c:1158 builtin/commit.c:1394 builtin/push.c:426
 msgid "machine-readable output"
@@ -4098,7 +4096,7 @@ msgid ""
 "ignore changes to submodules, optional when: all, dirty, untracked. "
 "(Default: all)"
 msgstr ""
-"ignoriert =C3=84nderungen in Unterprojekten, optional wenn: all, dirt=
y, "
+"ignoriert =C3=84nderungen in Submodulen, optional wenn: all, dirty, "
 "untracked. (Standard: all)"
=20
 #: builtin/commit.c:1174
@@ -4107,31 +4105,31 @@ msgstr "listet unbeobachtete Dateien in Spalten=
 auf"
=20
 #: builtin/commit.c:1248
 msgid "couldn't look up newly created commit"
-msgstr "Konnte neu erstellte Version nicht nachschlagen."
+msgstr "Konnte neu erstellten Commit nicht nachschlagen."
=20
 #: builtin/commit.c:1250
 msgid "could not parse newly created commit"
-msgstr "Konnte neulich erstellte Version nicht analysieren."
+msgstr "Konnte neulich erstellten Commit nicht analysieren."
=20
 #: builtin/commit.c:1291
 msgid "detached HEAD"
-msgstr "losgel=C3=B6ste Zweigspitze (HEAD)"
+msgstr "losgel=C3=B6ster HEAD"
=20
 #: builtin/commit.c:1293
 msgid " (root-commit)"
-msgstr " (Basis-Version)"
+msgstr " (Basis-Commit)"
=20
 #: builtin/commit.c:1360
 msgid "suppress summary after successful commit"
-msgstr "unterdr=C3=BCckt Zusammenfassung nach erfolgreicher Eintragung=
"
+msgstr "unterdr=C3=BCckt Zusammenfassung nach erfolgreichem Commit"
=20
 #: builtin/commit.c:1361
 msgid "show diff in commit message template"
-msgstr "zeigt Unterschiede in Versionsbeschreibungsvorlage an"
+msgstr "zeigt Unterschiede in Commit-Beschreibungsvorlage an"
=20
 #: builtin/commit.c:1363
 msgid "Commit message options"
-msgstr "Optionen f=C3=BCr Versionsbeschreibung"
+msgstr "Optionen f=C3=BCr Commit-Beschreibung"
=20
 #: builtin/commit.c:1364 builtin/tag.c:457
 msgid "read message from file"
@@ -4143,7 +4141,7 @@ msgstr "Autor"
=20
 #: builtin/commit.c:1365
 msgid "override author for commit"
-msgstr "=C3=BCberschreibt Autor von Version"
+msgstr "=C3=BCberschreibt Autor eines Commits"
=20
 #: builtin/commit.c:1366 builtin/gc.c:178
 msgid "date"
@@ -4151,7 +4149,7 @@ msgstr "Datum"
=20
 #: builtin/commit.c:1366
 msgid "override date for commit"
-msgstr "=C3=BCberschreibt Datum von Version"
+msgstr "=C3=BCberschreibt Datum eines Commits"
=20
 #: builtin/commit.c:1367 builtin/merge.c:208 builtin/notes.c:533
 #: builtin/notes.c:690 builtin/tag.c:455
@@ -4160,31 +4158,31 @@ msgstr "Beschreibung"
=20
 #: builtin/commit.c:1367
 msgid "commit message"
-msgstr "Versionsbeschreibung"
+msgstr "Commit-Beschreibung"
=20
 #: builtin/commit.c:1368
 msgid "reuse and edit message from specified commit"
-msgstr "verwendet wieder und editiert Beschreibung von der angegebenen=
 Version"
+msgstr "verwendet wieder und editiert Beschreibung des angegebenen Com=
mits"
=20
 #: builtin/commit.c:1369
 msgid "reuse message from specified commit"
-msgstr "verwendet Beschreibung der angegebenen Version wieder"
+msgstr "verwendet Beschreibung des angegebenen Commits wieder"
=20
 #: builtin/commit.c:1370
 msgid "use autosquash formatted message to fixup specified commit"
 msgstr ""
-"verwendet eine automatisch zusammengesetzte Beschreibung zum Nachbess=
ern der "
-"angegebenen Version"
+"verwendet eine automatisch zusammengesetzte Beschreibung zum Nachbess=
ern des "
+"angegebenen Commits"
=20
 #: builtin/commit.c:1371
 msgid "use autosquash formatted message to squash specified commit"
 msgstr ""
-"verwendet eine automatisch zusammengesetzte Beschreibung zum Zusammen=
f=C3=BChren "
-"der angegebenen Version"
+"verwendet eine automatisch zusammengesetzte Beschreibung beim \"squas=
h\" "
+"des angegebenen Commits"
=20
 #: builtin/commit.c:1372
 msgid "the commit is authored by me now (used with -C/-c/--amend)"
-msgstr "Setzt Sie als Autor der Version (verwendet mit -C/-c/--amend)"
+msgstr "Setzt Sie als Autor des Commits (verwendet mit -C/-c/--amend)"
=20
 #: builtin/commit.c:1373 builtin/log.c:1113 builtin/revert.c:109
 msgid "add Signed-off-by:"
@@ -4196,7 +4194,7 @@ msgstr "verwendet angegebene Vorlagendatei"
=20
 #: builtin/commit.c:1375
 msgid "force edit of commit"
-msgstr "erzwingt Bearbeitung der Version"
+msgstr "erzwingt Bearbeitung des Commits"
=20
 #: builtin/commit.c:1376
 msgid "default"
@@ -4209,7 +4207,7 @@ msgstr ""
=20
 #: builtin/commit.c:1377
 msgid "include status in commit message template"
-msgstr "f=C3=BCgt Status in die Versionsbeschreibungsvorlage ein"
+msgstr "f=C3=BCgt Status in die Commit-Beschreibungsvorlage ein"
=20
 #: builtin/commit.c:1378 builtin/merge.c:215 builtin/tag.c:461
 msgid "key id"
@@ -4217,20 +4215,20 @@ msgstr "Schl=C3=BCssel-ID"
=20
 #: builtin/commit.c:1379 builtin/merge.c:216
 msgid "GPG sign commit"
-msgstr "signiert Version mit GPG"
+msgstr "signiert Commit mit GPG"
=20
 #. end commit message options
 #: builtin/commit.c:1382
 msgid "Commit contents options"
-msgstr "Optionen f=C3=BCr Versionsinhalt"
+msgstr "Optionen f=C3=BCr Commit-Inhalt"
=20
 #: builtin/commit.c:1383
 msgid "commit all changed files"
-msgstr "tr=C3=A4gt alle ge=C3=A4nderten Dateien ein"
+msgstr "committet alle ge=C3=A4nderten Dateien"
=20
 #: builtin/commit.c:1384
 msgid "add specified files to index for commit"
-msgstr "tr=C3=A4gt die angegebenen Dateien zus=C3=A4tzlich zur Bereits=
tellung ein"
+msgstr "merkt die angegebenen Dateien zus=C3=A4tzlich zum Commit vor"
=20
 #: builtin/commit.c:1385
 msgid "interactively add files"
@@ -4242,7 +4240,7 @@ msgstr "interaktives Hinzuf=C3=BCgen von =C3=84nd=
erungen"
=20
 #: builtin/commit.c:1387
 msgid "commit only specified files"
-msgstr "tr=C3=A4gt nur die angegebenen Dateien ein"
+msgstr "committet nur die angegebenen Dateien"
=20
 #: builtin/commit.c:1388
 msgid "bypass pre-commit hook"
@@ -4250,11 +4248,11 @@ msgstr "umgeht \"pre-commit hook\""
=20
 #: builtin/commit.c:1389
 msgid "show what would be committed"
-msgstr "zeigt an, was eingetragen werden w=C3=BCrde"
+msgstr "zeigt an, was committet werden w=C3=BCrde"
=20
 #: builtin/commit.c:1400
 msgid "amend previous commit"
-msgstr "=C3=A4ndert vorherige Version"
+msgstr "=C3=A4ndert vorherigen Commit"
=20
 #: builtin/commit.c:1401
 msgid "bypass post-rewrite hook"
@@ -4270,7 +4268,7 @@ msgstr "erlaubt Aufzeichnung einer =C3=84nderung =
mit einer leeren Beschreibung"
=20
 #: builtin/commit.c:1441
 msgid "could not parse HEAD commit"
-msgstr "Konnte Version der Zweigspitze (HEAD) nicht analysieren."
+msgstr "Konnte Commit von HEAD nicht analysieren."
=20
 #: builtin/commit.c:1479 builtin/merge.c:510
 #, c-format
@@ -4289,29 +4287,29 @@ msgstr "Konnte MERGE_MODE nicht lesen"
 #: builtin/commit.c:1512
 #, c-format
 msgid "could not read commit message: %s"
-msgstr "Konnte Versionsbeschreibung nicht lesen: %s"
+msgstr "Konnte Commit-Beschreibung nicht lesen: %s"
=20
 #: builtin/commit.c:1526
 #, c-format
 msgid "Aborting commit; you did not edit the message.\n"
-msgstr "Eintragung abgebrochen; Sie haben die Beschreibung nicht editi=
ert.\n"
+msgstr "Commit abgebrochen; Sie haben die Beschreibung nicht editiert.=
\n"
=20
 #: builtin/commit.c:1531
 #, c-format
 msgid "Aborting commit due to empty commit message.\n"
-msgstr "Eintragung aufgrund leerer Versionsbeschreibung abgebrochen.\n=
"
+msgstr "Commit aufgrund leerer Beschreibung abgebrochen.\n"
=20
 #: builtin/commit.c:1546 builtin/merge.c:847 builtin/merge.c:872
 msgid "failed to write commit object"
-msgstr "Fehler beim Schreiben des Versionsobjektes."
+msgstr "Fehler beim Schreiben des Commit-Objektes."
=20
 #: builtin/commit.c:1567
 msgid "cannot lock HEAD ref"
-msgstr "Kann Referenz der Zweigspitze (HEAD) nicht sperren."
+msgstr "Kann Referenz von HEAD nicht sperren."
=20
 #: builtin/commit.c:1571
 msgid "cannot update HEAD ref"
-msgstr "Kann Referenz der Zweigspitze (HEAD) nicht aktualisieren."
+msgstr "Kann Referenz von HEAD nicht aktualisieren."
=20
 #: builtin/commit.c:1582
 msgid ""
@@ -4319,7 +4317,7 @@ msgid ""
 "new_index file. Check that disk is not full or quota is\n"
 "not exceeded, and then \"git reset HEAD\" to recover."
 msgstr ""
-"Das Projektarchiv wurde aktualisiert, aber die \"new_index\"-Datei\n"
+"Das Repository wurde aktualisiert, aber die \"new_index\"-Datei\n"
 "konnte nicht geschrieben werden. Pr=C3=BCfen Sie, dass Ihre Festplatt=
e nicht\n"
 "voll und Ihr Kontingent nicht aufgebraucht ist und f=C3=BChren Sie\n"
 "anschlie=C3=9Fend \"git reset HEAD\" zu Wiederherstellung aus."
@@ -4342,7 +4340,7 @@ msgstr "verwendet systemweite Konfigurationsdatei=
"
=20
 #: builtin/config.c:54
 msgid "use repository config file"
-msgstr "verwendet Konfigurationsdatei des Projektarchivs"
+msgstr "verwendet Konfigurationsdatei des Repositories"
=20
 #: builtin/config.c:55
 msgid "use given config file"
@@ -4459,17 +4457,17 @@ msgstr "git describe [Optionen] --dirty"
 #: builtin/describe.c:233
 #, c-format
 msgid "annotated tag %s not available"
-msgstr "annotierte Markierung %s ist nicht verf=C3=BCgbar"
+msgstr "annotierter Tag %s ist nicht verf=C3=BCgbar"
=20
 #: builtin/describe.c:237
 #, c-format
 msgid "annotated tag %s has no embedded name"
-msgstr "annotierte Markierung %s hat keinen eingebetteten Namen"
+msgstr "annotierter Tag %s hat keinen eingebetteten Namen"
=20
 #: builtin/describe.c:239
 #, c-format
 msgid "tag '%s' is really '%s' here"
-msgstr "Markierung '%s' ist eigentlich '%s' hier"
+msgstr "Tag '%s' ist eigentlich '%s' hier"
=20
 #: builtin/describe.c:266
 #, c-format
@@ -4484,7 +4482,7 @@ msgstr "%s ist kein g=C3=BCltiges '%s' Objekt"
 #: builtin/describe.c:286
 #, c-format
 msgid "no tag exactly matches '%s'"
-msgstr "kein Markierung entspricht exakt '%s'"
+msgstr "kein Tag entspricht exakt '%s'"
=20
 #: builtin/describe.c:288
 #, c-format
@@ -4502,8 +4500,8 @@ msgid ""
 "No annotated tags can describe '%s'.\n"
 "However, there were unannotated tags: try --tags."
 msgstr ""
-"Keine annotierten Markierungen k=C3=B6nnen '%s' beschreiben.\n"
-"Jedoch gab es nicht annotierte Markierungen: versuchen Sie --tags."
+"Keine annotierten Tags k=C3=B6nnen '%s' beschreiben.\n"
+"Jedoch gab es nicht-annotierte Tags: versuchen Sie --tags."
=20
 #: builtin/describe.c:356
 #, c-format
@@ -4511,13 +4509,13 @@ msgid ""
 "No tags can describe '%s'.\n"
 "Try --always, or create some tags."
 msgstr ""
-"Keine Markierungen k=C3=B6nnen '%s' beschreiben.\n"
-"Versuchen Sie --always oder erstellen Sie einige Markierungen."
+"Keine Tags k=C3=B6nnen '%s' beschreiben.\n"
+"Versuchen Sie --always oder erstellen Sie einige Tags."
=20
 #: builtin/describe.c:377
 #, c-format
 msgid "traversed %lu commits\n"
-msgstr "%lu Versionen durchlaufen\n"
+msgstr "%lu Commits durchlaufen\n"
=20
 #: builtin/describe.c:380
 #, c-format
@@ -4525,12 +4523,12 @@ msgid ""
 "more than %i tags found; listed %i most recent\n"
 "gave up search at %s\n"
 msgstr ""
-"mehr als %i Markierungen gefunden; F=C3=BChre die ersten %i auf\n"
+"mehr als %i Tags gefunden; F=C3=BChre die ersten %i auf\n"
 "Suche bei %s aufgegeben\n"
=20
 #: builtin/describe.c:402
 msgid "find the tag that comes after the commit"
-msgstr "findet die Markierung, die nach der Version kommt"
+msgstr "findet den Tag, die nach Commit kommt"
=20
 #: builtin/describe.c:403
 msgid "debug search strategy on stderr"
@@ -4542,7 +4540,7 @@ msgstr "verwendet alle Referenzen"
=20
 #: builtin/describe.c:405
 msgid "use any tag, even unannotated"
-msgstr "verwendet jede Markierung, auch nicht-annotierte"
+msgstr "verwendet jeden Tag, auch nicht-annotierte"
=20
 #: builtin/describe.c:406
 msgid "always use long format"
@@ -4554,15 +4552,15 @@ msgstr "gibt nur exakte =C3=9Cbereinstimmungen =
aus"
=20
 #: builtin/describe.c:411
 msgid "consider <n> most recent tags (default: 10)"
-msgstr "betrachtet die j=C3=BCngsten <n> Markierungen (Standard: 10)"
+msgstr "betrachtet die j=C3=BCngsten <n> Tags (Standard: 10)"
=20
 #: builtin/describe.c:413
 msgid "only consider tags matching <pattern>"
-msgstr "betrachtet nur Markierungen die <Muster> entsprechen"
+msgstr "betrachtet nur Tags die <Muster> entsprechen"
=20
 #: builtin/describe.c:415 builtin/name-rev.c:238
 msgid "show abbreviated commit object as fallback"
-msgstr "zeigt gek=C3=BCrztes Versionsobjekt, wenn sonst nichts zutriff=
t"
+msgstr "zeigt gek=C3=BCrztes Commit-Objekt, wenn sonst nichts zutrifft=
"
=20
 #: builtin/describe.c:416
 msgid "mark"
@@ -4571,7 +4569,7 @@ msgstr "Kennzeichen"
 #: builtin/describe.c:417
 msgid "append <mark> on dirty working tree (default: \"-dirty\")"
 msgstr ""
-"f=C3=BCgt <Kennzeichen> bei ge=C3=A4ndertem Arbeitsbaum hinzu (Standa=
rd: \"-dirty\")"
+"f=C3=BCgt <Kennzeichen> bei ge=C3=A4ndertem Arbeitsverzeichnis hinzu =
(Standard: \"-dirty\")"
=20
 #: builtin/describe.c:435
 msgid "--long is incompatible with --abbrev=3D0"
@@ -4583,12 +4581,12 @@ msgstr "Keine Namen gefunden, kann nichts besch=
reiben."
=20
 #: builtin/describe.c:481
 msgid "--dirty is incompatible with committishes"
-msgstr "Die Option --dirty kann nicht mit Versionen verwendet werden."
+msgstr "Die Option --dirty kann nicht mit Commits verwendet werden."
=20
 #: builtin/diff.c:79
 #, c-format
 msgid "'%s': not a regular file or symlink"
-msgstr "'%s': keine regul=C3=A4re Datei oder symbolischer Link"
+msgstr "'%s': keine regul=C3=A4re Datei oder symbolischer Verweis"
=20
 #: builtin/diff.c:228
 #, c-format
@@ -4597,7 +4595,7 @@ msgstr "Ung=C3=BCltige Option: %s"
=20
 #: builtin/diff.c:305
 msgid "Not a git repository"
-msgstr "Kein Git-Projektarchiv"
+msgstr "Kein Git-Repository"
=20
 #: builtin/diff.c:348
 #, c-format
@@ -4607,7 +4605,7 @@ msgstr "Objekt '%s' ist ung=C3=BCltig."
 #: builtin/diff.c:353
 #, c-format
 msgid "more than %d trees given: '%s'"
-msgstr "Mehr als %d Zweige angegeben: '%s'"
+msgstr "Mehr als %d \"Tree\"-Objekte angegeben: '%s'"
=20
 #: builtin/diff.c:363
 #, c-format
@@ -4629,11 +4627,11 @@ msgstr "zeigt Fortschritt nach <n> Objekten an"
=20
 #: builtin/fast-export.c:660
 msgid "select handling of signed tags"
-msgstr "w=C3=A4hlt Behandlung von signierten Markierungen"
+msgstr "w=C3=A4hlt Behandlung von signierten Tags"
=20
 #: builtin/fast-export.c:663
 msgid "select handling of tags that tag filtered objects"
-msgstr "w=C3=A4hlt Behandlung von Markierungen, die gefilterte Objekte=
 markieren"
+msgstr "w=C3=A4hlt Behandlung von Tags, die gefilterte Objekte markier=
en"
=20
 #: builtin/fast-export.c:666
 msgid "Dump marks to this file"
@@ -4646,11 +4644,11 @@ msgstr "Importiert Kennzeichen von dieser Datei=
"
 #: builtin/fast-export.c:670
 msgid "Fake a tagger when tags lack one"
 msgstr ""
-"erzeugt k=C3=BCnstlich einen Markierungsersteller, wenn die Markierun=
g keinen hat"
+"erzeugt k=C3=BCnstlich einen Tag-Ersteller, wenn der Tag keinen hat"
=20
 #: builtin/fast-export.c:672
 msgid "Output full tree for each commit"
-msgstr "gibt f=C3=BCr jede Version den gesamten Baum aus"
+msgstr "gibt f=C3=BCr jeden Commit das gesamte Verzeichnis aus"
=20
 #: builtin/fast-export.c:674
 msgid "Use the done feature to terminate the stream"
@@ -4662,7 +4660,7 @@ msgstr "=C3=9Cberspringt Ausgabe von Blob-Daten"
=20
 #: builtin/fetch.c:20
 msgid "git fetch [<options>] [<repository> [<refspec>...]]"
-msgstr "git fetch [<Optionen>] [<Projektarchiv> [<Referenzspezifikatio=
n>...]]"
+msgstr "git fetch [<Optionen>] [<Repository> [<Refspec>...]]"
=20
 #: builtin/fetch.c:21
 msgid "git fetch [<options>] <group>"
@@ -4670,7 +4668,7 @@ msgstr "git fetch [<Optionen>] <Gruppe>"
=20
 #: builtin/fetch.c:22
 msgid "git fetch --multiple [<options>] [(<repository> | <group>)...]"
-msgstr "git fetch --multiple [<Optionen>] [(<Projektarchiv> | <Gruppe>=
)...]"
+msgstr "git fetch --multiple [<Optionen>] [(<Repository> | <Gruppe>)..=
=2E]"
=20
 #: builtin/fetch.c:23
 msgid "git fetch --all [<options>]"
@@ -4678,7 +4676,7 @@ msgstr "git fetch --all [<Optionen>]"
=20
 #: builtin/fetch.c:60
 msgid "fetch from all remotes"
-msgstr "fordert von allen externen Projektarchiven an"
+msgstr "fordert von allen Remote-Repositories an"
=20
 #: builtin/fetch.c:62
 msgid "append to .git/FETCH_HEAD instead of overwriting"
@@ -4690,24 +4688,25 @@ msgstr "Pfad des Programms zum Hochladen von Pa=
keten auf der Gegenseite"
=20
 #: builtin/fetch.c:65
 msgid "force overwrite of local branch"
-msgstr "erzwingt das =C3=9Cberschreiben von lokalen Zweigen"
+msgstr "erzwingt das =C3=9Cberschreiben von lokalen Branches"
=20
 #: builtin/fetch.c:67
 msgid "fetch from multiple remotes"
-msgstr "fordert von mehreren externen Projektarchiven an"
+msgstr "fordert von mehreren Remote-Repositories an"
=20
 #: builtin/fetch.c:69
 msgid "fetch all tags and associated objects"
-msgstr "fordert alle Markierungen und verbundene Objekte an"
+msgstr "fordert alle Tags und verbundene Objekte an"
=20
 #: builtin/fetch.c:71
 msgid "do not fetch all tags (--no-tags)"
-msgstr "fordert nicht alle Markierungen an (--no-tags)"
+msgstr "fordert nicht alle Tags an (--no-tags)"
=20
 #: builtin/fetch.c:73
 msgid "prune remote-tracking branches no longer on remote"
 msgstr ""
-"entfernt externe =C3=9Cbernahmezweige, die sich nicht mehr im Fernarc=
hiv befinden"
+"entfernt Remote-Tracking-Branches, die sich nicht mehr im Remote-Repo=
sitory "
+"befinden"
=20
 #: builtin/fetch.c:74
 msgid "on-demand"
@@ -4715,7 +4714,7 @@ msgstr "bei-Bedarf"
=20
 #: builtin/fetch.c:75
 msgid "control recursive fetching of submodules"
-msgstr "kontrolliert rekursive Anforderungen von Unterprojekten"
+msgstr "kontrolliert rekursive Anforderungen von Submodulen"
=20
 #: builtin/fetch.c:79
 msgid "keep downloaded pack"
@@ -4727,11 +4726,11 @@ msgstr "erlaubt Aktualisierung der \"HEAD\"-Ref=
erenz"
=20
 #: builtin/fetch.c:84
 msgid "deepen history of shallow clone"
-msgstr "vertieft die Historie eines flachen Klon"
+msgstr "vertieft die Historie eines flachen Klons"
=20
 #: builtin/fetch.c:86
 msgid "convert to a complete repository"
-msgstr "konvertiert zu einem vollst=C3=A4ndigen Projektarchiv"
+msgstr "konvertiert zu einem vollst=C3=A4ndigen Repository"
=20
 #: builtin/fetch.c:88 builtin/log.c:1130
 msgid "dir"
@@ -4739,7 +4738,7 @@ msgstr "Verzeichnis"
=20
 #: builtin/fetch.c:89
 msgid "prepend this to submodule path output"
-msgstr "stellt dies an die Ausgabe der Unterprojekt-Pfade voran"
+msgstr "stellt dies an die Ausgabe der Submodul-Pfade voran"
=20
 #: builtin/fetch.c:92
 msgid "default mode for recursion"
@@ -4747,7 +4746,7 @@ msgstr "Standard-Modus f=C3=BCr Rekursion"
=20
 #: builtin/fetch.c:204
 msgid "Couldn't find remote ref HEAD"
-msgstr "Konnte externe Referenz der Zweigspitze (HEAD) nicht finden."
+msgstr "Konnte Remote-Referenz von HEAD nicht finden."
=20
 #: builtin/fetch.c:257
 #, c-format
@@ -4761,7 +4760,7 @@ msgstr "[aktuell]"
 #: builtin/fetch.c:276
 #, c-format
 msgid "! %-*s %-*s -> %s  (can't fetch in current branch)"
-msgstr "! %-*s %-*s -> %s  (kann nicht im aktuellen Zweig anfordern)"
+msgstr "! %-*s %-*s -> %s  (kann \"fetch\" im aktuellen Branch nicht a=
usf=C3=BChren)"
=20
 #: builtin/fetch.c:277 builtin/fetch.c:363
 msgid "[rejected]"
@@ -4769,7 +4768,7 @@ msgstr "[zur=C3=BCckgewiesen]"
=20
 #: builtin/fetch.c:288
 msgid "[tag update]"
-msgstr "[Markierungsaktualisierung]"
+msgstr "[Tag Aktualisierung]"
=20
 #: builtin/fetch.c:290 builtin/fetch.c:325 builtin/fetch.c:343
 msgid "  (unable to update local ref)"
@@ -4777,11 +4776,11 @@ msgstr "  (kann lokale Referenz nicht aktualisi=
eren)"
=20
 #: builtin/fetch.c:308
 msgid "[new tag]"
-msgstr "[neue Markierung]"
+msgstr "[neuer Tag]"
=20
 #: builtin/fetch.c:311
 msgid "[new branch]"
-msgstr "[neuer Zweig]"
+msgstr "[neuer Branch]"
=20
 #: builtin/fetch.c:314
 msgid "[new ref]"
@@ -4821,7 +4820,7 @@ msgid ""
 " 'git remote prune %s' to remove any old, conflicting branches"
 msgstr ""
 "Einige lokale Referenzen konnten nicht aktualisiert werden; versuchen=
 Sie\n"
-"'git remote prune %s' um jeden =C3=A4lteren, widerspr=C3=BCchlichen Z=
weig zu l=C3=B6schen."
+"'git remote prune %s' um jeden =C3=A4lteren, widerspr=C3=BCchlichen B=
ranch zu l=C3=B6schen."
=20
 #: builtin/fetch.c:552
 #, c-format
@@ -4845,7 +4844,7 @@ msgstr "(nichts)"
 #, c-format
 msgid "Refusing to fetch into current branch %s of non-bare repository=
"
 msgstr ""
-"Das Anfordern in den aktuellen Zweig %s von einem nicht-blo=C3=9Fen P=
rojektarchiv "
+"Der \"fetch\" in den aktuellen Branch %s von einem nicht-Bare-Reposit=
ory "
 "wurde verweigert."
=20
 #: builtin/fetch.c:712
@@ -4878,13 +4877,13 @@ msgid ""
 "No remote repository specified.  Please, specify either a URL or a\n"
 "remote name from which new revisions should be fetched."
 msgstr ""
-"Kein externes Projektarchiv angegeben. Bitte geben Sie entweder eine =
URL\n"
-"oder den Namen des externen Archivs an, von welchem neue\n"
+"Kein Remote-Repository angegeben. Bitte geben Sie entweder eine URL\n=
"
+"oder den Namen des Remote-Repositories an, von welchem neue\n"
 "Revisionen angefordert werden sollen."
=20
 #: builtin/fetch.c:935
 msgid "You need to specify a tag name."
-msgstr "Sie m=C3=BCssen den Namen der Markierung angeben."
+msgstr "Sie m=C3=BCssen den Namen des Tags angeben."
=20
 #: builtin/fetch.c:981
 msgid "--depth and --unshallow cannot be used together"
@@ -4894,27 +4893,27 @@ msgstr ""
 #: builtin/fetch.c:983
 msgid "--unshallow on a complete repository does not make sense"
 msgstr ""
-"Die Option --unshallow kann nicht in einem vollst=C3=A4ndigen Projekt=
archiv "
+"Die Option --unshallow kann nicht in einem vollst=C3=A4ndigen Reposit=
ory "
 "verwendet werden."
=20
 #: builtin/fetch.c:1002
 msgid "fetch --all does not take a repository argument"
-msgstr "fetch --all akzeptiert kein Projektarchiv als Argument"
+msgstr "fetch --all akzeptiert kein Repository als Argument"
=20
 #: builtin/fetch.c:1004
 msgid "fetch --all does not make sense with refspecs"
-msgstr "fetch --all kann nicht mit Referenzspezifikationen verwendet w=
erden."
+msgstr "fetch --all kann nicht mit Refspecs verwendet werden."
=20
 #: builtin/fetch.c:1015
 #, c-format
 msgid "No such remote or remote group: %s"
-msgstr "Kein externes Archiv (einzeln oder Gruppe): %s"
+msgstr "Kein Remote-Repository (einzeln oder Gruppe): %s"
=20
 #: builtin/fetch.c:1023
 msgid "Fetching a group and specifying refspecs does not make sense"
 msgstr ""
-"Das Abholen einer Gruppe von externen Archiven kann nicht mit der Ang=
abe\n"
-"von Referenzspezifikationen verwendet werden."
+"Das Abholen einer Gruppe von Remote-Repositories kann nicht mit der A=
ngabe\n"
+"von Refspecs verwendet werden."
=20
 #: builtin/fmt-merge-msg.c:13
 msgid "git fmt-merge-msg [-m <message>] [--log[=3D<n>]|--no-log] [--fi=
le <file>]"
@@ -5001,7 +5000,7 @@ msgstr "zeigt unreferenzierte Objekte"
=20
 #: builtin/fsck.c:616
 msgid "report tags"
-msgstr "meldet Markierungen"
+msgstr "meldet Tags"
=20
 #: builtin/fsck.c:617
 msgid "report root nodes"
@@ -5009,11 +5008,11 @@ msgstr "meldet Hauptwurzeln"
=20
 #: builtin/fsck.c:618
 msgid "make index objects head nodes"
-msgstr "erzeugt Kopfknoten der Bereitstellungsobjekte"
+msgstr "pr=C3=BCft Objekte in der Staging-Area"
=20
 #: builtin/fsck.c:619
 msgid "make reflogs head nodes (default)"
-msgstr "erzeugt Kopfknoten des Referenzprotokolls (Standard)"
+msgstr "pr=C3=BCft die Reflogs (Standard)"
=20
 #: builtin/fsck.c:620
 msgid "also consider packs and alternate objects"
@@ -5063,7 +5062,7 @@ msgid ""
 "Auto packing the repository for optimum performance. You may also\n"
 "run \"git gc\" manually. See \"git help gc\" for more information.\n"
 msgstr ""
-"Die Datenbank des Projektarchivs wird f=C3=BCr eine optimale Performa=
nce\n"
+"Die Datenbank des Repositories wird f=C3=BCr eine optimale Performanc=
e\n"
 "komprimiert. Sie k=C3=B6nnen auch \"git gc\" manuell ausf=C3=BChren.\=
n"
 "Siehe \"git help gc\" f=C3=BCr weitere Informationen.\n"
=20
@@ -5091,7 +5090,7 @@ msgstr "Fehler beim Verzeichniswechsel: %s"
 #: builtin/grep.c:443 builtin/grep.c:478
 #, c-format
 msgid "unable to read tree (%s)"
-msgstr "konnte Zweig (%s) nicht lesen"
+msgstr "konnte \"Tree\"-Objekt (%s) nicht lesen"
=20
 #: builtin/grep.c:493
 #, c-format
@@ -5110,7 +5109,7 @@ msgstr "kann '%s' nicht =C3=B6ffnen"
=20
 #: builtin/grep.c:643
 msgid "search in index instead of in the work tree"
-msgstr "sucht in der Bereitstellung anstatt im Arbeitsbaum"
+msgstr "sucht in der Staging-Area anstatt im Arbeitsverzeichnis"
=20
 #: builtin/grep.c:645
 msgid "find in contents not managed by git"
@@ -5261,7 +5260,7 @@ msgstr "zeigt nur =C3=9Cbereinstimmungen von Date=
ien, die allen Mustern entsprechen"
=20
 #: builtin/grep.c:736
 msgid "show parse tree for grep expression"
-msgstr "zeigt geparsten Baum f=C3=BCr \"grep\"-Ausdruck"
+msgstr "zeigt geparstes Verzeichnis f=C3=BCr \"grep\"-Ausdruck"
=20
 #: builtin/grep.c:740
 msgid "pager"
@@ -5286,8 +5285,8 @@ msgstr "keine Muster angegeben"
 #: builtin/grep.c:866
 msgid "--open-files-in-pager only works on the worktree"
 msgstr ""
-"Die Option --open-files-in-pager kann nur innerhalb des Arbeitsbaums =
"
-"verwendet werden."
+"Die Option --open-files-in-pager kann nur innerhalb des Arbeitsverzei=
chnisses"
+" verwendet werden."
=20
 #: builtin/grep.c:889
 msgid "--cached or --untracked cannot be used with --no-index."
@@ -5298,7 +5297,7 @@ msgstr ""
 #: builtin/grep.c:894
 msgid "--no-index or --untracked cannot be used with revs."
 msgstr ""
-"Die Optionen --no-index und --untracked k=C3=B6nnen nicht mit Version=
en verwendet "
+"Die Optionen --no-index und --untracked k=C3=B6nnen nicht mit Commits=
 verwendet "
 "werden."
=20
 #: builtin/grep.c:897
@@ -5309,7 +5308,7 @@ msgstr ""
=20
 #: builtin/grep.c:905
 msgid "both --cached and trees are given."
-msgstr "Die Option --cached kann nicht mit Zweigen verwendet werden."
+msgstr "Die Option --cached kann nicht mit \"Tree\"-Objekten verwendet=
 werden."
=20
 #: builtin/hash-object.c:60
 msgid ""
@@ -5439,7 +5438,7 @@ msgstr "Spezifikation von bewusst ignorierten, un=
beobachteten Dateien"
=20
 #: builtin/help.c:425
 msgid "Defining submodule properties"
-msgstr "Definition von Unterprojekt-Eigenschaften"
+msgstr "Definition von Submodul-Eigenschaften"
=20
 #: builtin/help.c:426
 msgid "Specifying revisions and ranges for Git"
@@ -5773,17 +5772,17 @@ msgstr "kann Verzeichnis '%s' nicht =C3=B6ffnen=
"
 #: builtin/init-db.c:97
 #, c-format
 msgid "cannot readlink '%s'"
-msgstr "kann Verkn=C3=BCpfung '%s' nicht lesen"
+msgstr "kann Verweis '%s' nicht lesen"
=20
 #: builtin/init-db.c:99
 #, c-format
 msgid "insanely long symlink %s"
-msgstr "zu lange symbolische Verkn=C3=BCpfung %s"
+msgstr "zu langer symbolischer Verweis %s"
=20
 #: builtin/init-db.c:102
 #, c-format
 msgid "cannot symlink '%s' '%s'"
-msgstr "kann '%s' nicht mit '%s' symbolisch verkn=C3=BCpfen"
+msgstr "kann symbolischen Verweis '%s' auf '%s' nicht erstellen"
=20
 #: builtin/init-db.c:106
 #, c-format
@@ -5833,7 +5832,7 @@ msgstr "Konnte %s nicht nach %s verschieben"
 #: builtin/init-db.c:363
 #, c-format
 msgid "Could not create git link %s"
-msgstr "Konnte git-Verkn=C3=BCpfung %s nicht erstellen"
+msgstr "Konnte git-Verweis %s nicht erstellen"
=20
 #.
 #. * TRANSLATORS: The first '%s' is either "Reinitialized
@@ -5843,7 +5842,7 @@ msgstr "Konnte git-Verkn=C3=BCpfung %s nicht erst=
ellen"
 #: builtin/init-db.c:420
 #, c-format
 msgid "%s%s Git repository in %s%s\n"
-msgstr "%s%s Git-Projektarchiv in %s%s\n"
+msgstr "%s%s Git-Repository in %s%s\n"
=20
 #: builtin/init-db.c:421
 msgid "Reinitialized existing"
@@ -5876,7 +5875,7 @@ msgstr "Berechtigungen"
 #: builtin/init-db.c:491
 msgid "specify that the git repository is to be shared amongst several=
 users"
 msgstr ""
-"gibt an, dass das Git-Projektarchiv mit mehreren Benutzern geteilt wi=
rd"
+"gibt an, dass das Git-Repository mit mehreren Benutzern geteilt wird"
=20
 #: builtin/init-db.c:493 builtin/prune-packed.c:77
 msgid "be quiet"
@@ -5908,7 +5907,7 @@ msgstr "Kann nicht auf aktuelles Arbeitsverzeichn=
is zugreifen."
 #: builtin/init-db.c:586
 #, c-format
 msgid "Cannot access work tree '%s'"
-msgstr "Kann nicht auf Arbeitsbaum '%s' zugreifen."
+msgstr "Kann nicht auf Arbeitsverzeichnis '%s' zugreifen."
=20
 #: builtin/log.c:40
 msgid "git log [<options>] [<revision range>] [[--] <path>...]\n"
@@ -5964,11 +5963,11 @@ msgstr "Kann Patch-Datei %s nicht =C3=B6ffnen"
=20
 #: builtin/log.c:750
 msgid "Need exactly one range."
-msgstr "Brauche genau einen Versionsbereich."
+msgstr "Brauche genau einen Commit-Bereich."
=20
 #: builtin/log.c:758
 msgid "Not a range."
-msgstr "Kein Versionsbereich."
+msgstr "Kein Commit-Bereich."
=20
 #: builtin/log.c:860
 msgid "Cover letter needs email format"
@@ -6042,7 +6041,7 @@ msgstr "gibt keine bin=C3=A4ren Unterschiede aus"
 #: builtin/log.c:1138
 msgid "don't include a patch matching a commit upstream"
 msgstr ""
-"schlie=C3=9Ft keine Patches ein, die einer Version im =C3=9Cbernahmez=
weig entsprechen"
+"schlie=C3=9Ft keine Patches ein, die einem Commit im Upstream-Branch =
entsprechen"
=20
 #: builtin/log.c:1140
 msgid "show patch format instead of default (patch + stat)"
@@ -6143,20 +6142,20 @@ msgstr "Fehler beim Erstellen der Ausgabedateie=
n."
=20
 #: builtin/log.c:1484
 msgid "git cherry [-v] [<upstream> [<head> [<limit>]]]"
-msgstr "git cherry [-v] [<=C3=9Cbernahmezweig> [<Arbeitszweig> [<Limit=
>]]]"
+msgstr "git cherry [-v] [<Upstream> [<Branch> [<Limit>]]]"
=20
 #: builtin/log.c:1539
 #, c-format
 msgid ""
 "Could not find a tracked remote branch, please specify <upstream> man=
ually.\n"
 msgstr ""
-"Konnte gefolgten, externen Zweig nicht finden, bitte geben Sie <upstr=
eam> "
+"Konnte gefolgten Remote-Branch nicht finden, bitte geben Sie <Upstrea=
m> "
 "manuell an.\n"
=20
 #: builtin/log.c:1552 builtin/log.c:1554 builtin/log.c:1566
 #, c-format
 msgid "Unknown commit %s"
-msgstr "Unbekannte Version %s"
+msgstr "Unbekannter Commit %s"
=20
 #: builtin/ls-files.c:402
 msgid "git ls-files [options] [<file>...]"
@@ -6164,7 +6163,7 @@ msgstr "git ls-files [Optionen] [<Datei>...]"
=20
 #: builtin/ls-files.c:459
 msgid "identify the file status with tags"
-msgstr "zeigt den Dateistatus mit Markierungen"
+msgstr "zeigt den Dateistatus mit Tags"
=20
 #: builtin/ls-files.c:461
 msgid "use lowercase letters for 'assume unchanged' files"
@@ -6193,7 +6192,7 @@ msgstr "zeigt ignorierte Dateien in der Ausgabe a=
n"
=20
 #: builtin/ls-files.c:474
 msgid "show staged contents' object name in the output"
-msgstr "zeigt Objektnamen von Inhalten in der Bereitstellung in der Au=
sgabe an"
+msgstr "zeigt Objektnamen von Inhalten, die zum Commit vorgemerkt sind=
, in der Ausgabe an"
=20
 #: builtin/ls-files.c:476
 msgid "show files on the filesystem that need to be removed"
@@ -6238,17 +6237,17 @@ msgstr "Ausgabe relativ zum Projektverzeichnis"
 #: builtin/ls-files.c:502
 msgid "if any <file> is not in the index, treat this as an error"
 msgstr ""
-"behandle es als Fehler, wenn sich eine <Datei> nicht in der Bereitste=
llung "
+"behandle es als Fehler, wenn sich eine <Datei> nicht in der Staging-A=
rea "
 "befindet"
=20
 #: builtin/ls-files.c:503
 msgid "tree-ish"
-msgstr "Versionsreferenz"
+msgstr "Commit-Referenz"
=20
 #: builtin/ls-files.c:504
 msgid "pretend that paths removed since <tree-ish> are still present"
 msgstr ""
-"gibt vor, dass Pfade, die seit <Versionsreferenz> gel=C3=B6scht wurde=
n, immer "
+"gibt vor, dass Pfade, die seit <Commit-Referenz> gel=C3=B6scht wurden=
, immer "
 "noch vorhanden sind"
=20
 #: builtin/ls-files.c:506
@@ -6257,19 +6256,19 @@ msgstr "zeigt Ausgaben zur Fehlersuche an"
=20
 #: builtin/ls-tree.c:27
 msgid "git ls-tree [<options>] <tree-ish> [<path>...]"
-msgstr "git ls-tree [<Optionen>] <Versionsreferenz> [<Pfad>...]"
+msgstr "git ls-tree [<Optionen>] <Commit-Referenz> [<Pfad>...]"
=20
 #: builtin/ls-tree.c:125
 msgid "only show trees"
-msgstr "zeigt nur B=C3=A4ume an"
+msgstr "zeigt nur Verzeichnisse an"
=20
 #: builtin/ls-tree.c:127
 msgid "recurse into subtrees"
-msgstr "f=C3=BChrt Rekursion in Teilb=C3=A4umen durch"
+msgstr "f=C3=BChrt Rekursion in Unterverzeichnissen durch"
=20
 #: builtin/ls-tree.c:129
 msgid "show trees when recursing"
-msgstr "zeigt B=C3=A4ume bei Rekursion an"
+msgstr "zeigt Verzeichnisse bei Rekursion an"
=20
 #: builtin/ls-tree.c:132
 msgid "terminate entries with NUL byte"
@@ -6290,16 +6289,16 @@ msgstr "verwendet vollst=C3=A4ndige Pfadnamen"
 #: builtin/ls-tree.c:142
 msgid "list entire tree; not just current directory (implies --full-na=
me)"
 msgstr ""
-"listet den gesamten Baum auf; nicht nur das aktuelle Verzeichnis (imp=
liziert "
-"--full-name)"
+"listet das gesamte Verzeichnis auf; nicht nur das aktuelle Verzeichni=
s "
+"(impliziert --full-name)"
=20
 #: builtin/merge.c:43
 msgid "git merge [options] [<commit>...]"
-msgstr "git merge [Optionen] [<Version>...]"
+msgstr "git merge [Optionen] [<Commit>...]"
=20
 #: builtin/merge.c:44
 msgid "git merge [options] <msg> HEAD <commit>"
-msgstr "git merge [Optionen] <Beschreibung> HEAD <Version>"
+msgstr "git merge [Optionen] <Beschreibung> HEAD <Commit>"
=20
 #: builtin/merge.c:45
 msgid "git merge --abort"
@@ -6312,7 +6311,7 @@ msgstr "Schalter 'm' erfordert einen Wert."
 #: builtin/merge.c:127
 #, c-format
 msgid "Could not find merge strategy '%s'.\n"
-msgstr "Konnte Zusammenf=C3=BChrungsstrategie '%s' nicht finden.\n"
+msgstr "Konnte Merge-Strategie '%s' nicht finden.\n"
=20
 #: builtin/merge.c:128
 #, c-format
@@ -6327,13 +6326,12 @@ msgstr "Verf=C3=BCgbare benutzerdefinierte Stra=
tegien sind:"
 #: builtin/merge.c:183
 msgid "do not show a diffstat at the end of the merge"
 msgstr ""
-"zeigt keine Zusammenfassung der Unterschiede am Schluss der Zusammenf=
=C3=BChrung "
-"an"
+"zeigt keine Zusammenfassung der Unterschiede am Schluss des Merges an=
"
=20
 #: builtin/merge.c:186
 msgid "show a diffstat at the end of the merge"
 msgstr ""
-"zeigt eine Zusammenfassung der Unterschiede am Schluss der Zusammenf=C3=
=BChrung an"
+"zeigt eine Zusammenfassung der Unterschiede am Schluss des Merges an"
=20
 #: builtin/merge.c:187
 msgid "(synonym to --stat)"
@@ -6342,22 +6340,21 @@ msgstr "(Synonym f=C3=BCr --stat)"
 #: builtin/merge.c:189
 msgid "add (at most <n>) entries from shortlog to merge commit message=
"
 msgstr ""
-"f=C3=BCgt (h=C3=B6chstens <n>) Eintr=C3=A4ge von \"shortlog\" zur Bes=
chreibung der "
-"Zusammenf=C3=BChrung hinzu"
+"f=C3=BCgt (h=C3=B6chstens <n>) Eintr=C3=A4ge von \"shortlog\" zur Bes=
chreibung des "
+"Merge-Commits hinzu"
=20
 #: builtin/merge.c:192
 msgid "create a single commit instead of doing a merge"
-msgstr "erzeugt eine einzelne Version anstatt einer Zusammenf=C3=BChru=
ng"
+msgstr "erzeugt einen einzelnen Commit anstatt eines Merges"
=20
 #: builtin/merge.c:194
 msgid "perform a commit if the merge succeeds (default)"
 msgstr ""
-"f=C3=BChrt eine Eintragung durch, wenn die Zusammenf=C3=BChrung erfol=
greich war "
-"(Standard)"
+"f=C3=BChrt einen Commit durch, wenn der Merge erfolgreich war (Standa=
rd)"
=20
 #: builtin/merge.c:196
 msgid "edit message before committing"
-msgstr "Bearbeitung der Versionsbeschreibung vor der Eintragung"
+msgstr "Bearbeitung der Beschreibung vor dem Commit"
=20
 #: builtin/merge.c:198
 msgid "allow fast-forward (default)"
@@ -6369,7 +6366,7 @@ msgstr "bricht ab, wenn kein Vorspulen m=C3=B6gli=
ch ist"
=20
 #: builtin/merge.c:203
 msgid "Verify that the named commit has a valid GPG signature"
-msgstr "=C3=BCberpr=C3=BCft die genannte Version auf eine g=C3=BCltige=
 GPG-Signatur"
+msgstr "=C3=BCberpr=C3=BCft den genannten Commit auf eine g=C3=BCltige=
 GPG-Signatur"
=20
 #: builtin/merge.c:204 builtin/notes.c:866 builtin/revert.c:112
 msgid "strategy"
@@ -6377,7 +6374,7 @@ msgstr "Strategie"
=20
 #: builtin/merge.c:205
 msgid "merge strategy to use"
-msgstr "zu verwendende Zusammenf=C3=BChrungsstrategie"
+msgstr "zu verwendende Merge-Strategie"
=20
 #: builtin/merge.c:206
 msgid "option=3Dvalue"
@@ -6385,17 +6382,16 @@ msgstr "Option=3DWert"
=20
 #: builtin/merge.c:207
 msgid "option for selected merge strategy"
-msgstr "Option f=C3=BCr ausgew=C3=A4hlte Zusammenf=C3=BChrungsstrategi=
e"
+msgstr "Option f=C3=BCr ausgew=C3=A4hlte Merge-Strategie"
=20
 #: builtin/merge.c:209
 msgid "merge commit message (for a non-fast-forward merge)"
 msgstr ""
-"f=C3=BChrt Versionsbeschreibung zusammen (f=C3=BCr eine Zusammenf=C3=BC=
hrung, die kein "
-"Vorspulen war)"
+"f=C3=BChrt Commit-Beschreibung zusammen (f=C3=BCr einen Merge, der ke=
in Vorspulen war)"
=20
 #: builtin/merge.c:213
 msgid "abort the current in-progress merge"
-msgstr "bricht die sich im Gange befindliche Zusammenf=C3=BChrung ab"
+msgstr "bricht den sich im Gange befindlichen Merge ab"
=20
 #: builtin/merge.c:242
 msgid "could not run stash."
@@ -6421,7 +6417,7 @@ msgstr " (nichts zu quetschen)"
 #: builtin/merge.c:331
 #, c-format
 msgid "Squash commit -- not updating HEAD\n"
-msgstr "Quetsche Version -- Zweigspitze (HEAD) wird nicht aktualisiert=
\n"
+msgstr "Quetsche Commit -- HEAD wird nicht aktualisiert\n"
=20
 #: builtin/merge.c:363
 msgid "Writing SQUASH_MSG"
@@ -6435,13 +6431,12 @@ msgstr "Schlie=C3=9Fe SQUASH_MSG ab"
 #, c-format
 msgid "No merge message -- not updating HEAD\n"
 msgstr ""
-"Keine Zusammenf=C3=BChrungsbeschreibung -- Zweigspitze (HEAD) wird ni=
cht "
-"aktualisiert\n"
+"Keine Merge-Commit-Beschreibung -- HEAD wird nicht aktualisiert\n"
=20
 #: builtin/merge.c:438
 #, c-format
 msgid "'%s' does not point to a commit"
-msgstr "'%s' zeigt auf keine Version"
+msgstr "'%s' zeigt auf keinen Commit"
=20
 #: builtin/merge.c:550
 #, c-format
@@ -6450,11 +6445,11 @@ msgstr "Ung=C3=BCltiger branch.%s.mergeoptions =
String: %s"
=20
 #: builtin/merge.c:643
 msgid "git write-tree failed to write a tree"
-msgstr "\"git write-tree\" schlug beim Schreiben eines Baumes fehl"
+msgstr "\"git write-tree\" schlug beim Schreiben eines \"Tree\"-Objekt=
es fehl"
=20
 #: builtin/merge.c:671
 msgid "Not handling anything other than two heads merge."
-msgstr "Es wird nur die Zusammenf=C3=BChrung von zwei Zweigen behandel=
t."
+msgstr "Es wird nur der Merge von zwei Branches behandelt."
=20
 #: builtin/merge.c:685
 #, c-format
@@ -6475,8 +6470,8 @@ msgstr "konnte nicht von '%s' lesen"
 #, c-format
 msgid "Not committing merge; use 'git commit' to complete the merge.\n=
"
 msgstr ""
-"Zusammenf=C3=BChrung wurde nicht eingetragen; benutzen Sie 'git commi=
t' um die "
-"Zusammenf=C3=BChrung abzuschlie=C3=9Fen.\n"
+"Merge wurde nicht committet; benutzen Sie 'git commit' um den Merge "
+"abzuschlie=C3=9Fen.\n"
=20
 #: builtin/merge.c:803
 #, c-format
@@ -6487,17 +6482,16 @@ msgid ""
 "Lines starting with '%c' will be ignored, and an empty message aborts=
\n"
 "the commit.\n"
 msgstr ""
-"Bitte geben Sie eine Versionsbeschreibung ein um zu erkl=C3=A4ren, wa=
rum diese "
-"Zusammenf=C3=BChrung erforderlich ist,\n"
-"insbesondere wenn es einen aktualisierten, externen Zweig mit einem T=
hema-"
-"Zweig zusammenf=C3=BChrt.\n"
+"Bitte geben Sie eine Commit-Beschreibung ein um zu erkl=C3=A4ren, war=
um dieser\n"
+"Merge erforderlich ist, insbesondere wenn es einen aktualisierten\n"
+"Upstream-Branch mit einem Thema-Branch zusammenf=C3=BChrt.\n"
 "\n"
-"Zeilen beginnend mit '%c' werden ignoriert, und eine leere Beschreibu=
ng "
-"bricht die Eintragung ab.\n"
+"Zeilen beginnend mit '%c' werden ignoriert, und eine leere Beschreibu=
ng\n"
+"bricht den Commit ab.\n"
=20
 #: builtin/merge.c:827
 msgid "Empty commit message."
-msgstr "Leere Versionsbeschreibung"
+msgstr "Leere Commit-Beschreibung"
=20
 #: builtin/merge.c:839
 #, c-format
@@ -6508,32 +6502,31 @@ msgstr "Wunderbar.\n"
 #, c-format
 msgid "Automatic merge failed; fix conflicts and then commit the resul=
t.\n"
 msgstr ""
-"Automatische Zusammenf=C3=BChrung fehlgeschlagen; beheben Sie die Kon=
flikte und "
-"tragen Sie dann das Ergebnis ein.\n"
+"Automatischer Merge fehlgeschlagen; beheben Sie die Konflikte und "
+"committen Sie dann das Ergebnis.\n"
=20
 #: builtin/merge.c:920
 #, c-format
 msgid "'%s' is not a commit"
-msgstr "'%s' ist keine Version"
+msgstr "'%s' ist kein Commit"
=20
 #: builtin/merge.c:961
 msgid "No current branch."
-msgstr "Sie befinden sich auf keinem Zweig."
+msgstr "Sie befinden sich auf keinem Branch."
=20
 #: builtin/merge.c:963
 msgid "No remote for the current branch."
-msgstr "Kein externes Archiv f=C3=BCr den aktuellen Zweig."
+msgstr "Kein Remote-Repository f=C3=BCr den aktuellen Branch."
=20
 #: builtin/merge.c:965
 msgid "No default upstream defined for the current branch."
 msgstr ""
-"Es ist kein externes Standard-Projektarchiv f=C3=BCr den aktuellen Zw=
eig "
-"definiert."
+"Es ist kein Standard-Upstream-Branch f=C3=BCr den aktuellen Branch de=
finiert."
=20
 #: builtin/merge.c:970
 #, c-format
 msgid "No remote tracking branch for %s from %s"
-msgstr "Kein externer =C3=9Cbernahmezweig f=C3=BCr %s von %s"
+msgstr "Kein Remote-Tracking-Branch f=C3=BCr %s von %s"
=20
 #: builtin/merge.c:1057 builtin/merge.c:1214
 #, c-format
@@ -6542,20 +6535,20 @@ msgstr "%s - nichts was wir zusammenf=C3=BChren=
 k=C3=B6nnen"
=20
 #: builtin/merge.c:1125
 msgid "There is no merge to abort (MERGE_HEAD missing)."
-msgstr "Es gibt keine Zusammenf=C3=BChrung zum Abbrechen (vermisse MER=
GE_HEAD)"
+msgstr "Es gibt keinen Merge zum Abbrechen (vermisse MERGE_HEAD)"
=20
 #: builtin/merge.c:1141 git-pull.sh:31
 msgid ""
 "You have not concluded your merge (MERGE_HEAD exists).\n"
 "Please, commit your changes before you can merge."
 msgstr ""
-"Sie haben Ihre Zusammenf=C3=BChrung nicht abgeschlossen (MERGE_HEAD e=
xistiert).\n"
-"Bitte tragen Sie Ihre =C3=84nderungen ein, bevor Sie zusammenf=C3=BCh=
ren k=C3=B6nnen."
+"Sie haben Ihren Merge nicht abgeschlossen (MERGE_HEAD existiert).\n"
+"Bitte committen Sie Ihre =C3=84nderungen, bevor Sie \"merge\" ausf=C3=
=BChren k=C3=B6nnen."
=20
 #: builtin/merge.c:1144 git-pull.sh:34
 msgid "You have not concluded your merge (MERGE_HEAD exists)."
 msgstr ""
-"Sie haben Ihre Zusammenf=C3=BChrung nicht abgeschlossen (MERGE_HEAD e=
xistiert)."
+"Sie haben Ihren Merge nicht abgeschlossen (MERGE_HEAD existiert)."
=20
 #: builtin/merge.c:1148
 msgid ""
@@ -6563,7 +6556,7 @@ msgid ""
 "Please, commit your changes before you can merge."
 msgstr ""
 "Sie haben \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD exist=
iert).\n"
-"Bitte tragen Sie Ihre =C3=84nderungen ein, bevor Sie zusammenf=C3=BCh=
ren k=C3=B6nnen."
+"Bitte committen Sie Ihre =C3=84nderungen, bevor Sie \"merge\" ausf=C3=
=BChren k=C3=B6nnen."
=20
 #: builtin/merge.c:1151
 msgid "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exist=
s)."
@@ -6580,43 +6573,44 @@ msgstr "Sie k=C3=B6nnen --no-ff nicht mit --ff-=
-only kombinieren."
=20
 #: builtin/merge.c:1172
 msgid "No commit specified and merge.defaultToUpstream not set."
-msgstr "Keine Version angegeben und merge.defaultToUpstream ist nicht =
gesetzt."
+msgstr "Kein Commit angegeben und merge.defaultToUpstream ist nicht ge=
setzt."
=20
 #: builtin/merge.c:1204
 msgid "Can merge only exactly one commit into empty head"
-msgstr "Kann nur exakt eine Version in einem leeren Zweig zusammenf=C3=
=BChren."
+msgstr "Kann nur exakt einen Commit in einem leeren Branch zusammenf=C3=
=BChren."
=20
 #: builtin/merge.c:1207
 msgid "Squash commit into empty head not supported yet"
-msgstr "Bin auf einem Zweig, der noch geboren wird; kann nicht quetsch=
en."
+msgstr "Bin auf einem Commit, der noch geboren wird; kann \"squash\" n=
icht "
+"ausf=C3=BChren."
=20
 #: builtin/merge.c:1209
 msgid "Non-fast-forward commit does not make sense into an empty head"
 msgstr ""
-"Nicht vorzuspulende Version kann nicht in einem leeren Zweig verwende=
t "
+"Nicht vorzuspulender Commit kann nicht in einem leeren Branch verwend=
et "
 "werden."
=20
 #: builtin/merge.c:1265
 #, c-format
 msgid "Commit %s has an untrusted GPG signature, allegedly by %s."
 msgstr ""
-"Version %s hat eine nicht vertrauensw=C3=BCrdige GPG-Signatur, angebl=
ich von %s."
+"Commit %s hat eine nicht vertrauensw=C3=BCrdige GPG-Signatur, angebli=
ch von %s."
=20
 #: builtin/merge.c:1268
 #, c-format
 msgid "Commit %s has a bad GPG signature allegedly by %s."
-msgstr "Version %s hat eine ung=C3=BCltige GPG-Signatur, angeblich von=
 %s."
+msgstr "Commit %s hat eine ung=C3=BCltige GPG-Signatur, angeblich von =
%s."
=20
 #. 'N'
 #: builtin/merge.c:1271
 #, c-format
 msgid "Commit %s does not have a GPG signature."
-msgstr "Version %s hat keine GPG-Signatur."
+msgstr "Commit %s hat keine GPG-Signatur."
=20
 #: builtin/merge.c:1274
 #, c-format
 msgid "Commit %s has a good GPG signature by %s\n"
-msgstr "Version %s hat eine g=C3=BCltige GPG-Signatur von %s\n"
+msgstr "Commit %s hat eine g=C3=BCltige GPG-Signatur von %s\n"
=20
 #: builtin/merge.c:1358
 #, c-format
@@ -6626,7 +6620,7 @@ msgstr "Aktualisiere %s..%s\n"
 #: builtin/merge.c:1397
 #, c-format
 msgid "Trying really trivial in-index merge...\n"
-msgstr "Probiere wirklich triviale \"in-index\"-Zusammenf=C3=BChrung..=
=2E\n"
+msgstr "Probiere wirklich trivialen \"in-index\"-Merge...\n"
=20
 #: builtin/merge.c:1404
 #, c-format
@@ -6640,22 +6634,22 @@ msgstr "Vorspulen nicht m=C3=B6glich, breche ab=
=2E"
 #: builtin/merge.c:1459 builtin/merge.c:1538
 #, c-format
 msgid "Rewinding the tree to pristine...\n"
-msgstr "R=C3=BCcklauf des Zweiges bis zum Ursprung...\n"
+msgstr "R=C3=BCcklauf des Verzeichnisses bis zum Ursprung...\n"
=20
 #: builtin/merge.c:1463
 #, c-format
 msgid "Trying merge strategy %s...\n"
-msgstr "Probiere Zusammenf=C3=BChrungsstrategie %s...\n"
+msgstr "Probiere Merge-Strategie %s...\n"
=20
 #: builtin/merge.c:1529
 #, c-format
 msgid "No merge strategy handled the merge.\n"
-msgstr "Keine Zusammenf=C3=BChrungsstrategie behandelt diese Zusammenf=
=C3=BChrung.\n"
+msgstr "Keine Merge-Strategie behandelt diesen Merge.\n"
=20
 #: builtin/merge.c:1531
 #, c-format
 msgid "Merge with strategy %s failed.\n"
-msgstr "Zusammenf=C3=BChrung mit Strategie %s fehlgeschlagen.\n"
+msgstr "Merge mit Strategie %s fehlgeschlagen.\n"
=20
 #: builtin/merge.c:1540
 #, c-format
@@ -6666,40 +6660,39 @@ msgstr "Benutzen Sie \"%s\" um die Aufl=C3=B6su=
ng per Hand vorzubereiten.\n"
 #, c-format
 msgid "Automatic merge went well; stopped before committing as request=
ed\n"
 msgstr ""
-"Automatische Zusammenf=C3=BChrung abgeschlossen; halte, wie gew=C3=BC=
nscht, vor der "
-"Eintragung an\n"
+"Automatischer Merge abgeschlossen; halte, wie gew=C3=BCnscht, vor dem=
 Commit an\n"
=20
 #: builtin/merge-base.c:26
 msgid "git merge-base [-a|--all] <commit> <commit>..."
-msgstr "git merge-base [-a|--all] <Version> <Version>..."
+msgstr "git merge-base [-a|--all] <Commit> <Commit>..."
=20
 #: builtin/merge-base.c:27
 msgid "git merge-base [-a|--all] --octopus <commit>..."
-msgstr "git merge-base [-a|--all] --octopus <Version>..."
+msgstr "git merge-base [-a|--all] --octopus <Commit>..."
=20
 #: builtin/merge-base.c:28
 msgid "git merge-base --independent <commit>..."
-msgstr "git merge-base --independent <Version>..."
+msgstr "git merge-base --independent <Commit>..."
=20
 #: builtin/merge-base.c:29
 msgid "git merge-base --is-ancestor <commit> <commit>"
-msgstr "git merge-base --is-ancestor <Version> <Version>"
+msgstr "git merge-base --is-ancestor <Commit> <Commit>"
=20
 #: builtin/merge-base.c:98
 msgid "output all common ancestors"
-msgstr "Ausgabe aller gemeinsamen Vorfahren"
+msgstr "Ausgabe aller gemeinsamen Vorg=C3=A4nger-Commits"
=20
 #: builtin/merge-base.c:99
 msgid "find ancestors for a single n-way merge"
-msgstr "findet Vorfahren f=C3=BCr eine einzelne n-Wege-Zusammenf=C3=BC=
hrung"
+msgstr "findet Vorg=C3=A4nger-Commits f=C3=BCr einen einzelnen n-Wege-=
Merge"
=20
 #: builtin/merge-base.c:100
 msgid "list revs not reachable from others"
-msgstr "listet Versionen auf, die nicht durch Andere erreichbar sind"
+msgstr "listet Commits auf, die nicht durch Andere erreichbar sind"
=20
 #: builtin/merge-base.c:102
 msgid "is the first one ancestor of the other?"
-msgstr "ist der Erste ein Vorfahre von dem Anderen?"
+msgstr "ist der Erste ein Vorg=C3=A4nger-Commit von dem Anderen?"
=20
 #: builtin/merge-file.c:8
 msgid ""
@@ -6715,7 +6708,7 @@ msgstr "sendet Ergebnisse zur Standard-Ausgabe"
=20
 #: builtin/merge-file.c:34
 msgid "use a diff3 based merge"
-msgstr "verwendet eine diff3 basierte Zusammenf=C3=BChrung"
+msgstr "verwendet einen diff3 basierten Merge"
=20
 #: builtin/merge-file.c:35
 msgid "for conflicts, use our version"
@@ -6755,7 +6748,7 @@ msgstr "erlaubt fehlende Objekte"
=20
 #: builtin/mktree.c:155
 msgid "allow creation of more than one tree"
-msgstr "erlaubt die Erstellung von mehr als einem Baum"
+msgstr "erlaubt die Erstellung von mehr als einem \"Tree\"-Objekt"
=20
 #: builtin/mv.c:14
 msgid "git mv [options] <source>... <destination>"
@@ -6789,7 +6782,7 @@ msgstr "kann Verzeichnis nicht =C3=BCber Datei ve=
rschieben"
 #: builtin/mv.c:128
 #, c-format
 msgid "Huh? %.*s is in index?"
-msgstr "Huh? %.*s ist in der Bereitstellung?"
+msgstr "Huh? %.*s ist zum Commit vorgemerkt?"
=20
 #: builtin/mv.c:140
 msgid "source directory is empty"
@@ -6833,7 +6826,7 @@ msgstr "Umbenennung von '%s' fehlgeschlagen"
=20
 #: builtin/name-rev.c:175
 msgid "git name-rev [options] <commit>..."
-msgstr "git name-rev [Optionen] <Version>..."
+msgstr "git name-rev [Optionen] <Commit>..."
=20
 #: builtin/name-rev.c:176
 msgid "git name-rev [options] --all"
@@ -6849,7 +6842,7 @@ msgstr "zeigt nur Namen an (keine SHA-1)"
=20
 #: builtin/name-rev.c:230
 msgid "only use tags to name the commits"
-msgstr "verwendet nur Markierungen um die Versionen zu benennen"
+msgstr "verwendet nur Tags um die Commits zu benennen"
=20
 #: builtin/name-rev.c:232
 msgid "only use refs matching <pattern>"
@@ -6857,7 +6850,7 @@ msgstr "verwendet nur Referenzen die <Muster> ent=
sprechen"
=20
 #: builtin/name-rev.c:234
 msgid "list all commits reachable from all refs"
-msgstr "listet alle Versionen auf, die von allen Referenzen erreichbar=
 sind"
+msgstr "listet alle Commits auf, die von allen Referenzen erreichbar s=
ind"
=20
 #: builtin/name-rev.c:235
 msgid "read from stdin"
@@ -7042,7 +7035,8 @@ msgstr "Fehler beim Lesen des Objektes '%s'."
=20
 #: builtin/notes.c:298
 msgid "Cannot commit uninitialized/unreferenced notes tree"
-msgstr "Kann uninitialisierten/unreferenzierten Notiz-Baum nicht eintr=
agen."
+msgstr "Kann uninitialisiertes/unreferenzierte Notiz-Verzeichnis nicht=
 "
+"committen."
=20
 #: builtin/notes.c:339
 #, c-format
@@ -7165,7 +7159,7 @@ msgstr "Allgemeine Optionen"
=20
 #: builtin/notes.c:865
 msgid "Merge options"
-msgstr "Optionen f=C3=BCr Zusammenf=C3=BChrung"
+msgstr "Merge-Optionen"
=20
 #: builtin/notes.c:867
 msgid ""
@@ -7182,16 +7176,16 @@ msgstr "tr=C3=A4gt nicht zusammengef=C3=BChrte =
Notizen ein"
 #: builtin/notes.c:871
 msgid "finalize notes merge by committing unmerged notes"
 msgstr ""
-"schlie=C3=9Ft Zusammenf=C3=BChrung von Notizen ab, in dem nicht zusam=
mengef=C3=BChrte "
-"Notizen eingetragen werden"
+"schlie=C3=9Ft Merge von Notizen ab, in dem nicht zusammengef=C3=BChrt=
e "
+"Notizen committet werden"
=20
 #: builtin/notes.c:873
 msgid "Aborting notes merge resolution"
-msgstr "bricht Konfliktaufl=C3=B6sung bei Zusammenf=C3=BChrung von Not=
izen ab"
+msgstr "bricht Konfliktaufl=C3=B6sung beim Merge von Notizen ab"
=20
 #: builtin/notes.c:875
 msgid "abort notes merge"
-msgstr "bricht Zusammenf=C3=BChrung von Notizen ab"
+msgstr "bricht Merge von Notizen ab"
=20
 #: builtin/notes.c:970
 #, c-format
@@ -7237,12 +7231,12 @@ msgstr "Fehler beim Komprimieren (%d)"
 #: builtin/pack-objects.c:2397
 #, c-format
 msgid "unsupported index version %s"
-msgstr "Nicht unterst=C3=BCtzte Bereitstellungsversion %s"
+msgstr "Nicht unterst=C3=BCtzte Staging-Area-Version %s"
=20
 #: builtin/pack-objects.c:2401
 #, c-format
 msgid "bad index version '%s'"
-msgstr "Ung=C3=BCltige Bereitstellungsversion '%s'"
+msgstr "Ung=C3=BCltige Staging-Area-Version '%s'"
=20
 #: builtin/pack-objects.c:2424
 #, c-format
@@ -7341,8 +7335,7 @@ msgstr "schlie=C3=9Ft Objekte ein, die von jeder =
Referenz erreichbar sind"
 #: builtin/pack-objects.c:2489
 msgid "include objects referred by reflog entries"
 msgstr ""
-"schlie=C3=9Ft Objekte ein, die von Eintr=C3=A4gen des Referenzprotoko=
lls referenziert "
-"werden"
+"schlie=C3=9Ft Objekte ein, die von Eintr=C3=A4gen des Reflogs referen=
ziert werden"
=20
 #: builtin/pack-objects.c:2492
 msgid "output pack to stdout"
@@ -7351,7 +7344,7 @@ msgstr "schreibt Paket in die Standard-Ausgabe"
 #: builtin/pack-objects.c:2494
 msgid "include tag objects that refer to objects to be packed"
 msgstr ""
-"schlie=C3=9Ft Markierungsobjekte ein, die auf gepackte Objekte refere=
nzieren"
+"schlie=C3=9Ft Tag-Objekte ein, die auf gepackte Objekte referenzieren=
"
=20
 #: builtin/pack-objects.c:2496
 msgid "keep unreachable objects"
@@ -7379,7 +7372,7 @@ msgstr "Komprimierungsgrad f=C3=BCr Paketierung"
=20
 #: builtin/pack-objects.c:2507
 msgid "do not hide commits by grafts"
-msgstr "verbirgt keine Versionen mit k=C3=BCnstlichen Vorg=C3=A4ngern =
(\"grafts\")"
+msgstr "verbirgt keine Commits mit k=C3=BCnstlichen Vorg=C3=A4ngern (\=
"grafts\")"
=20
 #: builtin/pack-refs.c:6
 msgid "git pack-refs [options]"
@@ -7399,7 +7392,7 @@ msgstr "git prune-packed [-n|--dry-run] [-q|--qui=
et]"
=20
 #: builtin/prune.c:12
 msgid "git prune [-n] [-v] [--expire <time>] [--] [<head>...]"
-msgstr "git prune [-n] [-v] [--expire <Zeit>] [--] [<Zweigspitze>...]"
+msgstr "git prune [-n] [-v] [--expire <Zeit>] [--] [<head>...]"
=20
 #: builtin/prune.c:132
 msgid "do not remove, show only"
@@ -7415,11 +7408,11 @@ msgstr "l=C3=A4sst Objekte =C3=A4lter als <Zeit=
> verfallen"
=20
 #: builtin/push.c:14
 msgid "git push [<options>] [<repository> [<refspec>...]]"
-msgstr "git push [<Optionen>] [<Projektarchiv> [<Referenzspezifikation=
>...]]"
+msgstr "git push [<Optionen>] [<Repository> [<Refspec>...]]"
=20
 #: builtin/push.c:45
 msgid "tag shorthand without <tag>"
-msgstr "Kurzschrift f=C3=BCr Markierung ohne <Markierung>"
+msgstr "Kurzschrift f=C3=BCr Tag ohne <Tag>"
=20
 #: builtin/push.c:64
 msgid "--delete only accepts plain target ref names"
@@ -7448,14 +7441,14 @@ msgid ""
 "    git push %s %s\n"
 "%s"
 msgstr ""
-"Der Name des externen =C3=9Cbernahmezweiges stimmt nicht mit dem Name=
n Ihres\n"
-"aktuellen Zweiges =C3=BCberein. Um auf den =C3=9Cbernahmezweig in dem=
 externen\n"
-"Projektarchiv zu versenden, benutzen Sie:\n"
+"Der Name des Upstream-Branches stimmt nicht mit dem Namen Ihres\n"
+"aktuellen Branches =C3=BCberein. Um auf den Upstream-Branch in dem Re=
mote-\n"
+"Repository zu versenden, benutzen Sie:\n"
 "\n"
 "    git push %s HEAD:%s\n"
 "\n"
-"Um auf den Zweig mit dem selben Namen in dem externen Projekarchiv\n"
-"zu versenden, benutzen Sie:\n"
+"Um auf den Branch mit dem selben Namen im Remote-Repository zu versen=
den,\n"
+"benutzen Sie:\n"
 "\n"
 "    git push %s %s\n"
 "%s"
@@ -7469,11 +7462,11 @@ msgid ""
 "\n"
 "    git push %s HEAD:<name-of-remote-branch>\n"
 msgstr ""
-"Sie befinden sich im Moment auf keinem Zweig.\n"
-"Um die Historie, f=C3=BChrend zum aktuellen (freistehende Zweigspitze=
 (HEAD))\n"
+"Sie befinden sich im Moment auf keinem Branch.\n"
+"Um die Historie, f=C3=BChrend zum aktuellen (losgel=C3=B6ster HEAD)\n=
"
 "Status zu versenden, benutzen Sie\n"
 "\n"
-"    git push %s HEAD:<Name-des-externen-Zweiges>\n"
+"    git push %s HEAD:<Name-des-Remote-Branches>\n"
=20
 #: builtin/push.c:128
 #, c-format
--=20
1.8.2.1230.g519726a
