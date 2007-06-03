From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 3 Jun 2007 15:31:09 +0200
Message-ID: <20070603133109.GD14336@artemis>
References: <20070603114843.GA14336@artemis> <878xb19ot5.fsf@graviton.dyn.troilus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="g7w8+K/95kPelPD2";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 15:31:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuqAw-0004MY-9Q
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 15:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbXFCNbL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 09:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbXFCNbL
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 09:31:11 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:45440 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752287AbXFCNbL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 09:31:11 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	by smtp7-g19.free.fr (Postfix) with ESMTP id B8546183C9;
	Sun,  3 Jun 2007 15:31:09 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5F3B8804; Sun,  3 Jun 2007 15:31:09 +0200 (CEST)
Mail-Followup-To: Michael Poole <mdpoole@troilus.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <878xb19ot5.fsf@graviton.dyn.troilus.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48993>


--g7w8+K/95kPelPD2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 03, 2007 at 08:59:18AM -0400, Michael Poole wrote:
> Pierre Habouzit writes:
>
> >   The other problem I see is that at the time a bug gets reported, the
> > user knows it's found at a commit say 'X'. But it could in fact have
> > been generated at a commit Y, with this pattern:
> >
> >   --o---o---Y---o---o---o---o---X---o---o--> master
> >                      \
> >                       o---o---o---o---o---o--> branch B
>=20
> Mainly for that reason, I would suggest having it outside the code
> base's namespace: probably a different root in the same $GIT_DIR, but
> I can see people wanting to have a separate $GIT_DIR.  If the database
> tracks bugs by what commit(s) introduce or expose the bug -- at least
> once that is known -- then you get nearly free tracking of which
> branches have the bug without having to check out largely redundant
> trees.

  Sure, but if it's completely out-of-tree, then cloning a repository
don't allow you to get the bug databases with it for free. I mean it'd
be great to have it somehow linked to the repository, but also I agree
that not everybody wants to clone the whole bugs databases. So maybe it
should just be in another shadow branch that annotates the devel ones.
Hmmm I definitely need to read the git-note thread...

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--g7w8+K/95kPelPD2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGYsKdvGr7W6HudhwRAlTSAJ4re4/sDJiY0xjlz/xtes/lfeMocQCfQ2+E
SIJ9UNHU6YjIf8hKYwitRjw=
=JFXk
-----END PGP SIGNATURE-----

--g7w8+K/95kPelPD2--
