From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Add some fancy colors in the test library when terminal supports it.
Date: Tue, 23 Oct 2007 10:13:27 +0200
Message-ID: <20071023081327.GA21334@artemis.corp>
References: <20071022081341.GC32763@artemis.corp> <200710230608.15124.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="EVF5PPMfhYS0aIcm";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 10:13:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkEtU-0003b3-FB
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 10:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbXJWINd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 04:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbXJWINc
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 04:13:32 -0400
Received: from pan.madism.org ([88.191.52.104]:37896 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564AbXJWINa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 04:13:30 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id DACFF2653A;
	Tue, 23 Oct 2007 10:13:28 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id A2AB33CC0B2; Tue, 23 Oct 2007 10:13:27 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200710230608.15124.chriscool@tuxfamily.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62120>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2007 at 04:08:14AM +0000, Christian Couder wrote:
> Hi Pierre,
>=20
> Le lundi 22 octobre 2007, Pierre Habouzit a =C3=A9crit :
> > +
> > +say_color () {
> > +	[ "$nocolor" =3D 0 ] &&  [ "$1" !=3D '-1' ] && tput setaf "$1"
> > +	shift
> > +	echo "* $*"
> > +	tput op
> > +}
> > +
> >  error () {
> > -	echo "* error: $*"
> > +	say_color 9 "* error: $*"
>=20
> This will print something like "* * error: ..." instead of "* error: ..."
>=20
> The following should work:
>=20
> > +	say_color 9 "error: $*"
>=20
> By the way, where do the 9 here and the 10 and the -1 below come from ?
> "man 5 terminfo" says that only values form 0 to 7 are portably defined.
> Maybe 9 is a bold red and 10 a bold green, or something like that, but it=
=20
> doesn't seem to work on my konsole.

Right I should use tput setb or sth like that to ask for bold mode
probably.

> Anyway, perhaps having:
>=20
> _red=3D1
> _green=3D2
>=20
> and then using "say_color $_red stuff" might be easier to understand and=
=20
> change if needed.

Agreed.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHHa0nvGr7W6HudhwRApsHAJ44LNxaOJly4O0RSfxgWkwbf8FqDwCeNO24
4HiJe35XUl6bFh21jENA9TM=
=2axQ
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
