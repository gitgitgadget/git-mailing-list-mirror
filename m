From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] builtin-tag: fix fallouts from recent parsopt  restriction.
Date: Mon, 17 Dec 2007 22:24:33 +0100
Message-ID: <20071217212433.GD13004@artemis.madism.org>
References: <7vd4t5eq52.fsf@gitster.siamese.dyndns.org> <20071217090749.GC7453@artemis.madism.org> <7vir2xa8z7.fsf@gitster.siamese.dyndns.org> <20071217105834.GG7453@artemis.madism.org> <7v1w9la7o8.fsf@gitster.siamese.dyndns.org> <20071217123307.GK7453@artemis.madism.org> <7vy7bt6qv6.fsf@gitster.siamese.dyndns.org> <20071217203143.GA2105@coredump.intra.peff.net> <7vhcih6oj8.fsf@gitster.siamese.dyndns.org> <20071217205355.GC2105@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="VV4b6MQE+OnNyhkM";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 17 22:25:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4NSX-0000X6-Qq
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 22:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934370AbXLQVYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 16:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934282AbXLQVYi
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 16:24:38 -0500
Received: from pan.madism.org ([88.191.52.104]:41332 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934113AbXLQVYh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 16:24:37 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8901130A1F;
	Mon, 17 Dec 2007 22:24:34 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 04A212A2250; Mon, 17 Dec 2007 22:24:34 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071217205355.GC2105@coredump.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68627>


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2007 at 08:53:55PM +0000, Jeff King wrote:
> On Mon, Dec 17, 2007 at 12:42:51PM -0800, Junio C Hamano wrote:
>=20
> > You forgot one case.
> >=20
> >     4. Everybody who does _not_ know that we traditionally did not
> >        support the form would expect "--abbrev 10" and "-n 4" to work.
>=20
> I would expect "-n 4" to work, but not "--abbrev 10". But perhaps that
> is just me. If that is the expectation, I think the behavior you
> outlined is sensible.

FWIW that's exactly the opposite for me. -n4 is easy to type, and I
always do that. Though on a keyboard, ' ' is under the thumb, '=3D' is
harder to catch, so I tend to prefer when CLIs don't force me to use =3D.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZukRvGr7W6HudhwRAuIsAKCGb1GFyNiXZEXtP1Vh59T3KF2P1wCeIfxw
u6vqxfnWLlDeU0eMlLih2tc=
=NfYg
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
