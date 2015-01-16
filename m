From: phillip <phillip.szelat@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 13 new messages
Date: Fri, 16 Jan 2015 23:31:08 +0100
Message-ID: <D0A38DE3-C180-4664-A50B-BBEBA70B2C27@gmail.com>
References: <1421341887-16719-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 23:31:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCFQD-0006F9-Hk
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 23:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbbAPWbN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2015 17:31:13 -0500
Received: from mail-wi0-f170.google.com ([209.85.212.170]:64290 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbbAPWbL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 17:31:11 -0500
Received: by mail-wi0-f170.google.com with SMTP id z2so7090770wiv.1
        for <git@vger.kernel.org>; Fri, 16 Jan 2015 14:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=eSNm6wj/42MsSi4gbyD0cxxKf6L4CB8kU7A1h521c9E=;
        b=z6hjqTRwIbi5BFvMp0ESy2B4f0ekW9vcvv4DYa8ZFbN4NZ0PChhRVWigWth47R3Cc4
         v5mFwPA1QqAnEQmez6Spl7wFwxL6uR41AQkN0rRbkufZHrKcGKvw/N9Mt/GN87SEYOFC
         aRiM6rE6p+zYQ9TDN95v9tgUfHC5vtVoEAIIUznZruJtd5b1p11uAWFdFAXK3KxraWOF
         OxCiPPrhFztjJ71j/fn3LTl2x5cg6h9/czpNLTJYaMH06jljjJ7M8z0uyovUlH/T6dsl
         FTh/tNeehLCxRiO2LbMStk7kJoAl0iYPqVaL98qLZxsvG/4dqjN7haVU9BVQ0a72z1Dz
         tTWw==
X-Received: by 10.194.24.103 with SMTP id t7mr6922209wjf.15.1421447470459;
        Fri, 16 Jan 2015 14:31:10 -0800 (PST)
Received: from android-b7bb6bce7d91de53.fritz.box (i577AA797.versanet.de. [87.122.167.151])
        by mx.google.com with ESMTPSA id o2sm4644329wiy.11.2015.01.16.14.31.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2015 14:31:09 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <1421341887-16719-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262577>



Hi,

looks good!

Phillip

> po/de.po | 39 +++++++++++++++------------------------
> 1 file changed, 15 insertions(+), 24 deletions(-)
>
>diff --git a/po/de.po b/po/de.po
>index 2fa5832..70ca3ff 100644
>--- a/po/de.po
>+++ b/po/de.po
>@@ -3129,9 +3129,8 @@ msgid "edit the description for the branch"
> msgstr "die Beschreibung f=C3=BCr den Branch bearbeiten"
>=20
> #: builtin/branch.c:851
>-#, fuzzy
> msgid "force creation, move/rename, deletion"
>-msgstr "F=C3=BChre Erkennung f=C3=BCr ungenaue Umbenennung aus"
>+msgstr "Erstellung, Verschiebung/Umbenennung oder L=C3=B6schung erzwi=
ngen"
>=20
> #: builtin/branch.c:854
> msgid "print only not merged branches"
>@@ -4003,7 +4002,7 @@ msgstr "nur einen Branch klonen, HEAD oder
>--branch"
>=20
> #: builtin/clone.c:99
> msgid "use --reference only while cloning"
>-msgstr ""
>+msgstr "--reference nur w=C3=A4hrend des Klonens benutzen"
>=20
> #: builtin/clone.c:100 builtin/init-db.c:502
> msgid "gitdir"
>@@ -4109,13 +4108,12 @@ msgid "unable to checkout working tree"
> msgstr "Arbeitsverzeichnis konnte nicht ausgecheckt werden"
>=20
> #: builtin/clone.c:746
>-#, fuzzy
> msgid "cannot repack to clean up"
>-msgstr "Kann Paketdatei %s nicht lesen"
>+msgstr "Kann \"repack\" zum Aufr=C3=A4umen nicht aufrufen"
>=20
> #: builtin/clone.c:748
> msgid "cannot unlink temporary alternates file"
>-msgstr ""
>+msgstr "Kann tempor=C3=A4re \"alternates\"-Datei nicht entfernen"
>=20
> #: builtin/clone.c:778
> msgid "Too many arguments."
>@@ -4176,7 +4174,7 @@ msgstr "Klone nach '%s'...\n"
>=20
> #: builtin/clone.c:897
> msgid "--dissociate given, but there is no --reference"
>-msgstr ""
>+msgstr "--dissociate ohne --reference angegeben"
>=20
> #: builtin/clone.c:912
> msgid "--depth is ignored in local clones; use file:// instead."
>@@ -4964,14 +4962,12 @@ msgid "open an editor"
> msgstr "einen Editor =C3=B6ffnen"
>=20
> #: builtin/config.c:72
>-#, fuzzy
> msgid "find the color configured: slot [default]"
>-msgstr "die konfigurierte Farbe finden: [Standard]"
>+msgstr "die konfigurierte Farbe finden: Slot [Standard]"
>=20
> #: builtin/config.c:73
>-#, fuzzy
> msgid "find the color setting: slot [stdout-is-tty]"
>-msgstr "die Farbeinstellung finden: [Standard-Ausgabe-ist-Terminal]"
>+msgstr "die Farbeinstellung finden: Slot
>[Standard-Ausgabe-ist-Terminal]"
>=20
> #: builtin/config.c:74
> msgid "Type"
>@@ -5591,7 +5587,6 @@ msgid "quote placeholders suitably for python"
> msgstr "Platzhalter als Python-String formatieren"
>=20
> #: builtin/for-each-ref.c:1078
>-#, fuzzy
> msgid "quote placeholders suitably for Tcl"
> msgstr "Platzhalter als Tcl-String formatieren"
>=20
>@@ -7618,13 +7613,12 @@ msgid "git notes [--ref <notes_ref>] [list
>[<object>]]"
> msgstr "git notes [--ref <Notiz-Referenz>] [list [<Objekt>]]"
>=20
> #: builtin/notes.c:25
>-#, fuzzy
> msgid ""
>"git notes [--ref <notes_ref>] add [-f] [--allow-empty] [-m <msg> | -F
><file> "
> "| (-c | -C) <object>] [<object>]"
> msgstr ""
>-"git notes [--ref <Notiz-Referenz>] add [-f] [-m <Nachricht> | -F
><Datei> | (-"
>-"c | -C) <Objekt>] [<Objekt>]"
>+"git notes [--ref <Notiz-Referenz>] add [-f] [--allow-empty] [-m
><Beschreibung> | "
>+"-F <Datei> | (-c | -C) <Objekt>] [<Objekt>]"
>=20
> #: builtin/notes.c:26
>msgid "git notes [--ref <notes_ref>] copy [-f] <from-object>
><to-object>"
>@@ -7632,18 +7626,16 @@ msgstr ""
>"git notes [--ref <Notiz-Referenz>] copy [-f] <von-Objekt>
><nach-Objekt>"
>=20
> #: builtin/notes.c:27
>-#, fuzzy
> msgid ""
>"git notes [--ref <notes_ref>] append [--allow-empty] [-m <msg> | -F
><file> | "
> "(-c | -C) <object>] [<object>]"
> msgstr ""
>-"git notes [--ref <Notiz-Referenz>] append [-m <Nachricht> | -F
><Datei> | (-c "
>-"| -C) <Objekt>] [<Objekt>]"
>+"git notes [--ref <Notiz-Referenz>] append [--allow-empty] [-m
><Beschreibung> | "
>+"-F <Datei> | (-c | -C) <Objekt>] [<Objekt>]"
>=20
> #: builtin/notes.c:28
>-#, fuzzy
> msgid "git notes [--ref <notes_ref>] edit [--allow-empty] [<object>]"
>-msgstr "git notes [--ref <Notiz-Referenz>] edit [<Objekt>]"
>+msgstr "git notes [--ref <Notiz-Referenz>] edit [--allow-empty]
>[<Objekt>]"
>=20
> #: builtin/notes.c:29
> msgid "git notes [--ref <notes_ref>] show [<object>]"
>@@ -7833,7 +7825,7 @@ msgstr "Wiederverwendung des angegebenen
>Notiz-Objektes"
>=20
> #: builtin/notes.c:404 builtin/notes.c:567
> msgid "allow storing empty note"
>-msgstr ""
>+msgstr "Speichern leerer Notiz erlauben"
>=20
> #: builtin/notes.c:405 builtin/notes.c:476
> msgid "replace existing notes"
>@@ -8124,9 +8116,8 @@ msgid "create thin packs"
> msgstr "d=C3=BCnnere Pakete erzeugen"
>=20
> #: builtin/pack-objects.c:2682
>-#, fuzzy
> msgid "create packs suitable for shallow fetches"
>-msgstr "Platzhalter als Shell-String formatieren"
>+msgstr "Pakete geeignet f=C3=BCr Abholung mit unvollst=C3=A4ndiger Hi=
storie
>(shallow) erzeugen"
>=20
> #: builtin/pack-objects.c:2684
> msgid "ignore packs that have companion .keep file"
>@@ -9846,7 +9837,7 @@ msgstr "Grund f=C3=BCr die Aktualisierung"
> msgid ""
>"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname>
>[<head>]"
> msgstr ""
>-"git tag [-a|-s|-u <Schl=C3=BCssel-id>] [-f] [-m <Nachricht>|-F <Date=
i>]
><Tagname> "
>+"git tag [-a|-s|-u <Schl=C3=BCssel-id>] [-f] [-m <Beschreibung>|-F <D=
atei>]
><Tagname> "
> "[<Commit>]"
>=20
> #: builtin/tag.c:23
