From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: 'next' will be rewound shortly
Date: Fri, 27 Jun 2008 21:28:19 +0200
Message-ID: <20080627192819.GC2058@genesis.frugalware.org>
References: <7vmylixr6h.fsf@gitster.siamese.dyndns.org> <7vbq1xx4y8.fsf@gitster.siamese.dyndns.org> <7vzlphvl69.fsf_-_@gitster.siamese.dyndns.org> <20080627161220.GB6201@leksak.fem-net> <20080627163411.GA2058@genesis.frugalware.org> <20080627171948.GC6201@leksak.fem-net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 27 21:29:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCJdI-0006u1-NN
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 21:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757504AbYF0T2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 15:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755354AbYF0T2X
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 15:28:23 -0400
Received: from virgo.iok.hu ([193.202.89.103]:36690 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757321AbYF0T2W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 15:28:22 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id AAB911B250E;
	Fri, 27 Jun 2008 21:28:21 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id E55B744697;
	Fri, 27 Jun 2008 21:01:35 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3CD081778012; Fri, 27 Jun 2008 21:28:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080627171948.GC6201@leksak.fem-net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86626>


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2008 at 07:19:48PM +0200, Stephan Beyer <s-beyer@gmx.net> w=
rote:
> -m <msg>::
> 	The commit message to be used for the merge commit (in case
> 	it is created). The `git-fmt-merge-msg` script can be used
> 	to give a good default for automated `git-merge` invocations.
>=20
> So it is not mentioned that a standard message is appended, and thus the
> original behavior is somehow "buggy" :)

Ah, OK. Then the code and the documentation differs and that's a bug,
sure.

=46rom git-merge.sh:

# All the rest are the commits being merged; prepare
# the standard merge summary message to be appended to
# the given message.

I did builtin-merge based on git-merge.sh, not the manpage. ;-)

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhlP1MACgkQe81tAgORUJadnACfcq+L5iiZao8Bq1ivZXbL4SYl
MmAAoKqVYbKWNZ+DrXVx1Tkx5tiPCdRb
=Zyi5
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--
