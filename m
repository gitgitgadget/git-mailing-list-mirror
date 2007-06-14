From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Add a guilt-export(1) command to export a guilt series to quilt.
Date: Thu, 14 Jun 2007 12:38:32 +0200
Message-ID: <20070614103832.GA23324@artemis>
References: <1181743313509-git-send-email-madcoder@debian.org> <1621f9fa0706130810n17bc3f67h1c539d75b3aed4ed@mail.gmail.com> <20070613155454.GC18989@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="lrZ03NoBR/3+SXJZ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Benjamin Sergeant <bsergean@gmail.com>, git@vger.kernel.org
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Jun 14 12:38:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hymiq-0001ZQ-Jg
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 12:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbXFNKif (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 06:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbXFNKif
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 06:38:35 -0400
Received: from pan.madism.org ([88.191.52.104]:38609 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859AbXFNKie (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 06:38:34 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 45554D991;
	Thu, 14 Jun 2007 12:38:33 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 7004092858; Thu, 14 Jun 2007 12:38:32 +0200 (CEST)
Mail-Followup-To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
	Benjamin Sergeant <bsergean@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070613155454.GC18989@filer.fsl.cs.sunysb.edu>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50188>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2007 at 11:54:54AM -0400, Josef Sipek wrote:
> On Wed, Jun 13, 2007 at 08:10:36AM -0700, Benjamin Sergeant wrote:
> > For the shebang:
> > #!/usr/bin/env bash
> > should works well and should work on non-linux boxes that did not
> > added a link in /bin/bash.
> =20
> Ideally, the best thing to do is to change guilt to use /bin/sh. Right no=
w,
> there are a number of bash-isms that are used. And if a system doesn't ha=
ve
> /bin/sh, it doesn't deserve to run any useful software ;)
>=20
> Patches are welcomed ;)

  Makes sense. I'm currently working on it (so that nobody loses time on
that issue).

  I'm mostly done with guilt(1), I still need to take some "local"
variables down (especially in guilt_push or whatever the function name
is). Most of the rest has been dealt with already.


  I should send a patch serie towards POSIX-shell-isation soon, as soon
as I've tested the patches with bash, zsh, dash and posh.

  Cheers,
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

iD8DBQBGcRqovGr7W6HudhwRAsnDAJwM849IpglV/KiaXPSL4q8/exUeOgCfQPIB
oJwf6dfwvBY+4zneSDfPw/M=
=33gN
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
