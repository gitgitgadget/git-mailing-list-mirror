From: Joey Hess <joey@kitenet.net>
Subject: Re: speed of git reset -- file
Date: Wed, 1 Jun 2011 19:31:57 -0400
Message-ID: <20110601233157.GA2468@gnu.kitenet.net>
References: <20110531190015.GA12113@gnu.kitenet.net>
 <20110531212639.GA13234@sigill.intra.peff.net>
 <7v62oqignm.fsf@alter.siamese.dyndns.org>
 <20110601195831.GA30070@sigill.intra.peff.net>
 <20110601201629.GA25354@gnu.kitenet.net>
 <20110601211847.GA31958@sigill.intra.peff.net>
 <20110601220502.GA28493@gnu.kitenet.net>
 <20110601225647.GD16820@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 02 01:35:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRuws-0001MK-99
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 01:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759102Ab1FAXfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 19:35:30 -0400
Received: from wren.kitenet.net ([80.68.85.49]:45789 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759066Ab1FAXf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 19:35:27 -0400
Received: from gnu.kitenet.net (dialup-4.154.7.116.Dial1.Atlanta1.Level3.net [4.154.7.116])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id C00A4119014;
	Wed,  1 Jun 2011 19:35:24 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 2D15B464B9; Wed,  1 Jun 2011 19:31:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110601225647.GD16820@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174920>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> OK, that's horrific. For me, the stat information for linux-2.6 all sits
> in cache and it takes about 0.3 seconds to refresh the index. I have 8G
> of ram and a nice SSD, though it doesn't actually hit the disk at all.
>=20
> Is it really faulting the stat information from disk that takes so long?
> Have you tried running "perf" on "git update-index --refresh"?

Cold cache:

 Performance counter stats for 'git update-index --refresh':

       9725.574501 task-clock-msecs         #      0.337 CPUs=20
            58,163 context-switches         #      0.006 M/sec
                94 CPU-migrations           #      0.000 M/sec
             8,637 page-faults              #      0.001 M/sec
    12,825,956,531 cycles                   #   1318.787 M/sec  (scaled fro=
m 33.43%)
     2,696,089,912 instructions             #      0.210 IPC    (scaled fro=
m 50.03%)
       457,705,110 branches                 #     47.062 M/sec  (scaled fro=
m 51.30%)
        40,033,685 branch-misses            #      8.747 %      (scaled fro=
m 50.19%)
       149,071,234 cache-references         #     15.328 M/sec  (scaled fro=
m 32.83%)
         9,662,661 cache-misses             #      0.994 M/sec  (scaled fro=
m 32.27%)

       28.846625099  seconds time elapsed

Warm cache is 0.88 seconds, but cold cache is typical; I use a cheap netbook
for a lot of different stuff.

Also, I can get much worse cold cache numbers on eg, a fairly average
VPS node, where it takes > 1 minute.

--=20
see shy jo

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTebL5skQ2SIlEuPHAQg4rw/+LSHXTzcuh1j+CyAdqtoZ/dzqwwOzE9yZ
x+OhmFwHP/0P7vhnrofmBpm8k3SEJJjUibW7hGkMVGR0kg8l9iuV7ILRbtA1qjOH
UoTaTHr3V1KiERyL9/dEcPGo/gIFg1EScAA+k0Z+p7q7+D+xdh06lxYzPW35rguk
lR0FQDZMEgf1eF8skNKbYzrycL2pUcvI69dmAHiFdSRBOa8teuigDghbAgo8+iAX
baGujPy5O/d+7di3exF9sUvlBplnGcWJc2rxp/rc5Pf54YYAbMCBcqVyhevdiKYO
5Kg4fJJiCBt3nVdflONpKdKmTr8FlV8UecUIIA7r5a3GADkva/40kX10pon8VNdj
K/ecuOLIEV8Qpr/vITuyWzQo1RT528uYiGf4mM0IcvClntyLbjMiyKwoBvakcLl0
zM2xtqxZ6R1IAlwtdxZ2AkXxbA2dlXWc3rh1NGqXZdzCvbo7fZ4ZWxJTx6j8gfei
8+jtRK17grSlYaSWj4/8TciO8pO5GMBeqzH4dBDmpWFuoah/ExwXUCbKTlURCONE
CMiZ4wEzW+8dsm1nKpBHRh3aEsL48Q/Fh8QB2VfM4DMOaL3hmhAFTR/FPSEt0/aW
ULIlZJ060OB/o/iDiFW+XCwDNCmXLRWEZEeCLaiYJw+OmUzC1kzpp/2Uvr/N5ySy
WhpBgI3jaXs=
=dviO
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
