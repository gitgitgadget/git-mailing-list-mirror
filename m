From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 12/15] user-manual: Use request-pull to generate
 "please pull" text
Date: Sun, 10 Feb 2013 17:29:17 -0500
Message-ID: <20130210222917.GD8377@odin.tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <3d860e7c19b33ebc2725eb86ec481f966e3007de.1360508415.git.wking@tremily.us>
 <7vehgnst8r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=XvKFcGCOAo53UbWW
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:30:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4fPH-0006yH-Pz
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756927Ab3BJW3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:29:33 -0500
Received: from vms173007pub.verizon.net ([206.46.173.7]:32706 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756748Ab3BJW3c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:29:32 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI00037LZSUK3A0@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 16:29:18 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id CAA64879B6D; Sun,
 10 Feb 2013 17:29:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360535357; bh=mDjzON0ey/swU05dhGE5QwrHm+iRLzcqF/IebNgllhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KpLPVqCYvWGtUp70cHlgp1rQFgpeYAfNZmNuOdIha/UP7WioTQqwxKbeU8iPHZOSw
 OZfbUdrs6tlWeKAY6uiDnRjP6ns+Naf1+XUl//EOA+T12Zz2wRqJR4tfko4SNeTO86
 5Drf7LRQVn5HO+mlfTcVbRcVDrHUgkHvTZZHF7aU=
Content-disposition: inline
In-reply-to: <7vehgnst8r.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215955>


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2013 at 02:23:48PM -0800, Junio C Hamano wrote:
> The request-pull checks a lot more than "does a merge base exist?",
> no?

It does, but the man page doesn't list the checks, and I didn't want
to read through the source to find them all ;).  Maybe I should, and
then update the man page :p.

> Does the examples in this flow push out what you want to be
> pulled _before_ running this step?

Err, yes.  And I should have used `mytree` unstead of the explicit
URL.  Maybe I should have an explicit push just before the
`request-pull` for extra clarity.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRGB88AAoJEEUbTsx0l5OMikUP+gKgNGlwQBIjw/H4L/6ZGrdl
5Mrw8EIOtfTgxP+GMhypz5yQGgfOmhLvJOzbM1F90ks2D/y2aJu6xy0gd4OOy/ck
Xbame6PniuZlOpE18dx3PEOcH/SRZxZ1vC/c+R7p00mc7SLjZI2/BxdpMV4xzA/C
SaornBApQdNKlzWV5fByJKhZ80DIp9+5l1vYcnVIih52nhS1+Q3XuxKrZ1WoeW3J
/HKJLH1inV/jw8UMLwqhdvSKS5ray+bE8Riflz1m7JqGW7SJzRh/DgFkKLDAv06T
ECDi4/xiwraGSygbkwdOy6X4HowQ9ogaAL1jeG+awp7PR9fQaKLSRuDWB+KeKhj1
8pwVnotg4NoJ//8NOD+RO7bR3WQgCIctoBHPL6GrMKI6rSah2PNb8Bm6H9jSPp5d
/FeM83v1C8Ahm41RL3jEcbJAv+bBqr40QD0fOh1yIMF/rzPICBbaFIKscOKvjqiI
653h1+cLZ1yzTjAIJPUsBRvAAGVQGKDHyaZYuS2Dm054hKKIfqv9euez1mpxkPz+
UZXNgsZ0nAc/ycKAxzcEftxkqCbcJzjjcNTXvj7VoMxJTP6Ws9NGXUrs8F2TvZO2
hHaxMnOqMQou/Pj+njUkBvYf7aHXroi52tXzifhdVYb8fIq6YZ+33EHeINiidgsw
omxdlkpYnJIxmLF8Fzmc
=/SFL
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
