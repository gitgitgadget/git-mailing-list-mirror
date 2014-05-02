From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v6 5/7] pull: add merge-ff-only option
Date: Fri, 2 May 2014 07:57:55 -0700
Message-ID: <20140502145755.GG28634@odin.tremily.us>
References: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
 <1398988808-29678-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bFsKbPszpzYNtEU6"
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 16:58:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgEub-0007pk-DJ
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 16:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbaEBO6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 10:58:00 -0400
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:52589
	"EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752545AbaEBO57 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 10:57:59 -0400
Received: from omta12.westchester.pa.mail.comcast.net ([76.96.62.44])
	by qmta04.westchester.pa.mail.comcast.net with comcast
	id x0jD1n0020xGWP8542xyXd; Fri, 02 May 2014 14:57:58 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta12.westchester.pa.mail.comcast.net with comcast
	id x2xw1n00A152l3L3Y2xxhx; Fri, 02 May 2014 14:57:58 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 46F721174121; Fri,  2 May 2014 07:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1399042675; bh=Nmji4wMva6wxcynbwN6jjTuzIDfiFXrYiuEUnRFz/6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OScYsxGQd42BT/wo0PV1CkTin3v/NH6tCS8TB9aJTljR+rBF8tnf5s63qD0txYdPa
	 v8zfZCaqiCSMWi1q9d8GJhTLdgbi81GKL9lx1kyNqEbZ4GsrVpDDW2W3Qs8IjPWSd4
	 gtkVto+oyXAVFSe+uOOnpu7Xc6g8xq+OnzYvrBQc=
Content-Disposition: inline
In-Reply-To: <1398988808-29678-6-git-send-email-felipe.contreras@gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1399042678;
	bh=Nmji4wMva6wxcynbwN6jjTuzIDfiFXrYiuEUnRFz/6I=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=fZxugykzMGXA1s+8NWXN/2r+QGv1+b016wRSADteYT0qwGhupnBzLPRwlHH+IqTG5
	 1bCvGuhchD5mkQ/cMs7bQp2wkH5rFoAtgVuLj4kPBQxcQk62xtBIq0Nz6hl4uaL3rg
	 Yx1art5RSpyqAz0Jo/6FKLBpRtly9cnEpUPGvtuKb1Ej551tvXMZBRtI20mySV+vXq
	 MCg9R1gIZ6lhyesWUmnrLzeSFCxUtO8FtvE+OEg5aYhOsjnXMqOEW4LzZX3wA+20Th
	 sdyBLZsQbsIM9DIytXPhI+LkZmCVwKzoX8WO79jZ5WOhVvA3v/vw4PZfJ+n4jxFiQu
	 L9d32rsmQSRgg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247938>


--bFsKbPszpzYNtEU6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2014 at 07:00:06PM -0500, Felipe Contreras wrote:
> It is very typical for Git newcomers to inadvertently create merges and
> worst; inadvertently pushing them. This is one of the reasons many
> experienced users prefer to avoid 'git pull', and recommend newcomers to
> avoid it as well.
>=20
> To avoid these problems and keep 'git pull' useful, it has been
> suggested that 'git pull' barfs by default if the merge is
> non-fast-forward, which unfortunately would break backwards
> compatibility.
>=20
> This patch leaves everything in place to enable this new mode, but it
> only gets enabled if the user specifically configures it; pull.mode =3D
> merge-ff-only.

The subject and commit message also need =E2=80=9Cmerge-ff-only=E2=80=9D =
=E2=86=92 =E2=80=9Cff-only=E2=80=9D.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--bFsKbPszpzYNtEU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTY7JwAAoJEKKfehoaNkbtGJUP/jA58UMP63fO+iphkidGGDxP
zNgDTiO3mUXhBvT66a9Sba1UPJQK5bRJPj7+t6P5a48/YR/CmYrDbQPX+8U0DC1S
GytcbC/p3o2ZAvAvdMUSw1YZhOnGDbxn9Um78jN8sFFpZVSl6uN66GmNMp1xh5xS
FbgInm2yx3VUVxKa04I78K0e3TOI1sQYLx4SZEfWA4UhHUJnr1hCe09LfOAx/tMN
+3ZsMPShQBP03PPsUCxS14DHIl79WZ+YHoPAd08ZewVrW4TLnR4LuxTy4+A6s8t0
/9/VK69/uJ6CmQhaqtRAhqn4jXVVOINYr265hduDlF5B72fh1/WFyehENa9YzcYy
2Mbw2mk1sM4eqdrxEhc8VO/VzmyDMP36vpGBBJZ/mcAkYtj6CwKeMSOUMoKA4KFT
wFnt0cTsXvF8ncadXQMmcawuHqjfIf80aJ4VRrEm1cQ+4fB7Tbi9OyV4sMsaQFzH
qijN4WvynvzEECMvgigtNataQm3UWR+b+hbyAjrmIVp2C56GTA6JrNitRwAk+2X7
WsmKX49LD/WUxIaxR/Pc7II5O2cIoOcLMJ3ev+yf0m1uCpPSMuMRxhxnfuXhzJRG
wDEY16TrupcXgz/pXzozRdMXps4YDGLVg6v5tGTJLCpoF8lZKm4jJKlTDXXhzNLB
/5w4ieA0lRubkcMC68M1
=rWjy
-----END PGP SIGNATURE-----

--bFsKbPszpzYNtEU6--
