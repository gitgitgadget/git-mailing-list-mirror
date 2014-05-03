From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [RFC PATCH 0/9] Use a structure for object IDs.
Date: Sat, 3 May 2014 22:49:58 +0000
Message-ID: <20140503224957.GL75770@vauxhall.crustytoothpaste.net>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vJI8q/aziP9idhqk"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 00:50:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgil6-0006Ys-D7
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 00:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbaECWuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 18:50:05 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47540 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752855AbaECWuE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 May 2014 18:50:04 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:406f:e13c:7c96:bfde])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B20D028087
	for <git@vger.kernel.org>; Sat,  3 May 2014 22:50:02 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248061>


--vJI8q/aziP9idhqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 03, 2014 at 08:12:13PM +0000, brian m. carlson wrote:
> This is a preliminary RFC patch series to move all the relevant uses of
> unsigned char [20] to struct object_id.  It should not be applied to any
> branch yet.
>=20
> The goal of this series to improve type-checking in the codebase and to
> make it easier to move to a different hash function if the project
> decides to do that.  This series does not convert all of the codebase,
> but only parts.  I'm looking for feedback to see if there is consensus
> that this is the right direction before investing a large amount of
> time.

I would like to point out that to get something with as few calls as
hashclr converted to use struct object_id requires an insane amount of
work, because often major parts of several files have to be converted
first.  So the list should be aware that this will likely be an
extensive series, although it is bisectable, so it could theoretically
be done in batches.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--vJI8q/aziP9idhqk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTZXKVAAoJEL9TXYEfUvaLbHQQAL09NAoQylfIZ2OGFW66CpfU
a3U+J+xcjFSiDEI3BRf+MF5JBjwUlF3jW8j92G8U1F9si7ZzPlG6X10R5qHJS/+/
UagfjIUMRnfKyOpIueG5Mqmq4JUpZsUwVKmWlzzRSWOhBRmAzrcmEusH8c2cTQfP
WG2tyQ62kae5CP/XsnayNu3EuITfN4xaGufQ1xwTwJsoO6U+hPDj1KWeCIf/m2Vz
PY3MfZn7sZBpfK6/vo5qTemyXJlzUAa/R1HJ/m0+zjbJFmUWlVQrSUwmlmg8SdtY
9dWCBAOHOrXhk0O9S4fPSCLOGhJOmNPkYonoUOXtrDcDCGh1lTQtPia5b7KoghXw
F6cPFy0NJfPhiCDnI5h1HkMha4DhfkkoKw+tBtAPUSQs+55ZLD6wKzLnvC2EnZaF
cQhAgcydZ7eTdgP5833NGVPCuqI73+dZt8s4huQRmEqM5qoniJxeYm8sJ6UXwWRE
9bIg1SFth6cex/3I4U+pbVBzBymrbj3I8xCSOLdUW/93XT4Vk7GSZ6BnbWmV+HZB
p9EHxV48E/g2PNjaKSYGZcntFUm/ByYJhgYxzFm+SSC9j4kiUd3dQBPaSylk/amd
rbch44C6Z9LNJgWZ1uBAQR8oG3lBfOuo6KCnKkTvVoG67E3Sby7nE/MFnJuUycua
lD7IwOpBwafVty0+V/Jl
=pHJM
-----END PGP SIGNATURE-----

--vJI8q/aziP9idhqk--
