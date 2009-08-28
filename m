From: Joey Hess <joey@kitenet.net>
Subject: Re: finding unmerged branches
Date: Thu, 27 Aug 2009 20:44:50 -0400
Message-ID: <20090828004450.GA20964@gnu.kitenet.net>
References: <20090827220241.GA1413@gnu.kitenet.net>
 <20090827223504.GA18307@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 02:45:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgpaf-0006k4-G4
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 02:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbZH1ApI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 20:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbZH1ApH
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 20:45:07 -0400
Received: from wren.kitenet.net ([80.68.85.49]:52464 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbZH1ApG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 20:45:06 -0400
Received: from gnu.kitenet.net (fttu-216-41-255-233.btes.tv [216.41.255.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 84E4F314423
	for <git@vger.kernel.org>; Thu, 27 Aug 2009 20:45:07 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 895E1A81A7; Thu, 27 Aug 2009 20:44:50 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20090827223504.GA18307@atjola.homenet>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127238>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Bj=F6rn Steinbrink wrote:
> Hm, not sure if I'd call it "better", but probably at least a bit
> faster. You could create a "fake" merge to combine all the branches.
>=20
> git branch -r --no-merged $(
>   : | git commit-tree HEAD^{tree} $(
>     git for-each-ref --format=3D'-p %(refname)' \
>       refs/heads/ \
>       refs/remotes/origin
>     )
>   )

That does run fast. Has some warnings about duplicate parents. The gitk
method seems more useful.

--=20
see shy jo

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFKlyh/d8HHehbQuO8RAmw9AKCyLLd+gDwYGY7XyJVXgfxLRQDBygCgpBht
VDYlNuSbUKScO3dxH+MJKdY=
=eegC
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
