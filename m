From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/3] Raw gpg output support for verify-commit and
 verify-tag
Date: Sun, 14 Jun 2015 22:14:57 +0000
Message-ID: <20150614221457.GG29305@vauxhall.crustytoothpaste.net>
References: <1434307910-705555-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqqd20ym1b0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LiQwW4YX+w4axhAx"
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Alex Zepeda <alex@inferiorhumanorgans.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 00:15:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4GBI-00073V-04
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 00:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbbFNWPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 18:15:04 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:43932 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751806AbbFNWPC (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jun 2015 18:15:02 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:81d4:30df:5b4f:7cad])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CDB242808F;
	Sun, 14 Jun 2015 22:15:00 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Alex Zepeda <alex@inferiorhumanorgans.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
Content-Disposition: inline
In-Reply-To: <xmqqd20ym1b0.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271655>


--LiQwW4YX+w4axhAx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2015 at 02:23:47PM -0700, Junio C Hamano wrote:
> What this series wants to achieve makes a lot of sense to me.  One
> comment I have after skimming the patfches is that I want the new
> "raw" bit added not as a yet another parameter after "verbose", but
> by turning the existing "verbose" into an "unsigned flag" flag word
> (with "#define GPG_VERIFY_VERBOSE 01") and then defining use of a
> new bit in the same flag word "#define GPG_VERIFY_RAW 01" or
> something.  That way, over time other people add differnt things to
> the interface, we would not have to end up with 47 different
> parameters each of which signals a single bit.

I'll wait for other responses (if any) and then reroll.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--LiQwW4YX+w4axhAx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.4 (GNU/Linux)

iQIcBAEBCgAGBQJVffzhAAoJEL9TXYEfUvaLGTsP/2EY0936nnhA7UXwaWY4WMbp
WrNH/OuZ3pHOahwCT1EC3X5VzYawbs7TzDGZ2JE8SYU1xC2TgIKGDs2w+rGGQtQK
/TGrTwO64imvhsNIEqn+mqH428Tzb1r2VTjMRc0kXqi75B3beZ9YmjgyG3CwAOF0
C7u5DkocGPijGOmyAbQ+Zka/diNhKmnY4w49pHJjpTyjigHDoAxz0kXkNnssase4
ax79o5s6NSN+ioNYq6dVp2wPs1y29cciEEwbhuzOrncALTviAedmNZjrlb+1v9OX
rIPZh6BHTFT6gydsYx9pRareNY9vpVtdKQZYzBnVVacyaB2bE18WzH3NekTqxza2
U76uWBxdMg4taQy1WLi3pRl+B2o5scFaHjlv+wwEkCf5VSg+ATv9sCZfyppR4K8F
JkNt5W+LKwqXBd116lB34SesqKhGdmmUT0SlWMLzuPumq1ERH6A4/dBIQTqIxJw9
KVhdeos2z8viv3aaZJ06UxjlUmGa20EkXmgBH2s9sjhlV1+wq8jSFmQsG7b/1oc9
CZF8JXB97WkQcmFC8Tf4Wgto+W+DiHigD7Zbbx1gR3igSQy9VSZsckjZqoNr4gtv
MrtkKke4leVkZeCnTKHI3BFkn1qRgE7JRc9QOhn6uR2NQCa3DLrgB/PcLHUDeIyF
LJXlnepKnfvoacJ2mheZ
=wudR
-----END PGP SIGNATURE-----

--LiQwW4YX+w4axhAx--
