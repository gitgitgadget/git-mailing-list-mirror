From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Quote ' as \(aq in manpages
Date: Wed, 21 Oct 2009 12:38:43 +0200
Message-ID: <20091021103843.GO6115@genesis.frugalware.org>
References: <200910151402.56295.trast@student.ethz.ch>
 <ab31eb03b25272341b91e1f1132dab9d8a49e5b6.1256113282.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cKDw3XFoqocuprIa"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Oct 21 12:39:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0YbH-00035N-Oq
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 12:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbZJUKil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 06:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753209AbZJUKil
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 06:38:41 -0400
Received: from virgo.iok.hu ([212.40.97.103]:33361 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752868AbZJUKik (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 06:38:40 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C15C158099;
	Wed, 21 Oct 2009 12:38:43 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 9E46244906;
	Wed, 21 Oct 2009 12:38:43 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 99F3211F002B; Wed, 21 Oct 2009 12:38:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ab31eb03b25272341b91e1f1132dab9d8a49e5b6.1256113282.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130903>


--cKDw3XFoqocuprIa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2009 at 10:24:42AM +0200, Thomas Rast <trast@student.ethz.c=
h> wrote:
> The docbook/xmlto toolchain insists on quoting ' as \'.  This does
> achieve the quoting goal, but modern 'man' implementations turn the
> apostrophe into a unicode "proper" apostrophe (given the right
> circumstances), breaking code examples in many of our manpages.
>=20
> Quote them as \(aq instead, which is an "apostrophe quote" as per the
> groff_char manpage.
>=20
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>=20
> I've had this around since my last rant, and it actually gives good
> results with both setups I can test on, which are:
>=20
> - asciidoc 8.4.5, docbook-xsl 1.75.2, xmlto 0.0.18
> - asciidoc 8.2.7, docbook-xsl 1.73.2, xmlto 0.0.20

Tested-by: Miklos Vajna <vmiklos@frugalware.org>

- asciidoc 8.3.5, docbook-xsl 1.74.0, xmlto 0.0.20

--cKDw3XFoqocuprIa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkre5LMACgkQe81tAgORUJa2qQCghEcPSsaSOB4Bk6cVHzhCVv5f
YVgAoKKTeVhC/QdhDBFnaXnRC0AQrHrn
=bdeb
-----END PGP SIGNATURE-----

--cKDw3XFoqocuprIa--
