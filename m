From: Josef Kufner <josef@kufner.cz>
Subject: Re: [PATCH] Pass graph width to pretty formatting, so '%>|' can work
 properly
Date: Fri, 11 Sep 2015 19:52:36 +0200
Message-ID: <55F314E4.40408@kufner.cz>
References: <1441979260-1494-1-git-send-email-josef@kufner.cz>
 <xmqq1te428xl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cCG1PUvA0qsgBlQ7gBjQc5VRW5vKipXs8"
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 20:01:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaSda-0002Pc-BF
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 20:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbbIKSBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 14:01:19 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:49338 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753693AbbIKSBS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 14:01:18 -0400
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Sep 2015 14:01:17 EDT
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id ED8EB19F4A6C;
	Fri, 11 Sep 2015 19:52:41 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id Ia5hxySfpEAz; Fri, 11 Sep 2015 19:52:40 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 94BDC19F4A69;
	Fri, 11 Sep 2015 19:52:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.1.0
In-Reply-To: <xmqq1te428xl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277686>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cCG1PUvA0qsgBlQ7gBjQc5VRW5vKipXs8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ok, there are the two tests (see the second e-mail). It should cover two
cases where something may go wrong.


Junio C Hamano wrote, on 11.9.2015 18:54:
> This "feels" correct ;-), but let me summon Duy who did the %><
> padding at around a5752342 (pretty: support padding placeholders, %<
> %> and %><, 2013-04-19) for an extra set of eyes.
>=20
> Care to add a test or two while at it?
>=20
> Thanks. =20
>=20


--cCG1PUvA0qsgBlQ7gBjQc5VRW5vKipXs8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV8xTkAAoJEN5YZWvcKoxvZbEP/RmZGnycwfzDZYwkSbRhHR3v
wKgk8D7KdWM9HECpVlB+9EVLAXkGBpXCWDGAt9X9op8egDtJJi5+07SEgSLgRq7q
Yx6zh8gAfs8yGfrvU/AqZkdXFsUCH7Xbyo6dqK0SUFmjapd8zVfkG2gsebljr7r5
eXmGZm5pIwGEX/DK5nGJFJ8WBiilTPYSAZAcPS9ebhrwERz68CI5toHadsG+7v/2
NIFRnFo3uknrIJOZdOZKzufLDtZ4vz2gMu0XrRzsPZVWuKtDiVK1Hh4kWP0xfiOq
jqZoW3ibOpu2+Lp+q3eVGADn1ZJY9MegfYAar2CHnzVTT8nUzOJTg6YKhTmBIpfC
DZWHoFGeP8LheW+GWPJB09Xw/sfAJeiMuxJxoEau6nYDMyXwW60fsvxYkEknHeiI
JQ9Mqn71I45x4z0SK8X3C5D9lW+Jr6diaCDABAHIm/7tPl/wH771flMhgX0T+iqJ
uaQenCol+kHkCs8rTp8FCWh6BdIdX/HDTLGwtEZqG71R4JuL/4rARs9af/k7U85N
HhfB/DTxB2LhrhFMzHYAf9odIwSG58gZ4NJOQDvr733WHHqn50beZpdHgTpn5MFu
KniYjQa8u5/0tPNFqASHCvNjQxN53sH19yzrHUoNXP3VhU1crPqO7yzMGCvXhdBC
kuHmN5dtTRSV1qGz4tPO
=cL8V
-----END PGP SIGNATURE-----

--cCG1PUvA0qsgBlQ7gBjQc5VRW5vKipXs8--
