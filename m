From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Port builtin-add.c to use the new option parser.
Date: Sat, 13 Oct 2007 22:27:06 +0200
Message-ID: <20071013202706.GJ7110@artemis.corp>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <1192282153-26684-2-git-send-email-madcoder@debian.org> <1192282153-26684-3-git-send-email-madcoder@debian.org> <Pine.LNX.4.64.0710131544030.25221@racer.site> <20071013150306.GH7110@artemis.corp> <20071013192213.GB2875@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Z8yxTSU1mh2gsre7";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 22:27:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgnZx-0002lR-0v
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 22:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756252AbXJMU1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 16:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754277AbXJMU1J
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 16:27:09 -0400
Received: from pan.madism.org ([88.191.52.104]:60213 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753870AbXJMU1I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 16:27:08 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id C8856244D2;
	Sat, 13 Oct 2007 22:27:06 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 1950E3A0976; Sat, 13 Oct 2007 22:27:06 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
Content-Disposition: inline
In-Reply-To: <20071013192213.GB2875@steel.home>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60774>


--Z8yxTSU1mh2gsre7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 13, 2007 at 07:22:13PM +0000, Alex Riesen wrote:
> Pierre Habouzit, Sat, Oct 13, 2007 17:03:06 +0200:
> > On Sat, Oct 13, 2007 at 02:47:20PM +0000, Johannes Schindelin wrote:
> > > Thinking about this more, I am reverting my stance on the ARRAY_SIZE(=
)=20
> > > issue.  I think if you introduce a "OPTION_NONE =3D 0" in the enum, t=
hen=20
> > > this single last comma should be enough.
> >=20
> >   adding a trailing comma does not add a NULL after that, it's ignored,
> > you're confused.
>=20
> Yep
>=20
> >   Note that I don't really like using ARRAY_SIZE either, I kept it that
> > way, but my taste would rather be to have an "empty" option, and
> > explicitely mark the end of the array.
>=20
> You can have both. Just stop at NULL-entry or when the 'size' elements
> passed, whatever happens first.

  Well I dislike the "count" thing, and Dscho agreed that it somehow
sucked too. If you go see the current state of the ph/parseopt series
you'll see it's not here anymore.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Z8yxTSU1mh2gsre7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHESoavGr7W6HudhwRAg4uAJ9ONuyBnFp1szpMo/qG08/IIOMLwQCeLrEc
hiBhPh+tvReqwHDPKEkvcbo=
=BoJD
-----END PGP SIGNATURE-----

--Z8yxTSU1mh2gsre7--
