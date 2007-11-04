From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] fix comment in strbuf.h to use correct name strbuf_avail()
Date: Sun, 04 Nov 2007 09:56:51 +0100
Message-ID: <20071104085651.GA26269@artemis.corp>
References: <11941633412454-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="J/dobhs11T7y2rNN";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Nov 04 09:57:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IobIB-0000EK-NH
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 09:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbXKDI45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 03:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbXKDI45
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 03:56:57 -0500
Received: from pan.madism.org ([88.191.52.104]:36431 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088AbXKDI44 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 03:56:56 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 9C49328494;
	Sun,  4 Nov 2007 09:56:55 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id AF9A71FED2; Sun,  4 Nov 2007 09:56:51 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <11941633412454-git-send-email-prohaska@zib.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63363>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2007 at 08:02:21AM +0000, Steffen Prohaska wrote:
>=20
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
  Acked-By: Pierre Habouzit <madcoder@debian.org>
> ---
>  strbuf.h |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>=20
> Note, the patch is against Junio's pu.
>=20
>     Steffen
>=20
> diff --git a/strbuf.h b/strbuf.h
> index 9720826..e5cdd1e 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -24,11 +24,11 @@
>   *
>   *    strbuf_grow(sb, SOME_SIZE);
>   *    // ... here the memory areay starting at sb->buf, and of length
> - *    // sb_avail(sb) is all yours, and you are sure that sb_avail(sb) i=
s at
> - *    // least SOME_SIZE
> + *    // strbuf_avail(sb) is all yours, and you are sure that strbuf_ava=
il(sb)
> + *    // is at least SOME_SIZE
>   *    strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
>   *
> - *    Of course, SOME_OTHER_SIZE must be smaller or equal to sb_avail(sb=
).
> + *    Of course, SOME_OTHER_SIZE must be smaller or equal to strbuf_avai=
l(sb).
>   *
>   *    Doing so is safe, though if it has to be done in many places, addi=
ng the
>   *    missing API to the strbuf module is the way to go.
> --=20
> 1.5.3.4.464.ge1bc2
>=20

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLYlTvGr7W6HudhwRAqERAJ9TMIk1tvnYeFEi3WFMTZKw78W48wCeKlwq
ZL10J201HQmNfO4epBZHlPQ=
=NSPz
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
