From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: THREADED_DELTA_SEARCH
Date: Thu, 10 Jul 2008 11:33:09 +0200
Message-ID: <20080710093308.GF24819@artemis.madism.org>
References: <20080710075327.GD24819@artemis.madism.org> <m3hcaydswg.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="cz6wLo+OExbGG7q/";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 11:34:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGsXQ-0008Jz-Hz
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 11:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbYGJJdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 05:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbYGJJdM
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 05:33:12 -0400
Received: from pan.madism.org ([88.191.52.104]:51882 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752991AbYGJJdL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 05:33:11 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 2B7F58;
	Thu, 10 Jul 2008 11:33:09 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 0E6A53ABA; Thu, 10 Jul 2008 11:33:09 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jakub Narebski <jnareb@gmail.com>, Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <m3hcaydswg.fsf@localhost.localdomain>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87963>


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2008 at 08:51:06AM +0000, Jakub Narebski wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   I'm using it in production for quite a long time now, and I wonder if
> > there is any specific reason why it's not default. Debian activated it
> > by default too a couple of weeks ago, which means that it's in
> > production on quite a large scale, and there are no issues reported
> > either. Would a patch making it default be accepted ? It's quite handy
> > given that SMP machines are really pervasive nowadays=E2=80=A6
>=20
> Doues our ./configure detects if it makes sense (i.e. if it is SMP
> machine)?

  I don't know if it does, but it wouldn't make sense for distros.

>  What is the cost of THREADED_DELTA_SEARCH for single processor
> single core machine?

  Threading has to be enabled in the configuration, and there is a
--thread=3D0 mode that enables autodetection of the number of CPUs online.
so there is no overhead for single CPU systems.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkh111QACgkQvGr7W6HudhxVpACgo3YOMPJhs1U3RiZ6v6xlniLd
tVYAni5a4UidRtkqd8pEmpcexTDa+gzT
=Ozyr
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
