From: Martin Uecker <muecker@gmx.de>
Subject: Re: WARNING! Object DB conversion (was Re: [PATCH] write-tree performance problems)
Date: Wed, 20 Apr 2005 18:33:42 +0200
Message-ID: <20050420163342.GA14434@macavity>
References: <200504192049.21947.mason@suse.com> <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org> <42660708.60109@zytor.com> <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org> <2cfc403205042005116484231c@mail.gmail.com> <20050420132446.GA10126@macavity> <Pine.LNX.4.61.0504201025030.2630@cag.csail.mit.edu> <20050420151902.GA13175@macavity> <Pine.LNX.4.61.0504201121490.2630@cag.csail.mit.edu> <20050420155734.GA13575@macavity>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Cc: Martin Uecker <muecker@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 20 18:33:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOI76-0004CR-3x
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 18:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVDTQfy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 12:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVDTQfy
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 12:35:54 -0400
Received: from dialin-145-254-143-183.arcor-ip.net ([145.254.143.183]:4225
	"EHLO macavity") by vger.kernel.org with ESMTP id S261716AbVDTQfm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 12:35:42 -0400
Received: from martin by macavity with local (Exim 4.34)
	id 1DOI9A-0003n8-Op; Wed, 20 Apr 2005 18:33:52 +0200
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Martin Uecker <muecker@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050420155734.GA13575@macavity>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 20, 2005 at 05:57:34PM +0200, Martin Uecker wrote:
> On Wed, Apr 20, 2005 at 11:28:20AM -0400, C. Scott Ananian wrote:
>=20
> > Yes, I guess this is the detail I was going to abandon. =3D)
> >=20
> > I viewed the fact that the top-level hash was dependent on the exact ch=
unk=20
> > makeup a 'misfeature', because it doesn't allow easy interoperability w=
ith=20
> > existing non-chunked repos.
>=20
> I thought this as a misfeature too before I realized how
> many advantages this has.

To make it more clear: Ofcourse it is a bug if the
hash depends on unimportant implementation details.

But a hash which is calculated recusively from
subhashes is a lot more usefull than a hash
which can only be calculated from the entire data
at once. And if this hash can be recalculated
cheaply from subhashes even if some data was
inserted somewhere this is an even more usefull
thing.

Martin

--=20
One night, when little Giana from Milano was fast asleep,
she had a strange dream.


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCZoRmYDJInvULMKYRAtSXAKCJ9lN4He0ubuH9v9bKjdXtvNbAGQCfZRNk
SQfXfpyV9j7XOLfQT3QNlv4=
=EgID
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
