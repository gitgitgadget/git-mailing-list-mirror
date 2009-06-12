From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: [PATCH] parse-options: add parse_options_check to validate
	option specs.
Date: Fri, 12 Jun 2009 21:31:57 +0200
Message-ID: <20090612193156.GC3129@artemis.corp>
References: <7vd49ewfsi.fsf@alter.siamese.dyndns.org> <1244535824-11970-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 21:33:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFCVG-0002ol-NA
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 21:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756451AbZFLTdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 15:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756238AbZFLTdU
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 15:33:20 -0400
Received: from pan.madism.org ([88.191.52.104]:36703 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756031AbZFLTdT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 15:33:19 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id E6D17464C6;
	Fri, 12 Jun 2009 21:33:19 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 46BC42AEA0; Fri, 12 Jun 2009 21:31:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1244535824-11970-1-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<
	;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u
	*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121443>


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2009 at 10:23:44AM +0200, Pierre Habouzit wrote:
> It only searches for now for the dreaded LASTARG_DEFAULT | OPTARG
> combination, but can be extended to check for any other forbidden
> combination.
>=20
> Options are checked each time we call parse_options_start.
>=20
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  parse-options.c |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)

Has this patch been missed, or has it any kind of flaw that _I_ missed ?
:)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoyrSoACgkQvGr7W6Hudhw6PwCgmm2SEqbWZ7jV5eQemmyXXqVO
ty4Ani75bUZ3yyyF/XnWcdFOuICGDKyE
=kC4N
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
