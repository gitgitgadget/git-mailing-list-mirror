From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] git commit --branch
Date: Mon, 29 May 2006 23:37:04 +0200
Message-ID: <20060529213704.GG14325@admingilde.org>
References: <20060529202851.GE14325@admingilde.org> <Pine.LNX.4.63.0605292310280.17412@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 23:38:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkpRU-0008NL-4R
	for gcvg-git@gmane.org; Mon, 29 May 2006 23:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWE2Vh0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 17:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWE2VhK
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 17:37:10 -0400
Received: from admingilde.org ([213.95.32.146]:13519 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1751365AbWE2VhF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 17:37:05 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FkpQ8-0000LL-Hz; Mon, 29 May 2006 23:37:04 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0605292310280.17412@wbgn013.biozentrum.uni-wuerzburg.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20978>


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 29, 2006 at 11:14:32PM +0200, Johannes Schindelin wrote:
> Doesn't
>=20
> $ git-update-index $(git-ls-files --modified)
> $ git-checkout -b tempBranch
> $ git-commit -m "to test"
>=20
> work? It also avoids totally bogus parents (if I read your patch=20
> correctly, you take the current HEAD as the true parent, but record the=
=20
> current HEAD of the other branch as parent nevertheless).

I'm doing two commits, one to HEAD and one to the other branch.
It is more like:

	git commit
	git checkout otherbranch
	git rebase --onto otherbranch master^ master   <-- first
	git checkout master
	git merge msg master otherbranch               <-- second

Now your current HEAD is still a merge of your topic branches,
and you commited your changes to one clean topic branch.

--=20
Martin Waitz

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEe2mAj/Eaxd/oD7IRAuvFAJ0b5BzXZuq27vhKNxc5iDrRmuVFGgCdFh08
VhkqGrfkeEniE/1+Tf4ko7g=
=BaLm
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
