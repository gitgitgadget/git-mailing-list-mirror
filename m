From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: Quick question
Date: Mon, 13 Feb 2006 19:26:03 +0100
Message-ID: <43F0CF3B.6040807@gorzow.mm.pl>
References: <43F0B577.4070608@gorzow.mm.pl> <Pine.LNX.4.64.0602130848220.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig40307B54D90D1DC13FC1F6F9"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 13 19:26:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8iOv-0005qx-W6
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 19:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWBMS0N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 13:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWBMS0N
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 13:26:13 -0500
Received: from goliat1.kalisz.mm.pl ([81.15.136.226]:41145 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S932242AbWBMS0M (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 13:26:12 -0500
Received: (qmail 6844 invoked from network); 13 Feb 2006 18:26:09 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.201.167])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <torvalds@osdl.org>; 13 Feb 2006 18:26:09 -0000
Received: from [192.168.0.1] (zen.uplink [192.168.0.1])
	by zen.uplink (Postfix) with ESMTP id 176BC23029D;
	Mon, 13 Feb 2006 19:26:09 +0100 (CET)
User-Agent: Thunderbird 1.4.1 (X11/20051010)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602130848220.3691@g5.osdl.org>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16078>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig40307B54D90D1DC13FC1F6F9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
>=20
> Well, since you're telling it to only show excluded files, it will also=
=20
> only show excluded directories.
>=20
> Which is admittedly insane. You don't want to exclude directories. Or=20
> maybe you do, but then we should add the "/" to the end before we do th=
e=20
> exclusion.
>=20
> This patch (untested) will never exclude directories. Which may or may =
not=20
> be the right thing.=20
>=20
> Junio? Others? Comments?
>=20

For me it seems to do the right thing, although I have no need to exclude=
 directories.
If I really needed to, I'd say something like:

/excluded_dir/*

in .git/info/exclude, and it would show the files as being excluded.

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enig40307B54D90D1DC13FC1F6F9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD8M9AlUMEU9HxC6IRAgNEAKCHb9sYlC/zDEJE4arlGyoNwz7RlQCaA+y6
dtwLTTJL1JZYYPUDxrdS9sU=
=Rr5l
-----END PGP SIGNATURE-----

--------------enig40307B54D90D1DC13FC1F6F9--
