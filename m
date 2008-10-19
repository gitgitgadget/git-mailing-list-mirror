From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] parse-opt: migrate builtin-checkout-index.
Date: Sun, 19 Oct 2008 22:19:34 +0200
Message-ID: <20081019201934.GO16610@artemis.corp>
References: <1224441040-5071-1-git-send-email-vmiklos@frugalware.org> <7vabd073bg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="tv2SIFopg1r47n4a";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 12:02:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrepQ-0000gV-ED
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 22:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbYJSUTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 16:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbYJSUTi
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 16:19:38 -0400
Received: from pan.madism.org ([88.191.52.104]:55553 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616AbYJSUTh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 16:19:37 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id D2E053ED36;
	Sun, 19 Oct 2008 22:19:35 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 66B24778397; Sun, 19 Oct 2008 22:19:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vabd073bg.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98638>


--tv2SIFopg1r47n4a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2008 at 08:11:31PM +0000, Junio C Hamano wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:
>=20
> > Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> > ---
> >
> > On Sat, Oct 18, 2008 at 03:17:23AM +0200, Miklos Vajna <vmiklos@frugalw=
are.org> wrote:
> >> > This adds a new feature to say --no-z from the command line, doesn't
> >> > it?
> >> > And I suspect the feature is broken ;-).
> >>
> >> Right, I fixed this in option_parse_z(). --no-z should set
> >> line_termination to \n instead of 1.
> >
> > Originally in option_parse_z() I had
> >
> >         line_termination =3D unset;
> >
> > which is in fact right, because (as Pierre pointed out) unset for short
> > options are always false, but I changed it to
> >
> >         line_termination =3D 0;
> >
> > to make it more readable.
>=20
> I think Pierre's comment is short-sighted.  Think of what would happen
> when somebody adds "--nul" as a longer equivalent to "-z", since it is
> extremely easy to do things like that with the use of parse-opt API?

Err I was only pointing out that --no-z would no nothing, I actually
didn't really read the argument :)  I didn't say having --null was a bad
idea, and I think we have -z/--null at a couple of places already, and
it's probably a good thing to actually _add_ --null.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--tv2SIFopg1r47n4a
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkj7llYACgkQvGr7W6HudhxDHgCgk6UqwwKo+Gip0R9wXm8hUm53
5O4AoJjbMsL65uLVsKSu1L5ku5wWlD+n
=DVtU
-----END PGP SIGNATURE-----

--tv2SIFopg1r47n4a--
