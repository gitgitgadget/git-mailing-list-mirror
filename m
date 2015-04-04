From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: C99 (Was: Re: Freeing struct lock_file?)
Date: Sat, 4 Apr 2015 19:04:00 +0000
Message-ID: <20150404190400.GB10125@vauxhall.crustytoothpaste.net>
References: <1428097515.31333.2.camel@ubuntu>
 <xmqqfv8gg9bp.fsf@gitster.dls.corp.google.com>
 <1428107083.31333.11.camel@ubuntu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 21:07:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeTPK-0002Sl-Dq
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 21:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbbDDTEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 15:04:09 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55308 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752522AbbDDTEH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Apr 2015 15:04:07 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:3964:791d:262f:be03])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EDA252808D;
	Sat,  4 Apr 2015 19:04:04 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428107083.31333.11.camel@ubuntu>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266778>


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2015 at 08:24:43PM -0400, David Turner wrote:
> But I can see why git wouldn't want to depend on that behavior. C11 has
> a way to do this safely, but AIUI, git doesn't want to move to C99 let
> alone C11.  So I guess this will just have to remain the way it is.

I would really like to move to at least C99.  However, MSVC bundles a
C89 compiler and a C++ compiler, but Microsoft steadfastly refuses to
bundle an actual C99 compiler, and Git doesn't even come close to
compiling as C++.  Newer versions of MSVC (2013 and newer) support
enough of the features, though, that it might be possible.

So it isn't as much of a "we don't want to move to C99" as much as "we
aren't yet willing to drop support for older versions of MSVC".  I don't
use Windows, so I'm happy to drop support for MSVC 2012 and older, but
others may have different opinions.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVIDWgAAoJEL9TXYEfUvaLkroP/2IK+U0NEGTLNdtB9psZ5pgk
0/FpC4QbuFWUQ1LizMbxJKcFY3ABg3dj+EzSdrD2Zf/1nyIFRtc1J07tLAFDi0Pq
qmNfOd8hnu/9fa9wuwkRbu8UBTxSy0k2mQ9hZl3lUwhhgiQxataPqo/BNdDK3vmT
tPj1GbVMzXpF9Eqtr9R/DHTOqZ6rFzNbdcA/y0P5CqCX1/t8z38lnGq9T8L3cFXX
D4LrqNShrmD5EvPMmPtgLeT022ZWt6M/iK6xBuwHw5v0ac6Va4IlE7mxtqsGYj4Q
L69m2j55JYA4LLzm3FrYmu5qqlidK1y/Q2vff8i/f7ZUICDkfNvd/MKtu7mqsEWf
W/W478zHEjye0I+06GRrw63YiAQv5ahM5OEeBaFvRSka8GDoHpcc117Kxlh1ifvr
DhNygEHsP066GK+xuil1KK0DvLMIHlqcb7sbpCRhbGOJnVIvyE+gegKq64Apf6Z7
Pk09Zc4MiLFTX0gHzirLeukD/4OVM6NejVvsV5IJA+psmUfpLi5Qd2wgMHUHhWRU
ZzcDfczyfpU8ZW7BTjD7WGvOWkrh9PHSQtygdmQSz8mpSKBNFDA3DqcvKdOSUA//
Nnc6jDbwpCdfM+yu+xDw3NHTS2L1w9D92uGfHBr8EKk8a3pO02rJ340thSxr4ezp
39od7/7mZZ6TxBfei204
=29Ft
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
