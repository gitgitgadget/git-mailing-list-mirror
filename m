From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] builtin-tag: fix fallouts from recent parsopt  restriction.
Date: Tue, 18 Dec 2007 00:14:59 +0100
Message-ID: <20071217231459.GA4422@artemis.madism.org>
References: <20071217090749.GC7453@artemis.madism.org> <7vir2xa8z7.fsf@gitster.siamese.dyndns.org> <20071217105834.GG7453@artemis.madism.org> <7v1w9la7o8.fsf@gitster.siamese.dyndns.org> <20071217123307.GK7453@artemis.madism.org> <7vy7bt6qv6.fsf@gitster.siamese.dyndns.org> <20071217203143.GA2105@coredump.intra.peff.net> <20071217204204.GA13004@artemis.madism.org> <20071217210116.GB13004@artemis.madism.org> <20071217230729.GE2105@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="J/dobhs11T7y2rNN";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 18 00:16:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4PBn-0001M0-OD
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 00:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933799AbXLQXPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 18:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763521AbXLQXPH
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 18:15:07 -0500
Received: from pan.madism.org ([88.191.52.104]:45419 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762636AbXLQXPF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 18:15:05 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 7B6EA309A6;
	Tue, 18 Dec 2007 00:15:03 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 20F7D14223A; Tue, 18 Dec 2007 00:14:59 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071217230729.GE2105@coredump.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68659>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2007 at 11:07:29PM +0000, Jeff King wrote:
> On Mon, Dec 17, 2007 at 10:01:16PM +0100, Pierre Habouzit wrote:
>=20
> >   Err I misread your point, _yes_ we do, see builtin-show-ref.c, or see
> > --start-number in builtin-log.c. There is a precedent.
>=20
> Ugh. Well, in that case, it seems we are stuck with it, and I think
> the behavior Junio laid out is the right course of action.

Well I agree, I was mostly trying to show what the code could look like
if we tried to be more clever. I'm fine for enforcing the sticked usage
for optional flags, I was the one advocating it in the first place
anyways. I just wanted to be sure we didn't missed something obvious.

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

iD8DBQBHZwLzvGr7W6HudhwRAlR5AKCNUWfwuHPXm/mqgTapHdpQ9nEqgQCeICwS
9mWopkx002qe5gp6XKJ3mCE=
=qoh9
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
