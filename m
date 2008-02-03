From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Sun, 03 Feb 2008 11:38:04 +0100
Message-ID: <20080203103804.GC323@artemis.madism.org>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <87k5lnwvzd.dancerj%dancer@netfort.gr.jp> <878x22j1km.dancerj%dancer@netfort.gr.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ALfTUftag+2gvp1h";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junichi Uekawa <dancer@netfort.gr.jp>
X-From: git-owner@vger.kernel.org Sun Feb 03 11:38:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLcFH-0001AT-HX
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 11:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbYBCKiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 05:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753462AbYBCKiK
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 05:38:10 -0500
Received: from pan.madism.org ([88.191.52.104]:54581 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753376AbYBCKiI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 05:38:08 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 6C46931FD2;
	Sun,  3 Feb 2008 11:38:05 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id DF00A468A3C; Sun,  3 Feb 2008 11:38:04 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junichi Uekawa <dancer@netfort.gr.jp>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <878x22j1km.dancerj%dancer@netfort.gr.jp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72347>


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 03, 2008 at 01:00:57AM +0000, Junichi Uekawa wrote:
> Hi,
>=20
>=20
> When I was idly googling around for traces of VCS and popularity,
> noticed that Git is actually pretty popular.  Googling for 'gitweb'
> and 'viewcvs' and other comparative web-frontend variants floating in
> the cyberspace I get these number of hits (in rough estimate) :
>=20
> 10000000 CVS
> 1000000 SVN
> 100000 Git
> 10000 Mercurial / Darcs
> 1000 Bzr
>=20
> This is crude, and I'm sure someone else will come up with a better
> estimate. The point is, when there are so many users, people don't
> read the lists or the changelog, but rely on manuals, and be surprised
> with this change.

  http://www.google.com/trends?q=3Dsvn%2C+git%2C+mercurial%2C+bzr%2C+darcs&=
ctab=3D0&geo=3Dall&date=3Dall&sort=3D0

  :)

> I was wondering why I use the git-xxx format so much (in muscle, and
> in scripts). And realized I have the following reasons:
>=20
> 1. That's the form documented in the manual pages (generated from asciido=
c)
>=20
> 2. That's the name manual pages are in.
>=20
> 3. Linus said it's better (3 years ago), and I thought so too.
>    (Situation has changed, bash has better completion for 'git'
>    commands, so that's no longer valid)
>=20
> 4. There was a GNU Interactive Tools with the same name 'git', so it
> was better to avoid confusion then. (This is still the case with
> Debian, where the sysadmin can choose whether to make 'git' (GNU
> Interactive Tools) the default, or our beloved git.
>=20
> 5. There are many documentations floating around.
>=20
> 6. I'm used to it.

  Yes, but your aliases are not usable through git-foo, only git foo is.
So for consistency reasons, non dashed versions are better.

  And one could in the future have builtin commands without the
corresponding git-foo and git-bar either. I'm thinking
git-revert/git-cherry-pick that use _exactly_ the same code and code
objects, hence having the two binary is somehow a waste of space.
git-log variants are the same, and so on. I'm not saying this _will_ be
done, TTBOMK it has not even been discussed, but that may happen at some
point.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHpZmMvGr7W6HudhwRAuqPAJ9Ligx1z2fdiWN0JfqFuouNve24JgCcDLtF
lJZ1Douo/DQdshrreVb/pW4=
=DvZy
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
