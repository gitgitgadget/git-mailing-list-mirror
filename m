From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git working tree status
Date: Sun, 26 Oct 2008 23:26:08 +0100
Message-ID: <20081026222608.GK2273@genesis.frugalware.org>
References: <73f525b90810261454wb902edfk3a696c06ef2148d1@mail.gmail.com> <20081026222335.GJ2273@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
Cc: git@vger.kernel.org
To: Mike Clarke <clarkema@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 23:27:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuE51-0001fI-3o
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 23:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbYJZW0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 18:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbYJZW0K
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 18:26:10 -0400
Received: from virgo.iok.hu ([193.202.89.103]:42746 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586AbYJZW0J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 18:26:09 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 55F61580AB;
	Sun, 26 Oct 2008 23:26:08 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 447A54465E;
	Sun, 26 Oct 2008 23:26:08 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2C13611901A1; Sun, 26 Oct 2008 23:26:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081026222335.GJ2273@genesis.frugalware.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99192>


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2008 at 11:23:35PM +0100, Miklos Vajna <vmiklos@frugalware.=
org> wrote:
> > c) 'dirty' in some way -- new files, uncommitted changes, etc.
>=20
> git update-index -q --refresh
> test -z "$(git diff-index --name-only HEAD --)" && echo "dirty"

I wanted to write '|| echo "dirty"', sorry.

--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkE7oAACgkQe81tAgORUJZKjQCfUMn05ATRVgF0j8CzrWl41y9y
Y78AoJuMyqL6xn0unY7djzlFSHusBFMK
=CSpy
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
