From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 01/10] Define a structure for object IDs.
Date: Thu, 12 Mar 2015 09:34:05 +0000
Message-ID: <20150312093404.GE46326@vauxhall.crustytoothpaste.net>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
 <1425770645-628957-2-git-send-email-sandals@crustytoothpaste.net>
 <CEA07500-9F47-4B24-AD5D-1423A601A4DD@gmail.com>
 <20150311220825.GB46326@vauxhall.crustytoothpaste.net>
 <xmqqr3sv3vsf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 10:34:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVzVP-0004y8-T1
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 10:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbbCLJeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 05:34:12 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50040 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751775AbbCLJeJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2015 05:34:09 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:d0c6:418b:e1a:b913])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 84C8F2808F;
	Thu, 12 Mar 2015 09:34:08 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>
Content-Disposition: inline
In-Reply-To: <xmqqr3sv3vsf.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265356>


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2015 at 05:26:56PM -0700, Junio C Hamano wrote:
>"brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> Michael Haggerty recommended that I call the structure element sha1
>> instead of oid in case we want to turn this into a union if we decide to
>> go the additional hash route.
>
>I'd advise against it.

Yeah, after re-reading this, I think "hash" is the best choice for the
underlying element name.  That way, it's different from "oid", which
would be the instances of the struct itself, and it's sufficiently
different from unconverted places in the code, which don't typically use
that term.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVAV2MAAoJEL9TXYEfUvaL894QAJ2j06CVw6+eo/SYsHm7YZrC
kVQxGgRydezm2TUl+0Fs4ithnqqhvSKUW6pKx3z1q8+soOjcHeMOA5lRrqb+lwl2
x+ZRZud8oErnzJiPCvZjtV/dKZ0KFVmLZSqYY30uPLDj9diB6goUcyUR/kfrHLee
UxC2urieUxOcgICZJrLoOuo54mUHZNgJ6Wm0XKPjIA1QprPq5QaD8CKVSw/Ln/Z3
psjgZlzev5sUMKBChw9zsUevVMt1/VzErPVVoh8dBrISBbC9bK7dX+r98344hXSp
VLgoi7qX3skGCRCaKHljAv2c2OYjwhlwQLQoPbTud4RbCYeNkI1C7kSfO157z/7F
I5+ogUHp3+wADKzcihMhBUFwQz4WkbIflajz9tKqctoXsQKl86DjrBfdncPG0/um
qoLUX+1ktVGn49NiXT9azBfUVi8OHPotA4jRk+OdAWraHAtSGz3wvgjnhXlc19LR
x/MjPltrlkDEAwf/LTAoIJa9l9gX3WmoPSbdSq58sBnIEHsMaXcUdZ/i0uENSMmU
Ebb6Ks2MJWs8GpDBoKdrJtxOsqi7p6/tjAq+WULEiEOvDUTXX+YVcEVM3AaeigbF
iBi577nWugzhxhSlCIXQnAKGBkHQC5WlPyhuVoiZvxM2yi31G5UlcdKI1Fh20CxN
ZqNS0AgbcRg663kmqYhZ
=mWq/
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
