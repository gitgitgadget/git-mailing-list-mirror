From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v4 1/6] submodule: Make 'checkout' update_module explicit
Date: Thu, 16 Jan 2014 12:19:49 -0800
Message-ID: <20140116201949.GX2647@odin.tremily.us>
References: <20140114224246.GA13271@book.hvoigt.net>
 <43e8f3bfdaffefca9edd7a23574816630690e1e5.1389837412.git.wking@tremily.us>
 <xmqqwqhzzrw3.fsf@gitster.dls.corp.google.com>
 <20140116192252.GT2647@odin.tremily.us>
 <CALas-ig4=qKqpopaP163gVdBG39seWH61qqA5Jx0CR6AZkE6ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9+ohdFDUqiMJzwPo"
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 21:20:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3tPy-0007s4-8i
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 21:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbaAPUTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 15:19:54 -0500
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:56129
	"EHLO qmta01.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750750AbaAPUTx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 15:19:53 -0500
Received: from omta05.westchester.pa.mail.comcast.net ([76.96.62.43])
	by qmta01.westchester.pa.mail.comcast.net with comcast
	id Ejoo1n0010vyq2s51kKsee; Thu, 16 Jan 2014 20:19:52 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta05.westchester.pa.mail.comcast.net with comcast
	id EkKq1n00g152l3L3RkKrHK; Thu, 16 Jan 2014 20:19:52 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id CC482EFF205; Thu, 16 Jan 2014 12:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389903589; bh=jGj0tZEy2UJXm9lkwbP+XHNgaeyHGLuvLDJqGzMhgsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HOtWYidrd2p/FvKHvyWVU2CU5Ctc+IL/pugLx5G1lF5exMltE5zPIX17eQNTojWPE
	 6wcMC23MHbmzJboQg7GlAtvbEAYarS+ooacRd7Kj787LN81edMzv1ZIlCGiL+7bRQC
	 3U8N7/p+AV42jAhn1c3TVaCW+WO+mH4QEs4pRimg=
Content-Disposition: inline
In-Reply-To: <CALas-ig4=qKqpopaP163gVdBG39seWH61qqA5Jx0CR6AZkE6ZA@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389903592;
	bh=/LQnWEkxCc2kIaTzhT/dmy0S66csJKcZXrdB5coswKU=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=qUjMDjWIgbLQbJeA5vaHhQf6fPp5fH62V40IyeqgGWOMNb7PUACxqDDFVVdVB7lq7
	 Rh6x3XxkotxFCFhonf3qWyprMF0+Ky7HsBCXsTRkp3ItBM3w8iHe0pjxf85faTlovz
	 6WKfKfNp/IolauEuuLAKtVmOwm32LE7KXF27eE7gQznnXcMT/vBHRoZgu1XhQbq7Ud
	 8SMBZiiu9GXSiXsLq339eVMhnQ4VUOFD63F+UlOP8Bon/YlzxQTOYmTfO5veqkFCib
	 lHeV/GCWV+qx3qD4bfgLEfRlWFZ75GFBd2KUXGMoeWqeBXrBCNGNaLHkAol+JJ4oIU
	 oeQ8q1WYzpCvw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240528>


--9+ohdFDUqiMJzwPo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2014 at 09:07:22PM +0100, Francesco Pretto wrote:
> 2014/1/16 W. Trevor King <wking@tremily.us>:
> > Avoiding useless clones is probably more important than avoiding
> > duplicate "Invalid update mode" messages.
>=20
> No, it's not duplicate code.

I meant =E2=80=9Cduplicating the "Invalid update mode" error message=E2=80=
=9D.  I
missed the die-early distinction, but I understand now.  I think its
non-DRY to have an early case statement to validate the update_module,
and a later case statement to use it.  Still, keeping those separate
statements in sync shouldn't be too hard ;).

> Please keep both as Junio said.

That's what I said I'd do in the email you're quoting ;).  Are you ok
with the die-early validation checking all update_module settings
instead of just checking the loaded-from config branch?

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--9+ohdFDUqiMJzwPo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2D7iAAoJEKKfehoaNkbtnhEQAJGplq3tatELcMS0Xb1ZJuGN
FPsjwMRw9pFt95a7R/XJINW7rv/6FvP25xGmdGFc4OSkQzxRmSMIiYr42mhlQ57i
qcB8WaEg6gE56I6vVv+8p3L+SvfbcMqCzheOqSWJyvIihNZTxgyay00IHu2mKH52
BWAYfY0FadkomRr+ArftWWYYXtq1xoOgf3mMFQvhv+QUINiiEmq9O9i6gtIksaaF
fr52/9MUTaZtqrplQ4ibJM+Umb+lGZ7fXLAoUSHqAq46MubRJNQMpp6CgrYXQNfO
fKXLC1UIM+2ATqAhL8vZpv++t4u33CNpEyZjNCXcAf2PXaB2S2g+ylFIR4gBEwlP
qcq7ZMS9rNhCNbvnPzUKzrDcxxyCx4v63wUDT5r21Jn9wXzX5a7lSsIhH02deb+c
yrroX8jRIfyuT4ab9LLMG9Q64KmMqvXAQ6zsuDDt30w8sDXgMDfKcpvHIm0OYlks
DL6l98MrXdVFwOXDOt1g8PqNggkRO4Bx6FYjUFgoUD46h4iYlyGVhtGKoThvuiri
r82Z/3nCgW+3OHtYwdv51ubY/mWVzwIFn3FL2c78APANNrhT1iY+E19ZhZRni1ZN
iEmI8cZeaYFxh5JAZqQyOIZq0io7oPWYQqf9FZXAoZXqFj/R+VyDiqkiEi67jDjb
4QjyKCbaK6EBa0mec5jM
=e+5w
-----END PGP SIGNATURE-----

--9+ohdFDUqiMJzwPo--
