From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Add --only-merges flag to display only merge commits.
Date: Wed, 9 Apr 2008 16:51:08 +0200
Message-ID: <20080409145108.GY11574@genesis.frugalware.org>
References: <20080408203648.GS11574@genesis.frugalware.org> <alpine.LSU.1.00.0804091605460.10660@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wQkw7DhpL9hyPo7K"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 09 16:52:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjbeX-0005Pz-0u
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 16:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbYDIOvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 10:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbYDIOvN
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 10:51:13 -0400
Received: from virgo.iok.hu ([193.202.89.103]:50972 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890AbYDIOvM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 10:51:12 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id DF0891B250A;
	Wed,  9 Apr 2008 16:51:10 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id CB44144659;
	Wed,  9 Apr 2008 16:47:49 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 1E9A81190A4E; Wed,  9 Apr 2008 16:51:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0804091605460.10660@wbgn129.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79111>


--wQkw7DhpL9hyPo7K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2008 at 04:06:57PM +0200, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> > I just wanted to see the list of merges since the last tag in a repo
> > where we have 1000+ commits and about 20 merges and found that there is
> > no easy way to do so.
>=20
> I usually did something like this:
>=20
> git log -1 $(git rev-list --parents | sed -n "s/ .* .*//p")

If you mean:

git log -1 $(git rev-list --parents HEAD | sed -n "s/ .* .*//p")

then it'll show only the first merge, --only-merges shows each merge.
(While of course you can still use -1 or tag.. or so.)

--wQkw7DhpL9hyPo7K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkf819wACgkQe81tAgORUJY7PwCZASdxg5Bz6Z8O5wzXPGE7A0pd
5WIAnjPiciXqv5ts77ZHiVAXthkIEZcT
=jIwR
-----END PGP SIGNATURE-----

--wQkw7DhpL9hyPo7K--
