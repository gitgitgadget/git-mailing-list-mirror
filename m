From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BRFC=5D=20l10n=3A=20de=2Epo=3A=20translate=2076=20new=20messages?=
Date: Thu,  2 Aug 2012 19:12:05 +0200
Message-ID: <1343927525-3338-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, worldhello.net@gmail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Thu Aug 02 19:12:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Swywx-0000GT-81
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 19:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754457Ab2HBRMd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Aug 2012 13:12:33 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59731 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab2HBRMb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 13:12:31 -0400
Received: by bkwj10 with SMTP id j10so4357336bkw.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 10:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=PFAxYvSswixwntQWE59PYJWy0mbXAi7scRfrbBu3f1I=;
        b=0cJH2dtr1arUegr90kJ/XbC282acW4XKXBtRqyk6sHIZJRgsmfL2kWv+zOad4wfV/3
         1cxNBQy+HlE+zW9sXX333ofEBZNTxiQSvk2bjffg3/cVoRwFTBt78ZzY2JSe1znHlZKQ
         Mx4ZXaw33A4MbG7w94io45FsTF2uNBr6EsXrIoDyDgQp90zqCoX7q9RIfgXJ+5g9eEpo
         4vZasc2xUHIDGIL0LWX3YFrcoFTUD1OuKqwx1HaOvDEenN3VYOmUlRTKAXn/b1tdHV8s
         UG4peT5u2Ml8bkrD8IpN8DxWGARAHRFO2/yVCIMalixy0IeJ8Fdga0+i6U2SUplZILNQ
         Y2/g==
Received: by 10.204.130.146 with SMTP id t18mr8619473bks.65.1343927549750;
        Thu, 02 Aug 2012 10:12:29 -0700 (PDT)
Received: from rath.fedora (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id 14sm3781162bkw.15.2012.08.02.10.12.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 10:12:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202784>

Translate 76 new messages came from git.pot update
in 3b6137f (l10n: Update git.pot (76 new, 4 removed
messages)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---

Hi German l10n team,

please review this update of German translation.
Please note that this patch is based on a preparation
commit which just contains the "msgmerge", so it might
not be applicable directly.

Thanks

 po/de.po | 214 ++++++++++++++++++++++++++++++++++---------------------=
--------
 1 file changed, 114 insertions(+), 100 deletions(-)

diff --git a/po/de.po b/po/de.po
index 679f14b..a208c56 100644
--- a/po/de.po
+++ b/po/de.po
@@ -232,9 +232,8 @@ msgstr ""
 "%s"
=20
 #: diff.c:1400
-#, fuzzy
 msgid " 0 files changed"
-msgstr " 0 Dateien ge=C3=A4ndert\n"
+msgstr " 0 Dateien ge=C3=A4ndert"
=20
 #: diff.c:1404
 #, c-format
@@ -351,57 +350,56 @@ msgstr[1] ""
 #: merge-recursive.c:190
 #, c-format
 msgid "(bad commit)\n"
-msgstr ""
+msgstr "(ung=C3=BCltige Version)\n"
=20
 #: merge-recursive.c:206
-#, fuzzy, c-format
+#, c-format
 msgid "addinfo_cache failed for path '%s'"
-msgstr "make_cache_entry f=C3=BCr Pfad '%s' fehlgeschlagen"
+msgstr "addinfo_cache f=C3=BCr Pfad '%s' fehlgeschlagen"
=20
 #: merge-recursive.c:268
-#, fuzzy
 msgid "error building trees"
-msgstr "Fehler beim Erzeugen der Zweige"
+msgstr "Fehler beim Erstellen der B=C3=A4ume"
=20
 #: merge-recursive.c:497
-#, fuzzy
 msgid "diff setup failed"
-msgstr "diff_setup_done fehlgeschlagen"
+msgstr "Einrichtung der Optionen zur Bestimmung der Unterschiede "
+"fehlgeschlagen"
=20
 #: merge-recursive.c:627
 msgid "merge-recursive: disk full?"
-msgstr ""
+msgstr "merge-recursive: Speicher voll?"
=20
 #: merge-recursive.c:690
-#, fuzzy, c-format
+#, c-format
 msgid "failed to create path '%s'%s"
-msgstr "Konnte Verkn=C3=BCpfung '%s' nicht erstellen"
+msgstr "Fehler beim Erstellen des Pfades '%s'%s"
=20
 #: merge-recursive.c:701
-#, fuzzy, c-format
+#, c-format
 msgid "Removing %s to make room for subdirectory\n"
-msgstr "Entferne Notiz f=C3=BCr Objekt %s\n"
+msgstr "Entferne %s um Platz f=C3=BCr Unterverzeichnis zu schaffen\n"
=20
 #. something else exists
 #. .. but not some other error (who really cares what?)
 #: merge-recursive.c:715 merge-recursive.c:736
 msgid ": perhaps a D/F conflict?"
-msgstr ""
+msgstr ": vielleicht ein D/F-Konflikt?"
=20
 #: merge-recursive.c:726
-#, fuzzy, c-format
+#, c-format
 msgid "refusing to lose untracked file at '%s'"
-msgstr "Ung=C3=BCltiger Modus '%s' f=C3=BCr unbeobachtete Dateien"
+msgstr "verweigere, da ungefolgte Dateien in '%s' verloren gehen w=C3=BC=
rden"
=20
 #: merge-recursive.c:766
-#, fuzzy, c-format
+#, c-format
 msgid "cannot read object %s '%s'"
-msgstr "Kann %s nicht lesen: %s"
+msgstr "kann Objekt %s '%s' nicht lesen"
=20
 #: merge-recursive.c:768
 #, c-format
 msgid "blob expected for %s '%s'"
-msgstr ""
+msgstr "Blob erwartet f=C3=BCr %s '%s'"
=20
 #: merge-recursive.c:791 builtin/clone.c:302
 #, c-format
@@ -409,27 +407,27 @@ msgid "failed to open '%s'"
 msgstr "Fehler beim =C3=96ffnen von '%s'"
=20
 #: merge-recursive.c:799
-#, fuzzy, c-format
+#, c-format
 msgid "failed to symlink '%s'"
-msgstr "Konnte '%s' nicht entfernen"
+msgstr "Fehler beim Erstellen einer symbolischen Verkn=C3=BCpfung f=C3=
=BCr '%s'"
=20
 #: merge-recursive.c:802
 #, c-format
 msgid "do not know what to do with %06o %s '%s'"
-msgstr ""
+msgstr "wei=C3=9F nicht was mit %06o %s '%s' zu machen ist"
=20
 #: merge-recursive.c:939
 msgid "Failed to execute internal merge"
-msgstr ""
+msgstr "Fehler bei Ausf=C3=BChrung der internen Zusammenf=C3=BChrung"
=20
 #: merge-recursive.c:943
-#, fuzzy, c-format
+#, c-format
 msgid "Unable to add %s to database"
-msgstr "Konnte %s nicht nach %s verschieben"
+msgstr "Konnte %s nicht zur Datenbank hinzuf=C3=BCgen"
=20
 #: merge-recursive.c:959
 msgid "unsupported object type in the tree"
-msgstr ""
+msgstr "nicht unterst=C3=BCtzter Objekttyp im Baum"
=20
 #: merge-recursive.c:1038 merge-recursive.c:1052
 #, c-format
@@ -437,6 +435,8 @@ msgid ""
 "CONFLICT (%s/delete): %s deleted in %s and %s in %s. Version %s of %s=
 left "
 "in tree."
 msgstr ""
+"KONFLIKT (%s/delete): %s gel=C3=B6scht in %s und %s in %s. Stand %s v=
on %s wurde "
+"im Arbeitsbereich gelassen."
=20
 #: merge-recursive.c:1044 merge-recursive.c:1057
 #, c-format
@@ -444,19 +444,21 @@ msgid ""
 "CONFLICT (%s/delete): %s deleted in %s and %s in %s. Version %s of %s=
 left "
 "in tree at %s."
 msgstr ""
+"KONFLIKT (%s/delete): %s gel=C3=B6scht in %s und %s in %s. Stand %s v=
on %s wurde "
+"im Arbeitsbereich bei %s gelassen."
=20
 #: merge-recursive.c:1098
 msgid "rename"
-msgstr ""
+msgstr "rename"
=20
 #: merge-recursive.c:1098
 msgid "renamed"
-msgstr ""
+msgstr "renamed"
=20
 #: merge-recursive.c:1154
 #, c-format
 msgid "%s is a directory in %s adding as %s instead"
-msgstr ""
+msgstr "%s ist ein Verzeichnis in %s, f=C3=BCge es stattdessen als %s =
hinzu"
=20
 #: merge-recursive.c:1176
 #, c-format
@@ -464,72 +466,74 @@ msgid ""
 "CONFLICT (rename/rename): Rename \"%s\"->\"%s\" in branch \"%s\" rena=
me \"%s"
 "\"->\"%s\" in \"%s\"%s"
 msgstr ""
+"KONFLIKT (rename/rename): Benenne um \"%s\"->\"%s\" in Zweig \"%s\" u=
nd "
+"\"%s\"->\"%s\" in Zweig \"%s\"%s"
=20
 #: merge-recursive.c:1181
 msgid " (left unresolved)"
-msgstr ""
+msgstr " (bleibt unaufgel=C3=B6st)"
=20
 #: merge-recursive.c:1235
 #, c-format
 msgid "CONFLICT (rename/rename): Rename %s->%s in %s. Rename %s->%s in=
 %s"
-msgstr ""
+msgstr "KONFLIKT (rename/rename): Benenne um %s->%s in %s. "
+"Benenne um %s->%s in %s"
=20
 #: merge-recursive.c:1265
-#, fuzzy, c-format
+#, c-format
 msgid "Renaming %s to %s and %s to %s instead"
-msgstr "Benenne %s nach %s um\n"
+msgstr "Benenne stattdessen %s nach %s und %s nach %s um"
=20
 #: merge-recursive.c:1464
 #, c-format
 msgid "CONFLICT (rename/add): Rename %s->%s in %s. %s added in %s"
-msgstr ""
+msgstr "KONFLIKT (rename/add): Benenne um %s->%s in %s. %s hinzugef=C3=
=BCgt in %s"
=20
 #: merge-recursive.c:1474
-#, fuzzy, c-format
+#, c-format
 msgid "Adding merged %s"
-msgstr "nicht zusammengef=C3=BChrt:   %s"
+msgstr "F=C3=BCge zusammengef=C3=BChrte Datei %s hinzu"
=20
 #: merge-recursive.c:1479 merge-recursive.c:1677
 #, c-format
 msgid "Adding as %s instead"
-msgstr ""
+msgstr "F=C3=BCge stattdessen als %s hinzu"
=20
 #: merge-recursive.c:1530
-#, fuzzy, c-format
+#, c-format
 msgid "cannot read object %s"
-msgstr "Kann existierendes Objekt %s nicht lesen."
+msgstr "kann Objekt %s nicht lesen"
=20
 #: merge-recursive.c:1533
-#, fuzzy, c-format
+#, c-format
 msgid "object %s is not a blob"
-msgstr "Objekt %s nicht gefunden"
+msgstr "Objekt %s ist kein Blob"
=20
 #: merge-recursive.c:1581
 msgid "modify"
-msgstr ""
+msgstr "modify"
=20
 #: merge-recursive.c:1581
-#, fuzzy
 msgid "modified"
-msgstr "von beiden ge=C3=A4ndert:"
+msgstr "modified"
=20
 #: merge-recursive.c:1591
 msgid "content"
-msgstr ""
+msgstr "content"
=20
 #: merge-recursive.c:1598
 msgid "add/add"
-msgstr ""
+msgstr "add/add"
=20
 #: merge-recursive.c:1632
 #, c-format
 msgid "Skipped %s (merged same as existing)"
-msgstr ""
+msgstr "%s ausgelassen (Ergebnis der Zusammenf=C3=BChrung existiert be=
reits)"
=20
 #: merge-recursive.c:1646
 #, c-format
 msgid "Auto-merging %s"
-msgstr ""
+msgstr "automatische Zusammenf=C3=BChrung von %s"
=20
 #: merge-recursive.c:1650 git-submodule.sh:844
 msgid "submodule"
@@ -538,65 +542,65 @@ msgstr "Unterprojekt"
 #: merge-recursive.c:1651
 #, c-format
 msgid "CONFLICT (%s): Merge conflict in %s"
-msgstr ""
+msgstr "KONFLIKT (%s): Zusammenf=C3=BChrungskonflikt in %s"
=20
 #: merge-recursive.c:1741
-#, fuzzy, c-format
+#, c-format
 msgid "Removing %s"
-msgstr "Entferne %s\n"
+msgstr "Entferne %s"
=20
 #: merge-recursive.c:1766
 msgid "file/directory"
-msgstr ""
+msgstr "Datei/Verzeichnis"
=20
 #: merge-recursive.c:1772
 msgid "directory/file"
-msgstr ""
+msgstr "Verzeichnis/Datei"
=20
 #: merge-recursive.c:1777
 #, c-format
 msgid "CONFLICT (%s): There is a directory with name %s in %s. Adding =
%s as %s"
-msgstr ""
+msgstr "KONFLIKT (%s): Es existiert bereits ein Verzeichnis %s in %s. =
"
+"F=C3=BCge %s als %s hinzu."
=20
 #: merge-recursive.c:1787
-#, fuzzy, c-format
+#, c-format
 msgid "Adding %s"
-msgstr "Aktualisiere %s"
+msgstr "F=C3=BCge %s hinzu"
=20
 #: merge-recursive.c:1804
 msgid "Fatal merge failure, shouldn't happen."
-msgstr ""
+msgstr "Fataler Fehler bei der Zusammenf=C3=BChrung. Sollte nicht pass=
ieren."
=20
 #: merge-recursive.c:1823
-#, fuzzy
 msgid "Already up-to-date!"
-msgstr "Aktualisierung erzwungen"
+msgstr "Bereits aktuell!"
=20
 #: merge-recursive.c:1832
 #, c-format
 msgid "merging of trees %s and %s failed"
-msgstr ""
+msgstr "zusammenf=C3=BChren der B=C3=A4ume %s und %s fehlgeschlagen"
=20
 #: merge-recursive.c:1862
 #, c-format
 msgid "Unprocessed path??? %s"
-msgstr ""
+msgstr " unverarbeiteter Pfad??? %s"
=20
 #: merge-recursive.c:1907
 msgid "Merging:"
-msgstr ""
+msgstr "Zusammenf=C3=BChrung:"
=20
 #: merge-recursive.c:1918
 #, c-format
 msgid "found %u common ancestor(s):"
-msgstr ""
+msgstr "%u gemeinsame Vorg=C3=A4nger gefunden"
=20
 #: merge-recursive.c:1954
 msgid "merge returned no commit"
-msgstr ""
+msgstr "Zusammenf=C3=BChrung hat keine Version zur=C3=BCckgegeben"
=20
 #: merge-recursive.c:2011
-#, fuzzy, c-format
+#, c-format
 msgid "Could not parse object '%s'"
 msgstr "Konnte Objekt '%s' nicht parsen."
=20
@@ -5322,7 +5326,7 @@ msgstr ""
 "Keine Zur=C3=BCcksetzung zu ORIG_HEAD."
=20
 #: git-am.sh:105
-#, fuzzy, sh-format
+#, sh-format
 msgid ""
 "When you have resolved this problem, run \"$cmdline --resolved\".\n"
 "If you prefer to skip this patch, run \"$cmdline --skip\" instead.\n"
@@ -5347,7 +5351,8 @@ msgstr ""
=20
 #: git-am.sh:139
 msgid "Using index info to reconstruct a base tree..."
-msgstr ""
+msgstr "Verwende Informationen aus der Bereitstellung um einen Basisba=
um "
+"nachzustellen"
=20
 #: git-am.sh:154
 msgid ""
@@ -5362,9 +5367,8 @@ msgid "Falling back to patching base and 3-way me=
rge..."
 msgstr "Falle zur=C3=BCck zum Patchen der Basis und der 3-Wege-Zusamme=
nf=C3=BChrung..."
=20
 #: git-am.sh:179
-#, fuzzy
 msgid "Failed to merge in the changes."
-msgstr "Lesen des Zwischenspeichers fehlgeschlagen"
+msgstr "Zusammenf=C3=BChrung der =C3=84nderungen fehlgeschlagen"
=20
 #: git-am.sh:274
 msgid "Only one StGIT patch series can be applied at once"
@@ -5384,6 +5388,8 @@ msgid ""
 "The -b/--binary option has been a no-op for long time, and\n"
 "it will be removed. Please do not use it anymore."
 msgstr ""
+"Die -b/--binary Option hat seit Langem keinen Effekt und wird\n"
+"entfernt. Bitte nicht mehr verwenden."
=20
 #: git-am.sh:477
 #, sh-format
@@ -5680,51 +5686,50 @@ msgid "Cannot rebase onto multiple branches"
 msgstr "kann nicht auf mehrere Zweige neu aufbauen"
=20
 #: git-rebase.sh:52
-#, fuzzy
 msgid ""
 "When you have resolved this problem, run \"git rebase --continue\".\n=
"
 "If you prefer to skip this patch, run \"git rebase --skip\" instead.\=
n"
 "To check out the original branch and stop rebasing, run \"git rebase =
--abort"
 "\"."
 msgstr ""
-"Wenn du das Problem aufgel=C3=B6st hast, f=C3=BChre \"$cmdline --reso=
lved\" aus.\n"
-"Falls du diesen Patch auslassen m=C3=B6chtest, f=C3=BChre stattdessen=
 \"$cmdline --skip"
-"\" aus.\n"
-"Um den urspr=C3=BCnglichen Zweig wiederherzustellen und die Anwendung=
 der "
-"Patches\n"
-"abzubrechen, f=C3=BChre \"$cmdline --abort\" aus."
+"Wenn du das Problem aufgel=C3=B6st hast, f=C3=BChre \"git rebase --co=
ntinue\" aus.\n"
+"Falls du diesen Patch auslassen m=C3=B6chtest, f=C3=BChre stattdessen=
 \"git rebase "
+"--skip\" aus.\n"
+"Um den urspr=C3=BCnglichen Zweig wiederherzustellen und den Neuaufbau=
 abzubrechen,\n"
+"f=C3=BChre \"git rebase --abort\" aus."
=20
 #: git-rebase.sh:159
 msgid "The pre-rebase hook refused to rebase."
-msgstr ""
+msgstr "Der \"pre-rebase hook\" hat den Neuaufbau zur=C3=BCckgewiesen.=
"
=20
 #: git-rebase.sh:164
 msgid "It looks like git-am is in progress. Cannot rebase."
-msgstr ""
+msgstr "\"git-am\" scheint im Gange zu sein. Kann nicht neu aufbauen."
=20
 #: git-rebase.sh:295
 msgid "The --exec option must be used with the --interactive option"
-msgstr ""
+msgstr "Die --exec Option muss mit der --interactive Option benutzt we=
rden"
=20
 #: git-rebase.sh:300
 msgid "No rebase in progress?"
-msgstr ""
+msgstr "Kein Neuaufbau im Gange?"
=20
 #: git-rebase.sh:313
-#, fuzzy
 msgid "Cannot read HEAD"
-msgstr "kann Zweigspitze (HEAD) nicht aufl=C3=B6sen"
+msgstr "Kann Zweigspitze (HEAD) nicht lesen"
=20
 #: git-rebase.sh:316
 msgid ""
 "You must edit all merge conflicts and then\n"
 "mark them as resolved using git add"
 msgstr ""
+"Du musst alle Zusammenf=C3=BChrungskonflikte editieren und diese dann=
\n"
+"mittels \"git add\" als aufgel=C3=B6st markieren"
=20
 #: git-rebase.sh:334
-#, fuzzy, sh-format
+#, sh-format
 msgid "Could not move back to $head_name"
-msgstr "Konnte Zweig %s nicht entfernen"
+msgstr "Konnte nicht zu $head_name zur=C3=BCckgehen"
=20
 #: git-rebase.sh:350
 #, sh-format
@@ -5738,60 +5743,70 @@ msgid ""
 "and run me again.  I am stopping in case you still have something\n"
 "valuable there."
 msgstr ""
+"Es scheint so, als g=C3=A4be es das Verzeichnis $state_dir_base berei=
ts, und\n"
+"es w=C3=A4re verwunderlich, wenn ein Neuaufbau bereits im Gange ist. =
Wenn das\n"
+"der Fall ist, probiere bitte\n"
+"\t$cmd_live_rebase\n"
+"Wenn das nicht der Fall ist, probiere bitte\n"
+"\t$cmd_clear_stale_rebase\n"
+"und f=C3=BChre dieses Kommando nochmal aus. Es wird angehalten, falls=
 bereits\n"
+"etwas N=C3=BCtzliches vorhanden ist."
=20
 #: git-rebase.sh:395
 #, sh-format
 msgid "invalid upstream $upstream_name"
-msgstr ""
+msgstr "ung=C3=BCltiger =C3=9Cbernahmezweig $upstream_name"
=20
 #: git-rebase.sh:419
 #, sh-format
 msgid "$onto_name: there are more than one merge bases"
-msgstr ""
+msgstr "$onto_name: es gibt mehr als eine Zusammenf=C3=BChrungsbasis"
=20
 #: git-rebase.sh:422 git-rebase.sh:426
 #, sh-format
 msgid "$onto_name: there is no merge base"
-msgstr ""
+msgstr "$onto_name: es gibt keine Zusammenf=C3=BChrungsbasis"
=20
 #: git-rebase.sh:431
-#, fuzzy, sh-format
+#, sh-format
 msgid "Does not point to a valid commit: $onto_name"
-msgstr "'%s' zeigt auf keine Version"
+msgstr "$onto_name zeigt auf keine g=C3=BCltige Version"
=20
 #: git-rebase.sh:454
 #, sh-format
 msgid "fatal: no such branch: $branch_name"
-msgstr ""
+msgstr "fatal: kein solcher Zweig: $branch_name"
=20
 #: git-rebase.sh:474
 msgid "Please commit or stash them."
-msgstr ""
+msgstr "Bitte trage die =C3=84nderungen ein oder benutze \"stash\"."
=20
 #: git-rebase.sh:492
 #, sh-format
 msgid "Current branch $branch_name is up to date."
-msgstr ""
+msgstr "Aktueller Zweig $branch_name ist auf dem neusten Stand."
=20
 #: git-rebase.sh:495
 #, sh-format
 msgid "Current branch $branch_name is up to date, rebase forced."
-msgstr ""
+msgstr "Aktueller Zweig $branch_name ist auf dem neusten Stand, "
+"Neuaufbau erzwungen."
=20
 #: git-rebase.sh:506
-#, fuzzy, sh-format
+#, sh-format
 msgid "Changes from $mb to $onto:"
-msgstr "zum Eintragen bereitgestellte =C3=84nderungen:"
+msgstr "=C3=84nderungen von $mb zu $onto:"
=20
 #. Detach HEAD and reset the tree
 #: git-rebase.sh:515
 msgid "First, rewinding head to replay your work on top of it..."
-msgstr ""
+msgstr "Zun=C3=A4chst wird die Zweigspitze zur=C3=BCckgespult, um dein=
e =C3=84nderungen\n"
+"darauf neu anzuwenden..."
=20
 #: git-rebase.sh:523
 #, sh-format
 msgid "Fast-forwarded $branch_name to $onto_name."
-msgstr ""
+msgstr "$branch_name zu $onto_name vorgespult."
=20
 #: git-stash.sh:51
 msgid "git stash clear with parameters is unimplemented"
@@ -6081,9 +6096,8 @@ msgid "Failed to recurse into submodule path '$sm=
_path'"
 msgstr "Fehler bei Rekursion in Unterprojekt-Pfad '$sm_path'"
=20
 #: git-submodule.sh:754
-#, fuzzy
 msgid "The --cached option cannot be used with the --files option"
-msgstr "--cached kann nicht mit --files benutzt werden"
+msgstr "Die --cached Option kann nicht mit der --files Option benutzt =
werden"
=20
 #. unexpected type
 #: git-submodule.sh:794
--=20
1.7.12.rc1
