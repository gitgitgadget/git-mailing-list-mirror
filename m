From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [RFC/PATCH] mailinfo: do not treat ">From" lines as in-body
 headers
Date: Sat, 13 Sep 2014 22:57:14 +0000
Message-ID: <20140913225713.GB189120@vauxhall.crustytoothpaste.net>
References: <1410472786-14552-1-git-send-email-mark.einon@gmail.com>
 <1410472786-14552-5-git-send-email-mark.einon@gmail.com>
 <20140913093746.GD6600@mwanda>
 <20140913154556.GA12361@kroah.com>
 <20140913203645.GB24854@peff.net>
 <20140913204745.GA12291@msilap.einon.net>
 <20140913205751.GA17875@mwanda>
 <20140913210908.GG6549@mwanda>
 <20140913212504.GA25190@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Einon <mark.einon@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 14 00:57:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSwG1-0005uq-38
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 00:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbaIMW5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 18:57:25 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50153 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751724AbaIMW5Y (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Sep 2014 18:57:24 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 70CEC2808F;
	Sat, 13 Sep 2014 22:57:17 +0000 (UTC)
Mail-Followup-To: Jeff King <peff@peff.net>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Einon <mark.einon@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20140913212504.GA25190@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256984>


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2014 at 05:25:05PM -0400, Jeff King wrote:
> Thanks both of you for following up. I did confirm that git-send-email
> does not add such quoting. From your findings above, I'd agree that it's
> the list-archive software munging it, and they are buggy IMHO (they
> should de-quote on display).

I wonder if git send-email should do what mutt does in this case, which
is use quoted-printable encoding and encode the first F as =3D46 (as well
as any equals signs as =3D3D).  It looks like mailinfo.c already is
capable of handling that, and that would avoid the entire issue.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUFMvJAAoJEL9TXYEfUvaL2MgQAIG0aowj+piE0f0uLn+iKclI
AbSF3Utwg9LYROXgLIhBNJbUYqLgumO8Bud5DeXZB80bHqmuHBsaNKEPmEpcKW49
7rTphXEG7F696eTrrDQ5nGVSpb4iZgKfpVp+5/wE4O2wzwnhx+TjcfFw0QoKRG6r
XMQi9cWMUgwcdYEA/8U5M6Tkat2niIDttV/M+llGh68FoQi0k+GNKhJ9N/UFleVE
OetqgibKuMn1MI0pDyagX4uRszwqBzTeIpbP70fpsHglMdJ1LPxDMQAGWRMy92a/
7jJjPIbKtXS9XqxSbqnqSh5xONkshxPodmo+rBycoAwxjbCXaz9d4mLZHx4qBWgm
0XJtsRTnA5n9Wl1A5qcdeuEsiYb27n7peDumoq6c/nIrHw4CICjtb3f/La9R0/bt
k0rRXWxW84DTCNFF6DI376vLuP0pB4yHGhXA1J2z51nRMBIlrJc1WCGzjxtRvOdI
7ovji/QD+z5h1XFt8z4TMqN1z0Gp73pOQSyZBzsVoIZxU9/176HVibU2ONx3DrR1
xEMkwK9HzzmhKKyGPjjprcBX/5J5geEmhQm5pQCh3j6475KhzVvj/4N/9pJCNU9m
1A7DhGr8GrJGFP+GswtSHGeadIX+sVR7b7yNXes8eq6Wn+GIzUHw3y/pislnLR4b
fJnk0KvizIPTErdHm3J7
=4srz
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
