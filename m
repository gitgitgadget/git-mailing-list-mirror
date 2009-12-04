From: Nathaniel W Filardo <nwf@cs.jhu.edu>
Subject: Re: Endianness bug in git-svn or called component?
Date: Fri, 4 Dec 2009 15:29:28 -0500
Message-ID: <20091204202928.GW17192@gradx.cs.jhu.edu>
References: <20091204174458.GV17192@gradx.cs.jhu.edu> <m23a3qa40n.fsf@igel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nc+Vvx0JXuqp7Zy0"
Cc: Nathaniel W Filardo <nwf@cs.jhu.edu>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Dec 04 21:30:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGenD-0004zF-Qo
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 21:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757221AbZLDUaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 15:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757214AbZLDUaH
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 15:30:07 -0500
Received: from blaze.cs.jhu.edu ([128.220.13.50]:54530 "EHLO blaze.cs.jhu.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757127AbZLDUaG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 15:30:06 -0500
Received: from gradx.cs.jhu.edu (gradx.cs.jhu.edu [128.220.13.52])
	by blaze.cs.jhu.edu (8.14.3/8.14.3) with ESMTP id nB4KTT7v007797
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 4 Dec 2009 15:29:29 -0500 (EST)
Received: from gradx.cs.jhu.edu (localhost.localdomain [127.0.0.1])
	by gradx.cs.jhu.edu (8.14.2/8.13.1) with ESMTP id nB4KTSOu006002;
	Fri, 4 Dec 2009 15:29:28 -0500
Received: (from nwf@localhost)
	by gradx.cs.jhu.edu (8.14.2/8.13.8/Submit) id nB4KTS9X006001;
	Fri, 4 Dec 2009 15:29:28 -0500
Content-Disposition: inline
In-Reply-To: <m23a3qa40n.fsf@igel.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134570>


--Nc+Vvx0JXuqp7Zy0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2009 at 09:16:40PM +0100, Andreas Schwab wrote:
> Nathaniel W Filardo <nwf@cs.jhu.edu> writes:
>=20
> > On this machine,
> >
> > mirrors hydra:/tank0/mirrors/misc% uname -a
> > FreeBSD hydra.priv.oc.ietfng.org 9.0-CURRENT FreeBSD 9.0-CURRENT #13: S=
at Nov 14 19:40:25 EST 2009 root@hydra.priv.oc.ietfng.org:/systank/obj/syst=
ank/src/sys/NWFKERN  sparc64
> >
> > attempting to fetch from an svn source yields the following error:
> >
> > rs hydra:/tank0/mirrors/misc% git svn init -s https://joshua.svn.source=
forge.net/svnroot/joshua test-joshua
> > Initialized empty Git repository in /tank0/mirrors/misc/test-joshua/.gi=
t/                                      =20
> > mirrors hydra:/tank0/mirrors/misc% cd test-joshua                      =
                                        =20
> > mirrors hydra:/tank0/mirrors/misc/test-joshua% git svn fetch
> >         A       scripts/distributedLM/config.template      =20
> > [...]
> >         A       build.xml
> > r1 =3D fe84a7d821ec6d92da75133ac7ad1deb476b6484 (refs/remotes/trunk)
> > error: index uses  extension, which we do not understand
> > fatal: index file corrupt
> > write-tree: command returned error: 128
>=20
> I could not reproduce that on powerpc (both 32bit and 64bit).
>=20
> Andreas.

Hm.  I seem to have forgotten to mention that I am running

% git --version
git version 1.6.5.3

built from the FreeBSD ports tree, in case that matters, using

% gcc --version
gcc (GCC) 4.2.1 20070719  [FreeBSD]

Knowing nothing of git's internals, how should I start to investigate what's
going on here?

Thanks again.
--nwf;

--Nc+Vvx0JXuqp7Zy0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksZcSgACgkQTeQabvr9Tc86CQCdG09ZCz56qUx5G+lW/2OQicG4
F3wAn0KLvJAKwr3e6u9QH3IAqNFRp585
=SNKz
-----END PGP SIGNATURE-----

--Nc+Vvx0JXuqp7Zy0--
