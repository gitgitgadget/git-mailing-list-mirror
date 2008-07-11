From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git cherry-pick before archive
Date: Fri, 11 Jul 2008 18:11:58 +0200
Message-ID: <20080711161158.GD10347@genesis.frugalware.org>
References: <6dbd4d000807110846m2921ddb9r88eb3986762b8f81@mail.gmail.com> <alpine.DEB.1.00.0807111649290.8950@racer> <6dbd4d000807110909n1ced22eeraef45af441c20cca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QOa9dl9wYIBIim/b"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Denis Bueno <dbueno@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 18:13:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHLEx-00046E-46
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 18:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbYGKQMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 12:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333AbYGKQMB
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 12:12:01 -0400
Received: from virgo.iok.hu ([193.202.89.103]:50170 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819AbYGKQMA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 12:12:00 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 322DA1B24FA;
	Fri, 11 Jul 2008 18:11:59 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 132764465E;
	Fri, 11 Jul 2008 17:37:25 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id D13EB177001C; Fri, 11 Jul 2008 18:11:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6dbd4d000807110909n1ced22eeraef45af441c20cca@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88137>


--QOa9dl9wYIBIim/b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2008 at 12:09:02PM -0400, Denis Bueno <dbueno@gmail.com> wr=
ote:
> On Fri, Jul 11, 2008 at 11:51, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > $ git cherry-pick -n <bla>
> > $ git archive --format=3Dtar --prefix=3Dpfx/ $(git write-tree) | gzip >=
 prj.tgz
> > $ git reset

I guess he wanted to write 'git reset --hard' here ;-)

>=20
> Thank you!  This is much better.  The only thing that could improve it
> is by some way to "un-cherry-pick" the applied change (so that after
> "git reset" there are no local modifications to the file(s) changed by
> cherry-picking <bla>).
>=20
> Is there an easy way to invert a patch to undo the change the original
> patch introduced?

git show <commit> | git apply -R?

--QOa9dl9wYIBIim/b
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh3hk4ACgkQe81tAgORUJYu/ACgmUFR7XRKxxFrhqjdZDJw5wiQ
07cAoJ97YE/OV7mxW7ItZVgZKBsg/m7w
=tu6b
-----END PGP SIGNATURE-----

--QOa9dl9wYIBIim/b--
