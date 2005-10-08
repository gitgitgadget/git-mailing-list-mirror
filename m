From: Elfyn McBratney <beu@gentoo.org>
Subject: Re: First cut at git port to Cygwin
Date: Sat, 8 Oct 2005 02:00:21 +0100
Message-ID: <20051008010021.GA29261@gentoo.org>
References: <20051005155457.GA30303@trixie.casa.cgf.cx> <20051005191741.GA25493@steel.home> <20051005202947.GA6184@trixie.casa.cgf.cx> <81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com> <81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com> <81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com> <Pine.LNX.4.64.0510070828270.31407@g5.osdl.org> <20051007205450.GA14827@steel.home> <7vfyrdyre5.fsf@assigned-by-dhcp.cox.net> <20051007234547.GC8893@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 03:00:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EO34d-0006M1-4C
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 03:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbVJHBAY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 21:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161031AbVJHBAY
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 21:00:24 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:55301 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1161029AbVJHBAX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 21:00:23 -0400
Received: from beu1.demon.co.uk ([83.105.51.149] helo=zippy.emcb.local)
	by anchor-post-34.mail.demon.net with esmtp (Exim 4.42)
	id 1EO34Y-0003aP-Ec; Sat, 08 Oct 2005 01:00:22 +0000
Received: by zippy.emcb.local (Postfix, from userid 1001)
	id 2DA32148041; Sat,  8 Oct 2005 02:00:21 +0100 (BST)
To: Alex Riesen <raa.lkml@gmail.com>
Mail-Followup-To: Elfyn McBratney <beu@gentoo.org>,
	Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051007234547.GC8893@steel.home>
Organisation: Gentoo Foundation, Inc.
User-Agent: mutt-ng/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9833>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 08, 2005 at 01:45:47AM +0200, Alex Riesen wrote:
 > Junio C Hamano, Fri, Oct 07, 2005 23:00:02 +0200:
 > > > "Sounds like a thinly veiled threat or a very effective prodding" 8)
 > > > ---
 > > >
 > > > Make read_cache copy the index into memory, to improve portability on
 > > > other OS's which have mmap too, tend to use it less commonly.
 > > >
 > >=20
 > > Huh?  where is your memcpy?
 > >=20
 >=20
 > Junio, unless there already are pressing reasons to put the patch in
 > GIT, could you postpone its inclusion (if you ever considered)? Or at
 > least put "#ifdef __cygwin" (I hope this is the define) around it?

Close ;) - the define is "__CYGWIN__".

Best,
Elfyn

--=20
Elfyn McBratney
Gentoo Developer/Perl Team Lead
beu/irc.freenode.net                            http://dev.gentoo.org/~beu/
+------------O.o--------------------- http://dev.gentoo.org/~beu/pubkey.asc

PGP Key ID: 0x69DF17AD
PGP Key Fingerprint:
  DBD3 B756 ED58 B1B4 47B9  B3BD 8D41 E597 69DF 17AD

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDRxoljUHll2nfF60RAlRqAJwItHESOc0e7W99XjwVePOLCSc2EACgyDm9
yZwapeqJKVlwOQhtBvGzd9Q=
=D7aT
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
