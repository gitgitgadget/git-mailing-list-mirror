From: Joey Hess <joey@kitenet.net>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 13:24:38 -0500
Message-ID: <20100120182438.GB31507@gnu.kitenet.net>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 19:24:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXfEV-00087A-Az
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 19:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011Ab0ATSYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 13:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753756Ab0ATSYm
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 13:24:42 -0500
Received: from wren.kitenet.net ([80.68.85.49]:35086 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753303Ab0ATSYl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 13:24:41 -0500
Received: from gnu.kitenet.net (fttu-216-41-255-233.btes.tv [216.41.255.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 5B7AB118FF6
	for <git@vger.kernel.org>; Wed, 20 Jan 2010 13:24:40 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 028C4A8366; Wed, 20 Jan 2010 13:24:38 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <201001201148.11701.johan@herland.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137561>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Johan Herland wrote:
> As Thomas already stated, git log is porcelain, and its output format is =
not=20
> set in stone. If you need a stable, script-friendly format, you should=20
> probably use the --format option, or use plumbing instead (such as e.g. g=
it=20
> rev-list, which also has a --format option).

But git log --format=3Draw --raw output was changed by notes.

> > Might be worth documenting in release notes, maybe too late now though.
> > But really, it's all good, notes are a great feature.
> >=20
> > PS, Has anyone thought about using notes to warn bisect away from
> > commits that are known to be unbuildable or otherwise cause bisection
> > trouble?
>=20
> No, I haven't thought of that specific use case. Great idea! :)

Only problem I see with doing it is it might be too easy to overwrite
such a note with git notes edit -m

Did you consider having -m append a line to an existing note?

--=20
see shy jo

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBS1dKZskQ2SIlEuPHAQgcFA//cNodzNrRbcXKUplBDVU0BDsUkMg4kfOb
jAgSIAWy+XkFelVrozs0i0ApOW6FNk0XUyn5KyoJDyztVvJZKwyPzPSNu3BSMl0D
qgO6yxiR7DML1KKpsD0yeFcFzYKo0vIXvQqan13Ek2+DLRjaleBhn8CCZFToZ9Qv
MmnISs4MQsGl7+PbmjqGffZyObLRKNhZPlhuKtDn/t1Hh7HSPzcXVY4QATtRDrKN
b7CNt3sWdj99Hd6Ai05y9cCVi6s4JB3XtkwfNuAjRG6iNHI8jbq/Vfa1bbhY7SOT
NQKy91NStIW+qSfILaMYK9/Oy3hoOeLbDLB741gCoPoEE0BigN0rwA8gEN97iyST
ouAFtfYdmShELqCRyjbuZTNyH/Ufl+PIe26w3vG1v2Zz8eWrcN1CEP1nBVxajzRt
tM1gWEnmCS8+NNE36To6rsnsNlULx/ypwDX27iPyMf80JHOSq/OazHNJK4vaDIcd
hD+Sdrh7SQqLBylzdRbzH86WD3EojGrcqJPYzt1KVEfYISnXFKZQzJOWkXJWG5/o
goiJhEsQq9t4k61J6fhlkPbBhXBMKqda/aSDB4EEnWC4vBCwu3VQ5LO/r8nDl34Z
UTCBUeCC2xMFAeRBDfMrPCorpqpaY+gWspKcPFXdKCnfCSYKZmEZcITy1aZzrRlb
/3SzmnLkOPU=
=074U
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
