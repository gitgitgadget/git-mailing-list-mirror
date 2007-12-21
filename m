From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-tag: fix -l switch handling regression.
Date: Fri, 21 Dec 2007 22:18:33 +0100
Message-ID: <20071221211833.GA10318@artemis.madism.org>
References: <7vwsr8lwf7.fsf@gitster.siamese.dyndns.org> <20071221104704.GC17701@artemis.madism.org> <20071221105058.GD17701@artemis.madism.org> <7vd4t0atzo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="oyUTqETQ0mS9luUI";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 22:19:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5pGs-00046E-5Z
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 22:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758729AbXLUVSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 16:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758719AbXLUVSh
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 16:18:37 -0500
Received: from pan.madism.org ([88.191.52.104]:47600 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758676AbXLUVSg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 16:18:36 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3177A20789;
	Fri, 21 Dec 2007 22:18:34 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id D12FC6A1D; Fri, 21 Dec 2007 22:18:33 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vd4t0atzo.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69094>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2007 at 04:32:43PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >
> > It seems that you didnt took that patch either, that IMHO gives a better
> > semantics to git tag -l than yours, while keeping backward
> > compatibility.
>=20
> I thought this depended on some other changes.  As is, doesn't
> it break the t7004 test?

  Well there are tests that test:

  git tag -n xxx -l ...

  or

  git tag -n "" -l ...

  but I think we agreed those test nothing legitimate, and that the
tests have to be removed. SO yes it hides another patch to cleanse t7004
=66rom the broken tests.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHbC2pvGr7W6HudhwRAhrBAKCPqcuqDIk2xSCwUDxVkJDE10ytTACfbiQO
T9zcTDeMdJijPx6j1/zyjQU=
=Skf0
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
