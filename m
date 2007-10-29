From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Fix regression in fast-import.c due to strbufs.
Date: Mon, 29 Oct 2007 07:29:37 +0100
Message-ID: <20071029062937.GB15520@artemis.corp>
References: <de47e4420710251726nb45a19fk15b3105b735a74f8@mail.gmail.com> <de47e4420710251729j5858481cg69146385a2ed798d@mail.gmail.com> <20071026065301.GL14735@spearce.org> <20071026075912.GA25365@artemis.corp> <20071026172523.GB5496@artemis.corp> <e66701d40710281959q517eabecm87bcf54c7fe47741@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="gatW/ieO32f1wygP";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git ML <git@vger.kernel.org>
To: Shun Kei Leung <kevinlsk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 07:29:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImO8G-0001YI-WF
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 07:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbXJ2G3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 02:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbXJ2G3j
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 02:29:39 -0400
Received: from pan.madism.org ([88.191.52.104]:52042 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbXJ2G3j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 02:29:39 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A313827574;
	Mon, 29 Oct 2007 07:29:37 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 317885D28E; Mon, 29 Oct 2007 07:29:37 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Shun Kei Leung <kevinlsk@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e66701d40710281959q517eabecm87bcf54c7fe47741@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62602>


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2007 at 02:59:02AM +0000, Shun Kei Leung wrote:
> Hi Pierre,
>=20
> Thanks. You are the man! It works perfectly now.

  Actually, I also was the one breaking it in the first place, but
you're welcome :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHJX3RvGr7W6HudhwRAnw5AJ0S9ZZyr9MKgmF/6OOup9vXLIuXcgCeJ2gi
xV8TTg3ggFpGIEbFomQegFI=
=/GNe
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
