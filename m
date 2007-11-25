From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] best way to show diff of commit
Date: Sun, 25 Nov 2007 23:09:02 +0100
Message-ID: <20071125220902.GB21121@artemis.corp>
References: <20071125211831.GA21121@artemis.corp> <20071125212748.GB23820@fieldses.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="wzJLGUyc3ArbnUjN";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sun Nov 25 23:09:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwPfW-0002KT-Px
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 23:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758745AbXKYWJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 17:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758795AbXKYWJG
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 17:09:06 -0500
Received: from pan.madism.org ([88.191.52.104]:53190 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758764AbXKYWJE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 17:09:04 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id CB3952C2F7;
	Sun, 25 Nov 2007 23:09:02 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 6F3BAC5BC; Sun, 25 Nov 2007 23:09:02 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071125212748.GB23820@fieldses.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66016>


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 25, 2007 at 09:27:48PM +0000, J. Bruce Fields wrote:
> On Sun, Nov 25, 2007 at 10:18:31PM +0100, Pierre Habouzit wrote:
> >   There is specific script I run in my vim with git, that tries to show
> > from the 'status' git commit shows in the buffer which list of files has
> > changed, and builds a diff from it quite clumsily[0].
> >=20
> >   I wonder how hard it would be for git commit to "stash" the current
> > commit being sent somewhere editors would be able to have a look at (an
> > alternate index is probably fine). Note that maybe I'm stupid and
> > overlooked that such a thing already exists.  I'd like to have it in two
> > flavors: normal and amend mode. normal mode would show what the
> > resulting commit diff looks like, and the amend mode only shows the
> > incrementall diff the amend adds to the previous commit.
> >=20
> >   My question is: what do you think is the best way to do that, and
> > where ?
>=20
> Have you checked whether "git-commit -v" already does what you want?

  Hmm it doesn't because I would have to call git commit -v each time I
commit and well I _like_ having the status better. And moreover I want
the diff to go in a separated buffer too.

  I'd rather have some kind of way to have git-commit let a trail of
what he's doing if the user validate the commit, and use that from the
editor. I'm sure it would be useful to simple GUIs as well (most
advanced GUIs would like to have fine control to what gets commited and
are likely to have the command like used quite right).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHSfJ+vGr7W6HudhwRAv82AJ47uZKFgxmE3U/wg7RcqC8hmRN0TwCdFKJ2
p3wvh3szxqQojcxkPCm3/UQ=
=qlTV
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
