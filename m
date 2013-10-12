From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/2] http: add option to enable 100 Continue responses
Date: Sat, 12 Oct 2013 00:03:34 +0000
Message-ID: <20131012000334.GD79408@vauxhall.crustytoothpaste.net>
References: <1381530945-90590-1-git-send-email-sandals@crustytoothpaste.net>
 <1381530945-90590-2-git-send-email-sandals@crustytoothpaste.net>
 <20131011234307.GU9464@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OROCMA9jn6tkzFBc"
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 12 02:03:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUmgI-0002B7-PO
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 02:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794Ab3JLADj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 20:03:39 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:32970 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753058Ab3JLADi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Oct 2013 20:03:38 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DD1B52807A;
	Sat, 12 Oct 2013 00:03:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20131011234307.GU9464@google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-trunk-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235930>


--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2013 at 04:43:07PM -0700, Jonathan Nieder wrote:
> "By default" means "when allowed to make its own choice", right?  (i.e.,
> the behavior git never gave libcurl a chance to try :))
>=20
> Makes sense.

Yes, at least according to Daniel Stenberg.  I don't believe it is ever
triggered the way that git calls curl with CURLOPT_READFUNCTION, but I
can't be certain since I haven't looked at the source code.

> Style: git tends to omit the '=3D 0' implicit for globals, since they are
> already 0 by default.

Okay.

> 	/*
> 	 * Multi-line comments in git have the starting and ending comment
> 	 * delimiters on their own lines, like this.
> 	 */

It wasn't clear from the existing code which way was being used, and the
CodingGuidelines file didn't seem to cover it.  I'll send a patch.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--OROCMA9jn6tkzFBc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSWJHWAAoJEL9TXYEfUvaLF+sP/2uHkliIOsAble0dFjH5FtWS
1SeRK/si8R3vh578dsadH4MniCDqFXN/d+vtfMP/c5tcA1zRMxq4OTGTXKKgW5tj
yWghbSabxlD/W7faxP5Hbesrp8CI6wO3/axq4aTaRweqg/O5NA3wTMULD8vi5AWs
NPaxXFcFVNeXP5G/THIvRg5akZ3A1RbUc7RF3Zu0SjL/0C/1VG2CP4KkrvDbXtHA
gRNqOyFtERucYMmHGtXeigV3SI0mFX2VCyniD5lU/uAsFPNDnqQbWyQu5xzpqezo
j+84lCNVtQ5z/V7Z2PVU2RlxL+yGma3MtEsrzfkfB7wchnzVGDMhVej9LBYhwMuC
bcxM0sRLWKu8YPZbjqz9QWIn4X8uqxtPpdYYz0s1Ib1ZI9DQZZM0c+BTts1w4dSO
ipfcpD8asPTZiD4rP1hwSey+JVJx2tMNPyODM9XDbvJjKgiSWsAtnUuRWbYjGFxG
iquMS31JI4rUOQPlyC/SsvpUQZgPPYa+kVkE3XuIpZAoFeGZc7twfe2pWfuWkIKl
cN4nl3WThpkdiE2UIEJUrgcEZM9FZ9nsBg8xhg1eopMcLHzMjEwyZGRNqZmCS2xE
JBC1POCtVc4iVVpWYS7AObPwh6S2XzbcypxtaVgaxST94Q8hsYhm/hKsPAQwQwVu
vBGpjocWJpHk8KIn1Z3w
=JQ1s
-----END PGP SIGNATURE-----

--OROCMA9jn6tkzFBc--
