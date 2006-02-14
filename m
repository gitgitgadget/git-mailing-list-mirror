From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: Quick question
Date: Tue, 14 Feb 2006 03:21:54 +0100
Message-ID: <43F13EC2.7040909@gorzow.mm.pl>
References: <43F0B577.4070608@gorzow.mm.pl>	<7vy80eydq0.fsf@assigned-by-dhcp.cox.net>	<43F13776.9000501@gorzow.mm.pl> <7v3bimy9wn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD50A383DBE7B26300950785B"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 03:22:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8ppO-0008Dp-Ew
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 03:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWBNCWD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 21:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWBNCWD
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 21:22:03 -0500
Received: from goliat1.kalisz.mm.pl ([81.15.136.226]:38281 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S1750920AbWBNCWB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 21:22:01 -0500
Received: (qmail 12996 invoked from network); 14 Feb 2006 02:21:58 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.201.167])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <junkio@cox.net>; 14 Feb 2006 02:21:58 -0000
Received: from [192.168.0.1] (zen.uplink [192.168.0.1])
	by zen.uplink (Postfix) with ESMTP id 619631786AC;
	Tue, 14 Feb 2006 03:21:58 +0100 (CET)
User-Agent: Thunderbird 1.4.1 (X11/20051010)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bimy9wn.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16102>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD50A383DBE7B26300950785B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Wow, you have a strong voice.
>
I didn't want to sound rude at all, of course.

>> That's why I used the -o (--others).
>=20
> You asked it to show either ignored or others.
>=20

So here's the catch? I don't think so.
But the manpage isn't totally clear in this matter.

When I specify just -o, it gives me files which weren't ignored too.
-o -i gives me only ignored files.
Plain -i returns nothing.

With git directory, compare:
git-ls-files -o -i -X .gitignore

with:
git-ls-files -o

The remainder is:
git-ls-files -o -X .gitignore

I have the documentation built.
(Yes, I'm not including its .gitignore on purpose)

>=20
>> I would like to use it for backup~ hunting purposes in a script
>> and not have to worry about find and other less portable tools.
>=20
> I usually do this for that:
>=20
> 	git ls-files -o '*~'
>=20

Also good. I have *~ in ignored too, so I think -o -i will suffice.

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enigD50A383DBE7B26300950785B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD8T7GlUMEU9HxC6IRAk/XAJ4uiXgNsOk8ETSTZRKHHkC6aOZoBACfRCkw
WGEIUpKpzX8KQHTc3bYYGec=
=ZyAZ
-----END PGP SIGNATURE-----

--------------enigD50A383DBE7B26300950785B--
