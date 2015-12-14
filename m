From: Joey Hess <id@joeyh.name>
Subject: update index mtime etc metadata
Date: Mon, 14 Dec 2015 16:44:29 -0400
Message-ID: <20151214204429.GA31013@kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 21:53:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8a7e-00037m-2L
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 21:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbbLNUxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 15:53:25 -0500
Received: from kitenet.net ([66.228.36.95]:41206 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932080AbbLNUxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 15:53:25 -0500
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Dec 2015 15:53:25 EST
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=WESnGE1B;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1450125869; bh=4qZhDfIpRlNX/o/HCX+sjqeNTJXZqoTobsZGWTzO9IQ=;
	h=Date:From:To:Subject:From;
	b=WESnGE1BdxtPxKcvB37ZdYtQt2xWdOF3XS5QDHmjV5bl3QwBEM+eAwUkniyxgYCyt
	 7zai6lCnP0LQPnHZp84eoYaqGXaTrICyRjIQZPvBJC+h37zby+fU38pB/MszcjeVPQ
	 r2vzMQBDqUiafpAK8C3tON0q2b0iQj5zTHW0il9M=
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-91.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BRBL_LASTEXT,RCVD_IN_PBL,
	RCVD_IN_RP_RNBL,RCVD_IN_SORBS_DUL,RDNS_NONE,SPF_SOFTFAIL,USER_IN_WHITELIST
	autolearn=no autolearn_force=no version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282410>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Is there any available plumbing that can change the mtime etc metadata
that is recorded in the index for a file, to user-provided values? Or,
to force the current file stat metadata to be updated in the index?

I know, git update-index --refresh, but I have a case where that's too
expensive. I'm using smudge filters; I know that the cleaned version of
the file will be unchanged from what's in the index now and only the
stat metadata will change, and so I want to avoid
git update-index --refresh running the clean filter, which can
be quite expensive for a large file.

At the moment I don't see a way to do it other than using eg libgit2 to
update the appropriate fields in the index structure.

--=20
see shy jo

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVm8qLMkQ2SIlEuPHAQKQIw//Q5bU8QCO29gSLKs4/iBxBwNlgPS9p1jy
bmOp8mfGZhIB/zEQl+eN3abajdFX3EyeqvemPMjHj2rr0s9/9uY4FOrLSAiRM9yy
XCw2L+2Q3K/JUM1o4v688wvDAeIJC1spFR/5Q+SlGr/Am1pRQv6+0E+vMJYJH1Pk
cjZxFcjBq8CdjCRVgShDpOY0I5sHGm1oqQ/b/qWEPGGoD12HE0lv+7u/rdDw1d3u
UAMdDkQeybrMY+tbUq4Rk1CInvcM7QmoF9ulCHOuWkegtFtJo6tX5YMJcFzyh0mb
b8Cw/WR3gsfmSv76HRKi1NwHdBVgrUAMhkbvbzMHrJZEhJUYyDRnhuG6xFOCjRrh
g7HyI3PI0Ta0eU5rSk+E44Rxlt6OQwyCds6qHENhGagrwzX41lA1KefBgbgrqFV+
GSFaBxl0gRMIPyOP3LGVeF8K6mgoO2a78upsVW3XRi1y0oFoPWB2bSC/pDc6i4u3
qu483/K5yoboTfWkUiVogxSGUqV9qrfI8GgTYNzOzzy7KQ7c0bsY15AbaZMB75+g
8VygNj9U/Jf3IJ105BnzSComsTHDtL8akwppz4j/a6dGneZpK7RoYLDDYyVsPAFc
XykacM55XqXHc434wBB/erQkidN/sYi//eBr+llDx4QvfBRDFej2Km4PqsY22hdp
5sm/H0YiclI=
=FAxX
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
