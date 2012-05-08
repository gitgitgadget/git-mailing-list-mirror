From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=2006/10=5D=20l10n=3A=20de=2Epo=3A=20translate=20=22track=22=20as=20=22beobachten=22?=
Date: Tue,  8 May 2012 19:33:41 +0200
Message-ID: <1336498425-17890-7-git-send-email-ralf.thielow@googlemail.com>
References: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worldhello.net@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Tue May 08 19:35:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRoJS-0002G2-T8
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 19:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274Ab2EHReh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 13:34:37 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:48089 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772Ab2EHRee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 13:34:34 -0400
Received: by wibhm4 with SMTP id hm4so877693wib.1
        for <git@vger.kernel.org>; Tue, 08 May 2012 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ADAgXVSfvq8BpHu7LB0p3tHtondYstTvZ8VCcLhRRL8=;
        b=L8GKNU8v2QvTidVXt+eDO6aF22jxWAsGFg83YnWw5Nnn4f/R0ZyPzw2J37+tT8BvXe
         K3z3L2i4rMlj+oF85XVlW1PI7nd/72d1WbPywPJol+qf4auXiuzPkRmjQ3NlttreJVru
         EyrWFfvdyKwTtLfeN75pMBmIWb8TIn+A6XzYjDYz+ErwHxm2I+7wRyDMmDN9DA0I75jK
         wmKne+dQyD/LoxoFtLUT5c9SnlkCwRMHGfHtafjjwDYti+G0J3+8y8H7fvm668som+QK
         zRQO/oSwaiEuSNzbYpokYHl5l+YUSobv7/ASVm9aYIGPd4rbwulUG1W/BTGK1P/ycKCo
         /WbA==
Received: by 10.216.135.105 with SMTP id t83mr12511946wei.105.1336498472684;
        Tue, 08 May 2012 10:34:32 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id ff2sm47784452wib.9.2012.05.08.10.34.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 May 2012 10:34:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.129.g1ec31a3
In-Reply-To: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197405>

The word "track" was translated as "verfolgen"
and "folgen". We've decided to translate "track" in
the meaning of tracked files/content as "beobachten"
and in the remote-tracking sense as "folgen".

Suggested-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po |   24 ++++++++++++------------
 1 Datei ge=C3=A4ndert, 12 Zeilen hinzugef=C3=BCgt(+), 12 Zeilen entfer=
nt(-)

diff --git a/po/de.po b/po/de.po
index abb719b..00fe020 100644
--- a/po/de.po
+++ b/po/de.po
@@ -470,7 +470,7 @@ msgstr ""
 #: wt-status.c:178
 msgid "  (commit or discard the untracked or modified content in submo=
dules)"
 msgstr ""
-"  (trage ein oder verwerfe den ungefolgten oder ge=C3=A4nderten Inhal=
t in den "
+"  (trage ein oder verwerfe den unbeobachteten oder ge=C3=A4nderten In=
halt in den "
 "Unterprojekten)"
=20
 #: wt-status.c:187
@@ -525,7 +525,7 @@ msgstr "ge=C3=A4nderter Inhalt, "
=20
 #: wt-status.c:252
 msgid "untracked content, "
-msgstr "unverfolgter Inhalt, "
+msgstr "unbeobachteter Inhalt, "
=20
 #: wt-status.c:266
 #, c-format
@@ -586,7 +586,7 @@ msgstr "Initiale Version"
=20
 #: wt-status.c:745
 msgid "Untracked"
-msgstr "Unverfolgte"
+msgstr "Unbeobachtete"
=20
 #: wt-status.c:747
 msgid "Ignored"
@@ -595,11 +595,11 @@ msgstr "Ignorierte"
 #: wt-status.c:749
 #, c-format
 msgid "Untracked files not listed%s"
-msgstr "Unverfolgte Dateien nicht aufgelistet%s"
+msgstr "Unbeobachtete Dateien nicht aufgelistet%s"
=20
 #: wt-status.c:751
 msgid " (use -u option to show untracked files)"
-msgstr " (benutze die Option -u um unverfolgte Dateien anzuzeigen)"
+msgstr " (benutze die Option -u um unbeobachteten Dateien anzuzeigen)"
=20
 #: wt-status.c:757
 msgid "No changes"
@@ -617,11 +617,11 @@ msgstr " (benutze \"git add\" und/oder \"git comm=
it -a\")"
 #: wt-status.c:765
 #, c-format
 msgid "nothing added to commit but untracked files present%s\n"
-msgstr "nichts zum Eintragen hinzugef=C3=BCgt, aber es gibt unverfolgt=
e Dateien%s\n"
+msgstr "nichts zum Eintragen hinzugef=C3=BCgt, aber es gibt unbeobacht=
ete Dateien%s\n"
=20
 #: wt-status.c:767
 msgid " (use \"git add\" to track)"
-msgstr " (benutze \"git add\" zum Verfolgen)"
+msgstr " (benutze \"git add\" zum Beobachten)"
=20
 #: wt-status.c:769 wt-status.c:772 wt-status.c:775
 #, c-format
@@ -630,11 +630,11 @@ msgstr "nichts zum Eintragen%s\n"
=20
 #: wt-status.c:770
 msgid " (create/copy files and use \"git add\" to track)"
-msgstr " (Erstelle/Kopiere Dateien und benutze \"git add\" zum Verfolg=
en)"
+msgstr " (Erstelle/Kopiere Dateien und benutze \"git add\" zum Beobach=
ten)"
=20
 #: wt-status.c:773
 msgid " (use -u to show untracked files)"
-msgstr " (benutze -u um unverfolgte Dateien anzuzeigen)"
+msgstr " (benutze -u um unbeobachtete Dateien anzuzeigen)"
=20
 #: wt-status.c:776
 msgid " (working directory clean)"
@@ -1592,7 +1592,7 @@ msgstr "Kein existierender Autor mit '%s' gefunde=
n."
 #: builtin/commit.c:1023 builtin/commit.c:1217
 #, c-format
 msgid "Invalid untracked files mode '%s'"
-msgstr "Ung=C3=BCltiger Modus '%s' f=C3=BCr unverfolgte Dateien"
+msgstr "Ung=C3=BCltiger Modus '%s' f=C3=BCr unbeobachtete Dateien"
=20
 #: builtin/commit.c:1063
 msgid "Using both --reset-author and --author does not make sense"
@@ -2087,7 +2087,7 @@ msgstr "--no-index oder --untracked kann nicht mi=
t Revisionen benutzt werden"
 #: builtin/grep.c:974
 msgid "--[no-]exclude-standard cannot be used for tracked contents."
 msgstr ""
-"--[no-]exlude-standard kann nicht mit verfolgten Inhalten benutzt wer=
den"
+"--[no-]exlude-standard kann nicht mit beobachteten Inhalten benutzt w=
erden"
=20
 #: builtin/grep.c:982
 msgid "both --cached and trees are given."
@@ -2338,7 +2338,7 @@ msgstr "Fehler beim Erstellen der Ausgabedateien.=
"
 msgid ""
 "Could not find a tracked remote branch, please specify <upstream> man=
ually.\n"
 msgstr ""
-"Konnte gefolgten, entfernten Zweig nicht finden, bitte spezifiziere "
+"Konnte gefolgten entfernten Zweig nicht finden, bitte spezifiziere "
 "<upstream> manuell.\n"
=20
 #: builtin/log.c:1530 builtin/log.c:1532 builtin/log.c:1544
--=20
1.7.10.129.g1ec31a3
