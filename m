From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] l10n: de.po: translate 41 new messages
Date: Thu, 31 May 2012 11:56:16 +0200
Message-ID: <87zk8o3c8v.fsf@thomas.inf.ethz.ch>
References: <1338395981-8094-1-git-send-email-ralf.thielow@googlemail.com>
	<1338412586-12116-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <trast@student.ethz.ch>, <jk@jk.gs>, <stimming@tuhh.de>,
	<worldhello.net@gmail.com>, <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Thu May 31 11:56:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa27F-0000Zv-6I
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 11:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802Ab2EaJ4U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 05:56:20 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:50056 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754640Ab2EaJ4T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 05:56:19 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 31 May
 2012 11:56:16 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 31 May
 2012 11:56:16 +0200
In-Reply-To: <1338412586-12116-1-git-send-email-ralf.thielow@googlemail.com>
	(Ralf Thielow's message of "Wed, 30 May 2012 23:16:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198877>

Ralf Thielow <ralf.thielow@googlemail.com> writes:

> +#. TRANSLATORS: the colon here should align with the
> +#. one in "usage: %s" translation
> +#: parse-options.c:515
> +#, c-format
> +msgid "   or: %s"
> +msgstr "      oder: %s"
> +
> +#: parse-options.c:518
> +#, c-format
> +msgid "    %s"
> +msgstr "    %s"

On IRC I indicated that this might be intended to line up with the " or=
:
%s" snippet.  This was a false alarm; it indents followup material, as
in

$ git blame -h
usage: git blame [options] [rev-opts] [rev] [--] file

    [rev-opts] are documented in git-rev-list(1)

    --incremental         Show blame entries as we find them, increment=
ally
[snip]

> +#: builtin/apply.c:3974
> +msgid "instead of applying the patch, output diffstat for the input"
> +msgstr "anstatt der Anwendung des Patches, wird die Differenz f=C3=BC=
r die Eingabe "
> +"ausgegeben"

diffstat has no precedent, so we get to bikeshed (yay).  I added a
placeholder to your glossary.  (I also added some other diff-related
terms.)  My current best suggestion, sadly, is "diffstat" simply becaus=
e
it matches the option name.

> +#: builtin/apply.c:4000 builtin/apply.c:4003
> +msgid "ignore changes in whitespace when finding context"
> +msgstr "ignoriert =C3=84nderungen in Leerzeichen bei der Suche des K=
ontextes"

I interpret "Leerzeichen" as being (specifically) the ASCII space
character.  Is it just me?  Otherwise I suggest we find a more general
translation for whitespace.

>  #: builtin/index-pack.c:458
>  msgid "delta base offset is out of bound"
> -msgstr "Wert f=C3=BCr Versatz bei Differenzobjekt liegt au=C3=9Ferha=
lb des g=C3=BCltigen "
> -"Bereichs"
> +msgstr ""
> +"Wert f=C3=BCr Versatz bei Differenzobjekt liegt au=C3=9Ferhalb des =
g=C3=BCltigen Bereichs"

This is a case where I really wonder how useful a translation is.  The
user won't be any wiser (just as with the English one), the developers
will just grep de.po for the "real" message to look for :-)

> +#: parse-options.h:156
> +msgid "no-op (backward compatibility)"
> +msgstr "Keine Operation (R=C3=BCckw=C3=A4rtskompatibilit=C3=A4t)"

"Kein Effekt" might be less confusing?

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
