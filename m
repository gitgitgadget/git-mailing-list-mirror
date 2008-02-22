From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [Fwd: [ANNOUNCE] bzr-fastimport plugin, yet another Bazaar import option]
Date: Fri, 22 Feb 2008 19:20:42 +0100
Message-ID: <20080222182041.GB4555@artemis.madism.org>
References: <47BE167A.4060005@internode.on.net> <20080222073228.GF8410@spearce.org> <20080222113737.GA18581@artemis.madism.org> <20080222144415.GA19974@yugib.highrise.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="gj572EiMnwbLXET9";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Ian Clatworthy <ian.clatworthy@internode.on.net>,
	Bazaar <bazaar@lists.canonical.com>, git@vger.kernel.org
To: Aidan Van Dyk <aidan@highrise.ca>
X-From: git-owner@vger.kernel.org Fri Feb 22 19:21:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JScWf-0002iX-JK
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 19:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072AbYBVSUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 13:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756028AbYBVSUq
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 13:20:46 -0500
Received: from pan.madism.org ([88.191.52.104]:43684 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755524AbYBVSUo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 13:20:44 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id B28001835F;
	Fri, 22 Feb 2008 19:20:42 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 40CB0451E6D; Fri, 22 Feb 2008 19:20:42 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Aidan Van Dyk <aidan@highrise.ca>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ian Clatworthy <ian.clatworthy@internode.on.net>,
	Bazaar <bazaar@lists.canonical.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080222144415.GA19974@yugib.highrise.ca>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74745>


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2008 at 02:44:15PM +0000, Aidan Van Dyk wrote:
> * Pierre Habouzit <madcoder@debian.org> [080201 08:20]:
> =20
> >   /me opens bigs ears and eyes: does this mean that we have an
> > incremental importer of CVS based on git-fast-import ? I mean I'm really
> > interested into that, as git-cvsimport is really broken with the glibc
> > CVS tree, and as the glibc CVSROOT is rsync-able, an incremental
> > importer that has access to the CVSROOT RCS files is probably the most
> > efficient way.
>=20
> In the repository I convert (PostgreSQL), I'm using the ruby
> fromcvs/togit converter, which has worked well, because git-cvsimport
> doesn't work.

  Well, last time I tried, it exploded miserably (big fat OOM) because
glibc CVS repository comes back to 1984 or so, and has a very nasty big
fat Changelog with literally thousands of modifications.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHvxJ5vGr7W6HudhwRAuhjAKCiU4fBPYZQM1ad18Gk+zkCjjLexACghwIW
gxOa1QG7GDWtmJqwYIVXw0Q=
=Gd6Q
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
