From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 123 new messages
Date: Mon, 14 Sep 2015 19:16:50 +0200
Message-ID: <CAN0XMOL53VbXV9p+yFSJccFVmePBELswRFrkfofiUF9qt8=iCg@mail.gmail.com>
References: <1441985744-882-1-git-send-email-ralf.thielow@gmail.com>
	<55F5C24E.3000101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Phillip Sz <phillip.szelat@gmail.com>,
	Magnus G <magnus.goerlitz@googlemail.com>
To: =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 19:16:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbXNB-00005q-D6
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 19:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755623AbbINRQx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Sep 2015 13:16:53 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:32832 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683AbbINRQw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Sep 2015 13:16:52 -0400
Received: by lamp12 with SMTP id p12so90239705lam.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 10:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=iJGlVhgBrXeB1/HlqG4O8j8KCBTiRFE3Ki5KdiMJ4O4=;
        b=K/iJ8vPT3qpx5riDpbvkGg9Fr/qBbtr/mzKMwwfX3Wgom41z8eJNAqsVKfssOW+bOd
         lRdy+ShoKCswxh+OfilCXG8xssYw80ekE3aHnnJIET8rooA39PSIDYYVGtz7PQd0axJU
         YDb5ZbJLZCa6E/ExHf8q1vbPnsV5HdUednw/FqOgFK/Ga5WabV0qWhFMdYwMrd+AEE7y
         ZsxuXlIkP4Ru7jItHwigS+CGZcc892fZMwXzrPVSNwOhatjDawK4wUQl/BKPK5N+dIyh
         OSUhAhOnuKtPRLMB3O6dDIKudxx7OJx33pipNr2fH9X2YtV5aPLGkuT1lG9HRX7k/Ykq
         DJ+g==
X-Received: by 10.112.181.197 with SMTP id dy5mr15687791lbc.109.1442251010782;
 Mon, 14 Sep 2015 10:16:50 -0700 (PDT)
Received: by 10.25.201.211 with HTTP; Mon, 14 Sep 2015 10:16:50 -0700 (PDT)
In-Reply-To: <55F5C24E.3000101@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277844>

Hi,

thanks for review! Good eyes. :-)

2015-09-13 20:37 GMT+02:00 Matthias R=C3=BCster <matthias.ruester@gmail=
=2Ecom>:
> Hi Ralf,
>
> thanks for your work!
> I have only a few things to add:
>
>
> one little typo:
>
>> @@ -1228,20 +1227,19 @@ msgstr[1] ""
>>   msgid "  (use \"git pull\" to merge the remote branch into yours)\=
n"
>>   msgstr ""
>>   "  (benutzen Sie \"git pull\", um Ihren Branch mit dem Remote-Bran=
ch "
>>   "zusammenzuf=C3=BChren)\n"
>>
>>   #: revision.c:2198
>> -#, fuzzy
>>   msgid "your current branch appears to be broken"
>> -msgstr "Sie sind auf einem Branch, der noch geboren wird"
>> +msgstr "Ihr aktuell Branch scheint fehlerhaft zu sein."
>>
>>   #: revision.c:2201
>> -#, fuzzy, c-format
>> +#, c-format
>>   msgid "your current branch '%s' does not have any commits yet"
>> -msgstr "Branch '%s' zeigt auf keinen Commit"
>> +msgstr "Ihr aktueller Branch '%s' hat noch keine Commits."
>>
>>   #: revision.c:2395
>>   msgid "--first-parent is incompatible with --bisect"
>>   msgstr "Die Optionen --first-parent und --bisect sind inkompatibel=
=2E"
>>
>>   #: run-command.c:83
>
>
>
> Should be: "Ihr aktueller Branch scheint fehlerhaft zu sein."
>
> And here:
>
>> @@ -1896,44 +1894,41 @@ msgstr "  (benutzen Sie \"git am --skip\", u=
m
>> diesen Patch auszulassen)"
>>   msgid "  (use \"git am --abort\" to restore the original branch)"
>>   msgstr ""
>>   "  (benutzen Sie \"git am --abort\", um den urspr=C3=BCnglichen Br=
anch "
>>   "wiederherzustellen)"
>>
>>   #: wt-status.c:1105
>> -#, fuzzy
>>   msgid "No commands done."
>> -msgstr "Keine Commits geparst."
>> +msgstr "Keine Kommandos ausgef=C3=BChrt."
>>
>>   #: wt-status.c:1108
>>   #, c-format
>>   msgid "Last command done (%d command done):"
>>   msgid_plural "Last commands done (%d commands done):"
>> -msgstr[0] ""
>> -msgstr[1] ""
>> +msgstr[0] "Letztes Kommando ausgef=C3=BChrt (%d Kommandos ausgef=C3=
=BChrt):"
>> +msgstr[1] "Letzte Kommandos ausgef=C3=BChrt (%d Kommandos ausgef=C3=
=BChrt):"
>>
>>   #: wt-status.c:1119
>>   #, c-format
>
>
> in the first version the singular "command" is used:
> [0] ... (%d Kommando ausgef=C3=BChrt):
>
>
> Should be the same here:
>
>>   #: wt-status.c:1127
>>   #, c-format
>>   msgid "Next command to do (%d remaining command):"
>>   msgid_plural "Next commands to do (%d remaining commands):"
>> -msgstr[0] ""
>> -msgstr[1] ""
>> +msgstr[0] "N=C3=A4chstes auszuf=C3=BChrendes Kommando (%d Kommandos=
 verbleibend):"
>> +msgstr[1] "N=C3=A4chste auszuf=C3=BChrende Kommandos (%d Kommandos =
verbleibend):"
>>
>
> [0] ... (%d Kommando verbleibend)
>
>
> Maybe leave the apostrophes in this message since it is not in the en=
glish
> version (?):
>
>> @@ -2504,15 +2494,15 @@ msgstr "auf leere Historie anwenden"
>>   #: builtin/am.c:1684 builtin/commit.c:1752 builtin/merge.c:829
>>   #: builtin/merge.c:854
>>   msgid "failed to write commit object"
>>   msgstr "Fehler beim Schreiben des Commit-Objektes."
>>
>>   #: builtin/am.c:1716 builtin/am.c:1720
>> -#, fuzzy, c-format
>> +#, c-format
>>   msgid "cannot resume: %s does not exist."
>> -msgstr "Branch '%s' existiert nicht"
>> +msgstr "Kann nicht fortsetzen: '%s' existiert nicht"
>>
>>   #: builtin/am.c:1736
>>   msgid "cannot be interactive without stdin connected to a terminal=
=2E"
>>   msgstr ""
>>   "Kann nicht interaktiv sein, ohne dass die Standard-Eingabe mit ei=
nem "
>>   "Terminal verbunden ist."
>
>
> "Kann nicht fortsetzen: %s existiert nicht"
>
>
> This:
>
>>
>>   #: builtin/am.c:2194
>> -#, fuzzy
>>   msgid "git am [options] [(<mbox>|<Maildir>)...]"
>> -msgstr "git merge [<Optionen>] [<Commit>...]"
>> +msgstr "git am [Optionen] [(<mbox>|<E-Mail-Verzeichnis>)...]"
>>
>>   #: builtin/am.c:2195
>> -#, fuzzy
>>   msgid "git am [options] (--continue | --skip | --abort)"
>> -msgstr "versuchen Sie \"git cherry-pick (--continue | --quit |
>> --abort)\""
>> +msgstr "git am [Optionen] (--continue | --quit | --abort)"
>>
>
>
> should be:
> "git am [Optionen] (--continue | --skip | --abort)"
>
> (--skip instead of --quit)
>
>
>
> One little typo here:
>
>> @@ -9289,19 +9270,18 @@ msgstr "Die Option --delete ist inkompatibel=
 mit
>> --all, --mirror und --tags."
>>
>>   #: builtin/push.c:581
>>   msgid "--delete doesn't make sense without any refs"
>>   msgstr "Die Option --delete kann nur mit Referenzen verwendet werd=
en."
>>
>>   #: builtin/read-tree.c:37
>> -#, fuzzy
>>   msgid ""
>>   "git read-tree [(-m [--trivial] [--aggressive] | --reset |
>> --prefix=3D<prefix>) "
>>   "[-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-c=
heckout]
>> [--"
>>   "index-output=3D<file>] (--empty | <tree-ish1> [<tree-ish2>
>> [<tree-ish3>]])"
>>   msgstr ""
>> -"git read-tree [[-m [--trivial] [--aggressive] | --reset |
>> --prefix=3D<Pr=C3=A4fix>] "
>> +"git read-tree [([-m [--trivial] [--aggressive] | --reset |
>> --prefix=3D<Pr=C3=A4fix>) "
>>   "[-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-c=
heckout]
>> [--"
>>   "index-output=3D<Datei>] (--empty | <Commit-Referenz1> [<Commit-Re=
ferenz2>
>> "
>>   "[<Commit-Referenz3>]])"
>>
>>   #: builtin/read-tree.c:110
>>   msgid "write resulting index to <file>"
>
>
>
> [([-m [--trivial] should be [(-m [--trivial]
>
>
>> @@ -11246,16 +11226,15 @@ msgstr "mit anderen zusammenarbeiten (sieh=
e
>> auch: git help workflows)"
>>
>>   #: common-cmds.h:17
>>   msgid "Add file contents to the index"
>>   msgstr "Dateiinhalte zum Commit vormerken"
>>
>>   #: common-cmds.h:18
>> -#, fuzzy
>>   msgid "Use binary search to find the commit that introduced a bug"
>> -msgstr ""
>> -"=C3=BCber eine Bin=C3=A4rsuche die =C3=84nderungen finden, die ein=
en Fehler verursacht
>> haben"
>> +msgstr "Bin=C3=A4rsuche verwenden, um den Commit finden, der einen =
=46ehler "
>> +"verursacht hat"
>>
>>   #: common-cmds.h:19
>>   msgid "List, create, or delete branches"
>>   msgstr "Branches anzeigen, erstellen oder entfernen"
>>
>>   #: common-cmds.h:20
>
>
> ..., um den Commit zu finden, ...
>
>
> Everything else looks great!
>
> Kind regards,
> Matthias
