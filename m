From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] mv: prevent mismatched data when ignoring errors.
Date: Wed, 12 Mar 2014 23:21:26 +0000
Message-ID: <20140312232126.GG4271@vauxhall.crustytoothpaste.net>
References: <20140308183501.GH18371@serenity.lan>
 <1394306499-50871-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqqfvmoo1d4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Guillaume Gelin <contact@ramnes.eu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 00:46:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNsqg-0001it-Dx
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 00:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbaCLXqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 19:46:04 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:52550 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751230AbaCLXqD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Mar 2014 19:46:03 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:7922:e1f9:69f1:ac6c])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1F56A28074;
	Wed, 12 Mar 2014 23:21:32 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Guillaume Gelin <contact@ramnes.eu>
Content-Disposition: inline
In-Reply-To: <xmqqfvmoo1d4.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.13-1-amd64)
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244010>


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2014 at 02:45:59PM -0700, Junio C Hamano wrote:
> Thanks.  Neither this nor John's seems to describe the user-visible
> way to trigger the symptom.  Can we have tests for them?

I'll try to get to writing some test today or tomorrow.  I just noticed
the bugginess by looking at the code, so I'll need to actually spend
time reproducing the problem.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTIOv2AAoJEL9TXYEfUvaLmusQAMN19atr/zGyKl/xiP2I3gzp
cSVZfdULZOg6G1rHCHg/ECNEUDEJGW+M2/qlYFtQUfAsLcXIktms7avwsJP9gbJT
DrpRx7PEiStcP8FT5TzMArN+aLw5Ima4Iyxqaac5fRNABLRpnyLeXAN6ZCjYdZ/D
PumZRIIbg14JzbnEBoBC2CHl5SyN1tX/Omwo8PX6LUit9rV9k/CKuUaGITUlQA4b
0q5RPvHtuO+vYW7ah0tMyDfATw3J2gZrCbIXLZXctGQe2q+sgn4c2FONhZdhfpyN
F9QYqdbZUkLDCkOb/sPiP7qyoS/AlM8sA9FhRMbScVXCxjd6oWLrpEDp9CKSNGEa
rUsOuZKvB4NADVd/Ae/OomuFwXGbxgnARdJQ+CWTenzbhkgu/j82CNOmJMe9kaHq
OOtDXTtq0HmR7IIRsK0BwTI1cg9H9S5K91sEhIyjarYV/H9AT1ac9H+KrKFBtxzf
6jGxI8zjTuNaRaQUIEac8sfyky6/kZVuE7SJ8BzLFWvZvsqPTHPjTTFGcrBCC0ul
DWfl1/B6QMzN/oYgKjql9OQK2N8Ur65jSN4b85Rp4hUHT+bqgRZ0BjkRjcBq89jf
XuzL4p7RuXUcUg9OcWI2ZAbETpTI2Qmpui7jKkZ+dqdT73mdzpHN8MEpevE5bm/o
OpfPSzRtxqgvkLyFqzFx
=Qgq7
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--
