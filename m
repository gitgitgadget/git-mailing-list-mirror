From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH] Remove more gcc extension usage.
Date: Mon, 10 Jul 2006 10:18:08 +0200
Message-ID: <20060710081808.GC22573@lug-owl.de>
References: <20060708183402.GA17644@spearce.org> <7vy7v4orpt.fsf@assigned-by-dhcp.cox.net> <20060708190327.GA17763@spearce.org> <20060709073155.GP22573@lug-owl.de> <20060710052255.GA15173@spearce.org> <1152512523.3504.28.camel@dv> <20060710062513.GZ22573@lug-owl.de> <1152514328.3504.58.camel@dv> <20060710073532.GA22573@lug-owl.de> <20060710040711.z1h4w0wsgk8sskg4@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nuX4E7Vid9I2gnPU"
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 10:18:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzqyL-00006t-8A
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 10:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWGJISL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 04:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWGJISL
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 04:18:11 -0400
Received: from lug-owl.de ([195.71.106.12]:25019 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751353AbWGJISK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 04:18:10 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 8FDBFF0398; Mon, 10 Jul 2006 10:18:08 +0200 (CEST)
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <20060710040711.z1h4w0wsgk8sskg4@webmail.spamcop.net>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23604>


--nuX4E7Vid9I2gnPU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-07-10 04:07:11 -0400, Pavel Roskin <proski@gnu.org> wrote:
> Quoting Jan-Benedict Glaw <jbglaw@lug-owl.de>:
> > Why should we jump through the hoops to support an obsolete standard
> > because proprietary compilers don't stand today's standards?
>=20
> Because we want git to run on such systems, and asking to compile gcc fir=
st is
> too much to ask for.

As I said, there are precompiled binaries for basically all useable
systems out there.

> There are still missing or broken C99 features in the current gcc:
> http://gcc.gnu.org/c99status.html

Sure. As are in other compilers. But you forgot to mention that these
missing or broken features are mostly of no use to commonly used C
code. So that's a non-issue. (If it was a real issue, you can be sure
that I'd drop a ton of bug reports into GCC's Bugzilla...)

> Going all the way to strict c89 could be too much, but fixing initializer=
s in a
> few places is a minor issue.  Users of the Sun's compiler can expect us t=
o do
> such changes, just like users of gcc would ask to fix a program that uses=
 c99
> features not yet available in gcc.

I'm not sure about specifically the initializers thing. Personally, I
consider the new C99 initializers one of the very best things that
ever happened to the C language, because it fixes a _real_ problem.
You may have noticed that eg. for the kernel code, these are used
throughoutly...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--nuX4E7Vid9I2gnPU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEsg1AHb1edYOZ4bsRAqOIAKCNt7cbCJJsMfsqXnZQMI2K8DcYbQCghYwf
zyvqDnjgrS3mCXtbEuIDUJM=
=afzG
-----END PGP SIGNATURE-----

--nuX4E7Vid9I2gnPU--
