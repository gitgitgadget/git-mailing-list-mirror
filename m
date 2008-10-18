From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH v2] parse-opt: migrate builtin-checkout-index.
Date: Sat, 18 Oct 2008 17:54:37 +0200
Message-ID: <20081018155436.GA4803@artemis>
References: <1224111343-17433-1-git-send-email-vmiklos@frugalware.org> <20081016082340.GB15266@artemis.corp> <20081016132810.GG536@genesis.frugalware.org> <7v63nqg4f4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="YiEDa0DAkWCtVeE4";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 17:55:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrE9h-0005O2-QJ
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 17:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbYJRPyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 11:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbYJRPyl
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 11:54:41 -0400
Received: from pan.madism.org ([88.191.52.104]:34084 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbYJRPyl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 11:54:41 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 295C614B;
	Sat, 18 Oct 2008 17:54:39 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5C75F2A378; Sat, 18 Oct 2008 17:54:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v63nqg4f4.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98555>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2008 at 11:58:23PM +0000, Junio C Hamano wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:
>=20
> > +static int option_parse_z(const struct option *opt,
> > +			  const char *arg, int unset)
> > +{
> > +	line_termination =3D unset;
> > +	return 0;
> > +}
> > ...
> > +		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
> > +			"paths are separated with NUL character",
> > +			PARSE_OPT_NOARG, option_parse_z },
>=20
> This adds a new feature to say --no-z from the command line, doesn't it?
> And I suspect the feature is broken ;-).

No it doesn't, --no-foo is only active for long options.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkj6BrsACgkQvGr7W6HudhyG3QCdGNFjwEFQCwOY/it0PBR5SdUE
OnEAn2iC+Tj7shV22sdVYPmRXjDBHGvI
=4Eog
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
