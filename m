From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Refactoring the tag object; Introducing soft references  (softrefs); Git 'notes' (take 2)
Date: Sun, 10 Jun 2007 10:29:35 +0200
Message-ID: <20070610082935.GD2951@artemis>
References: <200706040251.05286.johan@herland.net> <466B305A.5080802@midwinter.com> <200706100116.46062.johan@herland.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="4ZLFUWh1odzi/v6L";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:29:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxInu-0002wU-Im
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762604AbXFJI3l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762593AbXFJI3l
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:29:41 -0400
Received: from pan.madism.org ([88.191.52.104]:52791 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762587AbXFJI3k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:29:40 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8B78ECA46;
	Sun, 10 Jun 2007 10:29:36 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id A5C26A788; Sun, 10 Jun 2007 10:29:35 +0200 (CEST)
Mail-Followup-To: Johan Herland <johan@herland.net>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <200706100116.46062.johan@herland.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49675>


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 10, 2007 at 01:16:45AM +0200, Johan Herland wrote:
> On Sunday 10 June 2007, Steven Grimm wrote:
> > Being able to specify relationships between commits after the fact seem=
s=20
> > like a very useful facility.
> >=20
> > Does it make sense to have type information to record what the=20
> > relationship between two objects means? Without that, it seems like=20
> > it'll be hard to build much of a tool set on top of this feature, since=
=20
> > no two tools that made use of it could unambiguously query just their=
=20
> > own softrefs.
>=20
> Actually MadCoder/Pierre had a similar idea on IRC. He wanted to separate=
=20
> softrefs into namespaces, so that softrefs for tags could live in a=20
> different place than softrefs associated with his "gits" bug tracker.
>=20
> I haven't thought very much about this, but it's certainly possible to do=
=20
> something like this. What do the rest of y'all think?

  Well, if we're two with the same idea, it's a good one, no ? :)

  In fact, the namespace idea like I told you on IRC isn't _that_
brilliant. But I'm sure recording a softref with:

  <from_sha> <to_sha> <token>

  token would help classify the softref. And I'm sure we'll end up with:

  <from_sha> <to_sha> <token> <flags>

  with the flags to say what behaviour (e.g.) the reachability resolver
should have wrt that link ?

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGa7ZvvGr7W6HudhwRAsGuAKCkDue3jdYKzB7+sFlBp1oZyaLbpQCdFPOo
qzV6efBH5HdwHqXbXxi/kS0=
=6lQz
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
