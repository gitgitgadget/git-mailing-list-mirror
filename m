From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 19:33:53 +0100
Message-ID: <43DFAD91.4080105@gorzow.mm.pl>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org> <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net> <1138529385.9919.185.camel@evo.keithp.com> <43DCA495.9040301@gorzow.mm.pl> <20060129181240.GA11721@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFF1621F055C08705EB9CC46A"
Cc: Keith Packard <keithp@keithp.com>, Junio C Hamano <junkio@cox.net>,
	cworth@cworth.org, Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 19:34:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F40KM-0005xw-TA
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 19:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWAaSeE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 13:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWAaSeD
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 13:34:03 -0500
Received: from goliat1.kalisz.mm.pl ([81.15.136.226]:23988 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S1751328AbWAaSeB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 13:34:01 -0500
Received: (qmail 30670 invoked from network); 31 Jan 2006 18:33:58 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.201.167])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <junkio@cox.net>; 31 Jan 2006 18:33:58 -0000
Received: from [192.168.0.1] (zen.uplink [192.168.0.1])
	by zen.uplink (Postfix) with ESMTP id 8B0DE1780F3;
	Tue, 31 Jan 2006 19:33:57 +0100 (CET)
User-Agent: Thunderbird 1.4.1 (X11/20051010)
To: Greg KH <greg@kroah.com>
In-Reply-To: <20060129181240.GA11721@kroah.com>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15332>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFF1621F055C08705EB9CC46A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Greg KH wrote:
> On Sun, Jan 29, 2006 at 12:18:45PM +0100, Radoslaw Szkodzinski wrote:
>> The only drawback is local cloning. This operation is like 4x slower
>> than plain copying of the repository. Probably because it works like a=
n
>> ssh clone - creates a pack, copies it, then unpacks. This is just
>> inefficient on a local machine.
>=20
> Have you tried the "-l" option for cloneing locally?  It's _very_ fast,=

> even for my tiny little old laptop.

Because it's cp -rl <one-tree> <second-tree> and some file modifications,=
 right?
It's what I've been using already.

This -l option should be more prominent in the documentation.
Maybe it even already is. I've taught myself using git before 0.9.

Thank you. This helps a lot.

> If you add a "-n" that will not checkout the source tree, so you can
> compare the time of cloning with the checkout portion.

Cloning without -l option is much slower - some minutes vs below a minute=
=2E
I could have time(8)d it, but it's no use.

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enigFF1621F055C08705EB9CC46A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD362VlUMEU9HxC6IRAq7dAJ4ho4tbuv1lsbS20AkDDypKFAyzIQCggT7r
gjf3vXrkBuZX8hppX1YpFBc=
=owhZ
-----END PGP SIGNATURE-----

--------------enigFF1621F055C08705EB9CC46A--
