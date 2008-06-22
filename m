From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: "git-pull --no-commit" should imply --no-ff...?
Date: Sun, 22 Jun 2008 15:49:46 +0200
Message-ID: <20080622134946.GL29404@genesis.frugalware.org>
References: <tkrat.5aa5af8e9968819c@s5r6.in-berlin.de> <20080622133606.GA21828@endor.mknod.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KVMjFyEluGnEcJ9s"
To: Stefan Richter <stefanr@s5r6.in-berlin.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 15:50:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAPxu-0003rf-HS
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 15:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbYFVNts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 09:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbYFVNts
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 09:49:48 -0400
Received: from virgo.iok.hu ([193.202.89.103]:47264 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010AbYFVNts (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 09:49:48 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C06D11B24F0;
	Sun, 22 Jun 2008 15:49:46 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5B25E44668;
	Sun, 22 Jun 2008 15:26:00 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 724C11190AD9; Sun, 22 Jun 2008 15:49:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080622133606.GA21828@endor.mknod.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85771>


--KVMjFyEluGnEcJ9s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2008 at 08:36:06AM -0500, Graham Wilson <graham@mknod.org> =
wrote:
> On Sat, Jun 21, 2008 at 04:08:51PM +0200, Stefan Richter wrote:
> > trying "git pull --no-commit . foo" for the first time, I was confused
> > that --no-commit was a no-op when the pull resulted in a fast-forward.
> > I.e. HEAD advanced the whole chain of commits to foo.  I expected it to
> > apply the diff of HEAD..foo but not commit them.
>=20
> --no-commit to me seems to mean don't commit a merge commit. Maybe what
> you want is something like:
>=20
>  git-diff HEAD foo | git-apply

Or git merge --no-commit --squash?

--KVMjFyEluGnEcJ9s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkheWHoACgkQe81tAgORUJZExgCfU30E1jTMp+Yky5X7QTO3f2qY
S7sAn0m0CLuwKpQK9veAZPxCeVeQZO5b
=0Q5h
-----END PGP SIGNATURE-----

--KVMjFyEluGnEcJ9s--
