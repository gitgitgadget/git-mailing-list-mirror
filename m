From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/3] git send-email: do not ask questions when  --compose is used.
Date: Sat, 01 Nov 2008 18:43:52 +0100
Message-ID: <20081101174352.GG26229@artemis.corp>
References: <20081031220149.GD21345@maintenance05.msc.mcgregor-surmount.com> <20081101130033.GD17961@sys-0.hiltweb.site> <20081101170817.GC26229@artemis.corp> <200811011834.32702.fg@one2team.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="64j1qyTOoGvYcHb1";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Francis Galiegue <fg@one2team.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 18:47:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwKZg-0001CF-QU
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 18:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbYKARn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 13:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbYKARn4
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 13:43:56 -0400
Received: from pan.madism.org ([88.191.52.104]:33022 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbYKARnz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 13:43:55 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id AE9893B199;
	Sat,  1 Nov 2008 18:43:53 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 6BDD95EE245; Sat,  1 Nov 2008 18:43:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200811011834.32702.fg@one2team.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99752>


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2008 at 05:34:32PM +0000, Francis Galiegue wrote:
> Le Saturday 01 November 2008 18:08:17 Pierre Habouzit, vous avez =C3=A9cr=
it=C2=A0:
> [...]
> >
> > To: John Doe <some.address@some.tld>, Random Joe <random.joe@abc.def>,
> >   Superman <batman@nyc.us>,
> >   "Someone with a comma, inside its tag name" <a@b.com>
> >
>=20
> fg@erwin ~ $ cat t.txt
> To: John Doe <some.address@some.tld>, Random Joe <random.joe@abc.def>,=20
> Superman <batman@nyc.us>, "Someone with a comma, inside its tag name"=20
> <a@b.com>
> fg@erwin ~ $ <t.txt perl -ne 's,^To:\s*,,i; @mails =3D m/\s*((?:"[^"]+")?
> \s*<[^@]+@[^@]+>)\s*,?/g; END { print join("\n", @mails) . "\n"}'
> <some.address@some.tld>
> <random.joe@abc.def>
> <batman@nyc.us>
> "Someone with a comma, inside its tag name" <a@b.com>
>=20
> That's regex, not especially perl ;)

Your regex fails to parse:

"Someone with a comma, and an escape double quote \" in its name"
  <regex.cant.be.used.for.serious.parsing@i.told.you.so>

That's why I first hinted at some MIME library that has probably made
that right.

Not to mention that you don't fix the multiline issue, but that is quite
less of a problem, it merely needs an accumulator and a 1 line lookahead
in the parser code while in the header parts. Nothing unrealistic for me
to write.

But I just can't resolve myself to parse anything with regex because I
just know it's horribly broken and wrong.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkMlVgACgkQvGr7W6Hudhy/PgCfQA3v48LWdNdO9y0Atbzk4PDV
CH0An2N10LKUC5/kml7HZAEdSsO3jImV
=NAgR
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--
