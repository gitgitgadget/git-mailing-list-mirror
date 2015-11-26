From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: Signed tags and git repository
Date: Thu, 26 Nov 2015 04:56:00 +0100
Message-ID: <20151126035600.GA11556@zorg.kyriasis.com>
References: <3816223.3lD8Al3iuQ@thunderbird>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Cc: Stephen & Linda Smith <ischis2@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 04:56:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1nfF-0008NO-5y
	for gcvg-git-2@plane.gmane.org; Thu, 26 Nov 2015 04:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbbKZD4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 22:56:05 -0500
Received: from theos.kyriasis.com ([212.71.254.33]:33304 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbbKZD4E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 22:56:04 -0500
Received: from theos.kyriasis.com (localhost [127.0.0.1])
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id 6f8ace61;
	Thu, 26 Nov 2015 03:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=q7Q3sl+7Zox3ElshnuKYhCWeTn0=; b=J/9N49
	Mw0arIzt64/iS44dyaQQhw6pwzcNxKysGmOoJ2SVP5kTT4veRoAYoeYonv/mNzbD
	iW8oNZTs2YID7e5lQWqRzsYhUTU0suEV6PYN2rVZazpDg4fei2OgPV0W9Wvr2LQU
	+eI4R0+tsOoKeETfdeUK8Bg36EUEZenOrCGBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=kwxYl2E1DisgnMYn9RJxyBEN1aLBlQY6
	FrgHvSU4OVIk4yIZSlMSBn2tefOVqj0Ea3s20rK/9vDbhPOAZMNEKbVOo98v3XK8
	S8GSCTnD/RejAN4CBlSCoNS9n7vPFBQ22QLXj2ml2UQ0d54lsrKAJCbAi5HZANUA
	GLAODnewaqM=
Received: from zorg.kyriasis.com (c80-217-51-233.bredband.comhem.se [80.217.51.233])
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id 7b49bfce
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Thu, 26 Nov 2015 03:56:00 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org,
	Stephen & Linda Smith <ischis2@cox.net>
Content-Disposition: inline
In-Reply-To: <3816223.3lD8Al3iuQ@thunderbird>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281753>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25/11, Stephen & Linda Smith wrote:
>I know that the linux and git repositories have signed tags, but I'm not a=
ble to verify
>them because my key isn't signed by anyone that leads back to one of the g=
it or linux
>maintainers.

Your key would only have to be signed for others to be able to verify=20
/your/ signatures through the Web of Trust.

You don't even need the Web of Trust though, you can just verify the=20
signature and then check that the key used to make the signature is the=20
correct one, then you could either sign the key if you know that the key=20
belongs to the right person and want to make the signature public, or=20
make a local signature which is local to your keyring and won't be sent=20
to eg keyservers. Or just mark the key as trusted overall.

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQRQBAABCgA6BQJWVoLNMxSAAAAAABUAFXBrYS1hZGRyZXNzQGdudXBnLm9yZ2pv
aGFubmVzQGt5cmlhc2lzLmNvbQAKCRCQHBwyDrDUXWWaIADCEmqavYOK7fk77TlK
RGHsMcqAZR4z7FyP79KU3F0396iBGQNviRTjCDpd8kBrfam1GwbAfY6sZVyqyReU
ixNHZbxwoY56HMeCemUmkDIgbGtdbisLtYuvojbfRQtbsCK9ihzCTPLxGKS66ziA
3o84cgqP4hmbAqFUf0B1JKYrbsHxxoUuG6vnZ09f6ZE1mzYJX78DYisujFRy38uy
uVIRTsOri7kx2XvHYHNKLcfMmBEYn+ckXMAla9tb2RlCC7IdZJh4V+DBURT2mFf7
a6j4p4k0ZAbUut0SWu07IH6gbHWxYwmgY4F7Tq+aKD9nqYzG07ZU+KwTNc/Csnao
WLxAh+WBMLcUu1c+W6g66t/a4t/DZab95x1BYYdmaL8l6XhZ547FU+YgUtDM3x3t
tPaaljgo+zpTJ+SBwwyyjpLb1TUJM4tgSXgzJNDg8bRtliFVV8UqngrCFO/sWX81
RlqWBclBlEvmFebWDf6aBNECj6xCugnFBnTr9Id0CWmS2NTyjqQtGd2EbfZ4izYx
xBdBvMMjo2w0U6bEHNtwp7d9XuAGfdsJk1f5796z/f3aFRKG78OIjjG+LWElWiOg
oVxzjmnyeT9LTwyHELTgYwMS7t9s3xkYUAmbV+9wj8jU2MqFv1FYo6wiruhPMGYz
SZFUwAp2gj3WqfyIySNyQtw5JPCLxCuRiQ2QAnzv399tVsPWoJyx20M74WMYxOd2
dFkBh5l10omvTuqrwASKreTznokCN9LjFCfYqA+RctgPkZR1Dql7gbyPj93nBnPX
zDwO9BL+/MNAN3yu4LqHqyiCQu/NtxIC3/4xEI3CUGFagYFVnPuKSml4bK+dRMhD
ZKstCj5rst7xmgqmbx/pXs33JnSxUQb87aONL84JWTVW59bFKHP1has1DwVyxGts
O+Cd0+gvzwRAnxIRsU4vjQG4ATV5cNR9DGmjTF2m+rdiNXAyiPfRSCSkV51af3OY
1c4vlR9wsKXywCLzJ3ZG0ijwSWStTmZ9xWbKCi0afTu0HWvVjNuvGpYY1nutS4wY
N5JFxZLRwA9VYigSrc+1dVC69E++RHfw307K315pmO65FU63wx9JI0LfSCPDsitz
1ZFeCzmnr8DbTzWmO8fhMBxsiQd3Jyut+X06JThn69T1VjtXsuUxvAul8gKVDpOr
6cCVc6kOObbybt8aEtmXXVO1Oqt1c78y7wHRBn9LagpfUxCrunnX02b/+gFz4dHN
uWV0pGCb104Y3/fag5bAOfDtUH1fynFkIclwapS+gFRxgwGciybQ72ovY5z6j9pq
q5eI9NINeKwCmuhQ/cFyQz0JbjObteooXs/Wx0lS9qf+54z6n0FxuSG3m9LH1tgo
3GMn
=oxKo
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
