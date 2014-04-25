From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] l10n: de.po: translate 45 new messages
Date: Fri, 25 Apr 2014 23:19:40 +0200
Message-ID: <87lhutp0nn.fsf@thomasrast.ch>
References: <1397931508-9752-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jk@jk.gs, stimming@tuhh.de
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 23:27:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdneK-00063j-I1
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 23:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbaDYV1G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Apr 2014 17:27:06 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:42549 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbaDYV1E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Apr 2014 17:27:04 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Apr 2014 17:27:03 EDT
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id E96E04D64DE;
	Fri, 25 Apr 2014 23:19:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 7AOxigF9C32u; Fri, 25 Apr 2014 23:19:40 +0200 (CEST)
Received: from linux-1gf2.thomasrast.ch (unknown [95.151.233.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 1F7ED4D6581;
	Fri, 25 Apr 2014 23:19:40 +0200 (CEST)
In-Reply-To: <1397931508-9752-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Sat, 19 Apr 2014 20:18:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247114>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Translate 45 new messages came from git.pot update in 5e078fc
> (l10n: git.pot: v2.0.0 round 1 (45 new, 28 removed)).

Thanks for sending this with extra context, it really helps reviewing!

With the small changes below,

Acked-by: Thomas Rast <tr@thomasrast.ch>

>  #: diffcore-rename.c:517
>  msgid "Performing inexact rename detection"
> -msgstr ""
> +msgstr "F=C3=BChre Erkennung f=C3=BCr ungenaue Umbenennung aus"

I don't have a better idea, but I wish we had a less unwieldy term for
"inexact rename detection".

>  #: wt-status.c:266
> -#, fuzzy, c-format
> +#, c-format
>  msgid "bug: unhandled unmerged status %x"
> -msgstr "Fehler: unbehandelter Differenz-Status %c"
> +msgstr "Fehler: unbehandelter Unmerged-Status %x"

s/Fehler/Bug/?

I interpret "Fehler" in such a message as a user-caused problem, wherea=
s
this message means the program doesn't handle a case that it really
should.

>  #: builtin/commit.c:1131
> -#, fuzzy
>  msgid "Explicit paths specified without -i or -o; assuming --only pa=
ths..."
>  msgstr ""
>  "Explizite Pfade ohne -i oder -o angegeben; unter der Annahme von --=
only "
>  "Pfaden..."

Not new, but "[I am] assuming --only paths" should really be translated
as such, e.g.

  nehme --only an

(Leaving off the "paths"; I think it reads better without it even in
English.)

>  #: builtin/gc.c:318
> -#, fuzzy, c-format
> +#, c-format
>  msgid "Auto packing the repository in background for optimum perform=
ance.\n"
>  msgstr ""
> -"Die Datenbank des Projektarchivs wird f=C3=BCr eine optimale Perfor=
mance "
> -"komprimiert.\n"
> +"Die Datenbank des Repositories wird f=C3=BCr eine optimale Performa=
nce automatisch\n"
> +"im Hintergrund komprimiert.\n"
> =20
>  #: builtin/gc.c:320
>  #, c-format
>  msgid "Auto packing the repository for optimum performance.\n"
>  msgstr ""
>  "Die Datenbank des Projektarchivs wird f=C3=BCr eine optimale Perfor=
mance "
>  "komprimiert.\n"

Nit: you added "automatisch" in the first one, but the second one
doesn't have it even though the difference between them is only "in
background".

>  #: builtin/gc.c:321
>  #, c-format
>  msgid "See \"git help gc\" for manual housekeeping.\n"
> -msgstr ""
> +msgstr "Siehe \"git help gc\" f=C3=BCr manuelle Einstellungen.\n"

f=C3=BCr manuelles Aufr=C3=A4umen?

>  #: builtin/notes.c:276
> -#, fuzzy, c-format
> +#, c-format
>  msgid "Cannot read note data from non-blob object '%s'."
> -msgstr "Kann existierendes Objekt %s nicht lesen."
> +msgstr "Kann Notiz-Daten von Nicht-Blob Objekt '%s' nicht lesen."

This would read better as

  Kann Notiz-Daten nicht von Nicht-Blob Objekt '%s' lesen.

since the key point is that we refuse any non-blob object, not that we
can't read it.

--=20
Thomas Rast
tr@thomasrast.ch
