From: Joey Hess <joey@kitenet.net>
Subject: Re: finding unmerged branches
Date: Thu, 27 Aug 2009 20:54:20 -0400
Message-ID: <20090828005420.GB20964@gnu.kitenet.net>
References: <20090827220241.GA1413@gnu.kitenet.net>
 <32541b130908271522u1048dcb1h67b79049e46df1ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 02:55:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgpkX-0000UN-0Y
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 02:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbZH1Ayf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 20:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbZH1Ayf
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 20:54:35 -0400
Received: from wren.kitenet.net ([80.68.85.49]:49286 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbZH1Aye (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 20:54:34 -0400
Received: from gnu.kitenet.net (fttu-216-41-255-233.btes.tv [216.41.255.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 4498D314423
	for <git@vger.kernel.org>; Thu, 27 Aug 2009 20:54:36 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 82932A81A7; Thu, 27 Aug 2009 20:54:20 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <32541b130908271522u1048dcb1h67b79049e46df1ac@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127239>


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Avery Pennarun wrote:
> How about:
>=20
> gitk $(git for-each-ref --format=3D'%(refname)' 'refs/remotes/'; git
> for-each-ref --format=3D'^%(refname)' 'refs/heads/')
>=20
> You could also replace 'gitk' with 'git log', and mess with the
> --pretty=3Dformat:whatever parameter.

I added 'refs/remotes/origin/' 'refs/tags/' to the list, and that's
almost perfect, thanks.

Though there was one remote branch where gitk showed a lot of commits
=66rom origin/master before the unmerged changes in the branch. Could not
figure out why, git log doesn't show them.

--=20
see shy jo

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFKlyq8d8HHehbQuO8RAic7AJkB2r2tio+XCAlXVBIDCMMXH1+E2ACdHNnK
SaA7PBEP9dIGK8AJEBqcFDs=
=mbYN
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
