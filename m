From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/2] Correct some sizeof(size_t) != sizeof(unsigned long)  typing errors
Date: Sun, 21 Oct 2007 12:31:32 +0200
Message-ID: <20071021103132.GA25741@artemis.corp>
References: <20071021052537.GB31927@spearce.org> <471B1AA5.8070009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="huq684BweRXVnRxX";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Oct 21 12:31:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjY5z-0007OM-DB
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 12:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbXJUKbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 06:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbXJUKbf
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 06:31:35 -0400
Received: from pan.madism.org ([88.191.52.104]:42590 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313AbXJUKbe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 06:31:34 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 7961119E4E;
	Sun, 21 Oct 2007 12:31:33 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 550973CEDCB; Sun, 21 Oct 2007 12:31:32 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <471B1AA5.8070009@lsrfire.ath.cx>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61898>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 21, 2007 at 09:23:49AM +0000, Ren=C3=A9 Scharfe wrote:
> > Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> > ---
> >  builtin-apply.c   |    2 +-
> >  builtin-archive.c |    2 +-
> >  diff.c            |    4 ++--
> >  entry.c           |    2 +-
> >  strbuf.h          |    8 +++++++-
> >  test-delta.c      |    3 ++-
> >  6 files changed, 14 insertions(+), 7 deletions(-)
>=20
> I have a feeling this is going in then wrong direction.  Shouldn't
> we rather use size_t everywhere?  malloc() takes a size_t, and it's
> the basis of strbuf and also of the file content functions.

  I agree, Junio was working on a patch that generalized use of size_t's
when unsigned long where used and size_t meant, I suppose he didn't had
the time to push it.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--huq684BweRXVnRxX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHGyqEvGr7W6HudhwRAi62AJ9TRjWw/HgCynMyJwLto2jExiIHJgCfWh8F
WBxMpMfWTm30/772wnhADv8=
=pr9m
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
