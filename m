From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 23/23] untracked cache: guard and disable on system
 changes
Date: Tue, 9 Dec 2014 10:04:30 +0000
Message-ID: <20141209100430.GC76457@vauxhall.crustytoothpaste.net>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
 <1418047507-22892-25-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 11:04:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyHev-0004Iz-VA
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 11:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755996AbaLIKEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 05:04:40 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55108 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755467AbaLIKEh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2014 05:04:37 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4888F2808F;
	Tue,  9 Dec 2014 10:04:34 +0000 (UTC)
Mail-Followup-To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1418047507-22892-25-git-send-email-pclouds@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261117>


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2014 at 09:05:07PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy wrote:
> If the user enables untracked cache, then
>=20
>  - move worktree to an unsupported filesystem
>  - or simply upgrade OS
>  - or move the whole (portable) disk from one machine to another
>  - or access a shared fs from another machine
>=20
> there's no guarantee that untracked cache can still function properly.
> Record the worktree location and OS footprint in the cache. If it
> changes, err on the safe side and disable the cache. The user can
> 'update-index --untracked-cache' again to make sure all conditions are
> met.

My use case for untracked cache is where I have one machine with a
repository and which is also mounted via sshfs on another machine.  It
looks like this will disable the cache every time I change the machine I
access it on.  Would you be willing to accept a patch for a configuration
option to disable this?
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUhskuAAoJEL9TXYEfUvaLhVwP/jEDCLdTIq39CXdW/IEexv4x
GZvHZbzMiPrMDR39QKdkcFBIkR2e37uYL4prciNnPbe7+aUpbVqVeGTTyByrMWRy
HAGBTjVSndhqTbih7KgGQDhaw183HrY84pA+WAtuyK7nzhqjobfw24If1rn4qkg1
SaOXtEoKrl+Z3md1pZokc869VGAWFOHhfnD8SpQEg/ixNr9zZ3kjMbQK5YC+Ud+K
qgXXKZ1uuBZ8TWu5prQ+tKnzi7kQO8EeGb3Xv8BVKYYGDID9fnmed5T2tdNt3bGU
bTwIQwUPMt0x2TBHJLQAFs+5fZiGAlwKgY49gBXgQw/GqQjSFB4bXH58NzWdvTkb
SVXUvN7u84vxfTj71VCpa7NHbprGtFKwqXH8927SWJ2LZ8Dx7f7NvlInXj84b+Sc
OirJ8zHIeCri18r7e6F0/sReig83GmC/3IDV0UVdPnxSQmTko7GVa5iVedrXBs7G
IZQMyavDJChoCKSIHqM5rNMCZteFjOsFQwlLk2sYxPcCRfQJoZkejYyKoaqyk4HG
R1hvX7Vw/gVdSM8r87qRDwCM6UNoQijKloF/HkfscIZpCqODTtUgzQKkjS6zjOZ3
qJdaXPNwQbq9CZmFMAubNmR3YDT5xxti09nQ1T1+K6pSvwmvmioLUgz6V7rjOEOU
G1vJFTgz9j6Nxj+x+O6M
=5hW6
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
