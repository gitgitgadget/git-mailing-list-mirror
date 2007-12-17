From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] (squashme) gitcli documentation fixups
Date: Mon, 17 Dec 2007 09:57:34 +0100
Message-ID: <20071217085734.GB7453@artemis.madism.org>
References: <20071213055226.GA3636@coredump.intra.peff.net> <20071213090604.GA12398@artemis.madism.org> <20071213091055.GA5674@coredump.intra.peff.net> <20071213093536.GC12398@artemis.madism.org> <20071213102636.GD12398@artemis.madism.org> <20071213102724.GE12398@artemis.madism.org> <7v7ijdeq4w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="RASg3xLB4tUQ4RcS";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 09:58:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4BnT-0003Hy-GP
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 09:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760629AbXLQI5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 03:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759326AbXLQI5g
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 03:57:36 -0500
Received: from pan.madism.org ([88.191.52.104]:55736 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbXLQI5g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 03:57:36 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 28B7B30627;
	Mon, 17 Dec 2007 09:57:35 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 8CA246703; Mon, 17 Dec 2007 09:57:34 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v7ijdeq4w.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68523>


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2007 at 07:28:47AM +0000, Junio C Hamano wrote:
>  * avoid reinventing the wheel.
>=20
> but it needs a bit more explanation.  Quite a few people seem to try to
> reinvent "git rev-parse --verify HEAD" in their scripts using much
> higher level "git show -s -1 --pretty=3Dformat:xxx", which is unfortunate
> and disgusting at the same time.

Oh and about that, the point is, users don't always know the wheel
exists because they don't know where to look in the first place. Maybe
gitcli(5) will become the right place to explain this kind of usual
tricks under a "git scripting idioms" section.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZjn+vGr7W6HudhwRAuT4AJ0Ws+lwdM0wiLn58Xf5s60fnHb8pQCfbmv0
4zJO6lmjzGHagrgYrBpxk2o=
=4XyF
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
