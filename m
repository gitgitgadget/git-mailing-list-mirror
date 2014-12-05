From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git bundle vs git rev-list
Date: Fri, 5 Dec 2014 23:13:50 +0000
Message-ID: <20141205231350.GB223328@vauxhall.crustytoothpaste.net>
References: <CAL3By--xYnXFUdDP3MDxAxvfeBT3ArFrdAV=apzdWg6_kiD2Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Cc: git@vger.kernel.org
To: Jesse Hopkins <jesse.hops@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 00:14:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx24Z-0006MB-CV
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 00:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794AbaLEXN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 18:13:59 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55047 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753618AbaLEXN6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Dec 2014 18:13:58 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 923D52808F;
	Fri,  5 Dec 2014 23:13:57 +0000 (UTC)
Mail-Followup-To: Jesse Hopkins <jesse.hops@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAL3By--xYnXFUdDP3MDxAxvfeBT3ArFrdAV=apzdWg6_kiD2Yg@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-1-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260912>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 05, 2014 at 03:36:18PM -0700, Jesse Hopkins wrote:
> 1. Any thoughts on why a tag would be included by 'git bundle', when
> 'git rev-list' with the same arguments returns empty?

I think the answer to this is found in the git rev-list manpage:

  List commits that are reachable by following the parent links from the
  given commit(s), but exclude commits that are reachable from the
  one(s) given with a ^ in front of them.

The operative word here is "commits".  A bundle might include one or
more tag objects, or unannotated tags, even though no new commits were
available within the time frame.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUgjwuAAoJEL9TXYEfUvaLDcQQAK9B+EoeC6QFpG0tKzHoUYDZ
87kKKO0v5wBdw8JRUFd9TLcE5CWuabic+HTceejJActU53ioUUXQ8ZGPuSQd9n4E
ZKYk1P6x8tewi3/5Kf1t1dsDcmDLiyOOY6RbYBK4LAWJs/QOhMvfmmCk+Dk9iYP8
Y4kw3pCPB4KRiUuKHm3UzXKUUcO4Hzy+NQ7X6bkGhCIrnI9eVuiaH7cKUQvggTY0
kpgKjemjR7wmgrD725npAgYfBgWipLm2Y4lZ8rdghLD1d0RzCFrDVNeOIzBqCRsu
NljrFZKQgXo0XXI2YorXVDwyvduaDGYRHWLPKo3irc6ctllaGFBRoewCr+riBPPl
9xXyDmfh65pFLk3rY/QSgg8mS5KeExpdctDMbwjmFMEbWZxFmMRrid3wCZprkSZJ
h+RE2ZIIFELwz8nYAEavHsF2ulqqs3wL97Wvnldc8pkEOiIsJeR082ozhngsGaYd
0/QvQPwMqssEuJ7L15RzdyWPD6rqEBuxSa3+QNhd+t/jYl6Da1BgTiyiXqidjTd9
jpv+ll/HlBbMa8AAqdTT1uIS45+eSbQzOfz+nVxl17l+Kjq2hNVa4sTLMmUbvv8M
qOIxsWuRTh0KM1i/tSPLj/1WwmMZpiNGxqUmzxcD3mcR/OfUKb/+pREm2y4NdogP
PFmwuz3t3R7TMlgwXs3S
=vH4y
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
