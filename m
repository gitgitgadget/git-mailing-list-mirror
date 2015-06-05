From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: [PATCH] receive-pack: Create a HEAD ref for ref namespace
Date: Fri, 5 Jun 2015 15:50:59 +0200
Message-ID: <20150605135059.GA1165@leeloo.kyriasis.com>
References: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
 <ef4dae3e-3ae8-4727-9448-80f801e1dbdf@email.android.com>
 <55719C47.6030600@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
To: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 15:51:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0s1c-0006f2-Gb
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 15:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbbFENvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 09:51:04 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:52461 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbbFENvC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 09:51:02 -0400
Received: from theos.kyriasis.com (localhost [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id 9d8151c9;
	Fri, 5 Jun 2015 13:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=yzwjWjZYAKQaOdiV26Jby2Jh3zA=; b=n75vSz
	7eUCKzNAH2ObUjg8JdfGOYS8Nq/6Gm5rMAgbBM7ihFb9FrkkCXZLGWWrzNGpoy7x
	7nzJmye6EgDOp7MkkbZiHvebAiyL0ot1fEC7nJ2hAMLLaYRVALRz0oLrsK7pcenC
	MiOQC+PD5UCqMTXvbWDlyvjzep8OoaMc8PavA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=ZH27Ys75V094H0SSmZCLNRrAqnlV4KoA
	i0dnxQfj5N2XSFG391WIZpPnVqgFxOr9xWY41x+L2ALyYCXls+WWFBofAjzfqmiW
	HkkhbV2yndUFUVOtucJW0n2F7X7OckwEOEmFeIAJYC8EAHnlDhTI2vcGSR80Mt/H
	gttQytz8M40=
Received: from leeloo.kyriasis.com (m77-218-250-201.cust.tele2.se [77.218.250.201]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id 035bedde;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Fri, 5 Jun 2015 13:51:00 +0000 (UTC)
Mail-Followup-To: Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <55719C47.6030600@drmicha.warpmail.net>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270833>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05/06, Michael J Gruber wrote:
>It appears your patch proposes to fix a problem. It's a good idea to
>expose the problem by writing a test so that one can check that the fix
>actually fixes the problem.
>

Right, will look into writing a test for it.

>(Also, your patch duplicates the line "struct strbuf=20
>namespaced_head_buf
>=3D STRBUF_INIT;")
>

Hmm, that's weird, no clue how that happened. Thanks.

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQcBAEBCgAGBQJVcak+AAoJEJAcHDIOsNRdg1Ef/2CAK6Q/5Y/HHCJuqooiResn
kFTydgLWWPnRZtcEfapQ1ajJq3Y/NpMSZ8o21Hm5BNUrvNE8LLFwolzs2CeIEsAI
fnAbC3ZWJMowNk13PnklJ5bzr/iA13RHWyUDjalsKPJUdhfWt0rs8jb1uFj1AJbU
No01515wz1Cap9/g7qln5aQe+RxfTxr73WxyyneiEt+fZ7zPTSzbOyhhwsIiXhGc
RlyH7N7D4Skm1qaBGQo6/jsgIuO/Og7Xh6BvfmKCO5UByJ9GKoKOLxdq7qn3cJDw
8hMvb/XjW8Ukzwn6xbzJLBQxqonGvwuLk1QN3QRaXF5IGl/NY+wN1VbHFeHJSkkx
4amRasl9z8c0hqyFzgUJDehJGjnZJ8djF1c02kXPflZk3sMUrxJSI+jKutbD/yiU
IvflkoO7lLJDU4I5CrmC2sJ5d5aMtnM0EMwfOfsG/0hxHaZgNbFrK8nEInsjM+gl
xhygiHbaOOhf7SqXiRENh6mA180bA4yl8+Q7FSUPzsa3v6bKqHfeUJuGLI0A3D2r
v2y1DNkBwfx1oL+ejzko29OZA00mIsy5NTyhM+Jz2MuQ5OYv2NoPh7imdwX6Q/8G
CkRpG4dwId50KzixGT+bmt4iknhRlH68Vp3bUcWjRlih9bJy0lK0jKmwAsX4c2tH
qGbO/TzkvAjxI30otgLxlF9f44zUxIanB34PV4b2mfeTyjCY/x5eKXQ6Mfeh2t19
vMqMbwkKCzXaqlNrbxaaUuuGaBS0DY8TNgKpU3+FdUxjSN5dD9TaGwBaeNGNaSKq
JD+vzCuOI8CH1IKFTJAqQ+LJwPFVzI1J26HsqCshvaB3qHryMTfgJ0Fm+gNpQwX8
kPmaLF78xNzgcByGJGox+ejriQtcVU7oVB4NEtOQwcv2eu1IYfb97/9XKyfzH3k+
bGF399dzh80nQBtlhtvbibkS3iYEbiE+aajk5ohh6S80jtI8moWtbBoyT+u2VTpU
xfyOMYqTA9lHeU8gASvR4SVfK2LzEgZ8s3va5xCQyacR9PH5i0xkk9B6JZFr7CRK
0AfeTEtNjtu+mCsNryCWAirQm9fsuZlKbRuvRBvSU8mAy3qWxhzK6G14ibg2drpm
Uo6A+Dr4w9TmozFfFGRKxYM7/TOCdqcIepi2AIiG0RxeUQe5BQ0dDMc5E9d/6Zo1
VDmnsFxXqr37v67QfyMN0leuY+Qd0o2oXBfqZNW0qRoG1xKX8+lPP7A6UibHamUP
JKbTU0pU8NYjG3ptl8c/k3EisXgMVC9KJWeqwnBrQTRK1Odn/xlHMeOQe/BBLht3
A5w+89mXotgVp9Hs94cHM1BylwkFaZM73Kbj927rNZ9YQzvXN94424hMm7RKiig=
=1i8/
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
