From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] remote-curl: don't fall back to Basic auth if we haven't
 tried Negotiate
Date: Sat, 20 Feb 2016 15:23:51 +0000
Message-ID: <20160220152351.GD14569@vauxhall.crustytoothpaste.net>
References: <1454404284-2197-1-git-send-email-dmitry.a.vilkov@gmail.com>
 <xmqqegcusvb4.fsf@gitster.mtv.corp.google.com>
 <20160202232952.GA6503@vauxhall.crustytoothpaste.net>
 <CAHdYDCqtNQMoU3Gu2AcSEWM5wA0SbaMrivu3WV_-N+B-F67v1Q@mail.gmail.com>
 <20160205204648.GA7403@vauxhall.crustytoothpaste.net>
 <xmqqa8nedg59.fsf@gitster.mtv.corp.google.com>
 <20160205210623.GC7403@vauxhall.crustytoothpaste.net>
 <xmqq60y2dduw.fsf@gitster.mtv.corp.google.com>
 <CAHdYDCq+MiAJoCPFd3Qn9VjAzoii8QgTOOV7HXEV8OdzW-dgPQ@mail.gmail.com>
 <CAHdYDCryaCbj-s6LG5fcDu115fi0k_uCawtus81PPbgyWpBTSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 16:24:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aX9Ok-0000jn-UN
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 16:24:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbcBTPX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 10:23:59 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:36540 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751490AbcBTPX6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Feb 2016 10:23:58 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 84FF928098;
	Sat, 20 Feb 2016 15:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1455981836;
	bh=y4th+LbmYEYiVOHv6O8us4hhHGeynG+lxeqrNknE6/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYVkUCWyqL0CcM748eCAmN5YtvdNGyGGwfRbLktN+qsr4/LQ+23qHve9d5pug9C63
	 tLmMEz8Cchp3Ako324Rry56LCGYx+iNdn9dGDuyeXmmd1SeE8lYfVRyZkLz9UilMNe
	 We1bea0NnlkFY7HdRCVUqMG6i5kCKAigrsNi/iLqttLzRrvpVtfE/2T9ZrTavnZSth
	 OQC1P0erXzaD1xhR+N0lFlPObrtbqR3Dg4xk19UmijwBmxn9wWYbN4ENnojBJf3HEp
	 jK4Q3b61WjJfg2Q5tKhDYRPo2Wtph/UVzAfGW3EKLfymEfTJ28KaYJLOkwju694RdE
	 niXKPRoJW+H1d4U5xnTu8f/8Ri8VkQZKrxddFec7+Y1t/DUkXY4BqCgvrH3gqksqXP
	 3+SLH5cgC1WRQXmJiWd2YMVpW+xcKPb9DkqRKjrTkyMpvSOAOIuspYjDPzVdl8dDv2
	 eeww4Vxj72aD2lWrIig4Zmy8d9/cDyAsSDIwRrOkyq+1Ni8PXvf
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Dmitry Vilkov <dmitry.a.vilkov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAHdYDCryaCbj-s6LG5fcDu115fi0k_uCawtus81PPbgyWpBTSA@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.3.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286784>


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 20, 2016 at 05:35:19PM +0300, Dmitry Vilkov wrote:
> Maybe you could accept my patch, so users would use
> "credential.helper=3Dstore" to avoid using ":@" in remote URL? At least
> for now, while there is no good solution to this issue? It would be
> very helpful because now we have to have our own version of patched
> Git :(

I sent in a patch (and I believe I CC'd you) that adds an option
http.emptyAuth that can be used in this case.  It should make its way to
a future release.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.11 (GNU/Linux)

iQIcBAEBCgAGBQJWyIUHAAoJEL9TXYEfUvaLWQcP/0HNUFsUY1C4QvQ5MOTwwH3Q
ZUhFxeidSOx7Z64Q36tCBTDea8YpwjwY2tkDmPA/pOmQ3FKaaM5OVYExamfOhABM
0j5aZ5ZDkV5k917PcnFhRwNTz3OS+FVI/NTjjsWjIOJIBKa3eB3UPLPFECjBuVXL
QZE5cqZardWhLvdMUbuP8VreTzcwJze6EqpejYjQjuP90rJxRgc17Sx2utkV272q
7IK1nIXbnqdS2m3TvoGa+TYSbpmUVaJcnx1HVIdQNDla+0uwKk578UvWwTHxNKBG
IHl1s02jSdphBYhv8rmRa/soiJnMkgw6E9+ZvJzsVMxEbHOlpr9KaP42IBZotK9s
/TFroeS4m63TvRfFINseU6tSngLo+VwQJ0XuW/M1V4DofgI8TjKeKcff8HSFc9r3
oTIqNbzhnX0XxwFsmIzt5hlsFArgZS/rV56Dtkj8J+9e1K9i32KkUe9b30nigkwY
BOyMazcL3zyvmbCiBhMf+pvHZjPYV6ccqnBb3fs++Lyn2iYix6dYUvqqxpG2/PhE
2I7UA++DrC7mTOAOWH7LN/u++18A88bvDo5en/W8cKfMCnFMbVIKfZL0uPoZuEm7
qGg8vyi/bQFMLHOeFj3F513czoc1bjSI6h6YHI9rFv0IY5bYIJ6kMWYn0e5AOETV
C2eDL0Sbfoo7OStNg+WT
=3vUq
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--
