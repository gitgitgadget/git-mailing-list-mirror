From: Michal Vyskocil <mvyskocil@suse.cz>
Subject: Re: RFC: reverse bisect
Date: Fri, 30 Sep 2011 10:29:14 +0200
Message-ID: <20110930082914.GD27152@zelva.suse.cz>
References: <20110929142027.GA4936@zelva.suse.cz>
 <4E849C5B.7050201@kdbg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UoPmpPX/dBe4BELn"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 10:29:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9YTP-0005ET-8E
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 10:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab1I3I3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 04:29:17 -0400
Received: from nat.scz.novell.com ([213.151.88.252]:54248 "EHLO zelva.site"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755278Ab1I3I3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 04:29:16 -0400
Received: by zelva.site (Postfix, from userid 10112)
	id 4957E42F3A0B; Fri, 30 Sep 2011 10:29:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E849C5B.7050201@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182470>


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 29, 2011 at 06:27:07PM +0200, Johannes Sixt wrote:
> Am 29.09.2011 16:20, schrieb Michal Vyskocil:
> > git bisect start --reverse HEAD~999 HEAD
>=20
> With the regular meaning of the start subcommand, the revs given are
> ordered: bad good good...
>=20
> With the reversed meaning, this would have to become: good bad bad...
>=20
> This would have to be mentioned clearly in the documentation.
>=20
> > git bisect good/bad/skip/run
>=20
> Last time this came up on the list I suggested to add the following
> commands:
>=20
>    git bisect regression  # a synonym for git bisect start
>    git bisect improvement # your --reverse

Good point! As you mentioned, the --switch already reverse the meanings
of arguments as you mentioned. Using a new command will be less
confusing for users.

Michal Vyskocil

--UoPmpPX/dBe4BELn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk6FfdoACgkQGwzgx2QvQgQjaACfXJAJ2P3kMWIkLVhQrEB7h2r8
m2IAn2Vp7h6qIJpTokshV2tRDv7wFRSS
=i3SJ
-----END PGP SIGNATURE-----

--UoPmpPX/dBe4BELn--
