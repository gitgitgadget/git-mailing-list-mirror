From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Thu, 8 Jan 2015 00:02:17 +0000
Message-ID: <20150108000216.GH1025060@vauxhall.crustytoothpaste.net>
References: <1419652893-477694-1-git-send-email-sandals@crustytoothpaste.net>
 <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
 <F91CD1B2-262C-4ED6-AE46-31B1333E0350@cisco.com>
 <20150105235308.GC1025060@vauxhall.crustytoothpaste.net>
 <3FBC0B0E-BB54-4BD5-AE7D-C82BA9FBA1C1@cisco.com>
 <AB98E028-8531-447B-959C-1DB385AB8578@cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FUFe+yI/t+r3nyH4"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "Dan Langille (dalangil)" <dalangil@cisco.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 01:03:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y90YX-00070i-Jq
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 01:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbbAHACZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 19:02:25 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:56897 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751333AbbAHACY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2015 19:02:24 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DC4B02808F;
	Thu,  8 Jan 2015 00:02:22 +0000 (UTC)
Mail-Followup-To: "Dan Langille (dalangil)" <dalangil@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <AB98E028-8531-447B-959C-1DB385AB8578@cisco.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.18.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262169>


--FUFe+yI/t+r3nyH4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 04:07:01PM +0000, Dan Langille (dalangil) wrote:
>< HTTP/1.1 401 Authorization Required
>< Date: Tue, 06 Jan 2015 16:02:48 GMT
>< Server: Apache
>< WWW-Authenticate: Negotiate

Your server is set up incorrectly.  You should see a Negotiate line and=20
a Basic line as well.  Right now, you only have Negotiate set up, so if=20
you don't have a ticket, it's going to fail.

I'd recommend making sure that you can access it using a web browser=20
after running kdestroy.  That will ensure that it's working properly.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--FUFe+yI/t+r3nyH4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUrckIAAoJEL9TXYEfUvaLlbUQAMQ+yDTpfvU77pKGi+x2unCZ
eB4rsONbk2aFkhjJEFHIfff5xGKODvot+qlz7Xb669UmxwNLiv5Oq4CtYsQ8QwKI
rVhHvcQzUn+jSmu8As1L66VVSH6x5cOH9OOX+JG616hZ2Ta6nqp0R7cC9kHhHiZF
95CYnjOA/M5yX4GCdwjiNtOEOXEB6XNTaDwlHgfdJsZI1Jmpvj3y+7pMrBnupX6o
D032rJGfVoEFgT1aAQ8G8IDpLRHzUe/FBSBUuDPaR4Odb9NF0t8bA67HAAJvYlOm
naSEl37WGhNo+qDfbIRnFDkLLOILCY05Ks+i2gAgE2nBys/9XnAdEzzQi2Io9fom
Iw1XTHBXkYqVALpcal0/C9ypmkSflxhtIqzD5ptCMYB+n0HA01ipJlPzu6g8mcPy
ZWxCS4LjO54aP7vEZ8GmBIAq1DW7SMdLvqNuWBNfbJmqAxWLlgjgmnBLNUd4FbBJ
nA7TCC+ptNuk9A9DMpTewFptzqCdcXBVC1vkz84LI4NJdjK3Qyj0OhLxrE6irspZ
4EagmJW0hniNu+3IHXKwCa/Yt9Nxf5CcK/oTqch9uX0aHmpCvHAWET2I/6eQRpNs
oOBuFtU3YLftt+Xr6tx/LXLCmnsZH8C1QheK6sLyX6y+Zb/wJa5QHwVAJygqZI4E
hT/gjhv35IKY8tW37RGb
=dOVB
-----END PGP SIGNATURE-----

--FUFe+yI/t+r3nyH4--
