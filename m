From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH guilt] make guilt use standard POSIX shell
Date: Thu, 14 Jun 2007 15:07:52 +0200
Message-ID: <20070614130752.GB23324@artemis>
References: <11818254621527-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="6sX45UoQRIJXqkqR";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Josef Jeff Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Jun 14 15:07:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyp3O-0007We-0j
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 15:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbXFNNHy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 09:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbXFNNHx
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 09:07:53 -0400
Received: from pan.madism.org ([88.191.52.104]:56440 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995AbXFNNHx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 09:07:53 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 833E8DA7A;
	Thu, 14 Jun 2007 15:07:52 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 13B38F58; Thu, 14 Jun 2007 15:07:52 +0200 (CEST)
Mail-Followup-To: Josef Jeff Sipek <jsipek@cs.sunysb.edu>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <11818254621527-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50198>


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2007 at 02:50:55PM +0200, Pierre Habouzit wrote:
> This patch series makes guilt be able to work with a standard posix shell.
>=20

> This has been tested with bash, zsh, dash and posh acting as /bin/sh.

  By tested I mean that I carefully crafted the changes, and ran make
test with /bin/sh pointing to those shells, and the suite passed.

  Though, we could have /some/ regressions.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGcT2ovGr7W6HudhwRAlcHAJ9cqLQK6rYdiitq9Hvccg3rPn+jhQCePVHI
8aQ/7y+l/Laaqg+t64aQ0io=
=t5Fd
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
