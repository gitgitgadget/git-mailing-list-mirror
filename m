From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 8/9] rebase: add the --gpg-sign option
Date: Mon, 27 Jan 2014 23:59:17 +0000
Message-ID: <20140127235917.GA91854@vauxhall.crustytoothpaste.net>
References: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
 <1390524666-51274-9-git-send-email-sandals@crustytoothpaste.net>
 <xmqqha8pm1yr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Cc: git@vger.kernel.org, Nicolas Vigier <boklm@mars-attacks.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 28 00:59:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7w5V-0004lI-Cr
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 00:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539AbaA0X72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 18:59:28 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51437 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754065AbaA0X7Y (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jan 2014 18:59:24 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:c122:2321:5699:217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0F39B28071;
	Mon, 27 Jan 2014 23:59:22 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nicolas Vigier <boklm@mars-attacks.org>
Content-Disposition: inline
In-Reply-To: <xmqqha8pm1yr.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241171>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2014 at 03:36:44PM -0800, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 43c19e0..73d32dd 100644
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -181,7 +181,7 @@ exit_with_patch () {
> >  	git rev-parse --verify HEAD > "$amend"
> >  	warn "You can amend the commit now, with"
> >  	warn
> > -	warn "	git commit --amend"
> > +	warn "	git commit --amend $gpg_sign_opt"
>=20
> I think this is meant to be cut-&-pasted, so you may have to quote
> the RHS of --gpg-sign=3D<key> (or the key part of -S<key>).
>=20
> The same comment as the one for 'git pull' patch applies around
> 'eval's in the remainder of the patch.
>=20
> > @@ -248,7 +248,8 @@ pick_one () {
> > =20
> >  	test -d "$rewritten" &&
> >  		pick_one_preserving_merges "$@" && return
> > -	output eval git cherry-pick "$strategy_args" $empty_args $ff "$@"
> > +	output eval git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} \
> > +			"$strategy_args" $empty_args $ff "$@"
> >  }
> > [rest snipped]
>=20
> Thanks.

Thanks for the review.  I'll get working on a reroll.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS5vLVAAoJEL9TXYEfUvaLUrMQAJEIQF8BY6xX51mLi0q9WseP
cgr43TXMA0GN//T5AY7d5XQyHqbB3odiC8YTXtFBhtbG3BDEF3BTuOyv6X45c4f5
Mg5bdcoiCkEQ9hqzEp2ilBrqmug1grGBYPZylFt+su8QIfWPl/fJlliUt+5mcamx
SrRBRpQK+BOez5ddGy/bVep1bkk/YIZiuq2Sxvv8Dv0lhdrGOD+6HxcwKgv/wQjN
7U2joxtHnj0Rrz1cfeSSCsVCAlUjRf4Ftx4owosNAEjgYoM8bsvOsYvWWZfmHUyr
IGlRMiUz9iupYp2gXyPJg9b/8sXPbSK4onhVa64EvOJ1//eOUCr4+gQSqmUME3+9
L/xgwaLLd0oMULF5cL5Xfo+4PkCcvif3WNVZFbmuEVoOlrptgpYL4AAVIg49iHvX
8brTNHY7dNQIGLEs97JLKlfgHWoFa9JByAlTDJuJS5a/7cBkj7dEcu3jfZm4RnCu
tbGLnmdD4179nsaWbbXlDJ+Hm0u/xSCs06JJbV7W/aEAoRitfEKHFhQCrq714NOS
v4UyFWU2rckodVo7hyDtobwvqNWyHZiEh+8zAIB5dFB6EJbEqWRvK6JUcoMzZv9Q
NbrFYT0xV+LwLMZavbXY0VxagnvO8nhmxr8zUjzMusmg1HqUb/ES7u3ZPrNwJIQ5
w6TqKGqnPElG3udxxmWn
=u2M8
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
