From: =?UTF-8?B?TWF0dGhpYXMgUsO8c3Rlcg==?= <matthias.ruester@gmail.com>
Subject: Re: [PATCH 1/1] l10n: de.po: use "bla =?UTF-8?B?4oCmIiBpbnN0ZWFk?=
 =?UTF-8?B?IG9mICJibGEuLi4i?=
Date: Sat, 21 Mar 2015 15:07:02 +0100
Message-ID: <550D7B06.4080807@gmail.com>
References: <1426942357-5618-1-git-send-email-phillip.szelat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	magnus.goerlitz@googlemail.com, ralf.thielow@gmail.com
To: Phillip Sz <phillip.szelat@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 15:07:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZK3f-0003aN-5u
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 15:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbbCUOHK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2015 10:07:10 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37954 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbbCUOHG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 10:07:06 -0400
Received: by wibgn9 with SMTP id gn9so14406052wib.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2015 07:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ildv5S2IR+OrEDE4Ni/B9eKX7YIobOkAWZRLYtYPJnQ=;
        b=bQZWtLzKjFVtkWFhOV2vgcfvII1p9AImeactDmiRMVRZjLIiHuo15GvVrK0id2u/sR
         E5X01GvJqwV15wkSV51curvXWFhRz9TXUqf6tP0O/L1q+DUYDL7jTnvZ/SGO6M6UGi2l
         1rulHl1gM0mmKz17fBJXaQ3x87uDZOwo51VICT7Bwy4oZ1y0Zgx0sGSCChNmlW8IrwIT
         8CmtmS4ZoIWWUK0n0e3ErmpbiNZ/sXR4GWydd6Or0aHPxurgN0dLPaRA+ljKUE4uP/Fj
         4V9u5128LW3XkpBS4a4pkwQ4YeI46Rd7IsjWVZtcHdjSD5yU5v4ss7zTbuemBiq9GEsK
         iblw==
X-Received: by 10.194.185.9 with SMTP id ey9mr171983265wjc.135.1426946824956;
        Sat, 21 Mar 2015 07:07:04 -0700 (PDT)
Received: from [10.30.1.49] ([193.25.42.141])
        by mx.google.com with ESMTPSA id l6sm10747440wjx.33.2015.03.21.07.07.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2015 07:07:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1426942357-5618-1-git-send-email-phillip.szelat@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266024>

Hi,

as long as the original messages do not have a space between the word=20
and the ellipsis I would not do it differently in the translation.

=46or me the standard way of writing a repeating argument is the other =
way=20
around: <path>...
Command-line tools I've used (so far) always use this format.

I can also point out the docopt project here (see docopt.org).

The use of the UTF-8 character 'horizontal ellipsis' is IMO not=20
necessary. Plus it just looks like a line if you use a smaller terminal=
=20
font.

You should consider the usage messages as a technical=20
document/description and not literature.

This is my opinion so far...

Kind regards
Matthias


On 03/21/2015 01:52 PM, Phillip Sz wrote:
> Hi,
>
> I think we should use it like this, as most open-source projects do.
> Also we should use a space before the three dots as per http://www.du=
den.de/sprachwissen/rechtschreibregeln/auslassungspunkte
>
> Phillip
>
> Signed-off-by: Phillip Sz <phillip.szelat@gmail.com>
> ---
>   po/de.po | 190 +++++++++++++++++++++++++++++++---------------------=
-----------
>   1 file changed, 95 insertions(+), 95 deletions(-)
>
> diff --git a/po/de.po b/po/de.po
> index 11fbd0f..4c1e90e 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -33,7 +33,7 @@ msgstr ""
>
>   #: archive.c:11
>   msgid "git archive [options] <tree-ish> [<path>...]"
> -msgstr "git archive [Optionen] <Commit-Referenz> [<Pfad>...]"
> +msgstr "git archive [Optionen] <Commit-Referenz> [<Pfad> =E2=80=A6]"
>
>   #: archive.c:12
>   msgid "git archive --list"
> @@ -44,7 +44,7 @@ msgid ""
>   "git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [<=
path>...]"
>   msgstr ""
>   "git archive --remote <Repository> [--exec <Programm>] [Optionen] <=
Commit-"
> -"Referenz> [Pfad...]"
> +"Referenz> [Pfad =E2=80=A6]"
>
>   #: archive.c:14
>   msgid "git archive --remote <repo> [--exec <cmd>] --list"
> @@ -616,7 +616,7 @@ msgstr ""
>   #: help.c:373
>   #, c-format
>   msgid "in %0.1f seconds automatically..."
> -msgstr "Automatische Ausf=C3=BChrung in %0.1f Sekunden..."
> +msgstr "Automatische Ausf=C3=BChrung in %0.1f Sekunden =E2=80=A6"
>
>   #: help.c:380
>   #, c-format
> @@ -945,7 +945,7 @@ msgstr "Konnte Objekt '%s' nicht parsen."
>
>   #: parse-options.c:546
>   msgid "..."
> -msgstr "..."
> +msgstr " =E2=80=A6"
>
>   #: parse-options.c:564
>   #, c-format
> @@ -1271,12 +1271,12 @@ msgstr "Kann keine Commit-Beschreibung f=C3=BC=
r %s bekommen"
>   #: sequencer.c:611
>   #, c-format
>   msgid "could not revert %s... %s"
> -msgstr "Konnte \"revert\" nicht auf %s ausf=C3=BChren... %s"
> +msgstr "Konnte \"revert\" nicht auf %s ausf=C3=BChren =E2=80=A6 %s"
>
>   #: sequencer.c:612
>   #, c-format
>   msgid "could not apply %s... %s"
> -msgstr "Konnte %s nicht anwenden... %s"
> +msgstr "Konnte %s nicht anwenden =E2=80=A6 %s"
>
>   #: sequencer.c:648
>   msgid "empty commit set passed"
> @@ -1425,7 +1425,7 @@ msgstr ""
>   "Sie diese angeben. Diese Referenzen k=C3=B6nnten aus Versehen\n"
>   "erzeugt worden sein. Zum Beispiel,\n"
>   "\n"
> -"  git checkout -b $br $(git rev-parse ...)\n"
> +"  git checkout -b $br $(git rev-parse =E2=80=A6)\n"
>   "\n"
>   "wobei \"$br\" leer ist und eine 40-Hex-Referenz erzeugt\n"
>   "wurde. Bitte pr=C3=BCfen Sie diese Referenzen und l=C3=B6schen\n"
> @@ -1576,30 +1576,30 @@ msgstr "Nicht zusammengef=C3=BChrte Pfade:"
>   #, c-format
>   msgid "  (use \"git reset %s <file>...\" to unstage)"
>   msgstr ""
> -"  (benutzen Sie \"git reset %s <Datei>...\" zum Entfernen aus der S=
taging-"
> +"  (benutzen Sie \"git reset %s <Datei> =E2=80=A6\" zum Entfernen au=
s der Staging-"
>   "Area)"
>
>   #: wt-status.c:179 wt-status.c:206
>   msgid "  (use \"git rm --cached <file>...\" to unstage)"
>   msgstr ""
> -"  (benutzen Sie \"git rm --cached <Datei>...\" zum Entfernen aus de=
r Staging-"
> +"  (benutzen Sie \"git rm --cached <Datei> =E2=80=A6\" zum Entfernen=
 aus der Staging-"
>   "Area)"
>
>   #: wt-status.c:183
>   msgid "  (use \"git add <file>...\" to mark resolution)"
>   msgstr ""
> -"  (benutzen Sie \"git add/rm <Datei>...\", um die Aufl=C3=B6sung zu=
 markieren)"
> +"  (benutzen Sie \"git add/rm <Datei> =E2=80=A6\", um die Aufl=C3=B6=
sung zu markieren)"
>
>   #: wt-status.c:185 wt-status.c:189
>   msgid "  (use \"git add/rm <file>...\" as appropriate to mark resol=
ution)"
>   msgstr ""
> -"  (benutzen Sie \"git add/rm <Datei>...\", um die Aufl=C3=B6sung en=
tsprechend zu "
> +"  (benutzen Sie \"git add/rm <Datei> =E2=80=A6\", um die Aufl=C3=B6=
sung entsprechend zu "
>   "markieren)"
>
>   #: wt-status.c:187
>   msgid "  (use \"git rm <file>...\" to mark resolution)"
>   msgstr ""
> -"  (benutzen Sie \"git add/rm <Datei>...\", um die Aufl=C3=B6sung zu=
 markieren)"
> +"  (benutzen Sie \"git add/rm <Datei> =E2=80=A6\", um die Aufl=C3=B6=
sung zu markieren)"
>
>   #: wt-status.c:198
>   msgid "Changes to be committed:"
> @@ -1612,20 +1612,20 @@ msgstr "=C3=84nderungen, die nicht zum Commit=
 vorgemerkt sind:"
>   #: wt-status.c:220
>   msgid "  (use \"git add <file>...\" to update what will be committe=
d)"
>   msgstr ""
> -"  (benutzen Sie \"git add <Datei>...\", um die =C3=84nderungen zum =
Commit "
> +"  (benutzen Sie \"git add <Datei> =E2=80=A6\", um die =C3=84nderung=
en zum Commit "
>   "vorzumerken)"
>
>   #: wt-status.c:222
>   msgid "  (use \"git add/rm <file>...\" to update what will be commi=
tted)"
>   msgstr ""
> -"  (benutzen Sie \"git add/rm <Datei>...\", um die =C3=84nderungen z=
um Commit "
> +"  (benutzen Sie \"git add/rm <Datei> =E2=80=A6\", um die =C3=84nder=
ungen zum Commit "
>   "vorzumerken)"
>
>   #: wt-status.c:223
>   msgid ""
>   "  (use \"git checkout -- <file>...\" to discard changes in working=
 directory)"
>   msgstr ""
> -"  (benutzen Sie \"git checkout -- <Datei>...\", um die =C3=84nderun=
gen im "
> +"  (benutzen Sie \"git checkout -- <Datei> =E2=80=A6\", um die =C3=84=
nderungen im "
>   "Arbeitsverzeichnis zu verwerfen)"
>
>   #: wt-status.c:225
> @@ -1638,7 +1638,7 @@ msgstr ""
>   #, c-format
>   msgid "  (use \"git %s <file>...\" to include in what will be commi=
tted)"
>   msgstr ""
> -"  (benutzen Sie \"git %s <Datei>...\", um die =C3=84nderungen zum C=
ommit "
> +"  (benutzen Sie \"git %s <Datei> =E2=80=A6\", um die =C3=84nderunge=
n zum Commit "
>   "vorzumerken)"
>
>   #: wt-status.c:252
> @@ -2035,7 +2035,7 @@ msgstr "Konnte '%s' nicht entfernen."
>
>   #: builtin/add.c:22
>   msgid "git add [options] [--] <pathspec>..."
> -msgstr "git add [Optionen] [--] [<Pfadspezifikation>...]"
> +msgstr "git add [Optionen] [--] [<Pfadspezifikation> =E2=80=A6]"
>
>   #: builtin/add.c:65
>   #, c-format
> @@ -2187,7 +2187,7 @@ msgstr "Konnte neue Staging-Area-Datei nicht sc=
hreiben."
>
>   #: builtin/apply.c:58
>   msgid "git apply [options] [<patch>...]"
> -msgstr "git apply [Optionen] [<Patch>...]"
> +msgstr "git apply [Optionen] [<Patch> =E2=80=A6]"
>
>   #: builtin/apply.c:111
>   #, c-format
> @@ -2436,7 +2436,7 @@ msgstr "%s: Patch konnte nicht angewendet werde=
n"
>   #: builtin/apply.c:3653
>   #, c-format
>   msgid "Checking patch %s..."
> -msgstr "Pr=C3=BCfe Patch %s..."
> +msgstr "Pr=C3=BCfe Patch %s =E2=80=A6"
>
>   #: builtin/apply.c:3746 builtin/checkout.c:231 builtin/reset.c:135
>   #, c-format
> @@ -2848,7 +2848,7 @@ msgstr "git branch [Optionen] [-l] [-f] <Branch=
name> [<Startpunkt>]"
>
>   #: builtin/branch.c:26
>   msgid "git branch [options] [-r] (-d | -D) <branchname>..."
> -msgstr "git branch [Optionen] [-r] (-d | -D) <Branchname>..."
> +msgstr "git branch [Optionen] [-r] (-d | -D) <Branchname> =E2=80=A6"
>
>   #: builtin/branch.c:27
>   msgid "git branch [options] (-m | -M) [<oldbranch>] <newbranch>"
> @@ -3318,12 +3318,12 @@ msgstr ""
>
>   #: builtin/check-attr.c:11
>   msgid "git check-attr [-a | --all | attr...] [--] pathname..."
> -msgstr "git check-attr [-a | --all | Attribut...] [--] Pfadname..."
> +msgstr "git check-attr [-a | --all | Attribut =E2=80=A6] [--] Pfadna=
me =E2=80=A6"
>
>   #: builtin/check-attr.c:12
>   msgid "git check-attr --stdin [-z] [-a | --all | attr...] < <list-o=
f-paths>"
>   msgstr ""
> -"git check-attr --stdin [-z] [-a | --all | Attribut...] < <Liste-von=
-Pfaden>"
> +"git check-attr --stdin [-z] [-a | --all | Attribut =E2=80=A6] < <Li=
ste-von-Pfaden>"
>
>   #: builtin/check-attr.c:19
>   msgid "report all attributes set on file"
> @@ -3380,7 +3380,7 @@ msgstr "--non-matching ist nur mit --verbose zu=
l=C3=A4ssig"
>
>   #: builtin/check-mailmap.c:8
>   msgid "git check-mailmap [options] <contact>..."
> -msgstr "git check-mailmap [Optionen] <Kontakt>..."
> +msgstr "git check-mailmap [Optionen] <Kontakt> =E2=80=A6"
>
>   #: builtin/check-mailmap.c:13
>   msgid "also read contacts from stdin"
> @@ -3397,7 +3397,7 @@ msgstr "keine Kontakte angegeben"
>
>   #: builtin/checkout-index.c:126
>   msgid "git checkout-index [options] [--] [<file>...]"
> -msgstr "git checkout-index [Optionen] [--] [<Datei>...]"
> +msgstr "git checkout-index [Optionen] [--] [<Datei> =E2=80=A6]"
>
>   #: builtin/checkout-index.c:188
>   msgid "check out all files in the index"
> @@ -3448,7 +3448,7 @@ msgstr "git checkout [Optionen] <Branch>"
>
>   #: builtin/checkout.c:26
>   msgid "git checkout [options] [<branch>] -- <file>..."
> -msgstr "git checkout [Optionen] [<Branch>] -- <Datei>..."
> +msgstr "git checkout [Optionen] [<Branch>] -- <Datei> =E2=80=A6"
>
>   #: builtin/checkout.c:132 builtin/checkout.c:165
>   #, c-format
> @@ -3547,7 +3547,7 @@ msgstr "Zu Branch '%s' gewechselt\n"
>   #: builtin/checkout.c:723
>   #, c-format
>   msgid " ... and %d more.\n"
> -msgstr " ... und %d weitere.\n"
> +msgstr " =E2=80=A6 und %d weitere.\n"
>
>   #: builtin/checkout.c:729
>   #, c-format
> @@ -3746,7 +3746,7 @@ msgstr ""
>   msgid ""
>   "git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <=
paths>..."
>   msgstr ""
> -"git clean [-d] [-f] [-i] [-n] [-q] [-e <Muster>] [-x | -X] [--] <Pf=
ade>..."
> +"git clean [-d] [-f] [-i] [-n] [-q] [-e <Muster>] [-x | -X] [--] <Pf=
ade> =E2=80=A6"
>
>   #: builtin/clean.c:30
>   #, c-format
> @@ -4091,7 +4091,7 @@ msgstr "Konnte zu klonenden Remote-Branch %s ni=
cht finden."
>   #: builtin/clone.c:561
>   #, c-format
>   msgid "Checking connectivity... "
> -msgstr "Pr=C3=BCfe Konnektivit=C3=A4t... "
> +msgstr "Pr=C3=BCfe Konnektivit=C3=A4t =E2=80=A6 "
>
>   #: builtin/clone.c:564
>   msgid "remote did not send all necessary objects"
> @@ -4165,12 +4165,12 @@ msgstr "Konnte Arbeitsverzeichnis '%s' nicht =
erstellen."
>   #: builtin/clone.c:870
>   #, c-format
>   msgid "Cloning into bare repository '%s'...\n"
> -msgstr "Klone in Bare-Repository '%s'...\n"
> +msgstr "Klone in Bare-Repository '%s' =E2=80=A6\n"
>
>   #: builtin/clone.c:872
>   #, c-format
>   msgid "Cloning into '%s'...\n"
> -msgstr "Klone nach '%s'...\n"
> +msgstr "Klone nach '%s' =E2=80=A6\n"
>
>   #: builtin/clone.c:897
>   msgid "--dissociate given, but there is no --reference"
> @@ -4240,11 +4240,11 @@ msgstr "Die Option --command muss an erster S=
telle stehen."
>
>   #: builtin/commit.c:37
>   msgid "git commit [options] [--] <pathspec>..."
> -msgstr "git commit [Optionen] [--] <Pfadspezifikation>..."
> +msgstr "git commit [Optionen] [--] <Pfadspezifikation> =E2=80=A6"
>
>   #: builtin/commit.c:42
>   msgid "git status [options] [--] <pathspec>..."
> -msgstr "git status [Optionen] [--] <Pfadspezifikation>..."
> +msgstr "git status [Optionen] [--] <Pfadspezifikation> =E2=80=A6"
>
>   #: builtin/commit.c:47
>   msgid ""
> @@ -4600,7 +4600,7 @@ msgstr ""
>   #: builtin/commit.c:1199
>   msgid "Clever... amending the last one with dirty index."
>   msgstr ""
> -"Klug... den letzten Commit mit einer ge=C3=A4nderten Staging-Area n=
achbessern."
> +"Klug =E2=80=A6 den letzten Commit mit einer ge=C3=A4nderten Staging=
-Area nachbessern."
>
>   #: builtin/commit.c:1201
>   msgid "Explicit paths specified without -i or -o; assuming --only p=
aths..."
> @@ -5258,7 +5258,7 @@ msgstr "Ausgabe anonymisieren"
>
>   #: builtin/fetch.c:20
>   msgid "git fetch [<options>] [<repository> [<refspec>...]]"
> -msgstr "git fetch [<Optionen>] [<Repository> [<Refspec>...]]"
> +msgstr "git fetch [<Optionen>] [<Repository> [<Refspec> =E2=80=A6]]"
>
>   #: builtin/fetch.c:21
>   msgid "git fetch [<options>] <group>"
> @@ -5266,7 +5266,7 @@ msgstr "git fetch [<Optionen>] <Gruppe>"
>
>   #: builtin/fetch.c:22
>   msgid "git fetch --multiple [<options>] [(<repository> | <group>)..=
=2E]"
> -msgstr "git fetch --multiple [<Optionen>] [(<Repository> | <Gruppe>)=
=2E..]"
> +msgstr "git fetch --multiple [<Optionen>] [(<Repository> | <Gruppe>)=
 =E2=80=A6]"
>
>   #: builtin/fetch.c:23
>   msgid "git fetch --all [<options>]"
> @@ -5620,7 +5620,7 @@ msgstr "Pr=C3=BCfe Objekt-Verzeichnisse"
>
>   #: builtin/fsck.c:603
>   msgid "git fsck [options] [<object>...]"
> -msgstr "git fsck [Optionen] [<Objekt>...]"
> +msgstr "git fsck [Optionen] [<Objekt> =E2=80=A6]"
>
>   #: builtin/fsck.c:609
>   msgid "show unreachable objects"
> @@ -5734,7 +5734,7 @@ msgstr ""
>
>   #: builtin/grep.c:23
>   msgid "git grep [options] [-e] <pattern> [<rev>...] [[--] <path>...=
]"
> -msgstr "git grep [Optionen] [-e] <Muster> [<Commit>...] [[--] <Pfad>=
=2E..]"
> +msgstr "git grep [Optionen] [-e] <Muster> [<Commit> =E2=80=A6] [[--]=
 <Pfad> =E2=80=A6]"
>
>   #: builtin/grep.c:218
>   #, c-format
> @@ -5972,10 +5972,10 @@ msgstr "Die Option --cached kann nicht mit \"=
Tree\"-Objekten verwendet werden."
>   #: builtin/hash-object.c:82
>   msgid ""
>   "git hash-object [-t <type>] [-w] [--path=3D<file>|--no-filters] [-=
-stdin] [--] "
> -"<file>..."
> +"<file> =E2=80=A6"
>   msgstr ""
>   "git hash-object [-t <Art>] [-w] [--path=3D<Datei>|--no-filters] [-=
-stdin] [--] "
> -"<Datei>..."
> +"<Datei> =E2=80=A6"
>
>   #: builtin/hash-object.c:83
>   msgid "git hash-object  --stdin-paths < <list-of-paths>"
> @@ -6576,11 +6576,11 @@ msgstr "Kann nicht auf Arbeitsverzeichnis '%s=
' zugreifen."
>
>   #: builtin/interpret-trailers.c:15
>   msgid ""
> -"git interpret-trailers [--trim-empty] [(--trailer <token>[(=3D|:)<v=
alue>])...] "
> -"[<file>...]"
> +"git interpret-trailers [--trim-empty] [(--trailer <token>[(=3D|:)<v=
alue>]) =E2=80=A6] "
> +"[<file> =E2=80=A6]"
>   msgstr ""
> -"git interpret-trailers [--trim-empty] [(--trailer <Token>[(=3D|:)<W=
ert>])...] "
> -"[<Datei>...]"
> +"git interpret-trailers [--trim-empty] [(--trailer <Token>[(=3D|:)<W=
ert>]) =E2=80=A6] "
> +"[<Datei> =E2=80=A6]"
>
>   #: builtin/interpret-trailers.c:25
>   msgid "trim empty trailers"
> @@ -6596,11 +6596,11 @@ msgstr "Anhang/Anh=C3=A4nge hinzuf=C3=BCgen"
>
>   #: builtin/log.c:41
>   msgid "git log [<options>] [<revision range>] [[--] <path>...]"
> -msgstr "git log [<Optionen>] [<Commitbereich>] [[--] <Pfad>...]"
> +msgstr "git log [<Optionen>] [<Commitbereich>] [[--] <Pfad> =E2=80=A6=
]"
>
>   #: builtin/log.c:42
>   msgid "git show [options] <object>..."
> -msgstr "git show [Optionen] <Objekt>..."
> +msgstr "git show [Optionen] <Objekt> =E2=80=A6"
>
>   #: builtin/log.c:81
>   #, c-format
> @@ -6882,7 +6882,7 @@ msgstr "Unbekannter Commit %s"
>
>   #: builtin/ls-files.c:401
>   msgid "git ls-files [options] [<file>...]"
> -msgstr "git ls-files [Optionen] [<Datei>...]"
> +msgstr "git ls-files [Optionen] [<Datei> =E2=80=A6]"
>
>   #: builtin/ls-files.c:458
>   msgid "identify the file status with tags"
> @@ -6981,7 +6981,7 @@ msgstr "Ausgaben zur Fehlersuche anzeigen"
>
>   #: builtin/ls-tree.c:28
>   msgid "git ls-tree [<options>] <tree-ish> [<path>...]"
> -msgstr "git ls-tree [<Optionen>] <Commit-Referenz> [<Pfad>...]"
> +msgstr "git ls-tree [<Optionen>] <Commit-Referenz> [<Pfad> =E2=80=A6=
]"
>
>   #: builtin/ls-tree.c:127
>   msgid "only show trees"
> @@ -7019,7 +7019,7 @@ msgstr ""
>
>   #: builtin/merge.c:45
>   msgid "git merge [options] [<commit>...]"
> -msgstr "git merge [Optionen] [<Commit>...]"
> +msgstr "git merge [Optionen] [<Commit> =E2=80=A6]"
>
>   #: builtin/merge.c:46
>   msgid "git merge [options] <msg> HEAD <commit>"
> @@ -7335,7 +7335,7 @@ msgstr "Aktualisiere %s..%s\n"
>   #: builtin/merge.c:1388
>   #, c-format
>   msgid "Trying really trivial in-index merge...\n"
> -msgstr "Probiere wirklich trivialen \"in-index\"-Merge...\n"
> +msgstr "Probiere wirklich trivialen \"in-index\"-Merge =E2=80=A6\n"
>
>   #: builtin/merge.c:1395
>   #, c-format
> @@ -7349,12 +7349,12 @@ msgstr "Vorspulen nicht m=C3=B6glich, breche =
ab."
>   #: builtin/merge.c:1450 builtin/merge.c:1529
>   #, c-format
>   msgid "Rewinding the tree to pristine...\n"
> -msgstr "R=C3=BCcklauf des Verzeichnisses bis zum Ursprung...\n"
> +msgstr "R=C3=BCcklauf des Verzeichnisses bis zum Ursprung =E2=80=A6\=
n"
>
>   #: builtin/merge.c:1454
>   #, c-format
>   msgid "Trying merge strategy %s...\n"
> -msgstr "Probiere Merge-Strategie %s...\n"
> +msgstr "Probiere Merge-Strategie %s =E2=80=A6\n"
>
>   #: builtin/merge.c:1520
>   #, c-format
> @@ -7379,15 +7379,15 @@ msgstr ""
>
>   #: builtin/merge-base.c:29
>   msgid "git merge-base [-a|--all] <commit> <commit>..."
> -msgstr "git merge-base [-a|--all] <Commit> <Commit>..."
> +msgstr "git merge-base [-a|--all] <Commit> <Commit> =E2=80=A6"
>
>   #: builtin/merge-base.c:30
>   msgid "git merge-base [-a|--all] --octopus <commit>..."
> -msgstr "git merge-base [-a|--all] --octopus <Commit>..."
> +msgstr "git merge-base [-a|--all] --octopus <Commit> =E2=80=A6"
>
>   #: builtin/merge-base.c:31
>   msgid "git merge-base --independent <commit>..."
> -msgstr "git merge-base --independent <Commit>..."
> +msgstr "git merge-base --independent <Commit> =E2=80=A6"
>
>   #: builtin/merge-base.c:32
>   msgid "git merge-base --is-ancestor <commit> <commit>"
> @@ -7475,7 +7475,7 @@ msgstr "die Erstellung von mehr als einem \"Tre=
e\"-Objekt erlauben"
>
>   #: builtin/mv.c:15
>   msgid "git mv [options] <source>... <destination>"
> -msgstr "git mv [Optionen] <Quelle>... <Ziel>"
> +msgstr "git mv [Optionen] <Quelle> =E2=80=A6 <Ziel>"
>
>   #: builtin/mv.c:69
>   #, c-format
> @@ -7570,7 +7570,7 @@ msgstr "Umbenennung von '%s' fehlgeschlagen"
>
>   #: builtin/name-rev.c:255
>   msgid "git name-rev [options] <commit>..."
> -msgstr "git name-rev [Optionen] <Commit>..."
> +msgstr "git name-rev [Optionen] <Commit> =E2=80=A6"
>
>   #: builtin/name-rev.c:256
>   msgid "git name-rev [options] --all"
> @@ -7658,7 +7658,7 @@ msgstr "git notes merge --abort [-v | -q]"
>
>   #: builtin/notes.c:33
>   msgid "git notes [--ref <notes_ref>] remove [<object>...]"
> -msgstr "git notes [--ref <Notiz-Referenz>] remove [<Objekt>...]"
> +msgstr "git notes [--ref <Notiz-Referenz>] remove [<Objekt> =E2=80=A6=
]"
>
>   #: builtin/notes.c:34
>   msgid "git notes [--ref <notes_ref>] prune [-n | -v]"
> @@ -7682,7 +7682,7 @@ msgstr "git notes copy [<Optionen>] <von-Objekt=
> <nach-Objekt>"
>
>   #: builtin/notes.c:51
>   msgid "git notes copy --stdin [<from-object> <to-object>]..."
> -msgstr "git notes copy --stdin [<von-Objekt> <nach-Objekt>]..."
> +msgstr "git notes copy --stdin [<von-Objekt> <nach-Objekt>] =E2=80=A6=
"
>
>   #: builtin/notes.c:56
>   msgid "git notes append [<options>] [<object>]"
> @@ -7950,12 +7950,12 @@ msgstr "Unbekanntes Unterkommando: %s"
>   #: builtin/pack-objects.c:28
>   msgid "git pack-objects --stdout [options...] [< ref-list | < objec=
t-list]"
>   msgstr ""
> -"git pack-objects --stdout [Optionen...] [< Referenzliste | < Objekt=
liste]"
> +"git pack-objects --stdout [Optionen =E2=80=A6] [< Referenzliste | <=
 Objektliste]"
>
>   #: builtin/pack-objects.c:29
>   msgid "git pack-objects [options...] base-name [< ref-list | < obje=
ct-list]"
>   msgstr ""
> -"git pack-objects [Optionen...] Basis-Name [< Referenzliste | < Obje=
ktliste]"
> +"git pack-objects [Optionen =E2=80=A6] Basis-Name [< Referenzliste |=
 < Objektliste]"
>
>   #: builtin/pack-objects.c:177 builtin/pack-objects.c:180
>   #, c-format
> @@ -8167,7 +8167,7 @@ msgstr "L=C3=B6sche doppelte Objekte"
>
>   #: builtin/prune.c:12
>   msgid "git prune [-n] [-v] [--expire <time>] [--] [<head>...]"
> -msgstr "git prune [-n] [-v] [--expire <Zeit>] [--] [<head>...]"
> +msgstr "git prune [-n] [-v] [--expire <Zeit>] [--] [<head> =E2=80=A6=
]"
>
>   #: builtin/prune.c:106
>   msgid "do not remove, show only"
> @@ -8183,7 +8183,7 @@ msgstr "Objekte =C3=A4lter als <Zeit> verfallen=
 lassen"
>
>   #: builtin/push.c:14
>   msgid "git push [<options>] [<repository> [<refspec>...]]"
> -msgstr "git push [<Optionen>] [<Repository> [<Refspec>...]]"
> +msgstr "git push [<Optionen>] [<Repository> [<Refspec> =E2=80=A6]]"
>
>   #: builtin/push.c:85
>   msgid "tag shorthand without <tag>"
> @@ -8341,7 +8341,7 @@ msgid ""
>   msgstr ""
>   "Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze Ihres=
 aktuellen\n"
>   "Branches hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefalle=
n ist. F=C3=BChren Sie\n"
> -"die externen =C3=84nderungen zusammen (z.B. 'git pull ...') bevor S=
ie \"push\"\n"
> +"die externen =C3=84nderungen zusammen (z.B. 'git pull =E2=80=A6') b=
evor Sie \"push\"\n"
>   "erneut ausf=C3=BChren.\n"
>   "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --h=
elp'\n"
>   "f=C3=BCr weitere Details."
> @@ -8356,7 +8356,7 @@ msgstr ""
>   "Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze eines=
 versendeten\n"
>   "Branches hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefalle=
n ist. Checken Sie\n"
>   "diesen Branch aus und f=C3=BChren Sie die externen =C3=84nderungen=
 zusammen\n"
> -"(z.B. 'git pull ...') bevor Sie erneut \"push\" ausf=C3=BChren.\n"
> +"(z.B. 'git pull =E2=80=A6') bevor Sie erneut \"push\" ausf=C3=BChre=
n.\n"
>   "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --h=
elp'\n"
>   "f=C3=BCr weitere Details."
>
> @@ -8365,7 +8365,7 @@ msgid ""
>   "Updates were rejected because the remote contains work that you do=
\n"
>   "not have locally. This is usually caused by another repository pus=
hing\n"
>   "to the same ref. You may want to first integrate the remote change=
s\n"
> -"(e.g., 'git pull ...') before pushing again.\n"
> +"(e.g., 'git pull =E2=80=A6') before pushing again.\n"
>   "See the 'Note about fast-forwards' in 'git push --help' for detail=
s."
>   msgstr ""
>   "Aktualisierungen wurden zur=C3=BCckgewiesen, weil das Remote-Repos=
itory Commits "
> @@ -8374,7 +8374,7 @@ msgstr ""
>   "von\n"
>   "Commits auf dieselbe Referenz von einem anderen Repository aus ver=
ursacht.\n"
>   "Vielleicht m=C3=BCssen Sie die externen =C3=84nderungen zusammenzu=
f=C3=BChren (z.B. 'git "
> -"pull ...')\n"
> +"pull =E2=80=A6')\n"
>   "bevor Sie erneut \"push\" ausf=C3=BChren.\n"
>   "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --h=
elp'\n"
>   "f=C3=BCr weitere Details."
> @@ -8645,11 +8645,11 @@ msgstr "git remote prune [-n | --dry-run] <Na=
me>"
>   msgid ""
>   "git remote [-v | --verbose] update [-p | --prune] [(<group> | <rem=
ote>)...]"
>   msgstr ""
> -"git remote [-v | --verbose] update [-p | --prune] [(<Gruppe> | <Rem=
ote>)...]"
> +"git remote [-v | --verbose] update [-p | --prune] [(<Gruppe> | <Rem=
ote>) =E2=80=A6]"
>
>   #: builtin/remote.c:20
>   msgid "git remote set-branches [--add] <name> <branch>..."
> -msgstr "git remote set-branches [--add] <Name> <Branch>..."
> +msgstr "git remote set-branches [--add] <Name> <Branch> =E2=80=A6"
>
>   #: builtin/remote.c:21 builtin/remote.c:69
>   msgid "git remote set-url [--push] <name> <newurl> [<oldurl>]"
> @@ -8673,11 +8673,11 @@ msgstr "git remote set-head <Name> (-a | --au=
to | -d | --delete | <Branch>)"
>
>   #: builtin/remote.c:48
>   msgid "git remote set-branches <name> <branch>..."
> -msgstr "git remote set-branches <Name> <Branch>..."
> +msgstr "git remote set-branches <Name> <Branch> =E2=80=A6"
>
>   #: builtin/remote.c:49
>   msgid "git remote set-branches --add <name> <branch>..."
> -msgstr "git remote set-branches --add <Name> <Branch>..."
> +msgstr "git remote set-branches --add <Name> <Branch> =E2=80=A6"
>
>   #: builtin/remote.c:54
>   msgid "git remote show [<options>] <name>"
> @@ -8689,7 +8689,7 @@ msgstr "git remote prune [<Optionen>] <Name>"
>
>   #: builtin/remote.c:64
>   msgid "git remote update [<options>] [<group> | <remote>]..."
> -msgstr "git remote update [<Optionen>] [<Gruppe> | <externesReposito=
ry>]..."
> +msgstr "git remote update [<Optionen>] [<Gruppe> | <externesReposito=
ry>] =E2=80=A6"
>
>   #: builtin/remote.c:88
>   #, c-format
> @@ -9201,11 +9201,11 @@ msgstr "git replace [-f] --edit <Objekt>"
>
>   #: builtin/replace.c:21
>   msgid "git replace [-f] --graft <commit> [<parent>...]"
> -msgstr "git replace [-f] --graft <Commit> [<Eltern-Commit>...]"
> +msgstr "git replace [-f] --graft <Commit> [<Eltern-Commit> =E2=80=A6=
]"
>
>   #: builtin/replace.c:22
>   msgid "git replace -d <object>..."
> -msgstr "git replace -d <Objekt>..."
> +msgstr "git replace -d <Objekt> =E2=80=A6"
>
>   #: builtin/replace.c:23
>   msgid "git replace [--format=3D<format>] [-l [<pattern>]]"
> @@ -9279,7 +9279,7 @@ msgstr "das angegebene Format benutzen"
>
>   #: builtin/rerere.c:12
>   msgid "git rerere [clear | forget path... | status | remaining | di=
ff | gc]"
> -msgstr "git rerere [clean | forget path... | status | remaining | di=
ff | gc]"
> +msgstr "git rerere [clean | forget path =E2=80=A6 | status | remaini=
ng | diff | gc]"
>
>   #: builtin/rerere.c:57
>   msgid "register clean resolutions in index"
> @@ -9293,11 +9293,11 @@ msgstr ""
>
>   #: builtin/reset.c:27
>   msgid "git reset [-q] <tree-ish> [--] <paths>..."
> -msgstr "git reset [-q] <Commit-Referenz> [--] <Pfade>..."
> +msgstr "git reset [-q] <Commit-Referenz> [--] <Pfade> =E2=80=A6"
>
>   #: builtin/reset.c:28
>   msgid "git reset --patch [<tree-ish>] [--] [<paths>...]"
> -msgstr "git reset --patch [<Commit-Referenz>] [--] [<Pfade>...]"
> +msgstr "git reset --patch [<Commit-Referenz>] [--] [<Pfade> =E2=80=A6=
]"
>
>   #: builtin/reset.c:34
>   msgid "mixed"
> @@ -9420,7 +9420,7 @@ msgstr "Konnte neue Staging-Area-Datei nicht sc=
hreiben."
>
>   #: builtin/rev-parse.c:361
>   msgid "git rev-parse --parseopt [options] -- [<args>...]"
> -msgstr "git rev-parse --parseopt [Optionen] -- [<Argumente>...]"
> +msgstr "git rev-parse --parseopt [Optionen] -- [<Argumente> =E2=80=A6=
]"
>
>   #: builtin/rev-parse.c:366
>   msgid "keep the `--` passed as an arg"
> @@ -9443,16 +9443,16 @@ msgid ""
>   "\n"
>   "Run \"git rev-parse --parseopt -h\" for more information on the fi=
rst usage."
>   msgstr ""
> -"git rev-parse --parseopt [Optionen] -- [<Argumente>...]\n"
> -"   oder: git rev-parse --sq-quote [<Argumente>...]\n"
> -"   oder: git rev-parse [Optionen] [<Argumente>...]\n"
> +"git rev-parse --parseopt [Optionen] -- [<Argumente> =E2=80=A6]\n"
> +"   oder: git rev-parse --sq-quote [<Argumente> =E2=80=A6]\n"
> +"   oder: git rev-parse [Optionen] [<Argumente> =E2=80=A6]\n"
>   "\n"
>   "F=C3=BChren Sie \"git rev-parse --parseopt -h\" f=C3=BCr weitere I=
nformationen bei "
>   "erster Verwendung aus."
>
>   #: builtin/revert.c:22
>   msgid "git revert [options] <commit-ish>..."
> -msgstr "git revert [Optionen] <Commit-Angabe>..."
> +msgstr "git revert [Optionen] <Commit-Angabe> =E2=80=A6"
>
>   #: builtin/revert.c:23
>   msgid "git revert <subcommand>"
> @@ -9460,7 +9460,7 @@ msgstr "git revert <Unterkommando>"
>
>   #: builtin/revert.c:28
>   msgid "git cherry-pick [options] <commit-ish>..."
> -msgstr "git cherry-pick [Optionen] <Commit-Angabe>..."
> +msgstr "git cherry-pick [Optionen] <Commit-Angabe> =E2=80=A6"
>
>   #: builtin/revert.c:29
>   msgid "git cherry-pick <subcommand>"
> @@ -9541,7 +9541,7 @@ msgstr "\"cherry-pick\" fehlgeschlagen"
>
>   #: builtin/rm.c:17
>   msgid "git rm [options] [--] <file>..."
> -msgstr "git rm [Optionen] [--] [<Datei>...]"
> +msgstr "git rm [Optionen] [--] [<Datei> =E2=80=A6]"
>
>   #: builtin/rm.c:65
>   msgid ""
> @@ -9649,7 +9649,7 @@ msgstr "git rm: konnte %s nicht l=C3=B6schen"
>
>   #: builtin/shortlog.c:13
>   msgid "git shortlog [<options>] [<revision range>] [[--] [<path>...=
]]"
> -msgstr "git shortlog [<Optionen>] [Commitbereich] [[--] <Pfad>...]"
> +msgstr "git shortlog [<Optionen>] [Commitbereich] [[--] <Pfad> =E2=80=
=A6]"
>
>   #: builtin/shortlog.c:131
>   #, c-format
> @@ -9686,7 +9686,7 @@ msgstr ""
>   "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-o=
rder]\n"
>   "\t\t[--current] [--color[=3D<Wann>] | --no-color] [--sparse]\n"
>   "\t\t[--more=3D<n> | --list | --independent | --merge-base]\n"
> -"\t\t[--no-name | --sha1-name] [--topics] [(<Commit> | <glob>)...]"
> +"\t\t[--no-name | --sha1-name] [--topics] [(<Commit> | <glob>) =E2=80=
=A6]"
>
>   #: builtin/show-branch.c:13
>   msgid "git show-branch (-g|--reflog)[=3D<n>[,<base>]] [--list] [<re=
f>]"
> @@ -9843,7 +9843,7 @@ msgstr ""
>
>   #: builtin/tag.c:23
>   msgid "git tag -d <tagname>..."
> -msgstr "git tag -d <Tagname>..."
> +msgstr "git tag -d <Tagname> =E2=80=A6"
>
>   #: builtin/tag.c:24
>   msgid ""
> @@ -9851,11 +9851,11 @@ msgid ""
>   "\t\t[<pattern>...]"
>   msgstr ""
>   "git tag -l [-n[<Nummer>]] [--contains <Commit>] [--points-at <Obje=
kt>] \n"
> -"\t\t[<Muster>...]"
> +"\t\t[<Muster> =E2=80=A6]"
>
>   #: builtin/tag.c:26
>   msgid "git tag -v <tagname>..."
> -msgstr "git tag -v <Tagname>..."
> +msgstr "git tag -v <Tagname> =E2=80=A6"
>
>   #: builtin/tag.c:69
>   #, c-format
> @@ -9865,7 +9865,7 @@ msgstr "fehlerhaftes Objekt bei '%s'"
>   #: builtin/tag.c:301
>   #, c-format
>   msgid "tag name too long: %.*s..."
> -msgstr "Tagname zu lang: %.*s..."
> +msgstr "Tagname zu lang: %.*s =E2=80=A6"
>
>   #: builtin/tag.c:306
>   #, c-format
> @@ -10063,7 +10063,7 @@ msgstr "Entpacke Objekte"
>
>   #: builtin/update-index.c:403
>   msgid "git update-index [options] [--] [<file>...]"
> -msgstr "git update-index [Optionen] [--] [<Datei>...]"
> +msgstr "git update-index [Optionen] [--] [<Datei> =E2=80=A6]"
>
>   #: builtin/update-index.c:756
>   msgid "continue refresh even when index needs update"
> @@ -10223,7 +10223,7 @@ msgstr "die Informationsdateien von Grund auf=
 aktualisieren"
>
>   #: builtin/verify-commit.c:17
>   msgid "git verify-commit [-v|--verbose] <commit>..."
> -msgstr "git verify-commit [-v|--verbose] <Commit>..."
> +msgstr "git verify-commit [-v|--verbose] <Commit> =E2=80=A6"
>
>   #: builtin/verify-commit.c:75
>   msgid "print commit contents"
> @@ -10231,7 +10231,7 @@ msgstr "Commit-Inhalte ausgeben"
>
>   #: builtin/verify-pack.c:54
>   msgid "git verify-pack [-v|--verbose] [-s|--stat-only] <pack>..."
> -msgstr "git verify-pack [-v|--verbose] [-s|--stat-only] <Paket>..."
> +msgstr "git verify-pack [-v|--verbose] [-s|--stat-only] <Paket> =E2=80=
=A6"
>
>   #: builtin/verify-pack.c:64
>   msgid "verbose"
> @@ -10243,7 +10243,7 @@ msgstr "nur Statistiken anzeigen"
>
>   #: builtin/verify-tag.c:17
>   msgid "git verify-tag [-v|--verbose] <tag>..."
> -msgstr "git verify-tag [-v|--verbose] <Tag>..."
> +msgstr "git verify-tag [-v|--verbose] <Tag> =E2=80=A6"
>
>   #: builtin/verify-tag.c:73
>   msgid "print tag contents"
> @@ -10450,7 +10450,7 @@ msgstr ""
>
>   #: git-am.sh:166
>   msgid "Falling back to patching base and 3-way merge..."
> -msgstr "Falle zur=C3=BCck zum Patchen der Basis und des 3-Wege-Merge=
s..."
> +msgstr "Falle zur=C3=BCck zum Patchen der Basis und des 3-Wege-Merge=
s =E2=80=A6"
>
>   #: git-am.sh:182
>   msgid "Failed to merge in the changes."
> @@ -10943,7 +10943,7 @@ msgstr "=C3=84nderungen von $mb zu $onto:"
>   msgid "First, rewinding head to replay your work on top of it..."
>   msgstr ""
>   "Zun=C3=A4chst wird der Branch zur=C3=BCckgespult, um Ihre =C3=84nd=
erungen\n"
> -"darauf neu anzuwenden..."
> +"darauf neu anzuwenden =E2=80=A6"
>
>   #: git-rebase.sh:620
>   #, sh-format
>
