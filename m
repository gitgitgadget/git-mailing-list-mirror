From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH guilt] make guilt use standard POSIX shell
Date: Thu, 14 Jun 2007 17:56:00 +0200
Message-ID: <20070614155600.GM23324@artemis>
References: <11818254621527-git-send-email-madcoder@debian.org> <20070614152702.GC934@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="WuedheRyq6FDfQ9j";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Josef Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Jun 14 17:56:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyrgD-0000Hf-T5
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 17:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbXFNP4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 11:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbXFNP4E
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 11:56:04 -0400
Received: from pan.madism.org ([88.191.52.104]:52551 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbXFNP4D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 11:56:03 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2ACB0DB16;
	Thu, 14 Jun 2007 17:56:01 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id CA56F1078; Thu, 14 Jun 2007 17:56:00 +0200 (CEST)
Mail-Followup-To: Josef Sipek <jsipek@cs.sunysb.edu>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070614152702.GC934@filer.fsl.cs.sunysb.edu>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50211>


--WuedheRyq6FDfQ9j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2007 at 11:27:02AM -0400, Josef Sipek wrote:
> On Thu, Jun 14, 2007 at 02:50:55PM +0200, Pierre Habouzit wrote:
> > This patch series makes guilt be able to work with a standard posix she=
ll.
> >=20
> > This has been tested with bash, zsh, dash and posh acting as /bin/sh.
> >=20
> > This uses awk and sed a bit more than before, but POSIX awk and sed sho=
uld be
> > enough. Though GNU find and GNU /bin/echo from the coreutils needs to be
> > there.
> >=20
> > Here is the shortlog:
> >=20
> > 	Pierre Habouzit (7):
> > 		  Regression test suite needs bash, that's OK.
> > 		  guilt(1): Obvious bashisms fixed.
> > 		  guilt(1): simplifications...
> > 		  guilt(1): reimplement push_patch, using a subshell to avoid locals.
> > 		  Easy commands, without bashisms.
> > 		  guilt-status(1): Remove bashisms.
> > 		  Remove last bashisms from remaining commands.
> =20
> I went though the patches, and it's mostly good (see individual patch
> replies for details). I noticed an indentation issue or two, but I can fix
> that up easily, I can take care of the quoting of `basename $0`.

  Thanks.

> The regression suite is little lacking, so I am going to put your updated
> patches onto a special branch, and test it for a while - fixing up any
> potential bugs. (I don't want to be even remotely responsible for people's
> patches turning into empty files :) )

  That seems like a very good plan. I just sent the fixes. Hopefully
this should fix major issues right now.

  Interestingly enough, benchmarking for runs with different shells as
/bin/sh show:

  dash: 1.63s user 3.93s system 102% cpu 5.436 total
  posh: 2.02s user 4.29s system 100% cpu 6.260 total
  bash: 2.82s user 5.78s system 104% cpu 8.223 total
  zsh:  3.70s user 5.86s system  99% cpu 9.626 total

  (this is obviously completely not unreliable, but gives some rough
ideas though)

> Thanks a lot!

  Well, worry for the obvious mistakes.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--WuedheRyq6FDfQ9j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGcWUQvGr7W6HudhwRAvo3AKCkDibPcFoPp4ZgEfbQ6URFTwuUhwCbBhFw
oNzJh8SWL1J0am3F6CZIslk=
=lDZ5
-----END PGP SIGNATURE-----

--WuedheRyq6FDfQ9j--
