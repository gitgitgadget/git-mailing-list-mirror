From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-svn branch naming question
Date: Sun, 9 Dec 2007 00:52:48 +0100
Message-ID: <20071208235248.GK3199@genesis.frugalware.org>
References: <20071208010438.GE3199@genesis.frugalware.org> <20071208105901.GA2844@xp.machine.xx> <20071208141449.GH3199@genesis.frugalware.org> <20071208165657.GC2844@xp.machine.xx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fKov5AqTsvseSZ0Z"
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 09 00:53:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J19U8-0005v2-IL
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 00:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbXLHXwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 18:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752963AbXLHXwv
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 18:52:51 -0500
Received: from virgo.iok.hu ([193.202.89.103]:39356 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739AbXLHXwu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 18:52:50 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id F00651B2512;
	Sun,  9 Dec 2007 00:52:48 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 3480A4465C;
	Sun,  9 Dec 2007 00:51:42 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id A3FE111904C1; Sun,  9 Dec 2007 00:52:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071208165657.GC2844@xp.machine.xx>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67579>


--fKov5AqTsvseSZ0Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 08, 2007 at 05:56:57PM +0100, Peter Baumann <waste.manager@gmx.=
de> wrote:
>  On the other hand you could forget completly the remote part by specifyi=
ng
>=20
>   [svn-remote "svn"]
>         url =3D https://url/to/your/svn/repo
>         fetch =3D trunk:refs/heads/trunk
>         branches =3D branches/*:refs/heads/*
>         tags =3D tags/*:refs/heads/tags/*
>=20
> but I advice you to not do this. refs/remotes has a special meaning in gi=
t,
> e.g.  you can't commit directly to it (which makes sense, because it only
> tracks the state of the remote repo. On the other hand remote branches wo=
n't
> get cloned per default.)

yes, that's exactly what i want to do - in case the target is to convert
an svn repo to a git one (and i need git-svn since git-svnimport is to
be removed in 1.5.4)

thanks,
- VMiklos

--fKov5AqTsvseSZ0Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHWy5Qe81tAgORUJYRAuaVAJ9dQ8tCqfaXEals4OU2tkqU+TpAvgCdFB+w
w2GJ0wpSwY1aoGmL+WRo9A4=
=7WL+
-----END PGP SIGNATURE-----

--fKov5AqTsvseSZ0Z--
