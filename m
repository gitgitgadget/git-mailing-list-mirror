From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] http: add option to try authentication without username
Date: Mon, 15 Feb 2016 21:41:10 +0000
Message-ID: <20160215214110.GC57185@vauxhall.crustytoothpaste.net>
References: <CAHdYDCq+MiAJoCPFd3Qn9VjAzoii8QgTOOV7HXEV8OdzW-dgPQ@mail.gmail.com>
 <1455561886-42028-1-git-send-email-sandals@crustytoothpaste.net>
 <CAPig+cTr1eW1KLsZGpY98hUhJ2EHdPopz9C_gTztZRdNPBQTmQ@mail.gmail.com>
 <20160215202937.GA57185@vauxhall.crustytoothpaste.net>
 <20160215203451.GA29705@sigill.intra.peff.net>
 <20160215203659.GB57185@vauxhall.crustytoothpaste.net>
 <xmqqsi0tpsa5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 22:41:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVQtT-0000oD-Dc
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbcBOVlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:41:15 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:40204 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752598AbcBOVlO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 16:41:14 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 36475282CA;
	Mon, 15 Feb 2016 21:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1455572472;
	bh=jQkZLoLYxk+jsxuae6pJFan9OS0SfRAgHQGqkNNU7qQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hxzDsgqPJzsPLKjMWXHnPmwfKJCOYSEHW53S/sfVZZ8v0Xj7/OpTmik2vX2Uutr7o
	 DkULcS0LMvF2JPgXQ5I0C01/Dr5KoU1gwmIwZTzvQHFK5FQcGkEbNdPnFu7c+9gNgv
	 B12uQIA62dW8tqLVrkrq4mIhQxQBGZWlNBSKOKl3ESw0ApKhIas6tCd6V6cDLrvXBM
	 PztMjRN1S9uWkrTIPPZkskkBpFAXnDcAsE1sezR8tp2PgELLH1vRVata2RT6A0s4kU
	 yRL5FY/PJlZM2Uj/ZFkFZ3/4gS+3QMz77AimWTE7OAPaN9LUuEfMV87WcNrCnYP+Rq
	 +gzsWMKxG88NfjLx0fmVp+nYoJKJ+5ho/0IQyqHNBoj2Q3vQK5i8L7sJBw/g86hpG7
	 ryx+c0RC+NOQa+zLIKAuzkM4luggPQdomMXntunyut+J9cKhQIImc3KX+6LfDOC7Ti
	 +6K7Mv2oaxT89ApJymacYeitTy0I9Tu/quZdru38rFzXuY3uKQ1
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
Content-Disposition: inline
In-Reply-To: <xmqqsi0tpsa5.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.3.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286250>


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 15, 2016 at 01:39:30PM -0800, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > On Mon, Feb 15, 2016 at 03:34:51PM -0500, Jeff King wrote:
> > ...
> >> So I think this hack should remain purely at the curl level, and never
> >> touch the credential struct at all.
> >>=20
> >> Which is a shame, because I think Eric's suggestion is otherwise much
> >> more readable. :)
> >
> > Yes, I agree.  That would have been a much nicer and smaller change.
>=20
> Alright, reading all reviews and taking them into account, the
> original, when a Sign-off is added, would be acceptable, it seems.

Sorry about that.  Please add my

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.11 (GNU/Linux)

iQIcBAEBCgAGBQJWwkX2AAoJEL9TXYEfUvaLuO4P+wYVpjjbnQrrnQq07482AXPb
a7Nly0J1RtPi2b+0sL9RvUsoZAiWKKIMuePcmOVf/iqaoNhUe93FYj2jxlzlpX1h
fI7WM8ofjjeHJ6O7c5p8fET7C2gLzneYd1wFYNZHJ9qWeMCl00mh71mLaaXORBV8
NihbhWn2946lxfvgsnyz/b9zXjlvWiROBWcyGcz36Ep4eueT/Tex/xsV8dV99V78
eNoTc0vSsrf79T+mJh/AGPT6FIjefDC/+lBS6eCiyzLVItiYqKd6Z3GUz36Eae/U
T7C6XrNHykWi1vrekm7VtIlIqm3rJPZC2gvsvNF1T54mvnFwzCWgFS5VM2A3Mhf5
HDJcLiVt+20x4KQ72SUhXVag1MVsH6GwjOql6KWO7gF4fjEyexEAiK7aBtdB/BP1
45p9MLIEOJrU8Y1BaagtH0h79MmyAITHUjgAHehiu3DmVm3X6VHRrpRQR6yh2TyX
GJT7uYYdbeYHMEvvtWMMxNpzDRvLO+hBDcpPe/LNuf1fbyAt0c6NTKLZNc8m6gNh
gNC6fW8ItfQo9Dilu8X141mRiJLzf8vdI2jl9PtIBR7D+u7IB55dfVWv8DPaYh/L
r6at/zAZrgRNTTvc6bV4FOrdVH6qSvE6MvsQ4ukYPzQ5utNLyO4MqnqN58VslDRb
pBI40QEFroTe6pNe23O5
=xUVf
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
