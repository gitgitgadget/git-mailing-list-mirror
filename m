From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Documentation typo.
Date: Thu, 7 Jun 2007 00:18:06 +0200
Message-ID: <20070606221806.GA23830@artemis>
References: <11810823561507-git-send-email-madcoder@debian.org> <7v4plkzsuj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="lrZ03NoBR/3+SXJZ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 00:18:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw3pW-0003wA-EJ
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 00:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934830AbXFFWSL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 18:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935124AbXFFWSL
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 18:18:11 -0400
Received: from pan.madism.org ([88.191.52.104]:59691 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934830AbXFFWSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 18:18:09 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A7EA1842A;
	Thu,  7 Jun 2007 00:18:07 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id BA62737E2; Thu,  7 Jun 2007 00:18:06 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v4plkzsuj.fsf@assigned-by-dhcp.cox.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49327>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2007 at 02:16:36PM -0700, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > From: Pierre Habouzit <pierre.habouzit@m4x.org>
> >
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >  Documentation/pull-fetch-param.txt |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fe=
tch-param.txt
> > index 8d4e950..5bcdbc8 100644
> > --- a/Documentation/pull-fetch-param.txt
> > +++ b/Documentation/pull-fetch-param.txt
> > @@ -4,7 +4,7 @@
> > =20
> >  <refspec>::
> >  	The canonical format of a <refspec> parameter is
> > -	`+?<src>:<dst>`; that is, an optional plus `+`, followed
> > +	`\+?<src>:<dst>`; that is, an optional plus `+`, followed
> >  	by the source ref, followed by a colon `:`, followed by
> >  	the destination ref.
> >  +
>=20
> Not really.  I suspect you are using AsciiDoc 8?

  indeed ...

> Your patch does make AsciiDoc 8 keep '+' in the HTML output, but
> manual page output gets an extra backslash, so it is not really
> an improvement.

  Not for me, using asciidoc 8.2.1 on debian. It was because the manpage
was missing a '+' that I actually wrote this patch, as it was really
akward.

> Unfortunately our documentation pages were written with AsciiDoc
> 7, and are not AsciiDoc 8 compatible.
>=20
> With -aasciidoc7compatible, AsciiDoc 8 is _supposed_ to behave
> compatibly, but in reality it does not format our documentation
> correctly.  It certainly is possible that AsciiDoc 7 "happens to
> work" with our documentation pages, and maybe the way we abuse
> mark-ups can be argued the bug in _our_ documentation, but
> nobody on our end worked on finding a satisfactory solution to
> make our documentation format correctly with _both_ versions of
> AsciiDoc yet.
>=20
> I wrote about the differences between AsciiDoc 7, and AsciiDoc 8
> with the "compatiblity" I found a few weeks ago on this list;
> the most problematic was that 'asciidoc -aasciidoc7compatible'
> loses carets in our description where they matter X-<.  The list
> archive may know more about the details,

  Okay, I see, sorry for the noise then.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGZzKevGr7W6HudhwRAvoqAJsESBym/9wurlBxnf2awf+9cR5GTwCfRgc2
YZpAussXXPiyLuDxViscbJI=
=yaN1
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
