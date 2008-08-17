From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Install on opensolaris 2008.05
Date: Sun, 17 Aug 2008 22:52:40 +0200
Message-ID: <20080817205240.GC17148@artemis>
References: <7a675f570808170555ie640c86jb5561cc6f7b68c73@mail.gmail.com> <20080817200321.GA17785@sigill.intra.peff.net> <1DC600E8-5D3A-44F7-994E-2B46254F192C@fuzzymagic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Qbvjkv9qwOGw/5Fx";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Sean Brandt <sean@fuzzymagic.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 23:03:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUpP5-0006Ec-8l
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 23:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbYHQUwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbYHQUwn
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:52:43 -0400
Received: from pan.madism.org ([88.191.52.104]:47251 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661AbYHQUwn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:52:43 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 6C3083F7AD;
	Sun, 17 Aug 2008 22:52:41 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 7B23A5B98EE; Sun, 17 Aug 2008 22:52:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1DC600E8-5D3A-44F7-994E-2B46254F192C@fuzzymagic.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92665>


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2008 at 08:50:13PM +0000, Sean Brandt wrote:
> Ahh, looks like it's a grep problem, thanks. opensolaris grep doesn't=20
> like the options in the test.
>=20
> By default it provides ggrep (gnu grep ) which does have the appropriate=
=20
> options.
>=20
> After making some changes so that the right grep is available ( moving=20
> the old one out of the way and symlinking ggrep in place ) the tests=20
> proceed past the original point to here:
>=20
[...]
> * FAIL 2: write-tree should notice unwritable repository
[...]
> gmake[1]: *** [t0004-unwritable.sh] Error 1
> gmake[1]: Leaving directory `/root/git-1.5.6.5/t'
                                ^^^^

  Do not run the test-suite as root ?

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkioj5gACgkQvGr7W6Hudhw3rACfZXNxzgtAk6ylmFT8Y5t/Fy+v
Pz4An06ivAZBiIVhl4p5ztXnP/yQIQSt
=ZNGF
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
