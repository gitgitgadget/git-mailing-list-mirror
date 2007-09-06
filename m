From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 6/7] Eradicate yet-another-buffer implementation in  buitin-rerere.c
Date: Thu, 06 Sep 2007 19:17:34 +0200
Message-ID: <20070906171734.GG8451@artemis.corp>
References: <20070902224213.GB431@artemis.corp> <11890776114037-git-send-email-madcoder@debian.org> <118907761140-git-send-email-madcoder@debian.org> <11890776111843-git-send-email-madcoder@debian.org> <11890776112292-git-send-email-madcoder@debian.org> <11890776111670-git-send-email-madcoder@debian.org> <11890776112309-git-send-email-madcoder@debian.org> <11890776112641-git-send-email-madcoder@debian.org> <Pine.LNX.4.64.0709061504521.28586@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="1XWsVB21DFCvn2e8";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 06 19:17:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITKz9-0001WU-Fb
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 19:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887AbXIFRRj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 13:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753885AbXIFRRj
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 13:17:39 -0400
Received: from pan.madism.org ([88.191.52.104]:33529 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753790AbXIFRRi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 13:17:38 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 0842C1E4F4;
	Thu,  6 Sep 2007 19:17:37 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id A59691A3DD; Thu,  6 Sep 2007 19:17:34 +0200 (CEST)
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709061504521.28586@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57912>


--1XWsVB21DFCvn2e8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2007 at 02:05:36PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Thu, 6 Sep 2007, Pierre Habouzit wrote:
>=20
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >  builtin-rerere.c |   56 +++++++++++++++++-----------------------------=
-------
> >  1 files changed, 18 insertions(+), 38 deletions(-)
>=20
> I like that one very much, but ...
>=20
> >  	FILE *f =3D fopen(path, "r");
> >  	FILE *out;
> > =20
> > +        strbuf_init(&minus);
> > +        strbuf_init(&plus);
> > +
>=20
> You used spaces instead of tabs here.

  crap, and I did that in the 5th patch as well. well, I'll maybe send
privately a "fixed" version of the patch to junio then, to avoid
flooding the list with spacing issues.

  And I'll also set my vim to use tabs when I'm hacking on git.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--1XWsVB21DFCvn2e8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4DYuvGr7W6HudhwRAnqBAJkBgzPhWpBXwvc/asr3ufOH1DyR9ACfdZ37
u846lSDmwdjIJK+8eQ67CBo=
=ICEx
-----END PGP SIGNATURE-----

--1XWsVB21DFCvn2e8--
