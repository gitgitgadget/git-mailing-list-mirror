From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH] sha1_file: avoid bogus "file exists" error message
Date: Wed, 26 Nov 2008 13:19:28 -0500
Message-ID: <20081126181928.GA31007@kodama.kitenet.net>
References: <20081120185628.GA25604@kodama.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 26 19:20:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5P0L-0003i1-N6
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 19:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbYKZSTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 13:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbYKZSTc
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 13:19:32 -0500
Received: from wren.kitenet.net ([80.68.85.49]:35043 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168AbYKZSTc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 13:19:32 -0500
Received: from kodama.kitenet.net (fttu-67-223-5-142.btes.tv [67.223.5.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Joey Hess", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 364C2314372
	for <git@vger.kernel.org>; Wed, 26 Nov 2008 13:19:30 -0500 (EST)
Received: by kodama.kitenet.net (Postfix, from userid 1000)
	id E71399C075; Wed, 26 Nov 2008 13:19:28 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20081120185628.GA25604@kodama.kitenet.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8684/Wed Nov 26 10:37:33 2008 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101755>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Joey Hess wrote:
> Note that in both occasions that I've seen this failure, it has not been
> due to a missing directory, or bad permissions

Actually, it was due to bad permissions. :-) Once git was fixed to
actually say that, I figured out where to look to fix them.

--=20
see shy jo

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFJLZMwd8HHehbQuO8RAk+MAJ9OusksbBW1E/lp1PAB1b0dv6mD1gCfa3+S
cvnT9WAwH1iPVYFTFpo3t8g=
=6GpU
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
