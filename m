From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: Eric Sunshine mail delivery failure
Date: Sun, 23 Aug 2015 19:16:22 +0200
Message-ID: <20150823171622.GA28700@zorg.kyriasis.com>
References: <20150811104056.16465.58131@localhost>
 <55CBA140.7050301@web.de>
 <20150813022545.30116.44787@localhost>
 <55D8C824.6000704@web.de>
 <CAPig+cSy+c9mOGOTN9e4xfLrvPc8nv7e0T_4PDA-vB-otwrvjw@mail.gmail.com>
 <trinity-6e67d416-0a61-4e73-9779-63519dd83fdb-1440322151491@3capp-webde-bs47>
 <55D993F8.4080506@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Cc: Git List <git@vger.kernel.org>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 23 19:23:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTYz9-0001VT-Mj
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 19:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbbHWRXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2015 13:23:07 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:36199 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbbHWRXF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 13:23:05 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Aug 2015 13:23:05 EDT
Received: from theos.kyriasis.com (localhost [127.0.0.1])
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id 1bf6981a;
	Sun, 23 Aug 2015 17:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=rJAQ+7SHJQkMqK1ibwKqeDQGrdA=; b=IDPblY
	wKw2uMEalouHPuH+5pVpWwPPrwvndejh0LnfQ7oUqK29eoqrv7QVIzqwqkEjebwW
	IK1s2D5ZNgHKEs9D6apLnBYE6v5SEceNwdanAwN3oTN9KkN4QMPXoa7nkO2oMA44
	mVYoZOik1a1oKGwwHnez7E7udBdA6sLvB3nVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=fCiBmMhsvrcOEBMEVM1hNEqSOkgauJmk
	Z+6k8RZn2SmSHA7q/56Iv0+mO4uJzCJdQe0K+h5vdJ2pR/iTs+NjecGHnFoiGqpe
	bsAJ/SNPoOWwwdRBCziYsNC5IgR0f+Mh99w9mIxRWipR7u0SsZx4lBJTjRnvwZ4u
	tGGvcm7928w=
Received: from leeloo.kyriasis.com (c83-253-173-217.bredband.comhem.se [83.253.173.217])
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id 6cd0bd44
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Sun, 23 Aug 2015 17:16:23 +0000 (UTC)
Mail-Followup-To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55D993F8.4080506@web.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276414>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23/08, Ren=C3=A9 Scharfe wrote:
>Eric, hope you see this reply on the list. Direct replies to=20
>sunshine@sunshineco.com are rejected by my mail provider on submit in=20
>Thunderbird with the following message:
>
>    Requested action not taken: mailbox unavailable
>    invalid DNS MX or A/AAAA resource record.
>
>And with this one when using their web interface:
>
>    A message that you sent could not be delivered to one or more of
>    its recipients. This is a permanent error. The following address
>    failed:
>
>    "sunshine@sunshineco.com":
>    no valid MX hosts found
>
>It seems web.de wants you to get an AAAA record before I'm allowed to=20
>send mails to you.  Sounds crazy.  Sorry about that.  Time to find a
>better provider, I guess. :-(
>

Just an A record would be enough. The issue is that mail.sunshineco.com=20
has neither an A nor an AAAA record, it is a CNAME to sunshineco.com,=20
which is invalid according to RFC2181.

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQcBAEBCgAGBQJV2f/jAAoJEJAcHDIOsNRdaSogAK6wt/QutcLLGb71kS6SezB3
YhPM8vi9ADBiWz8p8lZIvPNvSC8z8OJ96IMsUjfQBZVAiF3PCkEEQIZWQ3TJND7M
vesr+RGEMIPMKw7NZSwJCBtVbkwJp1vZraRQAEyQX0OYYyqHCiHOJGgW2Wfwk0dL
BVQjtB0jwMnIv3HxG7Om+cnDfARA9TbZylwddjtoAr5tnvNUR2r4QbAzFx1TdDLD
nYg8dGvXWl919wVrin+E9zDS/pQs+2OVta/RjfhlZ1MEdIVIZ3eCjD1uhU2hPG5D
jJkxNsOjgI2hJ8OGi4/Rr8ct/NBDrBGJDY4Mf4lCXrY5hiwHTk34FPDd4y61SpZN
tbgOGzkYufK1qfwAflkoWX1tF+8Wqy9BXoBhSzBSoHSyS1o8KnIu6fLlpuNlipCs
EbIATsfavAEnXlOKwwe9Q0SyFGNMmeq6ili8ZzQAgy9qcmEtJVuhfhTiSAiMnioC
EZjlEMV2PQ00S1pez8ySKcCLo4xJBD8Jge1UcpGJn7tLn/YRQWoJPDyadXDOD1Am
C8cNt09ETvVdnUVI5XJyf2ytVdNSIYgP74rUy+IuWwLkWsA1oh/Z/ezGh1wOrK+L
wgEiEFwFdglnHC4ZPWbh0Jt+OKXF7z+YEpw0XzQrF8t9B3p2uUVe4pJr86yAPm1J
nxMOdsT6GcpMg1S5j7rFKKGP+Ro+FC5SKQKliDTZxSnbVHGAb9ASCDO3x3Qy6qvI
inCF3MBZ3Cv7H4nG5Cj1IN0xv2/lwMuj1bTAlYQs2VUPK3/q+NNF8y4kLi7IvD3j
lt7cOUT5Ijef1kj1LmMZeRqzgKTlQRsL3p3bcXqA9CN8893oIRatZIMJ6pOoFIfD
tHO54UWsMhKgcxFLuedUax+FD/VteJKJrEo1uVC+eh1z6dBptUsAFx5RE/TT6C0v
Crn9zXuzwWfRFdhhaNb4AyDn2hAZ/W7aqsuhIwCeds8EnFuffjO84jWjBkhNwRSe
lIjVX/jNuzU/5Ek2Yy5nAJiUgrw0KrgsbCjE3nXFn6Cs4Ku+uvUmpAE/0CNg7xks
5zMbPeLiG9hP5p51xUgp04E+Q2d0Y5VpjYsbSzRZlDJThxypZUItwY7rTXiotHkY
S+eIcfyC+0DT69j6AXfboDMNvK9Mic/I2OlRZZCgCuk+CmmuCCCTusBAjs88LALC
AKu3mAet7ziGOYp0D1uKRvQnf6/h4/qe2cb5j5bkSJwJDu9gpQxFKgasHkLXhKiZ
nLzhf07GpuK2TJZ4ncZ2NKFFoQov30aZJHVqZm3zCz6JviM3dI/ovEzG3i0eJeGZ
569Fu71VISOM4eGbpuJQXk2Iwth7tkAD2jFLfNjS0YVpBGC7HITNo7NknRvIS1k=
=2l/g
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
