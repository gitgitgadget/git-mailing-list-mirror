From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: A tour of git: the basics (and notes on some unfriendly messages)
Date: Sun, 30 Sep 2007 15:49:37 +0200
Message-ID: <20070930134937.GG22560@artemis.corp>
References: <87ir5us82a.wl%cworth@cworth.org> <20070929000056.GZ3099@spearce.org> <20070929090121.GA4216@artemis.corp> <912CB4AE-83B9-42D7-A591-E721D1E22439@wincent.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Zrag5V6pnZGjLKiw";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Sep 30 15:49:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbzBB-00025q-7L
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 15:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755615AbXI3Ntl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 09:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755493AbXI3Ntl
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 09:49:41 -0400
Received: from pan.madism.org ([88.191.52.104]:38036 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755476AbXI3Ntl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 09:49:41 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 5E7A61F208;
	Sun, 30 Sep 2007 15:49:39 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 2AFE32ACBB0; Sun, 30 Sep 2007 15:49:38 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Wincent Colaiuta <win@wincent.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <912CB4AE-83B9-42D7-A591-E721D1E22439@wincent.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59541>


--Zrag5V6pnZGjLKiw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 30, 2007 at 12:45:34PM +0000, Wincent Colaiuta wrote:
> El 29/9/2007, a las 11:01, Pierre Habouzit escribi=C3=B3:
>=20
> >  Many git commands output are still messy and indeed, having them in C
> >should help in that regard. The usual culprit are I think:
> >
> >  * git fetch/clone/pull/.. ;
> >  * git push ;
> >  * git repack/gc/... ;
> >  * git merge (even with the merge.verbosity set to the minimum it's
> >    still not very readable and confusing).
> >
> >
> >  I do believe that the quite verbose output git commands sometimes have
> >is quite confusing, and let the user think it's messy. I believe that
> >porcelains should be more silent, it's OK for the plumbing to spit
> >progress messages and so on, because people using the plumbing are able
> >to understand those, but porcelains should not.
>=20
> I think that most people just want to know, "Did it work or not?" and so=
=20
> when the commands chatter too much they go into filter mode, don't really=
=20
> read the output, let alone try to understand it, and just skim it.=20
> Ideally Git would be much less "chattery" in general when things work,=20
> and only be more verbose when things go wrong; of course, finding that=20
> balance point is where the art lies.

  That's true for git merge that is fast. But people also want to know
the command is not stuck in an infinite loop, and for that progress bars
or little \|/- animation.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Zrag5V6pnZGjLKiw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/6lxvGr7W6HudhwRAu8RAJ9ah0lIfi1GflrXFW9I6AqrI9MfFgCeJLNn
WIW2+TYzIYpC085WKyFTcYU=
=fhZE
-----END PGP SIGNATURE-----

--Zrag5V6pnZGjLKiw--
