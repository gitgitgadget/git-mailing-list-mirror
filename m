From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/2] Add a 'source' decorator for commits
Date: Tue, 28 Oct 2008 21:09:02 +0100
Message-ID: <20081028200901.GA2894@artemis.mtv.corp.google.com>
References: <alpine.LFD.2.00.0810271256470.3386@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810271305500.3386@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810271306230.3386@nehalem.linux-foundation.org> <20081028054539.GA23195@sigill.intra.peff.net> <20081028131116.GA8272@artemis.googlewifi.com> <20081028194642.GB752@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="NzB8fVQJ5HfG6fxh";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 28 21:10:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuutU-0007rU-Js
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 21:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbYJ1UJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 16:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbYJ1UJK
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 16:09:10 -0400
Received: from pan.madism.org ([88.191.52.104]:34501 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbYJ1UJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 16:09:09 -0400
Received: from madism.org (unknown [216.239.45.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id AFD1E3DDD7;
	Tue, 28 Oct 2008 21:09:05 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 7F92755AC1A; Tue, 28 Oct 2008 21:09:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081028194642.GB752@sigill.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99319>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2008 at 07:46:43PM +0000, Jeff King wrote:
> On Tue, Oct 28, 2008 at 02:11:16PM +0100, Pierre Habouzit wrote:
> > believe the proper way to do that is to help git-log knowing which are
> > the short (topic) branches, and to crawl incrementally using a
> > date-based hack. This would basically work a bit like this. Let's
> > imaging you want to crawl "next" in git and know which topics from pu
> > are in it. You would say e.g.:
>=20
> Hmm. Why a date-based hack to see what's on the topic branch? Why not
> just give an option to walk the graph twice,

it serves the purpose to not walk the graph twice actually, but indeed
twice is not _that_ bad.
=20
> giving name-rev style annotations, and just let it be slow. People
> will mostly look at it by specifying just their topic branches anyway.
> IOW:
>=20
>   git log ^origin/master my/topic1 my/topic2 my/topic3
>=20
> and by virtue of the fact that you are vastly limiting the size of the
> tree, it won't actually end up too slow. So you haven't said so much
> "these are my topic branches" as "I am just not interested in things
> that are already upstream."

Well, I was just thinking quickly during jetlag-induced insomnia. I
don't really care about the issue that much actually.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkHcVsACgkQvGr7W6HudhzFmACeK2W4x3Sh+cbrqjK6k30+IU4m
zGgAoJIlkWPPrKJAl7oihga+Q4E6QJte
=+T63
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
