From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Working with Git and CVS in a team.
Date: Fri, 13 Jun 2008 16:50:10 +0200
Message-ID: <20080613145010.GU29404@genesis.frugalware.org>
References: <200806131633.34980.mirko.stocker@hsr.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tIJ0yshv4NgnvLR0"
Cc: Git Mailing List <git@vger.kernel.org>
To: Mirko Stocker <mirko.stocker@hsr.ch>
X-From: git-owner@vger.kernel.org Fri Jun 13 16:51:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7AcP-0000l6-Vq
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 16:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555AbYFMOuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 10:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755240AbYFMOuP
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 10:50:15 -0400
Received: from virgo.iok.hu ([193.202.89.103]:43975 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755215AbYFMOuO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 10:50:14 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 2762B1B2507;
	Fri, 13 Jun 2008 16:50:12 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 64D1A4469F;
	Fri, 13 Jun 2008 16:31:27 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7A66C1770022; Fri, 13 Jun 2008 16:50:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200806131633.34980.mirko.stocker@hsr.ch>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84887>


--tIJ0yshv4NgnvLR0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2008 at 04:33:34PM +0200, Mirko Stocker <mirko.stocker@hsr.=
ch> wrote:
> 3) Then we have the role of a "Merge-Dude" who pulls the changes from
>    /git-proj and uses 'git merge origin/origin' to update his master.
>    If there are any conflicts, he resolves them and pushes everything
>    back to the master at /git-proj.
>=20
> 4) The users can just push and pull from /git-proj.
>=20
> From time to time, we can use 'git diff origin/origin' to get a patch
> with all the changes we made and have to send upstream.
>=20
> What do you guys think, is this approach feasible?
>=20
> What I don't like is how we have to make the upstream patch(es). Is
> there an easy way we can get multiple patches, lets say for each
> commit we made? Or is it easier to make a lots of branches and to
> then create a patch from the diff between the branch and origin/origin?

Don't you mean origin/master?

In general, if you don't merge your changes but you rebase on top of the
new upstream head, then you can use 'git format-patch origin/master..'
to create patches for each commit.

It'll include the commit message and each commit will be written out as
a separate file.

--tIJ0yshv4NgnvLR0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhSiSIACgkQe81tAgORUJZtiwCeJq7EfR82hBuMl6gOEO78AOmD
ip0Anjsttw16P477XcT99r7piKlmaa/n
=kydm
-----END PGP SIGNATURE-----

--tIJ0yshv4NgnvLR0--
