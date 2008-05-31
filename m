From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Why does "git log --reverse -1" print the HEAD commit?
Date: Sat, 31 May 2008 16:24:08 +0200
Message-ID: <20080531142408.GL29404@genesis.frugalware.org>
References: <20080531141102.GA3035@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HTLCc13+3hfAZ6SL"
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sat May 31 16:25:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2S12-0000XY-LD
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 16:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbYEaOYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 10:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbYEaOYL
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 10:24:11 -0400
Received: from virgo.iok.hu ([193.202.89.103]:34304 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753245AbYEaOYK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 10:24:10 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 55F831B2511;
	Sat, 31 May 2008 16:24:09 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A89C344697;
	Sat, 31 May 2008 16:07:21 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C3D44177001C; Sat, 31 May 2008 16:24:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080531141102.GA3035@mithlond.arda.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83388>


--HTLCc13+3hfAZ6SL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2008 at 05:11:02PM +0300, Teemu Likonen <tlikonen@iki.fi> w=
rote:
> It feels wrong that "git log -1" and "git log --reverse -1" both print
> the same commit: HEAD. Why is that?
>=20
> Since "git log --reverse" starts from the bottom I'd have expected "-1"
> to print one commit from the bottom.

-1 limits the commit list to one element and then it prints that range
in reverse order, which is the same for a single commit.

--HTLCc13+3hfAZ6SL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhBX4gACgkQe81tAgORUJbXUwCdHAfn83hG9sArIE7pi4SOM4nE
LKsAoKD5cU8TXZVcrgOKwiPIFJOFMofO
=1xHg
-----END PGP SIGNATURE-----

--HTLCc13+3hfAZ6SL--
