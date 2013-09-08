From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: use "das Tag" instead of "der Tag"
Date: Sun,  8 Sep 2013 18:43:57 +0200
Message-ID: <1378658637-5885-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: dirk.heinrichs@altum.de, trast@student.ethz.ch, jk@jk.gs,
	stimming@tuhh.de, Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 18:44:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIi5r-0000jT-9j
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 18:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547Ab3IHQoG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Sep 2013 12:44:06 -0400
Received: from mail-bk0-f52.google.com ([209.85.214.52]:42238 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab3IHQoF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 12:44:05 -0400
Received: by mail-bk0-f52.google.com with SMTP id e11so1872441bkh.25
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 09:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=ELtclSRtzbPRXQd7x1ZOMxWw6gVaNVvDtbCtmCwZczU=;
        b=iSPI+CTc9xB6jF5gR7H5HJkHFnoaIqpl/8/FTBSeGqGj9LtJcWv0UO/PR3Lz28cof5
         V1sEXANe2p/JJbiKgpQGyXmUSeOqzdkTXi/gDeXK6EhjReZT9VgUfN6SJgtBatLojMTt
         dSmZRFOTRZDdTYSg3bP/UYzJZ6yacVv9QfBVn3ey442DbLZLTP0fBWKK+0Q3CFx9lofu
         7YapP3ZqQWYYsXBsnvM2o3gEwJDFHLR4lYK6Ni/I6tYjBoynbmb9UIMXPS+2kcWJAfzi
         DSPqeKdQSmF0vAmaKF4oThZj5S7P9C7iAOHfhPTqHkXbEqGhzhxR6P8yPu8Xyypr543l
         66MQ==
X-Received: by 10.205.20.133 with SMTP id qo5mr10864010bkb.6.1378658643904;
        Sun, 08 Sep 2013 09:44:03 -0700 (PDT)
Received: from localhost (dslb-178-005-189-036.pools.arcor-ip.net. [178.5.189.36])
        by mx.google.com with ESMTPSA id no2sm1450304bkb.15.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 09:44:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.325.g5deb81b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234254>

Use "das Tag" to avoid confusion with the German word "Tag" (day).

Reported-by: Dirk Heinrichs <dirk.heinrichs@altum.de>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/po/de.po b/po/de.po
index 11dde11..f4076fb 100644
--- a/po/de.po
+++ b/po/de.po
@@ -4694,12 +4694,12 @@ msgstr "git describe [Optionen] --dirty"
 #: builtin/describe.c:237
 #, c-format
 msgid "annotated tag %s not available"
-msgstr "annotierter Tag %s ist nicht verf=C3=BCgbar"
+msgstr "annotiertes Tag %s ist nicht verf=C3=BCgbar"
=20
 #: builtin/describe.c:241
 #, c-format
 msgid "annotated tag %s has no embedded name"
-msgstr "annotierter Tag %s hat keinen eingebetteten Namen"
+msgstr "annotiertes Tag %s hat keinen eingebetteten Namen"
=20
 #: builtin/describe.c:243
 #, c-format
@@ -4765,7 +4765,7 @@ msgstr ""
=20
 #: builtin/describe.c:409
 msgid "find the tag that comes after the commit"
-msgstr "findet den Tag, die nach Commit kommt"
+msgstr "findet das Tag, das nach Commit kommt"
=20
 #: builtin/describe.c:410
 msgid "debug search strategy on stderr"
@@ -4777,7 +4777,7 @@ msgstr "verwendet alle Referenzen"
=20
 #: builtin/describe.c:412
 msgid "use any tag, even unannotated"
-msgstr "verwendet jeden Tag, auch nicht-annotierte"
+msgstr "verwendet jedes Tag, auch nicht-annotierte"
=20
 #: builtin/describe.c:413
 msgid "always use long format"
@@ -4880,7 +4880,7 @@ msgstr "Importiert Kennzeichen von dieser Datei"
=20
 #: builtin/fast-export.c:678
 msgid "Fake a tagger when tags lack one"
-msgstr "erzeugt k=C3=BCnstlich einen Tag-Ersteller, wenn der Tag keine=
n hat"
+msgstr "erzeugt k=C3=BCnstlich einen Tag-Ersteller, wenn das Tag keine=
n hat"
=20
 #: builtin/fast-export.c:680
 msgid "Output full tree for each commit"
@@ -5013,7 +5013,7 @@ msgstr "  (kann lokale Referenz nicht aktualisier=
en)"
=20
 #: builtin/fetch.c:324
 msgid "[new tag]"
-msgstr "[neuer Tag]"
+msgstr "[neues Tag]"
=20
 #: builtin/fetch.c:327
 msgid "[new branch]"
@@ -7831,7 +7831,7 @@ msgstr ""
 #: builtin/push.c:257
 msgid "Updates were rejected because the tag already exists in the rem=
ote."
 msgstr ""
-"Aktualisierungen wurden zur=C3=BCckgewiesen, weil der Tag bereits\n"
+"Aktualisierungen wurden zur=C3=BCckgewiesen, weil das Tag bereits\n"
 "im Remote-Repository existiert."
=20
 #: builtin/push.c:260
@@ -9244,7 +9244,7 @@ msgstr "Optionen f=C3=BCr Erstellung von Tags"
=20
 #: builtin/tag.c:454
 msgid "annotated tag, needs a message"
-msgstr "annotierter Tag, ben=C3=B6tigt eine Beschreibung"
+msgstr "annotiertes Tag, ben=C3=B6tigt eine Beschreibung"
=20
 #: builtin/tag.c:456
 msgid "tag message"
@@ -9252,15 +9252,15 @@ msgstr "Tag-Beschreibung"
=20
 #: builtin/tag.c:458
 msgid "annotated and GPG-signed tag"
-msgstr "annotierter und GPG-signierter Tag"
+msgstr "annotiertes und GPG-signiertes Tag"
=20
 #: builtin/tag.c:462
 msgid "use another key to sign the tag"
-msgstr "verwendet einen anderen Schl=C3=BCssel um den Tag zu signieren=
"
+msgstr "verwendet einen anderen Schl=C3=BCssel um das Tag zu signieren=
"
=20
 #: builtin/tag.c:463
 msgid "replace the tag if exists"
-msgstr "ersetzt den Tag, wenn er existiert"
+msgstr "ersetzt das Tag, wenn es existiert"
=20
 #: builtin/tag.c:464
 msgid "show tag list in columns"
--=20
1.8.4.325.g5deb81b
