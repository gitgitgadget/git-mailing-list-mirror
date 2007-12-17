From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] builtin-tag: fix fallouts from recent parsopt  restriction.
Date: Mon, 17 Dec 2007 22:01:16 +0100
Message-ID: <20071217210116.GB13004@artemis.madism.org>
References: <20071213102636.GD12398@artemis.madism.org> <7vd4t5eq52.fsf@gitster.siamese.dyndns.org> <20071217090749.GC7453@artemis.madism.org> <7vir2xa8z7.fsf@gitster.siamese.dyndns.org> <20071217105834.GG7453@artemis.madism.org> <7v1w9la7o8.fsf@gitster.siamese.dyndns.org> <20071217123307.GK7453@artemis.madism.org> <7vy7bt6qv6.fsf@gitster.siamese.dyndns.org> <20071217203143.GA2105@coredump.intra.peff.net> <20071217204204.GA13004@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="9zSXsLTf0vkW971A";
	protocol="application/pgp-signature"; micalg=SHA1
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 22:01:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4N5r-0007n6-J7
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 22:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761537AbXLQVBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 16:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761523AbXLQVBT
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 16:01:19 -0500
Received: from pan.madism.org ([88.191.52.104]:55542 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761484AbXLQVBS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 16:01:18 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id E50D6309FE;
	Mon, 17 Dec 2007 22:01:16 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 472E83E117F; Mon, 17 Dec 2007 22:01:16 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071217204204.GA13004@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68620>


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2007 at 08:42:04PM +0000, Pierre Habouzit wrote:
> On Mon, Dec 17, 2007 at 08:31:43PM +0000, Jeff King wrote:
> > On Mon, Dec 17, 2007 at 11:52:29AM -0800, Junio C Hamano wrote:
> >=20
> > > So in short, for an option that takes optional option-argument:
> >=20
> > I agree with everything you said, except...
> >=20
> > >    - if it is given as "--long-name", and there is a next word, see if
> > >      that is plausible as its argument.  Get it and signal the caller
> > >      you consumed it, if it is.  Ignore it and signal the caller you
> > >      didn't, if it isn't.
> >=20
> > This "plausible" makes me a little nervous, and I wonder why we want to
> > support this at all. Is it
> >=20
> >   1. We have traditionally supported "--abbrev 10"? I don't think this
> >      is the case.
>=20
>   Yes, that's why the restriction bugs me a bit too.

  Err I misread your point, _yes_ we do, see builtin-show-ref.c, or see
--start-number in builtin-log.c. There is a precedent.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZuOcvGr7W6HudhwRAiAeAJ9fhEAcGt4MVZr/tZIGaNtYsaJQPgCfbt9S
N91kuS0fzYn24HjjO9Fi7/o=
=Hxwd
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
