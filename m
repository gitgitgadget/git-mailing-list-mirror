From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git svn and the post-receive hook
Date: Sat, 2 Aug 2008 20:03:19 +0200
Message-ID: <20080802180319.GZ32057@genesis.frugalware.org>
References: <489485BC.1020607@obry.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZukBEUNXiWwEFff2"
Cc: git list <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Sat Aug 02 20:04:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPLSp-0003mS-Dn
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 20:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357AbYHBSDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 14:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753202AbYHBSDW
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 14:03:22 -0400
Received: from virgo.iok.hu ([193.202.89.103]:48316 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752811AbYHBSDV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 14:03:21 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 25B051B250D;
	Sat,  2 Aug 2008 20:03:20 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 3A16B4465E;
	Sat,  2 Aug 2008 19:16:16 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7BF651770071; Sat,  2 Aug 2008 20:03:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <489485BC.1020607@obry.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91162>


--ZukBEUNXiWwEFff2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 02, 2008 at 06:05:16PM +0200, Pascal Obry <pascal@obry.net> wro=
te:
> At the moment it seems to me that the post-receive hook is not called whe=
n=20
> tracking a remove Subversion repository.

Sure. From the "post-receive" hook documentation:

"This hook is invoked by 'git-receive-pack' on the remote repository,
which happens when a 'git-push' is done on a local repository."

And git svn will never invoke git receive-pack.

> I think it would be nice to call the post-receive hook at the end of:
>=20
>    $ git svn rebase

What about a post-rebase hook, like there is a post-merge one?

> I have zero experience with Perl so I do not feel like hacking this mysel=
f.

git rebase is shell. ;-)

--ZukBEUNXiWwEFff2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiUoWcACgkQe81tAgORUJb0FQCgqiJHZCGnJVf1Af5vR8A2kON3
5C0AnRuiW3FBTGijwQTqAP8FYtDs9d98
=2jbr
-----END PGP SIGNATURE-----

--ZukBEUNXiWwEFff2--
