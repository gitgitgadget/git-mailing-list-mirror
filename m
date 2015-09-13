From: =?UTF-8?Q?Matthias_R=c3=bcster?= <matthias.ruester@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 123 new messages
Date: Sun, 13 Sep 2015 20:37:02 +0200
Message-ID: <55F5C24E.3000101@gmail.com>
References: <1441985744-882-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, magnus.goerlitz@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:37:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbC9K-0006o8-Jr
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 20:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049AbbIMShH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Sep 2015 14:37:07 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33498 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbbIMShG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 14:37:06 -0400
Received: by wiclk2 with SMTP id lk2so115610692wic.0
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 11:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=uIshXaZlVshEk4ZkfxVSpN3lzta5fPq3TpR3EI6rbTA=;
        b=hqh9vyeRgPNn7zzP9yFfNwGNgflsimcDdg1Pw/Ykof/LYyZ8vghUTHpM57TL2x1i/6
         VAxkYpSmnywI7nWycekCVekx/VOMjaYBcQcNOO3WoPUB3LNKKO4fvYQnFR/g7wipkXvM
         Nc57dZPo3cdVbRuuYVyvrhdWtQLaRrJADeokiwMH3IjT9B03b2CC5jcYrnYO+t0ckFHY
         WcasrzEGi89YGHXrgSymhX4VHkwBYndREKJHYohoGVNCaFwWtzt4SePKG3Onf9hJVyfv
         zRiii7M2oXFzoi0JlSIhjL+u3LSNIYL8sOCAZH7sZpaX30MYE6n9iThgpwGyLD7BiMK4
         KwSg==
X-Received: by 10.194.60.243 with SMTP id k19mr20377568wjr.8.1442169424401;
        Sun, 13 Sep 2015 11:37:04 -0700 (PDT)
Received: from ?IPv6:2a02:8108:2bc0:1154:5555:45f6:e25b:ea5e? ([2a02:8108:2bc0:1154:5555:45f6:e25b:ea5e])
        by smtp.googlemail.com with ESMTPSA id fx2sm10206657wib.24.2015.09.13.11.37.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Sep 2015 11:37:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <1441985744-882-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277791>

Hi Ralf,

thanks for your work!
I have only a few things to add:


one little typo:

> @@ -1228,20 +1227,19 @@ msgstr[1] ""
>   msgid "  (use \"git pull\" to merge the remote branch into yours)\n=
"
>   msgstr ""
>   "  (benutzen Sie \"git pull\", um Ihren Branch mit dem Remote-Branc=
h "
>   "zusammenzuf=C3=BChren)\n"
>
>   #: revision.c:2198
> -#, fuzzy
>   msgid "your current branch appears to be broken"
> -msgstr "Sie sind auf einem Branch, der noch geboren wird"
> +msgstr "Ihr aktuell Branch scheint fehlerhaft zu sein."
>
>   #: revision.c:2201
> -#, fuzzy, c-format
> +#, c-format
>   msgid "your current branch '%s' does not have any commits yet"
> -msgstr "Branch '%s' zeigt auf keinen Commit"
> +msgstr "Ihr aktueller Branch '%s' hat noch keine Commits."
>
>   #: revision.c:2395
>   msgid "--first-parent is incompatible with --bisect"
>   msgstr "Die Optionen --first-parent und --bisect sind inkompatibel.=
"
>
>   #: run-command.c:83


Should be: "Ihr aktueller Branch scheint fehlerhaft zu sein."

And here:

> @@ -1896,44 +1894,41 @@ msgstr "  (benutzen Sie \"git am --skip\", um=
 diesen Patch auszulassen)"
>   msgid "  (use \"git am --abort\" to restore the original branch)"
>   msgstr ""
>   "  (benutzen Sie \"git am --abort\", um den urspr=C3=BCnglichen Bra=
nch "
>   "wiederherzustellen)"
>
>   #: wt-status.c:1105
> -#, fuzzy
>   msgid "No commands done."
> -msgstr "Keine Commits geparst."
> +msgstr "Keine Kommandos ausgef=C3=BChrt."
>
>   #: wt-status.c:1108
>   #, c-format
>   msgid "Last command done (%d command done):"
>   msgid_plural "Last commands done (%d commands done):"
> -msgstr[0] ""
> -msgstr[1] ""
> +msgstr[0] "Letztes Kommando ausgef=C3=BChrt (%d Kommandos ausgef=C3=BC=
hrt):"
> +msgstr[1] "Letzte Kommandos ausgef=C3=BChrt (%d Kommandos ausgef=C3=BC=
hrt):"
>
>   #: wt-status.c:1119
>   #, c-format

in the first version the singular "command" is used:
[0] ... (%d Kommando ausgef=C3=BChrt):


Should be the same here:

>   #: wt-status.c:1127
>   #, c-format
>   msgid "Next command to do (%d remaining command):"
>   msgid_plural "Next commands to do (%d remaining commands):"
> -msgstr[0] ""
> -msgstr[1] ""
> +msgstr[0] "N=C3=A4chstes auszuf=C3=BChrendes Kommando (%d Kommandos =
verbleibend):"
> +msgstr[1] "N=C3=A4chste auszuf=C3=BChrende Kommandos (%d Kommandos v=
erbleibend):"
>

[0] ... (%d Kommando verbleibend)


Maybe leave the apostrophes in this message since it is not in the=20
english version (?):

> @@ -2504,15 +2494,15 @@ msgstr "auf leere Historie anwenden"
>   #: builtin/am.c:1684 builtin/commit.c:1752 builtin/merge.c:829
>   #: builtin/merge.c:854
>   msgid "failed to write commit object"
>   msgstr "Fehler beim Schreiben des Commit-Objektes."
>
>   #: builtin/am.c:1716 builtin/am.c:1720
> -#, fuzzy, c-format
> +#, c-format
>   msgid "cannot resume: %s does not exist."
> -msgstr "Branch '%s' existiert nicht"
> +msgstr "Kann nicht fortsetzen: '%s' existiert nicht"
>
>   #: builtin/am.c:1736
>   msgid "cannot be interactive without stdin connected to a terminal.=
"
>   msgstr ""
>   "Kann nicht interaktiv sein, ohne dass die Standard-Eingabe mit ein=
em "
>   "Terminal verbunden ist."

"Kann nicht fortsetzen: %s existiert nicht"


This:

>
>   #: builtin/am.c:2194
> -#, fuzzy
>   msgid "git am [options] [(<mbox>|<Maildir>)...]"
> -msgstr "git merge [<Optionen>] [<Commit>...]"
> +msgstr "git am [Optionen] [(<mbox>|<E-Mail-Verzeichnis>)...]"
>
>   #: builtin/am.c:2195
> -#, fuzzy
>   msgid "git am [options] (--continue | --skip | --abort)"
> -msgstr "versuchen Sie \"git cherry-pick (--continue | --quit | --abo=
rt)\""
> +msgstr "git am [Optionen] (--continue | --quit | --abort)"
>


should be:
"git am [Optionen] (--continue | --skip | --abort)"

(--skip instead of --quit)



One little typo here:

> @@ -9289,19 +9270,18 @@ msgstr "Die Option --delete ist inkompatibel =
mit --all, --mirror und --tags."
>
>   #: builtin/push.c:581
>   msgid "--delete doesn't make sense without any refs"
>   msgstr "Die Option --delete kann nur mit Referenzen verwendet werde=
n."
>
>   #: builtin/read-tree.c:37
> -#, fuzzy
>   msgid ""
>   "git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=
=3D<prefix>) "
>   "[-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-ch=
eckout] [--"
>   "index-output=3D<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-=
ish3>]])"
>   msgstr ""
> -"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<Pr=C3=A4fix>] "
> +"git read-tree [([-m [--trivial] [--aggressive] | --reset | --prefix=
=3D<Pr=C3=A4fix>) "
>   "[-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-ch=
eckout] [--"
>   "index-output=3D<Datei>] (--empty | <Commit-Referenz1> [<Commit-Ref=
erenz2> "
>   "[<Commit-Referenz3>]])"
>
>   #: builtin/read-tree.c:110
>   msgid "write resulting index to <file>"


[([-m [--trivial] should be [(-m [--trivial]


> @@ -11246,16 +11226,15 @@ msgstr "mit anderen zusammenarbeiten (siehe=
 auch: git help workflows)"
>
>   #: common-cmds.h:17
>   msgid "Add file contents to the index"
>   msgstr "Dateiinhalte zum Commit vormerken"
>
>   #: common-cmds.h:18
> -#, fuzzy
>   msgid "Use binary search to find the commit that introduced a bug"
> -msgstr ""
> -"=C3=BCber eine Bin=C3=A4rsuche die =C3=84nderungen finden, die eine=
n Fehler verursacht haben"
> +msgstr "Bin=C3=A4rsuche verwenden, um den Commit finden, der einen F=
ehler "
> +"verursacht hat"
>
>   #: common-cmds.h:19
>   msgid "List, create, or delete branches"
>   msgstr "Branches anzeigen, erstellen oder entfernen"
>
>   #: common-cmds.h:20

=2E.., um den Commit zu finden, ...


Everything else looks great!

Kind regards,
Matthias
