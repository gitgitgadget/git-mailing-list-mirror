From: Sebastian Harl <sh@tokkee.org>
Subject: Re: git.or.cz IPv6
Date: Mon, 14 May 2007 14:45:20 +0200
Message-ID: <20070514124518.GO18965@albany.tokkee.org>
References: <20070513094054.GB18546@cip.informatik.uni-erlangen.de> <20070514005410.GG4489@pasky.or.cz> <20070514054232.GD17207@cip.informatik.uni-erlangen.de> <1179144251.9637.6.camel@lt21223.campus.dmacc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/TUrtqMIkCP4YtJm"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 15:06:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnaFt-0007ph-Jd
	for gcvg-git@gmane.org; Mon, 14 May 2007 15:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbXENNGT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 09:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753278AbXENNGT
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 09:06:19 -0400
Received: from mail.tokkee.org ([212.114.247.92]:36566 "EHLO albany.tokkee.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751906AbXENNGT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 09:06:19 -0400
X-Greylist: delayed 1257 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 May 2007 09:06:18 EDT
Received: by albany.tokkee.org (Postfix, from userid 1000)
	id C6B50364001; Mon, 14 May 2007 14:45:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1179144251.9637.6.camel@lt21223.campus.dmacc.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47238>


--/TUrtqMIkCP4YtJm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 14, 2007 at 07:04:11AM -0500, Jeffrey C. Ollie wrote:
> On Mon, 2007-05-14 at 07:42 +0200, Thomas Glanzmann wrote:
> > (faui01) [~] traceroute6 git.or.cz
> > traceroute to rover.or.cz (2a01:b0:0:2::) from 2001:638:a00:1e:209:3dff=
:fe10:85e5, 30 hops max, 16 byte packets
> > [...]
> > 15  so-0-0-0.ham10.ip6.tiscali.net (2001:668:0:2::101)  37.727 ms  37.3=
19 ms  37.488 ms
> > 16  * * *
> > 17  * * *
> > 18  * * *
>=20
> > (thinkpad) [~] traceroute6 git.or.cz
> > traceroute to rover.or.cz (2a01:b0:0:2::) from 2001:a60:f027:dead:213:2=
ff:fe7b:d860, 30 hops max, 16 byte packets
> > [...]
> > 19  so-0-0-0.ham10.ip6.tiscali.net (2001:668:0:2::101)  58.853 ms  60.3=
17 ms  59.325 ms
> > 20  * *
>=20
> > (stargate) [~] traceroute6 git.or.cz
> > traceroute to rover.or.cz (2a01:b0:0:2::) from 2001:4b88:103a::1, 30 ho=
ps max, 16 byte packets
> > [...]
> > 12  so-0-0-0.ham10.ip6.tiscali.net (2001:668:0:2::101)  41.131 ms  42.7=
67 ms  42.101 ms
>=20
> I see a similar problem from my Hurricane Electric tunnel:
>=20
> # traceroute6 git.or.cz
> traceroute to git.or.cz (2a01:b0:0:2::), 30 hops max, 40 byte packets
>  1  ambience.tunnel.tserv2.fmt.ipv6.he.net (2001:470:1f01:ffff::130)  110=
=2E910 ms  110.729 ms  110.611 ms
>  2  2001:470:1fff:2::26 (2001:470:1fff:2::26)  110.505 ms  110.404 ms  11=
0.273 ms
>  3  2001:470:0:9::2 (2001:470:0:9::2)  121.185 ms  121.044 ms  120.939 ms
>  4  2001:470:1fff:1::1 (2001:470:1fff:1::1)  195.496 ms  195.321 ms  195.=
213 ms
>  5   (2001:458:26:2::200)  206.184 ms  206.110 ms *
>  6  * ge-1-0-0.nyc10.ip6.tiscali.net (2001:504:1::a500:3257:1)  189.877 m=
s  189.688 ms
>  7  so-1-1-3.nyc33.ip6.tiscali.net (2001:668:0:2::330)  189.582 ms  189.4=
97 ms  200.172 ms
>  8  so-2-1-0.lon11.ip6.tiscali.net (2001:668:0:2::1:61)  266.841 ms  257.=
321 ms  257.144 ms
>  9  so-7-0-0.lon11.ip6.tiscali.net (2001:668:0:2::1:332)  257.036 ms  253=
=2E481 ms so-0-1-0.lon11.ip6.tiscali.net (2001:668:0:2::1:322)  264.383 ms
> 10  so-1-0-0.dus11.ip6.tiscali.net (2001:668:0:2::1:32)  278.012 ms *  26=
8.019 ms
> 11  so-0-0-0.ham10.ip6.tiscali.net (2001:668:0:2::101)  278.754 ms  278.6=
14 ms  278.478 ms
> 12  * * *

It works fine for me - might be fixed by now:

traceroute to rover.or.cz (2a01:b0:0:2::) from 2001:780:106::f1, 30 hops ma=
x, 1s
[...]
 5  so-1-0-0.fra40.ip6.tiscali.net (2001:668:0:2::4b0)  4.971 ms  4.962 ms =
 4.9s 6  so-0-0-0.dus11.ip6.tiscali.net (2001:668:0:2::1:1)  8.468 ms  8.45=
 ms  8.55s
 7  so-0-0-0.ham10.ip6.tiscali.net (2001:668:0:2::101)  13.964 ms  13.683 m=
s  1s
 8  rover.xs26.eu (2a01:b0:0:2::)  37.079 ms  37.146 ms  37.145 ms

Cheers,
Sebastian

--=20
Sebastian "tokkee" Harl
GnuPG-ID: 0x8501C7FC
http://tokkee.org/


--/TUrtqMIkCP4YtJm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGSFneEFEKc4UBx/wRAqOMAJ4jSOQhLX4VAfrZul4CyfobeyLxjgCdFDti
jCHgAAiZTYZ3eWyit4ngUlA=
=O7FH
-----END PGP SIGNATURE-----

--/TUrtqMIkCP4YtJm--
