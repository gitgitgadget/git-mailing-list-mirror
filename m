From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: quote in help code example
Date: Mon, 12 Oct 2009 21:40:16 +0200
Message-ID: <20091012194016.GS23777@genesis.frugalware.org>
References: <20091012102926.GA3937@debian.b2j>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 21:49:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxQtP-00047u-Nn
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 21:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757829AbZJLTky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 15:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757738AbZJLTkx
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 15:40:53 -0400
Received: from virgo.iok.hu ([212.40.97.103]:41316 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757669AbZJLTkx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 15:40:53 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id B3E04580B5;
	Mon, 12 Oct 2009 21:40:16 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id ADD7D44906;
	Mon, 12 Oct 2009 21:40:16 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B543311F0028; Mon, 12 Oct 2009 21:40:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20091012102926.GA3937@debian.b2j>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130058>


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2009 at 06:29:26PM +0800, bill lam <cbill.lam@gmail.com> wr=
ote:
> In git man, eg. git help filter-branch
> The code examples for command line or shell scripts inside .ft pairs
> use (smart?) quote instead of single quotes, like
>=20
>   .ft C
>    git filter-branch --tree-filter =B4rm filename=B4 HEAD
>    .ft
>=20
> Is this intentional or just some configuration problem during
> compiling.

Just a guess: do you have docbook-xsl >=3D1.73.0 and you did not set
ASCIIDOC_NO_ROFF?

Try rebuilding the documentation using 'make ASCIIDOC_NO_ROFF=3DYesPlease'.

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrThiAACgkQe81tAgORUJYmzACgnJUTanqGvW/2t++/gJbfFN1D
gY4Amwewg6rYIhxy+fhB7yn6BwGWgYYq
=mNnI
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
