From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH/RFC] l10n: de.po: translate 39 new messages
Date: Mon, 15 Apr 2013 18:27:40 +0200
Message-ID: <1366043260-3131-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Mon Apr 15 18:27:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URmG3-0005co-Ur
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 18:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab3DOQ1v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Apr 2013 12:27:51 -0400
Received: from mail-bk0-f42.google.com ([209.85.214.42]:64497 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463Ab3DOQ1t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 12:27:49 -0400
Received: by mail-bk0-f42.google.com with SMTP id jc3so2471965bkc.15
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=ESa04O8mK2cq7ouOZuuErCYD4YPO1bBAYVRGL3tlOp4=;
        b=BKkQ2sFTaSTxInOnZGzmq9z20eGRjRNFKopLqs+aIMKea9VI0g/czxK+n1kgOig35e
         85y5FuPA1Y0wIHFFRYNP5HM+hAmi/krKmVttmixoCdF70Lz533rIcUrl7Wrrlb8xdli6
         9XpVTqaPdImRaSq3+s21dlTY3mGRfCmaSN0cw3Kj/cX55O/qp8lLFaao3z++H/9U0DWo
         zfTtcNNwuaErr8z2i7cnHdgdPTzmMLJwfof7zeFel5gWIcPam3Rywh5/zBWBOe8fw1IY
         xUWTbA5zrsClUbCqsf7WAo5mYopBZkVcHds0OzQVssPhStf/o0YTeKEpSiuctcDxp66J
         TPnw==
X-Received: by 10.204.163.135 with SMTP id a7mr5409573bky.62.1366043267638;
        Mon, 15 Apr 2013 09:27:47 -0700 (PDT)
Received: from localhost (dslb-178-005-125-192.pools.arcor-ip.net. [178.5.125.192])
        by mx.google.com with ESMTPS id jt9sm8892473bkb.18.2013.04.15.09.27.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 09:27:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.557.g0f6ee90
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221246>

Translate 39 new messages came from git.pot update in
c138af5 (l10n: git.pot: v1.8.3 round 1 (54 new, 15 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 186 +++++++++++++++++++++++++++++++++----------------------=
--------
 1 file changed, 97 insertions(+), 89 deletions(-)

diff --git a/po/de.po b/po/de.po
index 2cd3fa9..2514567 100644
--- a/po/de.po
+++ b/po/de.po
@@ -136,12 +136,13 @@ msgstr ""
 #: branch.c:201
 #, c-format
 msgid "Cannot setup tracking information; starting point '%s' is not a=
 branch."
-msgstr ""
+msgstr "Kann Informationen zum =C3=9Cbernahmezweig nicht einrichten; "
+"Startpunkt '%s' ist kein Zweig."
=20
 #: branch.c:203
-#, fuzzy, c-format
+#, c-format
 msgid "the requested upstream branch '%s' does not exist"
-msgstr "Zweig '%s' existiert nicht"
+msgstr "der angeforderte externe =C3=9Cbernahmezweig '%s' existiert ni=
cht"
=20
 #: branch.c:205
 msgid ""
@@ -154,6 +155,15 @@ msgid ""
 "\n"
 "If you are planning on basing your work on an upstream\n"
 "branch that already exists at the remote, you may need to\n"
 "run \"git fetch\" to retrieve it.\n"
 "\n"
 "If you are planning to push out a new local branch that\n"
 "will track its remote counterpart, you may want to use\n"
 "\"git push -u\" to set the upstream config as you push."
 msgstr ""
+"\n"
+"Falls Sie vorhaben, Ihre Arbeit auf einem bereits existierenden,\n"
+"externen =C3=9Cbernahmezweig aufzubauen, sollten Sie \"git fetch\"\n"
+"ausf=C3=BChren, um diesen abzurufen.\n"
+"\n"
+"Falls Sie vorhaben, einen neuen lokalen Zweig zu versenden\n"
+"der seinem externen Gegenst=C3=BCck folgen soll, k=C3=B6nnen Sie\n"
+"\"git push -u\" verwenden, um den externen =C3=9Cbernahmezweig\n"
+"beim Versand zu konfigurieren."
=20
 #: bundle.c:36
 #, c-format
@@ -181,22 +191,22 @@ msgid "revision walk setup failed"
 msgstr "Einrichtung des Revisionsgangs fehlgeschlagen"
=20
 #: bundle.c:186
-#, fuzzy, c-format
+#, c-format
 msgid "The bundle contains this ref:"
 msgid_plural "The bundle contains these %d refs:"
-msgstr[0] "Das Paket enth=C3=A4lt %d Referenz"
-msgstr[1] "Das Paket enth=C3=A4lt %d Referenzen"
+msgstr[0] "Das Paket enth=C3=A4lt diese Referenz:"
+msgstr[1] "Das Paket enth=C3=A4lt diese %d Referenzen:"
=20
 #: bundle.c:193
 msgid "The bundle records a complete history."
 msgstr "Das Paket speichert eine komplette Historie."
=20
 #: bundle.c:195
-#, fuzzy, c-format
+#, c-format
 msgid "The bundle requires this ref:"
 msgid_plural "The bundle requires these %d refs:"
-msgstr[0] "Das Paket ben=C3=B6tigt diese Referenz"
-msgstr[1] "Das Paket ben=C3=B6tigt diese %d Referenzen"
+msgstr[0] "Das Paket ben=C3=B6tigt diese Referenz:"
+msgstr[1] "Das Paket ben=C3=B6tigt diese %d Referenzen:"
=20
 #: bundle.c:294
 msgid "rev-list died"
@@ -731,7 +741,7 @@ msgid "Unable to write index."
 msgstr "Konnte Bereitstellung nicht schreiben."
=20
 #: object.c:195
-#, fuzzy, c-format
+#, c-format
 msgid "unable to parse object: %s"
 msgstr "Konnte Objekt '%s' nicht parsen."
=20
@@ -1376,33 +1386,29 @@ msgid "  (all conflicts fixed: run \"git commit=
\")"
 msgstr "  (alle Konflikte behoben: f=C3=BChren Sie \"git commit\" aus)=
"
=20
 #: wt-status.c:972
-#, fuzzy, c-format
+#, c-format
 msgid "You are currently reverting commit %s."
-msgstr "Sie sind gerade bei einer bin=C3=A4ren Suche in Zweig '%s'."
+msgstr "Sie kehren gerade Version '%s' um."
=20
 #: wt-status.c:977
-#, fuzzy
 msgid "  (fix conflicts and run \"git revert --continue\")"
 msgstr ""
-"  (beheben Sie die Konflikte und f=C3=BChren Sie dann \"git rebase --=
continue\" "
+"  (beheben Sie die Konflikte und f=C3=BChren Sie dann \"git revert --=
continue\" "
 "aus)"
=20
 #: wt-status.c:980
-#, fuzzy
 msgid "  (all conflicts fixed: run \"git revert --continue\")"
-msgstr "  (alle Konflikte behoben: f=C3=BChren Sie \"git rebase --cont=
inue\" aus)"
+msgstr "  (alle Konflikte behoben: f=C3=BChren Sie \"git revert --cont=
inue\" aus)"
=20
 #: wt-status.c:982
-#, fuzzy
 msgid "  (use \"git revert --abort\" to cancel the revert operation)"
 msgstr ""
-"  (benutzen Sie \"git rebase --abort\" um den urspr=C3=BCnglichen Zwe=
ig "
-"auszuchecken)"
+"  (benutzen Sie \"git revert --abort\" um die Umkehroperation abzubre=
chen)"
=20
 #: wt-status.c:993
-#, fuzzy, c-format
+#, c-format
 msgid "You are currently bisecting, started from branch '%s'."
-msgstr "Sie sind gerade bei einer bin=C3=A4ren Suche in Zweig '%s'."
+msgstr "Sie sind gerade bei einer bin=C3=A4ren Suche, gestartet von Zw=
eig '%s'."
=20
 #: wt-status.c:997
 msgid "You are currently bisecting."
@@ -1419,13 +1425,12 @@ msgid "On branch "
 msgstr "Auf Zweig "
=20
 #: wt-status.c:1186
-#, fuzzy
 msgid "HEAD detached at "
-msgstr "losgel=C3=B6ste Zweigspitze (HEAD)"
+msgstr "Zweigspitze (HEAD) losgel=C3=B6st bei "
=20
 #: wt-status.c:1188
 msgid "HEAD detached from "
-msgstr ""
+msgstr "Zweigspitze (HEAD) losgel=C3=B6st von "
=20
 #: wt-status.c:1191
 msgid "Not currently on any branch."
@@ -1446,15 +1451,16 @@ msgstr "Ignorierte Dateien"
 #: wt-status.c:1228
 #, c-format
 msgid "It took %.2f seconds to enumerate untracked files.  'status -un=
o'"
-msgstr ""
+msgstr "Es dauerte %.2f Sekunden die unbeobachteten Dateien zu bestimm=
en."
+"'status -uno'"
=20
 #: wt-status.c:1232
 msgid "may speed it up, but you have to be careful not to forget to ad=
d"
-msgstr ""
+msgstr "k=C3=B6nnte das beschleunigen, aber Sie m=C3=BCssen darauf ach=
ten, neue"
=20
 #: wt-status.c:1235
 msgid "new files yourself (see 'git help status')."
-msgstr ""
+msgstr "Dateien selbstst=C3=A4ndig hinzuzuf=C3=BCgen (siehe 'git help =
status')."
=20
 #: wt-status.c:1238
 #, c-format
@@ -2531,19 +2537,19 @@ msgid " **** invalid ref ****"
 msgstr " **** ung=C3=BCltige Referenz ****"
=20
 #: builtin/branch.c:562
-#, fuzzy, c-format
+#, c-format
 msgid "(no branch, rebasing %s)"
-msgstr "(kein Zweig)"
+msgstr "(kein Zweig, Neuaufbau von Zweig %s im Gange)"
=20
 #: builtin/branch.c:565
 #, c-format
 msgid "(no branch, bisect started on %s)"
-msgstr ""
+msgstr "(kein Zweig, Neuaufbau begonnen bei %s)"
=20
 #: builtin/branch.c:568
-#, fuzzy, c-format
+#, c-format
 msgid "(detached from %s)"
-msgstr "liest von der Standard-Eingabe"
+msgstr "(losgel=C3=B6st von %s)"
=20
 #: builtin/branch.c:571
 msgid "(no branch)"
@@ -2729,18 +2735,19 @@ msgid "too many branches for a rename operation=
"
 msgstr "zu viele Zweige f=C3=BCr eine Umbenennen-Operation angegeben"
=20
 #: builtin/branch.c:919
-#, fuzzy
 msgid "too many branches to set new upstream"
-msgstr "zu viele Zweige f=C3=BCr eine Umbenennen-Operation angegeben"
+msgstr "zu viele Zweige angegeben um neuen =C3=9Cbernahmezweig zu setz=
en"
=20
 #: builtin/branch.c:923
 #, c-format
 msgid ""
 "could not set upstream of HEAD to %s when it does not point to any br=
anch."
 msgstr ""
+"Konnte keinen neuen =C3=9Cbernahmezweig von Zweigspitze (HEAD) zu %s =
setzen,\n"
+"da diese auf keinen Zweig zeigt."
=20
 #: builtin/branch.c:926 builtin/branch.c:948 builtin/branch.c:970
-#, fuzzy, c-format
+#, c-format
 msgid "no such branch '%s'"
 msgstr "Kein solcher Zweig '%s'"
=20
@@ -2750,14 +2757,13 @@ msgid "branch '%s' does not exist"
 msgstr "Zweig '%s' existiert nicht"
=20
 #: builtin/branch.c:942
-#, fuzzy
 msgid "too many branches to unset upstream"
-msgstr "zu viele Zweige f=C3=BCr eine Umbenennen-Operation angegeben"
+msgstr "zu viele Zweige angegeben um Konfiguration zu =C3=9Cbernahmezw=
eig zu entfernen"
=20
 #: builtin/branch.c:946
-#, fuzzy
 msgid "could not unset upstream of HEAD when it does not point to any =
branch."
-msgstr "Zweigspitze (HEAD) zeigt auf keinen Zweig"
+msgstr "Konnte Konfiguration zum =C3=9Cbernahmezweig von Zweigspitze (=
HEAD) nicht\n"
+"entfernen, da diese auf keinen Zweig zeigt."
=20
 #: builtin/branch.c:952
 #, c-format
@@ -2766,7 +2772,7 @@ msgstr "Zweig '%s' hat keinen externen =C3=9Cbern=
ahmezweig gesetzt"
=20
 #: builtin/branch.c:967
 msgid "it does not make sense to create 'HEAD' manually"
-msgstr ""
+msgstr "'HEAD' darf nicht manuell erstellt werden"
=20
 #: builtin/branch.c:973
 msgid "-a and -r options to 'git branch' do not make sense with a bran=
ch name"
@@ -3467,6 +3473,9 @@ msgid ""
 "You can inspect what was checked out with 'git status'\n"
 "and retry the checkout with 'git checkout -f HEAD'\n"
 msgstr ""
+"Klonen erfolgreich, Auschecken ist aber fehlgeschlagen.\n"
+"Sie k=C3=B6nnen mit 'git status' pr=C3=BCfen, was ausgecheckt worden =
ist\n"
+"und das Auschecken mit 'git checkout -f HEAD' erneut versuchen.\n"
=20
 #: builtin/clone.c:466
 #, c-format
@@ -3474,9 +3483,8 @@ msgid "Could not find remote branch %s to clone."
 msgstr "Konnte zu klonenden externer Zweig %s nicht finden."
=20
 #: builtin/clone.c:540
-#, fuzzy
 msgid "remote did not send all necessary objects"
-msgstr "%s hat nicht alle erforderlichen Objekte gesendet\n"
+msgstr "Fernarchiv hat nicht alle erforderlichen Objekte gesendet."
=20
 #: builtin/clone.c:600
 msgid "remote HEAD refers to nonexistent ref, unable to checkout.\n"
@@ -3485,9 +3493,8 @@ msgstr ""
 "und kann nicht ausgecheckt werden.\n"
=20
 #: builtin/clone.c:631
-#, fuzzy
 msgid "unable to checkout working tree"
-msgstr "konnte %s nicht schreiben"
+msgstr "Arbeitsbaum konnte nicht ausgecheckt werden"
=20
 #: builtin/clone.c:739
 msgid "Too many arguments."
@@ -4382,13 +4389,12 @@ msgid "debug search strategy on stderr"
 msgstr "protokolliert die Suchstrategie in der Standard-Fehlerausgabe"
=20
 #: builtin/describe.c:404
-#, fuzzy
 msgid "use any ref"
-msgstr "versendet alle Referenzen"
+msgstr "verwendet alle Referenzen"
=20
 #: builtin/describe.c:405
 msgid "use any tag, even unannotated"
-msgstr ""
+msgstr "verwendet jede Markierung, auch nicht-annotierte"
=20
 #: builtin/describe.c:406
 msgid "always use long format"
@@ -6179,7 +6185,7 @@ msgstr "bricht ab, wenn kein Vorspulen m=C3=B6gli=
ch ist"
=20
 #: builtin/merge.c:203
 msgid "Verify that the named commit has a valid GPG signature"
-msgstr ""
+msgstr "=C3=BCberpr=C3=BCft die genannte Version auf eine g=C3=BCltige=
 GPG-Signatur"
=20
 #: builtin/merge.c:204 builtin/notes.c:866 builtin/revert.c:112
 msgid "strategy"
@@ -6409,23 +6415,24 @@ msgstr ""
 #: builtin/merge.c:1265
 #, c-format
 msgid "Commit %s has an untrusted GPG signature, allegedly by %s."
-msgstr ""
+msgstr "Version %s hat eine nicht vertrauensw=C3=BCrdige GPG-Signatur,=
 "
+"vermeintlich von %s."
=20
 #: builtin/merge.c:1268
 #, c-format
 msgid "Commit %s has a bad GPG signature allegedly by %s."
-msgstr ""
+msgstr "Version %s hat eine ung=C3=BCltige GPG-Signatur, vermeintlich =
von %s."
=20
 #. 'N'
 #: builtin/merge.c:1271
-#, fuzzy, c-format
+#, c-format
 msgid "Commit %s does not have a GPG signature."
-msgstr "Version %s hat keinen Elternteil %d"
+msgstr "Version %s hat keine GPG-Signatur."
=20
 #: builtin/merge.c:1274
 #, c-format
 msgid "Commit %s has a good GPG signature by %s\n"
-msgstr ""
+msgstr "Version %s hat eine g=C3=BCltige GPG-Signatur von %s\n"
=20
 #: builtin/merge.c:1358
 #, c-format
@@ -7549,7 +7556,7 @@ msgstr "umgeht \"pre-push hook\""
=20
 #: builtin/push.c:440
 msgid "push missing but relevant tags"
-msgstr ""
+msgstr "versendet fehlende, aber relevante Markierungen"
=20
 #: builtin/push.c:450
 msgid "--delete is incompatible with --all, --mirror and --tags"
@@ -9974,23 +9981,22 @@ msgstr ""
 "fehlgeschlagen"
=20
 #: git-submodule.sh:588
-#, fuzzy, sh-format
+#, sh-format
 msgid "Use '.' if you really want to deinitialize all submodules"
-msgstr "Verwenden Sie -f wenn Sie diese wirklich hinzuf=C3=BCgen m=C3=B6=
chten.\n"
+msgstr "Verwenden Sie '.' wenn Sie wirklich alle Unterprojekte\n"
+"deinitialisieren m=C3=B6chten."
=20
 #: git-submodule.sh:603
 #, sh-format
 msgid "Submodule work tree '$sm_path' contains a .git directory"
-msgstr ""
+msgstr "Arbeitsbaum des Unterprojekts in '$sm_path' enth=C3=A4lt ein .=
git-Verzeichnis"
=20
 #: git-submodule.sh:604
-#, fuzzy, sh-format
+#, sh-format
 msgid ""
 "(use 'rm -rf' if you really want to remove it including all of its hi=
story)"
 msgstr ""
-"Unterprojekt '%s' (oder ein geschachteltes Unterprojekt hiervon) verw=
endet\n"
-"ein .git-Verzeichnis (benutzen Sie 'rm -rf' wenn Sie dieses wirklich =
"
-"mitsamt\n"
+"(benutzen Sie 'rm -rf' wenn Sie dieses Unterprojekt wirklich mitsamt\=
n"
 "seiner Historie l=C3=B6schen m=C3=B6chten)"
=20
 #: git-submodule.sh:610
@@ -9999,40 +10005,42 @@ msgid ""
 "Submodule work tree '$sm_path' contains local modifications; use '-f'=
 to "
 "discard them"
 msgstr ""
+"Arbeitsbaum von Unterprojekt in '$sm_path' enth=C3=A4lt lokale =C3=84=
nderungen; "
+"verwenden Sie '-f' um diese zu verwerfen"
=20
 #: git-submodule.sh:613
-#, fuzzy, sh-format
+#, sh-format
 msgid "Cleared directory '$sm_path'"
-msgstr "Konnte Verzeichnis '%s' nicht erstellen."
+msgstr "Verzeichnis '$sm_path' bereinigt."
=20
 #: git-submodule.sh:614
-#, fuzzy, sh-format
+#, sh-format
 msgid "Could not remove submodule work tree '$sm_path'"
-msgstr "Registierung von Unterprojekt '$sm_path' fehlgeschlagen"
+msgstr "Konnte Arbeitsbaum des Unterprojektes in '$sm_path' nicht l=C3=
=B6schen."
=20
 #: git-submodule.sh:617
-#, fuzzy, sh-format
+#, sh-format
 msgid "Could not create empty submodule directory '$sm_path'"
-msgstr "Konnte Verzeichnis '%s' nicht erstellen."
+msgstr "Konnte kein leeres Verzeichnis f=C3=BCr Unterprojekt in '$sm_p=
ath' erstellen."
=20
 #: git-submodule.sh:626
-#, fuzzy, sh-format
+#, sh-format
 msgid "Submodule '$name' ($url) unregistered for path '$sm_path'"
-msgstr "Unterprojekt '$name' ($url) ist f=C3=BCr Pfad '$sm_path' regis=
triert"
+msgstr "Unterprojekt '$name' ($url) ist nicht f=C3=BCr Pfad '$sm_path'=
 registriert."
=20
 #: git-submodule.sh:731
-#, fuzzy, sh-format
+#, sh-format
 msgid ""
 "Submodule path '$prefix$sm_path' not initialized\n"
 "Maybe you want to use 'update --init'?"
 msgstr ""
-"Unterprojekt-Pfad '$sm_path' ist nicht initialisiert\n"
+"Unterprojekt-Pfad '$prefix$sm_path' ist nicht initialisiert.\n"
 "Vielleicht m=C3=B6chten Sie 'update --init' benutzen?"
=20
 #: git-submodule.sh:744
-#, fuzzy, sh-format
+#, sh-format
 msgid "Unable to find current revision in submodule path '$prefix$sm_p=
ath'"
-msgstr "Konnte aktuelle Revision in Unterprojekt-Pfad '$sm_path' nicht=
 finden"
+msgstr "Konnte aktuelle Revision in Unterprojekt-Pfad '$prefix$sm_path=
' nicht finden."
=20
 #: git-submodule.sh:753
 #, sh-format
@@ -10040,45 +10048,45 @@ msgid "Unable to fetch in submodule path '$sm=
_path'"
 msgstr "Konnte in Unterprojekt-Pfad '$sm_path' nicht anfordern"
=20
 #: git-submodule.sh:777
-#, fuzzy, sh-format
+#, sh-format
 msgid "Unable to fetch in submodule path '$prefix$sm_path'"
-msgstr "Konnte in Unterprojekt-Pfad '$sm_path' nicht anfordern"
+msgstr "Konnte in Unterprojekt-Pfad '$prefix$sm_path' nicht anfordern"
=20
 #: git-submodule.sh:791
-#, fuzzy, sh-format
+#, sh-format
 msgid "Unable to rebase '$sha1' in submodule path '$prefix$sm_path'"
-msgstr "Neuaufbau von '$sha1' in Unterprojekt-Pfad '$sm_path' nicht m=C3=
=B6glich"
+msgstr "Neuaufbau von '$sha1' in Unterprojekt-Pfad '$prefix$sm_path' n=
icht m=C3=B6glich"
=20
 #: git-submodule.sh:792
-#, fuzzy, sh-format
+#, sh-format
 msgid "Submodule path '$prefix$sm_path': rebased into '$sha1'"
-msgstr "Unterprojekt-Pfad '$sm_path': neu aufgebaut in '$sha1'"
+msgstr "Unterprojekt-Pfad '$prefix$sm_path': neu aufgebaut in '$sha1'"
=20
 #: git-submodule.sh:797
-#, fuzzy, sh-format
+#, sh-format
 msgid "Unable to merge '$sha1' in submodule path '$prefix$sm_path'"
 msgstr ""
-"Zusammenf=C3=BChrung von '$sha1' in Unterprojekt-Pfad '$sm_path' fehl=
geschlagen"
+"Zusammenf=C3=BChrung von '$sha1' in Unterprojekt-Pfad '$prefix$sm_pat=
h' fehlgeschlagen"
=20
 #: git-submodule.sh:798
-#, fuzzy, sh-format
+#, sh-format
 msgid "Submodule path '$prefix$sm_path': merged in '$sha1'"
-msgstr "Unterprojekt-Pfad '$sm_path': zusammengef=C3=BChrt in '$sha1'"
+msgstr "Unterprojekt-Pfad '$prefix$sm_path': zusammengef=C3=BChrt in '=
$sha1'"
=20
 #: git-submodule.sh:803
-#, fuzzy, sh-format
+#, sh-format
 msgid "Unable to checkout '$sha1' in submodule path '$prefix$sm_path'"
-msgstr "Konnte '$sha1' in Unterprojekt-Pfad '$sm_path' nicht auschecke=
n."
+msgstr "Konnte '$sha1' in Unterprojekt-Pfad '$prefix$sm_path' nicht au=
schecken."
=20
 #: git-submodule.sh:804
-#, fuzzy, sh-format
+#, sh-format
 msgid "Submodule path '$prefix$sm_path': checked out '$sha1'"
-msgstr "Unterprojekt-Pfad: '$sm_path': '$sha1' ausgecheckt"
+msgstr "Unterprojekt-Pfad: '$prefix$sm_path': '$sha1' ausgecheckt"
=20
 #: git-submodule.sh:831
-#, fuzzy, sh-format
+#, sh-format
 msgid "Failed to recurse into submodule path '$prefix$sm_path'"
-msgstr "Fehler bei Rekursion in Unterprojekt-Pfad '$sm_path'"
+msgstr "Fehler bei Rekursion in Unterprojekt-Pfad '$prefix$sm_path'"
=20
 #: git-submodule.sh:939
 msgid "The --cached option cannot be used with the --files option"
--=20
1.8.2.1.557.g0f6ee90
