From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Mon, 21 Nov 2005 03:24:28 +0100
Message-ID: <20051121022428.GB7902@kiste.smurf.noris.de>
References: <20051117230723.GD26122@nowhere.earth> <Pine.LNX.4.63.0511180026080.18775@wbgn013.biozentrum.uni-wuerzburg.de> <20051119140404.GD3393@nowhere.earth> <20051119141341.GE3393@nowhere.earth> <Pine.LNX.4.63.0511191612350.4895@wbgn013.biozentrum.uni-wuerzburg.de> <20051119170929.GF3393@nowhere.earth> <pan.2005.11.19.17.23.17.920228@smurf.noris.de> <Pine.LNX.4.63.0511200217200.11653@wbgn013.biozentrum.uni-wuerzburg.de> <20051120223249.GI3393@nowhere.earth> <Pine.LNX.4.63.0511210041370.24681@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 03:26:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee1NT-0006z7-4m
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 03:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVKUCZv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 21:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbVKUCZv
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 21:25:51 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:10408 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S932179AbVKUCZv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 21:25:51 -0500
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1Ee1M5-0005Xr-H6; Mon, 21 Nov 2005 03:24:55 +0100
Received: (nullmailer pid 24771 invoked by uid 501);
	Mon, 21 Nov 2005 02:24:28 -0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511210041370.24681@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12417>


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Johannes Schindelin:
> > > ORIG1 .. ORIG2 .. .. ORIG_HEAD
> > >                          |
> > >                          |   GIT1 .. GIT2 .. .. GIT_HEAD
> > >                          |   /                    /
> > >                          | /                     /
> > >                       UNIFYING_MERGE           /
> > >                                    \         /
> > >                                      \     /
> > >                                NEW_HEAD_FOR_ARCHEOLOGICAL_PURPOSES
> > >=20
> > Note: it's not only about research (ie. something that would be static
> > for browsing only), it's also about using the results of the research
> > in further developement.
>=20
> Then you could base your future development on=20
> NEW_HEAD_FOR_ARCHEOLOGICAL_PURPOSES.
>=20
If you need a new HEAD *anyway*, then re-basing your trees would
IMHO be a better solution.

ORIG1 .. ORIG2 .. .. ORIG_HEAD
                         |
                         |   GIT1 .. GIT2 .. .. GIT_HEAD
                         |  //       //           //   \
                         | //       //           //    TAG
                      NEWGIT1 .. GIT2 .. .. NEW_HEAD
                                                   \
                                                  NEW_TAG

Those // links might be real parent pointers, which allows you to keep=20
your old tags -- or not, which allows you to have a sane history. The
good part is that you can do this incrementally, so you won't need a
flag day.

I seriously doubt that all of this is worth the effort, given that you
can do the same thing with a graft line... and most people could care
less whether their histor starts at 2.6.11-whatever, 2.4, or 0.11.
(*Has* anybody imported the old tarballs into git, by the way?)

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
lately waking up i'm not sure where i've been
		-- Indigo Girls, "Language or the Kiss"

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDgS/c8+hUANcKr/kRAuy6AKCgEq0I/YtNQ8iXN5cevqcA1NZhNwCgmF3s
sjYFRmurA0HUFrT98mkWw/g=
=dyyc
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
