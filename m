From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH (1b)] merge-recursive.c: Add more generic
	merge_recursive_generic()
Date: Tue, 12 Aug 2008 23:44:10 +0200
Message-ID: <20080812214410.GG18960@genesis.frugalware.org>
References: <1218559514-16890-1-git-send-email-vmiklos@frugalware.org> <1218572040-23362-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9u+pkcMrQJw6us1"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Aug 12 23:45:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT1g2-0000bR-21
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 23:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbYHLVoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 17:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbYHLVoM
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 17:44:12 -0400
Received: from virgo.iok.hu ([193.202.89.103]:36979 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbYHLVoL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 17:44:11 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 464721B251D;
	Tue, 12 Aug 2008 23:44:10 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B70094465E;
	Tue, 12 Aug 2008 22:51:38 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 299261190002; Tue, 12 Aug 2008 23:44:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1218572040-23362-1-git-send-email-s-beyer@gmx.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92145>


--M9u+pkcMrQJw6us1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2008 at 10:13:59PM +0200, Stephan Beyer <s-beyer@gmx.net> w=
rote:
> merge_recursive_generic() takes, in comparison to to merge_recursive(),
> no commit ("struct commit *") arguments but SHA ids ("unsigned char *"),
> and no commit list of bases but an array of refs ("const char **").
>=20
> This makes it more generic in the case that it can also take the SHA
> of a tree to merge trees without commits, for the bases, the head
> and the remote.
>=20
> merge_recursive_generic() also handles locking and updating of the
> index, which is a common use case of merge_recursive().

Then what about adding an extra parameter to merge_recursive_generic()
so that merge_recursive_setup() could be a static function?

Or is there any reason to keep them separated?

Thanks.

--M9u+pkcMrQJw6us1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiiBCoACgkQe81tAgORUJY6DgCfXrY/JwSoWp2Y8nV10X2y+QKo
wyEAn2To+LkoRXB2+JwIrJJn3mRx6fYp
=iJU6
-----END PGP SIGNATURE-----

--M9u+pkcMrQJw6us1--
