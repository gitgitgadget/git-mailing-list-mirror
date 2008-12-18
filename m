From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Add git-edit-index.perl
Date: Thu, 18 Dec 2008 17:36:54 +0100
Message-ID: <20081218163654.GR5691@genesis.frugalware.org>
References: <20081217204749.GA18261@janet.wally> <20081218043734.GD20749@coredump.intra.peff.net> <alpine.DEB.1.00.0812181446430.6952@intel-tinevez-2-302> <20081218140411.GB6706@coredump.intra.peff.net> <alpine.DEB.1.00.0812181723340.6952@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aNVYTE9V2LY2iLDz"
Cc: Jeff King <peff@peff.net>, Neil Roberts <bpeeluk@yahoo.co.uk>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 18 17:38:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDLt8-0001W4-O7
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 17:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbYLRQg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 11:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbYLRQg5
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 11:36:57 -0500
Received: from virgo.iok.hu ([212.40.97.103]:38082 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbYLRQg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 11:36:56 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A78E058095;
	Thu, 18 Dec 2008 17:36:54 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 2476B4465E;
	Thu, 18 Dec 2008 17:36:54 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5157E11B862F; Thu, 18 Dec 2008 17:36:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0812181723340.6952@intel-tinevez-2-302>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103469>


--aNVYTE9V2LY2iLDz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2008 at 05:24:00PM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> Hi,
>=20
> On Thu, 18 Dec 2008, Jeff King wrote:
>=20
> > It _would_ be a nicer workflow to say "I don't want these changes yet"=
=20
> > and selectively put them elsewhere, test what's in the working tree,=20
> > commit, and then grab some more changes from your stash. But we don't=
=20
> > have interactive stashing and unstashing yet, which would be required=
=20
> > for that.
>=20
> git stash -i... Yes, I'd like that!

Or git checkout -i?

For the cases when you did two changes in a file, you realize one of
them is not yet necessary, but you don't want to stage/commit the other
change yet.

--aNVYTE9V2LY2iLDz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklKfCYACgkQe81tAgORUJZgBQCeMBA06H3W1BqRl3wC9Gzi+OoW
168An1xQqUksEEZ4apKtCRrFHcl+OGfR
=T1yP
-----END PGP SIGNATURE-----

--aNVYTE9V2LY2iLDz--
