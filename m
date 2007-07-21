From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 3/5] Internationalization of git-gui
Date: Sat, 21 Jul 2007 15:46:21 +0200
Organization: Organization?!?
Message-ID: <85ps2l98eq.fsf@lola.goethe.zz>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <200707211434.56622.stimming@tuhh.de> <200707211436.44672.stimming@tuhh.de> <200707211437.43524.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 21 15:46:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICFI9-0007q8-Ff
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 15:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757493AbXGUNqg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Jul 2007 09:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbXGUNqf
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 09:46:35 -0400
Received: from main.gmane.org ([80.91.229.2]:39162 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756592AbXGUNqf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 09:46:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ICFHy-0001gh-Ds
	for git@vger.kernel.org; Sat, 21 Jul 2007 15:46:30 +0200
Received: from dslb-084-061-010-231.pools.arcor-ip.net ([84.61.10.231])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 15:46:30 +0200
Received: from dak by dslb-084-061-010-231.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 15:46:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-010-231.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:ErQxYgtEO9XPklsPQlaCqL8yPqo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53167>

Christian Stimming <stimming@tuhh.de> writes:

> And a new German translation, so far 100% but many more strings are t=
o come.
>
>  po/de.po |  265 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  1 files changed, 265 insertions(+), 0 deletions(-)
>  create mode 100644 po/de.po

I have somewhat different proposals which sound less awkward, I
think.  Of course, it is always a matter of taste whether a technical
term should really be translated always, but assuming that, I'll make
some German proposals.  Some may be tongue in cheek.

> +#: git-gui.sh:1627 git-gui.sh:1802 git-gui.sh:2134
> +msgid "Commit"
> +msgstr "=DCbertragen"

Einpflegen ist als Verb gebr=E4uchlich, aber dann ist es schwer, ein
passendes Substantiv zu finden.  "Sendung"?

> +#: git-gui.sh:1631
> +msgid "Fetch"
> +msgstr "Holen"

Importieren (haupts=E4chlich, weil es zu Exportieren pa=DFt und Schiebe=
n
h=E4=DFlich ist)

> +#: git-gui.sh:1632 git-gui.sh:2140
> +msgid "Push"
> +msgstr "Schieben"

Exportieren

> +#: git-gui.sh:1641
> +msgid "Browse Current Branch"
> +msgstr "Aktuellen Zweig durchbl=E4ttern"

Im aktuellen Zweig st=F6bern.

> +#: git-gui.sh:1659
> +msgid "Compress Database"
> +msgstr "Datenbank komprimieren"

Ganz Deutsch: verdichten.

> +
> +#: git-gui.sh:1662
> +msgid "Verify Database"
> +msgstr "Datenbank pr=FCfen"

=FCberpr=FCfen (pr=FCfen w=E4re eher zu "checking")

> +#: git-gui.sh:1669 git-gui.sh:1673 git-gui.sh:1677
> +msgid "Create Desktop Icon"
> +msgstr "Desktop-Icon erstellen"

Da gibt es sicher einen neudeutschen Ausdruck, aber als
Nichtwindowsnutzer mit Amilokale...

> +#: git-gui.sh:1689
> +msgid "Undo"
> +msgstr "R=FCckg=E4ngig"

Ach nein.

> +#: git-gui.sh:1692
> +msgid "Redo"
> +msgstr "Wiederholen"

Jetzt doch.

> +#: git-gui.sh:1709 git-gui.sh:2217 git-gui.sh:2354
> +msgid "Select All"
> +msgstr "Alle ausw=E4hlen"

Alles ausw=E4hlen z=F6ge ich vor.

> +#: git-gui.sh:1724
> +msgid "Checkout..."
> +msgstr "Auschecken..."

Ausspielung.

> +#: git-gui.sh:1752 git-gui.sh:2151
> +msgid "New Commit"
> +msgstr "Neu =FCbertragen"

Neue Sendung

> +#: git-gui.sh:1760 git-gui.sh:2158
> +msgid "Amend Last Commit"
> +msgstr "Letzte =DCbertragung erg=E4nzen"

Letzte Sendung korrigieren.

> +#: git-gui.sh:1775
> +msgid "Add To Commit"
> +msgstr "Zur Bereitstellung hinzuf=FCgen"

Der Sendung hinzuf=FCgen.

> +#: git-gui.sh:1780
> +msgid "Add Existing To Commit"
> +msgstr "Existierendes zur Bereitstellung hinzuf=FCgen"

Der Sendung hinzuf=FCgen.

> +#: git-gui.sh:1786
> +msgid "Unstage From Commit"
> +msgstr "Aus der Bereitstellung herausnehmen"

Aus der Sendung entfernen.

> +#: git-gui.sh:1798 git-gui.sh:2130 git-gui.sh:2228
> +msgid "Sign Off"
> +msgstr "Freizeichnen"

Gegenzeichnen?

> +#: git-gui.sh:2057
> +msgid "Staged Changes (Will Be Committed)"
> +msgstr "Bereitgestellte =C4nderungen (werden =FCbertragen)"

Einzupflegende =C4nderungen

> +#: git-gui.sh:2077
> +msgid "Unstaged Changes (Will Not Be Committed)"
> +msgstr "Nicht bereitgestellte =C4nderungen (werden nicht =FCbertrage=
n)"

Nicht einzupflegende =C4nderungen

So, jetzt geht mir die Luft aus.

--=20
David Kastrup, Kriemhildstr. 15, 44793 Bochum
