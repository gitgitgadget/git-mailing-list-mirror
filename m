From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 1/7] Make is_git_command() usable outside builtin-help
Date: Mon, 28 Jul 2008 03:18:28 +0200
Message-ID: <20080728011828.GI32057@genesis.frugalware.org>
References: <cover.1217037178.git.vmiklos@frugalware.org> <f311372167c02868ccf5aa4dc03c97b7f956d855.1217037178.git.vmiklos@frugalware.org> <Pine.GSO.4.62.0807261301300.15728@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rNH9aVqBNQhZXx6Q"
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Mon Jul 28 03:19:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNHOg-0006eH-8G
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 03:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbYG1BSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 21:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbYG1BSb
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 21:18:31 -0400
Received: from virgo.iok.hu ([193.202.89.103]:54350 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711AbYG1BSa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 21:18:30 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 63A4D1B250C;
	Mon, 28 Jul 2008 03:18:29 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A565D4465E;
	Mon, 28 Jul 2008 02:34:38 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id F2BAA1190A0A; Mon, 28 Jul 2008 03:18:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.62.0807261301300.15728@harper.uchicago.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90384>


--rNH9aVqBNQhZXx6Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2008 at 01:12:36PM -0500, Jonathan Nieder <jrnieder@uchicag=
o.edu> wrote:
> On Sat, 26 Jul 2008, Miklos Vajna wrote:
>=20
> > +	if (!prefix)
> > +		prefix =3D "git-";
> > +       	prefix_len =3D strlen(prefix);
>=20
> The whitespace gave me a start: the diff markup moved the prefix_len
> line to the next tab stop, so at first glance it seems there are missing
> braces here.  But it is an illusion.  (I mention this so others might
> avoid wasting time worrying about it.)

In fact it was a whitespace problem: somehow I used spaces there instead
of a tab. I fixed it locally. (Will send an updated series soon.)

> I like the patch so far.  Thanks for the pleasant reading.

:-)

--rNH9aVqBNQhZXx6Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiNHmQACgkQe81tAgORUJYblwCeLHqPbhsUquO3q5FAq/aK/Hn5
QJwAn1cpTCj+LF/3Tre6PUkQ7orlM5p/
=A1Je
-----END PGP SIGNATURE-----

--rNH9aVqBNQhZXx6Q--
