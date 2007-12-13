From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Thu, 13 Dec 2007 10:29:43 +0100
Message-ID: <20071213092942.GB12398@artemis.madism.org>
References: <20071213055226.GA3636@coredump.intra.peff.net> <20071213090604.GA12398@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="s2ZSL+KKDSLx8OML";
	protocol="application/pgp-signature"; micalg=SHA1
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 10:30:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2kON-0004Gy-EK
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 10:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbXLMJ3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 04:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbXLMJ3p
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 04:29:45 -0500
Received: from pan.madism.org ([88.191.52.104]:49592 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbXLMJ3o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 04:29:44 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id C2E9A2FB58;
	Thu, 13 Dec 2007 10:29:43 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 288E3C242; Thu, 13 Dec 2007 10:29:43 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071213090604.GA12398@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68135>


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On jeu, d=C3=A9c 13, 2007 at 09:06:04 +0000, Pierre Habouzit wrote:
> fail. Maybe we can do parse_options work in multiple passes though, but
> that would require a quite extensive rethought of the module, the

  In fact it's not doable because of short options. I knew I already had
that idea but dropped it, the reason is that if you have the atom:

  -ab

  That the first pass knows about a -b, and that the second pass knows
about -a, then you have a problem. Because at soon you meet a flag that
you don't know about, you cannot parse any further. So we're back at
what I said, we must migrate revs and diff options parsing first, and
that's a huge task.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHYPuGvGr7W6HudhwRAroDAJ9zcoO58KbbO1UPisYqf7fhauJcigCdE47T
2TV3mjuaDiTj67nEHw2ghZ8=
=CINN
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
