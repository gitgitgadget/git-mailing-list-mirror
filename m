From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCHv2] l10n: de.po: translate 68 new messages
Date: Sat, 09 Nov 2013 13:10:14 +0100
Message-ID: <877gchu66x.fsf@thomasrast.ch>
References: <1383937049-8161-1-git-send-email-ralf.thielow@gmail.com>
	<1383942139-10536-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jk@jk.gs, stimming@tuhh.de, worldhello.net@gmail.com,
	git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 13:10:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf7N4-0005zc-VL
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 13:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853Ab3KIMKb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Nov 2013 07:10:31 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:52248 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752781Ab3KIMK3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Nov 2013 07:10:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 302FA4D6576;
	Sat,  9 Nov 2013 13:10:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5EKhqMFmCbF2; Sat,  9 Nov 2013 13:10:15 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 95E004D6414;
	Sat,  9 Nov 2013 13:10:14 +0100 (CET)
In-Reply-To: <1383942139-10536-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Fri, 8 Nov 2013 21:22:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237575>

Ralf Thielow <ralf.thielow@gmail.com> writes:

>  #: remote.c:1837
> -#, fuzzy
>  msgid "  (use \"git branch --unset-upstream\" to fixup)\n"
> -msgstr "    git branch --set-upstream-to %s\n"
> +msgstr "    (benutzen Sie \"git branch --unset-upstream\" zum Behebe=
n)\n"

Minor nit: the indent (it's simply a continuation indent for the "your
upstream is gone" message) is not consistent with other continuation
indents in the same vein, e.g.

  #: remote.c:1794
  msgid "  (use \"git push\" to publish your local commits)\n"
  msgstr "  (benutzen Sie \"git push\" um lokale Commits zu publizieren=
)\n"

>  #. Maybe the user already did that, don't error out here
>  #: submodule.c:76
> -#, fuzzy, c-format
> +#, c-format
>  msgid "Could not update .gitmodules entry %s"
> -msgstr "Konnte git-Verweis %s nicht erstellen"
> +msgstr "Konnte Eintrag '%s' in .gitmodules nicht aktualisieren"
> =20
>  #. Maybe the user already did that, don't error out here
>  #: submodule.c:109
> -#, fuzzy, c-format
> +#, c-format
>  msgid "Could not remove .gitmodules entry for %s"
> -msgstr "Konnte Sektion '%s' nicht aus Konfiguration entfernen"
> +msgstr "Konnte Sektion '%s' nicht aus .gitmodules entfernen"

Here you translate 'entry' once as Eintrag, and once as Sektion?  Is th=
e
latter just a mistake from the fuzzy translation?

>  #: builtin/gc.c:265
>  msgid "force running gc even if there may be another gc running"
> -msgstr ""
> +msgstr "erzwingt Ausf=C3=BChrung des Garbage Collectors selbst wenn =
ein anderer\n"
> +"Gargabe Collector bereits ausgef=C3=BChrt wird"
> =20
>  #: builtin/gc.c:305
>  #, c-format
> @@ -5502,6 +5493,8 @@ msgstr ""
>  msgid ""
>  "gc is already running on machine '%s' pid %<PRIuMAX> (use --force i=
f not)"
>  msgstr ""
> +"Gargabe Collector wird bereits auf Maschine '%s' pid %<PRIuMAX> aus=
gef=C3=BChrt\n"
> +"(benutzen Sie --force falls nicht)"

According to the glossary:

  When a message is referring to the command, e.g. in error messages, w=
e
  do not translate the term.

Isn't this an instance of this rule?  You could translate gc to git-gc
to avoid some confusion, but I think it specifically refers to running
the command.

>  #: builtin/repack.c:143
> -#, fuzzy
>  msgid "pack everything in a single pack"
> -msgstr "packt alles"
> +msgstr "packt alles in ein einzelnes Paket"

"ein einziges Paket" -- or is that my Swiss German again?

Also, the glossary says pack -> Pack-Datei.  So it'd end up at "eine
einzige Pack-Datei".

>  #: builtin/repack.c:145
> -#, fuzzy
>  msgid "same as -a, and turn unreachable objects loose"
> -msgstr "zeigt unerreichbare Objekte"
> +msgstr "genau wie -a, unerreichbare Objekte werden aber nicht gel=C3=
=B6scht"

Clever :-)

>  #: builtin/repack.c:150
>  msgid "pass --no-reuse-delta to git-pack-objects"
> -msgstr ""
> +msgstr "=C3=BCbergibt --no-reuse-delta nach git-pack-objects"
> =20
>  #: builtin/repack.c:152
>  msgid "pass --no-reuse-object to git-pack-objects"
> -msgstr ""
> +msgstr "=C3=BCbergibt --no-reuse-object nach git-pack-objects"
>=20
>  #: builtin/repack.c:157
>  msgid "pass --local to git-pack-objects"
> -msgstr ""
> +msgstr "=C3=BCbergibt --local nach git-pack-objects"

s/nach/an/?

>  #: builtin/repack.c:158
>  msgid "approxidate"
> -msgstr ""
> +msgstr "Datumsangabe"

On an entirely different note, we don't parse German approxidates, do
we?

--=20
Thomas Rast
tr@thomasrast.ch
