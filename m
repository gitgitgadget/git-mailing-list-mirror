From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] user-manual: Rewrite git-gc section for automatic packing
Date: Fri, 08 Feb 2013 13:35:47 -0500
Message-ID: <20130208183546.GC3616@odin.tremily.us>
References: <7ac63ea832711ad4bee636163e277a408cbddda4.1360341577.git.wking@tremily.us>
 <7vd2wa3dxm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=HG+GLK89HZ1zG0kk
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 19:36:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3soB-0006Tm-KG
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 19:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946797Ab3BHSf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 13:35:59 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:9925 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946783Ab3BHSf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 13:35:58 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MHW0036QZNNOZA0@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 08 Feb 2013 12:35:48 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 1A463877C5A; Fri,
 08 Feb 2013 13:35:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360348547; bh=p6yST00BYZGTi6ZB6n5Pxw8A3BzA/QoVMTM1wS+HbM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JMb17Bm9XDOOP+5cDNME9j7I2CTamH6sYtx8sWz3AhzN/QH1VCi2YFHucf8ghf8J9
 idwDnKBebRBKwZxF68rdurY8J+DPqkRIeXKOldcnu0GTknwJlXgWksWkRM9FCQkucR
 90nmnsXCBmF+p2gbfxLpj2VjKrJ3a/F6jfd6Z3rU=
Content-disposition: inline
In-reply-to: <7vd2wa3dxm.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215798>


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2013 at 09:36:53AM -0800, Junio C Hamano wrote:
> I'd rather phrase it like "... may take long, so you would want to
> run it explicitly from time to time to avoid automatic gc kicking in
> when it is not convenient for you".

Works for me.

> Removal of this is a good change, though.

I just read through the manual cover to cover, so I have a number of
other fixes in the pipe (from which I've already submitted the
receive.denyCurrentBranch patch).  Should I bundle them all into a
single series to reduce clutter on the list, or will that just lead to
resending boring fixes while we hash out the right handling for more
involved ones?

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRFUWBAAoJEEUbTsx0l5OMv/AQAJXAij0bwEPWH79AxBFqjKnm
bQXO7ucv2O+znzIqw1TzMk2lASE9puobrJj2vyc82vqic05AbNoyMapFjdwWVXVk
KBlnnn/XrOa/yBsAEcXnriE2Wz5Vmkiti9SI9W/65kN3v/RdZUe/lX89tXO3GPUD
k1cBAfygni7WsrF08+vW1BkTgyBvIEgvuZWsR5GcTSMZl9AlxMWNH8lz9DF60xHF
JzCbuKSoaIqgbMueoujR8OeG6tlDFIlI4cj4zlVWBMxLNCO/SWU0LLox8ZvzwlEY
01dVrr23gexkozAYdxfWG5GfaPetPyppih155boiskYXw4NRNZOT8vC4j5ENs5EZ
Zf6Wy4NRpMJLERNEsc+Ym8ENlpCtCHj7/F5Oggm0OmKbX2gOYW2TRPH2Lua0OQyk
Flfg2aP46AOjAA/iYFNFUAt2hJb8iB0WV9fOYRXsRCZ+0uGdmGXTVGuv4vLv0kCW
mERqhsmR3c2tvDN6QnjWS3r56l2wvg/Tu9PiX+GfyHdAmpULSHUYqvu7AARopv5D
Ix72vG2QVxXiiNvpKRsINCbrRUcaxnWWCBjQV/CDJigRxZv2iFqtnTj8JiGMTlLv
gnCwJMgk9zgaS3F5bHsFMMQOr8sbOS/KKvEcb/yBeaF9mAHXWcM5AUznE7ZwhxtC
I+4LNGur8SmsjBWnSEDW
=EJgH
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
