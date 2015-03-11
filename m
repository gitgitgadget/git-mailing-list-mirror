From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 04/10] archive.c: convert to use struct object_id
Date: Wed, 11 Mar 2015 22:12:30 +0000
Message-ID: <20150311221229.GC46326@vauxhall.crustytoothpaste.net>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
 <1425770645-628957-5-git-send-email-sandals@crustytoothpaste.net>
 <55004F18.4070609@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Cc: git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 11 23:12:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVoro-0000XG-6N
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 23:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbbCKWMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 18:12:36 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50032 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751931AbbCKWMf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2015 18:12:35 -0400
Received: from vauxhall.crustytoothpaste.net (ng1.cptxoffice.net [208.74.121.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 191772808F;
	Wed, 11 Mar 2015 22:12:34 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>
Content-Disposition: inline
In-Reply-To: <55004F18.4070609@alum.mit.edu>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -1.5 BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265344>


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2015 at 03:20:08PM +0100, Michael Haggerty wrote:
>On 03/08/2015 12:23 AM, brian m. carlson wrote:
>>  struct directory {
>>  	struct directory *up;
>> -	unsigned char sha1[20];
>> +	unsigned char sha1[GIT_SHA1_RAWSZ];
>
>This is a local struct, and I think it is only a three-line change to
>change the sha1 member to
>
>        struct object_id oid;
>
>Though perhaps you are delaying that change for some concrete reason.

No, I just overlooked it.  I'll fix that in the re-roll.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVAL3NAAoJEL9TXYEfUvaLldoP/05OB5EO5lxA0Fx2a9ntuwqd
62ot7aHxaTgyejJYEdECwOdHoqXCkkGE6wuvTb/G5tp7FsVUvosIa+U1jy6FLQjP
ixVogDif/6QV299RGeZ1jusdEoXIDnw6jlKwgOlZk0hj6415h0BVETtlyn6XE9XC
ll6nqFSA96M5/kZHbb/l8QrtEWZeWJ9NhqNCXna83A6jvclsRdr+7QXTAPHvJFPj
bWkXxmsdkB/AGiFg4H4JRydWraJmoANuPwUYS8c8pokI+1stO6/4uXaOWohYPlZR
jsPF5Yh2CAs3uRH2mLTa6CF6LwEhBrvMafIfgTrmQpl2dS6hPzZiNDQt58jzUKzZ
IiNe1PWeVppTCdAtauy1naBD8w1Bp7pUx8CHIHVsu0Y8jXVPZHUUKhLsJsy4f4dO
PwtblEHMFbDCfUwgZmLJWP8TwTOr1AyMYdbpWPoobanOVPp154IwQOTkR0/slWcx
FhQaAeyYAPS20Ly9hmLTZh8kDtMw8V7BxQU1DQ8FRV8Q3Fy0tcbJJWYGpBHM2Aoc
aI8FU7MWV9I3rfApYQQaPEewq9XuSY6UHSoYpcN9dkQOEzfQqftNj3On5Gf3o+iG
7NeVustPsYIm61LGSNEFmzBUZTyKZr+wYZhUuaW4eua7Xe3R/TniFJKTNjgCTlJ0
cJq0fx3lUa6Bium0d6KO
=17p4
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
