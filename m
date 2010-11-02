From: Joey Hess <joey@kitenet.net>
Subject: Re: git check-attr -z and quoting
Date: Tue, 2 Nov 2010 18:10:29 -0400
Message-ID: <20101102221029.GA3646@gnu.kitenet.net>
References: <20101102155705.GA17207@gnu.kitenet.net>
 <7583D61F-64FA-44A8-B5C5-6E0FC329ED32@sb.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 02 23:10:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDP48-0007Xd-FS
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 23:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab0KBWKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 18:10:34 -0400
Received: from wren.kitenet.net ([80.68.85.49]:39081 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753430Ab0KBWKd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 18:10:33 -0400
Received: from gnu.kitenet.net (fttu-216-41-255-233.btes.tv [216.41.255.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id CFEE11D2128
	for <git@vger.kernel.org>; Tue,  2 Nov 2010 18:10:31 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 9C9E7466EC; Tue,  2 Nov 2010 18:10:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7583D61F-64FA-44A8-B5C5-6E0FC329ED32@sb.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160559>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Kevin Ballard wrote:
> On Nov 2, 2010, at 8:57 AM, Joey Hess wrote:
>=20
> > First, thanks to all for supporting -z in various commands like=20
> > git ls-files and git diff. Big help for plumbing, as I'm sure you know.
> >=20
> > But, git check-attr -z only enables NUL separation of its input; output
> > always has munged pathnames. This bit me trying to use it as plumbing.
>=20
> What do you mean by munged pathnames? As long as the path doesn't contain=
 the sequence ": " it seems like the output should be unambiguous.

Quoted with quote_c_style()

$ perl -e 'print shift()."\n\0"' '=A1hello!' | git check-attr eol -z --stdin
"\302\241hello!\n": foo: unspecified

Maybe -Z could enable this output:

=A1hello!\n\0foo\0unspecified\0

--=20
see shy jo

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBTNCMUskQ2SIlEuPHAQg7NQ//czF27TYn+DZ+SIgziMCnHdImWuCRI2/s
QQ84oqitgWTvR40KiyzsBsH5vmeX7YO/UdpwCUzHabmJjgKzJ4wdxWw39gB0MmNZ
bDDmM/moF/wpQ2joqRTx76biFrpoV430tBHaN2QBpxi6XEWQGiFDSPiCSMnci3CH
Eyz6veSzfeluP8vxeNU6vQ/NMsJWAuy4D49h3FLSvqlDiJZEbsZ/1zg7TWvU/z3U
v5Kt06ffDqEFurb0599gn5uOtSjxpb8vHGU9N2BnwwLr4TtE/OV3BbIkTnwPXgWl
BHeTvs51y1PEdQxH1jT07hzYwb3ZS3qDRkyzIZf3IbhFViQA1nkGhx3deGEUJhb8
03vJlE8KjofRzty05F13unq3heOiiIFahHSaj27uC8oE/qIrGEhXEI6fNI9XxjOv
OIhUkUz/4+rsDer8OTPl37pQefld4WWsbJxpWnjczjvv5/9v3xqtWJl7246cKZQN
9YknXAU3PBcc+CbumsNKJGY7GzyFJ4TX8v6DvZi+fwO+iSckPS+B54ppCm93NF2/
V9hy3/+HKo/Ap/J2eNIatGHYeG2OwJkCJt4bYDWX6X79DQZVRgewn6540UqYd/Aj
Ja67DpTJ++l+XDMkD/ByB5sQVGnGs/G3D029gd1wDg0EcMe2Vz/BPGs5i3Mkz24q
MNaUkWfLxfc=
=lgPO
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
