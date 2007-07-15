From: VMiklos <vmiklos@frugalware.org>
Subject: Re: question about git-submodule
Date: Sun, 15 Jul 2007 16:26:24 +0200
Message-ID: <20070715142624.GF7106@genesis.frugalware.org>
References: <20070713214630.GB7106@genesis.frugalware.org> <20070715083959.GC999MdfPADPa@greensroom.kotnet.org> <20070715104712.GF2568@steel.home> <20070715105450.GD7106@genesis.frugalware.org> <20070715135057.GI2568@steel.home> <20070715135453.GE7106@genesis.frugalware.org> <20070715140244.GF999MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Jul 15 16:26:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA53W-0002jL-6r
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 16:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757662AbXGOO0f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 10:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757669AbXGOO0f
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 10:26:35 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:54289 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757658AbXGOO0e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 10:26:34 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1IA53N-000885-Up
	from <vmiklos@frugalware.org>; Sun, 15 Jul 2007 16:26:33 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id EF535176813C; Sun, 15 Jul 2007 16:26:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070715140244.GF999MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.1
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.1 required=5.9 tests=BAYES_50,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4994]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52559>


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Na Sun, Jul 15, 2007 at 04:02:44PM +0200, Sven Verdoolaege <skimo@kotnet.or=
g> pisal(a):
> On Sun, Jul 15, 2007 at 03:54:53PM +0200, VMiklos wrote:
> > that's what i asked originally :) i believed that one is supposed to use
> > git-submodule update to pull each submodule, but it does not seems to
> > do so. my question is still about if it is possible to pull each
> > submodule using a single command
>=20
> Maybe you should explain in a bit more detail what you are trying
> to do.

ok :) so i have a repo and i add a submodule in the libfoo dir. when i
add it, git will clone the repo, that's fine. it would be nice to have a
command (i thought git submodule update would do it for me) which would
pull in the repo _and_ would pull in the libfoo dir, too

currently if you have 10 submodules, you need to updated each of them
manually, and having a feature to all of them at once would be nice (of
course it's fine if this is not the default when using git pull in the
"main" repo)

thanks,
- VMiklos

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGmi6Qe81tAgORUJYRAkL8AJ9IA9o/vmBLjTYLJNZ+yT3RZoVC/ACfRj42
gansdp8AGjOFivrT0Fep2Ck=
=9g/V
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--
