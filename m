From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: Re: [PATCH] rev-parse doc: clarify use of optional / required
 arguments
Date: Tue, 15 Oct 2013 12:49:45 +0200
Message-ID: <20131015104945.GW4589@mars-attacks.org>
References: <1381760611-9573-1-git-send-email-boklm@mars-attacks.org>
 <20131014143632.GD21200@google.com>
 <20131014152529.GU4589@mars-attacks.org>
 <20131014235742.GF865149@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4YatIo8qwOC8yTX3"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 12:49:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW2CH-0002CH-5i
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 12:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757851Ab3JOKtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 06:49:49 -0400
Received: from mx0.mars-attacks.org ([92.243.25.60]:35595 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362Ab3JOKts (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 06:49:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id CC5A047B6;
	Tue, 15 Oct 2013 12:50:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id QcL8ZUd0mdhg; Tue, 15 Oct 2013 12:50:00 +0200 (CEST)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 2B9DD3ECC;
	Tue, 15 Oct 2013 12:50:00 +0200 (CEST)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 4C86643920; Tue, 15 Oct 2013 12:49:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20131014235742.GF865149@vauxhall.crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236176>


--4YatIo8qwOC8yTX3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Oct 2013, brian m. carlson wrote:

> On Mon, Oct 14, 2013 at 05:25:29PM +0200, Nicolas Vigier wrote:
> > The reason that I looked at this documentation in the first place was
> > that I was looking at adding an option '-S[<keyid>], --gpg-sign[=3D<key=
id>]'
> > to git-rebase, similar to the option in git-commit, so that rebased
> > commits can be signed. In git-commit this option takes an optional argu=
ment,
> > so I think it would make sense to make it optional in git-rebase too.
>=20
> It's funny you say that, because I literally started on that yesterday.
> I have cherry-pick and revert working, but I haven't gotten to anything
> else yet.  Feel free to work on it if you're interested, as I probably
> won't get around to finishing it for some time.

I have a patch for git-am working, but with a small problem : it has to
assume that the optional argument to -S does not start with a dash.
This is because git-rev-parse --parseopt does not allow us to see the
difference between -S-q and -S -q, we don't know if -q is the next
option or the argument to -S.

Maybe that's the reason why the use of optional argument options with
git rev-parse --parseopt is discouraged ?

I'm going to send a patch proposal so that rev-parse --parseopt gives an
empty argument for an unset optional argument.


--4YatIo8qwOC8yTX3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBAgAGBQJSXR3JAAoJECBnABsbZ4pj6fcP/iY+0ai7g5l22nw1wlMnNpsT
rvtxAxY10cIrMHiD28iTjspFXpSrmZq2j3umyfBA15CPXZGz/SPREmdeqVeZQEVk
f2IEEslSIT0/DTGFH0MzaN1MDU5qyYJOhv7CCFh3dFGf0WkIlgDtG2MuLXCUbbgL
bh1/tHrqsgR3aVuU7Yn0l3jEj0BbmU4aRkcTycShNbt/obDi+BVR7Y3SV7uhMB1J
m9sPBiGvwF89YXiKV0GbgWHOEJD8kP5MkAjE7cSe2bl1Ad5ockl0zNnsLO+paD4+
DnQ4+fK94CpvjWA/We/pn8W9+YAt4G6XQLFqfq8tIeTHNqxH0Apj7Eas3uoqnMF9
0anaXUH9qLkoWhevqUCX6WwlfaOXth5f4e64B9LU4bOjPnso6vJyz35LrX2TKxar
FvuV6odDawLBHbgcU6WrurbbIeAxAVcClFfqVqpGZXyRwqMESZCEx+QwVX9IOrFO
Y7OoCpDs3lP1jKcb3MVLqGGfzOXW7LUjvZ607RSgbhGOu+KgRFg6ANiUNrkXPSsq
2zIYGJmeerRKBH13RwaCtDc0vA/STh6mDo6rf2G5p0z6zZ1WmdwShSeo9m6eynMH
xq+5+t2uTKgEf0fj6FTKo4bNluL1mornyKvrrRQKpr7xDiy4g1vS+mOAxham9PHN
vMD9e3Q0XCW9FJzhVl7d
=BDsE
-----END PGP SIGNATURE-----

--4YatIo8qwOC8yTX3--
