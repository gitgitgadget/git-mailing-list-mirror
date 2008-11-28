From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Removing part of the history
Date: Fri, 28 Nov 2008 22:34:54 +0100
Message-ID: <20081128213454.GE19355@genesis.frugalware.org>
References: <49306150.6010701@datacom.ind.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Cc: git@vger.kernel.org
To: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
X-From: git-owner@vger.kernel.org Fri Nov 28 22:36:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6B0Z-0006fy-Rv
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 22:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbYK1Ve6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 16:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbYK1Ve6
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 16:34:58 -0500
Received: from virgo.iok.hu ([212.40.97.103]:35401 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752177AbYK1Ve5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 16:34:57 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 9E6025809A;
	Fri, 28 Nov 2008 22:34:55 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 858CB4465E;
	Fri, 28 Nov 2008 22:34:55 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 09B4411901A1; Fri, 28 Nov 2008 22:34:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49306150.6010701@datacom.ind.br>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101886>


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2008 at 07:23:28PM -0200, Samuel Lucas Vaz de Mello <samuel=
lucas@datacom.ind.br> wrote:
> There is any way to get rid of the (broken) cvs-old tree?
>=20
> I've tried to rebase, but the commits from A' and A are different, it
> tries to reapply all history in CVS.

Have you tried git rebase --onto?

> I've tried to checkout a point before our changes start (B') and then,
> using a script, cherry-pick all commits up to HEAD that are not in
> cvs-old branch. This approach didn't handled well merges between our
> branches (K-L-M and X-Y).

git rebase --preserve-merges is probably what you are searching for.

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkwY/4ACgkQe81tAgORUJadjgCgqOgGWdHVriVlLBgRAv/MtItu
lQgAnj0AVDRkHVycpToUd0qy+qgKQx3S
=/utv
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
