From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=208/9=5D=20po/hi=2Epo=3A=20Eliminate=20fuzzy=20translations?=
Date: Mon,  3 Oct 2011 18:58:16 +0000
Message-ID: <1317668297-2702-9-git-send-email-avarab@gmail.com>
References: <1317668297-2702-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?q?Marcin=20Cie=C5=9Blak?= <saper@saper.info>,
	Sam Reed <sam@reedyboy.net>,
	Jan Engelhardt <jengelh@medozas.de>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 21:00:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAnkE-0005jw-Ip
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 21:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757255Ab1JCS7t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 14:59:49 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50138 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757242Ab1JCS7r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 14:59:47 -0400
Received: by mail-ey0-f174.google.com with SMTP id 28so3121204eya.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 11:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zurbfQJD9l+VAuF/z9yj8RnOOKqVu55IX2Akip7kJ/Q=;
        b=ctBIwmJYg/MBCKSziOdCiD3tiQ7lQ5ZSzk3wmkw1Ph6dYxU/Dl6y3SpFWWLukBwcJo
         M1/xXwyxgtfJS1z17BpH27aya/NTP0N7mbY+WHhakXgM9Uh6dfz/1PAxjj/6kUmKT4Wr
         LK1INOFZT3NpD5iS/62xYXtcOv53RULwz4SdU=
Received: by 10.223.35.211 with SMTP id q19mr317601fad.120.1317668386590;
        Mon, 03 Oct 2011 11:59:46 -0700 (PDT)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id f25sm22312819faf.7.2011.10.03.11.59.45
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 11:59:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.3
In-Reply-To: <1317668297-2702-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182693>

=46rom: Ramkumar Ramachandra <artagnon@gmail.com>

Remove all fuzzy translations by either correcting them where trivial,
or removing them altogether.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 po/hi.po |  167 +++++++++++++++++++++++++++++-------------------------=
-------
 1 files changed, 79 insertions(+), 88 deletions(-)

diff --git a/po/hi.po b/po/hi.po
index 45221e0..46a9b4b 100644
--- a/po/hi.po
+++ b/po/hi.po
@@ -22,9 +22,9 @@ msgid "  Failed to parse dirstat cut-off percentage '=
%.*s'\n"
 msgstr ""
=20
 #: diff.c:109
-#, fuzzy, c-format
+#, c-format
 msgid "  Unknown dirstat parameter '%.*s'\n"
-msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F '%s' =E0=A4=95=E0=A5=8B [stat] =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=
=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr ""
=20
 #: diff.c:205
 #, c-format
@@ -312,12 +312,11 @@ msgid "Could not open '%s' for writing."
 msgstr ""
=20
 #: builtin/add.c:288
-#, fuzzy
 msgid "Could not write patch"
-msgstr "%s =E0=A4=95=E0=A5=8B =E0=A4=B8=E0=A4=AE=E0=A5=82=E0=A4=B9 =E0=
=A4=A6=E0=A5=8D=E0=A4=B5=E0=A4=BE=E0=A4=B0=E0=A4=BE =E0=A4=B2=E0=A4=BF=E0=
=A4=96=E0=A4=A8=E0=A5=87 =E0=A4=95=E0=A5=80 =E0=A4=87=E0=A4=9C=E0=A4=BE=
=E0=A4=9C=E0=A4=BC=E0=A4=A4 =E0=A4=A8=E0=A4=B9=E0=A5=80 =E0=A4=A6=E0=A5=
=87 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr ""
=20
 #: builtin/add.c:293
-#, fuzzy, c-format
+#, c-format
 msgid "Could not stat '%s'"
 msgstr "'%s' =E0=A4=95=E0=A5=8B [stat] =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=
=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=87"
=20
@@ -615,9 +614,9 @@ msgid "you need to resolve your current index first=
"
 msgstr ""
=20
 #: builtin/checkout.c:527
-#, fuzzy, c-format
+#, c-format
 msgid "Can not do reflog for '%s'\n"
-msgstr "=E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=
=E0=A4=BF=E0=A4=95=E0=A4=BE '%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=
=A4=96=E0=A5=8B=E0=A4=B2 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr ""
=20
 #: builtin/checkout.c:557
 msgid "HEAD is now at"
@@ -807,9 +806,9 @@ msgid "Removing %s\n"
 msgstr ""
=20
 #: builtin/clean.c:161 builtin/clean.c:181
-#, fuzzy, c-format
+#, c-format
 msgid "failed to remove %s"
-msgstr "=E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=
=E0=A4=BF=E0=A4=95=E0=A4=BE '%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=
=A4=96=E0=A5=8B=E0=A4=B2 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr "'%s' =E0=A4=A8=E0=A4=BF=E0=A4=95=E0=A4=BE=E0=A4=B2 =E0=A4=A8=E0=
=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=B8=E0=A4=95=E0=A5=87"
=20
 #: builtin/clean.c:165
 #, c-format
@@ -827,24 +826,24 @@ msgid "reference repository '%s' is not a local d=
irectory."
 msgstr ""
=20
 #: builtin/clone.c:241
-#, fuzzy, c-format
+#, c-format
 msgid "failed to open '%s'"
-msgstr "=E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=
=E0=A4=BF=E0=A4=95=E0=A4=BE '%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=
=A4=96=E0=A5=8B=E0=A4=B2 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr "'%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=96=E0=A5=8B=E0=
=A4=B2 =E0=A4=B8=E0=A4=95=E0=A5=87"
=20
 #: builtin/clone.c:245
-#, fuzzy, c-format
+#, c-format
 msgid "failed to create directory '%s'"
-msgstr "=E0=A4=96=E0=A4=B0=E0=A4=BE=E0=A4=AC =E0=A4=97=E0=A4=BF=E0=A4=9F=
 =E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=E0=A4=BF=
=E0=A4=95=E0=A4=BE %s"
+msgstr "=E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=
=E0=A4=BF=E0=A4=95=E0=A4=BE '%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=
=A4=AC=E0=A4=A8=E0=A4=BE =E0=A4=B8=E0=A4=95=E0=A5=87"
=20
 #: builtin/clone.c:247 builtin/diff.c:74
-#, fuzzy, c-format
+#, c-format
 msgid "failed to stat '%s'"
 msgstr "'%s' =E0=A4=95=E0=A5=8B [stat] =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=
=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=87"
=20
 #: builtin/clone.c:249
-#, fuzzy, c-format
+#, c-format
 msgid "%s exists and is not a directory"
-msgstr "=E0=A4=96=E0=A4=B0=E0=A4=BE=E0=A4=AC =E0=A4=97=E0=A4=BF=E0=A4=9F=
 =E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=E0=A4=BF=
=E0=A4=95=E0=A4=BE %s"
+msgstr ""
=20
 #: builtin/clone.c:263
 #, c-format
@@ -857,14 +856,14 @@ msgid "failed to unlink '%s'"
 msgstr ""
=20
 #: builtin/clone.c:278
-#, fuzzy, c-format
+#, c-format
 msgid "failed to create link '%s'"
-msgstr "=E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=AA=E0=A4=A2=E0=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87=
"
+msgstr "=E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=AC=E0=A4=A8=E0=A4=BE =E0=A4=B8=E0=A4=95=E0=A5=87=
"
=20
 #: builtin/clone.c:282
-#, fuzzy, c-format
+#, c-format
 msgid "failed to copy file to '%s'"
-msgstr "'%s' =E0=A4=95=E0=A5=80 =E0=A4=85=E0=A4=A8=E0=A5=81=E0=A4=95=E0=
=A5=83=E0=A4=A4=E0=A4=BF '%s' =E0=A4=AE=E0=A5=87=E0=A4=82 =E0=A4=A8=E0=A4=
=B9=E0=A5=80=E0=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr ""
=20
 #: builtin/clone.c:311
 #, c-format
@@ -977,9 +976,8 @@ msgid "failed to unpack HEAD tree object"
 msgstr ""
=20
 #: builtin/commit.c:359
-#, fuzzy
 msgid "unable to create temporary index"
-msgstr "=E0=A4=96=E0=A4=B0=E0=A4=BE=E0=A4=AC =E0=A4=97=E0=A4=BF=E0=A4=9F=
 =E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=E0=A4=BF=
=E0=A4=95=E0=A4=BE %s"
+msgstr ""
=20
 #: builtin/commit.c:365
 msgid "interactive add failed"
@@ -995,9 +993,8 @@ msgid "cannot do a partial commit during a %s."
 msgstr ""
=20
 #: builtin/commit.c:456
-#, fuzzy
 msgid "cannot read the index"
-msgstr "=E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=AA=E0=A4=A2=E0=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87=
"
+msgstr ""
=20
 #: builtin/commit.c:476
 msgid "unable to write temporary index file"
@@ -1036,9 +1033,9 @@ msgid "could not read log from standard input"
 msgstr ""
=20
 #: builtin/commit.c:674
-#, fuzzy, c-format
+#, c-format
 msgid "could not read log file '%s'"
-msgstr "=E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=AA=E0=A4=A2=E0=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87=
"
+msgstr ""
=20
 #: builtin/commit.c:680
 msgid "commit has empty message"
@@ -1053,14 +1050,14 @@ msgid "could not read SQUASH_MSG"
 msgstr ""
=20
 #: builtin/commit.c:704
-#, fuzzy, c-format
+#, c-format
 msgid "could not read '%s'"
-msgstr "=E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=AA=E0=A4=A2=E0=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87=
"
+msgstr "'%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=AA=E0=A4=A2=E0=
=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87"
=20
 #: builtin/commit.c:732
-#, fuzzy, c-format
+#, c-format
 msgid "could not open '%s'"
-msgstr "=E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=
=E0=A4=BF=E0=A4=95=E0=A4=BE '%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=
=A4=96=E0=A5=8B=E0=A4=B2 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr "'%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=96=E0=A5=8B=E0=
=A4=B2 =E0=A4=B8=E0=A4=95=E0=A5=87"
=20
 #: builtin/commit.c:756
 msgid "could not write commit template"
@@ -1104,9 +1101,8 @@ msgid "%sCommitter: %s"
 msgstr ""
=20
 #: builtin/commit.c:829
-#, fuzzy
 msgid "Cannot read index"
-msgstr "=E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=AA=E0=A4=A2=E0=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87=
"
+msgstr ""
=20
 #: builtin/commit.c:869
 msgid "Error building trees"
@@ -1266,9 +1262,9 @@ msgid "%s is not a valid '%s' object"
 msgstr ""
=20
 #: builtin/describe.c:287
-#, fuzzy, c-format
+#, c-format
 msgid "no tag exactly matches '%s'"
-msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F '%s' =E0=A4=95=E0=A5=8B [stat] =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=
=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr ""
=20
 #: builtin/describe.c:289
 #, c-format
@@ -1357,9 +1353,9 @@ msgid "Couldn't find remote ref HEAD"
 msgstr ""
=20
 #: builtin/fetch.c:252
-#, fuzzy, c-format
+#, c-format
 msgid "object %s not found"
-msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F=E0=A5=8D=E0=A4=B8 =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=
=AE=E0=A4=BF=E0=A4=B2=E0=A5=87: %s"
+msgstr ""
=20
 #: builtin/fetch.c:257
 msgid "[up to date]"
@@ -1407,9 +1403,9 @@ msgid "(non-fast-forward)"
 msgstr ""
=20
 #: builtin/fetch.c:361 builtin/fetch.c:684
-#, fuzzy, c-format
+#, c-format
 msgid "cannot open %s: %s\n"
-msgstr "=E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=
=E0=A4=BF=E0=A4=95=E0=A4=BE '%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=
=A4=96=E0=A5=8B=E0=A4=B2 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr "%2$s =E0=A4=95=E0=A5=87 =E0=A4=B5=E0=A4=9C=E0=A4=BE=E0=A4=AF =E0=
=A4=B8=E0=A5=87 '%1$s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=96=E0=
=A5=8B=E0=A4=B2 =E0=A4=B8=E0=A4=95=E0=A5=87"
=20
 #: builtin/fetch.c:439
 #, c-format
@@ -1522,9 +1518,9 @@ msgid "Too many options specified"
 msgstr ""
=20
 #: builtin/gc.c:103
-#, fuzzy, c-format
+#, c-format
 msgid "insanely long object directory %.*s"
-msgstr "=E0=A4=96=E0=A4=B0=E0=A4=BE=E0=A4=AC =E0=A4=97=E0=A4=BF=E0=A4=9F=
 =E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=E0=A4=BF=
=E0=A4=95=E0=A4=BE %s"
+msgstr ""
=20
 #: builtin/gc.c:223
 #, c-format
@@ -1584,9 +1580,9 @@ msgid "switch `%c' expects a numerical value"
 msgstr ""
=20
 #: builtin/grep.c:691
-#, fuzzy, c-format
+#, c-format
 msgid "cannot open '%s'"
-msgstr "=E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=
=E0=A4=BF=E0=A4=95=E0=A4=BE '%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=
=A4=96=E0=A5=8B=E0=A4=B2 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr "'%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=96=E0=A5=8B=E0=
=A4=B2 =E0=A4=B8=E0=A4=95=E0=A5=87"
=20
 #: builtin/grep.c:974
 msgid "no pattern given."
@@ -1694,14 +1690,14 @@ msgid "unable to handle file type %d"
 msgstr ""
=20
 #: builtin/init-db.c:357
-#, fuzzy, c-format
+#, c-format
 msgid "unable to move %s to %s"
-msgstr "'%s' =E0=A4=95=E0=A5=80 =E0=A4=85=E0=A4=A8=E0=A5=81=E0=A4=95=E0=
=A5=83=E0=A4=A4=E0=A4=BF '%s' =E0=A4=AE=E0=A5=87=E0=A4=82 =E0=A4=A8=E0=A4=
=B9=E0=A5=80=E0=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr ""
=20
 #: builtin/init-db.c:362
-#, fuzzy, c-format
+#, c-format
 msgid "Could not create git link %s"
-msgstr "=E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=AA=E0=A4=A2=E0=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87=
"
+msgstr "=E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=AC=E0=A4=A8=E0=A4=BE =E0=A4=B8=E0=A4=95=E0=A5=87=
"
=20
 #.
 #. * TRANSLATORS: The first '%s' is either "Reinitialized
@@ -1730,14 +1726,14 @@ msgid "cannot tell cwd"
 msgstr ""
=20
 #: builtin/init-db.c:521 builtin/init-db.c:528
-#, fuzzy, c-format
+#, c-format
 msgid "cannot mkdir %s"
-msgstr "=E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=
=E0=A4=BF=E0=A4=95=E0=A4=BE '%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=
=A4=96=E0=A5=8B=E0=A4=B2 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr "=E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=
=E0=A4=BF=E0=A4=95=E0=A4=BE '%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=
=A4=AC=E0=A4=A8=E0=A4=BE =E0=A4=B8=E0=A4=95=E0=A5=87"
=20
 #: builtin/init-db.c:532
-#, fuzzy, c-format
+#, c-format
 msgid "cannot chdir to %s"
-msgstr "=E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=
=E0=A4=BF=E0=A4=95=E0=A4=BE '%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=
=A4=96=E0=A5=8B=E0=A4=B2 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr ""
=20
 #: builtin/init-db.c:554
 #, c-format
@@ -1751,9 +1747,9 @@ msgid "Cannot access current working directory"
 msgstr ""
=20
 #: builtin/init-db.c:585
-#, fuzzy, c-format
+#, c-format
 msgid "Cannot access work tree '%s'"
-msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F '%s' =E0=A4=95=E0=A5=8B [stat] =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=
=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr ""
=20
 #: builtin/log.c:186
 #, c-format
@@ -1784,9 +1780,9 @@ msgid "name of output directory is too long"
 msgstr ""
=20
 #: builtin/log.c:688
-#, fuzzy, c-format
+#, c-format
 msgid "Cannot open patch file %s"
-msgstr "=E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=
=E0=A4=BF=E0=A4=95=E0=A4=BE '%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=
=A4=96=E0=A5=8B=E0=A4=B2 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr ""
=20
 #: builtin/log.c:702
 msgid "Need exactly one range."
@@ -1805,9 +1801,9 @@ msgid "Cover letter needs email format"
 msgstr ""
=20
 #: builtin/log.c:872
-#, fuzzy, c-format
+#, c-format
 msgid "insane in-reply-to: %s"
-msgstr "=E0=A4=96=E0=A4=B0=E0=A4=BE=E0=A4=AC =E0=A4=97=E0=A4=BF=E0=A4=9F=
 =E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=E0=A4=BF=
=E0=A4=95=E0=A4=BE %s"
+msgstr ""
=20
 #: builtin/log.c:945
 msgid "Two output directories?"
@@ -1974,14 +1970,14 @@ msgstr ""
=20
 #: builtin/merge.c:841 builtin/merge.c:920 builtin/merge.c:1427
 #: builtin/merge.c:1436 builtin/revert.c:210
-#, fuzzy, c-format
+#, c-format
 msgid "Could not open '%s' for writing"
-msgstr "%s =E0=A4=95=E0=A5=8B =E0=A4=B8=E0=A4=AE=E0=A5=82=E0=A4=B9 =E0=
=A4=A6=E0=A5=8D=E0=A4=B5=E0=A4=BE=E0=A4=B0=E0=A4=BE =E0=A4=B2=E0=A4=BF=E0=
=A4=96=E0=A4=A8=E0=A5=87 =E0=A4=95=E0=A5=80 =E0=A4=87=E0=A4=9C=E0=A4=BE=
=E0=A4=9C=E0=A4=BC=E0=A4=A4 =E0=A4=A8=E0=A4=B9=E0=A5=80 =E0=A4=A6=E0=A5=
=87 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr "%s =E0=A4=95=E0=A5=8B =E0=A4=B2=E0=A4=BF=E0=A4=96=E0=A4=A8=E0=A5=
=87 =E0=A4=95=E0=A5=87 =E0=A4=B2=E0=A4=BF=E0=A4=8F =E0=A4=96=E0=A5=8B=E0=
=A4=B2 =E0=A4=A8=E0=A4=B9=E0=A5=80 =E0=A4=B8=E0=A4=95=E0=A5=87"
=20
 #: builtin/merge.c:852
-#, fuzzy, c-format
+#, c-format
 msgid "Could not read from '%s'"
-msgstr "=E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=AA=E0=A4=A2=E0=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87=
"
+msgstr "'%s' =E0=A4=B8=E0=A5=87 =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=
=A4=AA=E0=A4=A2=E0=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87"
=20
 #: builtin/merge.c:869
 #, c-format
@@ -2114,9 +2110,9 @@ msgid "Automatic merge went well; stopped before =
committing as requested\n"
 msgstr ""
=20
 #: builtin/mv.c:103
-#, fuzzy, c-format
+#, c-format
 msgid "Checking rename of '%s' to '%s'\n"
-msgstr "'%s' =E0=A4=95=E0=A5=80 =E0=A4=85=E0=A4=A8=E0=A5=81=E0=A4=95=E0=
=A5=83=E0=A4=A4=E0=A4=BF '%s' =E0=A4=AE=E0=A5=87=E0=A4=82 =E0=A4=A8=E0=A4=
=B9=E0=A5=80=E0=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr ""
=20
 #: builtin/mv.c:107
 msgid "bad source"
@@ -2195,9 +2191,9 @@ msgid "failed to finish 'show' for object '%s'"
 msgstr ""
=20
 #: builtin/notes.c:175 builtin/tag.c:303
-#, fuzzy, c-format
+#, c-format
 msgid "could not create file '%s'"
-msgstr "=E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=AA=E0=A4=A2=E0=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87=
"
+msgstr "'%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=AC=E0=A4=A8=E0=
=A4=BE =E0=A4=B8=E0=A4=95=E0=A5=87"
=20
 #: builtin/notes.c:189
 msgid "Please supply the note contents using either -m or -F option"
@@ -2218,14 +2214,14 @@ msgid "The note contents has been left in %s"
 msgstr ""
=20
 #: builtin/notes.c:251 builtin/tag.c:448
-#, fuzzy, c-format
+#, c-format
 msgid "cannot read '%s'"
-msgstr "=E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=AA=E0=A4=A2=E0=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87=
"
+msgstr "'%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=AA=E0=A4=A2=E0=
=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87"
=20
 #: builtin/notes.c:253 builtin/tag.c:451
-#, fuzzy, c-format
+#, c-format
 msgid "could not open or read '%s'"
-msgstr "=E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=
=E0=A4=BF=E0=A4=95=E0=A4=BE '%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=
=A4=96=E0=A5=8B=E0=A4=B2 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr ""
=20
 #: builtin/notes.c:272 builtin/notes.c:445 builtin/notes.c:447
 #: builtin/notes.c:507 builtin/notes.c:561 builtin/notes.c:644
@@ -2267,9 +2263,9 @@ msgid "Malformed input line: '%s'."
 msgstr ""
=20
 #: builtin/notes.c:456
-#, fuzzy, c-format
+#, c-format
 msgid "Failed to copy notes from '%s' to '%s'"
-msgstr "'%s' =E0=A4=95=E0=A5=80 =E0=A4=85=E0=A4=A8=E0=A5=81=E0=A4=95=E0=
=A5=83=E0=A4=A4=E0=A4=BF '%s' =E0=A4=AE=E0=A5=87=E0=A4=82 =E0=A4=A8=E0=A4=
=B9=E0=A5=80=E0=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr ""
=20
 #: builtin/notes.c:500 builtin/notes.c:554 builtin/notes.c:627
 #: builtin/notes.c:639 builtin/notes.c:712 builtin/notes.c:759
@@ -2678,9 +2674,9 @@ msgid "tag name too long: %.*s..."
 msgstr ""
=20
 #: builtin/tag.c:126
-#, fuzzy, c-format
+#, c-format
 msgid "tag '%s' not found."
-msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F=E0=A5=8D=E0=A4=B8 =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=
=AE=E0=A4=BF=E0=A4=B2=E0=A5=87: %s"
+msgstr ""
=20
 #: builtin/tag.c:141
 #, c-format
@@ -3018,9 +3014,9 @@ msgid "No logfile given"
 msgstr ""
=20
 #: git-bisect.sh:372
-#, fuzzy, sh-format
+#, sh-format
 msgid "cannot read $file for replaying"
-msgstr "=E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=AA=E0=A4=A2=E0=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87=
"
+msgstr ""
=20
 #: git-bisect.sh:388
 msgid "?? what are you talking about?"
@@ -3097,14 +3093,12 @@ msgid "You do not have the initial commit yet"
 msgstr ""
=20
 #: git-stash.sh:80
-#, fuzzy
 msgid "Cannot save the current index state"
-msgstr "=E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=AA=E0=A4=A2=E0=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87=
"
+msgstr ""
=20
 #: git-stash.sh:94 git-stash.sh:107
-#, fuzzy
 msgid "Cannot save the current worktree state"
-msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F '%s' =E0=A4=95=E0=A5=8B [stat] =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=
=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr ""
=20
 #: git-stash.sh:111
 msgid "No changes selected"
@@ -3115,9 +3109,8 @@ msgid "Cannot remove temporary index (can't happe=
n)"
 msgstr ""
=20
 #: git-stash.sh:127
-#, fuzzy
 msgid "Cannot record working tree state"
-msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F '%s' =E0=A4=95=E0=A5=8B [stat] =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=
=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr ""
=20
 #: git-stash.sh:182
 msgid "No local changes to save"
@@ -3132,9 +3125,8 @@ msgid "Cannot save the current status"
 msgstr ""
=20
 #: git-stash.sh:207
-#, fuzzy
 msgid "Cannot remove worktree changes"
-msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F '%s' =E0=A4=95=E0=A5=8B [stat] =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=
=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr ""
=20
 #: git-stash.sh:302
 msgid "No stash found."
@@ -3173,9 +3165,8 @@ msgid "Conflicts in index. Try without --index."
 msgstr ""
=20
 #: git-stash.sh:373
-#, fuzzy
 msgid "Could not save index tree"
-msgstr "%s =E0=A4=95=E0=A5=8B =E0=A4=B8=E0=A4=AE=E0=A5=82=E0=A4=B9 =E0=
=A4=A6=E0=A5=8D=E0=A4=B5=E0=A4=BE=E0=A4=B0=E0=A4=BE =E0=A4=B2=E0=A4=BF=E0=
=A4=96=E0=A4=A8=E0=A5=87 =E0=A4=95=E0=A5=80 =E0=A4=87=E0=A4=9C=E0=A4=BE=
=E0=A4=9C=E0=A4=BC=E0=A4=A4 =E0=A4=A8=E0=A4=B9=E0=A5=80 =E0=A4=A6=E0=A5=
=87 =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr ""
=20
 #: git-stash.sh:399
 msgid "Cannot unstage modified files"
@@ -3229,9 +3220,9 @@ msgid "repo URL: '$repo' must be absolute or begi=
n with ./|../"
 msgstr ""
=20
 #: git-submodule.sh:222
-#, fuzzy, sh-format
+#, sh-format
 msgid "'$path' already exists in the index"
-msgstr "=E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=AA=E0=A4=A2=E0=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87=
"
+msgstr ""
=20
 #: git-submodule.sh:227
 #, sh-format
@@ -3247,9 +3238,9 @@ msgid "Adding existing repo at '$path' to the ind=
ex"
 msgstr ""
=20
 #: git-submodule.sh:242
-#, fuzzy, sh-format
+#, sh-format
 msgid "'$path' already exists and is not a valid git repo"
-msgstr "=E0=A4=96=E0=A4=B0=E0=A4=BE=E0=A4=AC =E0=A4=97=E0=A4=BF=E0=A4=9F=
 =E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=E0=A4=BF=
=E0=A4=95=E0=A4=BE %s"
+msgstr ""
=20
 #: git-submodule.sh:265
 #, sh-format
--=20
1.7.6.3
