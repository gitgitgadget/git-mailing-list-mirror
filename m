From: phillip <phillip.szelat@gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_1/1=5D_l10n=3A_de=2Epo=3A_u?= =?UTF-8?Q?se_=22bla_=E2=80=A6=22_instead_of_=22bla=2E=2E=2E=22?=
Date: Tue, 24 Mar 2015 21:29:13 +0100
Message-ID: <622DA8B6-EAC0-476F-9B8A-01F5CF5CFA73@gmail.com>
References: <1426942357-5618-1-git-send-email-phillip.szelat@gmail.com> <CAN0XMO+JLfzkYwP5rKkT6RyLJ-XuH1k=9vKmi1X0xb1SjTOdvg@mail.gmail.com> <551190F2.10808@drmicha.warpmail.net> <20150324171044.GA4414@ralf-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?ISO-8859-1?Q?Matthias_R=FCster?= <matthias.ruester@gmail.com>,
	=?ISO-8859-1?Q?Magnus_G=F6rlitz?= <magnus.goerlitz@googlemail.com>
To: Ralf Thielow <ralf.thielow@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 21:29:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaVS1-0003WY-Vn
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 21:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbbCXU3V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 16:29:21 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33422 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbbCXU3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 16:29:20 -0400
Received: by wgbcc7 with SMTP id cc7so3669613wgb.0
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 13:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=FGf5akFyemLjrraXoXWqgXz23IlXubffeFt2iEBVtQA=;
        b=JGTEQOAqb7y6CybFuzazJgnTUc3c7BHMmQ5O2YwMNqoa4PfKuFaP6f9OIeOCpg0aeO
         Cn/M8O3X3JzNBy+i0snfb4q4vxIqEYp/PPwcTQhP4xz4TX6kKJsLFD+I7oBE0zqs8Z7A
         YnMIlhWvvzC0NdubSM2U1Nky2WBfJYH9nGn36xkuLpPMztV6qqccEWHdmq1djbkbybFq
         3tjY2e8d/8lFF8Jqt1omlEVZTIH4Hx29LzhrT3AC8kJF6GPPg+FXhyq52o8xm+eWHZzT
         eBHiBBDc9YejEl+Eq1hISIjvotcKcF7Fgioqq1083i92OR7MEx/dJ28dF5TNibA7h1J0
         7WIA==
X-Received: by 10.180.74.47 with SMTP id q15mr30907437wiv.49.1427228959062;
        Tue, 24 Mar 2015 13:29:19 -0700 (PDT)
Received: from android-b7bb6bce7d91de53.fritz.box (i59F45BBC.versanet.de. [89.244.91.188])
        by mx.google.com with ESMTPSA id ey10sm12628163wib.2.2015.03.24.13.29.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2015 13:29:18 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <20150324171044.GA4414@ralf-ubuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266226>



Thanks a lot for fixing!

Phillip

>
>Let's apply this instead.
>
>-- >8 --
>From: Phillip Sz <phillip.szelat@gmail.com>
>Date: Sat, 21 Mar 2015 13:52:37 +0100
>Subject: [PATCH] l10n: de.po: add space before ellipsis
>
>Signed-off-by: Phillip Sz <phillip.szelat@gmail.com>
>Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>---
> po/de.po | 32 ++++++++++++++++----------------
> 1 file changed, 16 insertions(+), 16 deletions(-)
>
>diff --git a/po/de.po b/po/de.po
>index 11fbd0f..9fa3f4c 100644
>--- a/po/de.po
>+++ b/po/de.po
>@@ -616,7 +616,7 @@ msgstr ""
> #: help.c:373
> #, c-format
> msgid "in %0.1f seconds automatically..."
>-msgstr "Automatische Ausf=C3=BChrung in %0.1f Sekunden..."
>+msgstr "Automatische Ausf=C3=BChrung in %0.1f Sekunden ..."
>=20
> #: help.c:380
> #, c-format
>@@ -1271,12 +1271,12 @@ msgstr "Kann keine Commit-Beschreibung f=C3=BC=
r %s
>bekommen"
> #: sequencer.c:611
> #, c-format
> msgid "could not revert %s... %s"
>-msgstr "Konnte \"revert\" nicht auf %s ausf=C3=BChren... %s"
>+msgstr "Konnte \"revert\" nicht auf %s ausf=C3=BChren ... %s"
>=20
> #: sequencer.c:612
> #, c-format
> msgid "could not apply %s... %s"
>-msgstr "Konnte %s nicht anwenden... %s"
>+msgstr "Konnte %s nicht anwenden ... %s"
>=20
> #: sequencer.c:648
> msgid "empty commit set passed"
>@@ -2436,7 +2436,7 @@ msgstr "%s: Patch konnte nicht angewendet werden=
"
> #: builtin/apply.c:3653
> #, c-format
> msgid "Checking patch %s..."
>-msgstr "Pr=C3=BCfe Patch %s..."
>+msgstr "Pr=C3=BCfe Patch %s ..."
>=20
> #: builtin/apply.c:3746 builtin/checkout.c:231 builtin/reset.c:135
> #, c-format
>@@ -4091,7 +4091,7 @@ msgstr "Konnte zu klonenden Remote-Branch %s
>nicht finden."
> #: builtin/clone.c:561
> #, c-format
> msgid "Checking connectivity... "
>-msgstr "Pr=C3=BCfe Konnektivit=C3=A4t... "
>+msgstr "Pr=C3=BCfe Konnektivit=C3=A4t ... "
>=20
> #: builtin/clone.c:564
> msgid "remote did not send all necessary objects"
>@@ -4165,12 +4165,12 @@ msgstr "Konnte Arbeitsverzeichnis '%s' nicht
>erstellen."
> #: builtin/clone.c:870
> #, c-format
> msgid "Cloning into bare repository '%s'...\n"
>-msgstr "Klone in Bare-Repository '%s'...\n"
>+msgstr "Klone in Bare-Repository '%s' ...\n"
>=20
> #: builtin/clone.c:872
> #, c-format
> msgid "Cloning into '%s'...\n"
>-msgstr "Klone nach '%s'...\n"
>+msgstr "Klone nach '%s' ...\n"
>=20
> #: builtin/clone.c:897
> msgid "--dissociate given, but there is no --reference"
>@@ -4600,7 +4600,7 @@ msgstr ""
> #: builtin/commit.c:1199
> msgid "Clever... amending the last one with dirty index."
> msgstr ""
>-"Klug... den letzten Commit mit einer ge=C3=A4nderten Staging-Area
>nachbessern."
>+"Klug ... den letzten Commit mit einer ge=C3=A4nderten Staging-Area
>nachbessern."
>=20
> #: builtin/commit.c:1201
>msgid "Explicit paths specified without -i or -o; assuming --only
>paths..."
>@@ -7335,7 +7335,7 @@ msgstr "Aktualisiere %s..%s\n"
> #: builtin/merge.c:1388
> #, c-format
> msgid "Trying really trivial in-index merge...\n"
>-msgstr "Probiere wirklich trivialen \"in-index\"-Merge...\n"
>+msgstr "Probiere wirklich trivialen \"in-index\"-Merge ...\n"
>=20
> #: builtin/merge.c:1395
> #, c-format
>@@ -7349,12 +7349,12 @@ msgstr "Vorspulen nicht m=C3=B6glich, breche a=
b."
> #: builtin/merge.c:1450 builtin/merge.c:1529
> #, c-format
> msgid "Rewinding the tree to pristine...\n"
>-msgstr "R=C3=BCcklauf des Verzeichnisses bis zum Ursprung...\n"
>+msgstr "R=C3=BCcklauf des Verzeichnisses bis zum Ursprung ...\n"
>=20
> #: builtin/merge.c:1454
> #, c-format
> msgid "Trying merge strategy %s...\n"
>-msgstr "Probiere Merge-Strategie %s...\n"
>+msgstr "Probiere Merge-Strategie %s ...\n"
>=20
> #: builtin/merge.c:1520
> #, c-format
>@@ -7682,7 +7682,7 @@ msgstr "git notes copy [<Optionen>] <von-Objekt>
><nach-Objekt>"
>=20
> #: builtin/notes.c:51
> msgid "git notes copy --stdin [<from-object> <to-object>]..."
>-msgstr "git notes copy --stdin [<von-Objekt> <nach-Objekt>]..."
>+msgstr "git notes copy --stdin [<von-Objekt> <nach-Objekt>] ..."
>=20
> #: builtin/notes.c:56
> msgid "git notes append [<options>] [<object>]"
>@@ -8689,7 +8689,7 @@ msgstr "git remote prune [<Optionen>] <Name>"
>=20
> #: builtin/remote.c:64
> msgid "git remote update [<options>] [<group> | <remote>]..."
>-msgstr "git remote update [<Optionen>] [<Gruppe> |
><externesRepository>]..."
>+msgstr "git remote update [<Optionen>] [<Gruppe> |
><externesRepository>] ..."
>=20
> #: builtin/remote.c:88
> #, c-format
>@@ -9865,7 +9865,7 @@ msgstr "fehlerhaftes Objekt bei '%s'"
> #: builtin/tag.c:301
> #, c-format
> msgid "tag name too long: %.*s..."
>-msgstr "Tagname zu lang: %.*s..."
>+msgstr "Tagname zu lang: %.*s ..."
>=20
> #: builtin/tag.c:306
> #, c-format
>@@ -10450,7 +10450,7 @@ msgstr ""
>=20
> #: git-am.sh:166
> msgid "Falling back to patching base and 3-way merge..."
>-msgstr "Falle zur=C3=BCck zum Patchen der Basis und des 3-Wege-Merges=
=2E.."
>+msgstr "Falle zur=C3=BCck zum Patchen der Basis und des 3-Wege-Merges=
 ..."
>=20
> #: git-am.sh:182
> msgid "Failed to merge in the changes."
>@@ -10943,7 +10943,7 @@ msgstr "=C3=84nderungen von $mb zu $onto:"
> msgid "First, rewinding head to replay your work on top of it..."
> msgstr ""
> "Zun=C3=A4chst wird der Branch zur=C3=BCckgespult, um Ihre =C3=84nder=
ungen\n"
>-"darauf neu anzuwenden..."
>+"darauf neu anzuwenden ..."
>=20
> #: git-rebase.sh:620
> #, sh-format
