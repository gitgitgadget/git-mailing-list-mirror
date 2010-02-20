From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [BUG] girocco + git-svn: trunk is not propagated to master
Date: Sun, 21 Feb 2010 00:42:00 +0100
Message-ID: <20100220234200.GS12429@genesis.frugalware.org>
References: <20100219132206.GA13734@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQdXoA6oJ4Q9/zKe"
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Sun Feb 21 01:34:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Niyxf-0007KG-Vl
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 00:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756928Ab0BTXmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 18:42:07 -0500
Received: from virgo.iok.hu ([212.40.97.103]:54919 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756880Ab0BTXmF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 18:42:05 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id F177458096;
	Sun, 21 Feb 2010 00:42:00 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C812842F09;
	Sun, 21 Feb 2010 00:42:00 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 86A5D1240003; Sun, 21 Feb 2010 00:42:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100219132206.GA13734@tugrik.mns.mnsspb.ru>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140575>


--uQdXoA6oJ4Q9/zKe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 19, 2010 at 04:22:07PM +0300, Kirill Smelkov <kirr@mns.spb.ru> =
wrote:
> ---- taskd/clone.sh ----
> svn://*)
>     GIT_DIR=3D. git svn fetch
>     # Neat Trick suggested by Miklos Vajna
>     GIT_DIR=3D. git config remote.origin.url .
>     GIT_DIR=3D. git config remote.origin.fetch +refs/remotes/heads/*:refs=
/heads/*
>     GIT_DIR=3D. git config remote.origin.fetch +refs/remotes/trunk:refs/h=
eads/master
>     GIT_DIR=3D. git config remote.origin.fetch +refs/remotes/tags/*:refs/=
tags/*
>     GIT_DIR=3D. git fetch

Here is the original blog post:

http://vmiklos.hu/blog/svn-ggit-conversion-using-git-svn

> ---- jobd/update.sh ----
> svn://*)
>         GIT_DIR=3D. bang git svn fetch
>         GIT_DIR=3D. bang git fetch
>=20
>=20
> But it seems it does not work. First I see there is a need for quoting,
> so e.g.=20
>=20
> -   GIT_DIR=3D. git config remote.origin.fetch +refs/remotes/heads/*:refs=
/heads/*
> +   GIT_DIR=3D. git config remote.origin.fetch '+refs/remotes/heads/*:ref=
s/heads/*'
>=20
> but I'm not sure it will fix the problem.

When I tried this technique in ooo-build, I did not need quoting. Though
it won't hurt, sure.

> Can we do something about it please?

Did you get any error message?

--uQdXoA6oJ4Q9/zKe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuAc0gACgkQe81tAgORUJYPJwCeNXmSd8ojH58jjSPPRTxE8AqX
XDMAniwtWpImRYBhsyOuL7yxCKmBp9s2
=8kom
-----END PGP SIGNATURE-----

--uQdXoA6oJ4Q9/zKe--
