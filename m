From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Sat, 15 Dec 2007 12:03:11 +0100
Message-ID: <20071215110311.GA11321@artemis.madism.org>
References: <20071213091055.GA5674@coredump.intra.peff.net> <20071213093536.GC12398@artemis.madism.org> <7vbq8u4ho8.fsf@gitster.siamese.dyndns.org> <20071213180347.GE1224@artemis.madism.org> <1197570521.28742.0.camel@hinata.boston.redhat.com> <1197571656.28742.13.camel@hinata.boston.redhat.com> <20071214040803.GA10169@sigill.intra.peff.net> <7vir31vmsn.fsf@gitster.siamese.dyndns.org> <20071214083943.GA24475@artemis.madism.org> <7v63z1qakt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="rwEMma7ioTxnRzrJ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 12:03:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3Unz-0004wJ-0f
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 12:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbXLOLDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 06:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbXLOLDP
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 06:03:15 -0500
Received: from pan.madism.org ([88.191.52.104]:37596 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489AbXLOLDO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 06:03:14 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 0F74026283;
	Sat, 15 Dec 2007 12:03:12 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id D6B4F3B12E0; Sat, 15 Dec 2007 12:03:11 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v63z1qakt.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68383>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On ven, d=C3=A9c 14, 2007 at 08:34:58 +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > On Fri, Dec 14, 2007 at 05:59:52AM +0000, Junio C Hamano wrote:
> >> 	git cmd --abbrev=3D10 -n=3D4
> >
> >   actually -n=3D4 isn't understood atm, only -n4 and -n 4 are.
>=20
> Ah, my mistake.  And I do not think accepting -n=3D4 is a good idea (it is
> not historically done).

> After thinking about it a bit more, I think I was worried too much about
> burdening the users to remember the differences between options with,
> without and optional option-arguments [*1*].  They need to know the
> difference between options with and without option-arguments already
> because single letter options can be combined if they are without
> option-arguments, and they have to write "shortlog -new72" but not
> "shortlog -wen72".  If they want to be extra sure, they can be more
> explicit and say "shortlog -n -e -w72".

  Yep, let's do it then. Note that's the reason why I felt we need a
manual page about this, because we should give some guidelines of what
is safe for scripting.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHY7RvvGr7W6HudhwRAq06AJ9V52+tA6F5f0aceqSltOXGkCtizACdG1oA
0hJ57URCMz/dNBGG9+P80YI=
=gfA4
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
