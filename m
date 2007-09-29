From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Big performance regression with --no-color option in git-log
Date: Sat, 29 Sep 2007 13:09:14 +0200
Message-ID: <20070929110914.GA32142@artemis.corp>
References: <e5bfff550709290302h6016c6e8mf9d5dfddce07d985@mail.gmail.com> <20070929110130.GC4216@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="yrj/dFKFPuw6o+aM";
	protocol="application/pgp-signature"; micalg=SHA1
To: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 13:09:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbaCL-0003lQ-Rc
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 13:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704AbXI2LJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 07:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754550AbXI2LJT
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 07:09:19 -0400
Received: from pan.madism.org ([88.191.52.104]:37345 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbXI2LJS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 07:09:18 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 84E0322480;
	Sat, 29 Sep 2007 13:09:14 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 33DE47BE; Sat, 29 Sep 2007 13:09:14 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070929110130.GC4216@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59460>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 29, 2007 at 11:01:30AM +0000, Pierre Habouzit wrote:
> On Sat, Sep 29, 2007 at 10:02:23AM +0000, Marco Costalba wrote:
> > On today git tree

  Okay for me it's not only from today, and the issue seems to be with
the fact that we pass options or that we don't... git log --color also
takes an awful lot of time here, whereas it's my default. Looks like
diff_opt_parse is called too many times.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/jJavGr7W6HudhwRAiTzAKCGSH4s6hllRF45hw9GsLBcbAnKFgCglwPx
3z4KvqHIAcKNeIRup+SUwOQ=
=z1Rz
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
