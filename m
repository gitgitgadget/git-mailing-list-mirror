From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/3] configure.ac,trace.c: check for CLOCK_MONOTONIC
Date: Mon, 22 Dec 2014 04:12:32 +0000
Message-ID: <20141222041232.GA170128@vauxhall.crustytoothpaste.net>
References: <1419188016-26134-1-git-send-email-reubenhwk@gmail.com>
 <1419188016-26134-2-git-send-email-reubenhwk@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Cc: git@vger.kernel.org
To: Reuben Hawkins <reubenhwk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 05:20:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2uTQ-0001Ri-2t
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 05:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837AbaLVEMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 23:12:44 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55875 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753764AbaLVEMo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Dec 2014 23:12:44 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 12E8F2808F;
	Mon, 22 Dec 2014 04:12:36 +0000 (UTC)
Mail-Followup-To: Reuben Hawkins <reubenhwk@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1419188016-26134-2-git-send-email-reubenhwk@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.18.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261637>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2014 at 10:53:35AM -0800, Reuben Hawkins wrote:
> CLOCK_MONOTONIC isn't available on RHEL3, but there are still RHEL3
> systems being used in production.  This change makes compiling git
> less tedious on older platforms.

While I'm not opposed to this change, I expect that you'll find there's
lots of subtle breakage when trying to compile (and run the testsuite
for) git on RHEL 3.  I've spoken up before to prevent breakage on
RHEL/CentOS 5 (since $DAYJOB still supports it), but I'm not sure
anyone's looking out for something as old as RHEL 3.  I expect you'll
probably have some pain points with perl and curl, among others.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUl5owAAoJEL9TXYEfUvaL0ZMP/0JzjLNkgDSiR7FBCeatVZtN
sHcECTcp9nuaeWVpg8K5XYT5oEHZfnWkj/VVasXoc7Xb4sors51Sn1ptvfdaVypP
J8Pp5moDozjQoal7FB7q/hVmcS3WU7PiiIOLDNBtWJ79SlmEAmYZE5+5JvPWMKwF
Ir8aZ5mQP/dPUBvhtf5x+s9E7+HFaI3pxYLrSBe10LDdiEoL+Sy53reon2TMM2BY
8R2RFII8rfXANKykcqU60pxLD2fXrJX97d4jukMRJx1yurADn9Q23A0p8PDlaUU/
GsJs+UbP7cPO24Pb0dV0HahzrPV+6hXFa84FEwwPXSCKMSWtFTgMBgD2ajg5POpL
6BBw6XZV6nnyv2ooqX98uitqYaWAYkwFQgmKA3lYPOK8x9WBfvdk6LWxczY8aNRE
dGoyXFzu+cC1AMtU6TYEbQha2k3meFdI6com9qONxDTFeGlI6NPT+FM1Puwg5nAN
C9OPQLC2vypp2Ew1owEXuXdacunSkf2iF9y9YjJ2F9AbNjzIUmEU8iWuvrXFuFnc
vugSsRm3aH1OOYDYPSOdm4b9RF+Gvk5aH4+HwEO3MQPZscV58iylsFSHhQ7vxBXI
E1se7WHJaE7I/i8Dfw+Tv7Ym/JBhF7tM9s44UVLh77WoKiG2lBuA5SeXD2uoOYla
WnbWOxeA6ACjnxxOyEOT
=upVJ
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
