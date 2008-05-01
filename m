From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] gitk: Update German translation
Date: Thu, 1 May 2008 23:10:04 +0200
Message-ID: <20080501211004.GE7868@leksak.fem-net>
References: <200805012142.10151.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RpqchZ26BWispMcB"
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Thu May 01 23:12:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrg4T-0007sm-Jd
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 23:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760263AbYEAVLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 17:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760258AbYEAVLR
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 17:11:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:38898 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754458AbYEAVLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 17:11:16 -0400
Received: (qmail invoked by alias); 01 May 2008 21:11:14 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp025) with SMTP; 01 May 2008 23:11:14 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19hKb8Y+S9hQYWLxkvkBc1ZVbQgUdyL5Hb0fsd8Vt
	5euyWRgxR9XBwx
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1Jrg2W-0005ky-Sp; Thu, 01 May 2008 23:10:04 +0200
Mail-Followup-To: Christian Stimming <stimming@tuhh.de>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200805012142.10151.stimming@tuhh.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80940>


--RpqchZ26BWispMcB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I'd propose to talk about the newest or topmost commit,=20
> but rather not about the "first".

I agree, but s/newest/latest/ :)


Well.
Although your patch does not cover the translations itself (and although
I neither use the German translation of gitk and use gitk very seldom at
all), I've taken a look at the given translations and want to drop some
comments/corrections.

> -#: gitk:141 gitk:2143
> +#: gitk:151 gitk:2191
>  msgid "Reading commits..."
>  msgstr "Versionen lesen..."

Is "Version" really the German translation for "commit" throughout the
whole git suite?
(Ehh, is git translated at all?)
I'd recommend "Commit" or "Eintragung"...

"Version" is so CVS/SVN-like.

> -#: gitk:264
> +#: gitk:275
>  msgid "Can't parse git log output:"
>  msgstr "Git log Ausgabe kann nicht erkannt werden:"

"git-log-Ausgabe" oder "Ausgabe von git-log"

> -#: gitk:650
> +#: gitk:665
>  msgid "List references"
>  msgstr "Zweige auflisten"

Hm, the button lists branches and tags.
Is then "Zweige" (=3D branches) only correct?
What about "Referenzen auflisten" or "Zweige/Markierungen auflisten"=20
(or however "tags" is translated).

> -#: gitk:782 gitk:784 gitk:2308 gitk:2331 gitk:2355 gitk:4257 gitk:4320
> +#: gitk:797 gitk:799 gitk:2356 gitk:2379 gitk:2403 gitk:4306 gitk:4369
>  msgid "containing:"
>  msgstr "enthaltend:"

"enth=E4lt:"

> -#: gitk:785 gitk:1741 gitk:1746 gitk:2383
> +#: gitk:800 gitk:1778 gitk:1783 gitk:2431
>  msgid "touching paths:"
>  msgstr "Pfad betreffend:"

"betrifft Pfad:"

> -#: gitk:786 gitk:2388
> +#: gitk:801 gitk:2436
>  msgid "adding/removing string:"
>  msgstr "String dazu/l??schen:"

"=E4ndert Zeichenkette:"

> -#: gitk:797 gitk:2466 gitk:4225
> +#: gitk:812 gitk:2514 gitk:4274
>  msgid "IgnCase"
>  msgstr "Kein Gro??/Klein"

The translation is rather ambiguous. Or is it just me? ;)
"Ignoriere Gro=DF-/Kleinschreibung"  or
"Gro=DF-/Kleinschreibung ignorieren"

> -#: gitk:801 gitk:2483 gitk:4287 gitk:4713
> +#: gitk:816 gitk:2531 gitk:4336 gitk:4765
>  msgid "Committer"
>  msgstr "Eintragender"

"Versionierender" ... No, just a bad joke ;-)
The translation is good.

> -#: gitk:1026
> +#: gitk:1061
>  msgid "Cherry-pick this commit"
>  msgstr "Diese Version pfl??cken"

If I didn't knew that it means "cherry-pick", I'd have no idea
what the function behind that German words does. ;-)
(That's why I don't have locales set to my mother tongue. Just because I
only have to understand the programmer and not the translator first.)

"Diesen Commit =FCbernehmen"
"Diesen Commit kopieren"
"Diese Eintragung =FCbernehmen"

> +#: gitk:1354
> +msgid "<Left>, z, j\tGo back in history list"
> +msgstr "<Links>, z, j\tEine Version zur??ck gehen"

I think it's still "zur=FCckgehen" and not "zur=FCck gehen" in the latest
German spelling.

> +#: gitk:1355
> +msgid "<Right>, x, l\tGo forward in history list"
> +msgstr "<Rechts>, x, l\tEine Version nach vorne gehen"

"nach vorne gehen" sounds so colloquial.
Better, perhaps: "weitergehen"?

> -#: gitk:5719
> +#: gitk:5781
>  msgid "SHA1 ID:"
>  msgstr "SHA1 Kennung:"

Somewhere else it has been translated to "SHA1:", which is imho better.
Otherwise it'd be "SHA1-Kennung".

> -#: gitk:5744
> +#: gitk:5806
>  #, tcl-format
>  msgid "Short SHA1 id %s is ambiguous"
>  msgstr "Kurze SHA1-Kennung ??%s?? ist mehrdeutig"

Here it's correct.

> -#: gitk:6081
> +#: gitk:6143
>  msgid "Error creating patch:"
>  msgstr "Fehler beim Patch erzeugen:"

"Fehler bei der Erzeugung des Patches"

> -#: gitk:6233
> +#: gitk:6291
>  msgid "Error writing commit:"
>  msgstr "Fehler beim Version eintragen:"

"Fehler bei der Eintragung:"
"Fehler beim Schreiben der Eintragung:" (or "Version", if really used in
other places)

> -#: gitk:7966
> +#: gitk:8024
> +msgid "Auto-select SHA1"
> +msgstr "SHA1 Hashwert automatisch markieren"

"SHA1-Hashwert"

> -#: gitk:7985
> +#: gitk:8048
>  msgid "Background"
>  msgstr "Vordergrund"
> =20
> -#: gitk:7989
> +#: gitk:8052
>  msgid "Foreground"
>  msgstr "Hintergrund"

Funny. It's vice versa!

msgid "Background"
msgstr "Hintergrund"

msgid "Foreground"
msgstr "Vordergrund"

> -#: gitk:8587
> +#: gitk:8656
>  msgid ""
>  "No files selected: --merge specified but no unmerged files are within f=
ile "
>  "limit."
> @@ -720,6 +891,6 @@ msgstr ""
>  "Keine Dateien ausgew??hle: --merge angegeben, aber keine nicht-"
                            ^
			    t
>  "zusammengef??hrten Dateien sind in der Dateiauswahl."

Regards,
  Stephan

--=20
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

--RpqchZ26BWispMcB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIGjGsbt3SB/zFBA8RAiTcAKCqdOnIdL0gmTRQdiaclUEGVj9VQQCeKaYO
oq4Hk5naOfyUmkSFv+5JVV0=
=7BeM
-----END PGP SIGNATURE-----

--RpqchZ26BWispMcB--
