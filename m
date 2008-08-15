From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2] count-objects: add human-readable size option
Date: Fri, 15 Aug 2008 11:22:50 +0200
Message-ID: <20080815092249.GA6024@artemis.madism.org>
References: <1218657910-22096-1-git-send-email-marcus@griep.us> <1218687684-11671-1-git-send-email-marcus@griep.us> <20080814064524.GA4379@blimp.local> <48A43B2A.7010702@griep.us> <20080814185131.GA14858@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="x+6KMIRAuhnl3hBn";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Marcus Griep <marcus@griep.us>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 11:24:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTvXM-0008PN-6b
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 11:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbYHOJW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 05:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbYHOJW4
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 05:22:56 -0400
Received: from pan.madism.org ([88.191.52.104]:40374 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbYHOJWz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 05:22:55 -0400
Received: from madism.org (unknown [88.187.254.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 52EE95D9D;
	Fri, 15 Aug 2008 11:22:53 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 41167700A; Fri, 15 Aug 2008 11:22:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080814185131.GA14858@steel.home>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92468>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2008 at 06:51:31PM +0000, Alex Riesen wrote:
> Marcus Griep, Thu, Aug 14, 2008 16:03:22 +0200:
> > Alex Riesen wrote:
> > > GNU ls and du use "-h", with du using -H for SI units.
> >=20
> > git's parse options plays interference here and injects the usage
> > and exits if it finds the '-h' option.  Is there a way to get around
> > that?
>=20
> AFAICS - no. I'd suggest removing "-h" from the unconditionally
> reserved list of options (untested patch attached). "--help" is well
> known (which could be a reason why coreutils uses just it).

  But --help is not as terse as -h is, and it would be going backwards
not having it anymore.

> On somewhat similar note, how about be a bit _less_ user-friendly in
> the text messages? IOW, make things like "something didn't work,
> please try doing 'git something-else'" configurable (ok, active by
> default, by deactivatable). These take an awful lot of screen space.
> The builtin fetch, checkout, add (the most often used commands) are
> the chattiest. The text in commit buffer takes almost half of screen,
> too.

  We probably want to reorganize some of our options so that it's less
verbose, but FWIW I prefer the git foo -h wrt git foo --help because I
usually *know* there is an option, and git foo -h is way easier to grep
with the eye than the man page.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkilSugACgkQvGr7W6HudhxCBQCgguVhtFFCk0X9S8ox0vSoNUXT
WvQAnA6T5CelML+dkdwXXcUuCovHKdHG
=q6VO
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
