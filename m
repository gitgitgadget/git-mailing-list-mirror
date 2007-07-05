From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Email address from username and hostname preferred over $EMAIL
Date: Thu, 5 Jul 2007 22:21:40 +0200
Message-ID: <20070705202140.GA24349@artemis.corp>
References: <OF40A04FE5.AA34B1BF-ON8825730F.005D733A-8825730F.0062A716@beckman.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="vkogqOf2sHV7VnPd";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: mkraai@beckman.com
X-From: git-owner@vger.kernel.org Thu Jul 05 22:21:58 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6Xpo-0007BK-P2
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 22:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762061AbXGEUVp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 16:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762045AbXGEUVp
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 16:21:45 -0400
Received: from pan.madism.org ([88.191.52.104]:48732 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761994AbXGEUVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 16:21:43 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 697C120B0;
	Thu,  5 Jul 2007 22:21:42 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 9C32A51AE; Thu,  5 Jul 2007 22:21:40 +0200 (CEST)
Mail-Followup-To: mkraai@beckman.com, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <OF40A04FE5.AA34B1BF-ON8825730F.005D733A-8825730F.0062A716@beckman.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51692>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2007 at 10:57:37AM -0700, mkraai@beckman.com wrote:
> Howdy,
>=20
> Git prefers to use an email address constructed from the username and=20
> hostname to the value of the EMAIL environment variable.  I think it=20
> should prefer the latter to the former.  This problem was introduced by=
=20
> ec563e8153cba89728a271a26c8a94e7a42d8152.

  no, ec563e8153cba89728a271a26c8a94e7a42d8152 is about making the
emails and usernames be taken from EMAIL iff there is none specified in
the different .gitconfig's (which is sane as $EMAIL is a system wide
default setting and that .git/config is definitely meant as an ovveride
of that setting).


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGjVLUvGr7W6HudhwRAi+OAKCbdSLx888s5fS1fuM1xAPgtISJqwCghh4B
0yRMdqfnMTea9jmP6jjZSLs=
=hYUo
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
