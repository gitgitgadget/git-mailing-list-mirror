From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] l10n: correct indentation of show-branch usage
Date: Wed, 21 Jan 2015 15:49:44 +0800
Message-ID: <1e607449135792dd117bd528432fc1fbc1115667.1421825841.git.worldhello.net@gmail.com>
References: <1421782228-24005-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Jean-Noel Avila <jn.avila@free.fr>,
	Jiang Xin <worldhello.net@gmail.com>,
	Joan Perals <joan.perals@ixds.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	Tran Ngoc Quan <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 08:50:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDq3W-0002Vw-0x
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 08:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbbAUHuV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2015 02:50:21 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:46508 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbbAUHuA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 02:50:00 -0500
Received: by mail-pd0-f172.google.com with SMTP id v10so26864026pde.3
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 23:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :references:content-type:content-transfer-encoding;
        bh=7lSMUL6Kz65ZTreh3BG7YdaTXgdLaGaxMQSCLxZrhlw=;
        b=mCJcKBq9HGujjtB9oBA4DbbG05XewkupMQqT1KAM53o+Q5JQH2XqaKgs99lDc3tX2a
         us1ELrr9ncDIKBuq9RSccgdk4Es/OKfJyeZ4/fI5bycxpEnaOyXf57xTw13F4J+vH753
         x8TZURGIFkMWpBLMkKQbFZ0oLvK2rPSclNrUf19oPXnXReFqwDI2jwMrF5rX+h2Bw1cF
         lpIYIqtR9HANzUCRTTT1hMVYrF75xBLbOJpAtTLwNBz75HBt17T8IZO/XT6D64zNR/Pg
         9wYhNhY0jt87XGXMymrBhXyWNVEK/lpqbn1A20CyKltnxMnY6Ut7K0S33tc3pfGoj8wV
         zKUQ==
X-Received: by 10.70.90.100 with SMTP id bv4mr50440081pdb.29.1421826600125;
        Tue, 20 Jan 2015 23:50:00 -0800 (PST)
Received: from localhost.localdomain ([69.85.92.49])
        by mx.google.com with ESMTPSA id qc1sm4951274pbb.84.2015.01.20.23.49.56
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jan 2015 23:49:58 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.7.g04cb2f2
In-Reply-To: <1421782228-24005-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262712>

An indentation error was found right after we started l10n round 2, and
commit d6589d1 (show-branch: fix indentation of usage string) and this
update would fix it.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
This patch is based on master branch of git://github.com/git-l10n/git-p=
o

 po/de.po    | 18 +++++++++---------
 po/fr.po    | 18 +++++++++---------
 po/git.pot  | 10 +++++-----
 po/sv.po    | 38 +++++++++++++++++++-------------------
 po/vi.po    | 18 +++++++++---------
 po/zh_CN.po | 24 +++++++++++-------------
 6 files changed, 62 insertions(+), 64 deletions(-)

diff --git a/po/de.po b/po/de.po
index 0b93b0f..b2d4639 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7,8 +7,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: Git\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
-"POT-Creation-Date: 2015-01-18 11:24+0800\n"
-"PO-Revision-Date: 2014-11-20 10:19+0800\n"
+"POT-Creation-Date: 2015-01-21 14:21+0800\n"
+"PO-Revision-Date: 2015-01-21 15:01+0800\n"
 "Last-Translator: Ralf Thielow <ralf.thielow@gmail.com>\n"
 "Language-Team: German <>\n"
 "Language: de\n"
@@ -326,7 +326,7 @@ msgstr "kann '%s' nicht erstellen"
 msgid "index-pack died"
 msgstr "Erstellung der Paketindexdatei abgebrochen"
=20
-#: color.c:259
+#: color.c:260
 #, c-format
 msgid "invalid color value: %.*s"
 msgstr "Ung=C3=BCltiger Farbwert: %.*s"
@@ -9679,14 +9679,14 @@ msgstr "Ausgabe mit Zeilenumbr=C3=BCchen"
 #: builtin/show-branch.c:9
 msgid ""
 "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r]\n"
-"\t\t       [--current] [--color[=3D<when>] | --no-color] [--sparse]\n=
"
-"\t\t       [--more=3D<n> | --list | --independent | --merge-base]\n"
-"\t       [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"
+"\t\t[--current] [--color[=3D<when>] | --no-color] [--sparse]\n"
+"\t\t[--more=3D<n> | --list | --independent | --merge-base]\n"
+"\t\t[--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"
 msgstr ""
 "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r]\n"
-"\t\t       [--current] [--color[=3D<Wann>] | --no-color] [--sparse]\n=
"
-"\t\t       [--more=3D<n> | --list | --independent | --merge-base]\n"
-"\t       [--no-name | --sha1-name] [--topics] [(<Commit> | <glob>)...=
]"
+"\t\t[--current] [--color[=3D<Wann>] | --no-color] [--sparse]\n"
+"\t\t[--more=3D<n> | --list | --independent | --merge-base]\n"
+"\t\t[--no-name | --sha1-name] [--topics] [(<Commit> | <glob>)...]"
=20
 #: builtin/show-branch.c:13
 msgid "git show-branch (-g|--reflog)[=3D<n>[,<base>]] [--list] [<ref>]=
"
diff --git a/po/fr.po b/po/fr.po
index d1b3397..3235879 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -73,8 +73,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
-"POT-Creation-Date: 2015-01-18 11:24+0800\n"
-"PO-Revision-Date: 2015-01-18 17:01+0100\n"
+"POT-Creation-Date: 2015-01-21 14:21+0800\n"
+"PO-Revision-Date: 2015-01-21 14:57+0800\n"
 "Last-Translator: Jean-No=C3=ABl Avila <jn.avila@free.fr>\n"
 "Language-Team: Jean-No=C3=ABl Avila <jn.avila@free.fr>\n"
 "Language: fr\n"
@@ -394,7 +394,7 @@ msgstr "impossible de cr=C3=A9er '%s'"
 msgid "index-pack died"
 msgstr "l'index de groupe a disparu"
=20
-#: color.c:259
+#: color.c:260
 #, c-format
 msgid "invalid color value: %.*s"
 msgstr "Valeur invalide de couleur : %.*s"
@@ -9675,14 +9675,14 @@ msgstr "Couper les lignes"
 #: builtin/show-branch.c:9
 msgid ""
 "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r]\n"
-"\t\t       [--current] [--color[=3D<when>] | --no-color] [--sparse]\n=
"
-"\t\t       [--more=3D<n> | --list | --independent | --merge-base]\n"
-"\t       [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"
+"\t\t[--current] [--color[=3D<when>] | --no-color] [--sparse]\n"
+"\t\t[--more=3D<n> | --list | --independent | --merge-base]\n"
+"\t\t[--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"
 msgstr ""
 "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r]\n"
-"                [--current] [--color[=3D<quand>] | --no-color] [--spa=
rse]\n"
-"                [--more=3D<n> | --list | --independent | --merge-base=
]\n"
-"                [--no-name | --sha1-name] [--topics] [(<r=C3=A9v> | <=
glob>)...]"
+"\t\t[--current] [--color[=3D<quand>] | --no-color] [--sparse]\n"
+"\t\t[--more=3D<n> | --list | --independent | --merge-base]\n"
+"\t\t[--no-name | --sha1-name] [--topics] [(<r=C3=A9v> | <glob>)...]"
=20
 #: builtin/show-branch.c:13
 msgid "git show-branch (-g|--reflog)[=3D<n>[,<base>]] [--list] [<ref>]=
"
diff --git a/po/git.pot b/po/git.pot
index 923d617..91fa5a1 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -8,7 +8,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: PACKAGE VERSION\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
-"POT-Creation-Date: 2015-01-18 11:24+0800\n"
+"POT-Creation-Date: 2015-01-21 14:21+0800\n"
 "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
 "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
 "Language-Team: LANGUAGE <LL@li.org>\n"
@@ -305,7 +305,7 @@ msgstr ""
 msgid "index-pack died"
 msgstr ""
=20
-#: color.c:259
+#: color.c:260
 #, c-format
 msgid "invalid color value: %.*s"
 msgstr ""
@@ -9015,9 +9015,9 @@ msgstr ""
 #: builtin/show-branch.c:9
 msgid ""
 "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r]\n"
-"\t\t       [--current] [--color[=3D<when>] | --no-color] [--sparse]\n=
"
-"\t\t       [--more=3D<n> | --list | --independent | --merge-base]\n"
-"\t       [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"
+"\t\t[--current] [--color[=3D<when>] | --no-color] [--sparse]\n"
+"\t\t[--more=3D<n> | --list | --independent | --merge-base]\n"
+"\t\t[--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"
 msgstr ""
=20
 #: builtin/show-branch.c:13
diff --git a/po/sv.po b/po/sv.po
index 9f8e04d..0440443 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -7,8 +7,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git 2.0.0\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
-"POT-Creation-Date: 2015-01-18 11:24+0800\n"
-"PO-Revision-Date: 2015-01-18 20:29+0100\n"
+"POT-Creation-Date: 2015-01-21 14:21+0800\n"
+"PO-Revision-Date: 2015-01-21 14:57+0800\n"
 "Last-Translator: Peter Krefting <peter@softwolves.pp.se>\n"
 "Language-Team: Swedish <tp-sv@listor.tp-sv.se>\n"
 "Language: sv\n"
@@ -320,7 +320,7 @@ msgstr "kan inte skapa \"%s\""
 msgid "index-pack died"
 msgstr "index-pack dog"
=20
-#: color.c:259
+#: color.c:260
 #, c-format
 msgid "invalid color value: %.*s"
 msgstr "felaktigt f=C3=A4rgv=C3=A4rde: %.*s"
@@ -6361,11 +6361,11 @@ msgstr " delat"
=20
 #: builtin/init-db.c:475
 msgid ""
-"git init [-q | --quiet] [--bare] [--template=3D<template-directory>] =
[--shared"
-"[=3D<permissions>]] [directory]"
+"git init [-q | --quiet] [--bare] [--template=3D<template-directory>] =
[--"
+"shared[=3D<permissions>]] [directory]"
 msgstr ""
-"git init [-q | --quiet] [--bare] [--template=3D<mallkatalog>] [--shar=
ed"
-"[=3D<beh=C3=B6righeter>]] [katalog]"
+"git init [-q | --quiet] [--bare] [--template=3D<mallkatalog>] [--"
+"shared[=3D<beh=C3=B6righeter>]] [katalog]"
=20
 #: builtin/init-db.c:498
 msgid "permissions"
@@ -6408,8 +6408,8 @@ msgid ""
 "git interpret-trailers [--trim-empty] [(--trailer <token>[(=3D|:)<val=
ue>])...] "
 "[<file>...]"
 msgstr ""
-"git interpret-trailers [--trim-empty] [(--trailer <symbol>[(=3D|:)"
-"<v=C3=A4rde>])...] [<fil>...]"
+"git interpret-trailers [--trim-empty] [(--trailer "
+"<symbol>[(=3D|:)<v=C3=A4rde>])...] [<fil>...]"
=20
 #: builtin/interpret-trailers.c:25
 msgid "trim empty trailers"
@@ -9425,14 +9425,14 @@ msgstr "Radbryt utdata"
 #: builtin/show-branch.c:9
 msgid ""
 "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r]\n"
-"\t\t       [--current] [--color[=3D<when>] | --no-color] [--sparse]\n=
"
-"\t\t       [--more=3D<n> | --list | --independent | --merge-base]\n"
-"\t       [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"
+"\t\t[--current] [--color[=3D<when>] | --no-color] [--sparse]\n"
+"\t\t[--more=3D<n> | --list | --independent | --merge-base]\n"
+"\t\t[--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"
 msgstr ""
 "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r]\n"
-"\t\t       [--current] [--color[=3D<n=C3=A4r>] | --no-color] [--spars=
e]\n"
-"\t\t       [--more=3D<n> | --list | --independent | --merge-base]\n"
-"\t       [--no-name | --sha1-name] [--topics] [(<rev> | <m=C3=B6nster=
>)...]"
+"\t\t[--current] [--color[=3D<n=C3=A4r>] | --no-color] [--sparse]\n"
+"\t\t[--more=3D<n> | --list | --independent | --merge-base]\n"
+"\t\t[--no-name | --sha1-name] [--topics] [(<rev> | <m=C3=B6nster>)...=
]"
=20
 #: builtin/show-branch.c:13
 msgid "git show-branch (-g|--reflog)[=3D<n>[,<base>]] [--list] [<ref>]=
"
@@ -9504,11 +9504,11 @@ msgstr "visa <n> nyaste refloggposter med b=C3=B6=
rjan p=C3=A5 bas"
=20
 #: builtin/show-ref.c:10
 msgid ""
-"git show-ref [-q|--quiet] [--verify] [--head] [-d|--dereference] [-s|=
--hash"
-"[=3D<n>]] [--abbrev[=3D<n>]] [--tags] [--heads] [--] [pattern*] "
+"git show-ref [-q|--quiet] [--verify] [--head] [-d|--dereference] [-s|=
--"
+"hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags] [--heads] [--] [pattern*] "
 msgstr ""
-"git show-ref [-q|--quiet] [--verify] [--head] [-d|--dereference] [-s|=
--hash"
-"[=3D<n>]] [--abbrev[=3D<n>]] [--tags] [--heads] [--] [m=C3=B6nster*] =
"
+"git show-ref [-q|--quiet] [--verify] [--head] [-d|--dereference] [-s|=
--"
+"hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags] [--heads] [--] [m=C3=B6nste=
r*] "
=20
 #: builtin/show-ref.c:11
 msgid "git show-ref --exclude-existing[=3Dpattern] < ref-list"
diff --git a/po/vi.po b/po/vi.po
index 940e57b..9c2bba8 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -8,8 +8,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git v2.3.0\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
-"POT-Creation-Date: 2015-01-18 11:24+0800\n"
-"PO-Revision-Date: 2015-01-19 07:19+0700\n"
+"POT-Creation-Date: 2015-01-21 14:21+0800\n"
+"PO-Revision-Date: 2015-01-21 14:58+0800\n"
 "Last-Translator: Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail=
=2Ecom>\n"
 "Language-Team: Vietnamese <translation-team-vi@lists.sourceforge.net>=
\n"
 "Language: vi\n"
@@ -325,7 +325,7 @@ msgstr "kh=C3=B4ng th=E1=BB=83 t=E1=BA=A1o =E2=80=9C=
%s=E2=80=9D"
 msgid "index-pack died"
 msgstr "m=E1=BB=A5c l=E1=BB=A5c g=C3=B3i =C4=91=C3=A3 ch=E1=BA=BFt"
=20
-#: color.c:259
+#: color.c:260
 #, c-format
 msgid "invalid color value: %.*s"
 msgstr "gi=C3=A1 tr=E1=BB=8B m=C3=A0u kh=C3=B4ng h=E1=BB=A3p l=E1=BB=87=
: %.*s"
@@ -9500,14 +9500,14 @@ msgstr "Ng=E1=BA=AFt d=C3=B2ng khi qu=C3=A1 d=C3=
=A0i"
 #: builtin/show-branch.c:9
 msgid ""
 "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r]\n"
-"\t\t       [--current] [--color[=3D<when>] | --no-color] [--sparse]\n=
"
-"\t\t       [--more=3D<n> | --list | --independent | --merge-base]\n"
-"\t       [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"
+"\t\t[--current] [--color[=3D<when>] | --no-color] [--sparse]\n"
+"\t\t[--more=3D<n> | --list | --independent | --merge-base]\n"
+"\t\t[--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"
 msgstr ""
 "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r]\n"
-"\t\t       [--current] [--color[=3D<khi>] | --no-color] [--sparse]\n"
-"\t\t       [--more=3D<n> | --list | --independent | --merge-base]\n"
-"\t       [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)=E2=80=
=A6]"
+"\t\t[--current] [--color[=3D<khi>] | --no-color] [--sparse]\n"
+"\t\t[--more=3D<n> | --list | --independent | --merge-base]\n"
+"\t\t[--no-name | --sha1-name] [--topics] [(<rev> | <glob>)=E2=80=A6]"
=20
 #: builtin/show-branch.c:13
 msgid "git show-branch (-g|--reflog)[=3D<n>[,<base>]] [--list] [<ref>]=
"
diff --git a/po/zh_CN.po b/po/zh_CN.po
index ccbb03c..2b8d2cb 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -12,8 +12,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: Git\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
-"POT-Creation-Date: 2015-01-18 11:24+0800\n"
-"PO-Revision-Date: 2015-01-18 20:34+0800\n"
+"POT-Creation-Date: 2015-01-21 14:21+0800\n"
+"PO-Revision-Date: 2015-01-21 14:58+0800\n"
 "Last-Translator: Jiang Xin <worldhello.net@gmail.com>\n"
 "Language-Team: GitHub <https://github.com/gotgit/git/>\n"
 "Language: zh_CN\n"
@@ -320,7 +320,7 @@ msgstr "=E4=B8=8D=E8=83=BD=E5=88=9B=E5=BB=BA '%s'"
 msgid "index-pack died"
 msgstr "index-pack =E7=BB=88=E6=AD=A2"
=20
-#: color.c:259
+#: color.c:260
 #, c-format
 msgid "invalid color value: %.*s"
 msgstr "=E6=97=A0=E6=95=88=E7=9A=84=E9=A2=9C=E8=89=B2=E5=80=BC=EF=BC=9A=
%.*s"
@@ -5368,8 +5368,7 @@ msgstr "=E8=8E=B7=E5=8F=96=E7=BB=84=E5=B9=B6=E6=8C=
=87=E5=AE=9A=E5=BC=95=E7=94=A8=E8=A7=84=E5=88=99=E6=B2=A1=E6=9C=89=E6=84=
=8F=E4=B9=89"
=20
 #: builtin/fmt-merge-msg.c:13
 msgid "git fmt-merge-msg [-m <message>] [--log[=3D<n>]|--no-log] [--fi=
le <file>]"
-msgstr ""
-"git fmt-merge-msg [-m <=E8=AF=B4=E6=98=8E>] [--log[=3D<n>]|--no-log] =
[--file <=E6=96=87=E4=BB=B6>]"
+msgstr "git fmt-merge-msg [-m <=E8=AF=B4=E6=98=8E>] [--log[=3D<n>]|--n=
o-log] [--file <=E6=96=87=E4=BB=B6>]"
=20
 #: builtin/fmt-merge-msg.c:662 builtin/fmt-merge-msg.c:665 builtin/gre=
p.c:698
 #: builtin/merge.c:198 builtin/repack.c:178 builtin/repack.c:182
@@ -6375,8 +6374,7 @@ msgstr "=E4=B8=8D=E8=83=BD=E5=88=87=E6=8D=A2=E7=9B=
=AE=E5=BD=95=E5=88=B0 %s"
 msgid ""
 "%s (or --work-tree=3D<directory>) not allowed without specifying %s (=
or --git-"
 "dir=3D<directory>)"
-msgstr ""
-"=E4=B8=8D=E5=85=81=E8=AE=B8 %s=EF=BC=88=E6=88=96 --work-tree=3D<=E7=9B=
=AE=E5=BD=95>=EF=BC=89=E8=80=8C=E6=B2=A1=E6=9C=89=E6=8C=87=E5=AE=9A %s=EF=
=BC=88=E6=88=96 --git-dir=3D<=E7=9B=AE=E5=BD=95>=EF=BC=89"
+msgstr "=E4=B8=8D=E5=85=81=E8=AE=B8 %s=EF=BC=88=E6=88=96 --work-tree=3D=
<=E7=9B=AE=E5=BD=95>=EF=BC=89=E8=80=8C=E6=B2=A1=E6=9C=89=E6=8C=87=E5=AE=
=9A %s=EF=BC=88=E6=88=96 --git-dir=3D<=E7=9B=AE=E5=BD=95>=EF=BC=89"
=20
 #: builtin/init-db.c:591
 #, c-format
@@ -9359,14 +9357,14 @@ msgstr "=E6=8A=98=E8=A1=8C=E8=BE=93=E5=87=BA"
 #: builtin/show-branch.c:9
 msgid ""
 "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r]\n"
-"\t\t       [--current] [--color[=3D<when>] | --no-color] [--sparse]\n=
"
-"\t\t       [--more=3D<n> | --list | --independent | --merge-base]\n"
-"\t       [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"
+"\t\t[--current] [--color[=3D<when>] | --no-color] [--sparse]\n"
+"\t\t[--more=3D<n> | --list | --independent | --merge-base]\n"
+"\t\t[--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"
 msgstr ""
 "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r]\n"
-"\t\t       [--current] [--color[=3D<=E4=BD=95=E6=97=B6>] | --no-color=
] [--sparse]\n"
-"\t\t       [--more=3D<n> | --list | --independent | --merge-base]\n"
-"\t       [--no-name | --sha1-name] [--topics] [(<=E7=89=88=E6=9C=AC> =
| <=E9=80=9A=E9=85=8D=E7=AC=A6>)...]"
+"\t\t[--current] [--color[=3D<=E4=BD=95=E6=97=B6>] | --no-color] [--sp=
arse]\n"
+"\t\t[--more=3D<n> | --list | --independent | --merge-base]\n"
+"\t\t[--no-name | --sha1-name] [--topics] [(<=E7=89=88=E6=9C=AC> | <=E9=
=80=9A=E9=85=8D=E7=AC=A6>)...]"
=20
 #: builtin/show-branch.c:13
 msgid "git show-branch (-g|--reflog)[=3D<n>[,<base>]] [--list] [<ref>]=
"
--=20
2.3.0.rc0.7.g04cb2f2
