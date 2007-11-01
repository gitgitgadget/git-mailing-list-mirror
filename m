From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 01 Nov 2007 22:42:57 +0100
Message-ID: <20071101214257.GB7161@artemis.corp>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org> <916BE4AD-5BD9-48E6-8026-B1AC7387E28D@adacore.com> <7v4pg5btis.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="oLBj+sq0vYjzfsbl";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Geert Bosch <bosch@adacore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 22:43:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inhos-0004vg-8p
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbXKAVnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753282AbXKAVnC
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:43:02 -0400
Received: from pan.madism.org ([88.191.52.104]:47657 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771AbXKAVnA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:43:00 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8581327F93;
	Thu,  1 Nov 2007 22:42:58 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id C454B32BA04; Thu,  1 Nov 2007 22:42:57 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Geert Bosch <bosch@adacore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v4pg5btis.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63015>


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2007 at 08:27:55PM +0000, Junio C Hamano wrote:
> Geert Bosch <bosch@adacore.com> writes:
>=20
> > I often type "make clean" as well many "git xyz" commands
> > during development, and so it happens that at times, I type
> > "git clean" by accident.
>=20
> Happened to me once.  I hate that command.
>=20
> > So, I propose *not* converting git clean to a C builtin,
> > but instead adding --untracked and --ignored options to
> > git-rm.
>=20
> I think what you are trying to do is to deprecate or remove "git
> clean".
>=20
> I do not know where "git clean" came from.  I am suspecting that
> it was to give counterparts to some other SCMs, but do not know
> which ones.  Some people wanted to have it --- so you need to
> convince them that it is a bad idea first.  Adding an equivalent
> options to "git rm" alone does not solve that issue.

  FWIW I do use git clean a _lot_. I don't mind if it's doable from
another kind of command, but I do use git clean and even git clean -x a
lot, because it achives cleansing my repository faster (and sometimes
faster) than a `make distclean` would do.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHKkhhvGr7W6HudhwRAvF7AJ0bYU06IzPNKUtaeTBddOn1gUNNDwCgoGog
6inY1/35dCz+7RxNZUp4rCg=
=Pvik
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
