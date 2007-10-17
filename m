From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 01/25] Add a simple option parser.
Date: Wed, 17 Oct 2007 09:52:06 +0200
Message-ID: <20071017075206.GA17911@artemis.corp>
References: <1192522616-16274-1-git-send-email-madcoder@debian.org> <1192523721-18985-1-git-send-email-madcoder@debian.org> <20071017072419.GZ13801@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="LQksG6bCIzRHxTLp";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 09:53:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii3iZ-0003Oj-JU
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 09:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611AbXJQHwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 03:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753591AbXJQHwK
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 03:52:10 -0400
Received: from pan.madism.org ([88.191.52.104]:37088 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753476AbXJQHwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 03:52:09 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 0DE3B25617;
	Wed, 17 Oct 2007 09:52:07 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 16F6732BD50; Wed, 17 Oct 2007 09:52:06 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071017072419.GZ13801@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61349>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2007 at 07:24:19AM +0000, Shawn O. Pearce wrote:
> Pierre Habouzit <madcoder@debian.org> wrote:
> > The option parser takes argc, argv, an array of struct option
> > and a usage string. ...
>=20
> OK, I've chewed down some version of this series.  ;-)
>=20
> To be more specific I fetched ph/parseopt (11b83dc4da) from your
> tree at git://git.madism.org/git.git and split it apart somewhat.
> All of the patches were rebased onto my most recent master but I
> also yanked the two that impacted the builtin-fetch series out and
> layered them over a merge of db/fetch-pack and my version of your
> ph/parseopt series.
>=20
> Why?  Well I want to keep our options open about which series
> graduates to master first.  Although builtin-fetch has been cooking
> for a while there's been a number of issues with that code.
> There exists a (perhaps small) chance that ph/parseopt will be
> ready before db/fetch-pack.

  Yes, this makes sense, otoh the migration of the fetch commands are
really independant so you can put those appart, even if I end up needing
to rewrite them it's not an issue.

> Currently ph/parseopt is in pu.  Tomorrow I'll look at the usage
> strings in more depth and see if any improvements can be easily
> made.  I already made one suggested by Dscho in builtin-add.

  wonderful, thanks.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHFb8mvGr7W6HudhwRAr1FAJ4lx8cGtM3fAr6fEU+3AiaaLqNTlACfQReS
WyEMCpc9C/AhQq4JUukPmeM=
=YlLy
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
