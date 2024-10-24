Received: from redcrew.org (redcrew.org [37.157.195.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278A81E1A35
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.157.195.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780026; cv=none; b=GsfEHpMh7oNpPtwseXG8ROps+nDKItBjxSevrfi6v1+Y4X4a8uAxOnyEoPnZP2xgndCRxrJYLoeI82dR4Q1QUxair4I+Fg9ZSVBg42sUKU+DsiW8ID2PZ7p4TK2nG3TilvaMULivQNb44XY4kAshP29dCdi3H6ZXFkBc75J9wLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780026; c=relaxed/simple;
	bh=ilObqqd51HE8jSQXGVcpQjYFV62wJojpx95K96VznO4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Omf0Y9ajeS3MRNcjSm2m5VmclArhC+SLUBvj5dAOoF8jX/wOXb5DUtgWz/eYiN6NANUagiCCYvsAY9YX8aBYNPigEojY8ItGUpm2D4N+0R3acMCQaMIv5tBr+9eJSQhcG7X+HCC4BXBKlTfzz1jfprabpQqbaW0lhwICmF0Qs1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu; spf=pass smtp.mailfrom=cepl.eu; dkim=pass (1024-bit key) header.d=cepl.eu header.i=@cepl.eu header.b=doyO+0na; arc=none smtp.client-ip=37.157.195.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cepl.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cepl.eu header.i=@cepl.eu header.b="doyO+0na"
Received: from localhost (unknown [185.22.237.37])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by redcrew.org (Postfix) with ESMTPSA id B0C5B8FCE;
	Thu, 24 Oct 2024 16:26:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 redcrew.org B0C5B8FCE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cepl.eu; s=default;
	t=1729780019; bh=f9lmjLJGENOKYF93aZKKxtGoGQ/E764nYRpm59au2SQ=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=doyO+0na9yHq83C74W3cwsD/7OSl6hMUDFv3kj4psxLAQH0p1bByIBxgmy1gTkl3U
	 QIZWeFPipkgCp74QAYFPE1HBvAgjtSISBmFVaU/DZ8Odu/2lxGfVXRCgkwhQ86NwGM
	 NJKul12yiq0AAPmZ4spMFBLYpGvDwt51tP0Ai8xU=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=bd89e4d3682e2c5084621474e3bbfe1bb68f0ebaa61cf6e18ef7191aef3f;
 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 24 Oct 2024 16:26:59 +0200
Message-Id: <D543UAO2CPHI.RQIN1V1IC85A@cepl.eu>
To: "avih" <avihpit@yahoo.com>, "Taylor Blau" <me@ttaylorr.com>
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RESOLVED [Was: Re: bash prompt evaporates in subdirectories]
From: =?utf-8?q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
X-Mailer: aerc 0.18.2
References: <D52FCQ2F409N.1S5Q8XRAX5YU7@cepl.eu>
 <ZxfKbsapf3MAUmcy@nand.local> <D53YJ81WH001.2KRT4KHARKLC4@cepl.eu>
 <1101848017.3146876.1729770380522@mail.yahoo.com>
 <D542P2ZTHIUJ.2GEJYE41VTC0J@cepl.eu>
In-Reply-To: <D542P2ZTHIUJ.2GEJYE41VTC0J@cepl.eu>

--bd89e4d3682e2c5084621474e3bbfe1bb68f0ebaa61cf6e18ef7191aef3f
Content-Type: multipart/mixed;
 boundary=db8213b5d119555631ae9f9a53210820721c907d36b62da80e00d1159f6c

--db8213b5d119555631ae9f9a53210820721c907d36b62da80e00d1159f6c
Content-Type: multipart/alternative;
 boundary=edfb61dbad9b5f7d8165b90af2edeb6803f24cad86437b7da2ad4710f904

--edfb61dbad9b5f7d8165b90af2edeb6803f24cad86437b7da2ad4710f904
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

On Thu Oct 24, 2024 at 3:33 PM CEST, Mat=C4=9Bj Cepl wrote:
> On Thu Oct 24, 2024 at 1:46 PM CEST, avih wrote:
>> - What is the "innermost" distro where this happens? Thumbleweed?
>> =C2=A0 which version?

It was a bug in one of my scripts, https://github.com/openSUSE/osc/pull/163=
2/commits/294001c46ea2

Sorry for bothering you.

Mat=C4=9Bj

--=20
http://matej.ceplovi.cz/blog/, @mcepl@floss.social
GPG Finger: 3C76 A027 CA45 AD70 98B5  BC1D 7920 5802 880B C9D8
=20
One reason that life is complex is that it has a real part and an
imaginary part.
    -- Andrew K=C3=B6nig


--edfb61dbad9b5f7d8165b90af2edeb6803f24cad86437b7da2ad4710f904--

--db8213b5d119555631ae9f9a53210820721c907d36b62da80e00d1159f6c
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=E09FEF25D96484AC.asc
Content-Type: application/pgp-keys; charset=UTF-8

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUdpQkQyZzVUMFJCQUNaZG5H
LzlUNEpTMm1seHNIZUZiZXgxS1d3ZUtQdVlUcG5idThGZTdyTllNV1ovQUtjCjlWbStSdW9WRXJt
NEhHc2IwcEw1WlBubmNBK204MFc4RXpRbTJyczhQRDJtSE5zVWhET0duayswZm0rMjVXU1UKNllM
emQ4bHR0eFBpYTc1QTVPcUJFQW1KbHlKVVNtb1dLakFLL3ExVGo1SFczKy83WHFXWVlDSnpBd0Nn
alIyRAppcnc4UVA4R0NvVVVYeGVOcElPVHF6TUQvajY2VlRsbityeFlUMTJVNGp4TGxzT3M1WTBM
VlFmVWJwREZFWXk5Cm1rV1g4aU5UVVpzeCttNnVoeWxhbW0zRWtOL2RXMGIyc1E0RDNvY1pla3Jp
TFBEUi9YMFAxWFBVZGN5MjhhNm8KV1pvVkFLTjI2WCtQd3hTcTNKQ2lRRUpnUEplS3hpTGlFeGgz
bERpdE55QVMwV1VEL3hRT3FyeUVGYjlrc0d4TApSOVVDQS85V1VRTXdnUXZFVWh1VkI3cVNuUkVv
MytrczM0S2x0cDcxdVVqdU1qTGszeWtTcHR5bjhvVitYWmd4CnJ4UEFEK1dPSm41MXlGeGJvK09Q
TmRINndHMlphWEZqNDdyWDZHUTlXNndJN0swUWhkeVFUcHM4S05sc0p1RFEKcHo3WE1FOThvYjhT
c3pzdmtQUG0vZ1gwb1dkT0lxSGlwSG5NbEw2ODRqUkhDV0hWanJRZFRXRjBaV29nUTJWdwpiQ0E4
YldGMFpXcEFZMlZ3Ykc5MmFTNWplajZJWUFRVEVRSUFJQUllQVFJWGdBSVpBUVVDUlNvV0FnWUxD
UWdICkF3SUVGUUlJQXdRV0FnTUJBQW9KRU9DZjd5WFpaSVNzcjVzQW9JQXFzTmNzMVNsOWpybXF2
N3ZKekw0UUc2OFYKQUo5KzMwTm1CQ2xRd3BtcW5BMjZuQ2E0K1dTNWFiUWJUV0YwWldvZ1EyVndi
Q0E4WTJWd2JDNXRRRzVsZFM1bApaSFUraUdBRUV4RUNBQ0FDR3dNQ0hnRUNGNEFGQWtVcUZna0dD
d2tJQndNQ0JCVUNDQU1FRmdJREFRQUtDUkRnCm4rOGwyV1NFckFVTEFKb0M4eXJwdE9nb29KT3pM
em1MeERjMW16ZUdEQUNkRkJ3Wmx2RmNqMVQyZG1DUk5kbjUKY0VyUnlCZTBHMDFoZE1TYmFpQkRa
WEJzSUR4dFkyVndiRUJqWlhCc0xtVjFQb2hpQkJNUkFnQWlCUUpRaXhwdwpBaHNEQmdzSkNBY0RB
Z1lWQ0FJSkNnc0VGZ0lEQVFJZUFRSVhnQUFLQ1JEZ24rOGwyV1NFckJNWUFKOWVRRXBpCmJMNlZt
N3NVT2h1cHhEL1VzSGlXbFFDZEhZaStVTnB6QzFtS1l0RFNXYTFvY2ZPMVE3NjBIRTFoZEdWcUlF
TmwKY0d3Z1BHTmxjR3h0UUhObGVtNWhiUzVqZWo2SVlBUVRFUUlBSUFJYkF3SWVBUUlYZ0FVQ1JT
b1dDUVlMQ1FnSApBd0lFRlFJSUF3UVdBZ01CQUFvSkVPQ2Y3eVhaWklTc1AxNEFuaTZVODdoU1VY
RFUrM1pUYURSWEl3YXNUdHRsCkFKMFFXaGpTbWFKVGRra3BmcW1SQjliUmk5cEFRYlFmVFdGMHhK
dHFJRU5sY0d3Z1BHTmxjR3hBYzNWeVptSmwKYzNRdWJtVjBQb2hnQkJNUkFnQWdBaHNEQWg0QkFo
ZUFCUUpGS2hZSkJnc0pDQWNEQWdRVkFnZ0RCQllDQXdFQQpDZ2tRNEovdkpkbGtoS3dCQndDYkJP
b1RZNTJoWWVLbkt1VS91UmpPVHNVTWczSUFualRUclhZSEQ0OXh5THM4ClQvVnBzdWs2WlAvaHRD
Rk5ZWFJsYWlCRFpYQnNJRHh0WVhSbGFpNWpaWEJzUUdkdFlXbHNMbU52YlQ2SVlBUVQKRVFJQUlB
SWJBd0llQVFJWGdBVUNSU29XQ1FZTENRZ0hBd0lFRlFJSUF3UVdBZ01CQUFvSkVPQ2Y3eVhaWklT
cwpraTBBbjBHdzFNalpKQVR0VnExMVN1MG1qZDNyRFFDaEFKMGVlUEUwYW1Td1lWR1NwU05iMjY0
K1hqVW90clFzClRXRjBaV29nUTJWd2JDQW9VbVZrU0dGMElFTjZaV05vS1NBOGJXTmxjR3hBY21W
a2FHRjBMbU52YlQ2SVlBUVQKRVFJQUlBVUNSU3ljaXdJYkF3WUxDUWdIQXdJRUZRSUlBd1FXQWdN
QkFoNEJBaGVBQUFvSkVPQ2Y3eVhaWklTcwpieVFBbmlxdzFQWDI0QmxiQkQyMnpOcVl3emZJUERo
d0FKNG0vM3l0dUp6c2Z4ckVhYzF0U29FYjIrSDl2clE1ClRXRjBaV29nUTJWd2JDQThZMlZ3YkMx
YVR6UkdNRXR1YlVORVNHc3hkVTFLVTBKclVXMVJRSEIxWW14cFl5NW4KYldGdVpTNXZjbWMraUdB
RUV4RUNBQ0FDR3dNQ0hnRUNGNEFGQWtVcUZna0dDd2tJQndNQ0JCVUNDQU1FRmdJRApBUUFLQ1JE
Z24rOGwyV1NFckFuOUFKOWJPME5VcUxuTURUQ2NjaHRWeks2eUVPTGtDZ0NmWHdrdHkxdUVBelFJ
CjVrdDlHZWM4eVFweERsaTBHazFoZEdWcUlFTmxjR3dnUEcxalpYQnNRSE4xYzJVdVpHVStpR01F
RXhFQ0FDTUYKQWxyNjVDc0NHd01IQ3drSUJ3TUNBUVlWQ0FJSkNnc0VGZ0lEQVFJZUFRSVhnQUFL
Q1JEZ24rOGwyV1NFckhqTwpBSjQ3eUY5U1RYL0VzNHFzSlBqVzk2MUhlOUgzYmdDZEVzak9ndDdj
ekU4N0d5MEQxS1hXV05UZFR0VzBHMDFoCmRHVnFJRU5sY0d3Z1BHMWpaWEJzUUhOMWMyVXVZMjl0
UG9oakJCTVJBZ0FqQlFKYSt1US9BaHNEQndzSkNBY0QKQWdFR0ZRZ0NDUW9MQkJZQ0F3RUNIZ0VD
RjRBQUNna1E0Si92SmRsa2hLd3NRUUNkR21HWFc3M082UTNUQjBWMAp4UDl5THdNakR0RUFuaktX
RFc4UEtPOTBueDhJa1BvZHhyMW5DdkpidEJwTllYUmxhaUJEWlhCc0lEeHRZMlZ3CmJFQnpkWE5s
TG1ONlBvaGpCQk1SQWdBakJRSmErdVJQQWhzREJ3c0pDQWNEQWdFR0ZRZ0NDUW9MQkJZQ0F3RUMK
SGdFQ0Y0QUFDZ2tRNEovdkpkbGtoS3lLdFFDZEhEcG9sSGcvMXFEYXcvNENReVV6QWZOdkhrMEFu
aUVZTDZCRgpyZHlvbmhnUWYvWlh6WGpuS3pTZXVRRU5CRDJnNVVFUUJBQ2Z4b3oybm16R0p6NnVl
S0hrVGVYY1Fadks0V3pLClROL3VKSmhFbVN1UW1PS3ltYklrR0w2dkJRYitXNEt4dkxsMmxBYk5s
ZklnTEdETENzMVlBd2ZTcEo0dlM0bXQKbGlQZ0EyT3RaNWoxV1NPcXB4ZWRRUEdWYmE1Z1ZvN0hO
U09NVXRaS1R6N1ZzQ3ZSOTR2MDVjb21oTzFHb2s3NQpaeEh0WXlWSHVrNVY4d0FEQlFQL2Z0K1c0
RjB0Y2N3c2x6ejhPL2M5L01qOEtaRFltZk15TmI3aWVsVDJXZVEzCmlGRjlBeE1UNk92T3hBUWJE
SnZ1cmZLZVlseWRjWExzNmN5NGxLY2UxaEZhSjRpK01PRkxWVjFablpERENoUlAKcFE2S3JSQ0hM
YittTFkrU1lEMzdPN3Awc3BRQSs5Z3NFRS90bW4rNXNXN0xFOGhxU09vUFZkZjdZNXlVRGo2SQpS
Z1FZRVFJQUJnVUNQYURsUVFBS0NSRGduKzhsMldTRXJFVVNBSjQyVDFsLzJURnlrYlVMQnFxQXRu
YkM2a1IwCnd3Q2RFblJsQ0dsdm5PNzhSMEZnS1hsdDNSeXpHdUU9Cj1zeG9XCi0tLS0tRU5EIFBH
UCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0K
--db8213b5d119555631ae9f9a53210820721c907d36b62da80e00d1159f6c--

--bd89e4d3682e2c5084621474e3bbfe1bb68f0ebaa61cf6e18ef7191aef3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iGwEABECACwWIQSJ70vGKIq/QxurJcPgn+8l2WSErAUCZxpZMw4cbWNlcGxAY2Vw
bC5ldQAKCRDgn+8l2WSErIHpAJ9dTjVZ6WmVdtOJPcXQBlzKkSYc2gCcCGBGKCrB
WbaoAD8KY0adKc7T0L0=
=se21
-----END PGP SIGNATURE-----

--bd89e4d3682e2c5084621474e3bbfe1bb68f0ebaa61cf6e18ef7191aef3f--
