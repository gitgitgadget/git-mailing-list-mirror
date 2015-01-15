From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 13 new messages
Date: Thu, 15 Jan 2015 18:11:27 +0100
Message-ID: <1421341887-16719-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 18:19:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBo52-0003zR-0C
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 18:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbbAORTb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2015 12:19:31 -0500
Received: from mail-wg0-f42.google.com ([74.125.82.42]:34267 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbbAORT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 12:19:29 -0500
Received: by mail-wg0-f42.google.com with SMTP id k14so16226949wgh.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 09:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=f7hmbgeYolQgxeyk0aPn6mUnmDiQK7k5jaHi0/CYIW8=;
        b=ZI6Pt2q+Walt8cB/pTxkfmQu5vaFQ4CMFCfcLZIYNw0TUoR4xBAkqYnNWdKId62z74
         g844/7ERTjXXu/HN2VWrvzq1l/9OckSBeYomVVLHvJgXVnpBj+OC4zgW7g87S4cFLRle
         hB7auMofPW5oGr28+eoZEv5ttIkoUczzU8yT9ikfX759aLtx6m6FoA4Su7j1JTjeiEEu
         pmKYOiWYygdYXdq8PNL0oR+aA6Wej6ABrslq86UJE+HAoeNudr3nBMJQCbMJEHIu+jFo
         EvfqWsHVm8CmsOwZqxWobbqudYVfIqyJ6+t1L1OHjLCLy4fHABeZSrPOSyTnXdSs8Ao9
         MbUw==
X-Received: by 10.194.108.162 with SMTP id hl2mr19663597wjb.134.1421341891963;
        Thu, 15 Jan 2015 09:11:31 -0800 (PST)
Received: from localhost (dslb-088-073-235-175.088.073.pools.vodafone-ip.de. [88.73.235.175])
        by mx.google.com with ESMTPSA id ej10sm8248950wib.2.2015.01.15.09.11.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Jan 2015 09:11:31 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.174.g1e99f79
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262488>

Translate 13 new messages came from git.pot update in
beb691f (l10n: git.pot: v2.3.0 round 1 (13 new, 11 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/po/de.po b/po/de.po
index 2fa5832..70ca3ff 100644
--- a/po/de.po
+++ b/po/de.po
@@ -3129,9 +3129,8 @@ msgid "edit the description for the branch"
 msgstr "die Beschreibung f=C3=BCr den Branch bearbeiten"
=20
 #: builtin/branch.c:851
-#, fuzzy
 msgid "force creation, move/rename, deletion"
-msgstr "F=C3=BChre Erkennung f=C3=BCr ungenaue Umbenennung aus"
+msgstr "Erstellung, Verschiebung/Umbenennung oder L=C3=B6schung erzwin=
gen"
=20
 #: builtin/branch.c:854
 msgid "print only not merged branches"
@@ -4003,7 +4002,7 @@ msgstr "nur einen Branch klonen, HEAD oder --bran=
ch"
=20
 #: builtin/clone.c:99
 msgid "use --reference only while cloning"
-msgstr ""
+msgstr "--reference nur w=C3=A4hrend des Klonens benutzen"
=20
 #: builtin/clone.c:100 builtin/init-db.c:502
 msgid "gitdir"
@@ -4109,13 +4108,12 @@ msgid "unable to checkout working tree"
 msgstr "Arbeitsverzeichnis konnte nicht ausgecheckt werden"
=20
 #: builtin/clone.c:746
-#, fuzzy
 msgid "cannot repack to clean up"
-msgstr "Kann Paketdatei %s nicht lesen"
+msgstr "Kann \"repack\" zum Aufr=C3=A4umen nicht aufrufen"
=20
 #: builtin/clone.c:748
 msgid "cannot unlink temporary alternates file"
-msgstr ""
+msgstr "Kann tempor=C3=A4re \"alternates\"-Datei nicht entfernen"
=20
 #: builtin/clone.c:778
 msgid "Too many arguments."
@@ -4176,7 +4174,7 @@ msgstr "Klone nach '%s'...\n"
=20
 #: builtin/clone.c:897
 msgid "--dissociate given, but there is no --reference"
-msgstr ""
+msgstr "--dissociate ohne --reference angegeben"
=20
 #: builtin/clone.c:912
 msgid "--depth is ignored in local clones; use file:// instead."
@@ -4964,14 +4962,12 @@ msgid "open an editor"
 msgstr "einen Editor =C3=B6ffnen"
=20
 #: builtin/config.c:72
-#, fuzzy
 msgid "find the color configured: slot [default]"
-msgstr "die konfigurierte Farbe finden: [Standard]"
+msgstr "die konfigurierte Farbe finden: Slot [Standard]"
=20
 #: builtin/config.c:73
-#, fuzzy
 msgid "find the color setting: slot [stdout-is-tty]"
-msgstr "die Farbeinstellung finden: [Standard-Ausgabe-ist-Terminal]"
+msgstr "die Farbeinstellung finden: Slot [Standard-Ausgabe-ist-Termina=
l]"
=20
 #: builtin/config.c:74
 msgid "Type"
@@ -5591,7 +5587,6 @@ msgid "quote placeholders suitably for python"
 msgstr "Platzhalter als Python-String formatieren"
=20
 #: builtin/for-each-ref.c:1078
-#, fuzzy
 msgid "quote placeholders suitably for Tcl"
 msgstr "Platzhalter als Tcl-String formatieren"
=20
@@ -7618,13 +7613,12 @@ msgid "git notes [--ref <notes_ref>] [list [<ob=
ject>]]"
 msgstr "git notes [--ref <Notiz-Referenz>] [list [<Objekt>]]"
=20
 #: builtin/notes.c:25
-#, fuzzy
 msgid ""
 "git notes [--ref <notes_ref>] add [-f] [--allow-empty] [-m <msg> | -F=
 <file> "
 "| (-c | -C) <object>] [<object>]"
 msgstr ""
-"git notes [--ref <Notiz-Referenz>] add [-f] [-m <Nachricht> | -F <Dat=
ei> | (-"
-"c | -C) <Objekt>] [<Objekt>]"
+"git notes [--ref <Notiz-Referenz>] add [-f] [--allow-empty] [-m <Besc=
hreibung> | "
+"-F <Datei> | (-c | -C) <Objekt>] [<Objekt>]"
=20
 #: builtin/notes.c:26
 msgid "git notes [--ref <notes_ref>] copy [-f] <from-object> <to-objec=
t>"
@@ -7632,18 +7626,16 @@ msgstr ""
 "git notes [--ref <Notiz-Referenz>] copy [-f] <von-Objekt> <nach-Objek=
t>"
=20
 #: builtin/notes.c:27
-#, fuzzy
 msgid ""
 "git notes [--ref <notes_ref>] append [--allow-empty] [-m <msg> | -F <=
file> | "
 "(-c | -C) <object>] [<object>]"
 msgstr ""
-"git notes [--ref <Notiz-Referenz>] append [-m <Nachricht> | -F <Datei=
> | (-c "
-"| -C) <Objekt>] [<Objekt>]"
+"git notes [--ref <Notiz-Referenz>] append [--allow-empty] [-m <Beschr=
eibung> | "
+"-F <Datei> | (-c | -C) <Objekt>] [<Objekt>]"
=20
 #: builtin/notes.c:28
-#, fuzzy
 msgid "git notes [--ref <notes_ref>] edit [--allow-empty] [<object>]"
-msgstr "git notes [--ref <Notiz-Referenz>] edit [<Objekt>]"
+msgstr "git notes [--ref <Notiz-Referenz>] edit [--allow-empty] [<Obje=
kt>]"
=20
 #: builtin/notes.c:29
 msgid "git notes [--ref <notes_ref>] show [<object>]"
@@ -7833,7 +7825,7 @@ msgstr "Wiederverwendung des angegebenen Notiz-Ob=
jektes"
=20
 #: builtin/notes.c:404 builtin/notes.c:567
 msgid "allow storing empty note"
-msgstr ""
+msgstr "Speichern leerer Notiz erlauben"
=20
 #: builtin/notes.c:405 builtin/notes.c:476
 msgid "replace existing notes"
@@ -8124,9 +8116,8 @@ msgid "create thin packs"
 msgstr "d=C3=BCnnere Pakete erzeugen"
=20
 #: builtin/pack-objects.c:2682
-#, fuzzy
 msgid "create packs suitable for shallow fetches"
-msgstr "Platzhalter als Shell-String formatieren"
+msgstr "Pakete geeignet f=C3=BCr Abholung mit unvollst=C3=A4ndiger His=
torie (shallow) erzeugen"
=20
 #: builtin/pack-objects.c:2684
 msgid "ignore packs that have companion .keep file"
@@ -9846,7 +9837,7 @@ msgstr "Grund f=C3=BCr die Aktualisierung"
 msgid ""
 "git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<hea=
d>]"
 msgstr ""
-"git tag [-a|-s|-u <Schl=C3=BCssel-id>] [-f] [-m <Nachricht>|-F <Datei=
>] <Tagname> "
+"git tag [-a|-s|-u <Schl=C3=BCssel-id>] [-f] [-m <Beschreibung>|-F <Da=
tei>] <Tagname> "
 "[<Commit>]"
=20
 #: builtin/tag.c:23
--=20
2.3.0.rc0.174.g1e99f79
