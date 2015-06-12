From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/8] object_id part 2
Date: Fri, 12 Jun 2015 20:30:54 +0000
Message-ID: <20150612203054.GA29305@vauxhall.crustytoothpaste.net>
References: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqq381zi3ev.fsf@gitster.dls.corp.google.com>
 <20150610235114.GA786544@vauxhall.crustytoothpaste.net>
 <20150611000251.GB786544@vauxhall.crustytoothpaste.net>
 <xmqqpp53gkmq.fsf@gitster.dls.corp.google.com>
 <xmqq4mmef22j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 22:31:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3VbV-0007xW-Hm
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 22:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbbFLUbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 16:31:00 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:41648 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751896AbbFLUa7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jun 2015 16:30:59 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:81d4:30df:5b4f:7cad])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9D7CB2808F;
	Fri, 12 Jun 2015 20:30:58 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Disposition: inline
In-Reply-To: <xmqq4mmef22j.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271519>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2015 at 01:00:04PM -0700, Junio C Hamano wrote:
> Fetched that branch, built and found out that it does not pass the
> tests, at least these (there may be others I do not usually run that
> are broken by this series; I dunno), so I'll discard what I fetched
> for now X-<.
>=20
> Test Summary Report
> -------------------
> t5540-http-push-webdav.sh  (Wstat: 256 Tests: 19 Failed: 12)
>   Failed tests:  4-10, 12-15, 17
>   Non-zero exit status: 1
> t5539-fetch-http-shallow.sh (Wstat: 256 Tests: 3 Failed: 2)
>   Failed tests:  2-3
>   Non-zero exit status: 1
> t5541-http-push-smart.sh   (Wstat: 256 Tests: 34 Failed: 27)
>   Failed tests:  3-17, 22-29, 31-34
>   Non-zero exit status: 1
> t5551-http-fetch-smart.sh  (Wstat: 256 Tests: 26 Failed: 17)
>   Failed tests:  4-14, 16, 19-20, 22, 24-25
>   Non-zero exit status: 1
> t5550-http-fetch-dumb.sh   (Wstat: 256 Tests: 29 Failed: 12)
>   Failed tests:  3, 7-16, 19
>   Non-zero exit status: 1

While I did run the tests between each commit, I hadn't noticed they
were failing because I don't have Apache installed on my laptop, so they
were silently skipped.  I'll resubmit with that fixed.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.4 (GNU/Linux)

iQIcBAEBCgAGBQJVe0F+AAoJEL9TXYEfUvaLlp8QAMipKPcPE9OIgAU6impEL1de
dDzhA4qt1f6ggbSEF3QRw4cxLP9kYpdrph78pqqHNyfrvp2W3MzHG4R7Io2XImsB
jjYjJ90vbO51X74bepc0dVw3I5pF4NzooEbxrOR78xspns+TaNwBto9QZt+tomC5
OSN3FQL5gdEKotpF8tmYOXsS7e+FGQUB0qLjRFxaaRIsz37kVJL2NaAkJHJMJYm6
Oqr14u/s9Mt4G8xEk7UHj+t4vdmzynrsazgh6CetxUAy8rMeadmBz4PefQWZvIeM
e7lV2MKLU9pg/QFKAnu8FZNbPBDZ5txT/edCT1TlwOezvfe/Wy/5l6Td0ySZCFNc
rP8yoOkUhoRvuZ2GKhFgDFsBYV5bRyPBQymU1TmdqTzCUtbSV/86FZ1EHo+garDu
JBFogiw2z2JXVCY5Bu+6vbfPt0GVOxhS8Gpg9F6pHAQe69theiJHHuzc8mYDcycx
hD582CXo/xlc4CNf21/HAKJCd8CYsqFwwIyPENnBvIGdzJZ/bPmky015hIfMnFro
d8D8e7f3XWtysn0U1bez+7z+u6mWXtuSZgo6sxvSdQXTUZAp4RYmipoGscGZT2Iu
idkPX8EtSAqoJLphUKG00SUkAlyV02/0rkw2pCJM+c6CJBB+h93EdwYyzw8659VP
HlIQDmuqshUnQykm8kfh
=qpGd
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
