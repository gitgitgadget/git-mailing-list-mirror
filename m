From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] l10n: de.po: translate 99 new messages
Date: Wed, 31 Jul 2013 22:53:32 +0200
Message-ID: <87wqo6e9ir.fsf@hexa.v.cablecom.net>
References: <1375072018-3266-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <jk@jk.gs>, <stimming@tuhh.de>, <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 22:53:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4dOt-0002YM-KY
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 22:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760787Ab3GaUxg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Jul 2013 16:53:36 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:46171 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209Ab3GaUxf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Jul 2013 16:53:35 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 31 Jul
 2013 22:53:30 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 31 Jul
 2013 22:53:32 +0200
In-Reply-To: <1375072018-3266-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Mon, 29 Jul 2013 06:26:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231461>

Hi Ralf

I made a feeble attempt to work directly on de.po so that I could send =
a
patch instead, but your patch was again linewrapping damaged at the las=
t
line here at least:

  -"Arbeitsverzeichnis von Submodul in '$sm_path' enth=C3=A4lt lokale =C3=
=84nderungen; "
  -"verwenden Sie '-f' um diese zu verwerfen"
  +msgstr "Arbeitsverzeichnis von Submodul in '$displaypath' enth=C3=A4=
lt
  lokale =C3=84nderungen; verwenden Sie '-f' um diese zu verwerfen"
=20
Was it intended for application?  If so, can you fix your tooling to
send correct patches?


Ralf Thielow <ralf.thielow@gmail.com> writes:

> -#, fuzzy, c-format
> +#, c-format
>  msgid "%s: %s - %s"
> -msgstr "%s: %s"
> +msgstr "%s: %s - %s"

Heh.  Curious that this is even translatable.

[...]
> @@ -1221,10 +1221,22 @@ msgid ""
>  "\n"
>  "where \"$br\" is somehow empty and a 40-hex ref is created. Please\=
n"
>  "examine these refs and maybe delete them. Turn this message off by\=
n"
>  "running \"git config advice.object_name_warning false\""
>  msgstr ""
> +"Git erzeugt normalerweise keine Referenzen die mit\n"
> +"40 Hex-Zeichen enden, da diese ignoriert werden wenn\n"
> +"Sie diese angeben. Diese Referenzen k=C3=B6nnten ausversehen\n"

aus Versehen?

[...]
> @@ -3529,10 +3525,14 @@ msgid ""
>  "Prompt help:\n"
>  "1          - select a numbered item\n"
>  "foo        - select item based on unique prefix\n"
>  "           - (empty) select nothing"
>  msgstr ""
> +"Eingabehilfe:\n"
> +"1          - numeriertes Element ausw=C3=A4hlen\n"

Isn't it "nummeriert" under the new spelling rules?

[...]
>  #: builtin/clean.c:634
>  #, c-format
>  msgid "Input ignore patterns>> "
> -msgstr ""
> +msgstr "Eingabe Ignorier-Muster>> "

"Input" here is an imperative, so it should be

  Ignorier-Muster eingeben>>

[...]
>  msgid "set From address to <ident> (or committer ident if absent)"
>  msgstr ""
> +"setzt \"From\"-Adresse zu <Identifikation> (oder Identifikation\n"
> +"des Commit-Erstellers, wenn fehlend)"

  setzt \"From\"-Adresse auf <Identifikation>
                         ^^^

or is that my Swiss German again?

In addition, I think <ident> would sound smoother as Identit=C3=A4t (in=
 any
case that's what I think it expands to in English).  There are other
occurrences of "ident" that you would need to change to match.

[...]
>  msgid_plural ""
>  "the following submodules (or one of its nested submodules)\n"
>  "use a .git directory:"
>  msgstr[0] ""
> +"das folgende Submodul (oder ein geschachteltes Submodul hiervon)\n"
> +"benutzt ein .git-Verzeichnis:"
>  msgstr[1] ""
> +"die folgenden Submodule (oder ein geschachteltes Submodul hiervon)\=
n"
> +"benutzt ein .git-Verzeichnis:"

The sentence is not fully in plural; it should probably be

"die folgenden Submodule (oder geschachtelte Submodule hiervon)\n"
"benutzen ein .git-Verzeichnis:"


[...]
>  #: git-rebase.sh:160
>  msgid ""
>  "Applying autostash resulted in conflicts.\n"
>  "Your changes are safe in the stash.\n"
>  "You can run \"git stash pop\" or \"git stash drop\" it at any time.=
\n"
>  msgstr ""
> +"Anwendung von \"autostash\" resultierte in Konflikten.\n"
> +"Ihre =C3=84nderungen sind sicher im Stash.\n"

There would be no ambiguity in the intended meaning of "sicher" if you
instead said

  Ihre =C3=84nderungen sind im Stash sicher.

(Note that the ambiguity does not exist in English: the other meaning
would be "surely".)

> +"Sie k=C3=B6nnen jederzeit \"git stash pop\" oder \"git stash drop\"=
 ausf=C3=BChren.\n"
[...]

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
