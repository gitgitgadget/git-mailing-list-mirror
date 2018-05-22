Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CEB2200B9
	for <e@80x24.org>; Tue, 22 May 2018 17:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbeEVR3w (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 13:29:52 -0400
Received: from luehne.de ([188.68.44.187]:57565 "EHLO mail.luehne.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbeEVR3v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 13:29:51 -0400
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 May 2018 13:29:50 EDT
Received: from [10.146.248.70] (unknown [62.159.156.210])
        by mail.luehne.de (Postfix) with ESMTPSA id 99E781E01EC
        for <git@vger.kernel.org>; Tue, 22 May 2018 19:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=luehne.de;
        s=luehne.de; t=1527009605;
        bh=JWHQBSjGcBwcy3w2NKRqRqCJwBVLdz0yRJ8ZkScl/3c=;
        h=To:From:Subject:Date;
        b=NQ0/V1hx6uk6yagjH7GTbwCMkFSpxfYoOl7YlX+LSdOb87Rbhm3HsC/dJugcx/UOX
         1N9mfEx8mNe33eDHYjfSRzxnvepfDwkac6DzUi32/Fy5ttETFOo3vGp7rkYgjFxEyd
         oKeN2zvqErigmjbxpxfj0HNuW7+2h+peXtu8zvi5fwY5YbWPsnUtWtPIo5OjKXIQpn
         weInod7f1w6HPJeMjOzxlNaA32jYoi4v3OX2OWdcsMNETBif6CrH8WVX0k/PVDoawW
         tlPYgfHVoEsrYeRBkyFkxyooWslvhPWupN3+ximqftxVJcCfKBNz0uX0bzuTDS/t2m
         EuMq86jw93AWlDf67dNc/lLGiffAF5srf1ytDz1l78J8eMMgEcsIR/OT4E2PdzDtda
         vzIp7jT9m3roROpGhPZmAPY79LAcOUSKojzZLBsjv3RT1ZAxKMyr3HdeZ4ABm/d5Sq
         DDT5QDNLSYlAe1RiwUXJAMGe4BShmK1J8cYoHkvcWX2otxl1fjJbebibYJq3IZSKXN
         cetkPduddbRByx+9k0d6CzDbhF0y8HGQXOYtMBSky6AoWR0l1sEoGhtYnRgww2fpvw
         wwIChlkqWKcOoJNpdHiI8gCjJ63x+y7dIZdEbiZ9KgSUBbxaGlBAhmJQWRckN01+Jz
         6xbYRc/Jt9oiayRAHtZvd3AU=
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Patrick_L=c3=bchne?= <patrick@luehne.de>
Openpgp: preference=signencrypt
Autocrypt: addr=patrick@luehne.de; prefer-encrypt=mutual; keydata=
 xsFNBFma5zgBEACp77nRTbQ/nBQLb5MXUz9Nx50svZSRdreYu83kLujOY79WM3vVmdJvuNzE
 hhfY8H/aoAoBzgf/z0CDL8gcleOT+uyu2Von306L0xLZ4ED9sdo7hJE1/m0JVNy6I1iTsanl
 QpxfHB1iQIVvZo4WBFgPIhgAQIsQ3Td9HHoiJYsOKKn9q39tkfLvhW3xeV7q35fBEga7ME3Y
 OhWpqZ8IMNSAAv9CRVBExUa6HwDwpPLiucIvFgBjMPmSmTPlGQNr0NhT9DYqsFdDq1UUtlnw
 escJ1z7i3MhYX7QQcX7fYiMcPEVQ7pfDERcv9vu/YM7uW0wfnRBNCmbv+nCm199A8J3ycCph
 Y1wo4hLw58+5iyRGbqezZ3ts4zvzi3o/uP7thBeai7d6xGrG6lW1PPAuEyIoH1hKuHDdUsQj
 qdeOEJUfyEGmHnbCuZltVi18tEIIx6Iglk4GHZSm03VKByrRZxgIR+7WM79dnpQVpWkZtwpz
 xRorGWGD7wDFV06ITRZPZgRLjRD1qEcpXHLngnO2brWoeS0PjL07pNZrqZdzSa//xf2Stwhy
 K41J8XBbC+enarEDxsDAuEm5ftvuiPMJGrA8TJmCJzWBRqntjbtz7Lcvjn/OTzXvjufjT52/
 kakr7z4zGvPU080gzXdBcSHc2vVRoNx5w94KyML00TQhFpLY8QARAQABzSxQYXRyaWNrIEzD
 vGhuZSA8cGF0cmljay5sdWVobmVAYXV0b2Rlc2suY29tPsLBlAQTAQgAPgIbAwULCQgHAgYV
 CAkKCwIEFgIDAQIeAQIXgBYhBG1kf2qcv5KOXwb7R6XYOGj3/5v7BQJalVCfBQkB57dnAAoJ
 EKXYOGj3/5v7Kk8QAI/vI8IculyltfwpcHGSunBhHeBrvnIXXl61wrv7c0LFFhhAK3dmyA+o
 kyNSYn/sJFpad8+YuMYROz/rVxJ24QgjWTVtNzQLB9zj4bkhP99uKlo4JlfgjtYy6055SADA
 QEDi0F5UOwG9ljGYHKgMBM2eMd5PVkUA/8M/uqUd8z593yDA1WaslCJJMD0Y9xnPC1aSIsrf
 aF1l725MfOEuhh6KHNtprrf0yEL6ZpRANB5daMy9UY7KUH5KafNc3ZUkxWRaCMoodSDcZnt7
 pU5febewRM/13Vdv1RpH9XBX/dpI4wxaLgYb+muRTGLHqYJGRV2v6OliYmZKM8CyMaIB7Pbc
 woiQ4NCdpvP8Q7/zdwz1O0bbK/2w1IrvwHat7ZLoA8crA5HXTeD1xffg1LKaEkV9qrCNjw6M
 T9BcvUEtWYYFD+4ahYlOx1nJ+vs8Pev3NTRLTJPq+JXQShLtoz1XUPsnDrtpWiW2EwV6x07h
 /hZdveXEoNai54LROhw3xNffwdZqnnmUyGECLpBVZCv0Gb0iS3B5+1IrP1hd6tiae9sKFDnX
 3oavtoF+JiOqSJlTJUzh2TJ2e/9Qg+LNrlhZU362o5wXUiPSj9Mo2jBLE1ui74Ha+58+lAp4
 ZGrWuN4p7HUH9m7ICFXK/PMdNF8Fd4bTToeJBUPA3hUfN9VtwmDOzsFNBFma5zgBEACxQwiY
 FzpWCN64iLZKz8TszjmSdDVLfOmHOgbYwhErG1qGbFqbwMQNtckO4MdHJrkFmsj3Rx3xObrE
 ir5R85qFVtgcLyB+FN5gbz9uYvmaXwdai6FSb/rA6xmMjOvU4H0vvlepJwVkoE5VBQi2u72z
 4PKLogqJoQEKoad1nPFS+QK938ns5MJNMwZXlQOfQLIpV8trRZEpaxvJBGgRfWwWtm37aTH2
 aA9Oiarx1wq9dS+nbnVeuvVfffrB1D6wKwjGUGRSX155aZVnVNT8kKfuYJfWwDxb8wd/VfoD
 SQ1mK++M+D5xp/fO3SY0ZaaC61L26VuhNeuurhUR6OmTO/cATqhdEb/s1DwJf01VSn919Mln
 A+znEJjFgarqCw6r5mRoN+3g+GaS7u0LMiUIr5Ge5Q8nNVaIIB8gfVQnwWw8cyLY9OYPoRn3
 JWIWw/w0AhTzpikYy3y/qnwetNggdX+OisCiaSWHPMjKzFvRuNpQwsmBEAROe6eDAQvtuQqj
 2sq+KwBxc4nx9PGtIb5ocpQ82KxlMmiQM4y5hHLZe9/NR0i5HCDFSu+4Qrts7TLMRUfujLOZ
 KjxxSsrWX5e8NG+naaguN3XaumT6nln+Xq90iBX342QgpYDYURrzXGdarui2iAg9/+NOGGWN
 sl6fmS9GRpKHYB6WDsq4xABXQ0hKiwARAQABwsF8BBgBCAAmAhsMFiEEbWR/apy/ko5fBvtH
 pdg4aPf/m/sFAlpnZ4QFCQG5zkwACgkQpdg4aPf/m/vEpxAAhyCjrBABU80bItfBg0waOwqN
 p+hyUBE3T7GsragqW+vOfV5wb6Bu0rHfoBt1eQAa7k53eDIi6O36832TG6ns0Ty/N0cas4Sh
 jcdB8UowXpytaeFSEe5zQppaY2h0aKbe+/Bzmr8x5yZwbA4s07kq1qNE47AQkeK6RD0ciNW2
 8nRcTf6UsVoqKlxm8+RC2aENINJd1MdBHxMkjkU2fA3k2Uq05jk97+BEN80glrJjs71RSdhU
 5rtGCjb+ezGd30psp9NXPIx/QlGeKRrmMR81O+Hy1WUaq3qFIca7RAumSUDtURfmOwIlELgf
 Pbx4TZT/yUvtc7yBJF3PB7RloKiF135zHhNfFYUPiNyunbVxh4oWV5xRB8+ZzPvHovRQ//wy
 mrdQbBf702k2nT3F9fiDPSfJgQxrc6KfzYRT1/5KC3NkVoGM3QsOHyHYr4E2qxj7/wjfQNqP
 ooNeytHCovBpDjsP+75bMNy07PCyCkVrKmdaNMw9wAtEle6jmXrxqOjJjNQ7bdboY2gfe9tY
 s+MyGS/SEiav+bBfQHUEY50ByEoZdetVJjMS3HDl3QFKmGpZMbaohwjLst6iYPjqDeSiy5XX
 aKKBgb/KRJwNHzOxUA8UZZVU9aDyP25SUwMEfRxbQVhANe1jLIxhsyxrDVIjozY4E8Bhg01r
 MHly1bmCJ7nCwXwEGAEIACYCGwwWIQRtZH9qnL+Sjl8G+0el2Dho9/+b+wUCWpVQowUJAee3
 awAKCRCl2Dho9/+b+xZWD/9MOsBI4/GfFrF9EDT+kc2x1Ce4blvyj0gMuz/vFgo/sZ+PEcH5
 aYruVDmoBJPbovXIAeV/G9F2xwchyuKCuQgV/5RbE1aufej426o/pq6D8lo+rMIPMR3AXEST
 DqmIIl6s0xLMTDFuwg9McgXRTcnGVUkkrC4YLZG2CgT2xRn438SGSmAenV7SsTxWYd4CB4hW
 SjJ1lh12+NGc+ErzzuIaEXWSpAZpTiZE71tB+LECr7NpMzbb7ro1R0aLOkenutyZg/gGFGI1
 vzaglzSbUkLg2RjL7rmYf6YLhSxTUOZW4Kk7iOii72pEHKqT0Q9PN8ClhcMWpfF2hbN8Fyn8
 /jH83CODZ3d+RRCfeMllnDzFFo+nPAWwvccO6N6uqlt5FwJ0eICIE/SqFJ8gB/2UoGJ7KuXW
 bWoYwo6vCAx8TRtjb45ZbGQARSOO3quI9/WIQGkuxZuGcoYuiA6YQlUlQIvZsw6tt/j+QgCI
 aVzm6aySh8LuSf3jPhRsVtY15qpls8xUv1wv1HHIlZxXecFJu9B2zMAat/p4xMUNomfmWcJL
 mJc1kowc+LSESZn35gvz2g45NpEe4zAYP3SnfT76FMCFFmN8f9ozffozZOUzppgHFC764Gcq
 Ln23i5SfG4PrKq4RH05WFHMRawLccXdILvlS44tsvRgnttK7FCXpEYX1ag==
Subject: Officially supported Git versions
Message-ID: <b5856696-bfcf-173a-49ac-6aa6989316d3@luehne.de>
Date:   Tue, 22 May 2018 19:20:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tyqPqKefCkSUzL7Hw0JpbZjOFiwhP4FaQ"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tyqPqKefCkSUzL7Hw0JpbZjOFiwhP4FaQ
Content-Type: multipart/mixed; boundary="9yOft24j3A5nGBqg68sxl7287tAli5ypg";
 protected-headers="v1"
From: =?UTF-8?Q?Patrick_L=c3=bchne?= <patrick@luehne.de>
To: git@vger.kernel.org
Message-ID: <b5856696-bfcf-173a-49ac-6aa6989316d3@luehne.de>
Subject: Officially supported Git versions

--9yOft24j3A5nGBqg68sxl7287tAli5ypg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Hi,

Is there an official list of the Git versions that are still actively
supported? According to hearsay from colleagues, the latest five release
series receive security patches. I can=E2=80=99t find a source for that, =
but
might that be correct?

There=E2=80=99s also the Wikipedia page on Git [1], but it doesn=E2=80=99=
t point to a
proper source either.

According to Wikipedia, versions 2.4.x to 2.9.x are still supported.
This surprised me, because the fix for CVE-2017-14867 [2] hasn=E2=80=99t =
been
backported to versions earlier than 2.10 if I see that correctly.
CVE-2017-14867 was fixed for Git series 2.10.x and newer on September
22, 2017, and publicly disclosed on September 29, 2017. However, the
latest releases for the 2.7.x, 2.8.x, and 2.9.x series date back to July
30, 2017 (and 2.4.x hasn=E2=80=99t been touched since September 4, 2015).=


Best wishes,
Patrick




[1] https://en.wikipedia.org/wiki/Git#Releases

[2] https://www.cvedetails.com/cve/CVE-2017-14867/


--9yOft24j3A5nGBqg68sxl7287tAli5ypg--

--tyqPqKefCkSUzL7Hw0JpbZjOFiwhP4FaQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbWR/apy/ko5fBvtHpdg4aPf/m/sFAlsEUUEACgkQpdg4aPf/
m/vVRRAApmsy+vp4O97qrTtzK92WivbmqkeU0LI0QDIjaKPMgm9Q/64OPMbVJTCe
p/M9EyDLWPWXHI7+z5tQI3sXDv7Au1N0A4LSS3BjW3n49yQOf1HCtZWRv2X1GyM5
mt/UAF3qg4BBY6l0FevPoORCZtWgzUeZekNENXajQU3uruc53rI8l1glL/XY0Bmf
xFwK9rofu+wVawdeY5rthDHdarIRxNtcK6hx6n5pFdnBxMkMEBC/i74cFI/VAU5Z
7gX5WpvfZJByZ8ZKXMDhVJSeFnkDkn9rgCxV/pTc+CbrMx7QPof7oRqXyoDg2/H3
DTOtZmgEpRU6e61dv2AV6nPyokXL87vTMjLgTQz+peWe8Uegw2F+uDeNROkjGOkA
wMDW3y9ks74+iYGXi8I3Ok+rLRlP9M06X7FWUhEAASNPObhXGdDeVgnVRBRY9vA6
sH6qGq9qZABSg8xCJvv0S/quWgyt1UF6h5WPB01LjsKY/U8XeCfLyfrMqz+OE7VF
FzCXdOrH95gu2Xp3Tnmxrn7Edf/k+trGXcxMPDiTkKQwSvOQfl5ycDFziTutD3F9
ikCBG9FJmA9cSTcr5gBnMVgMDvYvJjnYyexpxCPGraUA/wLnWzqpF1qNBJYOi5b1
R4Sw3NxQyLbRBzN3cS/K2gPOLBd6tR7a9WOxw/Pfh8hveyQW+6s=
=GyyN
-----END PGP SIGNATURE-----

--tyqPqKefCkSUzL7Hw0JpbZjOFiwhP4FaQ--
