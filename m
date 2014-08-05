From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] Documentation: avoid dangling modifier for imap-send
Date: Tue, 5 Aug 2014 00:54:51 +0000
Message-ID: <20140805005451.GA10435@vauxhall.crustytoothpaste.net>
References: <1407023821-103681-1-git-send-email-sandals@crustytoothpaste.net>
 <1407024847-104449-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqq8un4rtv6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 02:55:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XET22-0006Pp-6F
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 02:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbaHEAzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 20:55:00 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49307 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752583AbaHEAy7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2014 20:54:59 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 08E762808F;
	Tue,  5 Aug 2014 00:54:57 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqq8un4rtv6.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16-rc6-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254795>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 04, 2014 at 11:29:33AM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Avoid a nonsensical misreading by moving the modifier closer to the
> > word it modifies.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  Documentation/git-imap-send.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-s=
end.txt
> > index 875d283..23231e1 100644
> > --- a/Documentation/git-imap-send.txt
> > +++ b/Documentation/git-imap-send.txt
> > @@ -43,7 +43,7 @@ imap.folder::
> >  imap.tunnel::
> >  	Command used to setup a tunnel to the IMAP server through which
> >  	commands will be piped instead of using a direct network connection
> > -	to the server. Required when imap.host is not set to use imap-send.
> > +	to the server. Required to use imap-send when imap.host is not set.
>=20
> To be honest, I find both versions are equally confusing.
>=20
> How about dropping the three words "to use imap-send"?

Fine by me.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJT4CtbAAoJEL9TXYEfUvaLzoYP/RmRyjG7v8ZXFjivJmYdM//a
SyYORyY2eBcghJfkCvLeYMQVWMZheJ+47v79J4Z1pgin2y5PQBR02Y4DQvs8zZs7
dmb03n2jOUTdiztHiGM787I2ewTZ92DEAhPYghULyCzCVy4WgKcxzfmvijANulbY
eWA2xEv5iAZNG3RUcPTD4QZk4B4nSeRY7tRfoJcvwB7fchXV4RFAc68V7r/etPza
S3Nvlw6sUxI1pOYpqgqknwMaHNAn9fyAQ9tmn37L+3mwYD+nY7Lal5pS+G1NdjWQ
Ys4yt6LbXJ5getDdyoviLWBQDeOFEwZ5Fu9P6hCrxgTAgJRetVbs4kxXe/RhSeTC
8E0AOo2SfzUOx8iW4wPOsa6ji9cnw9Zly5+a+TeOzi7XamwsM5Tm+dbMh3jeOHq8
EfLI1yRHuI6hhynnL8Cghz6QzJSXrTqU/nblQuELke/9jrF7IXDspNuMzey9qNhj
2j3hqlXlrNidG4vhToWH49X6WqpnwytgvLWfekT/6krZIVMG03IbipFJU2sDOP+H
WkotYXniZqlaE8eRxeMqk+Ry586FNoQsnxGY+Ggn0jiFogamyV1R8bGOdTC4Kocp
lecSodjVubcC5cyOd0KkqGUgnRmVU4yZGUY9sUcUnv1cFxnoLF4TColXA2OlLOH6
fxbphkMka4yyYGInzkNQ
=5R5R
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
