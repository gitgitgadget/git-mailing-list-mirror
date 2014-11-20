From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [L10N] please review a batch l10n update for Git 2.2.0 final
Date: Thu, 20 Nov 2014 16:30:44 +0800
Message-ID: <CANYiYbH5-eDSkq8LQsyixMsDh6e9ZA7nTVib_GbdK5BQ6vE6OA@mail.gmail.com>
References: <CANYiYbFrNCqxfrcaOWjeEZ2no=DRHVoDic8Qg989=U_VUTWiWA@mail.gmail.com>
	<CAN0XMOLZw+btduQkQwMLykYFgFuZzTfMwnexyGR0FBdbG=qFmA@mail.gmail.com>
	<CANYiYbEt7r1Bjx9VA29Vk5FL9Qu0nTeXVZWAaggrcM=eNsY7Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 09:30:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrN8d-0003GY-43
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 09:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756639AbaKTIar convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Nov 2014 03:30:47 -0500
Received: from mail-wi0-f175.google.com ([209.85.212.175]:61254 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbaKTIaq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Nov 2014 03:30:46 -0500
Received: by mail-wi0-f175.google.com with SMTP id l15so7888961wiw.8
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 00:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9sDVAyvXX8Z1Ma+cS3DzQGHU6KZqs420PPUtw2iLxsY=;
        b=jA3ylhf/46GWeJ8hWDbOyf/m4Lb1ZuVuu6+nntp/PAsGzsTHSNv8niSXc0F66XwRdr
         3p0XBeFvN5TlJgByQEAF9f5MSdK0KZDzyoWHxNDtCTnDjLFNBTlr0cyOMmNu18+rTf80
         /cpxb8n9Xsv+JXFDIR28hqtNht92fAz/K7DJH88FZQA89DlVjLh5Dye+nDd4x0J37gad
         yoEhrbqx4DWlzIBJnoGoi1aeLjBy5bNzaHR/flkMfDdAVmAKPW8l67KY/TadsIsN6nS0
         1P3ZwyOT5P76pjiflrULW1owwOrmnotVhq6Yi/f16uhyZ8x25/AGTcdDdvQhQ/goJrHM
         Ee4w==
X-Received: by 10.180.208.8 with SMTP id ma8mr13369841wic.53.1416472244891;
 Thu, 20 Nov 2014 00:30:44 -0800 (PST)
Received: by 10.194.56.8 with HTTP; Thu, 20 Nov 2014 00:30:44 -0800 (PST)
In-Reply-To: <CANYiYbEt7r1Bjx9VA29Vk5FL9Qu0nTeXVZWAaggrcM=eNsY7Rg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2014-11-20 16:04 GMT+08:00 Jiang Xin <worldhello.net@gmail.com>:
> 2014-11-20 14:31 GMT+08:00 Ralf Thielow <ralf.thielow@gmail.com>:
>>>
>>> NOTE for Ralf:  After I updated de.po, there are 3 fuzzies instead =
of one.
>>> I can only fix one of them.
>>>
>>
>> I just send a pull-request to you. It seems I have forgotten one git=
=2Epot update.
>
> Merged.  I also see a nice workaround in your commit.  It's a fix for=
 the issue
> you reported [1] yesterday on our side. ;-)
>
>      msgid "check"
>     +msgstr "check|on-demand"
>
> [1]: http://www.spinics.net/lists/git/msg241964.html
>

Another batch update:

commit 7ba2ba7d12163a8f9a9947d7880bd26f2970d4c5
Author: Jiang Xin <worldhello.net@gmail.com>
Date:   Thu Nov 20 16:12:34 2014 +0800

    l10n: remove a superfluous translation for push.c

    Ralf reported that '--recurse-submodules' option in push.c should n=
ot be
    translated [1].  Before his commit is merged, remove superfluous
    translations for push.c.

    [1] http://www.spinics.net/lists/git/msg241964.html

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

diff --git a/po/bg.po b/po/bg.po
index 4394eef..ccdd11e 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -131,7 +131,7 @@ msgstr ""
 "Project-Id-Version: git master\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
 "POT-Creation-Date: 2014-11-20 09:42+0800\n"
-"PO-Revision-Date: 2014-11-20 10:15+0800\n"
+"PO-Revision-Date: 2014-11-20 16:09+0800\n"
 "Last-Translator: Alexander Shopov <ash@kambanaria.org>\n"
 "Language-Team: Bulgarian <dict@fsa-bg.org>\n"
 "Language: bg\n"
@@ -8676,10 +8676,6 @@ msgstr "=D0=A3=D0=9A=D0=90=D0=97=D0=90=D0=A2=D0=95=
=D0=9B>:<=D0=9E=D0=A7=D0=90=D0=9A=D0=92=D0=90=D0=9D=D0=90_=D0=A1=D0=A2=D0=
=9E=D0=99=D0=9D=D0=9E=D0=A1=D0=A2"
 msgid "require old value of ref to be at this value"
 msgstr "=D0=A3=D0=9A=D0=90=D0=97=D0=90=D0=A2=D0=95=D0=9B=D1=8F=D1=82 =D1=
=82=D1=80=D1=8F=D0=B1=D0=B2=D0=B0 =D0=BF=D1=8A=D1=80=D0=B2=D0=BE=D0=BD=D0=
=B0=D1=87=D0=B0=D0=BB=D0=BD=D0=BE =D0=B4=D0=B0 =D0=B5 =D1=81 =D1=82=D0=B0=
=D0=B7=D0=B8 =D0=9E=D0=A7=D0=90=D0=9A=D0=92=D0=90=D0=9D=D0=90_=D0=A1=D0=
=A2=D0=9E=D0=99=D0=9D=D0=9E=D0=A1=D0=A2"

-#: builtin/push.c:506
-msgid "check"
-msgstr "=D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0"
-
 #: builtin/push.c:507
 msgid "control recursive pushing of submodules"
 msgstr "=D1=83=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BD=D0=B0 =D1=80=D0=B5=D0=BA=D1=83=D1=80=D1=81=D0=B8=D0=B2=D0=BD=D0=BE=D1=
=82=D0=BE =D0=B8=D0=B7=D1=82=D0=BB=D0=B0=D1=81=D0=BA=D0=B2=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D0=BF=D0=BE=D0=B4=D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D0=B8=
=D1=82=D0=B5"
diff --git a/po/ca.po b/po/ca.po
index b30c611..1fea047 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -8,7 +8,7 @@ msgstr ""
 "Project-Id-Version: Git\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
 "POT-Creation-Date: 2014-11-20 09:42+0800\n"
-"PO-Revision-Date: 2014-11-20 10:23+0800\n"
+"PO-Revision-Date: 2014-11-20 16:10+0800\n"
 "Last-Translator: Alex Henrie <alexhenrie24@gmail.com>\n"
 "Language-Team: Catalan\n"
 "Language: ca\n"
@@ -8320,10 +8320,6 @@ msgstr "nom-de-refer=C3=A8ncia>:<esperat"
 msgid "require old value of ref to be at this value"
 msgstr "requereix que el valor antic de la refer=C3=A8ncia sigui d'aqu=
est valor"

-#: builtin/push.c:506
-msgid "check"
-msgstr "comprova"
-
 #: builtin/push.c:507
 msgid "control recursive pushing of submodules"
 msgstr "controla la pujada recursiva dels subm=C3=B2duls"
diff --git a/po/fr.po b/po/fr.po
index 172796d..fc31831 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -74,7 +74,7 @@ msgstr ""
 "Project-Id-Version: git\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
 "POT-Creation-Date: 2014-11-20 09:42+0800\n"
-"PO-Revision-Date: 2014-11-20 10:21+0800\n"
+"PO-Revision-Date: 2014-11-20 16:10+0800\n"
 "Last-Translator: Jean-No=C3=ABl Avila <jn.avila@free.fr>\n"
 "Language-Team: Jean-No=C3=ABl Avila <jn.avila@free.fr>\n"
 "Language: fr\n"
@@ -8472,10 +8472,6 @@ msgstr "nom de r=C3=A9f=C3=A9rence>:<attendu"
 msgid "require old value of ref to be at this value"
 msgstr "exiger que l'ancienne valeur de la r=C3=A9f=C3=A9rence soit =C3=
=A0 cette valeur"

-#: builtin/push.c:506
-msgid "check"
-msgstr "check"
-
 #: builtin/push.c:507
 msgid "control recursive pushing of submodules"
 msgstr "contr=C3=B4ler la pouss=C3=A9e r=C3=A9cursive des sous-modules=
"
diff --git a/po/sv.po b/po/sv.po
index 5a4bd2e..d601027 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -8,7 +8,7 @@ msgstr ""
 "Project-Id-Version: git 2.0.0\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
 "POT-Creation-Date: 2014-11-20 09:42+0800\n"
-"PO-Revision-Date: 2014-11-20 10:19+0800\n"
+"PO-Revision-Date: 2014-11-20 16:10+0800\n"
 "Last-Translator: Peter Krefting <peter@softwolves.pp.se>\n"
 "Language-Team: Swedish <tp-sv@listor.tp-sv.se>\n"
 "Language: sv\n"
@@ -8245,10 +8245,6 @@ msgstr "refnamn>:<f=C3=B6rv=C3=A4nta"
 msgid "require old value of ref to be at this value"
 msgstr "kr=C3=A4v att ref:s tidigare v=C3=A4rde =C3=A4r detta"

-#: builtin/push.c:506
-msgid "check"
-msgstr "kontrollera"
-
 #: builtin/push.c:507
 msgid "control recursive pushing of submodules"
 msgstr "styr rekursiv ins=C3=A4ndning av undermoduler"
diff --git a/po/vi.po b/po/vi.po
index 054190b..1430666 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -9,7 +9,7 @@ msgstr ""
 "Project-Id-Version: git v2.2.0\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
 "POT-Creation-Date: 2014-11-20 09:42+0800\n"
-"PO-Revision-Date: 2014-11-20 10:17+0800\n"
+"PO-Revision-Date: 2014-11-20 16:10+0800\n"
 "Last-Translator: Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail=
=2Ecom>\n"
 "Language-Team: Vietnamese <translation-team-vi@lists.sourceforge.net>=
\n"
 "Language: vi\n"
@@ -8368,10 +8368,6 @@ msgstr "t=C3=AAn-tham-chi=E1=BA=BFu>:<c=E1=BA=A7=
n"
 msgid "require old value of ref to be at this value"
 msgstr "y=C3=AAu c=E1=BA=A7u gi=C3=A1-tr=E1=BB=8B c=C5=A9 c=E1=BB=A7a =
tham chi=E1=BA=BFu th=C3=AC l=C3=A0 gi=C3=A1-tr=E1=BB=8B n=C3=A0y"

-#: builtin/push.c:506
-msgid "check"
-msgstr "ki=E1=BB=83m tra"
-
 #: builtin/push.c:507
 msgid "control recursive pushing of submodules"
 msgstr "=C4=91i=E1=BB=81u khi=E1=BB=83n vi=E1=BB=87c =C4=91=E1=BA=A9y =
l=C3=AAn (push) =C4=91=E1=BB=87 qui c=E1=BB=A7a m=C3=B4-=C4=91un-con"
diff --git a/po/zh_CN.po b/po/zh_CN.po
index 37a044b..4b0e9ee 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -13,7 +13,7 @@ msgstr ""
 "Project-Id-Version: Git\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
 "POT-Creation-Date: 2014-11-20 09:42+0800\n"
-"PO-Revision-Date: 2014-11-20 10:05+0800\n"
+"PO-Revision-Date: 2014-11-20 16:10+0800\n"
 "Last-Translator: Jiang Xin <worldhello.net@gmail.com>\n"
 "Language-Team: GitHub <https://github.com/gotgit/git/>\n"
 "Language: zh_CN\n"
@@ -8191,10 +8191,6 @@ msgstr "=E5=BC=95=E7=94=A8=E5=90=8D>:<=E6=9C=9F=E6=
=9C=9B=E5=80=BC"
 msgid "require old value of ref to be at this value"
 msgstr "=E8=A6=81=E6=B1=82=E5=BC=95=E7=94=A8=E6=97=A7=E7=9A=84=E5=8F=96=
=E5=80=BC=E4=B8=BA=E8=AE=BE=E5=AE=9A=E5=80=BC"

-#: builtin/push.c:506
-msgid "check"
-msgstr "=E6=A3=80=E6=9F=A5"
-
 #: builtin/push.c:507
 msgid "control recursive pushing of submodules"
 msgstr "=E6=8E=A7=E5=88=B6=E5=AD=90=E6=A8=A1=E7=BB=84=E7=9A=84=E9=80=92=
=E5=BD=92=E6=8E=A8=E9=80=81"




--=20
Jiang Xin
