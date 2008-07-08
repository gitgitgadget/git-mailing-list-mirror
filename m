From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/6] revisions: refactor init_revisions and   setup_revisions.
Date: Tue, 08 Jul 2008 14:48:32 +0200
Message-ID: <20080708124832.GH19202@artemis.madism.org>
References: <1215510964-16664-1-git-send-email-madcoder@debian.org> <1215510964-16664-2-git-send-email-madcoder@debian.org> <alpine.DEB.1.00.0807081258010.4319@eeepc-johanness> <20080708110624.GF19202@artemis.madism.org> <alpine.DEB.1.00.0807081339270.4319@eeepc-johanness>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="fmEUq8M7S0s+Fl0V";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, torvalds@linux-foundation.org,
	gitster@pobox.com, peff@peff.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 08 14:49:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGCdq-00014R-2C
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 14:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760175AbYGHMsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 08:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759900AbYGHMsj
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 08:48:39 -0400
Received: from pan.madism.org ([88.191.52.104]:46635 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760169AbYGHMsi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 08:48:38 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id BEC68281B9;
	Tue,  8 Jul 2008 14:48:33 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 8747A5A15DD; Tue,  8 Jul 2008 14:48:32 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, torvalds@linux-foundation.org,
	gitster@pobox.com, peff@peff.net
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807081339270.4319@eeepc-johanness>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87758>


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On mar, jui 08, 2008 at 11:43:15 +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 8 Jul 2008, Pierre Habouzit wrote:
>=20
> > On Tue, Jul 08, 2008 at 10:59:43AM +0000, Johannes Schindelin wrote:
> >=20
> > > On Tue, 8 Jul 2008, Pierre Habouzit wrote:
> > >=20
> > > > setup_revisions has been split in two: parse_revisions that does=20
> > > > (almost) only argument parsing, to be more like what parse-options=
=20
> > > > can do, and setup_revisions that does the rest.
> > >=20
> > > I do not see the sense of this change, except
> >=20
> > Well, it's required to remove "parse_revisions" at once if we one day=
=20
> > reach the goal of having only parse-opt based parsers.
>=20
> We can do that, then.
>=20
> We do not need to do that, now.

  hmmm right, I may be able to cook a simpler series without that
indeed. Ill repost a new one with this idea.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhzYiAACgkQvGr7W6HudhyQVgCfdH8THaDhmNV2FNL4Xku/Ctnj
U/MAoJmOvKYoc2Zw3ogOEJ7T+cWKFNQe
=r7bI
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--
