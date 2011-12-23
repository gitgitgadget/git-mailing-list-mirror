From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH] fix shell command line in example
Date: Fri, 23 Dec 2011 13:33:15 -0400
Message-ID: <20111223173315.GB23049@gnu.kitenet.net>
References: <20111223164128.GA21918@gnu.kitenet.net>
 <8739cbi5v3.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 23 18:33:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Re8zn-0008SB-Ns
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 18:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757525Ab1LWRdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 12:33:23 -0500
Received: from wren.kitenet.net ([80.68.85.49]:59158 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754110Ab1LWRdW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 12:33:22 -0500
Received: from gnu.kitenet.net (dialup-4.252.10.92.Dial1.Atlanta1.Level3.net [4.252.10.92])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 9E0EA1183C0
	for <git@vger.kernel.org>; Fri, 23 Dec 2011 12:33:20 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id C808F42A75; Fri, 23 Dec 2011 12:33:15 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <8739cbi5v3.fsf@thomas.inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187636>


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thomas Rast wrote:
>   * Update the upstream origin of the current branch, then merge the
>     tracked branch into the current one:
>   +
>   --------------------------------------------------
>   $ git pull
>   --------------------------------------------------
>=20
> modulo avoiding confusion around upstream/tracking.

I support having a simple "git pull" example; I think it's the first
thing users should be reaching for, followed perhaps by "git pull foo bar"
when they have multiple remotes.=20

Still, an example of pulling all tracking branches from a remote and
merging in the right one for the currently checked out branch would be
good to have, that's also a common need when using git without a
centralized origin. AFAICS, there's no way to do all that in a single
git pull command? My feeling was that this sort of scenario was what
the example was trying to do (rather badly).

--=20
see shy jo

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTvS7W8kQ2SIlEuPHAQhOFRAAjCbmr5dIHGty4dd7KuaIsdK+jetawmpW
bbHRi5kCckQsMWstAqX+Fq4ay/gxeWHmq1l+dsxqmoSmTEVyfvPR5LpxxudUNRC1
MQUptMpiJy9MItRYEXwpNn2sMDEPkAXGNnBdL6EMfoku2ZHTDqfoD/c+JXkjW9+P
2MeyxYugLMooKlqAoAv2iyrmNkNLtm9r5/GXgsqBot4PpbgB83BcwQxPGe8elY5q
8zFwoz+pi+exQ7aP6MtMu6P1TSNJG1cu6IMBXBfUqM3EH7hHV/7Pk7gLClRJuQKP
rPOXldGdhZm3cMzGZxbLG+iuGwoGDMN4XY7+ZlZjnKxXZIf1/iaZOCxzIPg/ZbPy
LleVNxNMvqYnQyxlxLWSEEG7WmlRVQ1Wfrf1ywohD/Rv7PVE2d8R07Um6RrZXqLe
LR5f7Q6etKFf7KB9uBrVXOK+qe/Seqls5T8tn5acBIdPA4He1G4DzLzg6nPscFCP
5fkwqjK0BDIbNRBj+1i/q/W5ZYpRSAJmqV0oIFa/mbuf8OTKTvnbOw1Mwozh1d6j
cQSFWesIMKWagJNK0YOnZtOhwOIyWTsaCv2yKdYINvHCI2BtvpGJkHOgQJiMktE3
F1e9IPproi1ZJICQiy4K1zpEGZs7bsy+Psl7wgsEy6F41HgNPuHGcuj0i87Uqt1j
ioUVfKDibIw=
=Cqwl
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
