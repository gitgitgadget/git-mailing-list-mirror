From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 1/2] Introduces xmkstemp()
Date: Fri, 31 Aug 2007 10:27:35 +0200
Message-ID: <46D7D0F7.1050302@trolltech.com>
References: <20070814164453.400b9c55@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9DCA07346E2F8CC69273F725"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Fri Aug 31 10:27:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR1qu-00032C-Cf
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 10:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbXHaI1f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 04:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753797AbXHaI1f
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 04:27:35 -0400
Received: from esparsett.troll.no ([62.70.27.18]:60781 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027AbXHaI1e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 04:27:34 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id F407A7432C; Fri, 31 Aug 2007 10:27:32 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id E7FBA74329; Fri, 31 Aug 2007 10:27:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <20070814164453.400b9c55@localhost>
X-Enigmail-Version: 0.95.3
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57132>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9DCA07346E2F8CC69273F725
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Luiz Fernando N. Capitulino said the following on 14.08.2007 21:44:
> This is a wrapper for mkstemp() that performs error checking and
> calls die() when an error occur.
>=20
> Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br=
>
> ---
>  git-compat-util.h |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>=20
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 362e040..ca0a597 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -303,6 +303,16 @@ static inline FILE *xfdopen(int fd, const char *mo=
de)
>  	return stream;
>  }
> =20
> +static inline int xmkstemp(char *template)
> +{
> +	int fd;
> +
> +	fd =3D mkstemp(template);
> +	if (fd < 0)
> +		die("Unable to create temporary file: %s", strerror(errno));
> +	return fd;
> +}
> +
>  static inline size_t xsize_t(off_t len)
>  {
>  	return (size_t)len;

This functions needs to be further down in the file for
MinGW builds, since mkstemp() is forward declared later
in the file. So, something like this:

diff --git a/git-compat-util.h b/git-compat-util.h
index 9e075b7..f9ba8b0 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -477,4 +477,14 @@ extern __attribute__((noreturn)) int git_exit(int co=
de);

 #endif /* __MINGW32__ */

+static inline int xmkstemp(char *template)
+{
+       int fd;
+
+       fd =3D mkstemp(template);
+       if (fd < 0)
+               die("Unable to create temporary file: %s", strerror(errno=
));
+       return fd;
+}
+
 #endif

--=20
=2Emarius


--------------enig9DCA07346E2F8CC69273F725
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG19D4KzzXl/njVP8RAliDAJ9wdk95ogJsVQbxTxXODDZKofASnwCguVuE
raKVt+tr/7yRyUnCK8/Gz/4=
=hbRn
-----END PGP SIGNATURE-----

--------------enig9DCA07346E2F8CC69273F725--
