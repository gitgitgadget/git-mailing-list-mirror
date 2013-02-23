From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] l10n: de.po: correct translation of "bisect" messages
Date: Sat, 23 Feb 2013 18:25:34 +0100
Message-ID: <87ehg76iy9.fsf@pctrast.inf.ethz.ch>
References: <1361639092-6564-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <trast@student.ethz.ch>, <jk@jk.gs>, <stimming@tuhh.de>,
	<git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 18:26:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9IrT-0007UM-0X
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 18:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135Ab3BWRZj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2013 12:25:39 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:21170 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab3BWRZj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2013 12:25:39 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 23 Feb
 2013 18:25:24 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.211.40) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 23 Feb
 2013 18:25:34 +0100
In-Reply-To: <1361639092-6564-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Sat, 23 Feb 2013 18:04:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.211.40]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216903>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> diff --git a/po/de.po b/po/de.po
> index c0e5398..58a1a46 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -1349,11 +1349,11 @@ msgstr " (alle Konflikte behoben: f=C3=BChren=
 Sie
> \"git commit\" aus)"
>  #: wt-status.c:958
>  #, c-format
>  msgid "You are currently bisecting branch '%s'."
> -msgstr "Sie sind gerade beim Halbieren in Zweig '%s'."
> +msgstr "Sie sind gerade bei einer bin=C3=A4ren Suche in Zweig '%s'."
                           ^^^

"an"?  Or is that again my Swiss non-German interfering?

>  #: wt-status.c:962
>  msgid "You are currently bisecting."
> -msgstr "Sie sind gerade beim Halbieren."
> +msgstr "Sie sind gerade bei einer bin=C3=A4ren Suche."

Same here.

>  #: git-bisect.sh:140
>  msgid "won't bisect on seeked tree"
> -msgstr "\"bisect\" auf gesuchtem Zweig nicht m=C3=B6glich"
> +msgstr "bin=C3=A4re Suche auf gesuchtem Zweig nicht m=C3=B6glich"

Does cogito actually have a German translation?  The comment right abov=
e
this message says it's only for cogito users.

Then again cogito has been deprecated since 2006.  Maybe the English
message should instead be rewritten to say "stop using cg!". ;-)

>  #. TRANSLATORS: Make sure to include [Y] and [n] in your
>  #. translation. The program will only accept English input
> @@ -9310,7 +9310,7 @@ msgstr ""
> =20
>  #: git-bisect.sh:347 git-bisect.sh:474
>  msgid "We are not bisecting."
> -msgstr "Wir sind nicht beim Halbieren."
> +msgstr "keine bin=C3=A4ren Suche im Gange"
                       ^

s/n / /

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
