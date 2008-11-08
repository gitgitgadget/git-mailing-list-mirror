From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libgit2 - a true git library
Date: Sat, 08 Nov 2008 18:27:59 +0100
Message-ID: <20081108172759.GA31655@artemis.corp>
References: <20081031170704.GU14786@spearce.org> <4915939B.1070306@gmail.com> <4915A3CB.5010909@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="AqsLC8rIMeq19msA";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Steve =?utf-8?Q?Fr=C3=A9cinaux?= <nudrema@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Nov 08 18:29:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyrcq-0000CD-PW
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 18:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbYKHR2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 12:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753601AbYKHR2G
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 12:28:06 -0500
Received: from pan.madism.org ([88.191.52.104]:39963 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753597AbYKHR2F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 12:28:05 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id DC6383C80B;
	Sat,  8 Nov 2008 18:28:01 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 527D97D511E; Sat,  8 Nov 2008 18:27:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4915A3CB.5010909@op5.se>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100413>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 08, 2008 at 02:35:55PM +0000, Andreas Ericsson wrote:
> Steve Fr=C3=A9cinaux wrote:
> > Just a random question: is there a reason why you have put all the
> > .h in a separate includes/ directory instead of relying on the
> > install target to put the include files at the right place ?
> > To me it makes it much harder to hack on the files as one is always
> > required to switch between both directories...
>=20
> I agree with this, but as I guess Shawn will do roughly 45 times more
> work on it than me (according to current commit-count in git.git), I'll
> live with it.

I don't, modifying the public includes may break the ABI and the API.

I believe it to be a good practice to put them in a separate directory
so that people modifying them will know this particular header is
public. Yes you can name your private headers differently, but it's not
really the same, it doesn't make editing public headers hard, and it has
to. People modifying them _have_ to thing "err why am I modifying this
specific header in the first place" before doing anything in it.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkVzB0ACgkQvGr7W6Hudhwi5wCgpvzRNocRLt7bUQdfXV213Q39
chgAnjqdWA0su6wNpoBZhvuYOoImz0Ig
=tykx
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
