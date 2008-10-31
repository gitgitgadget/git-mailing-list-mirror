From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 22:31:14 +0100
Message-ID: <20081031213114.GA21799@artemis.corp>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="HcAYCG3uE/tztfnV";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 22:32:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw1bb-0006Ve-0b
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 22:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbYJaVbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 17:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752442AbYJaVbS
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 17:31:18 -0400
Received: from pan.madism.org ([88.191.52.104]:42283 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384AbYJaVbS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 17:31:18 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id F0DF73B708;
	Fri, 31 Oct 2008 22:31:15 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 92C8F5EE243; Fri, 31 Oct 2008 22:31:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810311558540.13034@xanadu.home>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99645>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2008 at 08:24:14PM +0000, Nicolas Pitre wrote:
> On Fri, 31 Oct 2008, Pierre Habouzit wrote:
>=20
> > Last but not least, I believe parts of git-core are currently easy to
> > just take. For example, any code *I* wrote, I hereby give permission to
> > relicense it in any of the following licenses: BSD-like, MIT-like,
> > WTFPL.
>=20
> First........... is there really a need to re-license it?
> If so then the choice of license is IMHO rather important.

Hmm yeah, GPL has the viral link issue, and there is a real use of
embedding the libgit in many projects. There is a use for it: front-ends
to git from editors, for closed-source projects of various sorts, ...
All of those right now must do a reimplementation of what they need. As
soon as they need some kind of performance, exec()ing git-* commands
doesn't fly.

Git is currently mostly "GPLv2 or later". A BSDish license was
mentioned, because it's the most permissive one and that nobody cared
that much, though a LGPL/GPL-with-GCC-exception would probably fly.

Many of the people needing a library for libgit are probably reading the
list, I'll let them comment. The kind of license you propose would
totally suite my needs, and I think, most of the one discussed at
GitTogether'08 (except for the eclipse people disliking GPL'ed stuff,
but anyways there was the issue of C code being non pure java anyways,
so maybe Shawn can comment on that bit, I don't recall the exact
specifics I must reckon).


OT: FWIW I prefer BSDish licenses (even the MIT actually) for libraries
because I believe that computing is overall better if everyone can use
the right tool for the task, and I don't want to prevent people from
using good stuff (I hope I write good stuff ;P) because of the license.
And I don't care about people don't giving back to me, those are not the
kind of people who would have given back if it was GPL'ed anyways.

But I understand this is a completely personal view, and I'm not even
trying to persuade you :)
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkLeSIACgkQvGr7W6Hudhw3MQCcC3uZcmImKz8bQ66DBKyyE1Fg
qNkAnR5J+t2eKiXNL+gPpdAFw88xzUnQ
=RFTU
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
