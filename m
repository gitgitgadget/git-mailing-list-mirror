From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 10:51:58 +0200
Message-ID: <20070905085158.GC31750@artemis.corp>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <7vsl5tk1r8.fsf@gitster.siamese.dyndns.org> <200709051013.39910.johan@herland.net> <vpqtzq91p5z.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="dkEUBIird37B8yKS";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Sep 05 10:52:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISqcO-00067D-GQ
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 10:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756096AbXIEIwE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 04:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756086AbXIEIwE
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 04:52:04 -0400
Received: from pan.madism.org ([88.191.52.104]:57367 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756067AbXIEIwB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 04:52:01 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 22F191DAF1;
	Wed,  5 Sep 2007 10:51:59 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id A39293244E8; Wed,  5 Sep 2007 10:51:58 +0200 (CEST)
Mail-Followup-To: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <vpqtzq91p5z.fsf@bauges.imag.fr>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57692>


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2007 at 08:39:52AM +0000, Matthieu Moy wrote:
> Johan Herland <johan@herland.net> writes:
>=20
> > When git-fetch and git-commit has done its job and is about to exit, it=
 checks=20
> > the number of loose object, and if too high tells the user something=20
> > like "There are too many loose objects in the repo, do you want me to r=
epack?=20
> > (y/N)". If the user answers "n" or simply <Enter>,
>=20
> I don't like commands to be interactive if they don't _need_ to be so.
> It kills scripting, it makes it hard for a front-end (git gui or so)
> to use the command, ...

  There is absolutely no problem here, as it can be avoided if the
output is not a tty. It's not _that_ hard to guess if you're currently
running in a script or in an interactive shell after all.

  Really, git commit/fetch/... whatever suggesting to repack/gc when it
believes it begins to be critical to performance is not a bad idea.
Though the risk is that the warning could be printed very often, but
that can be avoided trivially by just writing to a state file in the
=2Egit directory that the warning was printed not so long time ago, and
that git should STFU for some more commits/time.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG3m4uvGr7W6HudhwRAgcdAJ490DcVwtKEEtS7g2waIc2U/OFbOwCfTWsB
7EH1vA8Nt3fgveiCromEQ4A=
=ejrp
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
