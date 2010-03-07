From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: status of libgit.a
Date: Sun, 7 Mar 2010 13:18:10 +0100
Message-ID: <20100307121809.GS27414@genesis.frugalware.org>
References: <499B3F65.8010109@synapse.com>
 <20090218091617.7805.qmail@2684cdd72f0ee9.315fe32.mid.smarden.org>
 <499C40EA.6050108@synapse.com>
 <20090219092446.23272.qmail@3b5a9fa637f270.315fe32.mid.smarden.org>
 <1267957655.3759.29.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cjNiBkmi8s9yAE0W"
Cc: git@vger.kernel.org, Marc Oscar Singer <elf@synapse.com>,
	407722@bugs.debian.org
To: Paul Menzel <pm.debian@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 13:18:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoFR5-0000Ts-28
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 13:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929Ab0CGMSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 07:18:13 -0500
Received: from virgo.iok.hu ([212.40.97.103]:43912 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677Ab0CGMSM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 07:18:12 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 333A958070;
	Sun,  7 Mar 2010 13:18:11 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id BBE7342F09;
	Sun,  7 Mar 2010 13:18:10 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id A2B891240003; Sun,  7 Mar 2010 13:18:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1267957655.3759.29.camel@mattotaupa>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141689>


--cjNiBkmi8s9yAE0W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 07, 2010 at 11:27:35AM +0100, Paul Menzel <pm.debian@googlemail=
=2Ecom> wrote:
> > You really need to talk to upstream if you want this libgit.a.
>=20
> could you please give an update on the status of libgit.a. For example
> cgit still could not be packaged yet for Debian [1] because of this bug
> [2].
>=20
> cgit is used by a lot of projects out there, so I am wondering if the
> current libgit.a can be released in its current state.

libgit.a is not a public library, so it will never have a stable
API/ABI. There is a libgit2 project which tries to do this, but it's far
=66rom complete:

http://repo.or.cz/w/libgit2.git

> By the way, is there a web site/page for libgit.a?

No, there isn't.

I think the only sane solution is what Fedora does as well:

http://cvs.fedoraproject.org/viewvc/devel/cgit/

When cgit-1.2.3 is released, have a look at its Makefile, check what Git
version does it want and add the relevant Git source to the cgit source
package.

[ I remember Debian did not support having multiple upstream sources /
one source package, I hope this is no longer the situation. ;-) ]

--cjNiBkmi8s9yAE0W
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuTmYEACgkQe81tAgORUJZULgCeLrM+UtTnn63o4On7VsD/wQ5S
AJAAoJHs/xVzgmWpYKXIxy/gZ6U/6Cww
=xk1N
-----END PGP SIGNATURE-----

--cjNiBkmi8s9yAE0W--
