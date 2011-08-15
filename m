From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Core dump on commit
Date: Mon, 15 Aug 2011 18:11:38 +0200
Message-ID: <1313424698.12213.1.camel@centaur.lab.cmartin.tk>
References: <loom.20110815T162144-798@post.gmane.org>
	 <CACsJy8AL5D938HA-sQkFkn_d9xuT2Vw8BKfD-h+V=iEkNrS1eA@mail.gmail.com>
	 <loom.20110815T172423-956@post.gmane.org>
	 <CACsJy8BBvgJauL4a9MxWAXGN-_qiAKprt15hizyBp0O9knwKrg@mail.gmail.com>
	 <loom.20110815T180732-236@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-KqmrcgVAKy+/UQy4nCsg"
Cc: git@vger.kernel.org
To: Marko Vukovic <amasniko@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 18:11:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QszlW-0004Qu-WF
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 18:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337Ab1HOQLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 12:11:45 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:44045 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634Ab1HOQLo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 12:11:44 -0400
Received: from [192.168.1.18] (brln-4db9ee8e.pool.mediaWays.net [77.185.238.142])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 932C646217;
	Mon, 15 Aug 2011 18:11:34 +0200 (CEST)
In-Reply-To: <loom.20110815T180732-236@post.gmane.org>
X-Mailer: Evolution 2.32.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179380>


--=-KqmrcgVAKy+/UQy4nCsg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-08-15 at 16:09 +0000, Marko Vukovic wrote:
> Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:
>=20
> > I should have written "git reset --soft 1b9a976133", which resets HEAD
> > ref back to (assuming) good commit. See [1] for more information. I
> > think for some reason, eGit put a tag object to HEAD, while it should
> > be a commit object. By resetting it back to the commit that the tag
> > points to, you may be able to commit again.
> >=20
> > No history would be lost. Also if you use --soft, index should be
> > untouched. As always, back up your repository (copy the whole
> > directory, including .git) before doing anything.
> >=20
> > [1] http://www.kernel.org/pub/software/scm/git/docs/git-reset.html
>=20
> Thank you very much, I was able to commit after the reset.
>=20
> I shall remember never to use eGit for tagging in the future!

A (probably) more useful way to deal with it would be to report a bug to
EGIT so they know about it and can fix it.

Cheers,
   cmn


--=-KqmrcgVAKy+/UQy4nCsg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOSUU1AAoJEHKRP1jG7ZzTjSAH/A7P8IEjt8zI0HZ3n/T681Cl
hjb7Ua96fEv6NBcYrqWnlXhdOd7gSOIaj8x/tXhNRLX6zchoTViTx9CiTlGnt69w
Pzktw57N64HFLf4M0ykXE7nmd4TH9MAv2WIF3biLaiNJDZL1PvpDoJcSTsxW1fIm
4e0R/l41lFpon0pObrPwsz91I3mkmwbrE9KcG+dDBq69G+mFhX66wPQ7pT1OqZqv
aM0xMEUNqu/3CZd5Yr2Q5Aj+H0jQ9FxLVF5b2Fnna7TMY5NVQEhey2TtqR1ZxwD6
z92iDgiFX9UdGLyfoLAKG7VCa3tIL2rF/nu9BYHki1dmOztidmmHf0S/caVu7Rk=
=+xbz
-----END PGP SIGNATURE-----

--=-KqmrcgVAKy+/UQy4nCsg--
