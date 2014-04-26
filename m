From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: GIT, libcurl and GSS-Negotiate
Date: Sat, 26 Apr 2014 17:47:18 +0000
Message-ID: <20140426174718.GC238861@vauxhall.crustytoothpaste.net>
References: <CAPc4eF__gWMy=E-8tdpMn_irA4m7mYF3=cwN6JeAqJsdPshNLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Cc: git@vger.kernel.org
To: Ivo Bellin Salarin <ivo.bellinsalarin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 19:47:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We6hK-0007xA-1k
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 19:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbaDZRr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 13:47:27 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47350 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750781AbaDZRr0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Apr 2014 13:47:26 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:e557:515c:f5ce:8138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 541BF28087;
	Sat, 26 Apr 2014 17:47:25 +0000 (UTC)
Mail-Followup-To: Ivo Bellin Salarin <ivo.bellinsalarin@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAPc4eF__gWMy=E-8tdpMn_irA4m7mYF3=cwN6JeAqJsdPshNLw@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-rc7-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247169>


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2014 at 07:17:36PM +0200, Ivo Bellin Salarin wrote:
> To shortly resume it, the problem is that:
> * when the authentication method (WWW-Authenticate) is Negotiate AND
> * when the server proposes a NTLMSSP_CHALLENGE in response of the
> client's NTLMSSP_NEGOTIATE,
> =3D> libcurl yields an "Authentication problem. Ignoring this.\n"
> And the communication is closed.
>=20
> At this point, in a normal communication, the client should send a
> NTLMSSP_AUTH containing a Kerberos ticket.
>=20
> Having seen the libcurl source code, I think we're passing through the
> lines  from 776 to 780 of
> [http.c](https://github.com/bagder/curl/blob/2e57c7e0fcfb9214b2a9dfa8b3da=
258ded013b8a/lib/http.c).
> Some guy, on the github issue page, has suggested that this could be
> related to an update of libcurl, when git was at its 1.8.2 version.
>=20
> I'm not debugging libcurl, and I can't reproduce this problem @home.
> So, has somebody already experienced the same problem? Is there a
> solution?

I'm personally using Git with GSS-Negotiate (and MIT Kerberos 5) and it
does seem to work correctly for me.  For large pushes, your server (and
any intermediate proxies) will need to support 100 Continue properly, as
there's simply no other way to make it work.

What version of curl are you using (and what distro if you didn't
compile it yourself)?  Also, can you post output of an attempt to push
with GIT_CURL_VERBOSE=3D1?

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTW/EmAAoJEL9TXYEfUvaL4BQP/2JJoasmMLvyb1Y7HOqHZzDQ
5TgLD15lWFNEBMkie5p8svMrSDWouUAthvshOwhV9fQ7H3U7aHBDam2hVVQ1cmAI
x0uZ/LtjM+fPhL9uHnPSrK1+AzznN7Byh6cHvDkYYwwP4YI6XGmfATbru0yF6nAr
8GslAxfWXgw4IiASYEL/ssnW75qCn5JLzAFW0xJ/ML4DG/AkEbUJsCTZZGNyE27x
vIID53Pm3j8C25SPPQc1XHH+m8AewWdiBz4sp05eNiixVGVVFcB5yTL6m5cRN1y4
MJSBl7YA0KPakCpIvaWVEkc4uaYQuniVCSVNC3yWGajVWNbJyuvZNrDFkxJkfY48
a3TTJNFdJQSUw/0430v/4uVaq/AiKdDNWHXTS61mDRk3E7qqFJ9b3ImoyBCkd6Vy
HC+1UueBUUG0fhvm/DNxkLiOl35AKsa7ZiLSUfxBF/Md+tki57r+B6dexEQnF3+j
gRmz4+zujem/iMdSpS8EgMM9RQtdFdl+j5QCvWpAzVXxiOkVK8pP0LAnJaM3coj8
kvSOOeIKeUA28AuYbdo9QHhlZ7u2vRX1YwzMzQ0oxvkLl7+ukeJkxMEpaYZDRQGq
X3OTlEuZujeQevCqCwuUrnL5uoJCCow83K7dcv0N5KcJfBeWQETxCB3RzAjWG67x
lbB96PHpHrFQuH0A3iP4
=UQul
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
