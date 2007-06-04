From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Tue, 5 Jun 2007 00:25:05 +0200
Message-ID: <20070604222505.GC13902@artemis>
References: <20070603114843.GA14336@artemis> <878xb19ot5.fsf@graviton.dyn.troilus.org> <20070603133109.GD14336@artemis> <200706031548.30111.johan@herland.net> <20070603151921.GB30347@artemis> <20070604220308.GJ6992@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="0lnxQi9hkpPO77W3";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Poole <mdpoole@troilus.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 00:25:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvKzN-0001yN-QY
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 00:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbXFDWZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 18:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755094AbXFDWZJ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 18:25:09 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:52454 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754919AbXFDWZI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 18:25:08 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 4C6FE18790;
	Tue,  5 Jun 2007 00:25:06 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 147FCA54; Tue,  5 Jun 2007 00:25:06 +0200 (CEST)
Mail-Followup-To: Yann Dirson <ydirson@altern.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Poole <mdpoole@troilus.org>
Content-Disposition: inline
In-Reply-To: <20070604220308.GJ6992@nan92-1-81-57-214-146.fbx.proxad.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49135>


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2007 at 12:03:08AM +0200, Yann Dirson wrote:
> Another aspect that I have not seen discussed yet is the handling of
> testcases that expose a bug, and which are usually integrated as
> non-reg tests afterwards.

  Well IMHO testcases are to be dealt with from the build sytem, and
versionned in the SCM. You may want to have some kind of helper doing
the bisect automatically for you (though, speaking of experience, it's
not always _that_ simple because of broken commits that do not build
e.g.) But I hardly see how it can be realted to a BTS anyways. I mean,
bugs will likely have test cases to exhibit the bug, but those should be
put in the test-case part of the repository. I mean well, maybe there is
fancy things to do, but I don't think it should be the role of a BTS at
all.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGZJFBvGr7W6HudhwRAoowAJ9bupDDCr/hDr13QLgIEujJEbDbEgCfcc0d
3nHFZZ86cbCw9vxYFU0oRYM=
=XAN/
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
