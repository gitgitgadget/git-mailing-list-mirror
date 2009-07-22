From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: janitoring
Date: Thu, 23 Jul 2009 00:02:09 +0200
Message-ID: <20090722220209.GE13823@artemis.corp>
References: <1248298475-2990-1-git-send-email-madcoder@debian.org>
 <7vws60cr9m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 00:02:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjtG-0003vg-Tr
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 00:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754350AbZGVWCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 18:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754281AbZGVWCP
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 18:02:15 -0400
Received: from pan.madism.org ([88.191.52.104]:56763 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754181AbZGVWCO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 18:02:14 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 611824652A;
	Thu, 23 Jul 2009 00:02:14 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id CF3812AEA0; Thu, 23 Jul 2009 00:02:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vws60cr9m.fsf@alter.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123795>


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2009 at 03:00:21PM -0700, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > [PATCH 1/3] janitor: use NULL and not 0 for pointers.
> >
> >   I really dislike the use of 0 when NULL is meant. This patch probably
> >   fixes most of them. The biggest culprit is nedmalloc, but a few
> >   remnants exist in plain git code.
>=20
> I am not enthused about "fixing" borrowed foreign code, unless we know
> that we are committed to support our fork.  My impression was that this
> ned stuff was borrowed by the MinGW folks with the understanding that we
> will slurp it with minimum modification and turn a blind eye to its
> sub-par coding styles, so that it can be more easily updated from the
> upstream?

Okay, maybe the 2-3 hunks that don't apply to nedmalloc stuff can be
saved though, do you want me to send an updated patch ?

--=20
Intersec <http://www.intersec.com>
Pierre Habouzit <pierre.habouzit@intersec.com>
T=C3=A9l : +33 (0)1 5570 3346
Mob : +33 (0)6 1636 8131
Fax : +33 (0)1 5570 3332
37 Rue Pierre Lhomme
92400 Courbevoie

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpnjGEACgkQvGr7W6HudhxH5wCgnib7wqLu3Ai110g9DOe4ZXya
MCQAn01fKQWNV45WTdS077iWGKUvRNrX
=o1Mv
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
