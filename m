From: Lars Kellogg-Stedman <lars@redhat.com>
Subject: Re: [PATCH v3] http: add support for specifying an SSL cipher list
Date: Thu, 7 May 2015 14:48:04 -0400
Message-ID: <20150507184804.GF16334@redhat.com>
References: <1431008210-673-1-git-send-email-lars@redhat.com>
 <1431022630-7005-1-git-send-email-lars@redhat.com>
 <CAPig+cSPGguo1mEqfCTpLbHuCMaKkH8YQhoDCOPM82Fjt0C+eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QNDPHrPUIc00TOLW"
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu May 07 20:48:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqQqE-0007U9-NH
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 20:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbbEGSsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 14:48:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56394 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007AbbEGSsI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 14:48:08 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t47Im6Yv031167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 May 2015 14:48:06 -0400
Received: from lkellogg-pk115wp.redhat.com (ovpn-112-66.phx2.redhat.com [10.3.112.66])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t47Im5C6020578;
	Thu, 7 May 2015 14:48:05 -0400
Received: by lkellogg-pk115wp.redhat.com (Postfix, from userid 1000)
	id 30964A0E2B; Thu,  7 May 2015 14:48:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cSPGguo1mEqfCTpLbHuCMaKkH8YQhoDCOPM82Fjt0C+eg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268577>


--QNDPHrPUIc00TOLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2015 at 02:41:07PM -0400, Eric Sunshine wrote:
> Format multi-line comments like this:
>=20
>     /*
>      * This is a multi-line
>      * comment.
>      */

Noted, thanks.

> > +       if (ssl_cipherlist !=3D NULL && ssl_cipherlist[0] !=3D '\0')
>=20
> In git code, this is usually spelled:
>=20
>     if (ssl_cipherlist && *ssl_cipherlist)

Huh.  At least in http.c, explicit checks against NULL seem more
common:

    if (ssl_cert !=3D NULL)
    if (ssl_key !=3D NULL)
    if (ssl_capath !=3D NULL)

Etc.  I was just trying to make the new code look like the existing
code.  If nobody else has an opinion on this, I'm inclined to leave
the first clause as-is so that it matches and change the check for an
empty string.

--=20
Lars Kellogg-Stedman <lars@redhat.com> | larsks @ {freenode,twitter,github}
Cloud Engineering / OpenStack          | http://blog.oddbit.com/


--QNDPHrPUIc00TOLW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJVS7NjAAoJEOTYsrE/X54pA1oP/10x9oNrVIYkgmHKUE8ksRTW
G30LoIFgixdaB4hXNIfUWoKGDocOMN3PNEKcl5xhGcpkZRNxMYAjffRbecbnJr1u
w28usgYapZ+lsvRWr1GX2n1yEdGttwBLnw30/CoZZ33EjfZQ9cZCY57sJExglPgy
M+M020UO4PBQHc1SWtQUGqJBIxK9O5XwiVs8XEHvbyQnX/mvfh1DWnTSl9FtXDDi
TBLmEFGKkKyWzy1+Zw8zwXZsKfICtMu5rTm8DYAbj/b3pWnVn/QxXLZJfnBsaRPx
DvjlSD2s9WirSqdNTZ4zMwNrfjLWhWgiY1cgfgpPJdI3nKhYWRXt0dkZt4In/Sm1
UeCY1MuG9n58bjfDBiBavl7AAnDvOnQ8MKkoNYuE4YUtjFwMT/9+Q5L0y6BCq6Ax
tkUbaijov0R8tIXfvqO6IQ5a+QHBmxzwE27sppyU5Cyl07OTj6EefPLUF5HYUGnu
kIY8FbIbkg7fnw6OyZ7qJUZHagFORNOkR08v4f7fDthdQ0hpputhgB51qnICz6Ox
mhTH55lCp28433rTulmFsG7IqsgRuDUJclmi77+ZJBb0jcUChjVCu80YGVipmXyB
PF72MwiAP/ZuUtaUnfnz39jC/o/B1xySLYG0O/nUAH9ozU/Iw05QzY3h1wrMjNSd
ZYAL0x5XnMEx7Lle3no8
=6uw1
-----END PGP SIGNATURE-----

--QNDPHrPUIc00TOLW--
