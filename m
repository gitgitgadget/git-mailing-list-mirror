From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Allow the envelope sender to be set via configuration
Date: Sat, 7 Jun 2008 15:03:30 +0200
Message-ID: <20080607130330.GD29404@genesis.frugalware.org>
References: <1212824022-31991-1-git-send-email-ask@develooper.com> <m3fxrpy5ji.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GJQzf4n/7sgn7z2y"
Cc: Ask Bj?rn Hansen <ask@develooper.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 15:05:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4y6K-0001vj-OX
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 15:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbYFGNDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 09:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753804AbYFGNDc
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 09:03:32 -0400
Received: from virgo.iok.hu ([193.202.89.103]:46635 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904AbYFGNDc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 09:03:32 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A1B401B2579;
	Sat,  7 Jun 2008 15:03:30 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 697F34469E;
	Sat,  7 Jun 2008 14:45:33 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 192071190ACA; Sat,  7 Jun 2008 15:03:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m3fxrpy5ji.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84199>


--GJQzf4n/7sgn7z2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 07, 2008 at 02:10:16AM -0700, Jakub Narebski <jnareb@gmail.com>=
 wrote:
> Ask Bj?rn Hansen <ask@develooper.com> writes:
>=20
> > ---
> >  git-send-email.perl |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index a598fdc..ec69c23 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -209,6 +209,7 @@ my %config_settings =3D (
> >      "bcc" =3D> \@bcclist,
> >      "aliasesfile" =3D> \@alias_files,
> >      "suppresscc" =3D> \@suppress_cc,
> > +    "envelopesender" =3D> \$envelope_sender,
> >  );
> > =20
> >  # Handle Uncouth Termination
>=20
> Thanks. Documentation, pretty please?

And it would be nice to add a testcase in the testsuite as well.

--GJQzf4n/7sgn7z2y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhKhyEACgkQe81tAgORUJZ0KwCeM8y3e0HOiv2xsrY+BvizTX6b
GMsAn1LxhBUhmaPVxz8F70m072m7Ie+J
=s9AE
-----END PGP SIGNATURE-----

--GJQzf4n/7sgn7z2y--
