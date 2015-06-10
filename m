From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: [PATCH v4] receive-pack: Create a HEAD ref for ref namespace
Date: Thu, 11 Jun 2015 01:39:21 +0200
Message-ID: <20150610233921.GA28452@leeloo.kyriasis.com>
References: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
 <1433526142-2413-1-git-send-email-johannes@kyriasis.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 01:39:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2par-0008WU-AE
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 01:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbbFJXje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 19:39:34 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:43623 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbbFJXjc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 19:39:32 -0400
Received: from theos.kyriasis.com (localhost [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id f4bb02b2;
	for <git@vger.kernel.org>;
	Wed, 10 Jun 2015 23:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=IS03A4nMKtLoKJSjb/49LNEhXNE=; b=BbQMkC
	ewBRJN9sWn0mblvaj9Y8ZnNOIZuakIGuNNSIw/dyOneSBjJP6qW6vT0q4JZOKPY8
	UhimG68QqryDa1fDYtURlO+KT1iCi0P611cGpaLN6sllvsHrbuGFdVXyEPAou7jc
	28cujlxz/ue7lbs9fe1r79GtQsmm2zWZ5AKO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=Ka1RCZMVm1f6k4gTW4QnDXZ9jXI4nbEw
	tG//YNZ4gC0rbFLPq+UloSiJDUoo90Tn3dVYZmti2lzpxQWdw++uXxFoKWNuUPmn
	EWmojzB4SNKFC7P9jQqnd+O+rcYNr5Jy0jvne39Q3IgBfdWUzAQQOOl+FvLIKK17
	GBOLry+Urp0=
Received: from leeloo.kyriasis.com (host-95-204-164-166.mobileonline.telia.com [95.204.164.166]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id 0e430192;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Wed, 10 Jun 2015 23:39:27 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1433526142-2413-1-git-send-email-johannes@kyriasis.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271367>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05/06, Johannes L=C3=B6thberg wrote:
>Each ref namespace have their own separate branches, tags, and HEAD, so
>when pushing to a namespace we need to make sure that there exists a
>HEAD ref for the namespace, otherwise you will not be able to check out
>the repo after cloning from a namespace
>
>Signed-off-by: Johannes L=C3=B6thberg <johannes@kyriasis.com>
>---
>Changes since v3:
>  test:
>    * Use a single printf statement
>    * Check that the contents of the file and sha of the commits in the
>      initial and cloned repositories matches
>

Any other comments?

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQcBAEBCgAGBQJVeMqmAAoJEJAcHDIOsNRdEOkgAK2+meBZryLbh0txobBlcqNj
tMjMrUJcrP6VN1UoYMXHq5PLT/2VAV/hhEwJMoKqtamptf4tLpTmLXCGBvaH33q8
4jY8PIBAhckxfA07bylFJUwuhCobWJj8wIuaFQRr7gCiN2jvLOhIbzKLbvl1nIUO
cs33O1Oh5xINUJb6hoqrT8/Zy367Vn4mRpo+GRlWuJ63ML/fPZccZUf0zgnPcLgN
un3ygnfCCaJz8ItpDo3408xlkCiUkfiPnpUtajvpySYdybcHA+pPSPxqLlpz0oPt
0yqYGG8jo1hO/iu2bWY+8eAYiAXnBCBxkmcALBFV4yfOkf3yHs8W3rDEp4xe2bfI
OPxJXyI0obUiXwyMkZuVqztROjuAsa4NcBe74KTwwBxE11J99eoxEPejqb3m6y0Z
BK5yOJzZ0IUMJZXx5pbNF9BGvOFxbYKHZoiA3ufNBcwgKaeMcR5zMeTrV4mjs6H7
PRJPZGTEgSYpFEqgrrAKxgSHnXoShJnpt9x6ggOu6tABzD1aEnxWEBnDvD153sVw
YbXdXuWVqQTAymAvva6t3NFej/i/1k1K9aAMx1weba2jv8P/K6Zgg9yIZzktKwog
PaKHoyh3NvtRln/6nqmskQaAt3DtF+u5Qovezekrj05XRyZXJgYdknyner+Sqrk/
7G/NsffAU5geGcJTYSLVswjmQ9sLP9gecoIIi9IT7TudRVYcaH4X5odUNkXiJ9NN
fbe+M/NgS5cWmw3YpxvGNyDsC3V6CgU2JuGGhl1a0Yrzd2qtfdOajkAma3iRyeVi
KE2/MpdOiWTJQCb5RtwYQcoBYC02//6y28LTES/mihnKh67YrYYuYpQvbba61nff
zdAkpkvywozvPEuLVsRP9D81kVkgz9/DhzPrYFOg1NuZVPMzmLvIHmDOxcZNjv+V
5MdG1NBGGdu7UwFudQUQlUoKnOxf9OGwUZakO1pff7R8g6YwFsRhSbcdy3EUL8um
ZDoO78JwnMpQtu6husDjhiYspXQOxQvKhpMzwILPz0R1BqzP2jbkjtT8deoDHsMC
deC1Wos/HhxqKDKj6K1EWo0YGnPBGQAv6DfIymScayOgGKf+GQw+FfmTOHvF7w/D
l4gWa8b/fXmWjqA1nqOIrZyZKtSPfYBOzfix1uufMkA7dxMIFDwn/IdKwNs5UPCz
pEJdhugy2MpKMVC8il8MF1pWyWnEC1PtiGpIrPI1E0YaLKJN1vcAw8cNkXuIHBat
brCd5H+x3nM1xph0h673ZLiyxNaeINtsI3pXQD6IbOLHkv14SyZ8CNpx/r8Qg8BS
OX95WuY4rxDDsN/emjqBzmq7JGv9K89OOS9eOfs/Ksog3cUDo121Q585UmYqFNM=
=pMzD
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
