From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-svn branch naming question
Date: Sun, 9 Dec 2007 03:25:06 +0100
Message-ID: <20071209022505.GO3199@genesis.frugalware.org>
References: <20071208010438.GE3199@genesis.frugalware.org> <20071208105901.GA2844@xp.machine.xx> <20071208141449.GH3199@genesis.frugalware.org> <20071208165657.GC2844@xp.machine.xx> <20071208235248.GK3199@genesis.frugalware.org> <20071209020510.GM3199@genesis.frugalware.org> <20071209021336.GA8327@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CQDko/0aYvuiEzgn"
Cc: Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 09 03:25:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1BrH-00055q-4N
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 03:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbXLICZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 21:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753297AbXLICZJ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 21:25:09 -0500
Received: from virgo.iok.hu ([193.202.89.103]:39532 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255AbXLICZI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 21:25:08 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id BD1D91B2511;
	Sun,  9 Dec 2007 03:25:06 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C90184465C;
	Sun,  9 Dec 2007 03:23:59 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5F34D11904C1; Sun,  9 Dec 2007 03:25:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071209021336.GA8327@atjola.homenet>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67587>


--CQDko/0aYvuiEzgn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2007 at 03:13:36AM +0100, Bj=F6rn Steinbrink <B.Steinbrink@=
gmx.de> wrote:
> >         url =3D svn+ssh://vmiklos@svn.gnome.org/svn/ooo-build
> >         fetch =3D trunk:refs/master
> >         branches =3D branches/*:refs/*
> >         tags =3D tags/*:refs/tags/*
>=20
> Just a guess, but this seems pretty headless ;-)

oh, right. here is my fixed config:

[svn-remote "svn"]
        url =3D svn+ssh://vmiklos@svn.gnome.org/svn/ooo-build
        fetch =3D trunk:refs/heads/master
        branches =3D branches/*:refs/heads/*
        tags =3D tags/*:refs/tags/*

git svn fetch still does not seem to do anything :S

thanks,
- VMiklos

--CQDko/0aYvuiEzgn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHW1IBe81tAgORUJYRAsTzAJwOO9iCG7C/v7H0IeLWIaO51XtwVQCgq0IT
tnooQHP2m49i6Ph2h4Vd2ZI=
=gvAZ
-----END PGP SIGNATURE-----

--CQDko/0aYvuiEzgn--
