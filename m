From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] http: add option to try authentication without username
Date: Mon, 15 Feb 2016 20:36:59 +0000
Message-ID: <20160215203659.GB57185@vauxhall.crustytoothpaste.net>
References: <CAHdYDCq+MiAJoCPFd3Qn9VjAzoii8QgTOOV7HXEV8OdzW-dgPQ@mail.gmail.com>
 <1455561886-42028-1-git-send-email-sandals@crustytoothpaste.net>
 <CAPig+cTr1eW1KLsZGpY98hUhJ2EHdPopz9C_gTztZRdNPBQTmQ@mail.gmail.com>
 <20160215202937.GA57185@vauxhall.crustytoothpaste.net>
 <20160215203451.GA29705@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Dmitry Vilkov <dmitry.a.vilkov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 21:37:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVPtQ-000548-3h
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 21:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbcBOUhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 15:37:06 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:40128 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751555AbcBOUhE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 15:37:04 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5E1B2282CA;
	Mon, 15 Feb 2016 20:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1455568621;
	bh=3Cs5I4XwYKFd1aOaWcuq5OcZ+obJ1RvKrW9Onj5GFwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8/qvvdikdK2rfCxwCtVLUWfnPicjfHvmyEdnUuIBE8xceGe74IVtYLg2dyBlkPIe
	 PgsOWxqINp1A7Yv2TAUih0ZEhmWX8GJLlLgm8YaLGaHDRi/BTUFUYYJvsZE9/+Nrl8
	 dEV5yyjRC5v/BvSHJ2EhRzROuYZMHi62q5rmAgLwxOzo6fwIFfoftwTkUmfpsuavst
	 mtqbnNdCLbjIPwG+MyUW0wkcfgtvdXTQ/p+mcdyhZ6GgXMIkrNpaRwK88csDRXj8vs
	 5K4dGGl3NdOTIDjrochT0dMUbm3seN6KCkq22/jObd+5Vc37mU2B9SMaTUMu9WfVwh
	 DVDSFWKppkW3AeTRXzZz7ksAwsUIm2l+fTesOAsFqgxXzk2y2YbzbxlvbUfZIz3Epv
	 mAAJ8AusQ5q+IEK8TG1WkCHzw3H8abVNGPujbsx2ik8cgwjq8A5B/wiDVp6IAKREYn
	 RW2/JMI8yno3iLG/59hUbEsAtAtT+Bsnn3zG+vEdCEoiR8mNowK
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Dmitry Vilkov <dmitry.a.vilkov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20160215203451.GA29705@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.3.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286235>


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 15, 2016 at 03:34:51PM -0500, Jeff King wrote:
> On Mon, Feb 15, 2016 at 08:29:37PM +0000, brian m. carlson wrote:
> > That would work.  I was concerned about the credential_fill call
> > actually prompting the user, but it appears that it doesn't do that if
> > the password already exists.  I don't know if we want to rely on that
> > functionality, though.
>=20
> Yeah, credential_fill() will treat that as a noop, as it is no different
> than getting "https://user:pass@example.com" in the URL in the first
> place. But it will _also_ send the result to credential_approve() and
> credential_reject(), which you probably don't want (because you do not
> want to store these useless dummy credentials in your keystore).

Correct.

> So I think this hack should remain purely at the curl level, and never
> touch the credential struct at all.
>=20
> Which is a shame, because I think Eric's suggestion is otherwise much
> more readable. :)

Yes, I agree.  That would have been a much nicer and smaller change.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.11 (GNU/Linux)

iQIcBAEBCgAGBQJWwjbrAAoJEL9TXYEfUvaLTjsP/21cyrpN0cFldCwzq8gtEZSE
J0aKkiM7r65ZFHCmCxMLR0r7MQhpqI7dG3e98bjPYDkwn9T5noG6kqltMrFoUtTT
La73NNTiOdWvrHUGZt3dzLaoiaxGW9+03O7bZz/BRJIG8KpwoRvGOdsQRBTS8zh0
9QProa83SXIczf9tGW0fx2cwSuejrj8v5zV20+3uA93oqjsaSlNBUeATolfGPt8d
O112hVdp9Vve7R2Rnh+gQuwh3+OJf3W0UpMuPCm40WQQspYUFhtw6Ke1nVP37+hw
yKfCh3Vfj0NX6o07OcjzMMfA4oohx5UOI5RC5SvkcwXXQSBAdO9uPnylyARTKZEp
COeeGNRKkxQ1KM8aTJbVMnZcXfCgpzts+ElXhIIiYYiL4E2j19rL41Xi7Twt0kvF
USAPEoPp4qSIzCUlWOsltnQUxRRpMbnQfJ36yJIYIvcOxjjCpjVfpjRFZwa4YY9X
Y/EpZvForvTuTZ5bmijMaGUAJ2ukXSXHSuOq/5XYT7GCgBPfdkve12Sto+DVnx/V
fFuQKFOd9OSmDjfAkRgYvoMHTgvDoC9QuX+ewQTA8TeaGvo53ki5x0NiHuVltY11
a2QrUGpKC/ZZgZCVqEvveSnRSwxlsrU20Wn5ZIk2WWylklI1eZoGd7da4kfCq1qe
u30eVSIBbBjwijlDSiBM
=yDeW
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
