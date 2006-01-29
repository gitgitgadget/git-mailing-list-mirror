From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: [Census] So who uses git?
Date: Sun, 29 Jan 2006 12:18:45 +0100
Message-ID: <43DCA495.9040301@gorzow.mm.pl>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>	 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>	 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>	 <1138446030.9919.112.camel@evo.keithp.com>	 <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net> <1138529385.9919.185.camel@evo.keithp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig41A023CB635EC55285591FC4"
Cc: Junio C Hamano <junkio@cox.net>, cworth@cworth.org,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 29 12:19:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3AaL-000725-Fq
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 12:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWA2LTG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 06:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWA2LTG
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 06:19:06 -0500
Received: from goliat1.kalisz.mm.pl ([81.15.136.226]:13497 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S1750918AbWA2LTF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 06:19:05 -0500
Received: (qmail 27291 invoked from network); 29 Jan 2006 11:18:51 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.183.100])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <junkio@cox.net>; 29 Jan 2006 11:18:51 -0000
Received: from [192.168.0.1] (zen.uplink [192.168.0.1])
	by zen.uplink (Postfix) with ESMTP id 47B89178460;
	Sun, 29 Jan 2006 12:18:50 +0100 (CET)
User-Agent: Thunderbird 1.4.1 (X11/20051010)
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1138529385.9919.185.camel@evo.keithp.com>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15212>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig41A023CB635EC55285591FC4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Keith Packard wrote:
> Fortunately, there are very few people involved with any specific piece=

> of the X.org distribution; there's really only one or two people
> actively developing the X.org core server, so that part of the migratio=
n
> will be easy. Our users will be stuck, but there aren't many of them
> either, and git makes just sucking the current bits pretty easy.=20
> =20

Not under Windows (bleh), but it's support for Cygwin is getting better
and better.

> I don't know of other huge projects moving to git; it's not all that
> interesting as we know the tool is stable and will scale to support our=

> project already. Also, hg and bzr are not ready for production use in m=
y
> opinion; hg as it appears likely a flag day will be required before 1.0=
,

I haven't seen any such flag day since 0.3. Repository format seems
stable, except rename and modes support (these will be added in a
compatible way I think).
0.8 release is imminent (today or tomorrow).

I personally wouldn't mind git - it's great.

The only drawback is local cloning. This operation is like 4x slower
than plain copying of the repository. Probably because it works like an
ssh clone - creates a pack, copies it, then unpacks. This is just
inefficient on a local machine.

> and bzr because they didn't focus on repository format, and have
> suggested that they will switch to a hash-addressed scheme at some poin=
t
> in the future...
>  =20

Not only that - they don't have an efficient network transfer protocol.
(they use HTTP walkers, not even supporting persistent connections and
also do too many DNS lookups)
This is very unfortunate, especially for large projects.
(branching Linux would take 3 days I think)

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enig41A023CB635EC55285591FC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD3KSalUMEU9HxC6IRAv9UAKCq0GcbHxUuZc3SnZlXPj9Lto8eOACgrIGt
0xrEEB8129o/QAtc7p3KoCc=
=j24z
-----END PGP SIGNATURE-----

--------------enig41A023CB635EC55285591FC4--
