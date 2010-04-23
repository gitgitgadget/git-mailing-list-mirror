From: Eric Raymond <esr@thyrsus.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 18:25:22 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100423222522.GA21224@thyrsus.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <20100422155806.GC4801@progeny.tock>
 <4BD1EE10.4010009@gmx.de>
 <k2ub4087cc51004231234z29228ac8ia0f62a4e16cedae4@mail.gmail.com>
 <4BD21CAB.8060903@gmx.de>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 24 00:25:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5RJS-00088d-M7
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 00:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516Ab0DWWZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 18:25:24 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:35569
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042Ab0DWWZX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 18:25:23 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 5A683479E92; Fri, 23 Apr 2010 18:25:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4BD21CAB.8060903@gmx.de>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145645>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Matthias Andree <matthias.andree@gmx.de>:
> Am 23.04.2010 21:34, schrieb Michael Witten:
> > On Fri, Apr 23, 2010 at 13:59, Matthias Andree <matthias.andree@gmx.de>=
 wrote:
> >> I'd also concur that "default to commit -a" would be a most undesireab=
le
> >=20
> > The proposal was not "default to commit -a" but rather "default to
> > commit -a when the index has not been explicitly updated with
> > something like git add".
>=20
> Which is the same:
>=20
> default (n) (5b) "a selection automatically used by a computer program
> in the absence of a choice made by the user" (Merriam-Webster)
>=20
> No previous "git add" =3D> default "git commit -a".  Exactly what I don't
> want.  It makes the software appear at nondeterministic as you add to
> the "if"s and "but"s, and it breaks established practice.
>=20
> It is not desirable to break established workflows for the sake of
> newcomers' convenience.

Speaking as a relative newcomer, I concur.  Commands that are simpler
to mentally model, because they don't have a lot of exception cases,
are better.
--=20
		<a href=3D"http://www.catb.org/~esr/">Eric S. Raymond</a>

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFL0h5SrfUW04Qh8RwRArs6AKDyooNyyr+I29vUnissx0tBC5wNnACg3z8k
eiQzBjJhvy5ITBiVnzAppyg=
=H85k
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
