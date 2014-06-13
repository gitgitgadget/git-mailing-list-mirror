From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git rebase --skip stuck in a loop
Date: Fri, 13 Jun 2014 01:02:56 +0000
Message-ID: <20140613010256.GD368384@vauxhall.crustytoothpaste.net>
References: <5397551C.4030709@ubuntu.com>
 <539A151C.50307@ubuntu.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 03:03:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvFtf-00048A-EF
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 03:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbaFMBDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 21:03:06 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48305 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751141AbaFMBDE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2014 21:03:04 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:897d:9e98:725a:bcd7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 521AC2808E;
	Fri, 13 Jun 2014 01:03:02 +0000 (UTC)
Mail-Followup-To: Phillip Susi <psusi@ubuntu.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <539A151C.50307@ubuntu.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.15-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251508>


--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2014 at 05:01:16PM -0400, Phillip Susi wrote:
> So nobody has any ideas on what to check for or how to debug this?

I'm assuming this works in the general case, because we have tests for
it.  Do you perhaps have a repository and a set of reproduction steps we
could use to try to reproduce this?

If you can get that information, I'm interested in trying to fix it.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTmk3AAAoJEL9TXYEfUvaLaEIP/0NmiwnJRyJBHfb1n/bMMQBe
1q5ycyKfVMojrAAAvNHsvgH1dTGlF1xCz0WXlD7YbZ2NEEbMA1UBOhz91yJStrDf
rpAFt1vW6RozPEZZKRoUHokD1tVG19A7wzL19POawbQvDq9WSH59ulWyZeT4nddn
M+/6748//Cpgw8VSlHxnIheu4ORTxSqkGcOYw4UDXeW7Ti3G8W77nSLOaQXWC9/d
m9ELVnxhe3hq5SSt+V5PFZmt+FMYh2dyrQ68G96uPl86Dby7tyXJgYiMt+FttZ9m
8pGAVnecBoX88Fl/oUH+eQqKlsvFtXDNzJeYL9n6+k3Ly25yxBpAq61SgKy0IW0d
YTOwNDu0x2lNM99wH+0gigjj2s0vYxKKhPK6qL5GMvRTKZDX/Y+WIfD6x7SNfnBU
AJGJXBkBxnc93mnzgMbmZ1NnRmzb6F7sjhKewRUHL/Y6BwUSyuoBnr0eIdLvSMn8
DjykKe4lE6EMjz5GTUa60uDIwFXqwadKJnoL+lfxMtIvVKreU8DtPz1b6ezTMcm+
7lAu9OUEKtdf6Y8vk033quLilZapiHBliBtFFzoZjPrchr+AbO/m7WJoXulsTW85
96mX4jDFTbRCpqBYg+EN+bMVSL/eF0bjXsKUqV0MCEefMBgMbaGS3Gz6L7DOEgmB
4JAT216Vor55RKPjDfph
=cB48
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--
