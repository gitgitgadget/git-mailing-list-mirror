From: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: [PATCH v2] git-gui: Update Russian translation
Date: Wed, 14 Oct 2015 16:18:58 +0300
Message-ID: <1444828738-14200-2-git-send-email-dimitriy.ryazantcev@gmail.com>
References: <1444828738-14200-1-git-send-email-dimitriy.ryazantcev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 15:20:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmLyT-0000Yi-8A
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 15:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbbJNNUA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2015 09:20:00 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37391 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557AbbJNNTy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 09:19:54 -0400
Received: by wijq8 with SMTP id q8so81569122wij.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 06:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:in-reply-to:references:content-type
         :content-transfer-encoding;
        bh=6uJpcsYODdqW0Kk9FyFgUt1DJMc3nKHQbwnqmrT4NHs=;
        b=t7Jbku/0CSCK7B+YkbrKX7uk82vjVtQjtTywTwuvPbdRaLSDb9HqJxJnjIXesUulm/
         U3T3iMnRpKCqT3bmETEb2oJMhd8yR4HZCqErDr2iqyHQT6wfj8zRdaKZQxeKM5IN4vaR
         8PXzCYSFnYyAX5XDvOMsuc4QLHVyeBWqfffY01X08DQZxMWg07+FOT5u04byffAqToo4
         JaGx17E8b/eGDmzsdtkpwpV9exAbPQnU4O6dx6BEQ/qS/53ID+YljALjz1kFWrAx81D9
         /RrB9Z1SQdOzjlftJ0ACE9vnRXadjQm0/Ql3ycgVr2t7uU9TuqadqNzN0C2fCDhuEtPe
         wZag==
X-Received: by 10.194.175.104 with SMTP id bz8mr4140242wjc.42.1444828792752;
        Wed, 14 Oct 2015 06:19:52 -0700 (PDT)
Received: from localhost.localdomain ([2a01:d0:8c94:0:dc2e:713e:8976:a916])
        by smtp.gmail.com with ESMTPSA id h7sm10041020wjz.7.2015.10.14.06.19.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Oct 2015 06:19:52 -0700 (PDT)
X-Mailer: git-send-email 2.6.1.windows.1
In-Reply-To: <1444828738-14200-1-git-send-email-dimitriy.ryazantcev@gmail.com>
In-Reply-To: <87r3kx91at.fsf@red.patthoyts.tk>
References: <87r3kx91at.fsf@red.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279571>

Signed-off-by: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
---
 po/ru.po | 668 +++++++++++++++++++++++--------------------------------=
--------
 1 file changed, 243 insertions(+), 425 deletions(-)

diff --git a/po/ru.po b/po/ru.po
index ca4343b..8287c21 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -1,19 +1,22 @@
 # Translation of git-gui to russian
 # Copyright (C) 2007 Shawn Pearce
 # This file is distributed under the same license as the git-gui packa=
ge.
-# Irina Riesen <irina.riesen@gmail.com>, 2007.
-#
+# Translators:
+# Dimitriy Ryazantcev <DJm00n@mail.ru>, 2015
+# Irina Riesen <irina.riesen@gmail.com>, 2007
 msgid ""
 msgstr ""
-"Project-Id-Version: git-gui\n"
+"Project-Id-Version: Git Russian Localization Project\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2010-01-26 15:47-0800\n"
-"PO-Revision-Date: 2007-10-22 22:30-0200\n"
-"Last-Translator: Alex Riesen <raa.lkml@gmail.com>\n"
-"Language-Team: Russian Translation <git@vger.kernel.org>\n"
+"PO-Revision-Date: 2015-10-12 11:36+0000\n"
+"Last-Translator: Dimitriy Ryazantcev <DJm00n@mail.ru>\n"
+"Language-Team: Russian (http://www.transifex.com/djm00n/git-po-ru/lan=
guage/ru/)\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
+"Language: ru\n"
+"Plural-Forms: nplurals=3D4; plural=3D(n%10=3D=3D1 && n%100!=3D11 ? 0 =
: n%10>=3D2 && n%10<=3D4 && (n%100<12 || n%100>14) ? 1 : n%10=3D=3D0 ||=
 (n%10>=3D5 && n%10<=3D9) || (n%100>=3D11 && n%100<=3D14)? 2 : 3);\n"
=20
 #: git-gui.sh:41 git-gui.sh:793 git-gui.sh:807 git-gui.sh:820 git-gui.=
sh:903
 #: git-gui.sh:922
@@ -51,14 +54,7 @@ msgid ""
 "%s requires at least Git 1.5.0 or later.\n"
 "\n"
 "Assume '%s' is version 1.5.0?\n"
-msgstr ""
-"=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=BE=D0=
=BF=D1=80=D0=B5=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=80=D1=
=81=D0=B8=D1=8E Git\n"
-"\n"
-"%s =D1=83=D0=BA=D0=B0=D0=B7=D1=8B=D0=B2=D0=B0=D0=B5=D1=82 =D0=BD=D0=B0=
 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8E '%s'.\n"
-"\n"
-"=D0=B4=D0=BB=D1=8F %s =D1=82=D1=80=D0=B5=D0=B1=D1=83=D0=B5=D1=82=D1=81=
=D1=8F =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F Git, =D0=BD=D0=B0=D1=87=D0=B8=
=D0=BD=D0=B0=D1=8F =D1=81 1.5.0\n"
-"\n"
-"=D0=9F=D1=80=D0=B8=D0=BD=D1=8F=D1=82=D1=8C '%s' =D0=BA=D0=B0=D0=BA =D0=
=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8E 1.5.0?\n"
+msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=BE=D0=BF=D1=80=D0=B5=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=
=80=D1=81=D0=B8=D1=8E Git\n\n%s =D1=83=D0=BA=D0=B0=D0=B7=D1=8B=D0=B2=D0=
=B0=D0=B5=D1=82 =D0=BD=D0=B0 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8E =C2=AB=
%s=C2=BB.\n\n=D0=B4=D0=BB=D1=8F %s =D1=82=D1=80=D0=B5=D0=B1=D1=83=D0=B5=
=D1=82=D1=81=D1=8F =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F Git, =D0=BD=D0=B0=
=D1=87=D0=B8=D0=BD=D0=B0=D1=8F =D1=81 1.5.0\n\n=D0=9F=D1=80=D0=B5=D0=B4=
=D0=BF=D0=BE=D0=BB=D0=BE=D0=B6=D0=B8=D1=82=D1=8C, =D1=87=D1=82=D0=BE =C2=
=AB%s=C2=BB =D0=B8 =D0=B5=D1=81=D1=82=D1=8C =D0=B2=D0=B5=D1=80=D1=81=D0=
=B8=D1=8F 1.5.0?\n"
=20
 #: git-gui.sh:1128
 msgid "Git directory not found:"
@@ -78,20 +74,19 @@ msgstr "=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=
=B2=D1=83=D0=B5=D1=82 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=
=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3"
=20
 #: git-gui.sh:1334 lib/checkout_op.tcl:306
 msgid "Refreshing file status..."
-msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D0=B8 =D0=BE =D1=81=
=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=
=D0=BE=D0=B2..."
+msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D0=B8 =D0=BE =D1=81=
=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=
=D0=BE=D0=B2=E2=80=A6"
=20
 #: git-gui.sh:1390
 msgid "Scanning for modified files ..."
-msgstr "=D0=9F=D0=BE=D0=B8=D1=81=D0=BA =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=
=B5=D0=BD=D0=BD=D1=8B=D1=85 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2..."
+msgstr "=D0=9F=D0=BE=D0=B8=D1=81=D0=BA =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=
=B5=D0=BD=D0=BD=D1=8B=D1=85 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=E2=80=A6=
"
=20
 #: git-gui.sh:1454
 msgid "Calling prepare-commit-msg hook..."
-msgstr "=D0=92=D1=8B=D0=B7=D0=BE=D0=B2 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=
=B0=D0=BC=D0=BC=D1=8B =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=BA=D0=
=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =
prepare-commit-msg..."
+msgstr "=D0=92=D1=8B=D0=B7=D0=BE=D0=B2 =D0=BF=D0=B5=D1=80=D0=B5=D1=85=D0=
=B2=D0=B0=D1=82=D1=87=D0=B8=D0=BA=D0=B0 prepare-commit-msg=E2=80=A6"
=20
 #: git-gui.sh:1471
 msgid "Commit declined by prepare-commit-msg hook."
-msgstr ""
-"=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BF=D1=
=80=D0=B5=D1=80=D0=B2=D0=B0=D0=BD=D0=BE =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=
=B0=D0=BC=D0=BC=D0=BE=D0=B9 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=
=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=
=8F prepare-commit-msg"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B8=D1=82 =D0=BF=D1=80=D0=B5=D1=80=D0=
=B2=D0=B0=D0=BD =D0=BF=D0=B5=D1=80=D0=B5=D1=85=D0=B2=D0=B0=D1=82=D1=87=D0=
=B8=D0=BA=D0=BE=D0=BC prepare-commit-msg."
=20
 #: git-gui.sh:1629 lib/browser.tcl:246
 msgid "Ready."
@@ -108,31 +103,31 @@ msgstr "=D0=9D=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=
=D0=B5=D0=BD=D0=BE"
=20
 #: git-gui.sh:1915
 msgid "Modified, not staged"
-msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE, =D0=BD=D0=B5=
 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE=
"
+msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE, =D0=BD=D0=B5=
 =D0=B2 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B5"
=20
 #: git-gui.sh:1916 git-gui.sh:1924
 msgid "Staged for commit"
-msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=
=D0=BD=D0=B8=D1=8F"
+msgstr "=D0=92 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B5 =D0=B4=D0=BB=
=D1=8F =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B0"
=20
 #: git-gui.sh:1917 git-gui.sh:1925
 msgid "Portions staged for commit"
-msgstr "=D0=A7=D0=B0=D1=81=D1=82=D0=B8, =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=
=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=B4=D0=BB=D1=8F=
 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
+msgstr "=D0=A7=D0=B0=D1=81=D1=82=D0=B8, =D0=B2 =D0=B8=D0=BD=D0=B4=D0=B5=
=D0=BA=D1=81=D0=B5 =D0=B4=D0=BB=D1=8F =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=
=82=D0=B0"
=20
 #: git-gui.sh:1918 git-gui.sh:1926
 msgid "Staged for commit, missing"
-msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=
=D0=BD=D0=B8=D1=8F, =D0=BE=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=
=83=D0=B5=D1=82"
+msgstr "=D0=92 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B5 =D0=B4=D0=BB=
=D1=8F =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B0, =D0=BE=D1=82=D1=81=D1=
=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82"
=20
 #: git-gui.sh:1920
 msgid "File type changed, not staged"
-msgstr "=D0=A2=D0=B8=D0=BF =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=B8=D0=B7=
=D0=BC=D0=B5=D0=BD=D1=91=D0=BD, =D0=BD=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B3=D0=
=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE"
+msgstr "=D0=A2=D0=B8=D0=BF =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=B8=D0=B7=
=D0=BC=D0=B5=D0=BD=D1=91=D0=BD, =D0=BD=D0=B5 =D0=B2 =D0=B8=D0=BD=D0=B4=D0=
=B5=D0=BA=D1=81=D0=B5"
=20
 #: git-gui.sh:1921
 msgid "File type changed, staged"
-msgstr "=D0=A2=D0=B8=D0=BF =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=B8=D0=B7=
=D0=BC=D0=B5=D0=BD=D1=91=D0=BD, =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=
=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE"
+msgstr "=D0=A2=D0=B8=D0=BF =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=B8=D0=B7=
=D0=BC=D0=B5=D0=BD=D1=91=D0=BD, =D0=B2 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=
=81=D0=B5"
=20
 #: git-gui.sh:1923
 msgid "Untracked, not staged"
-msgstr "=D0=9D=D0=B5 =D0=BE=D1=82=D1=81=D0=BB=D0=B5=D0=B6=D0=B8=D0=B2=D0=
=B0=D0=B5=D1=82=D1=81=D1=8F, =D0=BD=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=
=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE"
+msgstr "=D0=9D=D0=B5 =D0=BE=D1=82=D1=81=D0=BB=D0=B5=D0=B6=D0=B8=D0=B2=D0=
=B0=D0=B5=D1=82=D1=81=D1=8F, =D0=BD=D0=B5 =D0=B2 =D0=B8=D0=BD=D0=B4=D0=B5=
=D0=BA=D1=81=D0=B5"
=20
 #: git-gui.sh:1928
 msgid "Missing"
@@ -140,11 +135,11 @@ msgstr "=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=
=D0=B2=D1=83=D0=B5=D1=82"
=20
 #: git-gui.sh:1929
 msgid "Staged for removal"
-msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=
=D1=8F"
+msgstr "=D0=92 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B5 =D0=B4=D0=BB=
=D1=8F =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F"
=20
 #: git-gui.sh:1930
 msgid "Staged for removal, still present"
-msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=
=D1=8F, =D0=B5=D1=89=D0=B5 =D0=BD=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=
=BD=D0=BE"
+msgstr "=D0=92 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B5 =D0=B4=D0=BB=
=D1=8F =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F, =D0=B5=D1=89=D0=
=B5 =D0=BD=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=BE"
=20
 #: git-gui.sh:1932 git-gui.sh:1933 git-gui.sh:1934 git-gui.sh:1935
 #: git-gui.sh:1936 git-gui.sh:1937
@@ -153,7 +148,7 @@ msgstr "=D0=A2=D1=80=D0=B5=D0=B1=D1=83=D0=B5=D1=82=D1=
=81=D1=8F =D1=80=D0=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B5=D0=BD=D0=B8=D0=B5 =
=D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B0 =D0=BF=D1=80=D0=B8=
 =D1=81=D0=BB=D0=B8
=20
 #: git-gui.sh:1972
 msgid "Starting gitk... please wait..."
-msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D0=BA=D0=B0=D0=B5=D1=82=D1=81=D1=
=8F gitk... =D0=9F=D0=BE=D0=B4=D0=BE=D0=B6=D0=B4=D0=B8=D1=82=D0=B5, =D0=
=BF=D0=BE=D0=B6=D0=B0=D0=BB=D1=83=D0=B9=D1=81=D1=82=D0=B0..."
+msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D0=BA=D0=B0=D0=B5=D1=82=D1=81=D1=
=8F gitk=E2=80=A6 =D0=9F=D0=BE=D0=B4=D0=BE=D0=B6=D0=B4=D0=B8=D1=82=D0=B5=
, =D0=BF=D0=BE=D0=B6=D0=B0=D0=BB=D1=83=D0=B9=D1=81=D1=82=D0=B0=E2=80=A6=
"
=20
 #: git-gui.sh:1984
 msgid "Couldn't find gitk in PATH"
@@ -173,11 +168,11 @@ msgstr "=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=
=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C"
=20
 #: git-gui.sh:2458 lib/choose_rev.tcl:561
 msgid "Branch"
-msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C"
+msgstr "=D0=92=D0=B5=D1=82=D0=BA=D0=B0"
=20
 #: git-gui.sh:2461 lib/choose_rev.tcl:548
 msgid "Commit@@noun"
-msgstr "=D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B8=D1=82"
=20
 #: git-gui.sh:2464 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
 msgid "Merge"
@@ -197,29 +192,29 @@ msgstr "=D0=9F=D1=80=D0=BE=D1=81=D0=BC=D0=BE=D1=82=
=D1=80 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=B3=D0=BE =D0=BA=D0=B0=D1=
=82=D0=B0=D0=BB=D0=BE=D0=B3=D0=B0"
=20
 #: git-gui.sh:2483
 msgid "Browse Current Branch's Files"
-msgstr "=D0=9F=D1=80=D0=BE=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=B5=D1=82=D1=
=8C =D1=84=D0=B0=D0=B9=D0=BB=D1=8B =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=
=D0=B9 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
+msgstr "=D0=9F=D1=80=D0=BE=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=B5=D1=82=D1=
=8C =D1=84=D0=B0=D0=B9=D0=BB=D1=8B =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=
=D0=B9 =D0=B2=D0=B5=D1=82=D0=BA=D0=B8"
=20
 #: git-gui.sh:2487
 msgid "Browse Branch Files..."
-msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8B =D0=B2=D0=B5=D1=82=D0=B2=D0=B8..."
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8B =D0=B2=D0=B5=D1=82=D0=BA=D0=B8=E2=80=A6"
=20
 #: git-gui.sh:2492
 msgid "Visualize Current Branch's History"
-msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D1=
=82=D0=BE=D1=80=D0=B8=D1=8E =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B9 =
=D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D1=
=82=D0=BE=D1=80=D0=B8=D1=8E =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B9 =
=D0=B2=D0=B5=D1=82=D0=BA=D0=B8"
=20
 #: git-gui.sh:2496
 msgid "Visualize All Branch History"
-msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D1=
=82=D0=BE=D1=80=D0=B8=D1=8E =D0=B2=D1=81=D0=B5=D1=85 =D0=B2=D0=B5=D1=82=
=D0=B2=D0=B5=D0=B9"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D1=
=82=D0=BE=D1=80=D0=B8=D1=8E =D0=B2=D1=81=D0=B5=D1=85 =D0=B2=D0=B5=D1=82=
=D0=BE=D0=BA"
=20
 #: git-gui.sh:2503
 #, tcl-format
 msgid "Browse %s's Files"
-msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8B =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 %s"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8B =D0=B2=D0=B5=D1=82=D0=BA=D0=B8 %s"
=20
 #: git-gui.sh:2505
 #, tcl-format
 msgid "Visualize %s's History"
-msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D1=
=82=D0=BE=D1=80=D0=B8=D1=8E =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 %s"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D1=
=82=D0=BE=D1=80=D0=B8=D1=8E =D0=B2=D0=B5=D1=82=D0=BA=D0=B8 %s"
=20
 #: git-gui.sh:2510 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
@@ -274,23 +269,23 @@ msgstr "=D0=92=D1=8B=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=
=D1=8C =D0=B2=D1=81=D0=B5"
=20
 #: git-gui.sh:2576
 msgid "Create..."
-msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C..."
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C=E2=80=A6"
=20
 #: git-gui.sh:2582
 msgid "Checkout..."
-msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8..."
+msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8=E2=80=A6"
=20
 #: git-gui.sh:2588
 msgid "Rename..."
-msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B8=D0=BC=D0=B5=D0=BD=D0=BE=D0=B2=D0=
=B0=D1=82=D1=8C..."
+msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B8=D0=BC=D0=B5=D0=BD=D0=BE=D0=B2=D0=
=B0=D1=82=D1=8C=E2=80=A6"
=20
 #: git-gui.sh:2593
 msgid "Delete..."
-msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C..."
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C=E2=80=A6"
=20
 #: git-gui.sh:2598
 msgid "Reset..."
-msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81=D0=B8=D1=82=D1=8C..."
+msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81=D0=B8=D1=82=D1=8C=E2=80=A6"
=20
 #: git-gui.sh:2608
 msgid "Done"
@@ -298,15 +293,15 @@ msgstr "=D0=97=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B5=
=D0=BD=D0=BE"
=20
 #: git-gui.sh:2610
 msgid "Commit@@verb"
-msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C"
+msgstr "=D0=97=D0=B0=D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B8=D1=82=D1=
=8C"
=20
 #: git-gui.sh:2619 git-gui.sh:3050
 msgid "New Commit"
-msgstr "=D0=9D=D0=BE=D0=B2=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=
=8F=D0=BD=D0=B8=D0=B5"
+msgstr "=D0=9D=D0=BE=D0=B2=D1=8B=D0=B9 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=
=82"
=20
 #: git-gui.sh:2627 git-gui.sh:3057
 msgid "Amend Last Commit"
-msgstr "=D0=98=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=BF=D0=
=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D0=B5"
+msgstr "=D0=98=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=BF=D0=
=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B8=D0=B9 =D0=BA=D0=BE=D0=BC=D0=BC=D0=
=B8=D1=82"
=20
 #: git-gui.sh:2637 git-gui.sh:3011 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
@@ -314,15 +309,15 @@ msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=
=D0=B0=D1=82=D1=8C"
=20
 #: git-gui.sh:2643
 msgid "Stage To Commit"
-msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=
=D0=B8=D1=8F"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=B2 =D0=B8=
=D0=BD=D0=B4=D0=B5=D0=BA=D1=81"
=20
 #: git-gui.sh:2649
 msgid "Stage Changed Files To Commit"
-msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D1=84=
=D0=B0=D0=B9=D0=BB=D1=8B =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=
=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D1=91=D0=BD=D0=BD=D1=8B=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D1=
=8B =D0=B2 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81"
=20
 #: git-gui.sh:2655
 msgid "Unstage From Commit"
-msgstr "=D0=A3=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D0=B8=D0=B7 =D0=BF=D0=BE=
=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=
=D0=BE"
+msgstr "=D0=A3=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D0=B8=D0=B7 =D0=B8=D0=B7=
=D0=B4=D0=B5=D0=BA=D1=81=D0=B0"
=20
 #: git-gui.sh:2661 lib/index.tcl:412
 msgid "Revert Changes"
@@ -342,31 +337,31 @@ msgstr "=D0=92=D1=81=D1=82=D0=B0=D0=B2=D0=B8=D1=82=
=D1=8C Signed-off-by"
=20
 #: git-gui.sh:2696
 msgid "Local Merge..."
-msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B5 =D1=81=D0=
=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5..."
+msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B5 =D1=81=D0=
=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5=E2=80=A6"
=20
 #: git-gui.sh:2701
 msgid "Abort Merge..."
-msgstr "=D0=9F=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D1=82=D1=8C =D1=81=D0=BB=D0=
=B8=D1=8F=D0=BD=D0=B8=D0=B5..."
+msgstr "=D0=9F=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D1=82=D1=8C =D1=81=D0=BB=D0=
=B8=D1=8F=D0=BD=D0=B8=D0=B5=E2=80=A6"
=20
 #: git-gui.sh:2713 git-gui.sh:2741
 msgid "Add..."
-msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C..."
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C=E2=80=A6"
=20
 #: git-gui.sh:2717
 msgid "Push..."
-msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C..."
+msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C=E2=80=A6=
"
=20
 #: git-gui.sh:2721
 msgid "Delete Branch..."
-msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=
=B2=D1=8C..."
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=
=BA=D1=83=E2=80=A6"
=20
 #: git-gui.sh:2731 git-gui.sh:3292
 msgid "Options..."
-msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8..."
+msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8=E2=80=A6=
"
=20
 #: git-gui.sh:2742
 msgid "Remove..."
-msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C..."
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C=E2=80=A6"
=20
 #: git-gui.sh:2751 lib/choose_repository.tcl:50
 msgid "Help"
@@ -393,11 +388,11 @@ msgstr "=D0=BA=D1=80=D0=B8=D1=82=D0=B8=D1=87=D0=B5=
=D1=81=D0=BA=D0=B0=D1=8F =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=B0: %s: =D0=BD=
=D0=B5=D1=82 =D1=82=D0=B0=D0=BA=D0=BE=D0=B3=D0=BE =D1=84=D0=B0=D0=B9=D0=
=BB=D0=B0
=20
 #: git-gui.sh:2926
 msgid "Current Branch:"
-msgstr "=D0=A2=D0=B5=D0=BA=D1=83=D1=89=D0=B0=D1=8F =D0=B2=D0=B5=D1=82=D0=
=B2=D1=8C:"
+msgstr "=D0=A2=D0=B5=D0=BA=D1=83=D1=89=D0=B0=D1=8F =D0=B2=D0=B5=D1=82=D0=
=BA=D0=B0:"
=20
 #: git-gui.sh:2947
 msgid "Staged Changes (Will Commit)"
-msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE (=D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=BE=D1=85=D1=80=D0=B0=
=D0=BD=D0=B5=D0=BD=D0=BE)"
+msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 =
=D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B5 (=D0=B1=D1=83=D0=B4=D1=83=D1=
=82 =D0=B7=D0=B0=D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=87=D0=B5=D0=BD=D1=8B)=
"
=20
 #: git-gui.sh:2967
 msgid "Unstaged Changes"
@@ -405,7 +400,7 @@ msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=
=BE (=D0=BD=D0=B5 =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=BE=D1=85=D1=80=
=D0=B0=D0=BD=D0=B5=D0=BD=D0=BE)"
=20
 #: git-gui.sh:3017
 msgid "Stage Changed"
-msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D0=B2=D1=81=D0=B5"
+msgstr "=D0=98=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B8=D1=80=D0=BE=D0=B2=D0=
=B0=D1=82=D1=8C =D0=B2=D1=81=D1=91"
=20
 #: git-gui.sh:3036 lib/transport.tcl:104 lib/transport.tcl:193
 msgid "Push"
@@ -413,27 +408,27 @@ msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=
=D1=82=D1=8C"
=20
 #: git-gui.sh:3071
 msgid "Initial Commit Message:"
-msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=
=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E:"
+msgstr "=D0=A1=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BF=D0=
=B5=D1=80=D0=B2=D0=BE=D0=B3=D0=BE =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=
=B0:"
=20
 #: git-gui.sh:3072
 msgid "Amended Commit Message:"
-msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E=
:"
+msgstr "=D0=A1=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B8=D1=
=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D0=
=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B0:"
=20
 #: git-gui.sh:3073
 msgid "Amended Initial Commit Message:"
-msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=BC=D1=83 =D0=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=BD=D0=B0=D1=87=D0=B0=
=D0=BB=D1=8C=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=
=D0=BD=D0=B8=D1=8E:"
+msgstr "=D0=A1=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B8=D1=
=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D0=
=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=B3=D0=BE =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=
=82=D0=B0:"
=20
 #: git-gui.sh:3074
 msgid "Amended Merge Commit Message:"
-msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=BC=D1=83 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8E:"
+msgstr "=D0=A1=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B8=D1=
=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D1=
=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F:"
=20
 #: git-gui.sh:3075
 msgid "Merge Commit Message:"
-msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8E:"
+msgstr "=D0=A1=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D1=81=D0=
=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F:"
=20
 #: git-gui.sh:3076
 msgid "Commit Message:"
-msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E:"
+msgstr "=D0=A1=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BA=D0=
=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B0:"
=20
 #: git-gui.sh:3125 git-gui.sh:3267 lib/console.tcl:73
 msgid "Copy All"
@@ -485,47 +480,47 @@ msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=
=D1=8C =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
 #: git-gui.sh:3354
 msgid "Visualize These Changes In The Submodule"
-msgstr ""
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=8D=D1=82=D0=
=B8 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D0=BE=
=D0=B4=D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F"
=20
 #: git-gui.sh:3358
 msgid "Visualize Current Branch History In The Submodule"
-msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D1=
=82=D0=BE=D1=80=D0=B8=D1=8E =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B9 =
=D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=BF=D0=BE=D0=B4=D0=BC=D0=BE=D0=B4=D1=83=
=D0=BB=D1=8F"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D1=
=82=D0=BE=D1=80=D0=B8=D1=8E =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B9 =
=D0=B2=D0=B5=D1=82=D0=BA=D0=B8 =D0=BF=D0=BE=D0=B4=D0=BC=D0=BE=D0=B4=D1=83=
=D0=BB=D1=8F"
=20
 #: git-gui.sh:3362
 msgid "Visualize All Branch History In The Submodule"
-msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D1=
=82=D0=BE=D1=80=D0=B8=D1=8E =D0=B2=D1=81=D0=B5=D1=85 =D0=B2=D0=B5=D1=82=
=D0=B2=D0=B5=D0=B9 =D0=BF=D0=BE=D0=B4=D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F=
"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D1=
=82=D0=BE=D1=80=D0=B8=D1=8E =D0=B2=D1=81=D0=B5=D1=85 =D0=B2=D0=B5=D1=82=
=D0=BE=D0=BA =D0=BF=D0=BE=D0=B4=D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F"
=20
 #: git-gui.sh:3367
 msgid "Start git gui In The Submodule"
-msgstr ""
+msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C git gui=
 =D0=B2 =D0=BF=D0=BE=D0=B4=D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D0=B5"
=20
 #: git-gui.sh:3389
 msgid "Unstage Hunk From Commit"
-msgstr "=D0=9D=D0=B5 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D1=8F=D1=82=D1=
=8C =D1=87=D0=B0=D1=81=D1=82=D1=8C"
+msgstr "=D0=A3=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D0=B1=D0=BB=D0=BE=D0=BA =
=D0=B8=D0=B7 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0"
=20
 #: git-gui.sh:3391
 msgid "Unstage Lines From Commit"
-msgstr "=D0=A3=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D1=81=D1=82=D1=80=D0=BE=D0=
=BA=D0=B8 =D0=B8=D0=B7 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=
=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE"
+msgstr "=D0=A3=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D1=81=D1=82=D1=80=D0=BE=D0=
=BA=D0=B8 =D0=B8=D0=B7 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0"
=20
 #: git-gui.sh:3393
 msgid "Unstage Line From Commit"
-msgstr "=D0=A3=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D1=81=D1=82=D1=80=D0=BE=D0=
=BA=D1=83 =D0=B8=D0=B7 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=
=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE"
+msgstr "=D0=A3=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D1=81=D1=82=D1=80=D0=BE=D0=
=BA=D1=83 =D0=B8=D0=B7 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0"
=20
 #: git-gui.sh:3396
 msgid "Stage Hunk For Commit"
-msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D1=87=D0=B0=D1=81=D1=82=D1=8C =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=
=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=B1=D0=BB=D0=
=BE=D0=BA =D0=B2 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81"
=20
 #: git-gui.sh:3398
 msgid "Stage Lines For Commit"
-msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=B8 =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=
=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D1=81=D1=82=D1=
=80=D0=BE=D0=BA=D0=B8 =D0=B2 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81"
=20
 #: git-gui.sh:3400
 msgid "Stage Line For Commit"
-msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D1=81=D1=82=D1=80=D0=BE=D0=BA=D1=83 =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=
=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D1=81=D1=82=D1=
=80=D0=BE=D0=BA=D1=83 =D0=B2 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81"
=20
 #: git-gui.sh:3424
 msgid "Initializing..."
-msgstr "=D0=98=D0=BD=D0=B8=D1=86=D0=B8=D0=B0=D0=BB=D0=B8=D0=B7=D0=B0=D1=
=86=D0=B8=D1=8F..."
+msgstr "=D0=98=D0=BD=D0=B8=D1=86=D0=B8=D0=B0=D0=BB=D0=B8=D0=B7=D0=B0=D1=
=86=D0=B8=D1=8F=E2=80=A6"
=20
 #: git-gui.sh:3541
 #, tcl-format
@@ -536,23 +531,14 @@ msgid ""
 "going to be ignored by any Git subprocess run\n"
 "by %s:\n"
 "\n"
-msgstr ""
-"=D0=92=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D1=8B =D0=BE=D1=88=D0=B8=D0=
=B1=D0=BA=D0=B8 =D0=B2 =D0=BF=D0=B5=D1=80=D0=B5=D0=BC=D0=B5=D0=BD=D0=BD=
=D1=8B=D1=85 =D0=BE=D0=BA=D1=80=D1=83=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F.\n"
-"\n"
-"=D0=9F=D0=B5=D1=80=D0=B5=D0=BC=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BE=D0=
=BA=D1=80=D1=83=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F, =D0=BA=D0=BE=D1=82=D0=BE=
=D1=80=D1=8B=D0=B5 =D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE\n"
-"=D0=B1=D1=83=D0=B4=D1=83=D1=82 =D0=BF=D1=80=D0=BE=D0=B8=D0=B3=D0=BD=D0=
=BE=D1=80=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D1=8B =D0=BA=D0=BE=D0=BC=D0=
=B0=D0=BD=D0=B4=D0=B0=D0=BC=D0=B8 Git,\n"
-"=D0=B7=D0=B0=D0=BF=D1=83=D1=89=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC=D0=B8 =D0=
=B8=D0=B7 %s\n"
-"\n"
+msgstr "=D0=92=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D1=8B =D0=BE=D1=88=D0=
=B8=D0=B1=D0=BA=D0=B8 =D0=B2 =D0=BF=D0=B5=D1=80=D0=B5=D0=BC=D0=B5=D0=BD=
=D0=BD=D1=8B=D1=85 =D0=BE=D0=BA=D1=80=D1=83=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F=
=2E\n\n=D0=9F=D0=B5=D1=80=D0=B5=D0=BC=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=
=BE=D0=BA=D1=80=D1=83=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F, =D0=BA=D0=BE=D1=82=
=D0=BE=D1=80=D1=8B=D0=B5 =D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE=
\n=D0=B1=D1=83=D0=B4=D1=83=D1=82 =D0=BF=D1=80=D0=BE=D0=B8=D0=B3=D0=BD=D0=
=BE=D1=80=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D1=8B =D0=BA=D0=BE=D0=BC=D0=
=B0=D0=BD=D0=B4=D0=B0=D0=BC=D0=B8 Git,\n=D0=B7=D0=B0=D0=BF=D1=83=D1=89=D0=
=B5=D0=BD=D0=BD=D1=8B=D0=BC=D0=B8 =D0=B8=D0=B7 %s\n\n"
=20
 #: git-gui.sh:3570
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
 "Tcl binary distributed by Cygwin."
-msgstr ""
-"\n"
-"=D0=AD=D1=82=D0=BE =D0=B8=D0=B7=D0=B2=D0=B5=D1=81=D1=82=D0=BD=D0=B0=D1=
=8F =D0=BF=D1=80=D0=BE=D0=B1=D0=BB=D0=B5=D0=BC=D0=B0 =D1=81 Tcl,\n"
-"=D1=80=D0=B0=D1=81=D0=BF=D1=80=D0=BE=D1=81=D1=82=D1=80=D0=B0=D0=BD=D1=
=8F=D0=B5=D0=BC=D1=8B=D0=BC Cygwin."
+msgstr "\n=D0=AD=D1=82=D0=BE =D0=B8=D0=B7=D0=B2=D0=B5=D1=81=D1=82=D0=BD=
=D0=B0=D1=8F =D0=BF=D1=80=D0=BE=D0=B1=D0=BB=D0=B5=D0=BC=D0=B0 =D1=81 Tc=
l,\n=D1=80=D0=B0=D1=81=D0=BF=D1=80=D0=BE=D1=81=D1=82=D1=80=D0=B0=D0=BD=D1=
=8F=D0=B5=D0=BC=D1=8B=D0=BC Cygwin."
=20
 #: git-gui.sh:3575
 #, tcl-format
@@ -563,13 +549,7 @@ msgid ""
 "is placing values for the user.name and\n"
 "user.email settings into your personal\n"
 "~/.gitconfig file.\n"
-msgstr ""
-"\n"
-"\n"
-"=D0=92=D0=BC=D0=B5=D1=81=D1=82=D0=BE =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=
=8C=D0=B7=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F %s =D0=BC=D0=BE=D0=B6=D0=BD=
=D0=BE\n"
-"=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C =D0=B7=D0=BD=D0=
=B0=D1=87=D0=B5=D0=BD=D0=B8=D1=8F user.name =D0=B8\n"
-"user.email =D0=B2 =D0=92=D0=B0=D1=88=D0=B5=D0=BC =D0=BF=D0=B5=D1=80=D1=
=81=D0=BE=D0=BD=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=BC\n"
-"=D1=84=D0=B0=D0=B9=D0=BB=D0=B5 ~/.gitconfig.\n"
+msgstr "\n\n=D0=92=D0=BC=D0=B5=D1=81=D1=82=D0=BE =D0=B8=D1=81=D0=BF=D0=
=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F %s =D0=BC=D0=BE=
=D0=B6=D0=BD=D0=BE\n=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=
=8C =D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=D0=B8=D1=8F user.name =D0=B8\n=
user.email =D0=B2 =D0=92=D0=B0=D1=88=D0=B5=D0=BC =D0=BF=D0=B5=D1=80=D1=81=
=D0=BE=D0=BD=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=BC\n=D1=84=D0=B0=D0=B9=D0=
=BB=D0=B5 ~/.gitconfig.\n"
=20
 #: lib/about.tcl:26
 msgid "git-gui - a graphical user interface for Git."
@@ -581,15 +561,15 @@ msgstr "=D0=9F=D1=80=D0=BE=D1=81=D0=BC=D0=BE=D1=82=
=D1=80 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0"
=20
 #: lib/blame.tcl:78
 msgid "Commit:"
-msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=
=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5:"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B8=D1=82:"
=20
 #: lib/blame.tcl:271
 msgid "Copy Commit"
-msgstr "=D0=A1=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=
=8C SHA-1"
+msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C S=
HA-1"
=20
 #: lib/blame.tcl:275
 msgid "Find Text..."
-msgstr "=D0=9D=D0=B0=D0=B9=D1=82=D0=B8 =D1=82=D0=B5=D0=BA=D1=81=D1=82.=
=2E."
+msgstr "=D0=9D=D0=B0=D0=B9=D1=82=D0=B8 =D1=82=D0=B5=D0=BA=D1=81=D1=82=E2=
=80=A6"
=20
 #: lib/blame.tcl:284
 msgid "Do Full Copy Detection"
@@ -601,16 +581,16 @@ msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=
=D1=8C =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8=
=D0=B9 =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=D1=82"
=20
 #: lib/blame.tcl:291
 msgid "Blame Parent Commit"
-msgstr "=D0=A0=D0=B0=D1=81=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=B5=D1=82=D1=
=8C =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BF=D1=80=
=D0=B5=D0=B4=D0=BA=D0=B0"
+msgstr "=D0=90=D0=B2=D1=82=D0=BE=D1=80=D1=8B =D1=80=D0=BE=D0=B4=D0=B8=D1=
=82=D0=B5=D0=BB=D1=8C=D1=81=D0=BA=D0=BE=D0=B3=D0=BE =D0=BA=D0=BE=D0=BC=D0=
=BC=D0=B8=D1=82=D0=B0"
=20
 #: lib/blame.tcl:450
 #, tcl-format
 msgid "Reading %s..."
-msgstr "=D0=A7=D1=82=D0=B5=D0=BD=D0=B8=D0=B5 %s..."
+msgstr "=D0=A7=D1=82=D0=B5=D0=BD=D0=B8=D0=B5 %s=E2=80=A6"
=20
 #: lib/blame.tcl:557
 msgid "Loading copy/move tracking annotations..."
-msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 =D0=B0=D0=BD=D0=
=BD=D0=BE=D1=82=D0=B0=D1=86=D0=B8=D0=B8 =D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=
=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B9/=D0=BF=D0=B5=D1=80=D0=B5=D0=B8=D0=BC=D0=
=B5=D0=BD=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B9..."
+msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 =D0=B0=D0=BD=D0=
=BD=D0=BE=D1=82=D0=B0=D1=86=D0=B8=D0=B8 =D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=
=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B9/=D0=BF=D0=B5=D1=80=D0=B5=D0=B8=D0=BC=D0=
=B5=D0=BD=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B9=E2=80=A6"
=20
 #: lib/blame.tcl:577
 msgid "lines annotated"
@@ -618,7 +598,7 @@ msgstr "=D1=81=D1=82=D1=80=D0=BE=D0=BA =D0=BF=D1=80=
=D0=BE=D0=BA=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B8=D1=80=D0=BE=D0=B2=
=D0=B0=D0=BD=D0=BE"
=20
 #: lib/blame.tcl:769
 msgid "Loading original location annotations..."
-msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 =D0=B0=D0=BD=D0=
=BD=D0=BE=D1=82=D0=B0=D1=86=D0=B8=D0=B9 =D0=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=
=BD=D0=B0=D1=87=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B3=D0=BE =D0=BF=D0=BE=D0=
=BB=D0=BE=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=
=82=D0=B0..."
+msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 =D0=B0=D0=BD=D0=
=BD=D0=BE=D1=82=D0=B0=D1=86=D0=B8=D0=B9 =D0=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=
=BD=D0=B0=D1=87=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B3=D0=BE =D0=BF=D0=BE=D0=
=BB=D0=BE=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=
=82=D0=B0=E2=80=A6"
=20
 #: lib/blame.tcl:772
 msgid "Annotation complete."
@@ -634,11 +614,11 @@ msgstr "=D0=90=D0=BD=D0=BD=D0=BE=D1=82=D0=B0=D1=86=
=D0=B8=D1=8F =D1=83=D0=B6=D0=B5 =D0=B7=D0=B0=D0=BF=D1=83=D1=89=D0=B5=D0=
=BD=D0=B0"
=20
 #: lib/blame.tcl:842
 msgid "Running thorough copy detection..."
-msgstr "=D0=92=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D0=BE=D0=BB=D0=BD=D0=BE=D0=B3=D0=BE =D0=BF=D0=BE=D0=B8=D1=81=D0=BA=D0=
=B0 =D0=BA=D0=BE=D0=BF=D0=B8=D0=B9..."
+msgstr "=D0=92=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D0=BE=D0=BB=D0=BD=D0=BE=D0=B3=D0=BE =D0=BF=D0=BE=D0=B8=D1=81=D0=BA=D0=
=B0 =D0=BA=D0=BE=D0=BF=D0=B8=D0=B9=E2=80=A6"
=20
 #: lib/blame.tcl:910
 msgid "Loading annotation..."
-msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 =D0=B0=D0=BD=D0=
=BD=D0=BE=D1=82=D0=B0=D1=86=D0=B8=D0=B8..."
+msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 =D0=B0=D0=BD=D0=
=BD=D0=BE=D1=82=D0=B0=D1=86=D0=B8=D0=B8=E2=80=A6"
=20
 #: lib/blame.tcl:963
 msgid "Author:"
@@ -646,7 +626,7 @@ msgstr "=D0=90=D0=B2=D1=82=D0=BE=D1=80:"
=20
 #: lib/blame.tcl:967
 msgid "Committer:"
-msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB:"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B5=D1=80:"
=20
 #: lib/blame.tcl:972
 msgid "Original File:"
@@ -654,11 +634,11 @@ msgstr "=D0=98=D1=81=D1=85=D0=BE=D0=B4=D0=BD=D1=8B=
=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB:"
=20
 #: lib/blame.tcl:1020
 msgid "Cannot find HEAD commit:"
-msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=BD=D0=B0=D0=B9=D1=82=D0=B8 =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B5 =
=D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5:"
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BD=
=D0=B0=D0=B9=D1=82=D0=B8 =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B5 =D1=
=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5:"
=20
 #: lib/blame.tcl:1075
 msgid "Cannot find parent commit:"
-msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=BD=D0=B0=D0=B9=D1=82=D0=B8 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=
=B8=D0=B5 =D0=BF=D1=80=D0=B5=D0=B4=D0=BA=D0=B0:"
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BD=
=D0=B0=D0=B9=D1=82=D0=B8 =D1=80=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=
=D1=81=D0=BA=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=
=D0=B5:"
=20
 #: lib/blame.tcl:1090
 msgid "Unable to display parent"
@@ -682,7 +662,7 @@ msgstr "=D0=A1=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=
=B2=D0=B0=D0=BD=D0=BE/=D0=BF=D0=B5=D1=80=D0=B5=D0=BC=D0=B5=D1=89=D0=B5=D0=
=BD=D0=BE =D0=B2:"
=20
 #: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
 msgid "Checkout Branch"
-msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BD=D0=B0 =D0=B2=
=D0=B5=D1=82=D0=B2=D1=8C"
+msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BD=D0=B0 =D0=B2=
=D0=B5=D1=82=D0=BA=D1=83"
=20
 #: lib/branch_checkout.tcl:23
 msgid "Checkout"
@@ -707,19 +687,19 @@ msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=
=D0=BA=D0=B8"
=20
 #: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
 msgid "Fetch Tracking Branch"
-msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B8=D0=B7 =D0=B2=D0=BD=D0=B5=
=D1=88=D0=BD=D0=B5=D0=B9 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
+msgstr "=D0=98=D0=B7=D0=B2=D0=BB=D0=B5=D1=87=D1=8C =D0=B8=D0=B7=D0=BC=D0=
=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B8=D0=B7 =D0=B2=D0=BD=D0=B5=D1=88=
=D0=BD=D0=B5=D0=B9 =D0=B2=D0=B5=D1=82=D0=BA=D0=B8"
=20
 #: lib/branch_checkout.tcl:44
 msgid "Detach From Local Branch"
-msgstr "=D0=9E=D1=82=D1=81=D0=BE=D0=B5=D0=B4=D0=B8=D0=BD=D0=B8=D1=82=D1=
=8C =D0=BE=D1=82 =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B9=
 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
+msgstr "=D0=9E=D1=82=D1=81=D0=BE=D0=B5=D0=B4=D0=B8=D0=BD=D0=B8=D1=82=D1=
=8C =D0=BE=D1=82 =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B9=
 =D0=B2=D0=B5=D1=82=D0=BA=D0=B8"
=20
 #: lib/branch_create.tcl:22
 msgid "Create Branch"
-msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B8"
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=
=BA=D1=83"
=20
 #: lib/branch_create.tcl:27
 msgid "Create New Branch"
-msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=BD=D0=BE=D0=B2=D1=
=83=D1=8E =D0=B2=D0=B5=D1=82=D0=B2=D1=8C"
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=BD=D0=BE=D0=B2=D1=
=83=D1=8E =D0=B2=D0=B5=D1=82=D0=BA=D1=83"
=20
 #: lib/branch_create.tcl:31 lib/choose_repository.tcl:381
 msgid "Create"
@@ -727,7 +707,7 @@ msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C"
=20
 #: lib/branch_create.tcl:40
 msgid "Branch Name"
-msgstr "=D0=9D=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B8"
+msgstr "=D0=98=D0=BC=D1=8F =D0=B2=D0=B5=D1=82=D0=BA=D0=B8"
=20
 #: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
 msgid "Name:"
@@ -735,7 +715,7 @@ msgstr "=D0=9D=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B8=D0=
=B5:"
=20
 #: lib/branch_create.tcl:58
 msgid "Match Tracking Branch Name"
-msgstr "=D0=92=D0=B7=D1=8F=D1=82=D1=8C =D0=B8=D0=B7 =D0=B8=D0=BC=D0=B5=
=D0=BD =D0=B2=D0=B5=D1=82=D0=B2=D0=B5=D0=B9 =D1=81=D0=BB=D0=B5=D0=B6=D0=
=B5=D0=BD=D0=B8=D1=8F"
+msgstr "=D0=A1=D0=BE=D0=BE=D1=82=D0=B2=D0=B5=D1=82=D1=81=D1=82=D0=B2=D0=
=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=B8=D0=BC=D0=B5=D0=BD=D0=B8 =D0=BE=D1=82=
=D1=81=D0=BB=D0=B5=D0=B6=D0=B8=D0=B2=D0=B0=D0=B5=D0=BC=D0=BE=D0=B9 =D0=B2=
=D0=B5=D1=82=D0=BA=D0=B8"
=20
 #: lib/branch_create.tcl:66
 msgid "Starting Revision"
@@ -743,7 +723,7 @@ msgstr "=D0=9D=D0=B0=D1=87=D0=B0=D0=BB=D1=8C=D0=BD=D0=
=B0=D1=8F =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F"
=20
 #: lib/branch_create.tcl:72
 msgid "Update Existing Branch:"
-msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D0=B8=D0=BC=D0=
=B5=D1=8E=D1=89=D1=83=D1=8E=D1=81=D1=8F =D0=B2=D0=B5=D1=82=D0=B2=D1=8C:=
"
+msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D0=B8=D0=BC=D0=
=B5=D1=8E=D1=89=D1=83=D1=8E=D1=81=D1=8F =D0=B2=D0=B5=D1=82=D0=BA=D1=83:=
"
=20
 #: lib/branch_create.tcl:75
 msgid "No"
@@ -763,33 +743,33 @@ msgstr "=D0=9F=D0=BE=D1=81=D0=BB=D0=B5 =D1=81=D0=BE=
=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D1=8F =D1=81=D0=B4=D0=B5=D0=BB=D0=B0=D1=82=
=D1=8C =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B9"
=20
 #: lib/branch_create.tcl:131
 msgid "Please select a tracking branch."
-msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B8=D1=82=D0=B5 =D0=B2=D0=B5=D1=82=D0=
=B2=D1=8C =D1=81=D0=BB=D0=B5=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F."
+msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B8=D1=82=D0=B5 =D0=BE=D1=82=D0=BB=D0=
=B5=D0=B6=D0=B8=D0=B2=D0=B0=D0=B5=D0=BC=D1=83=D1=8E =D0=B2=D0=B5=D1=82=D0=
=BA=D1=83."
=20
 #: lib/branch_create.tcl:140
 #, tcl-format
 msgid "Tracking branch %s is not a branch in the remote repository."
-msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C =D1=81=D0=BB=D0=B5=D0=B6=D0=B5=D0=
=BD=D0=B8=D1=8F %s =D0=BD=D0=B5 =D1=8F=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=D1=
=81=D1=8F =D0=B2=D0=B5=D1=82=D0=B2=D1=8C=D1=8E =D0=B2=D0=BE =D0=B2=D0=BD=
=D0=B5=D1=88=D0=BD=D0=B5=D0=BC =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=
=D0=BE=D1=80=D0=B8=D0=B8."
+msgstr "=D0=9E=D1=82=D1=81=D0=BB=D0=B5=D0=B6=D0=B8=D0=B2=D0=B0=D0=B5=D0=
=BC=D0=B0=D1=8F =D0=B2=D0=B5=D1=82=D0=BA=D0=B0 %s =D0=BD=D0=B5 =D1=8F=D0=
=B2=D0=BB=D1=8F=D0=B5=D1=82=D1=81=D1=8F =D0=B2=D0=B5=D1=82=D0=BA=D0=BE=D0=
=B9 =D0=BD=D0=B0 =D0=B2=D0=BD=D0=B5=D1=88=D0=BD=D0=B5=D0=BC =D1=80=D0=B5=
=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B8."
=20
 #: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
 msgid "Please supply a branch name."
-msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B8=D1=82=D0=B5 =D0=BD=D0=B0=D0=B7=D0=
=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8."
+msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B8=D1=82=D0=B5 =D0=B8=D0=BC=D1=8F =
=D0=B2=D0=B5=D1=82=D0=BA=D0=B8."
=20
 #: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
 #, tcl-format
 msgid "'%s' is not an acceptable branch name."
-msgstr "=D0=9D=D0=B5=D0=B4=D0=BE=D0=BF=D1=83=D1=81=D1=82=D0=B8=D0=BC=D0=
=BE=D0=B5 =D0=BD=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B2=D0=B5=
=D1=82=D0=B2=D0=B8 '%s'."
+msgstr "=D0=9D=D0=B5=D0=B4=D0=BE=D0=BF=D1=83=D1=81=D1=82=D0=B8=D0=BC=D0=
=BE=D0=B5 =D0=B8=D0=BC=D1=8F =D0=B2=D0=B5=D1=82=D0=BA=D0=B8 =C2=AB%s=C2=
=BB."
=20
 #: lib/branch_delete.tcl:15
 msgid "Delete Branch"
-msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B8"
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B2=D0=B5=D1=
=82=D0=BA=D0=B8"
=20
 #: lib/branch_delete.tcl:20
 msgid "Delete Local Branch"
-msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D0=BB=D0=BE=D0=BA=D0=
=B0=D0=BB=D1=8C=D0=BD=D1=83=D1=8E =D0=B2=D0=B5=D1=82=D0=B2=D1=8C"
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D0=BB=D0=BE=D0=BA=D0=
=B0=D0=BB=D1=8C=D0=BD=D1=83=D1=8E =D0=B2=D0=B5=D1=82=D0=BA=D1=83"
=20
 #: lib/branch_delete.tcl:37
 msgid "Local Branches"
-msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D1=8B=D0=B5 =D0=B2=D0=
=B5=D1=82=D0=B2=D0=B8"
+msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D1=8B=D0=B5 =D0=B2=D0=
=B5=D1=82=D0=BA=D0=B8"
=20
 #: lib/branch_delete.tcl:52
 msgid "Delete Only If Merged Into"
@@ -802,30 +782,25 @@ msgstr "=D0=92=D1=81=D0=B5=D0=B3=D0=B4=D0=B0 (=D0=
=BD=D0=B5 =D0=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D1=8F=D1=82=D1=8C =D0=BF=
=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D1=83 =D0=BD=D0=B0 =D1=81=D0=BB=D0=
=B8=D1=8F=D0=BD=D0=B8
 #: lib/branch_delete.tcl:103
 #, tcl-format
 msgid "The following branches are not completely merged into %s:"
-msgstr "=D0=92=D0=B5=D1=82=D0=B2=D0=B8, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=
=D1=8B=D0=B5 =D0=BD=D0=B5 =D0=BF=D0=BE=D0=BB=D0=BD=D0=BE=D1=81=D1=82=D1=
=8C=D1=8E =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D1=8E=D1=82=D1=81=D1=8F =D1=81=
 %s:"
+msgstr "=D0=92=D0=B5=D1=82=D0=BA=D0=B8, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=
=D1=8B=D0=B5 =D0=BD=D0=B5 =D0=BF=D0=BE=D0=BB=D0=BD=D0=BE=D1=81=D1=82=D1=
=8C=D1=8E =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D1=8E=D1=82=D1=81=D1=8F =D1=81=
 %s:"
=20
 #: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:217
 msgid ""
 "Recovering deleted branches is difficult.\n"
 "\n"
 "Delete the selected branches?"
-msgstr ""
-"=D0=92=D0=BE=D1=81=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=B2=D0=B5=
=D1=82=D0=B2=D0=B8 =D1=81=D0=BB=D0=BE=D0=B6=D0=BD=D0=BE.\n"
-"\n"
-"=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C?"
+msgstr "=D0=92=D0=BE=D1=81=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=
=82=D1=8C =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=B2=
=D0=B5=D1=82=D0=BA=D0=B8 =D1=81=D0=BB=D0=BE=D0=B6=D0=BD=D0=BE.\n\n=D0=9F=
=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C?"
=20
 #: lib/branch_delete.tcl:141
 #, tcl-format
 msgid ""
 "Failed to delete branches:\n"
 "%s"
-msgstr ""
-"=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D1=83=D0=B4=D0=
=B0=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=B2=D0=B8:\n"
-"%s"
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D1=83=
=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=BA=D0=B8:\n%=
s"
=20
 #: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
 msgid "Rename Branch"
-msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B8=D0=BC=D0=B5=D0=BD=D0=BE=D0=B2=D0=
=B0=D0=BD=D0=B8=D0=B5 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
+msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B8=D0=BC=D0=B5=D0=BD=D0=BE=D0=B2=D0=
=B0=D0=BD=D0=B8=D0=B5 =D0=B2=D0=B5=D1=82=D0=BA=D0=B8"
=20
 #: lib/branch_rename.tcl:26
 msgid "Rename"
@@ -833,7 +808,7 @@ msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B8=D0=BC=D0=B5=D0=
=BD=D0=BE=D0=B2=D0=B0=D1=82=D1=8C"
=20
 #: lib/branch_rename.tcl:36
 msgid "Branch:"
-msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C:"
+msgstr "=D0=92=D0=B5=D1=82=D0=BA=D0=B0:"
=20
 #: lib/branch_rename.tcl:39
 msgid "New Name:"
@@ -841,21 +816,21 @@ msgstr "=D0=9D=D0=BE=D0=B2=D0=BE=D0=B5 =D0=BD=D0=B0=
=D0=B7=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5:"
=20
 #: lib/branch_rename.tcl:75
 msgid "Please select a branch to rename."
-msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B8=D1=82=D0=B5 =D0=B2=D0=B5=D1=82=D0=
=B2=D1=8C =D0=B4=D0=BB=D1=8F =D0=BF=D0=B5=D1=80=D0=B5=D0=B8=D0=BC=D0=B5=
=D0=BD=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F."
+msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B8=D1=82=D0=B5 =D0=B2=D0=B5=D1=82=D0=
=BA=D1=83 =D0=B4=D0=BB=D1=8F =D0=BF=D0=B5=D1=80=D0=B5=D0=B8=D0=BC=D0=B5=
=D0=BD=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F."
=20
 #: lib/branch_rename.tcl:96 lib/checkout_op.tcl:202
 #, tcl-format
 msgid "Branch '%s' already exists."
-msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D1=83=D0=B6=D0=B5 =D1=81=D1=
=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
+msgstr "=D0=92=D0=B5=D1=82=D0=BA=D0=B0 =C2=AB%s=C2=BB =D1=83=D0=B6=D0=B5=
 =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
=20
 #: lib/branch_rename.tcl:117
 #, tcl-format
 msgid "Failed to rename '%s'."
-msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=B5=D1=80=D0=B5=D0=B8=D0=BC=D0=B5=D0=BD=D0=BE=D0=B2=D0=B0=D1=82=D1=8C=
 '%s'. "
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=B5=D1=80=D0=B5=D0=B8=D0=BC=D0=B5=D0=BD=D0=BE=D0=B2=D0=B0=D1=82=D1=8C=
 =C2=AB%s=C2=BB. "
=20
 #: lib/browser.tcl:17
 msgid "Starting..."
-msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D0=BA..."
+msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D0=BA=E2=80=A6"
=20
 #: lib/browser.tcl:26
 msgid "File Browser"
@@ -864,7 +839,7 @@ msgstr "=D0=9F=D1=80=D0=BE=D1=81=D0=BC=D0=BE=D1=82=D1=
=80 =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B0 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=
=D0=B2"
 #: lib/browser.tcl:126 lib/browser.tcl:143
 #, tcl-format
 msgid "Loading %s..."
-msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 %s..."
+msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 %s=E2=80=A6"
=20
 #: lib/browser.tcl:187
 msgid "[Up To Parent]"
@@ -872,7 +847,7 @@ msgstr "[=D0=9D=D0=B0 =D1=83=D1=80=D0=BE=D0=B2=D0=B5=
=D0=BD=D1=8C =D0=B2=D1=8B=D1=88=D0=B5]"
=20
 #: lib/browser.tcl:267 lib/browser.tcl:273
 msgid "Browse Branch Files"
-msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8B =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8B =D0=B2=D0=B5=D1=82=D0=BA=D0=B8"
=20
 #: lib/browser.tcl:278 lib/choose_repository.tcl:398
 #: lib/choose_repository.tcl:486 lib/choose_repository.tcl:497
@@ -883,7 +858,7 @@ msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=
=8C"
 #: lib/checkout_op.tcl:85
 #, tcl-format
 msgid "Fetching %s from %s"
-msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 %s =D0=B8=
=D0=B7 %s "
+msgstr "=D0=98=D0=B7=D0=B2=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 %=
s =D0=B8=D0=B7 %s "
=20
 #: lib/checkout_op.tcl:133
 #, tcl-format
@@ -898,12 +873,12 @@ msgstr "=D0=97=D0=B0=D0=BA=D1=80=D1=8B=D1=82=D1=8C=
"
 #: lib/checkout_op.tcl:175
 #, tcl-format
 msgid "Branch '%s' does not exist."
-msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D0=BD=D0=B5 =D1=81=D1=83=D1=
=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 "
+msgstr "=D0=92=D0=B5=D1=82=D0=BA=D0=B0 =C2=AB%s=C2=BB =D0=BD=D0=B5 =D1=
=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
=20
 #: lib/checkout_op.tcl:194
 #, tcl-format
 msgid "Failed to configure simplified git-pull for '%s'."
-msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D1=81=D0=BE=D0=B7=D0=B4=D0=
=B0=D0=BD=D0=B8=D1=8F =D1=83=D0=BF=D1=80=D0=BE=D1=89=D1=91=D0=BD=D0=BD=D0=
=BE=D0=B9 =D0=BA=D0=BE=D0=BD=D1=84=D0=B8=D0=B3=D1=83=D1=80=D0=B0=D1=86=D0=
=B8=D0=B8 git pull =D0=B4=D0=BB=D1=8F '%s'."
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D1=81=D0=BE=D0=B7=D0=B4=D0=
=B0=D0=BD=D0=B8=D1=8F =D1=83=D0=BF=D1=80=D0=BE=D1=89=D1=91=D0=BD=D0=BD=D0=
=BE=D0=B9 =D0=BA=D0=BE=D0=BD=D1=84=D0=B8=D0=B3=D1=83=D1=80=D0=B0=D1=86=D0=
=B8=D0=B8 git pull =D0=B4=D0=BB=D1=8F =C2=AB%s=C2=BB."
=20
 #: lib/checkout_op.tcl:229
 #, tcl-format
@@ -912,21 +887,17 @@ msgid ""
 "\n"
 "It cannot fast-forward to %s.\n"
 "A merge is required."
-msgstr ""
-"=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D1=83=D0=B6=D0=B5 =D1=81=D1=83=D1=
=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82.\n"
-"\n"
-"=D0=9E=D0=BD=D0=B0 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82 =D0=B1=
=D1=8B=D1=82=D1=8C =D0=BF=D1=80=D0=BE=D0=BA=D1=80=D1=83=D1=87=D0=B5=D0=BD=
=D0=B0(fast-forward) =D0=BA %s.\n"
-"=D0=A2=D1=80=D0=B5=D0=B1=D1=83=D0=B5=D1=82=D1=81=D1=8F =D1=81=D0=BB=D0=
=B8=D1=8F=D0=BD=D0=B8=D0=B5."
+msgstr "=D0=92=D0=B5=D1=82=D0=BA=D0=B0 =C2=AB%s=C2=BB =D1=83=D0=B6=D0=B5=
 =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82.\n\n=D0=9E=
=D0=BD=D0=B0 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82 =D0=B1=D1=8B=D1=
=82=D1=8C =D0=BF=D0=B5=D1=80=D0=B5=D0=BC=D0=BE=D1=82=D0=B0=D0=BD=D0=B0 =
=D0=B2=D0=BF=D0=B5=D1=80=D0=B5=D0=B4 =D0=BA %s.\n=D0=A2=D1=80=D0=B5=D0=B1=
=D1=83=D0=B5=D1=82=D1=81=D1=8F =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5=
=2E"
=20
 #: lib/checkout_op.tcl:243
 #, tcl-format
 msgid "Merge strategy '%s' not supported."
-msgstr "=D0=9D=D0=B5=D0=B8=D0=B7=D0=B2=D0=B5=D1=81=D1=82=D0=BD=D0=B0=D1=
=8F =D1=81=D1=82=D1=80=D0=B0=D1=82=D0=B5=D0=B3=D0=B8=D1=8F =D1=81=D0=BB=
=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F: '%s'."
+msgstr "=D0=9D=D0=B5=D0=B8=D0=B7=D0=B2=D0=B5=D1=81=D1=82=D0=BD=D0=B0=D1=
=8F =D1=81=D1=82=D1=80=D0=B0=D1=82=D0=B5=D0=B3=D0=B8=D1=8F =D1=81=D0=BB=
=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F =C2=AB%s=C2=BB."
=20
 #: lib/checkout_op.tcl:262
 #, tcl-format
 msgid "Failed to update '%s'."
-msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BE=
=D0=B1=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C '%s'."
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BE=
=D0=B1=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =C2=AB%s=C2=BB."
=20
 #: lib/checkout_op.tcl:274
 msgid "Staging area (index) is already locked."
@@ -936,22 +907,15 @@ msgstr "=D0=A0=D0=B0=D0=B1=D0=BE=D1=87=D0=B0=D1=8F=
 =D0=BE=D0=B1=D0=BB=D0=B0=D1=81=D1=82=D1=8C =D0=B7=D0=B0=D0=B1=D0=BB=D0=
=BE=D0=BA=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B0 =D0=B4=D1=80=D1=83=D0=
=B3=D0=B8=D0=BC =D0=BF
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
-"Another Git program has modified this repository since the last scan.=
  A "
-"rescan must be performed before the current branch can be changed.\n"
+"Another Git program has modified this repository since the last scan.=
  A rescan must be performed before the current branch can be changed.\=
n"
 "\n"
 "The rescan will be automatically started now.\n"
-msgstr ""
-"=D0=9F=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B5 =D0=BF=D1=80=D0=
=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D1=8F =D0=BD=D0=B5 =D1=81=D0=BE=D0=BE=D1=82=D0=B2=
=D0=B5=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 =D1=82=D0=B5=D0=BA=D1=83=
=D1=89=D0=B5=D0=BC=D1=83.\n"
-"\n"
-"=D0=A1 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=BF=D0=BE=D1=81=D0=
=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B9 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=
=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 =D0=B1=D1=8B=D0=BB =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD =D0=B4=
=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=
=D0=BC=D0=BE=D0=B9 Git. "
-"=D0=9D=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=BE =D0=BF=D0=
=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9, =D0=BF=D1=80=D0=B5=D0=B6=
=D0=B4=D0=B5 =D1=87=D0=B5=D0=BC =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D1=8F=D1=
=82=D1=8C =D1=82=D0=B5=D0=BA=D1=83=D1=89=D1=83=D1=8E =D0=B2=D0=B5=D1=82=
=D0=B2=D1=8C.\n"
-"\n"
-"=D0=AD=D1=82=D0=BE =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=B4=D0=B5=D0=
=BB=D0=B0=D0=BD=D0=BE =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B0=D0=B2=
=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8.\n"
+msgstr "=D0=9F=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B5 =D0=BF=D1=
=80=D0=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=
=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=
=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D0=BD=D0=B5 =D1=81=D0=BE=D0=BE=D1=82=
=D0=B2=D0=B5=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 =D1=82=D0=B5=D0=BA=
=D1=83=D1=89=D0=B5=D0=BC=D1=83.\n\n=D0=A1 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=
=D1=82=D0=B0 =D0=BF=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B9 =D0=
=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=
=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9 =D0=B1=D1=8B=D0=BB =D0=B8=D0=B7=
=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD =D0=B4=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =D0=
=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9 Git. =D0=9D=D0=
=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=BE =D0=BF=D0=B5=D1=80=D0=
=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=
=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9, =D0=BF=D1=80=D0=B5=D0=B6=D0=B4=D0=B5=
 =D1=87=D0=B5=D0=BC =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B0=D1=8F =D0=B2=D0=
=B5=D1=82=D0=BA=D0=B0 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82 =D0=B1=D1=8B=D1=82=
=D1=8C =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B0.\n\n=D0=AD=D1=82=
=D0=BE =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=B4=D0=B5=D0=BB=D0=B0=D0=
=BD=D0=BE =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B0=D0=B2=D1=82=D0=BE=
=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8.\n"
=20
 #: lib/checkout_op.tcl:345
 #, tcl-format
 msgid "Updating working directory to '%s'..."
-msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D1=
=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=B3=D0=BE =D0=BA=D0=B0=D1=82=D0=B0=D0=
=BB=D0=BE=D0=B3=D0=B0 =D0=B8=D0=B7 '%s'..."
+msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D1=
=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=B3=D0=BE =D0=BA=D0=B0=D1=82=D0=B0=D0=
=BB=D0=BE=D0=B3=D0=B0 =D0=B8=D0=B7 =C2=AB%s=C2=BB=E2=80=A6"
=20
 #: lib/checkout_op.tcl:346
 msgid "files checked out"
@@ -960,7 +924,7 @@ msgstr "=D1=84=D0=B0=D0=B9=D0=BB=D1=8B =D0=B8=D0=B7=
=D0=B2=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D1=8B"
 #: lib/checkout_op.tcl:376
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
-msgstr "=D0=9F=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D0=BD =D0=BF=D0=B5=D1=80=D0=
=B5=D1=85=D0=BE=D0=B4 =D0=BD=D0=B0 '%s' (=D1=82=D1=80=D0=B5=D0=B1=D1=83=
=D0=B5=D1=82=D1=81=D1=8F =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5 =D1=
=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B0=D0=BD=D0=B8=D1=8F =D1=84=D0=B0=D0=
=B9=D0=BB=D0=BE=D0=B2)"
+msgstr "=D0=9F=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D0=BD =D0=BF=D0=B5=D1=80=D0=
=B5=D1=85=D0=BE=D0=B4 =D0=BD=D0=B0 =C2=AB%s=C2=BB (=D1=82=D1=80=D0=B5=D0=
=B1=D1=83=D0=B5=D1=82=D1=81=D1=8F =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=
=B5 =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D0=BC=D0=BE=D0=B3=D0=BE =
=D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2)"
=20
 #: lib/checkout_op.tcl:377
 msgid "File level merge required."
@@ -969,38 +933,33 @@ msgstr "=D0=A2=D1=80=D0=B5=D0=B1=D1=83=D0=B5=D1=82=
=D1=81=D1=8F =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5 =D1=81=D0=BE=D0=
=B4=D0=B5=D1=80=D0=B6=D0=B0=D0=BD=D0=B8=D1=8F =D1=84=D0=B0=D0=B9=D0=BB=D0=
=BE=D0=B2."
 #: lib/checkout_op.tcl:381
 #, tcl-format
 msgid "Staying on branch '%s'."
-msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D0=BE=D1=81=D1=82=D0=B0=D0=
=B5=D1=82=D1=81=D1=8F =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B9."
+msgstr "=D0=92=D0=B5=D1=82=D0=BA=D0=B0 =C2=AB%s=C2=BB =D0=BE=D1=81=D1=82=
=D0=B0=D1=91=D1=82=D1=81=D1=8F =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B9=
=2E"
=20
 #: lib/checkout_op.tcl:452
 msgid ""
 "You are no longer on a local branch.\n"
 "\n"
-"If you wanted to be on a branch, create one now starting from 'This D=
etached "
-"Checkout'."
-msgstr ""
-"=D0=92=D1=8B =D0=BD=D0=B0=D1=85=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D1=81=D1=
=8C =D0=BD=D0=B5 =D0=B2 =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=
=D0=B9 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8.\n"
-"\n"
-"=D0=95=D1=81=D0=BB=D0=B8 =D0=B2=D1=8B =D1=85=D0=BE=D1=82=D0=B8=D1=82=D0=
=B5 =D1=81=D0=BD=D0=BE=D0=B2=D0=B0 =D0=B2=D0=B5=D1=80=D0=BD=D1=83=D1=82=
=D1=8C=D1=81=D1=8F =D0=BA =D0=BA=D0=B0=D0=BA=D0=BE=D0=B9-=D0=BD=D0=B8=D0=
=B1=D1=83=D0=B4=D1=8C =D0=B2=D0=B5=D1=82=D0=B2=D0=B8, =D1=81=D0=BE=D0=B7=
=D0=B4=D0=B0=D0=B9=D1=82=D0=B5 =D0=B5=D0=B5 =D1=81=D0=B5=D0=B9=D1=87=D0=
=B0=D1=81, "
-"=D0=BD=D0=B0=D1=87=D0=B8=D0=BD=D0=B0=D1=8F =D1=81 '=D0=A2=D0=B5=D0=BA=
=D1=83=D1=89=D0=B5=D0=B3=D0=BE =D0=BE=D1=82=D1=81=D0=BE=D0=B5=D0=B4=D0=B8=
=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=
=D1=8F=D0=BD=D0=B8=D1=8F'."
+"If you wanted to be on a branch, create one now starting from 'This D=
etached Checkout'."
+msgstr "=D0=92=D1=8B =D0=B1=D0=BE=D0=BB=D0=B5=D0=B5 =D0=BD=D0=B5 =D0=BD=
=D0=B0=D1=85=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D1=81=D1=8C =D0=BD=D0=B0 =D0=
=BB=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B9 =D0=B2=D0=B5=D1=82=D0=
=BA=D0=B5.\n\n=D0=95=D1=81=D0=BB=D0=B8 =D0=B2=D1=8B =D1=85=D0=BE=D1=82=D0=
=B8=D1=82=D0=B5 =D1=81=D0=BD=D0=BE=D0=B2=D0=B0 =D0=B2=D0=B5=D1=80=D0=BD=
=D1=83=D1=82=D1=8C=D1=81=D1=8F =D0=BA =D0=BA=D0=B0=D0=BA=D0=BE=D0=B9-=D0=
=BD=D0=B8=D0=B1=D1=83=D0=B4=D1=8C =D0=B2=D0=B5=D1=82=D0=BA=D0=B5, =D1=81=
=D0=BE=D0=B7=D0=B4=D0=B0=D0=B9=D1=82=D0=B5 =D0=B5=D1=91 =D1=81=D0=B5=D0=
=B9=D1=87=D0=B0=D1=81, =D0=BD=D0=B0=D1=87=D0=B8=D0=BD=D0=B0=D1=8F =D1=81=
 =C2=AB=D0=A2=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B3=D0=BE =D0=BE=D1=82=D1=
=81=D0=BE=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D1=
=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F=C2=BB."
=20
 #: lib/checkout_op.tcl:503 lib/checkout_op.tcl:507
 #, tcl-format
 msgid "Checked out '%s'."
-msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D1=81=D0=B4=D0=B5=D0=BB=D0=
=B0=D0=BD=D0=B0 =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B9."
+msgstr "=D0=92=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D0=B5=D0=BD =D0=BF=D0=B5=D1=
=80=D0=B5=D1=85=D0=BE=D0=B4 =D0=BD=D0=B0 =C2=AB%s=C2=BB."
=20
 #: lib/checkout_op.tcl:535
 #, tcl-format
 msgid "Resetting '%s' to '%s' will lose the following commits:"
-msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81 '%s' =D0=B2 '%s' =D0=BF=D1=80=D0=
=B8=D0=B2=D0=B5=D0=B4=D0=B5=D1=82 =D0=BA =D0=BF=D0=BE=D1=82=D0=B5=D1=80=
=D0=B5 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B8=D1=85 =D1=81=D0=
=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D1=8B=D1=85 =D1=81=D0=BE=D1=
=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9: "
+msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81 =C2=AB%s=C2=BB  =D0=BD=D0=B0 =C2=
=AB%s=C2=BB =D0=BF=D1=80=D0=B8=D0=B2=D0=B5=D0=B4=D0=B5=D1=82 =D0=BA =D0=
=BF=D0=BE=D1=82=D0=B5=D1=80=D0=B5 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=
=89=D0=B8=D1=85 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=BE=D0=B2:"
=20
 #: lib/checkout_op.tcl:557
 msgid "Recovering lost commits may not be easy."
-msgstr "=D0=92=D0=BE=D1=81=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=
=82=D1=8C =D0=BF=D0=BE=D1=82=D0=B5=D1=80=D1=8F=D0=BD=D0=BD=D1=8B=D0=B5 =
=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D1=81=
=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F =D0=B1=D1=83=D0=B4=D0=B5=
=D1=82 =D1=81=D0=BB=D0=BE=D0=B6=D0=BD=D0=BE."
+msgstr "=D0=92=D0=BE=D1=81=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=
=82=D1=8C =D0=BF=D0=BE=D1=82=D0=B5=D1=80=D1=8F=D0=BD=D0=BD=D1=8B=D0=B5 =
=D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D1=8B =D0=B1=D1=83=D0=B4=D0=B5=D1=82=
 =D1=81=D0=BB=D0=BE=D0=B6=D0=BD=D0=BE."
=20
 #: lib/checkout_op.tcl:562
 #, tcl-format
 msgid "Reset '%s'?"
-msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81=D0=B8=D1=82=D1=8C '%s'?"
+msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81=D0=B8=D1=82=D1=8C =C2=AB%s=C2=BB=
?"
=20
 #: lib/checkout_op.tcl:567 lib/merge.tcl:164 lib/tools_dlg.tcl:343
 msgid "Visualize"
@@ -1011,17 +970,10 @@ msgstr "=D0=9D=D0=B0=D0=B3=D0=BB=D1=8F=D0=B4=D0=BD=
=D0=BE"
 msgid ""
 "Failed to set current branch.\n"
 "\n"
-"This working directory is only partially switched.  We successfully u=
pdated "
-"your files, but failed to update an internal Git file.\n"
+"This working directory is only partially switched.  We successfully u=
pdated your files, but failed to update an internal Git file.\n"
 "\n"
 "This should not have occurred.  %s will now close and give up."
-msgstr ""
-"=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D1=83=D1=81=D1=
=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D1=82=D0=B5=D0=BA=D1=83=D1=
=89=D1=83=D1=8E =D0=B2=D0=B5=D1=82=D0=B2=D1=8C.\n"
-"\n"
-"=D0=92=D0=B0=D1=88 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=D0=
=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 =D0=BE=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=
=B5=D0=BD =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D1=87=D0=B0=D1=81=D1=82=
=D0=B8=D1=87=D0=BD=D0=BE. =D0=91=D1=8B=D0=BB=D0=B8 =D0=BE=D0=B1=D0=BD=D0=
=BE=D0=B2=D0=BB=D0=B5=D0=BD=D1=8B =D0=B2=D1=81=D0=B5 =D1=84=D0=B0=D0=B9=
=D0=BB=D1=8B =D0=BA=D1=80=D0=BE=D0=BC=D0=B5 "
-"=D1=81=D0=BB=D1=83=D0=B6=D0=B5=D0=B1=D0=BD=D1=8B=D1=85 =D1=84=D0=B0=D0=
=B9=D0=BB=D0=BE=D0=B2 Git. \n"
-"\n"
-"=D0=AD=D1=82=D0=BE=D0=B3=D0=BE =D0=BD=D0=B5 =D0=B4=D0=BE=D0=BB=D0=B6=D0=
=BD=D0=BE =D0=B1=D1=8B=D0=BB=D0=BE =D0=BF=D1=80=D0=BE=D0=B8=D0=B7=D0=BE=
=D0=B9=D1=82=D0=B8. %s =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B0=D0=B5=
=D1=82=D1=81=D1=8F."
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D1=83=
=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D1=82=D0=B5=D0=BA=
=D1=83=D1=89=D1=83=D1=8E =D0=B2=D0=B5=D1=82=D0=BA=D1=83.\n\n=D0=92=D0=B0=
=D1=88 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=
=B0=D0=BB=D0=BE=D0=B3 =D0=BE=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D1=91=D0=BD =
=D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D1=87=D0=B0=D1=81=D1=82=D0=B8=D1=87=
=D0=BD=D0=BE. =D0=91=D1=8B=D0=BB=D0=B8 =D0=BE=D0=B1=D0=BD=D0=BE=D0=B2=D0=
=BB=D0=B5=D0=BD=D1=8B =D0=B2=D1=81=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D1=8B=
 =D0=BA=D1=80=D0=BE=D0=BC=D0=B5 =D1=81=D0=BB=D1=83=D0=B6=D0=B5=D0=B1=D0=
=BD=D1=8B=D1=85 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2 Git. \n\n=D0=AD=D1=
=82=D0=BE=D0=B3=D0=BE =D0=BD=D0=B5 =D0=B4=D0=BE=D0=BB=D0=B6=D0=BD=D0=BE=
 =D0=B1=D1=8B=D0=BB=D0=BE =D0=BF=D1=80=D0=BE=D0=B8=D0=B7=D0=BE=D0=B9=D1=
=82=D0=B8. %s =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B0=D0=B5=D1=82=D1=
=81=D1=8F."
=20
 #: lib/choose_font.tcl:39
 msgid "Select"
@@ -1043,9 +995,7 @@ msgstr "=D0=9F=D1=80=D0=B8=D0=BC=D0=B5=D1=80 =D1=82=
=D0=B5=D0=BA=D1=81=D1=82=D0=B0"
 msgid ""
 "This is example text.\n"
 "If you like this text, it can be your font."
-msgstr ""
-"=D0=AD=D1=82=D0=BE =D0=BF=D1=80=D0=B8=D0=BC=D0=B5=D1=80 =D1=82=D0=B5=D0=
=BA=D1=81=D1=82=D0=B0.\n"
-"=D0=95=D1=81=D0=BB=D0=B8 =D0=92=D0=B0=D0=BC =D0=BD=D1=80=D0=B0=D0=B2=D0=
=B8=D1=82=D1=81=D1=8F =D1=8D=D1=82=D0=BE=D1=82 =D1=82=D0=B5=D0=BA=D1=81=
=D1=82, =D1=8D=D1=82=D0=BE =D0=BC=D0=BE=D0=B6=D0=B5=D1=82 =D0=B1=D1=8B=D1=
=82=D1=8C =D0=92=D0=B0=D1=88 =D1=88=D1=80=D0=B8=D1=84=D1=82."
+msgstr "=D0=AD=D1=82=D0=BE =D0=BF=D1=80=D0=B8=D0=BC=D0=B5=D1=80 =D1=82=
=D0=B5=D0=BA=D1=81=D1=82=D0=B0.\n=D0=95=D1=81=D0=BB=D0=B8 =D0=92=D0=B0=D0=
=BC =D0=BD=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=81=D1=8F =D1=8D=D1=82=D0=BE=
=D1=82 =D1=82=D0=B5=D0=BA=D1=81=D1=82, =D1=8D=D1=82=D0=BE =D0=BC=D0=BE=D0=
=B6=D0=B5=D1=82 =D0=B1=D1=8B=D1=82=D1=8C =D0=92=D0=B0=D1=88 =D1=88=D1=80=
=D0=B8=D1=84=D1=82."
=20
 #: lib/choose_repository.tcl:28
 msgid "Git Gui"
@@ -1057,7 +1007,7 @@ msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C=
 =D0=BD=D0=BE=D0=B2=D1=8B=D0=B9 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D0=B9"
=20
 #: lib/choose_repository.tcl:93
 msgid "New..."
-msgstr "=D0=9D=D0=BE=D0=B2=D1=8B=D0=B9..."
+msgstr "=D0=9D=D0=BE=D0=B2=D1=8B=D0=B9=E2=80=A6"
=20
 #: lib/choose_repository.tcl:100 lib/choose_repository.tcl:471
 msgid "Clone Existing Repository"
@@ -1065,7 +1015,7 @@ msgstr "=D0=A1=D0=BA=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=
=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=
=D1=83=D1=8E=D1=89=D0=B8=D0=B9 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=
=D0=BE=D1=80=D0=B8=D0=B9
=20
 #: lib/choose_repository.tcl:106
 msgid "Clone..."
-msgstr "=D0=A1=D0=BA=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C..."
+msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=
=8C=E2=80=A6"
=20
 #: lib/choose_repository.tcl:113 lib/choose_repository.tcl:1016
 msgid "Open Existing Repository"
@@ -1073,7 +1023,7 @@ msgstr "=D0=92=D1=8B=D0=B1=D1=80=D0=B0=D1=82=D1=8C=
 =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=89=D0=B8=D0=B9=
 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9"
=20
 #: lib/choose_repository.tcl:119
 msgid "Open..."
-msgstr "=D0=9E=D1=82=D0=BA=D1=80=D1=8B=D1=82=D1=8C..."
+msgstr "=D0=9E=D1=82=D0=BA=D1=80=D1=8B=D1=82=D1=8C=E2=80=A6"
=20
 #: lib/choose_repository.tcl:132
 msgid "Recent Repositories"
@@ -1126,7 +1076,7 @@ msgstr "=D0=A2=D0=B8=D0=BF =D0=BA=D0=BB=D0=BE=D0=BD=
=D0=B0:"
=20
 #: lib/choose_repository.tcl:508
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
-msgstr "=D0=A1=D1=82=D0=B0=D0=BD=D0=B4=D0=B0=D1=80=D1=82=D0=BD=D1=8B=D0=
=B9 (=D0=91=D1=8B=D1=81=D1=82=D1=80=D1=8B=D0=B9, =D0=BF=D0=BE=D0=BB=D1=83=
=D0=B8=D0=B7=D0=B1=D1=8B=D1=82=D0=BE=D1=87=D0=BD=D1=8B=D0=B9, \"=D0=B6=D0=
=B5=D1=81=D1=82=D0=BA=D0=B8=D0=B5\" =D1=81=D1=81=D1=8B=D0=BB=D0=BA=D0=B8=
)"
+msgstr "=D0=A1=D1=82=D0=B0=D0=BD=D0=B4=D0=B0=D1=80=D1=82=D0=BD=D1=8B=D0=
=B9 (=D0=91=D1=8B=D1=81=D1=82=D1=80=D1=8B=D0=B9, =D0=BF=D0=BE=D0=BB=D1=83=
=D0=B8=D0=B7=D0=B1=D1=8B=D1=82=D0=BE=D1=87=D0=BD=D1=8B=D0=B9, =C2=AB=D0=
=B6=D0=B5=D1=81=D1=82=D0=BA=D0=B8=D0=B5=C2=BB =D1=81=D1=81=D1=8B=D0=BB=D0=
=BA=D0=B8)"
=20
 #: lib/choose_repository.tcl:514
 msgid "Full Copy (Slower, Redundant Backup)"
@@ -1166,7 +1116,7 @@ msgstr "=D0=A1=D1=87=D0=B8=D1=82=D0=B0=D1=8E =D0=BE=
=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D1=8B"
=20
 #: lib/choose_repository.tcl:641
 msgid "buckets"
-msgstr ""
+msgstr "=D0=B1=D0=BB=D0=BE=D0=BA=D0=B8"
=20
 #: lib/choose_repository.tcl:665
 #, tcl-format
@@ -1181,11 +1131,11 @@ msgstr "=D0=9D=D0=B5=D1=87=D0=B5=D0=B3=D0=BE =D0=
=BA=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D1=81 =
%s."
 #: lib/choose_repository.tcl:703 lib/choose_repository.tcl:917
 #: lib/choose_repository.tcl:929
 msgid "The 'master' branch has not been initialized."
-msgstr "=D0=9D=D0=B5 =D0=B8=D0=BD=D0=B8=D1=86=D0=B8=D0=B0=D0=BB=D0=B8=D0=
=B7=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B0 =D0=B2=D0=B5=D1=82=D0=B2=D1=
=8C 'master'."
+msgstr "=D0=9D=D0=B5 =D0=B8=D0=BD=D0=B8=D1=86=D0=B8=D0=B0=D0=BB=D0=B8=D0=
=B7=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B0 =D0=B2=D0=B5=D1=82=D0=B2=D1=
=8C =C2=ABmaster=C2=BB."
=20
 #: lib/choose_repository.tcl:716
 msgid "Hardlinks are unavailable.  Falling back to copying."
-msgstr "\"=D0=96=D0=B5=D1=81=D1=82=D0=BA=D0=B8=D0=B5 =D1=81=D1=81=D1=8B=
=D0=BB=D0=BA=D0=B8\" =D0=BD=D0=B5=D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=D0=
=BD=D1=8B. =D0=91=D1=83=D0=B4=D0=B5=D1=82 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=
=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D0=BD=D0=BE =D0=BA=D0=BE=D0=BF=D0=B8=D1=80=
=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5."
+msgstr "=C2=AB=D0=96=D0=B5=D1=81=D1=82=D0=BA=D0=B8=D0=B5 =D1=81=D1=81=D1=
=8B=D0=BB=D0=BA=D0=B8=C2=BB =D0=BD=D0=B5=D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=
=BF=D0=BD=D1=8B. =D0=91=D1=83=D0=B4=D0=B5=D1=82 =D0=B8=D1=81=D0=BF=D0=BE=
=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D0=BD=D0=BE =D0=BA=D0=BE=D0=BF=D0=B8=
=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5."
=20
 #: lib/choose_repository.tcl:728
 #, tcl-format
@@ -1216,16 +1166,15 @@ msgstr "=D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D1=
=8B"
 #: lib/choose_repository.tcl:803
 #, tcl-format
 msgid "Unable to hardlink object: %s"
-msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 \"=D0=B6=D0=B5=D1=81=D1=82=
=D0=BA=D0=BE =D1=81=D0=B2=D1=8F=D0=B7=D0=B0=D1=82=D1=8C\" =D0=BE=D0=B1=D1=
=8A=D0=B5=D0=BA=D1=82: %s"
+msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=81=D0=BE=D0=B7=D0=B4=
=D0=B0=D1=82=D1=8C =C2=AB=D0=B6=D0=B5=D1=81=D1=82=D0=BA=D1=83=D1=8E =D1=
=81=D1=81=D1=8B=D0=BB=D0=BA=D1=83=C2=BB =D0=BD=D0=B0 =D0=BE=D0=B1=D1=8A=
=D0=B5=D0=BA=D1=82: %s"
=20
 #: lib/choose_repository.tcl:858
 msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
-msgstr ""
-"=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=
=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=B8 =D0=BE=D0=B1=D1=8A=
=D0=B5=D0=BA=D1=82=D1=8B. =D0=94=D0=BE=D0=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=
=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=
=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BD=D1=81=D0=BE=
=D0=BB=D0=B8."
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=B8=
=D0=B7=D0=B2=D0=BB=D0=B5=D1=87=D1=8C =D0=B2=D0=B5=D1=82=D0=BA=D0=B8 =D0=
=B8 =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D1=8B. =D0=94=D0=BE=D0=BF=D0=BE=
=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=B8=D0=BD=
=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =D0=BA=D0=
=BE=D0=BD=D1=81=D0=BE=D0=BB=D0=B8."
=20
 #: lib/choose_repository.tcl:869
 msgid "Cannot fetch tags.  See console output for details."
-msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BF=D0=BE=D0=BB=D1=83=
=D1=87=D0=B8=D1=82=D1=8C =D0=BC=D0=B5=D1=82=D0=BA=D0=B8. =D0=94=D0=BE=D0=
=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=
=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =
=D0=BA=D0=BE=D0=BD=D1=81=D0=BE=D0=BB=D0=B8."
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=B8=
=D0=B7=D0=B2=D0=BB=D0=B5=D1=87=D1=8C =D0=BC=D0=B5=D1=82=D0=BA=D0=B8. =D0=
=94=D0=BE=D0=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=
=B0=D1=8F =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =
=D0=BD=D0=B0 =D0=BA=D0=BE=D0=BD=D1=81=D0=BE=D0=BB=D0=B8."
=20
 #: lib/choose_repository.tcl:893
 msgid "Cannot determine HEAD.  See console output for details."
@@ -1242,12 +1191,12 @@ msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=
=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=
=D0=BE=D1=81=D1=8C."
=20
 #: lib/choose_repository.tcl:915
 msgid "No default branch obtained."
-msgstr "=D0=9D=D0=B5 =D0=B1=D1=8B=D0=BB=D0=BE =D0=BF=D0=BE=D0=BB=D1=83=
=D1=87=D0=B5=D0=BD=D0=BE =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=BF=D0=BE =D1=
=83=D0=BC=D0=BE=D0=BB=D1=87=D0=B0=D0=BD=D0=B8=D1=8E."
+msgstr "=D0=92=D0=B5=D1=82=D0=BA=D0=B0 =D0=BF=D0=BE =D1=83=D0=BC=D0=BE=
=D0=BB=D1=87=D0=B0=D0=BD=D0=B8=D1=8E =D0=BD=D0=B5 =D0=B1=D1=8B=D0=BB=D0=
=B0 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B0."
=20
 #: lib/choose_repository.tcl:926
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
-msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=80=D0=B0=D1=81=D0=BF=
=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D1=8C %s =D0=BA=D0=B0=D0=BA =D1=81=D0=BE=
=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5."
+msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=80=D0=B0=D1=81=D0=BF=
=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D1=8C %s =D0=BA=D0=B0=D0=BA =D0=BA=D0=BE=
=D0=BC=D0=BC=D0=B8=D1=82."
=20
 #: lib/choose_repository.tcl:938
 msgid "Creating working directory"
@@ -1285,11 +1234,11 @@ msgstr "=D0=92=D1=8B=D1=80=D0=B0=D0=B6=D0=B5=D0=
=BD=D0=B8=D0=B5 =D0=B4=D0=BB=D1=8F =D0=BE=D0=BF=D1=80=D0=B5=D0=B4=D0=B5=
=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D0=B8:"
=20
 #: lib/choose_rev.tcl:74
 msgid "Local Branch"
-msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=B2=D0=
=B5=D1=82=D0=B2=D1=8C:"
+msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=B2=D0=
=B5=D1=82=D0=BA=D0=B0:"
=20
 #: lib/choose_rev.tcl:79
 msgid "Tracking Branch"
-msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C =D1=81=D0=BB=D0=B5=D0=B6=D0=B5=D0=
=BD=D0=B8=D1=8F"
+msgstr "=D0=9E=D1=82=D1=81=D0=BB=D0=B5=D0=B6=D0=B8=D0=B2=D0=B0=D0=B5=D0=
=BC=D0=B0=D1=8F =D0=B2=D0=B5=D1=82=D0=BA=D0=B0"
=20
 #: lib/choose_rev.tcl:84 lib/choose_rev.tcl:538
 msgid "Tag"
@@ -1320,29 +1269,19 @@ msgstr "=D0=A1=D1=81=D1=8B=D0=BB=D0=BA=D0=B0"
 msgid ""
 "There is nothing to amend.\n"
 "\n"
-"You are about to create the initial commit.  There is no commit befor=
e this "
-"to amend.\n"
-msgstr ""
-"=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 =D1=
=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=B4=D0=BB=D1=8F =
=D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F.\n"
-"\n"
-"=D0=92=D1=8B =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D0=B5=D1=82=D0=B5 =D0=BF=D0=
=B5=D1=80=D0=B2=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=
=B8=D0=B5 =D0=B2 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=
=D0=B8=D0=B8, =D0=B7=D0=B4=D0=B5=D1=81=D1=8C =D0=B5=D1=89=D0=B5 =D0=BD=D0=
=B5=D1=87=D0=B5=D0=B3=D0=BE =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D1=
=8F=D1=82=D1=8C.\n"
+"You are about to create the initial commit.  There is no commit befor=
e this to amend.\n"
+msgstr "=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=
=82 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D1=8B =D0=B4=D0=BB=D1=8F =D0=B8=
=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F.\n\n=D0=92=
=D1=8B =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D0=B5=D1=82=D0=B5 =D0=BD=D0=B0=D1=
=87=D0=B0=D0=BB=D1=8C=D0=BD=D1=8B=D0=B9 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=
=82, =D0=B7=D0=B4=D0=B5=D1=81=D1=8C =D0=B5=D1=89=D0=B5 =D0=BD=D0=B5=D1=87=
=D0=B5=D0=B3=D0=BE =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D1=8F=D1=82=
=D1=8C.\n"
=20
 #: lib/commit.tcl:18
 msgid ""
 "Cannot amend while merging.\n"
 "\n"
-"You are currently in the middle of a merge that has not been fully "
-"completed.  You cannot amend the prior commit unless you first abort =
the "
-"current merge activity.\n"
-msgstr ""
-"=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=B8=D1=
=81=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=B2=D0=BE =D0=B2=D1=80=D0=B5=D0=BC=D1=8F=
 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D1=81=D0=BB=D0=B8=D1=
=8F=D0=BD=D0=B8=D1=8F.\n"
-"\n"
-"=D0=A2=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B5 =D1=81=D0=BB=D0=B8=D1=8F=D0=
=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B5=
=D0=BD=D0=BE. =D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=
=BE =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=BF=D1=80=
=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=B5 =D1=81=D0=BE=D1=85=D1=80=
=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=B5 "
-"=D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5, =D0=BD=D0=B5 =
=D0=BF=D1=80=D0=B5=D1=80=D1=8B=D0=B2=D0=B0=D1=8F =D1=8D=D1=82=D1=83 =D0=
=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8E.\n"
+"You are currently in the middle of a merge that has not been fully co=
mpleted.  You cannot amend the prior commit unless you first abort the =
current merge activity.\n"
+msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=BA=D0=BE=D0=BC=D0=
=BC=D0=B8=D1=82 =D0=B2=D0=BE =D0=B2=D1=80=D0=B5=D0=BC=D1=8F =D1=81=D0=BB=
=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F.\n\n=D0=A2=D0=B5=D0=BA=D1=83=D1=89=D0=B5=
=D0=B5 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =D0=B7=D0=
=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=BE. =D0=9D=D0=B5=D0=B2=D0=BE=
=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=
=D0=B8=D1=82=D1=8C =D0=BF=D1=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D0=B8=D0=B9=
 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82, =D0=BD=D0=B5 =D0=BF=D1=80=D0=B5=D1=
=80=D1=8B=D0=B2=D0=B0=D1=8F =D1=8D=D1=82=D1=83 =D0=BE=D0=BF=D0=B5=D1=80=
=D0=B0=D1=86=D0=B8=D1=8E.\n"
=20
 #: lib/commit.tcl:48
 msgid "Error loading commit data for amend:"
-msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B7=
=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B5 =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=
=D1=85 =D0=B4=D0=BB=D1=8F =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=
=B5=D0=BD=D0=B8=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=
=BD=D0=BE=D0=B3=D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=
=8F:"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B7=
=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B5 =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=
=D1=85 =D0=B4=D0=BB=D1=8F =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=
=B5=D0=BD=D0=B8=D1=8F =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B0:"
=20
 #: lib/commit.tcl:75
 msgid "Unable to obtain your identity:"
@@ -1350,41 +1289,29 @@ msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=
=BE=D0=B6=D0=BD=D0=BE =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C =
=D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8E =D0=BE=D0=B1=
 =D0=B0=D0=B2=D1=82=D0=BE
=20
 #: lib/commit.tcl:80
 msgid "Invalid GIT_COMMITTER_IDENT:"
-msgstr "=D0=9D=D0=B5=D0=B2=D0=B5=D1=80=D0=BD=D1=8B=D0=B9 GIT_COMMITTER=
_IDENT:"
+msgstr "=D0=9D=D0=B5=D0=B4=D0=BE=D0=BF=D1=83=D1=81=D1=82=D0=B8=D0=BC=D1=
=8B=D0=B9 GIT_COMMITTER_IDENT:"
=20
 #: lib/commit.tcl:129
 #, tcl-format
 msgid "warning: Tcl does not support encoding '%s'."
-msgstr "=D0=BF=D1=80=D0=B5=D0=B4=D1=83=D0=BF=D1=80=D0=B5=D0=B6=D0=B4=D0=
=B5=D0=BD=D0=B8=D0=B5: Tcl =D0=BD=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=
=80=D0=B6=D0=B8=D0=B2=D0=B0=D0=B5=D1=82 =D0=BA=D0=BE=D0=B4=D0=B8=D1=80=D0=
=BE=D0=B2=D0=BA=D1=83 '%s'."
+msgstr "=D0=BF=D1=80=D0=B5=D0=B4=D1=83=D0=BF=D1=80=D0=B5=D0=B6=D0=B4=D0=
=B5=D0=BD=D0=B8=D0=B5: Tcl =D0=BD=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=
=80=D0=B6=D0=B8=D0=B2=D0=B0=D0=B5=D1=82 =D0=BA=D0=BE=D0=B4=D0=B8=D1=80=D0=
=BE=D0=B2=D0=BA=D1=83 =C2=AB%s=C2=BB."
=20
 #: lib/commit.tcl:149
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
-"Another Git program has modified this repository since the last scan.=
  A "
-"rescan must be performed before another commit can be created.\n"
+"Another Git program has modified this repository since the last scan.=
  A rescan must be performed before another commit can be created.\n"
 "\n"
 "The rescan will be automatically started now.\n"
-msgstr ""
-"=D0=9F=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B5 =D0=BF=D1=80=D0=
=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D1=8F =D0=BD=D0=B5 =D1=81=D0=BE=D0=BE=D1=82=D0=B2=
=D0=B5=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 =D1=82=D0=B5=D0=BA=D1=83=
=D1=89=D0=B5=D0=BC=D1=83.\n"
-"\n"
-"=D0=A1 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=BF=D0=BE=D1=81=D0=
=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B9 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=
=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 =D0=B1=D1=8B=D0=BB =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD =D0=B4=
=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=
=D0=BC=D0=BE=D0=B9 Git. "
-"=D0=9D=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=BE =D0=BF=D0=
=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9, =D0=BF=D1=80=D0=B5=D0=B6=
=D0=B4=D0=B5 =D1=87=D0=B5=D0=BC =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D1=8F=D1=
=82=D1=8C =D1=82=D0=B5=D0=BA=D1=83=D1=89=D1=83=D1=8E =D0=B2=D0=B5=D1=82=
=D0=B2=D1=8C. \n"
-"\n"
-"=D0=AD=D1=82=D0=BE =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=B4=D0=B5=D0=
=BB=D0=B0=D0=BD=D0=BE =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B0=D0=B2=
=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8.\n"
+msgstr "=D0=9F=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B5 =D0=BF=D1=
=80=D0=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=
=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=
=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D0=BD=D0=B5 =D1=81=D0=BE=D0=BE=D1=82=
=D0=B2=D0=B5=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 =D1=82=D0=B5=D0=BA=
=D1=83=D1=89=D0=B5=D0=BC=D1=83.\n\n=D0=A1 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=
=D1=82=D0=B0 =D0=BF=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B9 =D0=
=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=
=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9 =D0=B1=D1=8B=D0=BB =D0=B8=D0=B7=
=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD =D0=B4=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =D0=
=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9 Git. =D0=9D=D0=
=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=BE =D0=BF=D0=B5=D1=80=D0=
=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=
=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9, =D0=BF=D1=80=D0=B5=D0=B6=D0=B4=D0=B5=
 =D1=87=D0=B5=D0=BC =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D1=8F=D1=82=D1=8C =D1=
=82=D0=B5=D0=BA=D1=83=D1=89=D1=83=D1=8E =D0=B2=D0=B5=D1=82=D0=B2=D1=8C.=
 \n\n=D0=AD=D1=82=D0=BE =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=B4=D0=B5=
=D0=BB=D0=B0=D0=BD=D0=BE =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B0=D0=
=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8.\=
n"
=20
 #: lib/commit.tcl:172
 #, tcl-format
 msgid ""
 "Unmerged files cannot be committed.\n"
 "\n"
-"File %s has merge conflicts.  You must resolve them and stage the fil=
e "
-"before committing.\n"
-msgstr ""
-"=D0=9D=D0=B5=D0=BB=D1=8C=D0=B7=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=
=BD=D0=B8=D1=82=D1=8C =D1=84=D0=B0=D0=B9=D0=BB=D1=8B =D1=81 =D0=BD=D0=B5=
=D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D1=91=D0=BD=D0=BD=D0=BE=D0=B9 =D0=BE=
=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B5=D0=B9 =D1=81=D0=BB=D0=B8=D1=8F=
=D0=BD=D0=B8=D1=8F.\n"
-"\n"
-"=D0=94=D0=BB=D1=8F =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 %s =D0=B2=D0=BE=D0=B7=
=D0=BD=D0=B8=D0=BA =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82 =D1=
=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F. =D0=A0=D0=B0=D0=B7=D1=80=D0=B5=
=D1=88=D0=B8=D1=82=D0=B5 =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=
 =D0=B8 =D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D1=8C=D1=82=D0=B5 =D0=BA "
-"=D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=
=BD=D1=8B=D0=BC =D1=84=D0=B0=D0=B9=D0=BB=D0=B0=D0=BC =D0=BF=D0=B5=D1=80=
=D0=B5=D0=B4 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5=
=D0=BC.\n"
+"File %s has merge conflicts.  You must resolve them and stage the fil=
e before committing.\n"
+msgstr "=D0=9D=D0=B5=D0=BB=D1=8C=D0=B7=D1=8F =D0=B2=D1=8B=D0=BF=D0=BE=D0=
=BB=D0=BD=D0=B8=D1=82=D1=8C =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82 =D1=81=
 =D0=BD=D0=B5=D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D1=91=D0=BD=D0=BD=D0=BE=
=D0=B9 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B5=D0=B9 =D1=81=D0=
=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F.\n\n=D0=94=D0=BB=D1=8F =D1=84=D0=B0=D0=
=B9=D0=BB=D0=B0 %s =D0=B2=D0=BE=D0=B7=D0=BD=D0=B8=D0=BA =D0=BA=D0=BE=D0=
=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=
=8F. =D0=A0=D0=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B8=D1=82=D0=B5 =D0=BA=D0=BE=
=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82 =D0=B8 =D0=B4=D0=BE=D0=B1=D0=B0=D0=
=B2=D1=8C=D1=82=D0=B5 =D0=B8=D1=85 =D0=B2 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=
=D1=81 =D0=BF=D0=B5=D1=80=D0=B5=D0=B4 =D0=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=
=BD=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=
=B0.\n"
=20
 #: lib/commit.tcl:180
 #, tcl-format
@@ -1392,20 +1319,14 @@ msgid ""
 "Unknown file state %s detected.\n"
 "\n"
 "File %s cannot be committed by this program.\n"
-msgstr ""
-"=D0=9E=D0=B1=D0=BD=D0=B0=D1=80=D1=83=D0=B6=D0=B5=D0=BD=D0=BE =D0=BD=D0=
=B5=D0=B8=D0=B7=D0=B2=D0=B5=D1=81=D1=82=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=
=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =
%s.\n"
-"\n"
-"=D0=A4=D0=B0=D0=B9=D0=BB %s =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82=
 =D0=B1=D1=8B=D1=82=D1=8C =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=
=BD =D0=B4=D0=B0=D0=BD=D0=BD=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=
=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9.\n"
+msgstr "=D0=9E=D0=B1=D0=BD=D0=B0=D1=80=D1=83=D0=B6=D0=B5=D0=BD=D0=BE =D0=
=BD=D0=B5=D0=B8=D0=B7=D0=B2=D0=B5=D1=81=D1=82=D0=BD=D0=BE=D0=B5 =D1=81=D0=
=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D0=
=B0 %s.\n\n=D0=A4=D0=B0=D0=B9=D0=BB %s =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=
=B5=D1=82 =D0=B1=D1=8B=D1=82=D1=8C =D0=B7=D0=B0=D0=BA=D0=BE=D0=BC=D0=BC=
=D0=B8=D1=87=D0=B5=D0=BD =D1=8D=D1=82=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=
=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9.\n"
=20
 #: lib/commit.tcl:188
 msgid ""
 "No changes to commit.\n"
 "\n"
 "You must stage at least 1 file before you can commit.\n"
-msgstr ""
-"=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=82 =D0=
=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B4=D0=BB=D1=8F =
=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F.\n"
-"\n"
-"=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D1=8C=D1=82=D0=B5 =D1=
=85=D0=BE=D1=82=D1=8F =D0=B1=D1=8B =D0=BE=D0=B4=D0=B8=D0=BD =D1=84=D0=B0=
=D0=B9=D0=BB =D0=B4=D0=BE =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D1=
=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=
=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F.\n"
+msgstr "=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=
=82 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B4=D0=BB=
=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F.\n\=
n=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D1=8C=D1=82=D0=B5 =D0=B2 =D0=B8=D0=BD=D0=
=B4=D0=B5=D0=BA=D1=81 =D1=85=D0=BE=D1=82=D1=8F =D0=B1=D1=8B =D0=BE=D0=B4=
=D0=B8=D0=BD =D1=84=D0=B0=D0=B9=D0=BB =D0=BF=D0=B5=D1=80=D0=B5=D0=B4 =D0=
=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC =D0=BA=D0=
=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B0.\n"
=20
 #: lib/commit.tcl:203
 msgid ""
@@ -1416,34 +1337,27 @@ msgid ""
 "- First line: Describe in one sentence what you did.\n"
 "- Second line: Blank\n"
 "- Remaining lines: Describe why this change is good.\n"
-msgstr ""
-"=D0=9D=D0=B0=D0=BF=D0=B8=D1=88=D0=B8=D1=82=D0=B5 =D0=BA=D0=BE=D0=BC=D0=
=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=B9 =D0=BA =D1=81=D0=BE=D1=85=
=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=
=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E.\n"
-"\n"
-"=D0=A0=D0=B5=D0=BA=D0=BE=D0=BC=D0=B5=D0=BD=D0=B4=D1=83=D0=B5=D1=82=D1=
=81=D1=8F =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B8=D0=B9 =D1=84=
=D0=BE=D1=80=D0=BC=D0=B0=D1=82 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=
=D0=B0=D1=80=D0=B8=D1=8F:\n"
-"\n"
-"- =D0=BF=D0=B5=D1=80=D0=B2=D0=B0=D1=8F =D1=81=D1=82=D1=80=D0=BE=D0=BA=
=D0=B0: =D0=BA=D1=80=D0=B0=D1=82=D0=BA=D0=BE=D0=B5 =D0=BE=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BD=D0=B8=D0=B5 =D1=81=D0=B4=D0=B5=D0=BB=D0=B0=D0=BD=D0=BD=D1=
=8B=D1=85 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9.\n"
-"- =D0=B2=D1=82=D0=BE=D1=80=D0=B0=D1=8F =D1=81=D1=82=D1=80=D0=BE=D0=BA=
=D0=B0 =D0=BF=D1=83=D1=81=D1=82=D0=B0=D1=8F\n"
-"- =D0=BE=D1=81=D1=82=D0=B0=D0=B2=D1=88=D0=B8=D0=B5=D1=81=D1=8F =D1=81=
=D1=82=D1=80=D0=BE=D0=BA=D0=B8: =D0=BE=D0=BF=D0=B8=D1=88=D0=B8=D1=82=D0=
=B5, =D1=87=D1=82=D0=BE =D0=B4=D0=B0=D1=8E=D1=82 =D0=B2=D0=B0=D1=88=D0=B8=
 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F.\n"
+msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B8=D1=82=D0=B5 =D1=81=D0=BE=D0=BE=D0=
=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=
=B0.\n\n=D0=A0=D0=B5=D0=BA=D0=BE=D0=BC=D0=B5=D0=BD=D0=B4=D1=83=D0=B5=D1=
=82=D1=81=D1=8F =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B8=D0=B9 =
=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=82 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=
=D0=BD=D0=B8=D1=8F:\n\n- =D0=B2 =D0=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=B9 =D1=
=81=D1=82=D1=80=D0=BE=D0=BA=D0=B5 =D0=BA=D1=80=D0=B0=D1=82=D0=BA=D0=BE=D0=
=B5 =D0=BE=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D0=B5 =D1=81=D0=B4=D0=B5=
=D0=BB=D0=B0=D0=BD=D0=BD=D1=8B=D1=85 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=
=D0=BD=D0=B8=D0=B9\n- =D0=B2=D1=82=D0=BE=D1=80=D0=B0=D1=8F =D1=81=D1=82=
=D1=80=D0=BE=D0=BA=D0=B0 =D0=BF=D1=83=D1=81=D1=82=D0=B0=D1=8F\n- =D0=B2=
 =D0=BE=D1=81=D1=82=D0=B0=D0=B2=D1=88=D0=B8=D1=85=D1=81=D1=8F =D1=81=D1=
=82=D1=80=D0=BE=D0=BA=D0=B0=D1=85 =D0=BE=D0=BF=D0=B8=D1=88=D0=B8=D1=82=D0=
=B5, =D1=87=D1=82=D0=BE =D0=B4=D0=B0=D1=8E=D1=82 =D0=B2=D0=B0=D1=88=D0=B8=
 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F\n"
=20
 #: lib/commit.tcl:234
 msgid "Calling pre-commit hook..."
-msgstr "=D0=92=D1=8B=D0=B7=D0=BE=D0=B2 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=
=B0=D0=BC=D0=BC=D1=8B =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=BA=D0=
=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =
pre-commit..."
+msgstr "=D0=92=D1=8B=D0=B7=D0=BE=D0=B2 =D0=BF=D0=B5=D1=80=D0=B5=D1=85=D0=
=B2=D0=B0=D1=82=D1=87=D0=B8=D0=BA=D0=B0 pre-commit=E2=80=A6"
=20
 #: lib/commit.tcl:249
 msgid "Commit declined by pre-commit hook."
-msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D0=BD=D0=BE =D0=BF=D1=80=D0=BE=D0=B3=D1=
=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=
=B6=D0=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=
=B8=D1=8F pre-commit"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B8=D1=82 =D0=BF=D1=80=D0=B5=D1=80=D0=
=B2=D0=B0=D0=BD =D0=BF=D0=B5=D1=80=D0=B5=D0=B2=D0=B0=D1=82=D1=87=D0=B8=D0=
=BA=D0=BE=D0=BC pre-commit."
=20
 #: lib/commit.tcl:272
 msgid "Calling commit-msg hook..."
-msgstr "=D0=92=D1=8B=D0=B7=D0=BE=D0=B2 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=
=B0=D0=BC=D0=BC=D1=8B =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=BA=D0=
=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =
commit-msg..."
+msgstr "=D0=92=D1=8B=D0=B7=D0=BE=D0=B2 =D0=BF=D0=B5=D1=80=D0=B5=D1=85=D0=
=B2=D0=B0=D1=82=D1=87=D0=B8=D0=BA=D0=B0 commit-msg=E2=80=A6"
=20
 #: lib/commit.tcl:287
 msgid "Commit declined by commit-msg hook."
-msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D0=BD=D0=BE =D0=BF=D1=80=D0=BE=D0=B3=D1=
=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=
=B6=D0=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=
=B8=D1=8F commit-msg"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B8=D1=82 =D0=BF=D1=80=D0=B5=D1=80=D0=
=B2=D0=B0=D0=BD =D0=BF=D0=B5=D1=80=D0=B5=D0=B2=D0=B0=D1=82=D1=87=D0=B8=D0=
=BA=D0=BE=D0=BC commit-msg"
=20
 #: lib/commit.tcl:300
 msgid "Committing changes..."
-msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9..."
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B8=D1=82 =D0=B8=D0=B7=D0=BC=D0=B5=D0=
=BD=D0=B5=D0=BD=D0=B8=D0=B9=E2=80=A6"
=20
 #: lib/commit.tcl:316
 msgid "write-tree failed:"
@@ -1451,12 +1365,12 @@ msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=
=BC=D0=BC=D0=B0 write-tree =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D0=
=BB=D0=B0=D1=81=D1=8C =D1=81 =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=BE=D0=B9=
:"
=20
 #: lib/commit.tcl:317 lib/commit.tcl:361 lib/commit.tcl:382
 msgid "Commit failed."
-msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C =D1=81=D0=
=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =D1=83=D0=B4=
=D0=B0=D0=BB=D0=BE=D1=81=D1=8C."
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=B7=
=D0=B0=D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=
=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F."
=20
 #: lib/commit.tcl:334
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
-msgstr "=D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 %s =D0=B2=
=D1=8B=D0=B3=D0=BB=D1=8F=D0=B4=D0=B8=D1=82 =D0=BF=D0=BE=D0=B2=D1=80=D0=B5=
=D0=B6=D0=B4=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B8=D1=82 %s =D0=BF=D0=BE=D1=85=D0=BE=
=D0=B6=D0=B5 =D0=BF=D0=BE=D0=B2=D1=80=D0=B5=D0=B6=D0=B4=D0=B5=D0=BD"
=20
 #: lib/commit.tcl:339
 msgid ""
@@ -1465,16 +1379,11 @@ msgid ""
 "No files were modified by this commit and it was not a merge commit.\=
n"
 "\n"
 "A rescan will be automatically started now.\n"
-msgstr ""
-"=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=82 =D0=
=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B4=D0=BB=D1=8F =
=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F.\n"
-"\n"
-"=D0=9D=D0=B8 =D0=BE=D0=B4=D0=B8=D0=BD =D1=84=D0=B0=D0=B9=D0=BB =D0=BD=
=D0=B5 =D0=B1=D1=8B=D0=BB =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD =D0=
=B8 =D0=BD=D0=B5 =D0=B1=D1=8B=D0=BB=D0=BE =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=
=D0=B8=D1=8F.\n"
-"\n"
-"=D0=A1=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B0=D0=B2=D1=82=D0=BE=D0=BC=D0=
=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8 =D0=B7=D0=B0=D0=BF=D1=83=D1=
=81=D1=82=D0=B8=D1=82=D1=81=D1=8F =D0=BF=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=
=82=D1=8B=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=
=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F.\n"
+msgstr "=D0=9D=D0=B5=D1=82 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=
=B8=D1=8F =D0=B4=D0=BB=D1=8F =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B0=
=2E\n\n=D0=9D=D0=B8 =D0=BE=D0=B4=D0=B8=D0=BD =D1=84=D0=B0=D0=B9=D0=BB =D0=
=BD=D0=B5 =D0=B1=D1=8B=D0=BB =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=
 =D0=B8 =D0=BD=D0=B5 =D0=B1=D1=8B=D0=BB=D0=BE =D1=81=D0=BB=D0=B8=D1=8F=D0=
=BD=D0=B8=D1=8F.\n\n=D0=A1=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B0=D0=B2=D1=
=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8 =D0=B7=D0=
=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=81=D1=8F =D0=BF=D0=B5=D1=80=D0=
=B5=D1=87=D0=B8=D1=82=D1=8B=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=
=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F.\n"
=20
 #: lib/commit.tcl:346
 msgid "No changes to commit."
-msgstr "=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=
=82 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B4=D0=BB=
=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F."
+msgstr "=D0=9D=D0=B5=D1=82 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=
=B8=D1=8F =D0=B4=D0=BB=D1=8F =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B0=
=2E"
=20
 #: lib/commit.tcl:360
 msgid "commit-tree failed:"
@@ -1487,11 +1396,11 @@ msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=
=BC=D0=BC=D0=B0 update-ref =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D0=
=BB=D0=B0=D1=81=D1=8C =D1=81 =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=BE=D0=B9=
:"
 #: lib/commit.tcl:469
 #, tcl-format
 msgid "Created commit %s: %s"
-msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=BE =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 %s: %s "
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD =D0=BA=D0=BE=D0=BC=D0=BC=D0=
=B8=D1=82 %s: %s "
=20
 #: lib/console.tcl:59
 msgid "Working... please wait..."
-msgstr "=D0=92 =D0=BF=D1=80=D0=BE=D1=86=D0=B5=D1=81=D1=81=D0=B5... =D0=
=BF=D0=BE=D0=B6=D0=B0=D0=BB=D1=83=D0=B9=D1=81=D1=82=D0=B0, =D0=B6=D0=B4=
=D0=B8=D1=82=D0=B5..."
+msgstr "=D0=92 =D0=BF=D1=80=D0=BE=D1=86=D0=B5=D1=81=D1=81=D0=B5=E2=80=A6=
 =D0=BF=D0=BE=D0=B6=D0=B0=D0=BB=D1=83=D0=B9=D1=81=D1=82=D0=B0, =D0=B6=D0=
=B4=D0=B8=D1=82=D0=B5=E2=80=A6"
=20
 #: lib/console.tcl:186
 msgid "Success"
@@ -1542,16 +1451,10 @@ msgstr "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=
=BA=D0=B0 =D0=B1=D0=B0=D0=B7=D1=8B =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=
=D0=BE=D0=B2 =D0=BF=D1=80=D0=B8 =D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D0=B8 fs=
ck"
 msgid ""
 "This repository currently has approximately %i loose objects.\n"
 "\n"
-"To maintain optimal performance it is strongly recommended that you c=
ompress "
-"the database.\n"
+"To maintain optimal performance it is strongly recommended that you c=
ompress the database.\n"
 "\n"
 "Compress the database now?"
-msgstr ""
-"=D0=AD=D1=82=D0=BE=D1=82 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=
=BE=D1=80=D0=B8=D0=B9 =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D1=81=D0=BE=
=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=BF=D1=80=D0=B8=D0=BC=D0=B5=D1=80=
=D0=BD=D0=BE %i =D1=81=D0=B2=D0=BE=D0=B1=D0=BE=D0=B4=D0=BD=D1=8B=D1=85 =
=D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D0=BE=D0=B2\n"
-"\n"
-"=D0=94=D0=BB=D1=8F =D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=B9 =D0=BF=D1=80=D0=
=BE=D0=B8=D0=B7=D0=B2=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=
=BE=D1=81=D1=82=D0=B8 =D1=80=D0=B5=D0=BA=D0=BE=D0=BC=D0=B5=D0=BD=D0=B4=D1=
=83=D0=B5=D1=82=D1=81=D1=8F =D1=81=D0=B6=D0=B0=D1=82=D1=8C =D0=B1=D0=B0=
=D0=B7=D1=83 =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85.\n"
-"\n"
-"=D0=A1=D0=B6=D0=B0=D1=82=D1=8C =D0=B1=D0=B0=D0=B7=D1=83 =D0=B4=D0=B0=D0=
=BD=D0=BD=D1=8B=D1=85 =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81?"
+msgstr "=D0=AD=D1=82=D0=BE=D1=82 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D0=B9 =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D1=81=
=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=BF=D1=80=D0=B8=D0=BC=D0=B5=
=D1=80=D0=BD=D0=BE %i =D1=81=D0=B2=D0=BE=D0=B1=D0=BE=D0=B4=D0=BD=D1=8B=D1=
=85 =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D0=BE=D0=B2\n\n=D0=94=D0=BB=D1=
=8F =D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=B9 =D0=BF=D1=80=D0=BE=D0=B8=D0=B7=
=D0=B2=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE=D1=81=D1=82=
=D0=B8 =D1=80=D0=B5=D0=BA=D0=BE=D0=BC=D0=B5=D0=BD=D0=B4=D1=83=D0=B5=D1=82=
=D1=81=D1=8F =D1=81=D0=B6=D0=B0=D1=82=D1=8C =D0=B1=D0=B0=D0=B7=D1=83 =D0=
=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85.\n\n=D0=A1=D0=B6=D0=B0=D1=82=D1=8C =D0=
=B1=D0=B0=D0=B7=D1=83 =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85 =D1=81=D0=B5=
=D0=B9=D1=87=D0=B0=D1=81?"
=20
 #: lib/date.tcl:25
 #, tcl-format
@@ -1565,41 +1468,27 @@ msgid ""
 "\n"
 "%s has no changes.\n"
 "\n"
-"The modification date of this file was updated by another application=
, but "
-"the content within the file was not changed.\n"
-"\n"
-"A rescan will be automatically started to find other files which may =
have "
-"the same state."
-msgstr ""
-"=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=BD=D0=B5 =D0=
=BE=D0=B1=D0=BD=D0=B0=D1=80=D1=83=D0=B6=D0=B5=D0=BD=D0=BE.\n"
+"The modification date of this file was updated by another application=
, but the content within the file was not changed.\n"
 "\n"
-"=D0=B2 %s =D0=BE=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D1=8E=
=D1=82 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F.\n"
-"\n"
-"=D0=94=D0=B0=D1=82=D0=B0 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=
=B8=D1=8F =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=B1=D1=8B=D0=BB=D0=B0 =D0=BE=
=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=B0 =D0=B4=D1=80=D1=83=D0=B3=
=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9=
, =D0=BD=D0=BE =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D0=BC=D0=BE=D0=
=B5 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 "
-"=D0=BE=D1=81=D1=82=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=D1=80=D0=B5=D0=
=B6=D0=BD=D0=B8=D0=BC.\n"
-"\n"
-"=D0=A1=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D0=
=B7=D0=B0=D0=BF=D1=83=D1=89=D0=B5=D0=BD=D0=BE =D0=BF=D0=B5=D1=80=D0=B5=D1=
=87=D0=B8=D1=82=D1=8B=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F, =D1=87=D1=82=D0=BE=D0=B1=
=D1=8B =D0=BD=D0=B0=D0=B9=D1=82=D0=B8 =D0=BF=D0=BE=D0=B4=D0=BE=D0=B1=D0=
=BD=D1=8B=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D1=8B."
+"A rescan will be automatically started to find other files which may =
have the same state."
+msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=BD=D0=
=B5 =D0=BE=D0=B1=D0=BD=D0=B0=D1=80=D1=83=D0=B6=D0=B5=D0=BD=D0=BE.\n\n=D0=
=B2 %s =D0=BE=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=82=
 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F.\n\n=D0=94=D0=B0=
=D1=82=D0=B0 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D1=
=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=B1=D1=8B=D0=BB=D0=B0 =D0=BE=D0=B1=D0=BD=
=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=B0 =D0=B4=D1=80=D1=83=D0=B3=D0=BE=D0=B9=
 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9, =D0=BD=D0=
=BE =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D0=BC=D0=BE=D0=B5 =D1=84=
=D0=B0=D0=B9=D0=BB=D0=B0 =D0=BE=D1=81=D1=82=D0=B0=D0=BB=D0=BE=D1=81=D1=8C=
 =D0=BF=D1=80=D0=B5=D0=B6=D0=BD=D0=B8=D0=BC.\n\n=D0=A1=D0=B5=D0=B9=D1=87=
=D0=B0=D1=81 =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D0=B7=D0=B0=D0=BF=D1=83=D1=
=89=D0=B5=D0=BD=D0=BE =D0=BF=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D1=8B=D0=
=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=
=BE=D1=80=D0=B8=D1=8F, =D1=87=D1=82=D0=BE=D0=B1=D1=8B =D0=BD=D0=B0=D0=B9=
=D1=82=D0=B8 =D0=BF=D0=BE=D0=B4=D0=BE=D0=B1=D0=BD=D1=8B=D0=B5 =D1=84=D0=
=B0=D0=B9=D0=BB=D1=8B."
=20
 #: lib/diff.tcl:104
 #, tcl-format
 msgid "Loading diff of %s..."
-msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=B2 %s..."
+msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 %s=E2=80=A6"
=20
 #: lib/diff.tcl:125
 msgid ""
 "LOCAL: deleted\n"
 "REMOTE:\n"
-msgstr ""
-"=D0=9B=D0=9E=D0=9A=D0=90=D0=9B=D0=AC=D0=9D=D0=9E: =D1=83=D0=B4=D0=B0=D0=
=BB=D1=91=D0=BD\n"
-"=D0=92=D0=9D=D0=95=D0=A8=D0=9D=D0=98=D0=99:\n"
+msgstr "=D0=9B=D0=9E=D0=9A=D0=90=D0=9B=D0=AC=D0=9D=D0=9E: =D1=83=D0=B4=
=D0=B0=D0=BB=D1=91=D0=BD\n=D0=92=D0=9D=D0=95=D0=A8=D0=9D=D0=98=D0=99:\n=
"
=20
 #: lib/diff.tcl:130
 msgid ""
 "REMOTE: deleted\n"
 "LOCAL:\n"
-msgstr ""
-"=D0=92=D0=9D=D0=95=D0=A8=D0=9D=D0=98=D0=99: =D1=83=D0=B4=D0=B0=D0=BB=D1=
=91=D0=BD\n"
-"=D0=9B=D0=9E=D0=9A=D0=90=D0=9B=D0=AC=D0=9D=D0=9E:\n"
+msgstr "=D0=92=D0=9D=D0=95=D0=A8=D0=9D=D0=98=D0=99: =D1=83=D0=B4=D0=B0=
=D0=BB=D1=91=D0=BD\n=D0=9B=D0=9E=D0=9A=D0=90=D0=9B=D0=AC=D0=9D=D0=9E:\n=
"
=20
 #: lib/diff.tcl:137
 msgid "LOCAL:\n"
@@ -1631,9 +1520,7 @@ msgstr "* =D0=94=D0=B2=D0=BE=D0=B8=D1=87=D0=BD=D1=
=8B=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB (=D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=
=D0=B8=D0=BC=D0=BE=D0=B5 =D0=BD=D0=B5 =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=
=B0=D0=BD=D0=BE)
 msgid ""
 "* Untracked file is %d bytes.\n"
 "* Showing only first %d bytes.\n"
-msgstr ""
-"* =D0=A0=D0=B0=D0=B7=D0=BC=D0=B5=D1=80 =D0=BD=D0=B5=D0=BF=D0=BE=D0=B4=
=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE=
 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 %d =D0=B1=D0=B0=D0=B9=D1=82.\n"
-"* =D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BE =D0=BF=D0=B5=D1=80=
=D0=B2=D1=8B=D1=85 %d =D0=B1=D0=B0=D0=B9=D1=82.\n"
+msgstr "* =D0=A0=D0=B0=D0=B7=D0=BC=D0=B5=D1=80 =D0=BD=D0=B5=D0=BE=D1=82=
=D1=81=D0=BB=D0=B5=D0=B6=D0=B8=D0=B2=D0=B0=D0=B5=D0=BC=D0=BE=D0=B3=D0=BE=
 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 %d =D0=B1=D0=B0=D0=B9=D1=82.\n* =D0=9F=D0=
=BE=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BE =D0=BF=D0=B5=D1=80=D0=B2=D1=8B=D1=
=85 %d =D0=B1=D0=B0=D0=B9=D1=82.\n"
=20
 #: lib/diff.tcl:233
 #, tcl-format
@@ -1641,10 +1528,7 @@ msgid ""
 "\n"
 "* Untracked file clipped here by %s.\n"
 "* To see the entire file, use an external editor.\n"
-msgstr ""
-"\n"
-"* =D0=9D=D0=B5=D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=
=B5=D0=BD=D0=BD=D1=8B=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB =D0=BE=D0=B1=D1=80=
=D0=B5=D0=B7=D0=B0=D0=BD: %s.\n"
-"* =D0=A7=D1=82=D0=BE=D0=B1=D1=8B =D1=83=D0=B2=D0=B8=D0=B4=D0=B5=D1=82=
=D1=8C =D0=B2=D0=B5=D1=81=D1=8C =D1=84=D0=B0=D0=B9=D0=BB, =D0=B8=D1=81=D0=
=BF=D0=BE=D0=BB=D1=8C=D0=B7=D1=83=D0=B9=D1=82=D0=B5 =D0=BF=D1=80=D0=BE=D0=
=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=83-=D1=80=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=
=BE=D1=80.\n"
+msgstr "\n* =D0=9D=D0=B5=D0=BE=D1=82=D1=81=D0=BB=D0=B5=D0=B6=D0=B8=D0=B2=
=D0=B0=D0=B5=D0=BC=D1=8B=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB =D0=BE=D0=B1=D1=
=80=D0=B5=D0=B7=D0=B0=D0=BD: %s.\n* =D0=A7=D1=82=D0=BE=D0=B1=D1=8B =D1=83=
=D0=B2=D0=B8=D0=B4=D0=B5=D1=82=D1=8C =D0=B2=D0=B5=D1=81=D1=8C =D1=84=D0=
=B0=D0=B9=D0=BB, =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D1=83=D0=B9=
=D1=82=D0=B5 =D0=B2=D0=BD=D0=B5=D1=88=D0=BD=D0=B8=D0=B9 =D1=80=D0=B5=D0=
=B4=D0=B0=D0=BA=D1=82=D0=BE=D1=80.\n"
=20
 #: lib/diff.tcl:482
 msgid "Failed to unstage selected hunk."
@@ -1652,7 +1536,7 @@ msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=
=D1=81=D1=8C =D0=B8=D1=81=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D1=8C =D0=
=B2=D1=8B=D0=B1=D1=80=D0=B0=D0=BD=D0=BD=D1=83=D1=8E =D1=87=D0=B0=D1=81=D1=
=82=D1=8C."
=20
 #: lib/diff.tcl:489
 msgid "Failed to stage selected hunk."
-msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D0=BA =D1=
=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E =D0=B2=D1=8B=D0=
=B1=D1=80=D0=B0=D0=BD=D0=BD=D1=83=D1=8E =D1=87=D0=B0=D1=81=D1=82=D1=8C.=
"
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D1=80=D0=BE=D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B8=D1=80=D0=BE=D0=B2=
=D0=B0=D1=82=D1=8C =D0=B2=D1=8B=D0=B1=D1=80=D0=B0=D0=BD=D0=BD=D1=8B=D0=B9=
 =D0=B1=D0=BB=D0=BE=D0=BA =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=
=B8=D0=B9."
=20
 #: lib/diff.tcl:568
 msgid "Failed to unstage selected line."
@@ -1660,7 +1544,7 @@ msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=
=D1=81=D1=8C =D0=B8=D1=81=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D1=8C =D0=
=B2=D1=8B=D0=B1=D1=80=D0=B0=D0=BD=D0=BD=D1=83=D1=8E =D1=81=D1=82=D1=80=D0=
=BE=D0=BA=D1=83."
=20
 #: lib/diff.tcl:576
 msgid "Failed to stage selected line."
-msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D0=BA =D1=
=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E =D0=B2=D1=8B=D0=
=B1=D1=80=D0=B0=D0=BD=D0=BD=D1=83=D1=8E =D1=81=D1=82=D1=80=D0=BE=D0=BA=D1=
=83."
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D1=80=D0=BE=D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B8=D1=80=D0=BE=D0=B2=
=D0=B0=D1=82=D1=8C =D0=B2=D1=8B=D0=B1=D1=80=D0=B0=D0=BD=D0=BD=D1=83=D1=8E=
 =D1=81=D1=82=D1=80=D0=BE=D0=BA=D1=83."
=20
 #: lib/encoding.tcl:443
 msgid "Default"
@@ -1685,7 +1569,7 @@ msgstr "=D0=BF=D1=80=D0=B5=D0=B4=D1=83=D0=BF=D1=80=
=D0=B5=D0=B6=D0=B4=D0=B5=D0=BD=D0=B8=D0=B5"
=20
 #: lib/error.tcl:94
 msgid "You must correct the above errors before committing."
-msgstr "=D0=9F=D1=80=D0=B5=D0=B6=D0=B4=D0=B5 =D1=87=D0=B5=D0=BC =D1=81=
=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C, =D0=B8=D1=81=D0=BF=D1=
=80=D0=B0=D0=B2=D1=8C=D1=82=D0=B5 =D0=B2=D1=8B=D1=88=D0=B5=D1=83=D0=BA=D0=
=B0=D0=B7=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=
=B8."
+msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B4 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=
=82=D0=BE=D0=BC, =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D1=8C=D1=82=D0=B5=
 =D0=B2=D1=8B=D1=88=D0=B5=D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BD=D1=8B=
=D0=B5 =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=B8."
=20
 #: lib/index.tcl:6
 msgid "Unable to unlock the index."
@@ -1699,9 +1583,7 @@ msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2=
 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B5"
 msgid ""
 "Updating the Git index failed.  A rescan will be automatically starte=
d to "
 "resynchronize git-gui."
-msgstr ""
-"=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BE=D0=B1=D0=
=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81 =
Git. =D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=
=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D0=B1=D1=83=D0=B4=
=D0=B5=D1=82 =D0=BF=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=BE=
 "
-"=D0=B0=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=
=BA=D0=B8."
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BE=
=D0=B1=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=
=D1=81 Git. =D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=80=
=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D0=B1=D1=83=
=D0=B4=D0=B5=D1=82 =D0=BF=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D0=BD=
=D0=BE =D0=B0=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=
=D0=BA=D0=B8."
=20
 #: lib/index.tcl:28
 msgid "Continue"
@@ -1714,16 +1596,16 @@ msgstr "=D0=A0=D0=B0=D0=B7=D0=B1=D0=BB=D0=BE=D0=
=BA=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=
=BA=D1=81"
 #: lib/index.tcl:289
 #, tcl-format
 msgid "Unstaging %s from commit"
-msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 %s =D0=B8=D0=B7=
 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=B3=D0=BE"
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 %s =D0=B8=D0=B7=
 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0"
=20
 #: lib/index.tcl:328
 msgid "Ready to commit."
-msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=
=D0=BD=D0=B8=D1=8F"
+msgstr "=D0=93=D0=BE=D1=82=D0=BE=D0=B2 =D0=B4=D0=BB=D1=8F =D0=BA=D0=BE=
=D0=BC=D0=BC=D0=B8=D1=82=D0=B0."
=20
 #: lib/index.tcl:341
 #, tcl-format
 msgid "Adding %s"
-msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 %=
s..."
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 %=
s=E2=80=A6"
=20
 #: lib/index.tcl:398
 #, tcl-format
@@ -1737,9 +1619,7 @@ msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=
=D1=8C =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 %i=
 =D1=84=D0=B0=D0=B9=D0=BB=D0=B5(-=D0=B0=D1=85)?"
=20
 #: lib/index.tcl:408
 msgid "Any unstaged changes will be permanently lost by the revert."
-msgstr ""
-"=D0=9B=D1=8E=D0=B1=D1=8B=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=
=BD=D0=B8=D1=8F, =D0=BD=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=
=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BA =D1=81=D0=BE=D1=85=D1=
=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E, =D0=B1=D1=83=D0=B4=D1=83=D1=82=
 =D0=BF=D0=BE=D1=82=D0=B5=D1=80=D1=8F=D0=BD=D1=8B =D0=BF=D1=80=D0=B8 =D0=
=B4=D0=B0=D0=BD=D0=BD=D0=BE=D0=B9 "
-"=D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B8."
+msgstr "=D0=9B=D1=8E=D0=B1=D1=8B=D0=B5 =D0=BD=D0=B5=D0=BF=D1=80=D0=BE=D0=
=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=
=BD=D1=8B=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F,=
 =D0=B1=D1=83=D0=B4=D1=83=D1=82 =D0=BF=D0=BE=D1=82=D0=B5=D1=80=D1=8F=D0=
=BD=D1=8B =D0=BF=D1=80=D0=B8 =D1=81=D0=B1=D1=80=D0=BE=D1=81=D0=B5."
=20
 #: lib/index.tcl:411
 msgid "Do Nothing"
@@ -1759,26 +1639,16 @@ msgid ""
 "Cannot merge while amending.\n"
 "\n"
 "You must finish amending this commit before starting any type of merg=
e.\n"
-msgstr ""
-"=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=B2=D1=
=8B=D0=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=82=D1=8C =D1=81=D0=BB=D0=B8=D1=8F=D0=
=BD=D0=B8=D0=B5 =D0=B2=D0=BE =D0=B2=D1=80=D0=B5=D0=BC=D1=8F =D0=B8=D1=81=
=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F.\n"
-"\n"
-"=D0=97=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D1=82=D0=B5 =D0=B8=D1=81=D0=
=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B4=D0=B0=D0=BD=D0=
=BD=D0=BE=D0=B3=D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=
=8F =D0=BF=D0=B5=D1=80=D0=B5=D0=B4 =D0=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=
=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=
=D0=B8 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F.\n"
+msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=82=D1=8C =D1=81=D0=BB=D0=B8=D1=
=8F=D0=BD=D0=B8=D0=B5 =D0=B2=D0=BE =D0=B2=D1=80=D0=B5=D0=BC=D1=8F =D0=B8=
=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F.\n\n=D0=97=
=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D1=82=D0=B5 =D0=B8=D1=81=D0=BF=D1=80=
=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B4=D0=B0=D0=BD=D0=BD=D0=BE=
=D0=B3=D0=BE =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B0 =D0=BF=D0=B5=D1=
=80=D0=B5=D0=B4 =D0=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=
=B5=D0=BC =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D1=81=D0=BB=
=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F.\n"
=20
 #: lib/merge.tcl:27
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
-"Another Git program has modified this repository since the last scan.=
  A "
-"rescan must be performed before a merge can be performed.\n"
+"Another Git program has modified this repository since the last scan.=
  A rescan must be performed before a merge can be performed.\n"
 "\n"
 "The rescan will be automatically started now.\n"
-msgstr ""
-"=D0=9F=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B5 =D0=BF=D1=80=D0=
=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D1=8F =D0=BD=D0=B5 =D1=81=D0=BE=D0=BE=D1=82=D0=B2=
=D0=B5=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 =D1=82=D0=B5=D0=BA=D1=83=
=D1=89=D0=B5=D0=BC=D1=83.\n"
-"\n"
-"=D0=A1 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=BF=D0=BE=D1=81=D0=
=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B9 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=
=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 =D0=B1=D1=8B=D0=BB =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD =D0=B4=
=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=
=D0=BC=D0=BE=D0=B9 Git. "
-"=D0=9D=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=BE =D0=BF=D0=
=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9, =D0=BF=D1=80=D0=B5=D0=B6=
=D0=B4=D0=B5 =D1=87=D0=B5=D0=BC =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D1=8F=D1=
=82=D1=8C =D1=82=D0=B5=D0=BA=D1=83=D1=89=D1=83=D1=8E =D0=B2=D0=B5=D1=82=
=D0=B2=D1=8C.\n"
-"\n"
-"=D0=AD=D1=82=D0=BE =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=B4=D0=B5=D0=
=BB=D0=B0=D0=BD=D0=BE =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B0=D0=B2=
=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8.\n"
+msgstr "=D0=9F=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B5 =D0=BF=D1=
=80=D0=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=
=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=
=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D0=BD=D0=B5 =D1=81=D0=BE=D0=BE=D1=82=
=D0=B2=D0=B5=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 =D1=82=D0=B5=D0=BA=
=D1=83=D1=89=D0=B5=D0=BC=D1=83.\n\n=D0=A1 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=
=D1=82=D0=B0 =D0=BF=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B9 =D0=
=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=
=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9 =D0=B1=D1=8B=D0=BB =D0=B8=D0=B7=
=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD =D0=B4=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =D0=
=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9 Git. =D0=9D=D0=
=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=BE =D0=BF=D0=B5=D1=80=D0=
=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=
=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9, =D0=BF=D1=80=D0=B5=D0=B6=D0=B4=D0=B5=
 =D1=87=D0=B5=D0=BC =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BC=D0=
=BE=D0=B6=D0=B5=D1=82 =D0=B1=D1=8B=D1=82=D1=8C =D1=81=D0=B4=D0=B5=D0=BB=
=D0=B0=D0=BD=D0=BE.\n\n=D0=AD=D1=82=D0=BE =D0=B1=D1=83=D0=B4=D0=B5=D1=82=
 =D1=81=D0=B4=D0=B5=D0=BB=D0=B0=D0=BD=D0=BE =D1=81=D0=B5=D0=B9=D1=87=D0=
=B0=D1=81 =D0=B0=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=
=81=D0=BA=D0=B8.\n"
=20
 #: lib/merge.tcl:45
 #, tcl-format
@@ -1787,15 +1657,8 @@ msgid ""
 "\n"
 "File %s has merge conflicts.\n"
 "\n"
-"You must resolve them, stage the file, and commit to complete the cur=
rent "
-"merge.  Only then can you begin another merge.\n"
-msgstr ""
-"=D0=9F=D1=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=B5 =D1=81=D0=
=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =D0=B7=D0=B0=D0=B2=D0=B5=
=D1=80=D1=88=D0=B5=D0=BD=D0=BE =D0=B8=D0=B7-=D0=B7=D0=B0 =D0=BA=D0=BE=D0=
=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B0.\n"
-"\n"
-"=D0=94=D0=BB=D1=8F =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 %s =D0=B2=D0=BE=D0=B7=
=D0=BD=D0=B8=D0=BA =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82 =D1=
=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F.\n"
-"\n"
-"=D0=A0=D0=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B8=D1=82=D0=B5 =D0=BA=D0=BE=D0=
=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82, =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=
=D0=BE=D0=B2=D1=8C=D1=82=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB =D0=B8 =D1=81=D0=
=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5. =D0=A2=D0=BE=D0=BB=D1=8C=
=D0=BA=D0=BE =D0=BF=D0=BE=D1=81=D0=BB=D0=B5 =D1=8D=D1=82=D0=BE=D0=B3=D0=
=BE =D0=BC=D0=BE=D0=B6=D0=BD=D0=BE "
-"=D0=BD=D0=B0=D1=87=D0=B0=D1=82=D1=8C =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=
=8E=D1=89=D0=B5=D0=B5 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5.\n"
+"You must resolve them, stage the file, and commit to complete the cur=
rent merge.  Only then can you begin another merge.\n"
+msgstr "=D0=9F=D1=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=B5 =D1=
=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =D0=B7=D0=B0=D0=B2=
=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=BE =D0=B8=D0=B7-=D0=B7=D0=B0 =D0=BA=D0=
=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B0.\n\n=D0=94=D0=BB=D1=8F =D1=
=84=D0=B0=D0=B9=D0=BB=D0=B0 %s =D0=B2=D0=BE=D0=B7=D0=BD=D0=B8=D0=BA =D0=
=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82 =D1=81=D0=BB=D0=B8=D1=8F=D0=
=BD=D0=B8=D1=8F.\n\n=D0=A0=D0=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B8=D1=82=D0=
=B5 =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82, =D0=B4=D0=BE=D0=B1=
=D0=B0=D0=B2=D1=8C=D1=82=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB =D0=B2 =D0=B8=D0=
=BD=D0=B4=D0=B5=D0=BA=D1=81 =D0=B8 =D0=B7=D0=B0=D0=BA=D0=BE=D0=BC=D0=BC=
=D0=B8=D1=82=D1=8C=D1=82=D0=B5. =D0=A2=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D0=
=BF=D0=BE=D1=81=D0=BB=D0=B5 =D1=8D=D1=82=D0=BE=D0=B3=D0=BE =D0=BC=D0=BE=
=D0=B6=D0=BD=D0=BE =D0=BD=D0=B0=D1=87=D0=B0=D1=82=D1=8C =D1=81=D0=BB=D0=
=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=B5 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=
=B8=D0=B5.\n"
=20
 #: lib/merge.tcl:55
 #, tcl-format
@@ -1804,15 +1667,8 @@ msgid ""
 "\n"
 "File %s is modified.\n"
 "\n"
-"You should complete the current commit before starting a merge.  Doin=
g so "
-"will help you abort a failed merge, should the need arise.\n"
-msgstr ""
-"=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BD=D0=B5 =D1=
=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D1=8B.\n"
-"\n"
-"=D0=A4=D0=B0=D0=B9=D0=BB %s =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=
=2E\n"
-"\n"
-"=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D1=8C=D1=82=D0=B5 =D0=
=B8 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=B8=D0=B7=
=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D0=B5=D1=80=D0=B5=D0=B4=
 =D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D0=BE=D0=BC =D1=81=D0=BB=D0=B8=D1=8F=D0=
=BD=D0=B8=D1=8F. =D0=92 =D1=81=D0=BB=D1=83=D1=87=D0=B0=D0=B5 "
-"=D0=BD=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=BE=D1=81=D1=
=82=D0=B8 =D1=8D=D1=82=D0=BE =D0=BF=D0=BE=D0=B7=D0=B2=D0=BE=D0=BB=D0=B8=
=D1=82 =D0=BF=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D1=82=D1=8C =D0=BE=D0=BF=D0=
=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8E =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=
=8F.\n"
+"You should complete the current commit before starting a merge.  Doin=
g so will help you abort a failed merge, should the need arise.\n"
+msgstr "=D0=92=D1=8B =D0=BD=D0=B0=D1=85=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D1=
=81=D1=8C =D0=B2 =D0=BF=D1=80=D0=BE=D1=86=D0=B5=D1=81=D1=81=D0=B5 =D0=B8=
=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9.\n\n=D0=A4=D0=B0=D0=B9=
=D0=BB %s =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D1=91=D0=BD.\n\n=D0=92=D1=8B =D0=
=B4=D0=BE=D0=BB=D0=B6=D0=BD=D1=8B =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=
=B8=D1=82=D1=8C =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B8=D0=B9 =D0=BA=D0=BE=
=D0=BC=D0=BC=D0=B8=D1=82 =D0=BF=D0=B5=D1=80=D0=B5=D0=B4 =D0=BD=D0=B0=D1=
=87=D0=B0=D0=BB=D0=BE=D0=BC =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F.=
 =D0=92 =D1=81=D0=BB=D1=83=D1=87=D0=B0=D0=B5 =D0=BD=D0=B5=D0=BE=D0=B1=D1=
=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=BE=D1=81=D1=82=D0=B8, =D1=8D=D1=82=D0=BE=
 =D0=BF=D0=BE=D0=B7=D0=B2=D0=BE=D0=BB=D0=B8=D1=82 =D0=BF=D1=80=D0=B5=D1=
=80=D0=B2=D0=B0=D1=82=D1=8C =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=
=8E =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F.\n"
=20
 #: lib/merge.tcl:107
 #, tcl-format
@@ -1822,7 +1678,7 @@ msgstr "%s =D0=B8=D0=B7 %s"
 #: lib/merge.tcl:120
 #, tcl-format
 msgid "Merging %s and %s..."
-msgstr "=D0=A1=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5 %s =D0=B8 %s..."
+msgstr "=D0=A1=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5 %s =D0=B8 %s=E2=80=A6=
"
=20
 #: lib/merge.tcl:131
 msgid "Merge completed successfully."
@@ -1846,10 +1702,7 @@ msgid ""
 "Cannot abort while amending.\n"
 "\n"
 "You must finish amending this commit.\n"
-msgstr ""
-"=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=BF=D1=
=80=D0=B5=D1=80=D0=B2=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=
=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5.\n"
-"\n"
-"=D0=97=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D1=82=D0=B5 =D1=82=D0=B5=D0=
=BA=D1=83=D1=89=D0=B5=D0=B5 =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=
=B5=D0=BD=D0=B8=D0=B5 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=
=BD=D0=BE=D0=B3=D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=
=8F.\n"
+msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=BF=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D0=BF=D1=80=D0=
=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5.\n\n=D0=97=D0=B0=D0=B2=D0=B5=D1=
=80=D1=88=D0=B8=D1=82=D0=B5 =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B5 =
=D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BA=
=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B0.\n"
=20
 #: lib/merge.tcl:222
 msgid ""
@@ -1858,12 +1711,7 @@ msgid ""
 "Aborting the current merge will cause *ALL* uncommitted changes to be=
 lost.\n"
 "\n"
 "Continue with aborting the current merge?"
-msgstr ""
-"=D0=9F=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D1=82=D1=8C =D0=BE=D0=BF=D0=B5=D1=
=80=D0=B0=D1=86=D0=B8=D1=8E =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F?=
\n"
-"\n"
-"=D0=9F=D1=80=D0=B5=D1=80=D1=8B=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D1=8D=D1=
=82=D0=BE=D0=B9 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D0=BF=
=D1=80=D0=B8=D0=B2=D0=B5=D0=B4=D0=B5=D1=82 =D0=BA =D0=BF=D0=BE=D1=82=D0=
=B5=D1=80=D0=B5 *=D0=92=D0=A1=D0=95=D0=A5* =D0=BD=D0=B5=D1=81=D0=BE=D1=85=
=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D1=8B=D1=85 =D0=B8=D0=B7=D0=BC=D0=B5=
=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9.\n"
-"\n"
-"=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C?"
+msgstr "=D0=9F=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D1=82=D1=8C =D0=BE=D0=BF=D0=
=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8E =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=
=8F?\n\n=D0=9F=D1=80=D0=B5=D1=80=D1=8B=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D1=
=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B3=D0=BE =D1=81=D0=BB=D0=B8=D1=8F=D0=
=BD=D0=B8=D1=8F =D0=BF=D1=80=D0=B8=D0=B2=D0=B5=D0=B4=D0=B5=D1=82 =D0=BA=
 =D0=BF=D0=BE=D1=82=D0=B5=D1=80=D0=B5 *=D0=92=D0=A1=D0=95=D0=A5* =D0=BD=
=D0=B5=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D1=8B=D1=85=
 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9.\n\n=D0=9F=D1=80=
=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C?"
=20
 #: lib/merge.tcl:228
 msgid ""
@@ -1872,12 +1720,7 @@ msgid ""
 "Resetting the changes will cause *ALL* uncommitted changes to be lost=
=2E\n"
 "\n"
 "Continue with resetting the current changes?"
-msgstr ""
-"=D0=9F=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D1=82=D1=8C =D0=BE=D0=BF=D0=B5=D1=
=80=D0=B0=D1=86=D0=B8=D1=8E =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F?=
\n"
-"\n"
-"=D0=9F=D1=80=D0=B5=D1=80=D1=8B=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D1=8D=D1=
=82=D0=BE=D0=B9 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D0=BF=
=D1=80=D0=B8=D0=B2=D0=B5=D0=B4=D0=B5=D1=82 =D0=BA =D0=BF=D0=BE=D1=82=D0=
=B5=D1=80=D0=B5 *=D0=92=D0=A1=D0=95=D0=A5* =D0=BD=D0=B5=D1=81=D0=BE=D1=85=
=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D1=8B=D1=85 =D0=B8=D0=B7=D0=BC=D0=B5=
=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9.\n"
-"\n"
-"=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C?"
+msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F?\n\n=D0=A1=D0=B1=D1=80=D0=BE=D1=
=81 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=BF=D1=80=
=D0=B8=D0=B2=D0=B5=D0=B4=D0=B5=D1=82 =D0=BA =D0=BF=D0=BE=D1=82=D0=B5=D1=
=80=D0=B5 *=D0=92=D0=A1=D0=95=D0=A5* =D0=BD=D0=B5=D1=81=D0=BE=D1=85=D1=80=
=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D1=8B=D1=85 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=
=D0=B5=D0=BD=D0=B8=D0=B9.\n\n=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=
=D0=B8=D1=82=D1=8C?"
=20
 #: lib/merge.tcl:239
 msgid "Aborting"
@@ -1901,11 +1744,11 @@ msgstr "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=
=B7=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=B1=D0=B0=D0=B7=D0=BE=D0=B2=D1=83=D1=
=8E =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8E =D0=B4=D0=BB=D1=8F =D1=80=D0=B0=
=D0=B7=D1=80=D0=B5=D1=88
=20
 #: lib/mergetool.tcl:9
 msgid "Force resolution to this branch?"
-msgstr "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8E =D1=8D=D1=82=D0=BE=D0=B9=
 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=B4=D0=BB=D1=8F =D1=80=D0=B0=D0=B7=D1=
=80=D0=B5=D1=88=D0=B5=D0=BD=D0=B8=D1=8F =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=
=B8=D0=BA=D1=82=D0=B0?"
+msgstr "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8E =D0=B8=D0=B7 =D1=8D=D1=82=
=D0=BE=D0=B9 =D0=B2=D0=B5=D1=82=D0=BA=D0=B8 =D0=B4=D0=BB=D1=8F =D1=80=D0=
=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B5=D0=BD=D0=B8=D1=8F =D0=BA=D0=BE=D0=BD=D1=
=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B0?"
=20
 #: lib/mergetool.tcl:10
 msgid "Force resolution to the other branch?"
-msgstr "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8E =D0=B4=D1=80=D1=83=D0=B3=
=D0=BE=D0=B9 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=B4=D0=BB=D1=8F =D1=80=D0=
=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B5=D0=BD=D0=B8=D1=8F =D0=BA=D0=BE=D0=BD=D1=
=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B0?"
+msgstr "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8E =D0=B8=D0=B7 =D0=B4=D1=80=
=D1=83=D0=B3=D0=BE=D0=B9 =D0=B2=D0=B5=D1=82=D0=BA=D0=B8 =D0=B4=D0=BB=D1=
=8F =D1=80=D0=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B5=D0=BD=D0=B8=D1=8F =D0=BA=
=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B0?"
=20
 #: lib/mergetool.tcl:14
 #, tcl-format
@@ -1915,19 +1758,12 @@ msgid ""
 "%s will be overwritten.\n"
 "\n"
 "This operation can be undone only by restarting the merge."
-msgstr ""
-"=D0=92=D0=BD=D0=B8=D0=BC=D0=B0=D0=BD=D0=B8=D0=B5! =D0=A1=D0=BF=D0=B8=D1=
=81=D0=BE=D0=BA =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =
=D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D1=8B=D0=B2=D0=B0=D0=B5=D1=82 =D1=82=D0=BE=
=D0=BB=D1=8C=D0=BA=D0=BE =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=
=D1=83=D1=8E=D1=89=D0=B8=D0=B5 =D0=BE=D1=82=D0=BB=D0=B8=D1=87=D0=B8=D1=8F=
=2E\n"
-"\n"
-"%s =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D0=BF=D0=B5=D1=80=D0=B5=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BD.\n"
-"\n"
-"=D0=AD=D1=82=D0=BE =D0=B4=D0=B5=D0=B9=D1=81=D1=82=D0=B2=D0=B8=D0=B5 =D0=
=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=BE=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=
=8C =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D0=BF=D0=B5=D1=80=D0=B5=D0=B7=
=D0=B0=D0=BF=D1=83=D1=81=D0=BA=D0=BE=D0=BC =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=
=D1=86=D0=B8=D0=B8 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F."
+msgstr "=D0=92=D0=BD=D0=B8=D0=BC=D0=B0=D0=BD=D0=B8=D0=B5! =D0=A1=D0=BF=
=D0=B8=D1=81=D0=BE=D0=BA =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=
=D0=B9 =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D1=8B=D0=B2=D0=B0=D0=B5=D1=82 =D1=
=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=
=BA=D1=82=D1=83=D1=8E=D1=89=D0=B8=D0=B5 =D0=BE=D1=82=D0=BB=D0=B8=D1=87=D0=
=B8=D1=8F.\n\n%s =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D0=BF=D0=B5=D1=80=D0=B5=
=D0=BF=D0=B8=D1=81=D0=B0=D0=BD.\n\n=D0=AD=D1=82=D0=BE =D0=B4=D0=B5=D0=B9=
=D1=81=D1=82=D0=B2=D0=B8=D0=B5 =D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=BE=D1=
=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=
=BE =D0=BF=D0=B5=D1=80=D0=B5=D0=B7=D0=B0=D0=BF=D1=83=D1=81=D0=BA=D0=BE=D0=
=BC =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D1=81=D0=BB=D0=B8=
=D1=8F=D0=BD=D0=B8=D1=8F."
=20
 #: lib/mergetool.tcl:45
 #, tcl-format
 msgid "File %s seems to have unresolved conflicts, still stage?"
-msgstr ""
-"=D0=A4=D0=B0=D0=B9=D0=BB %s, =D0=BF=D0=BE=D1=85=D0=BE=D0=B6=D0=B5, =D1=
=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=BD=D0=B5=D0=BE=D0=B1=D1=
=80=D0=B0=D0=B1=D0=BE=D1=82=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BA=D0=BE=D0=
=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=8B. =D0=9F=D1=80=D0=BE=D0=B4=D0=BE=
=D0=BB=D0=B6=D0=B8=D1=82=D1=8C =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=
=D0=B2=D0=BA=D1=83 =D0=BA "
-"=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E?"
+msgstr "=D0=9F=D0=BE=D1=85=D0=BE=D0=B6=D0=B5, =D1=87=D1=82=D0=BE =D1=84=
=D0=B0=D0=B9=D0=BB %s =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =
=D0=BD=D0=B5=D1=80=D0=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B5=D0=BD=D0=BD=D1=8B=
=D0=B5 =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=8B. =D0=9F=D1=
=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=
=B5=D0=BA=D1=81=D0=B0=D1=86=D0=B8=D1=8E?"
=20
 #: lib/mergetool.tcl:60
 #, tcl-format
@@ -1936,8 +1772,7 @@ msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=BB=D1=8F=
=D1=8E =D1=80=D0=B5=D0=B7=D1=83=D0=BB=D1=8C=D1=82=D0=B0=D1=82 =D1=80=D0=
=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B5=D0=BD=D0=B8=D1=8F =D0=B4=D0=BB=D1=8F =
%s"
=20
 #: lib/mergetool.tcl:141
 msgid "Cannot resolve deletion or link conflicts using a tool"
-msgstr ""
-"=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D1=81=D0=BB=D0=
=B8=D1=8F=D0=BD=D0=B8=D1=8F =D0=BD=D0=B5 =D0=BE=D0=B1=D1=80=D0=B0=D0=B1=
=D0=B0=D1=82=D1=8B=D0=B2=D0=B0=D0=B5=D1=82 =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=
=D0=B8=D0=BA=D1=82=D1=8B =D1=81 =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=
=B8=D0=B5=D0=BC =D0=B8=D0=BB=D0=B8 =D1=83=D1=87=D0=B0=D1=81=D1=82=D0=B8=
=D0=B5=D0=BC =D1=81=D1=81=D1=8B=D0=BB=D0=BE=D0=BA"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D1=81=D0=
=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F =D0=BD=D0=B5 =D0=BE=D0=B1=D1=80=D0=B0=
=D0=B1=D0=B0=D1=82=D1=8B=D0=B2=D0=B0=D0=B5=D1=82 =D0=BA=D0=BE=D0=BD=D1=84=
=D0=BB=D0=B8=D0=BA=D1=82=D1=8B =D1=81 =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=
=BD=D0=B8=D0=B5=D0=BC =D0=B8=D0=BB=D0=B8 =D1=83=D1=87=D0=B0=D1=81=D1=82=
=D0=B8=D0=B5=D0=BC =D1=81=D1=81=D1=8B=D0=BB=D0=BE=D0=BA"
=20
 #: lib/mergetool.tcl:146
 msgid "Conflict file does not exist"
@@ -1946,12 +1781,12 @@ msgstr "=D0=9A=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=
=BA=D1=82=D1=83=D1=8E=D1=89=D0=B8=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB =D0=BD=
=D0=B5 =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82"
 #: lib/mergetool.tcl:264
 #, tcl-format
 msgid "Not a GUI merge tool: '%s'"
-msgstr "'%s' =D0=BD=D0=B5 =D1=8F=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=D1=81=D1=
=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9 =D1=81=
=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F"
+msgstr "=C2=AB%s=C2=BB =D0=BD=D0=B5 =D1=8F=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=
=D1=81=D1=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9=
 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F"
=20
 #: lib/mergetool.tcl:268
 #, tcl-format
 msgid "Unsupported merge tool '%s'"
-msgstr "=D0=9D=D0=B5=D0=B8=D0=B7=D0=B2=D0=B5=D1=81=D1=82=D0=BD=D0=B0=D1=
=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D1=81=D0=BB=
=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F '%s'"
+msgstr "=D0=9D=D0=B5=D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D0=
=B2=D0=B0=D0=B5=D0=BC=D0=B0=D1=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=
=BC=D0=BC=D0=B0 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F =C2=AB%s=C2=BB=
"
=20
 #: lib/mergetool.tcl:303
 msgid "Merge tool is already running, terminate it?"
@@ -1962,9 +1797,7 @@ msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=
=D0=BC=D0=B0 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F =D1=83=D0=B6=D0=
=B5 =D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=B0=D0=B5=D1=82. =D0=9F=D1=80=D0=B5=
=D1=80=D0=B2=D0=B0
 msgid ""
 "Error retrieving versions:\n"
 "%s"
-msgstr ""
-"=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=
=B5=D0=BD=D0=B8=D1=8F =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D0=B9:\n"
-"%s"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=BF=D0=BE=D0=BB=D1=83=D1=
=87=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D0=B9:\n%s"
=20
 #: lib/mergetool.tcl:343
 #, tcl-format
@@ -1972,14 +1805,11 @@ msgid ""
 "Could not start the merge tool:\n"
 "\n"
 "%s"
-msgstr ""
-"=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B7=D0=B0=D0=BF=D1=83=D1=81=D0=
=BA=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=8B =D1=81=
=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F:\n"
-"\n"
-"%s"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B7=D0=B0=D0=BF=D1=83=D1=
=81=D0=BA=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=8B =
=D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F:\n\n%s"
=20
 #: lib/mergetool.tcl:347
 msgid "Running merge tool..."
-msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D0=BA =D0=BF=D1=80=D0=BE=D0=B3=D1=
=80=D0=B0=D0=BC=D0=BC=D1=8B =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F.=
=2E."
+msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D0=BA =D0=BF=D1=80=D0=BE=D0=B3=D1=
=80=D0=B0=D0=BC=D0=BC=D1=8B =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F=E2=
=80=A6"
=20
 #: lib/mergetool.tcl:375 lib/mergetool.tcl:383
 msgid "Merge tool failed."
@@ -1988,12 +1818,12 @@ msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=
=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D1=80=D0=
=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=8B =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=
=B8=D1=8F."
 #: lib/option.tcl:11
 #, tcl-format
 msgid "Invalid global encoding '%s'"
-msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2 =D0=B3=D0=BB=D0=BE=
=D0=B1=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B9 =D1=83=D1=81=D1=82=D0=B0=D0=BD=
=D0=BE=D0=B2=D0=BA=D0=B5 =D0=BA=D0=BE=D0=B4=D0=B8=D1=80=D0=BE=D0=B2=D0=BA=
=D0=B8 '%s'"
+msgstr "=D0=9D=D0=B5=D0=B2=D0=B5=D1=80=D0=BD=D0=B0=D1=8F =D0=B3=D0=BB=D0=
=BE=D0=B1=D0=B0=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=BA=D0=BE=D0=B4=D0=B8=D1=
=80=D0=BE=D0=B2=D0=BA=D0=B0 =C2=AB%s=C2=BB"
=20
 #: lib/option.tcl:19
 #, tcl-format
 msgid "Invalid repo encoding '%s'"
-msgstr "=D0=9D=D0=B5=D0=B2=D0=B5=D1=80=D0=BD=D0=B0=D1=8F =D0=BA=D0=BE=D0=
=B4=D0=B8=D1=80=D0=BE=D0=B2=D0=BA=D0=B0 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=
=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F: '%s'"
+msgstr "=D0=9D=D0=B5=D0=B2=D0=B5=D1=80=D0=BD=D0=B0=D1=8F =D0=BA=D0=BE=D0=
=B4=D0=B8=D1=80=D0=BE=D0=B2=D0=BA=D0=B0 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=
=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =C2=AB%s=C2=BB"
=20
 #: lib/option.tcl:117
 msgid "Restore Defaults"
@@ -2022,7 +1852,7 @@ msgstr "=D0=90=D0=B4=D1=80=D0=B5=D1=81 =D1=8D=D0=BB=
=D0=B5=D0=BA=D1=82=D1=80=D0=BE=D0=BD=D0=BD=D0=BE=D0=B9 =D0=BF=D0=BE=D1=87=
=D1=82=D1=8B"
=20
 #: lib/option.tcl:141
 msgid "Summarize Merge Commits"
-msgstr "=D0=A1=D1=83=D0=BC=D0=BC=D0=B0=D1=80=D0=BD=D1=8B=D0=B9 =D0=BA=D0=
=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=B9 =D0=BF=D1=80=D0=
=B8 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B8"
+msgstr "=D0=A1=D1=83=D0=BC=D0=BC=D0=B0=D1=80=D0=BD=D0=BE=D0=B5 =D1=81=D0=
=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BF=D1=80=D0=B8 =D1=81=
=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B8"
=20
 #: lib/option.tcl:142
 msgid "Merge Verbosity"
@@ -2042,11 +1872,11 @@ msgstr "=D0=94=D0=BE=D0=B2=D0=B5=D1=80=D1=8F=D1=
=82=D1=8C =D0=B2=D1=80=D0=B5=D0=BC=D0=B5=D0=BD=D0=B8 =D0=BC=D0=BE=D0=B4=
=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=86=D0=B8=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=
=D0=B0"
=20
 #: lib/option.tcl:147
 msgid "Prune Tracking Branches During Fetch"
-msgstr "=D0=A7=D0=B8=D1=81=D1=82=D0=BA=D0=B0 =D0=B2=D0=B5=D1=82=D0=B2=D0=
=B5=D0=B9 =D1=81=D0=BB=D0=B5=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D1=80=
=D0=B8 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B8 =D0=B8=D0=
=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9"
+msgstr "=D0=A7=D0=B8=D1=81=D1=82=D0=BA=D0=B0 =D0=BE=D1=82=D1=81=D0=BB=D0=
=B5=D0=B6=D0=B8=D0=B2=D0=B0=D0=B5=D0=BC=D1=8B=D1=85 =D0=B2=D0=B5=D1=82=D0=
=BE=D0=BA =D0=BF=D1=80=D0=B8 =D0=B8=D0=B7=D0=B2=D0=BB=D0=B5=D1=87=D0=B5=
=D0=BD=D0=B8=D0=B8 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9=
"
=20
 #: lib/option.tcl:148
 msgid "Match Tracking Branches"
-msgstr "=D0=98=D0=BC=D1=8F =D0=BD=D0=BE=D0=B2=D0=BE=D0=B9 =D0=B2=D0=B5=
=D1=82=D0=B2=D0=B8 =D0=B2=D0=B7=D1=8F=D1=82=D1=8C =D0=B8=D0=B7 =D0=B8=D0=
=BC=D0=B5=D0=BD =D0=B2=D0=B5=D1=82=D0=B2=D0=B5=D0=B9 =D1=81=D0=BB=D0=B5=
=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F"
+msgstr "=D0=A2=D0=B0=D0=BA=D0=BE=D0=B5 =D0=B6=D0=B5 =D0=B8=D0=BC=D1=8F=
, =D0=BA=D0=B0=D0=BA =D0=B8 =D1=83 =D0=BE=D1=82=D1=81=D0=BB=D0=B5=D0=B6=
=D0=B8=D0=B2=D0=B0=D0=B5=D0=BC=D0=BE=D0=B9 =D0=B2=D0=B5=D1=82=D0=BA=D0=B8=
"
=20
 #: lib/option.tcl:149
 msgid "Blame Copy Only On Changed Files"
@@ -2066,11 +1896,11 @@ msgstr "=D0=A7=D0=B8=D1=81=D0=BB=D0=BE =D1=81=D1=
=82=D1=80=D0=BE=D0=BA =D0=B2 =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=
=D1=82=D0=B5 diff"
=20
 #: lib/option.tcl:153
 msgid "Commit Message Text Width"
-msgstr "=D0=A8=D0=B8=D1=80=D0=B8=D0=BD=D0=B0 =D1=82=D0=B5=D0=BA=D1=81=D1=
=82=D0=B0 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D1=
=8F"
+msgstr "=D0=A8=D0=B8=D1=80=D0=B8=D0=BD=D0=B0 =D1=82=D0=B5=D0=BA=D1=81=D1=
=82=D0=B0 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D1=8F =D0=BA=
=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B0"
=20
 #: lib/option.tcl:154
 msgid "New Branch Name Template"
-msgstr "=D0=A8=D0=B0=D0=B1=D0=BB=D0=BE=D0=BD =D0=B4=D0=BB=D1=8F =D0=B8=
=D0=BC=D0=B5=D0=BD=D0=B8 =D0=BD=D0=BE=D0=B2=D0=BE=D0=B9 =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B8"
+msgstr "=D0=A8=D0=B0=D0=B1=D0=BB=D0=BE=D0=BD =D0=B4=D0=BB=D1=8F =D0=B8=
=D0=BC=D0=B5=D0=BD=D0=B8 =D0=BD=D0=BE=D0=B2=D0=BE=D0=B9 =D0=B2=D0=B5=D1=
=82=D0=BA=D0=B8"
=20
 #: lib/option.tcl:155
 msgid "Default File Contents Encoding"
@@ -2093,7 +1923,6 @@ msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=
=D1=8C"
 msgid "Choose %s"
 msgstr "=D0=92=D1=8B=D0=B1=D0=B5=D1=80=D0=B8=D1=82=D0=B5 %s"
=20
-# carbon copy
 #: lib/option.tcl:264
 msgid "pt."
 msgstr "pt."
@@ -2116,7 +1945,7 @@ msgstr "=D0=A7=D0=B8=D1=81=D1=82=D0=BA=D0=B0"
=20
 #: lib/remote.tcl:173
 msgid "Fetch from"
-msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B8=D0=
=B7"
+msgstr "=D0=98=D0=B7=D0=B2=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=B8=D0=B7"
=20
 #: lib/remote.tcl:215
 msgid "Push to"
@@ -2132,7 +1961,7 @@ msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=
=D1=8C =D0=B2=D0=BD=D0=B5=D1=88=D0=BD=D0=B8=D0=B9 =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9"
=20
 #: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
 msgid "Add"
-msgstr ""
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C"
=20
 #: lib/remote_add.tcl:37
 msgid "Remote Details"
@@ -2148,7 +1977,7 @@ msgstr "=D0=A1=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=
=D0=B0=D1=8F =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8F"
=20
 #: lib/remote_add.tcl:65
 msgid "Fetch Immediately"
-msgstr "=D0=A1=D0=BA=D0=B0=D1=87=D0=B0=D1=82=D1=8C =D1=81=D1=80=D0=B0=D0=
=B7=D1=83"
+msgstr "=D0=A1=D1=80=D0=B0=D0=B7=D1=83 =D0=B8=D0=B7=D0=B2=D0=BB=D0=B5=D1=
=87=D1=8C =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
 #: lib/remote_add.tcl:71
 msgid "Initialize Remote Repository and Push"
@@ -2165,27 +1994,27 @@ msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B8=D1=82=D0=
=B5 =D0=BD=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B2=D0=BD=D0=B5=
=D1=88=D0=BD=D0=B5=D0=B3=D0=BE =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=
=D0=BE=D1=80=D0=B8=D1=8F.
 #: lib/remote_add.tcl:114
 #, tcl-format
 msgid "'%s' is not an acceptable remote name."
-msgstr "=D0=9D=D0=B5=D0=B4=D0=BE=D0=BF=D1=83=D1=81=D1=82=D0=B8=D0=BC=D0=
=BE=D0=B5 =D0=BD=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B2=D0=BD=
=D0=B5=D1=88=D0=BD=D0=B5=D0=B3=D0=BE =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=
=D1=82=D0=BE=D1=80=D0=B8=D1=8F '%s'."
+msgstr "=C2=AB%s=C2=BB =D0=BD=D0=B5 =D1=8F=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=
=D1=81=D1=8F =D0=B4=D0=BE=D0=BF=D1=83=D1=81=D1=82=D0=B8=D0=BC=D1=8B=D0=BC=
 =D0=B8=D0=BC=D0=B5=D0=BD=D0=B5=D0=BC =D0=B2=D0=BD=D0=B5=D1=88=D0=BD=D0=
=B5=D0=B3=D0=BE =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=
=B8=D1=8F."
=20
 #: lib/remote_add.tcl:125
 #, tcl-format
 msgid "Failed to add remote '%s' of location '%s'."
-msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=B4=
=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C '%s' =D0=B8=D0=B7 '%s'. "
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=B4=
=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =C2=AB%s=C2=BB =D0=B8=D0=B7 =
=C2=AB%s=C2=BB. "
=20
 #: lib/remote_add.tcl:133 lib/transport.tcl:6
 #, tcl-format
 msgid "fetch %s"
-msgstr "=D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 %s"
+msgstr "=D0=B8=D0=B7=D0=B2=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 %=
s"
=20
 #: lib/remote_add.tcl:134
 #, tcl-format
 msgid "Fetching the %s"
-msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 %s"
+msgstr "=D0=98=D0=B7=D0=B2=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 %=
s"
=20
 #: lib/remote_add.tcl:157
 #, tcl-format
 msgid "Do not know how to initialize repository at location '%s'."
-msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=B8=D0=BD=D0=B8=D1=86=D0=B8=D0=B0=D0=BB=D0=B8=D0=B7=D0=B8=D1=80=D0=BE=D0=
=B2=D0=B0=D1=82=D1=8C =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=
=80=D0=B8=D0=B9 =D0=B2 '%s'."
+msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=B8=D0=BD=D0=B8=D1=86=D0=B8=D0=B0=D0=BB=D0=B8=D0=B7=D0=B8=D1=80=D0=BE=D0=
=B2=D0=B0=D1=82=D1=8C =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=
=80=D0=B8=D0=B9 =D0=B2 =C2=AB%s=C2=BB."
=20
 #: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
 #: lib/transport.tcl:81
@@ -2200,7 +2029,7 @@ msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=
=D0=BA=D0=B0 %s (=D0=B2 %s)"
=20
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
 msgid "Delete Branch Remotely"
-msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B8 =D0=B2=D0=BE =D0=B2=D0=BD=D0=B5=D1=88=D0=BD=D0=B5=D0=BC=
 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B8"
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B2=D0=B5=D1=
=82=D0=BA=D0=B8 =D0=B2=D0=BE =D0=B2=D0=BD=D0=B5=D1=88=D0=BD=D0=B5=D0=BC=
 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B8"
=20
 #: lib/remote_branch_delete.tcl:47
 msgid "From Repository"
@@ -2216,7 +2045,7 @@ msgstr "=D0=A3=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BD=
=D0=BE=D0=B5 =D0=BF=D0=BE=D0=BB=D0=BE=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5:"
=20
 #: lib/remote_branch_delete.tcl:84
 msgid "Branches"
-msgstr "=D0=92=D0=B5=D1=82=D0=B2=D0=B8"
+msgstr "=D0=92=D0=B5=D1=82=D0=BA=D0=B8"
=20
 #: lib/remote_branch_delete.tcl:109
 msgid "Delete Only If"
@@ -2228,7 +2057,7 @@ msgstr "=D0=A1=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5=
 =D1=81:"
=20
 #: lib/remote_branch_delete.tcl:152
 msgid "A branch is required for 'Merged Into'."
-msgstr "=D0=94=D0=BB=D1=8F =D0=BE=D0=BF=D1=86=D0=B8=D0=B8 '=D0=A1=D0=BB=
=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5 =D1=81' =D1=82=D1=80=D0=B5=D0=B1=D1=83=D0=
=B5=D1=82=D1=81=D1=8F =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B2=
=D0=B5=D1=82=D0=B2=D1=8C."
+msgstr "=D0=94=D0=BB=D1=8F =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=
=B8 =C2=AB=D0=A1=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5 =D1=81=C2=BB =D1=82=
=D1=80=D0=B5=D0=B1=D1=83=D0=B5=D1=82=D1=81=D1=8F =D1=83=D0=BA=D0=B0=D0=B7=
=D0=B0=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=BA=D1=83."
=20
 #: lib/remote_branch_delete.tcl:184
 #, tcl-format
@@ -2236,28 +2065,23 @@ msgid ""
 "The following branches are not completely merged into %s:\n"
 "\n"
 " - %s"
-msgstr ""
-"=D0=A1=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B8=D0=B5 =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B8 =D0=BC=D0=BE=D0=B3=D1=83=D1=82 =D0=B1=D1=8B=D1=82=D1=8C=
 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D1=8B =D1=81 %s=
 =D0=BF=D1=80=D0=B8 =D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D0=B8 =D0=BE=D0=BF=D0=
=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=
=8F:\n"
-"\n"
-" - %s"
+msgstr "=D0=A1=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B8=D0=B5 =D0=B2=D0=
=B5=D1=82=D0=BA=D0=B8 =D0=BC=D0=BE=D0=B3=D1=83=D1=82 =D0=B1=D1=8B=D1=82=
=D1=8C =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D1=8B =D1=
=81 %s =D0=BF=D1=80=D0=B8 =D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D0=B8 =D0=BE=D0=
=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=
=B8=D1=8F:\n\n - %s"
=20
 #: lib/remote_branch_delete.tcl:189
 #, tcl-format
 msgid ""
 "One or more of the merge tests failed because you have not fetched th=
e "
 "necessary commits.  Try fetching from %s first."
-msgstr ""
-"=D0=9D=D0=B5=D0=BA=D0=BE=D1=82=D0=BE=D1=80=D1=8B=D0=B5 =D1=82=D0=B5=D1=
=81=D1=82=D1=8B =D0=BD=D0=B0 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5=
 =D0=BD=D0=B5 =D0=BF=D1=80=D0=BE=D1=88=D0=BB=D0=B8, =D0=BF=D0=BE=D1=82=D0=
=BE=D0=BC=D1=83 =D1=87=D1=82=D0=BE =D0=92=D1=8B =D0=BD=D0=B5 =D0=BF=D0=BE=
=D0=BB=D1=83=D1=87=D0=B8=D0=BB=D0=B8 =D0=BD=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=
=D0=B4=D0=B8=D0=BC=D1=8B=D0=B5 "
-"=D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F. =D0=9F=D0=BE=D0=
=BF=D1=8B=D1=82=D0=B0=D0=B9=D1=82=D0=B5=D1=81=D1=8C =D0=BF=D0=BE=D0=BB=D1=
=83=D1=87=D0=B8=D1=82=D1=8C =D0=B8=D1=85 =D0=B8=D0=B7 %s."
+msgstr "=D0=9D=D0=B5=D0=BA=D0=BE=D1=82=D0=BE=D1=80=D1=8B=D0=B5 =D1=82=D0=
=B5=D1=81=D1=82=D1=8B =D0=BD=D0=B0 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=
=D0=B5 =D0=BD=D0=B5 =D0=BF=D1=80=D0=BE=D1=88=D0=BB=D0=B8, =D0=BF=D0=BE=D1=
=82=D0=BE=D0=BC=D1=83 =D1=87=D1=82=D0=BE =D0=B2=D1=8B =D0=BD=D0=B5 =D0=B8=
=D0=B7=D0=B2=D0=BB=D0=B5=D0=BA=D0=BB=D0=B8 =D0=BD=D0=B5=D0=BE=D0=B1=D1=85=
=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D0=B5 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=
=D1=8B. =D0=9F=D0=BE=D0=BF=D1=8B=D1=82=D0=B0=D0=B9=D1=82=D0=B5=D1=81=D1=
=8C =D0=B8=D0=B7=D0=B2=D0=BB=D0=B5=D1=87=D1=8C =D0=B8=D1=85 =D0=B8=D0=B7=
 %s."
=20
 #: lib/remote_branch_delete.tcl:207
 msgid "Please select one or more branches to delete."
-msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B8=D1=82=D0=B5 =D0=BE=D0=B4=D0=BD=D1=
=83 =D0=B8=D0=BB=D0=B8 =D0=BD=D0=B5=D1=81=D0=BA=D0=BE=D0=BB=D1=8C=D0=BA=
=D0=BE =D0=B2=D0=B5=D1=82=D0=B2=D0=B5=D0=B9 =D0=B4=D0=BB=D1=8F =D1=83=D0=
=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F."
+msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B8=D1=82=D0=B5 =D0=BE=D0=B4=D0=BD=D1=
=83 =D0=B8=D0=BB=D0=B8 =D0=BD=D0=B5=D1=81=D0=BA=D0=BE=D0=BB=D1=8C=D0=BA=
=D0=BE =D0=B2=D0=B5=D1=82=D0=BE=D0=BA =D0=B4=D0=BB=D1=8F =D1=83=D0=B4=D0=
=B0=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F."
=20
 #: lib/remote_branch_delete.tcl:226
 #, tcl-format
 msgid "Deleting branches from %s"
-msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B5=D0=B9 =D0=B8=D0=B7 %s"
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B2=D0=B5=D1=
=82=D0=BE=D0=BA =D0=B8=D0=B7 %s"
=20
 #: lib/remote_branch_delete.tcl:292
 msgid "No repository selected."
@@ -2266,7 +2090,7 @@ msgstr "=D0=9D=D0=B5 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=
=D0=BD =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9=
=2E"
 #: lib/remote_branch_delete.tcl:297
 #, tcl-format
 msgid "Scanning %s..."
-msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D1=8B=D0=B2=D0=B0=D0=
=BD=D0=B8=D0=B5 %s... "
+msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D1=8B=D0=B2=D0=B0=D0=
=BD=D0=B8=D0=B5 %s=E2=80=A6"
=20
 #: lib/search.tcl:21
 msgid "Find:"
@@ -2352,7 +2176,7 @@ msgstr "=D0=92=D0=B0=D1=88 =D0=BF=D1=83=D0=B1=D0=BB=
=D0=B8=D1=87=D0=BD=D1=8B=D0=B9 =D0=BA=D0=BB=D1=8E=D1=87 OpenSSH"
=20
 #: lib/sshkey.tcl:78
 msgid "Generating..."
-msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D0=B5..."
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D0=B5=E2=80=A6"
=20
 #: lib/sshkey.tcl:84
 #, tcl-format
@@ -2360,10 +2184,7 @@ msgid ""
 "Could not start ssh-keygen:\n"
 "\n"
 "%s"
-msgstr ""
-"=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B7=D0=B0=D0=BF=D1=83=D1=81=D0=
=BA=D0=B0 ssh-keygen:\n"
-"\n"
-"%s"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B7=D0=B0=D0=BF=D1=83=D1=
=81=D0=BA=D0=B0 ssh-keygen:\n\n%s"
=20
 #: lib/sshkey.tcl:111
 msgid "Generation failed."
@@ -2381,7 +2202,7 @@ msgstr "=D0=92=D0=B0=D1=88 =D0=BA=D0=BB=D1=8E=D1=87=
 =D0=BD=D0=B0=D1=85=D0=BE=D0=B4=D0=B8=D1=82=D1=81=D1=8F =D0=B2: %s"
 #: lib/status_bar.tcl:83
 #, tcl-format
 msgid "%s ... %*i of %*i %s (%3i%%)"
-msgstr "%s ... %*i =D0=B8=D0=B7 %*i %s (%3i%%)"
+msgstr "%s =E2=80=A6 %*i =D0=B8=D0=B7 %*i %s (%3i%%)"
=20
 #: lib/tools.tcl:75
 #, tcl-format
@@ -2431,7 +2252,7 @@ msgstr "=D0=9E=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=
=D0=B5 =D0=B2=D1=81=D0=BF=D0=BE=D0=BC=D0=BE=D0=B3=D0=B0=D1=82=D0=B5=D0=BB=
=D1=8C=D0=BD=D0=BE=D0=B9 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B8=
"
=20
 #: lib/tools_dlg.tcl:48
 msgid "Use '/' separators to create a submenu tree:"
-msgstr "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D1=83=D0=B9=D1=82=D0=
=B5 '/' =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D1=
=8F =D0=BF=D0=BE=D0=B4=D0=BC=D0=B5=D0=BD=D1=8E"
+msgstr "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D1=83=D0=B9=D1=82=D0=
=B5 =C2=AB/=C2=BB =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=
=D0=B8=D1=8F =D0=BF=D0=BE=D0=B4=D0=BC=D0=B5=D0=BD=D1=8E"
=20
 #: lib/tools_dlg.tcl:61
 msgid "Command:"
@@ -2464,16 +2285,14 @@ msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B8=D1=82=D0=
=B5 =D0=BD=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B2=D1=81=D0=BF=
=D0=BE=D0=BC=D0=BE=D0=B3=D0=B0=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE=D0=B9=
 =D0=BE=D0=BF=D0=B5=D1=80
 #: lib/tools_dlg.tcl:129
 #, tcl-format
 msgid "Tool '%s' already exists."
-msgstr "=D0=92=D1=81=D0=BF=D0=BE=D0=BC=D0=BE=D0=B3=D0=B0=D1=82=D0=B5=D0=
=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=
=8F '%s' =D1=83=D0=B6=D0=B5 =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=
=83=D0=B5=D1=82."
+msgstr "=D0=92=D1=81=D0=BF=D0=BE=D0=BC=D0=BE=D0=B3=D0=B0=D1=82=D0=B5=D0=
=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=
=8F =C2=AB%s=C2=BB =D1=83=D0=B6=D0=B5 =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=
=82=D0=B2=D1=83=D0=B5=D1=82."
=20
 #: lib/tools_dlg.tcl:151
 #, tcl-format
 msgid ""
 "Could not add tool:\n"
 "%s"
-msgstr ""
-"=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D0=
=BB=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=
=BC=D1=8B:\n"
-"%s"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B4=D0=BE=D0=B1=D0=B0=D0=
=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=
=BC=D0=BC=D1=8B:\n%s"
=20
 #: lib/tools_dlg.tcl:190
 msgid "Remove Tool"
@@ -2507,9 +2326,8 @@ msgstr "OK"
 #: lib/transport.tcl:7
 #, tcl-format
 msgid "Fetching new changes from %s"
-msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B8=D0=
=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=B8=D0=B7 %s "
+msgstr "=D0=98=D0=B7=D0=B2=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=B8=D0=B7 %s "
=20
-# carbon copy
 #: lib/transport.tcl:18
 #, tcl-format
 msgid "remote prune %s"
@@ -2518,7 +2336,7 @@ msgstr "=D1=87=D0=B8=D1=81=D1=82=D0=BA=D0=B0 =D0=B2=
=D0=BD=D0=B5=D1=88=D0=BD=D0=B5=D0=B3=D0=BE %s"
 #: lib/transport.tcl:19
 #, tcl-format
 msgid "Pruning tracking branches deleted from %s"
-msgstr "=D0=A7=D0=B8=D1=81=D1=82=D0=BA=D0=B0 =D0=B2=D0=B5=D1=82=D0=B2=D0=
=B5=D0=B9 =D1=81=D0=BB=D0=B5=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F, =D1=83=D0=B4=
=D0=B0=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D1=85 =D0=B8=D0=B7 %s"
+msgstr "=D0=A7=D0=B8=D1=81=D1=82=D0=BA=D0=B0 =D0=BE=D1=82=D1=81=D0=BB=D0=
=B5=D0=B6=D0=B8=D0=B2=D0=B0=D0=B5=D0=BC=D1=8B=D1=85 =D0=B2=D0=B5=D1=82=D0=
=BE=D0=BA, =D1=83=D0=B4=D0=B0=D0=BB=D1=91=D0=BD=D0=BD=D1=8B=D1=85 =D0=B8=
=D0=B7 %s"
=20
 #: lib/transport.tcl:26
 #, tcl-format
@@ -2537,11 +2355,11 @@ msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=
=BA=D0=B0 %s %s =D0=B2 %s"
=20
 #: lib/transport.tcl:100
 msgid "Push Branches"
-msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=B8=D0=
=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 =D0=B2=D0=B5=D1=82=
=D0=B2=D1=8F=D1=85"
+msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=B2=D0=
=B5=D1=82=D0=BA=D0=B8"
=20
 #: lib/transport.tcl:114
 msgid "Source Branches"
-msgstr "=D0=98=D1=81=D1=85=D0=BE=D0=B4=D0=BD=D1=8B=D0=B5 =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B8"
+msgstr "=D0=98=D1=81=D1=85=D0=BE=D0=B4=D0=BD=D1=8B=D0=B5 =D0=B2=D0=B5=D1=
=82=D0=BA=D0=B8"
=20
 #: lib/transport.tcl:131
 msgid "Destination Repository"
@@ -2553,7 +2371,7 @@ msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=
=D0=BA=D0=B8 =D0=BE=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BA=D0=B8"
=20
 #: lib/transport.tcl:171
 msgid "Force overwrite existing branch (may discard changes)"
-msgstr "=D0=9D=D0=B0=D0=BC=D0=B5=D1=80=D0=B5=D0=BD=D0=BD=D0=BE =D0=BF=D0=
=B5=D1=80=D0=B5=D0=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C =D1=81=D1=83=D1=89=D0=
=B5=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=89=D1=83=D1=8E =D0=B2=D0=B5=D1=82=D0=
=B2=D1=8C (=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=B0 =D0=BF=D0=BE=
=D1=82=D0=B5=D1=80=D1=8F =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=
=D0=B9)"
+msgstr "=D0=9F=D1=80=D0=B8=D0=BD=D1=83=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=
=8C=D0=BD=D0=BE =D0=BF=D0=B5=D1=80=D0=B5=D0=B7=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D1=82=D1=8C =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=
=89=D1=83=D1=8E =D0=B2=D0=B5=D1=82=D0=BA=D1=83 (=D0=B2=D0=BE=D0=B7=D0=BC=
=D0=BE=D0=B6=D0=BD=D0=B0 =D0=BF=D0=BE=D1=82=D0=B5=D1=80=D1=8F =D0=B8=D0=
=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9)"
=20
 #: lib/transport.tcl:175
 msgid "Use thin pack (for slow network connections)"
--=20
2.6.0
