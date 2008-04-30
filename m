From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH] Use perl instead of tac
Date: Wed, 30 Apr 2008 11:02:06 +0200
Message-ID: <20080430090206.GA21826@alea.gnuu.de>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com> <20080427064250.GA5455@sigill.intra.peff.net> <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com> <slrng1be8l.25r.joerg@alea.gnuu.de> <86k5iib0g9.fsf@blue.stonehenge.com> <slrng1bqhb.25r.joerg@alea.gnuu.de> <04EB077D-CB35-4253-A9EA-2085890C3639@silverinsanity.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 14:04:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrB3D-0004OX-GI
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 14:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758911AbYD3MDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 08:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758710AbYD3MDx
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 08:03:53 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:3093 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758389AbYD3MDx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 08:03:53 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 60344488037; Wed, 30 Apr 2008 14:03:50 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jr8CU-00053N-Ox; Wed, 30 Apr 2008 11:02:06 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jr8CU-0002kx-CQ; Wed, 30 Apr 2008 11:02:06 +0200
Content-Disposition: inline
In-Reply-To: <04EB077D-CB35-4253-A9EA-2085890C3639@silverinsanity.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80832>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Brian,

Brian Gernhardt schrieb am Mon 28. Apr, 15:13 (-0400):
> This loop-reverse-loop construct is _extremely_ ugly, and I'm having =20
> problems following it.  None of what this function is doing is =20
> immediately obvious.  It's a good candidate for a comment or two.

I write one.

> I also dislike the large lists this is carrying around in shell =20
> variables.  If I'm reading it correctly, the tag list could be replaced=
=20
> by invocations of "git describe --exact-match".

Yes. How to get all tags of a commit?

% git tag foo v1.5.5
% git describe --exact-match 9d831805195ba40b62f632acc6bb6e53d3
warning: tag 'v1.5.5' is really 'foo' here
v1.5.5

> Now that I think about it, the generation of marks could be done by a =20
> second loop over the list.  Notice what commits need to be marked in =20
> loop 1, then add the mark commands in loop 2.  Both of these loops would=
=20
> function in the same direction, removing the need for either tac or perl.

You are right.

Thanks for your comments.

Bye, J=F6rg.
--=20
Damit das M=F6gliche entsteht, mu=DF immer wieder das Unm=F6gliche versucht
werden.                                       (Hermann Hesse)

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIGDWOwe0mZwH1VIARAlakAJ9Q4UqAVY2VHXWGjaz6r2cvX/SN3ACgmPjN
oJXAt90n6raGzycJX/MGAbg=
=kEuZ
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
