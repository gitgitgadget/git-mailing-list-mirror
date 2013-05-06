From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] l10n: de.po: translate 44 new messages
Date: Mon, 6 May 2013 21:36:44 +0200
Message-ID: <87zjw7sxwz.fsf@hexa.v.cablecom.net>
References: <1367859032-3639-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <jk@jk.gs>, <stimming@tuhh.de>, <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 06 21:37:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZRDT-0002Vn-Td
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 21:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850Ab3EFTgv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 May 2013 15:36:51 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:27052 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755832Ab3EFTgv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 May 2013 15:36:51 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 6 May
 2013 21:36:46 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 6 May
 2013 21:36:47 +0200
In-Reply-To: <1367859032-3639-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Mon, 6 May 2013 18:50:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223499>

Ralf Thielow <ralf.thielow@gmail.com> writes:

>  #: branch.c:275
> -#, fuzzy, c-format
> +#, c-format
>  msgid "Not a valid branch point: '%s'."
> -msgstr "Ung=C3=BCltiger Zweig-Name: '%s'"
> +msgstr "Ung=C3=BCltige Zweig-Version: '%s'"

That's a bit strange and calls for a proper translation of "branch
point".  "Abzweigung" is really tempting, but probably does nothing to
clarify the intent ;-)

Perhaps "Abzweigpunkt".  dict.leo.org has some other reasonable ideas.

>  #: builtin/checkout.c:1065
>  msgid "do not limit pathspecs to sparse entries only"
> -msgstr ""
> +msgstr "keine Beschr=C3=A4nkung von Pfadspezifikationen zu eingeschr=
=C3=A4nkten "
> +"Eintr=C3=A4gen"

Huh?! :-)

Even if you translated "sparse entry" as "eingeschr=C3=A4nkte Eintr=C3=A4=
ge" -- it
doesn't have a wiki entry -- using "Beschr=C3=A4nkung" in the same sent=
ence
is just confusing.

How about

  Pfadspezifikationen ignorieren Einstellungen zum partiellen Auschecke=
n


All the ones I didn't quote here: Acked-by: Thomas Rast <trast@inf.ethz=
=2Ech>

Thanks for your work!

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
