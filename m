From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 6/7] Eradicate yet-another-buffer implementation in  buitin-rerere.c
Date: Fri, 07 Sep 2007 11:02:16 +0200
Message-ID: <20070907090216.GG21418@artemis.corp>
References: <11890776114037-git-send-email-madcoder@debian.org> <118907761140-git-send-email-madcoder@debian.org> <11890776111843-git-send-email-madcoder@debian.org> <11890776112292-git-send-email-madcoder@debian.org> <11890776111670-git-send-email-madcoder@debian.org> <11890776112309-git-send-email-madcoder@debian.org> <11890776112641-git-send-email-madcoder@debian.org> <Pine.LNX.4.64.0709061504521.28586@racer.site> <20070906171734.GG8451@artemis.corp> <7v642m7vhr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="iJXiJc/TAIT2rh2r";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 11:02:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITZjN-0003ul-T4
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 11:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbXIGJCT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 05:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757377AbXIGJCT
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 05:02:19 -0400
Received: from pan.madism.org ([88.191.52.104]:52287 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757402AbXIGJCS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 05:02:18 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 243B98B6;
	Fri,  7 Sep 2007 11:02:17 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 33C6B88; Fri,  7 Sep 2007 11:02:16 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <7v642m7vhr.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58007>


--iJXiJc/TAIT2rh2r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2007 at 08:03:28AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   crap, and I did that in the 5th patch as well. well, I'll maybe send
> > privately a "fixed" version of the patch to junio then, to avoid
> > flooding the list with spacing issues.
>=20
> Heh, no need.  I can fix them up locally here.

  okay, perfect.

> For me personally, your use of Mail-Followup-To: header is very
> much more irritating.  When I want to talk to you, I want my MUA
> to put YOUR name on To: header, not Johannes.  I consider it
> rude and selfish to use M-F-T to avoid getting duplicates from a
> mailing list you subscribe to.
>=20
> I have said this often enough in the past, and have been trying
> not to say this unless necessary.  It is sad and happy at the
> same time that I still occasionary need to bring this up.
>=20
> Sad because I have to get irritated enough before I say this,

  I'm sorry, I'll remove it (for the next mail though, I'm too lazy to
change that right now). It's a policy on Debian lists to force M-F-T,
and it's indeed not very practical on lists like the lkml or git. I
could have guessed that myself.

> and happy because it means I found another person who is worth
> communicating with and expect to communicate again with on the
> list.

  heh, thanks :)

> Please, don't.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--iJXiJc/TAIT2rh2r
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4ROYvGr7W6HudhwRAkZGAJ49gckTWhKJdAZrkYOXJy9Kky+ZTwCfTmVj
yHeT7HzAqb4a1gXRUy5VpNY=
=i/mh
-----END PGP SIGNATURE-----

--iJXiJc/TAIT2rh2r--
