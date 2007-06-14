From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH guilt] make guilt use standard POSIX shell
Date: Thu, 14 Jun 2007 19:16:11 +0200
Message-ID: <20070614171611.GW23324@artemis>
References: <11818254621527-git-send-email-madcoder@debian.org> <20070614152702.GC934@filer.fsl.cs.sunysb.edu> <20070614155600.GM23324@artemis> <20070614155826.GN23324@artemis> <20070614163940.GA4752@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Ln+iIw7POnzHEEo5";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Josef Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Jun 14 19:16:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hysvl-0002ru-If
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 19:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566AbXFNRQO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 13:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754579AbXFNRQN
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 13:16:13 -0400
Received: from pan.madism.org ([88.191.52.104]:54320 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754566AbXFNRQM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 13:16:12 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A8704DB73;
	Thu, 14 Jun 2007 19:16:11 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5CC9010B41; Thu, 14 Jun 2007 19:16:11 +0200 (CEST)
Mail-Followup-To: Josef Sipek <jsipek@cs.sunysb.edu>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070614163940.GA4752@filer.fsl.cs.sunysb.edu>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50215>


--Ln+iIw7POnzHEEo5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2007 at 12:39:40PM -0400, Josef Sipek wrote:
> On Thu, Jun 14, 2007 at 05:58:26PM +0200, Pierre Habouzit wrote:
> > On Thu, Jun 14, 2007 at 05:56:00PM +0200, Pierre Habouzit wrote:
> > > On Thu, Jun 14, 2007 at 11:27:02AM -0400, Josef Sipek wrote:
> > > > Thanks a lot!
> > >=20
> > >   Well, worry for the obvious mistakes.
> >          *sorry
> >=20
> >   Now, *that* was an interesting typo :P
>=20
> :)
>=20
> Ok, pushed to kernel.org. I folded the 2 regression fixing patches into t=
he
> right places.

  Just a small remark: 87739d0e should be merged in the master branch,
as the regression suite does not work atm if you are using a shell that
does not understands enough bashisms.

  The patch is safe (it only adds /bin/bash shebangs to tests, and
changes the way tests are called in the Makefile).

  For the rest, I agree the patches should continue to live in a
separate branch until better coverage of the testsuite can give us more
faith in those patches :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Ln+iIw7POnzHEEo5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGcXfbvGr7W6HudhwRAi8zAJ42m0xFg7vsZHHXVTk27gIiFdAf/QCggxG7
Qy7IFx7xERZQL25r0J4iMe8=
=wFXL
-----END PGP SIGNATURE-----

--Ln+iIw7POnzHEEo5--
