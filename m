From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: Quick question
Date: Tue, 14 Feb 2006 02:50:46 +0100
Message-ID: <43F13776.9000501@gorzow.mm.pl>
References: <43F0B577.4070608@gorzow.mm.pl> <7vy80eydq0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig728E2A4752ECB357AF500F2C"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 02:51:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8pLG-0008CO-0o
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 02:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWBNBuy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 20:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWBNBuy
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 20:50:54 -0500
Received: from goliat1.kalisz.mm.pl ([81.15.136.226]:62340 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S1750837AbWBNBux (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 20:50:53 -0500
Received: (qmail 10390 invoked from network); 14 Feb 2006 01:50:51 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.201.167])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <junkio@cox.net>; 14 Feb 2006 01:50:51 -0000
Received: from [192.168.0.1] (zen.uplink [192.168.0.1])
	by zen.uplink (Postfix) with ESMTP id D404D17811E;
	Tue, 14 Feb 2006 02:50:50 +0100 (CET)
User-Agent: Thunderbird 1.4.1 (X11/20051010)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy80eydq0.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16098>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig728E2A4752ECB357AF500F2C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> With the git.git repository itself, I tried:
>=20
> $ cat /var/tmp/i
> *.c
> $ git ls-files -i -X /var/tmp/i | head -n 6
> apply.c
> arm/sha1.c
> blob.c
> cat-file.c
> check-ref-format.c
> checkout-index.c
>=20
> So I am not sure what you mean.  You wanted to "display ignored
> files of the whole project", right?  I am getting arm/sha1.c
> here in my output, so I do not understand the issue here...
>=20

Wrong. I wanted to display files that are ignored and not checked in.
(unlike your example)

That's why I used the -o (--others).

Try your example with git repo's .gitignore and any .o file.
I would like to use it for backup~ hunting purposes in a script
and not have to worry about find and other less portable tools.

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enig728E2A4752ECB357AF500F2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD8Td6lUMEU9HxC6IRAh/PAKCv8Qp9uNDQsJf2AfhazWD1bsoDqgCeKctv
ae6SjxA7hsAleOGhfsIg5Bk=
=0etC
-----END PGP SIGNATURE-----

--------------enig728E2A4752ECB357AF500F2C--
