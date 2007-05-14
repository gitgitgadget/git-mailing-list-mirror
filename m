From: "Jeffrey C. Ollie" <jeff@ocjtech.us>
Subject: Re: git.or.cz IPv6
Date: Mon, 14 May 2007 07:04:11 -0500
Message-ID: <1179144251.9637.6.camel@lt21223.campus.dmacc.edu>
References: <20070513094054.GB18546@cip.informatik.uni-erlangen.de>
	 <20070514005410.GG4489@pasky.or.cz>
	 <20070514054232.GD17207@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ysO9nCxHFvcVmiji1qJn"
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 14 14:03:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnZGv-0003T9-14
	for gcvg-git@gmane.org; Mon, 14 May 2007 14:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbXENMDQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 08:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753655AbXENMDQ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 08:03:16 -0400
Received: from homer.isunet.net ([63.175.164.9]:42888 "EHLO homer.isunet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602AbXENMDP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 08:03:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by homer.isunet.net (Postfix) with ESMTP id B011D388322
	for <git@vger.kernel.org>; Mon, 14 May 2007 06:10:36 -0500 (CDT)
Received: from homer.isunet.net ([63.175.164.9])
 by localhost (homer [63.175.164.9]) (amavisd-new, port 10024) with ESMTP
 id 11653-02 for <git@vger.kernel.org>; Mon, 14 May 2007 06:10:32 -0500 (CDT)
Received: from max1.ocjtech.us (dsl-ppp239.isunet.net [63.175.164.239])
	by homer.isunet.net (Postfix) with ESMTP id EA0C538817F
	for <git@vger.kernel.org>; Mon, 14 May 2007 06:10:31 -0500 (CDT)
Received: from [172.16.0.186]
	by max1.ocjtech.us with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.62)
	(envelope-from <jeff@ocjtech.us>)
	id 1HnZGn-00009K-Op
	for git@vger.kernel.org; Mon, 14 May 2007 07:03:17 -0500
In-Reply-To: <20070514054232.GD17207@cip.informatik.uni-erlangen.de>
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
X-Virus-Scanned: by amavisd-new at isunet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47232>


--=-ysO9nCxHFvcVmiji1qJn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-05-14 at 07:42 +0200, Thomas Glanzmann wrote:
>=20
> (faui01) [~] traceroute6 git.or.cz
> traceroute to rover.or.cz (2a01:b0:0:2::) from 2001:638:a00:1e:209:3dff:f=
e10:85e5, 30 hops max, 16 byte packets
> [...]
> 15  so-0-0-0.ham10.ip6.tiscali.net (2001:668:0:2::101)  37.727 ms  37.319=
 ms  37.488 ms
> 16  * * *
> 17  * * *
> 18  * * *

> (thinkpad) [~] traceroute6 git.or.cz
> traceroute to rover.or.cz (2a01:b0:0:2::) from 2001:a60:f027:dead:213:2ff=
:fe7b:d860, 30 hops max, 16 byte packets
> [...]
> 19  so-0-0-0.ham10.ip6.tiscali.net (2001:668:0:2::101)  58.853 ms  60.317=
 ms  59.325 ms
> 20  * *

> (stargate) [~] traceroute6 git.or.cz
> traceroute to rover.or.cz (2a01:b0:0:2::) from 2001:4b88:103a::1, 30 hops=
 max, 16 byte packets
> [...]
> 12  so-0-0-0.ham10.ip6.tiscali.net (2001:668:0:2::101)  41.131 ms  42.767=
 ms  42.101 ms

I see a similar problem from my Hurricane Electric tunnel:

# traceroute6 git.or.cz
traceroute to git.or.cz (2a01:b0:0:2::), 30 hops max, 40 byte packets
 1  ambience.tunnel.tserv2.fmt.ipv6.he.net (2001:470:1f01:ffff::130)  110.9=
10 ms  110.729 ms  110.611 ms
 2  2001:470:1fff:2::26 (2001:470:1fff:2::26)  110.505 ms  110.404 ms  110.=
273 ms
 3  2001:470:0:9::2 (2001:470:0:9::2)  121.185 ms  121.044 ms  120.939 ms
 4  2001:470:1fff:1::1 (2001:470:1fff:1::1)  195.496 ms  195.321 ms  195.21=
3 ms
 5   (2001:458:26:2::200)  206.184 ms  206.110 ms *
 6  * ge-1-0-0.nyc10.ip6.tiscali.net (2001:504:1::a500:3257:1)  189.877 ms =
 189.688 ms
 7  so-1-1-3.nyc33.ip6.tiscali.net (2001:668:0:2::330)  189.582 ms  189.497=
 ms  200.172 ms
 8  so-2-1-0.lon11.ip6.tiscali.net (2001:668:0:2::1:61)  266.841 ms  257.32=
1 ms  257.144 ms
 9  so-7-0-0.lon11.ip6.tiscali.net (2001:668:0:2::1:332)  257.036 ms  253.4=
81 ms so-0-1-0.lon11.ip6.tiscali.net (2001:668:0:2::1:322)  264.383 ms
10  so-1-0-0.dus11.ip6.tiscali.net (2001:668:0:2::1:32)  278.012 ms *  268.=
019 ms
11  so-0-0-0.ham10.ip6.tiscali.net (2001:668:0:2::101)  278.754 ms  278.614=
 ms  278.478 ms
12  * * *
13  * * *
14  * * *


--=-ysO9nCxHFvcVmiji1qJn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGSFAyrtk7xyyIQRERAr4WAJ9+jP/Q6qWAUGOdk6DZrB7QImkiAwCfUs0k
CiR33SEvrsXeCUCMDrgu7gk=
=8Olm
-----END PGP SIGNATURE-----

--=-ysO9nCxHFvcVmiji1qJn--
