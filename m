From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [WIP/PATCH 6/9] Teach bisect the --[no-]recurse-submodules option
Date: Mon, 3 Feb 2014 12:04:35 -0800
Message-ID: <20140203200435.GA16057@odin.tremily.us>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>
 <52CC3E16.4060909@web.de>
 <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com>
 <52EFF25E.6080306@web.de>
 <52EFF35D.7070908@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 03 21:04:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAPl6-0007XB-E8
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 21:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbaBCUEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 15:04:40 -0500
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:41011
	"EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752975AbaBCUEj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Feb 2014 15:04:39 -0500
Received: from omta20.westchester.pa.mail.comcast.net ([76.96.62.71])
	by qmta04.westchester.pa.mail.comcast.net with comcast
	id MpFn1n0031YDfWL54w4eR8; Mon, 03 Feb 2014 20:04:38 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta20.westchester.pa.mail.comcast.net with comcast
	id Mw4c1n00H152l3L3gw4dLe; Mon, 03 Feb 2014 20:04:38 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id C3E1AFC49C5; Mon,  3 Feb 2014 12:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1391457875; bh=tlErgooPQXLH9bZzezywDB4GzH9LWs9NOoBmzuu3j0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QqHZH3FlEfqByeEs9JN7SwRv5x62xQkMI99rFWPb9v0olrU5lLJ0PddEF6IgAuUQU
	 JdNBquRS5+yFUxMmpOVPf+ce8IgCoSxOk1JzMKWjtdAAK+Pp21eVmL1eQvOkbIEAra
	 9jRbEXPdbPGKt340gmnPo+rkiUYzshtTfFpwTojc=
Content-Disposition: inline
In-Reply-To: <52EFF35D.7070908@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1391457878;
	bh=7gdaH7x9ncqNWeJYdg6LomZtrqcU201kekj8kIalQTI=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=GZy3iKIHlmifUerNVtg4Hac2ErtTLhGLNYGDWIikM2YRIyi6XAMKgVtjhoXjr5JE+
	 d/KKJDu0Doh/Yj7cCUSEcNAbmujjJe+8QBiZLsyGKZ+kxXHxl3DjdYJOUZTYqtdu59
	 +m1pBHNB3FrFE0JnOVqHVYmUM7e/PePG2pkhd+B+TeUtaNrsEMkJOUpC1XqlqvF28R
	 e8eOiQM2UaW0zdNnQ6KZTvk9BCfr7AZpcd9SySXsYKwqpbMtPStbw4AA4zVmiJB0Jz
	 WhvBhFziC49Z9fPdSObfCp+qkS0KkHI6Hj8txWFbrHSmVRstxth5VOniN0maCRm+lC
	 bDllPTkZJIWHQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241468>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2014 at 08:51:57PM +0100, Jens Lehmann wrote:
> submodule update' eacht time obsolete, which was tedious and error prone.
                    ^ each

I'm just reading the commit messages this pass ;).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS7/ZRAAoJEKKfehoaNkbtJAYP/jCl+l8j3cQdJDqhvHlToEuc
dV+83GwA/fwsGEgyz9NgMNRkMTlXLIoBbo66rWOyfirogokk8oN/oLYId0EWhU8f
jmP5pf+1jAge2GxS/mUAZWXaVaXx9uF9x3VEvRWhsYkoHBqU2lG4ns8nKCTC570j
HQEQpLK4mpZUPqboBPueA6JNPJkghcPoLU1KP4aM1ZwoRSe8Aa8YWZ+QzKHwalrA
yCP+aiBp3RKFm1BFbrfWvSsC+2UW+pLYwlLpDkNtS8ZbPhbNWf8OvlmAYdZ8udXE
lF6/iom9p0nHemalZnOi97yn5CxouanVN1y39OZ2VCGYRS35fT5ZK5g3ALXFuqGd
B1r2N80fGH2KIP4FaXZ2vSkFJSvhv80jzZHkN8hNF51jG8rr6efApdk7TW+fzOwI
Szev8/7SiHzu7vhhlYS/cC2Rrafsh5yU/MFDJCr1baR3TQdcMC73ax56gve9SnNK
8fsOs/s9vG/bQAILHoWmPxDsTlGIGjsspj9c4GWYdjHrYoEcKZ/Ccy9NVjUokfqd
c8qjbAIyGJyOIhKS+brP2DX/9KvhE592PTFzRp4wboCZGolbD3gCIvbRJYnI5zxh
oCDDYEx1kwdraovy/E1h+qXyOYohfSe4mM8ciyhfAYPLS/CDzrBBZrQR5Gtw4fug
Pn0AacSqBXU51L6KGq+y
=bBhA
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
