Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E8B61FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 19:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526AbcFTTuw (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 15:50:52 -0400
Received: from goldorak5.eric.deplagne.name ([213.246.56.18]:43602 "EHLO
	exim4.goldorak5.eric.deplagne.name" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752073AbcFTTuv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2016 15:50:51 -0400
Received: from [192.168.0.4] (helo=mail.eric.deplagne.name)
	by exim4.goldorak5.eric.deplagne.name with esmtp (Exim 4.72)
	(envelope-from <Eric@Deplagne.name>)
	id 1bF5Cd-0003lp-Na; Mon, 20 Jun 2016 21:49:47 +0200
Received: from deplagne by mail.eric.deplagne.name with local (Exim 4.69)
	(envelope-from <Eric@Deplagne.name>)
	id 1bF5Cd-0003lm-Mm; Mon, 20 Jun 2016 21:49:47 +0200
Date:	Mon, 20 Jun 2016 21:49:47 +0200
From:	Eric Deplagne <Eric@Deplagne.name>
To:	Jeff King <peff@peff.net>
Cc:	Norbert Kiesel <nkiesel@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: unable to pull from remote if commit date is in the future
Message-ID: <20160620194947.GE24553@mail.eric.deplagne.name>
References: <CAM+g_NswH8fd8aFPEHfSLYnZWptNU2GX=xTWpehzjTJfJM_GfQ@mail.gmail.com> <CAGZ79kZL-ZY_0hZx9uA-ObPvMiD+EWvJYQa+OfCeQe2RLOPECA@mail.gmail.com> <CAM+g_NtNAWpLkbErL5-BUyH_3X4rYGfZwO0o-Hfu8zyam8pw7Q@mail.gmail.com> <20160620193928.GA3631@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sXc4Kmr5FA7axrvy"
Content-Disposition: inline
In-Reply-To: <20160620193928.GA3631@sigill.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Jun 2016 15:39:28 -0400, Jeff King wrote:
> On Mon, Jun 20, 2016 at 12:05:07PM -0700, Norbert Kiesel wrote:
>=20
> > Hmm.  On closer inspection that commit 23c07cc that github shows with
> > date 2152-06-19 is already in my local branch.  I got confused because
> > locally it is shown with a different date: `git log -1 --format=3D'%ci'
> > 23c07cc` shows "2106-02-07 06:28:56 -40643156" which is invalid.
> >=20
> > My system is running Debian unstable 64bit.  Is git using the time
> > rendering methods from the C library (glibc 2.22-12)?
>=20
> No, git's time code is (mostly) internal routines. Can you show us the
> output of:
>=20
>     git cat-file commit 23c07cc | egrep '^author|committer'
>=20
> Note also that some interfaces (like "git log", and GitHub) will show
> the author date by default, which might be different than the committer
> date. The "-40643156" timezone definitely looks suspicious, though. I'm
> curious if it is bad handling in the time code, or if the commit has
> corrupt ident lines.
>=20
> -Peff

  2106 is the year of unsigned 32-bit unix time bug, would there be any rel=
ation ?

--=20
  Eric Deplagne

--sXc4Kmr5FA7axrvy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFXaEjbej7DisjVpq4RAuEkAJ4pdZ6TvDgZ97vETfcOO24eSzVHGQCfXZ4A
5c5yf43Qrz+nbBYsrf2Njhg=
=pyuE
-----END PGP SIGNATURE-----

--sXc4Kmr5FA7axrvy--
