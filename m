From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=202/5=5D=20l10n=3A=20de=2Epo=3A=20translate=20=22track=22=20as=20=22folgen=22?=
Date: Fri,  4 May 2012 21:48:23 +0200
Message-ID: <1336160906-20708-3-git-send-email-ralf.thielow@googlemail.com>
References: <1336160906-20708-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Fri May 04 21:49:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQOUy-0007I9-SZ
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 21:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759559Ab2EDTsu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 15:48:50 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:62404 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379Ab2EDTsr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 15:48:47 -0400
Received: by mail-we0-f174.google.com with SMTP id b10so138033wer.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 12:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dSHFGndJ9To7MGyTma1Gm7QnaC9wElB1r8nL3tkf9qw=;
        b=Z0pm1uAGQXo1DRHWVM1tK1kYtlctgfWxWs+rG79cGXtXXK4bEpOj6qnFKztSaEUdnI
         +oLgf5nH6Kdg3nGeUQkB4722awbo7Eggjm6RLKKIQ1IJLF+5BbtrdiaKkrXmt0RcdRpN
         xwj0FcyZzb9GLEnz5wK3uk+EUpZ1dbRyQXdcIIf7HYJHwIlxHQn5a8Xb6cDQeHhhY9zU
         AB9CBxoQ3XrvXolFazYkJWzFQG3BAkTlPX4xblqj6oJmmWDTrsxv3YY7E0P4FxAWbfgp
         Y3y/HK4W1fISY1b0n762kB+2tamxQu+yfnvLiGDMCnbNJe4j8/adfd758jM4C5kwtXrc
         3etQ==
Received: by 10.180.81.135 with SMTP id a7mr15823010wiy.16.1336160927424;
        Fri, 04 May 2012 12:48:47 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id 6sm3408902wiz.1.2012.05.04.12.48.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 May 2012 12:48:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.72.g0dc6d
In-Reply-To: <1336160906-20708-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197066>

The word "track" was translated as "verfolgt"
which is not the correct word for it. We've
changed it to "folgen".

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po |   20 ++++++++++----------
 1 Datei ge=C3=A4ndert, 10 Zeilen hinzugef=C3=BCgt(+), 10 Zeilen entfer=
nt(-)

diff --git a/po/de.po b/po/de.po
index abb719b..e4fb676 100644
--- a/po/de.po
+++ b/po/de.po
@@ -525,7 +525,7 @@ msgstr "ge=C3=A4nderter Inhalt, "
=20
 #: wt-status.c:252
 msgid "untracked content, "
-msgstr "unverfolgter Inhalt, "
+msgstr "ungefolgter Inhalt, "
=20
 #: wt-status.c:266
 #, c-format
@@ -586,7 +586,7 @@ msgstr "Initiale Version"
=20
 #: wt-status.c:745
 msgid "Untracked"
-msgstr "Unverfolgte"
+msgstr "Ungefolgte"
=20
 #: wt-status.c:747
 msgid "Ignored"
@@ -595,11 +595,11 @@ msgstr "Ignorierte"
 #: wt-status.c:749
 #, c-format
 msgid "Untracked files not listed%s"
-msgstr "Unverfolgte Dateien nicht aufgelistet%s"
+msgstr "Ungefolgte Dateien nicht aufgelistet%s"
=20
 #: wt-status.c:751
 msgid " (use -u option to show untracked files)"
-msgstr " (benutze die Option -u um unverfolgte Dateien anzuzeigen)"
+msgstr " (benutze die Option -u um ungefolgte Dateien anzuzeigen)"
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
+msgstr "nichts zum Eintragen hinzugef=C3=BCgt, aber es gibt ungefolgte=
 Dateien%s\n"
=20
 #: wt-status.c:767
 msgid " (use \"git add\" to track)"
-msgstr " (benutze \"git add\" zum Verfolgen)"
+msgstr " (benutze \"git add\" zum Folgen)"
=20
 #: wt-status.c:769 wt-status.c:772 wt-status.c:775
 #, c-format
@@ -630,11 +630,11 @@ msgstr "nichts zum Eintragen%s\n"
=20
 #: wt-status.c:770
 msgid " (create/copy files and use \"git add\" to track)"
-msgstr " (Erstelle/Kopiere Dateien und benutze \"git add\" zum Verfolg=
en)"
+msgstr " (Erstelle/Kopiere Dateien und benutze \"git add\" zum Folgen)=
"
=20
 #: wt-status.c:773
 msgid " (use -u to show untracked files)"
-msgstr " (benutze -u um unverfolgte Dateien anzuzeigen)"
+msgstr " (benutze -u um ungefolgte Dateien anzuzeigen)"
=20
 #: wt-status.c:776
 msgid " (working directory clean)"
@@ -1592,7 +1592,7 @@ msgstr "Kein existierender Autor mit '%s' gefunde=
n."
 #: builtin/commit.c:1023 builtin/commit.c:1217
 #, c-format
 msgid "Invalid untracked files mode '%s'"
-msgstr "Ung=C3=BCltiger Modus '%s' f=C3=BCr unverfolgte Dateien"
+msgstr "Ung=C3=BCltiger Modus '%s' f=C3=BCr ungefolgte Dateien"
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
+"--[no-]exlude-standard kann nicht mit gefolgten Inhalten benutzt werd=
en"
=20
 #: builtin/grep.c:982
 msgid "both --cached and trees are given."
--=20
1.7.10.72.g0dc6d
