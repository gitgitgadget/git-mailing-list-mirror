From: miurahr@linux.com
Subject: [PATCH] gitk: Update Japanese translation
Date: Fri,  6 Nov 2015 23:32:42 +0900
Message-ID: <1446820362-5003-1-git-send-email-miurahr@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mizar.jp@gmail.com, paulus@samba.org,
	Hiroshi Miura <miurahr@linux.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 15:40:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuiBb-0001L9-OR
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 15:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932962AbbKFOkE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Nov 2015 09:40:04 -0500
Received: from nm33-vm8.bullet.mail.bf1.yahoo.com ([72.30.238.198]:60171 "EHLO
	nm33-vm8.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751734AbbKFOkD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2015 09:40:03 -0500
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2015 09:40:02 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1446820393; bh=K2d6YyLA5apW/N58AlGteLZ6Cshb9IEzLcsxQyytfFM=; h=From:To:Cc:Subject:Date:From:Subject; b=YXUXc8vCb8uUWSKcY5pHtrPiy7ukhAbpeZeahlg+iQwUZwfgnP0Lsu08R+CgKMlJPeh3ooZ6y6zAh2m2jaGQVWZQZjSm5gfdG5/COZLcDt7AJo/4Qy1ixx5M1cLAMgUwobxaBcbKczPgaIhVfqgiArKLOLlZW1PMXBmQ+0LRVTsVdg/lQSOoqQWcRfstr3lJLJsuPl9/wq8sCQTUmMOnNTM3BWjXVkFtfnkYOZ7onPVRgzEaph2SBBNgEN1Z/KtW09sxCV0IegBMEPxyxPuflVzocJCWmaDpXlkDTtCADCKVv9DRC+jt6wQO0XwutiiC0tuMBGQ8yRy6hf2DjoK74Q==
Received: from [98.139.170.181] by nm33.bullet.mail.bf1.yahoo.com with NNFMP; 06 Nov 2015 14:33:13 -0000
Received: from [98.139.211.203] by tm24.bullet.mail.bf1.yahoo.com with NNFMP; 06 Nov 2015 14:33:13 -0000
Received: from [127.0.0.1] by smtp212.mail.bf1.yahoo.com with NNFMP; 06 Nov 2015 14:33:13 -0000
X-Yahoo-Newman-Id: 839331.59306.bm@smtp212.mail.bf1.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: aGqu1XoVM1kEooTSkX7.j4ibBA7CSqZkJz.ToKuzGIshsbQ
 1aYA5UefHAxfsnrJvyRaK74eDHymflptgWVlYOlfqCh1yDCxN4peJvazwVN6
 M0LCwLnb51.VBku0R3F8zOAo1se0MVVj3ymSAxSBqlhNlwxknbLkazbXNRy3
 wb_efcIkmE134A6gnQdTZZzZuV_6fpIv.k6cUHuwqqHuJoYQXJirxBo2IZYQ
 PyuMTMS9nCV3lsd_7MQXyoq4_7mLYlf5dq.LlUtkh2KXmSzBIonw8jwZPLWQ
 Oj36Gitc0Qevi4VB4J550UYY42bJ9bQxuqkO.KyhuSwl86KVZ2s2W9j6YhWT
 exC5vuJ5kWR2HjYSZh0qtcu5HRYXKXaeFe82xUZvBfAzyoxIXwXcGlaPcBkK
 ieTxB5P8Mqd1J741fNjOXkYMCrXOXPocbpdqUdq4JcTPA5w.Sb50kaSCv0HL
 p7GObC.z9ijqtmpZmPzAf__zl_CvnnidGOl62lAsDoy14WAX7NGRNQxh56Yf
 uUHscTl6htF69dfNacr7KcHNEK8ofECFGqHZ0tXpFsGy7qT0jrX1bidGF
X-Yahoo-SMTP: TFiWS.GswBDcwJZc5VAEj6aHk.w-
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280987>

=46rom: Hiroshi Miura <miurahr@linux.com>

- Update untranslated terms in gitk in Japanese

Signed-off-by: Hiroshi Miura <miurahr@linux.com>
---
 gitk-git/po/ja.po | 119 ++++++++++++++++++++++++----------------------=
--------
 1 file changed, 53 insertions(+), 66 deletions(-)

diff --git a/gitk-git/po/ja.po b/gitk-git/po/ja.po
index 59e42a8..6d55bca 100644
--- a/gitk-git/po/ja.po
+++ b/gitk-git/po/ja.po
@@ -9,26 +9,27 @@ msgstr ""
 "Project-Id-Version: gitk\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2015-05-17 14:32+1000\n"
-"PO-Revision-Date: 2009-11-06 01:45+0900\n"
-"Last-Translator: Mizar <mizar.jp@gmail.com>\n"
+"PO-Revision-Date: 2015-11-04 08:47+0900\n"
+"Last-Translator: Hiroshi Miura <miurahr@linux.com>\n"
 "Language-Team: Japanese\n"
-"Language: \n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
 "Plural-Forms: nplurals=3D1; plural=3D0;\n"
+"X-Generator: Poedit 1.5.4\n"
+"Language: ja\n"
=20
 #: gitk:140
 msgid "Couldn't get list of unmerged files:"
-msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=
=E3=81=AA=E3=81=84=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=81=AE=E3=83=AA=
=E3=82=B9=E3=83=88=E3=82=92=E5=8F=96=E5=BE=97=E3=81=A7=E3=81=8D=E3=81=BE=
=E3=81=9B=E3=82=93:"
+msgstr "=E6=9C=AA=E3=83=9E=E3=83=BC=E3=82=B8=E3=81=AE=E3=83=95=E3=82=A1=
=E3=82=A4=E3=83=AB=E4=B8=80=E8=A6=A7=E3=82=92=E5=8F=96=E5=BE=97=E3=81=A7=
=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93:"
=20
 #: gitk:212 gitk:2381
 msgid "Color words"
-msgstr ""
+msgstr "=E5=B7=AE=E5=88=86=E5=8D=98=E8=AA=9E=E3=81=AB=E7=9D=80=E8=89=B2=
"
=20
 #: gitk:217 gitk:2381 gitk:8220 gitk:8253
 msgid "Markup words"
-msgstr ""
+msgstr "=E5=B7=AE=E5=88=86=E5=8D=98=E8=AA=9E=E3=82=92=E3=83=9E=E3=83=BC=
=E3=82=AF"
=20
 #: gitk:324
 msgid "Error parsing revisions:"
@@ -176,11 +177,11 @@ msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88"
 #: gitk:2299 gitk:2301 gitk:4687 gitk:4710 gitk:4734 gitk:6755 gitk:68=
27
 #: gitk:6912
 msgid "containing:"
-msgstr "=E5=90=AB=E3=82=80:"
+msgstr "=E6=96=87=E5=AD=97=E3=82=92=E5=90=AB=E3=82=80:"
=20
 #: gitk:2302 gitk:3526 gitk:3531 gitk:4763
 msgid "touching paths:"
-msgstr "=E3=83=91=E3=82=B9=E3=81=AE=E4=B8=80=E9=83=A8:"
+msgstr "=E3=83=91=E3=82=B9=E3=81=AB=E5=90=AB=E3=82=80:"
=20
 #: gitk:2303 gitk:4777
 msgid "adding/removing string:"
@@ -188,15 +189,15 @@ msgstr "=E8=BF=BD=E5=8A=A0/=E9=99=A4=E5=8E=BB=E3=81=
=99=E3=82=8B=E6=96=87=E5=AD=97=E5=88=97:"
=20
 #: gitk:2304 gitk:4779
 msgid "changing lines matching:"
-msgstr ""
+msgstr "=E5=A4=89=E6=9B=B4=E8=A1=8C=E3=81=8C=E5=90=AB=E3=82=80=EF=BC=9A=
"
=20
 #: gitk:2313 gitk:2315 gitk:4766
 msgid "Exact"
-msgstr "=E8=8B=B1=E5=AD=97=E3=81=AE=E5=A4=A7=E5=B0=8F=E3=82=92=E5=8C=BA=
=E5=88=A5=E3=81=99=E3=82=8B"
+msgstr "=E5=A4=A7=E5=B0=8F=E6=96=87=E5=AD=97=E3=82=92=E5=8C=BA=E5=88=A5=
"
=20
 #: gitk:2315 gitk:4854 gitk:6723
 msgid "IgnCase"
-msgstr "=E8=8B=B1=E5=AD=97=E3=81=AE=E5=A4=A7=E5=B0=8F=E3=82=92=E5=8C=BA=
=E5=88=A5=E3=81=97=E3=81=AA=E3=81=84"
+msgstr "=E5=A4=A7=E5=B0=8F=E6=96=87=E5=AD=97=E3=82=92=E5=90=8C=E4=B8=80=
=E8=A6=96"
=20
 #: gitk:2315 gitk:4736 gitk:4852 gitk:6719
 msgid "Regexp"
@@ -204,7 +205,7 @@ msgstr "=E6=AD=A3=E8=A6=8F=E8=A1=A8=E7=8F=BE"
=20
 #: gitk:2317 gitk:2318 gitk:4874 gitk:4904 gitk:4911 gitk:6848 gitk:69=
16
 msgid "All fields"
-msgstr "=E5=85=A8=E3=81=A6=E3=81=AE=E9=A0=85=E7=9B=AE"
+msgstr "=E5=85=A8=E9=A0=85=E7=9B=AE"
=20
 #: gitk:2318 gitk:4871 gitk:4904 gitk:6786
 msgid "Headline"
@@ -249,7 +250,7 @@ msgstr "=E7=A9=BA=E7=99=BD=E3=81=AE=E9=81=95=E3=81=84=
=E3=82=92=E7=84=A1=E8=A6=96"
=20
 #: gitk:2378 gitk:2380 gitk:7959 gitk:8206
 msgid "Line diff"
-msgstr ""
+msgstr "=E8=A1=8C=E5=B7=AE=E5=88=86=E8=A1=A8=E7=A4=BA"
=20
 #: gitk:2445
 msgid "Patch"
@@ -269,7 +270,7 @@ msgstr "=E9=81=B8=E6=8A=9E=E3=81=97=E3=81=9F=E3=82=B3=
=E3=83=9F=E3=83=83=E3=83=88=E3=81=A8=E3=81=93=E3=82=8C=E3=81=AEdiff=E3=82=
=92=E8=A6=8B=E3=82=8B"
=20
 #: gitk:2619 gitk:2639
 msgid "Make patch"
-msgstr "=E3=83=91=E3=83=83=E3=83=81=E4=BD=9C=E6=88=90"
+msgstr "=E3=83=91=E3=83=83=E3=83=81=E3=82=92=E4=BD=9C=E6=88=90"
=20
 #: gitk:2620 gitk:9254
 msgid "Create tag"
@@ -301,26 +302,23 @@ msgstr "=E3=83=9E=E3=83=BC=E3=82=AF=E3=82=92=E4=BB=
=98=E3=81=91=E3=81=9F=E6=89=80=E3=81=AB=E6=88=BB=E3=82=8B"
=20
 #: gitk:2627
 msgid "Find descendant of this and mark"
-msgstr "=E3=81=93=E3=82=8C=E3=81=A8=E3=83=9E=E3=83=BC=E3=82=AF=E3=82=92=
=E3=81=A4=E3=81=91=E3=81=9F=E6=89=80=E3=81=A8=E3=81=AE=E5=AD=90=E5=AD=AB=
=E3=82=92=E8=A6=8B=E3=81=A4=E3=81=91=E3=82=8B"
+msgstr "=E3=81=93=E3=82=8C=E3=81=A8=E3=83=9E=E3=83=BC=E3=82=AF=E3=82=92=
=E4=BB=98=E3=81=91=E3=81=9F=E6=89=80=E3=81=A8=E3=81=AE=E5=AD=90=E5=AD=AB=
=E3=82=92=E8=A6=8B=E3=81=A4=E3=81=91=E3=82=8B"
=20
 #: gitk:2628
 msgid "Compare with marked commit"
 msgstr "=E3=83=9E=E3=83=BC=E3=82=AF=E3=82=92=E4=BB=98=E3=81=91=E3=81=9F=
=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=A8=E6=AF=94=E8=BC=83=E3=81=99=
=E3=82=8B"
=20
 #: gitk:2629 gitk:2640
-#, fuzzy
 msgid "Diff this -> marked commit"
-msgstr "=E3=81=93=E3=82=8C=E3=81=A8=E9=81=B8=E6=8A=9E=E3=81=97=E3=81=9F=
=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=AEdiff=E3=82=92=E8=A6=8B=E3=82=
=8B"
+msgstr "=E3=81=93=E3=82=8C->=E3=83=9E=E3=83=BC=E3=82=AF=E3=81=97=E3=81=
=9F=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=AEdiff"
=20
 #: gitk:2630 gitk:2641
-#, fuzzy
 msgid "Diff marked commit -> this"
-msgstr "=E9=81=B8=E6=8A=9E=E3=81=97=E3=81=9F=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E3=81=A8=E3=81=93=E3=82=8C=E3=81=AEdiff=E3=82=92=E8=A6=8B=E3=82=
=8B"
+msgstr "=E3=83=9E=E3=83=BC=E3=82=AF=E3=81=97=E3=81=9F=E3=82=B3=E3=83=9F=
=E3=83=83=E3=83=88->=E3=81=93=E3=82=8C=E3=81=AEdiff"
=20
 #: gitk:2631
-#, fuzzy
 msgid "Revert this commit"
-msgstr "=E3=81=93=E3=81=AE=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=AB=
=E3=83=9E=E3=83=BC=E3=82=AF=E3=82=92=E3=81=A4=E3=81=91=E3=82=8B"
+msgstr "=E3=81=93=E3=81=AE=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=82=92=
=E3=83=AA=E3=83=90=E3=83=BC=E3=83=88=E3=81=99=E3=82=8B"
=20
 #: gitk:2647
 msgid "Check out this branch"
@@ -332,7 +330,7 @@ msgstr "=E3=81=93=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=
=E3=83=81=E3=82=92=E9=99=A4=E5=8E=BB=E3=81=99=E3=82=8B"
=20
 #: gitk:2649
 msgid "Copy branch name"
-msgstr ""
+msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E5=90=8D=E3=82=92=E3=82=B3=
=E3=83=94=E3=83=BC=E3=81=99=E3=82=8B"
=20
 #: gitk:2656
 msgid "Highlight this too"
@@ -352,7 +350,7 @@ msgstr "=E8=A6=AA=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=
=E3=81=8B=E3=82=89 blame =E3=82=92=E3=81=8B=E3=81=91=E3=82=8B"
=20
 #: gitk:2660
 msgid "Copy path"
-msgstr ""
+msgstr "=E3=83=91=E3=82=B9=E3=82=92=E3=82=B3=E3=83=94=E3=83=BC"
=20
 #: gitk:2667
 msgid "Show origin of this line"
@@ -363,7 +361,6 @@ msgid "Run git gui blame on this line"
 msgstr "=E3=81=93=E3=81=AE=E8=A1=8C=E3=81=AB git gui =E3=81=A7 blame =E3=
=82=92=E3=81=8B=E3=81=91=E3=82=8B"
=20
 #: gitk:3014
-#, fuzzy
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
@@ -375,7 +372,7 @@ msgstr ""
 "\n"
 "Gitk - git=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=83=93=E3=83=A5=E3=83=
=BC=E3=82=A2\n"
 "\n"
-"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
+"Copyright =C2=A9 2005-2014 Paul Mackerras\n"
 "\n"
 "=E4=BD=BF=E7=94=A8=E3=81=8A=E3=82=88=E3=81=B3=E5=86=8D=E9=85=8D=E5=B8=
=83=E3=81=AF GNU General Public License =E3=81=AB=E5=BE=93=E3=81=A3=E3=81=
=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84"
=20
@@ -397,9 +394,9 @@ msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\t=E7=B5=82=E4=BA=86"
=20
 #: gitk:3049
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "<%s-W>\t\tClose window"
-msgstr "<%s-F>\t\t=E6=A4=9C=E7=B4=A2"
+msgstr "<%s-W>\t\t=E3=82=A6=E3=82=A4=E3=83=B3=E3=83=89=E3=82=A6=E3=82=92=
=E9=96=89=E3=81=98=E3=82=8B"
=20
 #: gitk:3050
 msgid "<Home>\t\tMove to first commit"
@@ -410,19 +407,16 @@ msgid "<End>\t\tMove to last commit"
 msgstr "<End>\t\t=E6=9C=80=E5=BE=8C=E3=81=AE=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E3=81=AB=E7=A7=BB=E5=8B=95"
=20
 #: gitk:3052
-#, fuzzy
 msgid "<Up>, p, k\tMove up one commit"
-msgstr "<Up>, p, i\t=E4=B8=80=E3=81=A4=E4=B8=8A=E3=81=AE=E3=82=B3=E3=83=
=9F=E3=83=83=E3=83=88=E3=81=AB=E7=A7=BB=E5=8B=95"
+msgstr "<Up>, p, k\t=E4=B8=80=E3=81=A4=E4=B8=8A=E3=81=AE=E3=82=B3=E3=83=
=9F=E3=83=83=E3=83=88=E3=81=AB=E7=A7=BB=E5=8B=95"
=20
 #: gitk:3053
-#, fuzzy
 msgid "<Down>, n, j\tMove down one commit"
-msgstr "<Down>, n, k\t=E4=B8=80=E3=81=A4=E4=B8=8B=E3=81=AE=E3=82=B3=E3=
=83=9F=E3=83=83=E3=83=88=E3=81=AB=E7=A7=BB=E5=8B=95"
+msgstr "<Down>, n, j\t=E4=B8=80=E3=81=A4=E4=B8=8B=E3=81=AE=E3=82=B3=E3=
=83=9F=E3=83=83=E3=83=88=E3=81=AB=E7=A7=BB=E5=8B=95"
=20
 #: gitk:3054
-#, fuzzy
 msgid "<Left>, z, h\tGo back in history list"
-msgstr "<Left>, z, j\t=E5=B1=A5=E6=AD=B4=E3=81=AE=E5=89=8D=E3=81=AB=E6=
=88=BB=E3=82=8B"
+msgstr "<Left>, z, h\t=E5=B1=A5=E6=AD=B4=E3=81=AE=E5=89=8D=E3=81=AB=E6=
=88=BB=E3=82=8B"
=20
 #: gitk:3055
 msgid "<Right>, x, l\tGo forward in history list"
@@ -431,7 +425,7 @@ msgstr "<Right>, x, l\t=E5=B1=A5=E6=AD=B4=E3=81=AE=E6=
=AC=A1=E3=81=B8=E9=80=B2=E3=82=80"
 #: gitk:3056
 #, tcl-format
 msgid "<%s-n>\tGo to n-th parent of current commit in history list"
-msgstr ""
+msgstr "<%s-n>\t=E3=83=92=E3=82=B9=E3=83=88=E3=83=AA=E3=81=AE=E7=8F=BE=
=E5=9C=A8=E3=81=8B=E3=82=89n=E7=95=AA=E7=9B=AE=E3=81=AE=E8=A6=AA=E3=82=B3=
=E3=83=9F=E3=83=83=E3=83=88=E3=81=B8=E7=A7=BB=E5=8B=95=E3=81=99=E3=82=8B=
"
=20
 #: gitk:3057
 msgid "<PageUp>\tMove up one page in commit list"
@@ -514,9 +508,8 @@ msgid "<Return>\tMove to next find hit"
 msgstr "<Return>\t=E6=AC=A1=E3=82=92=E6=A4=9C=E7=B4=A2=E3=81=97=E3=81=A6=
=E7=A7=BB=E5=8B=95"
=20
 #: gitk:3075
-#, fuzzy
 msgid "g\t\tGo to commit"
-msgstr "<End>\t\t=E6=9C=80=E5=BE=8C=E3=81=AE=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E3=81=AB=E7=A7=BB=E5=8B=95"
+msgstr "g\t\t=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=AB=E7=A7=BB=E5=
=8B=95"
=20
 #: gitk:3076
 msgid "/\t\tFocus the search box"
@@ -672,9 +665,8 @@ msgid "Matches all Commit Info criteria"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E6=83=85=E5=A0=B1=E3=81=AE=
=E5=85=A8=E3=81=A6=E3=81=AE=E6=9D=A1=E4=BB=B6=E3=81=AB=E4=B8=80=E8=87=B4=
"
=20
 #: gitk:4086
-#, fuzzy
 msgid "Matches no Commit Info criteria"
-msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E6=83=85=E5=A0=B1=E3=81=AE=
=E5=85=A8=E3=81=A6=E3=81=AE=E6=9D=A1=E4=BB=B6=E3=81=AB=E4=B8=80=E8=87=B4=
"
+msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E6=83=85=E5=A0=B1=E3=81=AB=
=E4=B8=80=E8=87=B4=E3=81=97=E3=81=BE=E3=81=9B=E3=82=93"
=20
 #: gitk:4087
 msgid "Changes to Files:"
@@ -761,9 +753,8 @@ msgid "-- criteria for selecting revisions"
 msgstr "=E2=80=95 =E3=83=AA=E3=83=93=E3=82=B8=E3=83=A7=E3=83=B3=E3=81=AE=
=E9=81=B8=E6=8A=9E=E6=9D=A1=E4=BB=B6"
=20
 #: gitk:4241
-#, fuzzy
 msgid "View Name"
-msgstr "=E3=83=93=E3=83=A5=E3=83=BC=E5=90=8D:"
+msgstr "=E3=83=93=E3=83=A5=E3=83=BC=E5=90=8D"
=20
 #: gitk:4316
 msgid "Apply (F5)"
@@ -803,7 +794,7 @@ msgstr "=E3=82=B9=E3=83=86=E3=83=BC=E3=82=B8=E3=81=95=
=E3=82=8C=E3=81=A6=E3=81=84=E3=81=AA=E3=81=84=E3=80=81=E3=82=B3=E3=83=9F=
=E3=83=83=E3=83=88=E5=89=8D=E3=81=AE=E3=83=AD=E3=83=BC=E3=82=AB=E3=83=AB=
=E3=81=AA=E5=A4=89=E6=9B=B4
=20
 #: gitk:7134
 msgid "and many more"
-msgstr ""
+msgstr "=E3=81=9D=E3=81=AE=E4=BB=96=E3=82=AA=E3=83=97=E3=82=B7=E3=83=A7=
=E3=83=B3"
=20
 #: gitk:7137
 msgid "many"
@@ -984,12 +975,11 @@ msgstr "=E3=82=BF=E3=82=B0=E5=90=8D:"
=20
 #: gitk:9268
 msgid "Tag message is optional"
-msgstr ""
+msgstr "=E3=82=BF=E3=82=B0=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC=E3=82=B8=
=E3=81=AF=E4=BB=BB=E6=84=8F=E3=81=A7=E3=81=99"
=20
 #: gitk:9270
-#, fuzzy
 msgid "Tag message:"
-msgstr "=E3=82=BF=E3=82=B0=E5=90=8D:"
+msgstr "=E3=82=BF=E3=82=B0=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC=E3=82=B8=
=EF=BC=9A"
=20
 #: gitk:9274 gitk:9439
 msgid "Create"
@@ -1066,33 +1056,32 @@ msgid "No changes committed"
 msgstr "=E4=BD=95=E3=81=AE=E5=A4=89=E6=9B=B4=E3=82=82=E3=82=B3=E3=83=9F=
=E3=83=83=E3=83=88=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=81=BE=E3=81=9B=
=E3=82=93"
=20
 #: gitk:9593
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Commit %s is not included in branch %s -- really revert it?"
 msgstr ""
-"=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88 %s =E3=81=AF=E6=97=A2=E3=81=AB=E3=
=83=96=E3=83=A9=E3=83=B3=E3=83=81 %s =E3=81=AB=E5=90=AB=E3=81=BE=E3=82=8C=
=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99 =E2=80=95 =E6=9C=AC=E5=BD=93=E3=81=
=AB=E3=81=93=E3=82=8C=E3=82=92=E5=86=8D=E9=81=A9=E7=94=A8=E3=81=97=E3=81=
=BE=E3=81=99=E3=81=8B=EF=BC=9F"
+"=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88 %s =E3=81=AF=E6=97=A2=E3=81=AB=E3=
=83=96=E3=83=A9=E3=83=B3=E3=83=81 %s =E3=81=AB=E5=90=AB=E3=81=BE=E3=82=8C=
=E3=81=A6=E3=81=84=E3=81=BE=E3=81=9B=E3=82=93 =E2=80=95 =E6=9C=AC=E5=BD=
=93=E3=81=AB=E3=81=93=E3=82=8C=E3=82=92=E3=83=AA=E3=83=90=E3=83=BC=E3=83=
=88=E3=81=97=E3=81=BE=E3=81=99"
+"=E3=81=8B=EF=BC=9F"
=20
 #: gitk:9598
-#, fuzzy
 msgid "Reverting"
-msgstr "=E3=83=AA=E3=82=BB=E3=83=83=E3=83=88=E4=B8=AD"
+msgstr "=E3=83=AA=E3=83=90=E3=83=BC=E3=83=88=E4=B8=AD"
=20
 #: gitk:9606
-#, fuzzy, tcl-format
+#, tcl-format
 msgid ""
 "Revert failed because of local changes to the following files:%s Plea=
se "
 "commit, reset or stash  your changes and try again."
 msgstr ""
-"=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB '%s' =E3=81=AE=E3=83=AD=E3=83=BC=
=E3=82=AB=E3=83=AB=E3=81=AA=E5=A4=89=E6=9B=B4=E3=81=AE=E3=81=9F=E3=82=81=
=E3=81=AB=E3=83=81=E3=82=A7=E3=83=AA=E3=83=BC=E3=83=94=E3=83=83=E3=82=AF=
=E3=81=AF=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F=E3=80=82=
\n"
+"=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB '%s' =E3=81=AE=E3=83=AD=E3=83=BC=
=E3=82=AB=E3=83=AB=E3=81=AA=E5=A4=89=E6=9B=B4=E3=81=AE=E3=81=9F=E3=82=81=
=E3=81=AB=E3=83=AA=E3=83=90=E3=83=BC=E3=83=88=E3=81=AF=E5=A4=B1=E6=95=97=
=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F=E3=80=82\n"
 "=E3=81=82=E3=81=AA=E3=81=9F=E3=81=AE=E5=A4=89=E6=9B=B4=E3=81=AB commi=
t, reset, stash =E3=81=AE=E3=81=84=E3=81=9A=E3=82=8C=E3=81=8B=E3=82=92=E8=
=A1=8C=E3=81=A3=E3=81=A6=E3=81=8B=E3=82=89=E3=82=84=E3=82=8A=E7=9B=B4=E3=
=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95"
 "=E3=81=84=E3=80=82"
=20
 #: gitk:9610
-#, fuzzy
 msgid ""
 "Revert failed because of merge conflict.\n"
 " Do you wish to run git citool to resolve it?"
 msgstr ""
-"=E3=83=9E=E3=83=BC=E3=82=B8=E3=81=AE=E8=A1=9D=E7=AA=81=E3=81=AB=E3=82=
=88=E3=81=A3=E3=81=A6=E3=83=81=E3=82=A7=E3=83=AA=E3=83=BC=E3=83=94=E3=83=
=83=E3=82=AF=E3=81=AF=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=97=E3=81=
=9F=E3=80=82\n"
+"=E3=83=9E=E3=83=BC=E3=82=B8=E3=81=AE=E8=A1=9D=E7=AA=81=E3=81=AB=E3=82=
=88=E3=81=A3=E3=81=A6=E3=83=AA=E3=83=90=E3=83=BC=E3=83=88=E3=81=AF=E5=A4=
=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F=E3=80=82\n"
 "=E3=81=93=E3=81=AE=E8=A7=A3=E6=B1=BA=E3=81=AE=E3=81=9F=E3=82=81=E3=81=
=AB git citool =E3=82=92=E5=AE=9F=E8=A1=8C=E3=81=97=E3=81=9F=E3=81=84=E3=
=81=A7=E3=81=99=E3=81=8B=EF=BC=9F"
=20
 #: gitk:9653
@@ -1200,9 +1189,8 @@ msgid "Show local changes"
 msgstr "=E3=83=AD=E3=83=BC=E3=82=AB=E3=83=AB=E3=81=AA=E5=A4=89=E6=9B=B4=
=E3=82=92=E8=A1=A8=E7=A4=BA"
=20
 #: gitk:11361
-#, fuzzy
 msgid "Auto-select SHA1 (length)"
-msgstr "SHA1 =E3=81=AE=E8=87=AA=E5=8B=95=E9=81=B8=E6=8A=9E"
+msgstr "SHA1(l=E9=8D=B5=E9=95=B7)=E3=81=AE=E8=87=AA=E5=8B=95=E9=81=B8=E6=
=8A=9E"
=20
 #: gitk:11365
 msgid "Hide remote refs"
@@ -1217,13 +1205,12 @@ msgid "Tab spacing"
 msgstr "=E3=82=BF=E3=83=96=E7=A9=BA=E7=99=BD=E5=B9=85"
=20
 #: gitk:11374
-#, fuzzy
 msgid "Display nearby tags/heads"
-msgstr "=E8=BF=91=E3=81=8F=E3=81=AE=E3=82=BF=E3=82=B0=E3=82=92=E8=A1=A8=
=E7=A4=BA=E3=81=99=E3=82=8B"
+msgstr "=E8=BF=91=E3=81=8F=E3=81=AE=E3=82=BF=E3=82=B0/head=E3=82=92=E8=
=A1=A8=E7=A4=BA=E3=81=99=E3=82=8B"
=20
 #: gitk:11377
 msgid "Maximum # tags/heads to show"
-msgstr ""
+msgstr "=E8=A1=A8=E7=A4=BA=E3=81=99=E3=82=8B=E6=9C=80=E5=A4=A7=E3=81=AE=
=E3=82=BF=E3=82=B0/=E3=83=98=E3=83=83=E3=83=89=E6=95=B0 #"
=20
 #: gitk:11380
 msgid "Limit diffs to listed paths"
@@ -1242,21 +1229,20 @@ msgid "Choose..."
 msgstr "=E9=81=B8=E6=8A=9E..."
=20
 #: gitk:11395
-#, fuzzy
 msgid "General options"
-msgstr "=E3=83=91=E3=83=83=E3=83=81=E7=94=9F=E6=88=90"
+msgstr "=E5=85=A8=E8=88=AC=E3=82=AA=E3=83=97=E3=82=B7=E3=83=A7=E3=83=B3=
"
=20
 #: gitk:11398
 msgid "Use themed widgets"
-msgstr ""
+msgstr "=E3=83=86=E3=83=BC=E3=83=9E=E3=81=AE=E3=82=A6=E3=82=A3=E3=82=B8=
=E3=82=A7=E3=83=83=E3=83=88=E3=82=92=E4=BD=BF=E3=81=86"
=20
 #: gitk:11400
 msgid "(change requires restart)"
-msgstr ""
+msgstr "(=E5=A4=89=E6=9B=B4=E3=82=92=E5=8F=8D=E6=98=A0=E3=81=99=E3=82=8B=
=E3=81=AB=E3=81=AF=E5=86=8D=E3=82=B9=E3=82=BF=E3=83=BC=E3=83=88=E3=81=AE=
=E5=BF=85=E8=A6=81=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=99=EF=BC=89=
"
=20
 #: gitk:11402
 msgid "(currently unavailable)"
-msgstr ""
+msgstr "=EF=BC=88=E7=8F=BE=E5=9C=A8=E5=AD=98=E5=9C=A8=E3=81=97=E3=81=AA=
=E3=81=84=EF=BC=89"
=20
 #: gitk:11413
 msgid "Colors: press to choose"
@@ -1343,17 +1329,16 @@ msgid "Gitk preferences"
 msgstr "Gitk =E8=A8=AD=E5=AE=9A"
=20
 #: gitk:11494
-#, fuzzy
 msgid "General"
-msgstr "=E7=94=9F=E6=88=90"
+msgstr "=E5=85=A8=E8=88=AC"
=20
 #: gitk:11495
 msgid "Colors"
-msgstr ""
+msgstr "=E8=89=B2"
=20
 #: gitk:11496
 msgid "Fonts"
-msgstr ""
+msgstr "=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88"
=20
 #: gitk:11546
 #, tcl-format
@@ -1365,6 +1350,8 @@ msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
 msgstr ""
+"=E7=94=B3=E3=81=97=E8=A8=B3=E6=9C=89=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=
=93=E3=80=82gitk=E3=81=AF=E3=80=81=E3=81=93=E3=81=AE=E3=83=90=E3=83=BC=E3=
=82=B8=E3=83=A7=E3=83=B3=E3=81=AETcl/Tk=E3=81=A7=E3=81=AF=E5=8B=95=E4=BD=
=9C=E3=81=97=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82\n"
+"Gitk=E3=81=AB=E3=81=AF=E5=B0=91=E3=81=AA=E3=81=8F=E3=81=A8=E3=82=82Tc=
l/Tk 8.4=E3=81=8C=E5=BF=85=E8=A6=81=E3=81=A7=E3=81=99=E3=80=82"
=20
 #: gitk:12269
 msgid "Cannot find a git repository here."
--=20
2.6.2
