From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] config.mak.uname: Cygwin: Use renames for creation
Date: Sat, 8 Aug 2015 21:06:28 +0000
Message-ID: <20150808210627.GB155450@vauxhall.crustytoothpaste.net>
References: <1438979428-5888-1-git-send-email-adam@dinwoodie.org>
 <55C66AF2.3060706@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Cc: Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org,
	Eric Blake <eblake@redhat.com>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 23:07:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOBKd-0000GW-Bg
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 23:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992769AbbHHVGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2015 17:06:36 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:42495 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2992746AbbHHVGc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Aug 2015 17:06:32 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6BBC82808D;
	Sat,  8 Aug 2015 21:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1439067991;
	bh=G0KwV9SItDBQ06g/YiM6mb99CIELo17F0/CbwI4YLnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kS3ahldCmM59SBrYhVwdFgByuNEjRD9KJ0CFWbgwDY9/JaJLfMn13fg/xBVZNtiZm
	 MIzQO4Af3trhEQ11AhId9xX2hHb4jyC97kkfKgNJ52a1UORSOlkHe1e7PzmHqJftgY
	 cYRBcE0Yv/a+QBuvQ1HoePvdfZAcp+WFSA1CeTjHZGwlcFUvTiBJxpNBbToQGcB10O
	 ivkfKugQT7mYQQcKvZpjqAYImM6WPYyglQsxJlUAXR3VcXQEDX5/eUtDCrkXy4Eqs4
	 PvxKXTholWU1NywoQl/Uoa3Y4ChJ4ZGPftBm3472Ai5yzxp1RjndX3q7iwg5xRxlTD
	 2DRRtlHU0XgroqNczdNUMSSDmCkAJMwEZXeTKH4b7AcPSeJTlwvU6+9tsdAw+/CEeP
	 KewQiEGFHn/RqUlcOUpL5R+60lQjNXPy31orLlFAH859uxITmfX7bo9j8bCXVMdo4C
	 qq2dNVmQGY73e7yegrmXl4O+jgNmkkdNFoBPRZrfGcSYxLYHDtk
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org,
	Eric Blake <eblake@redhat.com>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Content-Disposition: inline
In-Reply-To: <55C66AF2.3060706@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.0.0-2-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275519>


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 08, 2015 at 04:47:46PM -0400, Mark Levedahl wrote:
> On 08/07/2015 04:30 PM, Adam Dinwoodie wrote:
> >When generating build options for Cygwin, enable
> >OBJECT_CREATION_USES_RENAMES.  This is necessary to use Git on Windows
> >shared directories, and is already enabled for the MinGW and plain
> >Windows builds.
> I've been supporting use of git on cygwin since about 2008, this issue has
> never risen that I know. Whatever issue is being patched around here, if
> truly repeatable, should be handled by the cygwin dll as that code is
> focused on providing full linux compatibility. If git on linux does need
> this patch, git on cygwin should not, either. So, I vote against this.

We've gotten a lot of users on the list who ask why their Git
directories on shared drives aren't working (or are broken in some way).
Since I don't use Windows, let me ask: does the Cygwin DLL handle
link(2) properly on shared drives, and if not, would this patch help it
do so?  I can imagine that perhaps SMB doesn't support the necessary
operations to make a POSIX link(2) work properly.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.6 (GNU/Linux)

iQIcBAEBCgAGBQJVxm9TAAoJEL9TXYEfUvaLb1gQAJBL329kOwGqsRXwdqjEUy6x
cMpBIo1mhTQXnTLLAmDP2RyljVFhdLzNsSvzDtseZKdpR5lYz9CBc9whsOrXv8iD
fOVKJjnFplW7T+SlQQmdm4IZWLCD8yBsbY1voJ4q2PyrbKsBMy6robG986eKIk1y
CDQfKxvy9GYsjej6I27RRJApYRhbHB1vuNEDGpqmlC2Q/Ddpjo+6ez1SGZ/W33DK
2dLbZxC4rpYtqmsxIYLJASV4d444MG5ZHhAwglm3cGdWISBEmKZabAEOUbPsrDvq
ZSkfRxh/980zZRJBNfbempyEjx2dUVgIIR6ukAaRrV8ycgYrjogtm0YHzxCiIrBN
NBXRsznnXqYRA6bttYNZ9QiqR6yOSUg9v/NFgZeT+FVNxloJq9mZb+tVecobNKv2
g2occxT1NGrznAnykro20jzbjcMvM+KEE7ZCzk2eiatg50Qpn3aZJEP8yOeCVa/a
ezcayNV6rkwbiN0t9VlkKol41UWmUFMitemIIkyItqYLLAoDKi6bNwh1v1MBQ008
zxVAXbNjdIQ6PmZCOHjbOWqkBalMPyBVnTcZjfHXm1SdjpGaL0hhYCRFjKkb3ym8
AkmfSUk89IZuG4/EWmtpJWm/EaHIXzzAhA5OPLP0xqGP0vMqdKgt5QBQsUwhLemf
LjLqtn5MdOP30JRFa8Ak
=ED9I
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
