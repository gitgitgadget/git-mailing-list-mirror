From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Fix dependencies of parse-options test program
Date: Wed, 14 Nov 2007 01:08:33 +0100
Message-ID: <20071114000833.GC22836@artemis.corp>
References: <20071113231636.GJ3268@steel.home> <Pine.LNX.4.64.0711132345310.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="z4+8/lEcDcG5Ke9S";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 14 01:09:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is5ou-0003h5-EV
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 01:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759507AbXKNAIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 19:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759357AbXKNAIg
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 19:08:36 -0500
Received: from pan.madism.org ([88.191.52.104]:35133 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759507AbXKNAIf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 19:08:35 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 340BA2A14C;
	Wed, 14 Nov 2007 01:08:33 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 2931F43BCF3; Wed, 14 Nov 2007 01:08:33 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711132345310.4362@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64923>


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2007 at 11:46:20PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> apparently I forgot to send this patch, which I thought was only relevant=
=20
> in the builtin-commit branch of mine:

  Btw is there a reason why git doesn't use the gcc -M* options to have
proper dependency informations ? I understand not everyone has a gcc
compiler at hand, but still, most of the compilers know how to do that.
We could even borough depcomp from automake for that task.

  I've been bitten by dependencies issues in git many times, and it's
only now that I understand that it was dependency issues, I always
assumed git Makefiles dealt with that already, and I believe that'd be
nice to have a real solution for that.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHOjyBvGr7W6HudhwRAtQqAJsF0M6p4udTm0WLlbmBl+QYbDYSWgCfT5u6
ET66dqYZhhRVNw1ldyPovJ4=
=JVKL
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
