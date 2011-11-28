From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: two branches: keep one difference but  merge others forth and
 back
Date: Mon, 28 Nov 2011 16:25:36 +0100
Message-ID: <20111128152536.GB2386@beez.lab.cmartin.tk>
References: <jats5v$r7c$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Cc: git@vger.kernel.org
To: Gelonida N <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 16:26:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV368-0006M8-AN
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 16:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235Ab1K1P0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 10:26:19 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:52242 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291Ab1K1P0T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 10:26:19 -0500
Received: from beez.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 5348D461A5;
	Mon, 28 Nov 2011 16:25:36 +0100 (CET)
Received: (nullmailer pid 1543 invoked by uid 1000);
	Mon, 28 Nov 2011 15:25:36 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Gelonida N <gelonida@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <jats5v$r7c$1@dough.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186017>


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 27, 2011 at 06:31:42PM +0100, Gelonida N wrote:
> Hi,
>=20
>=20
> Is this possible.
>=20
>=20
> I'd like to have two branches.
>=20
> If possible I would be able to merge forth and back between both of them.
>=20
> However I would like, that certain differences will be kept between both
> branches.
>=20
> Is there any way to tell git to permanently ignoring certain commits
> from merging?

This goes against what a merge is.

>=20
>=20
> Example:
> ---------
>    Normally shell scripts would have a first line of
> '#!/bin/bash',
> but in a certain branch I would like that the first lines would be
>=20
> '#!/usr/local/bin/bash'
>=20
> All from then on however I'd like to be able to commit on both branches
> and to merge from the other branches (and always keep this difference)
>=20
> What I tried:
> -------------
> My first naive approach was:
> - create shell scripts in master,
> - create then a branch named 'my_shell'
> - modify first lines of shell scripts in this branch and commit
> - checkout master
> - merge my_shell to master with merge strategy 'ours'
>   git pull my_shell -s ours
> - now I changed something else in master
> - when I try to merge back to branch my_shell I will not only get
>   the most recent changes done in master, but I will also undo the
> changes in line 1 of my shell scripts.
>=20
> So it seems I am not doing things as one should.

If you tell git to merge, it expects that you want to take the changes
done in the other branch.

>=20
>=20
> Potential other strategies:
> ----------------------------
> - never commit anything on branch my_shell and just pull regularly
>   from master to keep it synced.
>=20
> - commit changes / bug fixes also on branch my_shell, but NEVER merge
> back to master. If a change grom my_shell is really needed on master,
> then just cherry-pick.
>=20
>=20
> Thanks in advance for suggestions how you would deal with such 'situation=
s'

You can amend the merge (or the next merge) commit so you undo that
change. Git should leave that line alone as long as you don't change
it.

Or you could have a branch where you make changes and two branches
where you change the hashbang. Merging from the main branch into the
specific branches won't touch the hashbang, as long as you don't touch
it.

   cmn

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJO06fwAAoJEHKRP1jG7ZzTplsH/ikb7wXQ+3+qWtozUGzwP8mF
hfLD8zWpU0eCZOXrQ5Rak7lgvEEXJnM2vnTcRKJNZeLu/Kmi12HkLrv5mz4SYjr9
ARmS/E6kRxNaKlf1r+M5SOcqY7DgKr6X9JTrBquFS+r/kyXGPCYvji7JkcJwc6Dm
mZBW/SitxLThxaqy2WhfwQb9QGYRn1DRx4wl+Pb53aSFZ80CpvkLNL9Pbf81mDkj
q3gMRgoAELCneyRB5oiwwY0HlLK+wPU+SF6Zzx4RFJye1flcPHOa5SvKLZnp60cV
3CL6hMv3SjFvYgSZDG9scWREpLb6HPexbQ3pXpBfS2S0p6PfzOgcrCLCYmA20HM=
=Il+3
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
