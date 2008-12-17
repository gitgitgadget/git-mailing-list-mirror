From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Documentation: fix description for enabling hooks
Date: Wed, 17 Dec 2008 15:36:27 +0100
Message-ID: <20081217143627.GB5691@genesis.frugalware.org>
References: <200812170359.24109.markus.heidelberg@web.de> <20081217041312.GZ5691@genesis.frugalware.org> <4948ADE8.2050804@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MljkYTiQARTYtn+v"
Cc: Markus Heidelberg <markus.heidelberg@web.de>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Dec 17 15:38:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCxX1-0008Ur-87
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 15:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbYLQOg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 09:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbYLQOg3
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 09:36:29 -0500
Received: from virgo.iok.hu ([212.40.97.103]:52879 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473AbYLQOg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 09:36:29 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 012FA5809F;
	Wed, 17 Dec 2008 15:36:28 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B561D4465E;
	Wed, 17 Dec 2008 15:36:27 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C600311B862F; Wed, 17 Dec 2008 15:36:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4948ADE8.2050804@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103353>


--MljkYTiQARTYtn+v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2008 at 08:44:40AM +0100, Johannes Sixt <j.sixt@viscovery.n=
et> wrote:
> > This is true, but having the executable bit is necessary as well. I
> > think it would be better to just append this requirement instead of
> > replacing the old one with this.
>=20
> Markus's proposed new wording is correct because the .sample hooks *are*
> already executable.

I thought about the following situation: The user reads the
documentation while working in an older repo (initialized a few versions
ago). S/he sees that the .sample suffix is already missing, so s/he
assumes that the hook is already active. Which is not true, because the
+x bit is missing.

--MljkYTiQARTYtn+v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklJDmsACgkQe81tAgORUJaknQCggy/IvfOt8qyIMUSvkc0cBKdM
F5UAn1X/uoiTxb/HmCoCQ8FYj8kfQ0en
=v0go
-----END PGP SIGNATURE-----

--MljkYTiQARTYtn+v--
