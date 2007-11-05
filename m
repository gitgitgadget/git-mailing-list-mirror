From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/3] parseopt: introduce OPT_RECURSE to specify shared options
Date: Mon, 05 Nov 2007 23:14:25 +0100
Message-ID: <20071105221425.GQ8939@artemis.corp>
References: <1194264204-3475-1-git-send-email-madcoder@debian.org> <1194264204-3475-2-git-send-email-madcoder@debian.org> <Pine.LNX.4.64.0711051230020.4362@racer.site> <Pine.LNX.4.64.0711051237420.4362@racer.site> <Pine.LNX.4.64.0711051315300.4362@racer.site> <Pine.LNX.4.64.0711051340490.4362@racer.site> <7vd4uonz30.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="orO6xySwJI16pVnm";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 23:14:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpADS-0002Kz-2Q
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 23:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbXKEWO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 17:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbXKEWO2
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 17:14:28 -0500
Received: from pan.madism.org ([88.191.52.104]:33042 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbXKEWO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 17:14:27 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3C24A282E5;
	Mon,  5 Nov 2007 23:14:26 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id CEC574BB4E; Mon,  5 Nov 2007 23:14:25 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vd4uonz30.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63570>


--orO6xySwJI16pVnm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2007 at 09:48:19PM +0000, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > After kicking this around a bit more on IRC, we had another idea.  Inst=
ead=20
> > of introducing OPT_RECURSE(), do something like OPT__QUIET(), only this=
=20
> > time in diff.h:
> >
> > #define OPT__DIFF(opt) \
> > 	OPT_BOOLEAN('p', NULL, &opt.format_patch, "show a patch"), \
> > 	...
> >
> > Pierre said this feels a bit "80s", so I'd like to hear other people's=
=20
> > opinions.
> >
> > Hmm?
>=20
> As I am from "80s" ;-)

Hey grand'pa, how are your rheumatisms today :-P

> I like the simpler "macro" one much better.  There aren't many things
> that can go wrong in the approach.

Okay, I suppose we will end up using the big macros then. Though I had a
look at diff_opt_parse and setup_revisions, the move isn't for tomorrow.

  The current code is heavy (at best), and has some logic that parseopt
is not yet ready to deal with (mainly the --not flags).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--orO6xySwJI16pVnm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHL5XBvGr7W6HudhwRAvMUAJ4rNgxHuMdFlFLk9BgSmq6jMVO0BgCgmLBL
J5T/pbt+GnFyREOwnazuMYg=
=ET38
-----END PGP SIGNATURE-----

--orO6xySwJI16pVnm--
