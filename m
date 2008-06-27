From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 15:49:08 +0200
Message-ID: <20080627134908.GA428@genesis.frugalware.org>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com> <alpine.DEB.1.00.0806271408290.9925@racer>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Cc: Robert Anderson <rwa000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 27 15:50:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCEL6-0006dA-RQ
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 15:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756738AbYF0NtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 09:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756141AbYF0NtL
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 09:49:11 -0400
Received: from virgo.iok.hu ([193.202.89.103]:36134 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755899AbYF0NtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 09:49:09 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 466C21B250E;
	Fri, 27 Jun 2008 15:49:08 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A738144668;
	Fri, 27 Jun 2008 15:22:32 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 20D2E1778012; Fri, 27 Jun 2008 15:49:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806271408290.9925@racer>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86562>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2008 at 02:33:33PM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> Having said that, I played with the idea of a "git stash -i", which would=
=20
> allow you to select the changes to stash away.  (And by extension, "git=
=20
> stash -e" using the "git add -e" command.)

If we are at it, git checkout -i is also something which may be useful,
like:

1) Do two unrelated changes in a file.

2) You realize one of them is unnecessary.

Currently what you can do is something like:

1) You stage the first hunk using git add -p

2) git commit

3) git checkout file

But this forces you to commit early, and to commit --amend later. It
would be nice to be able to completely drop a hunk without first
commiting.

(Feel free to point out if this is something bad, I just remember from
the past that darcs revert - which is like git checkout - had such an
interactive mode.)

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhk79MACgkQe81tAgORUJZw6QCgoJe5uGdkR+H5uy197XqJ2qyL
pUwAn1+2P9EV9I8ZNqGyq4EDVX0fjH87
=uPuw
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
