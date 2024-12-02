Received: from redcrew.org (redcrew.org [37.157.195.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824794C85
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.157.195.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733122902; cv=none; b=umfELp2OgFKtLIRFE3q7jeyqvu5CLl/yObVCtgUgKCfcYHsnFk93Nli9YaZRo4I5rbPKrwe8/qjORQ7MkNPSbW12vpZQyO/e4+Mi3sQd0N3fQVVbe2TgNzaJYIifh/gVNPb7HCRlvPCXyIngEdGtTQBWUL8zdXDdEVtj4D7ByLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733122902; c=relaxed/simple;
	bh=b6XOD73V4stZwXbzR3OoLiyc6p3zqIdpGWCHHyiTv5Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=H48MnGyVLQrFR138prr41Hd9KTL4zEpsOfdi2Wr4Ot+1N8ZxrSB9OYj/UZPFGkY37/qcMgBoiMzJEgapHq7mQhfKzp8zeXfyuDbCdyMkAUhAQyza/hXgFfjCzulUwHJZCruybgDnP617AbIBPo/TmcZk3djWI73UW+3hxTPjZhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu; spf=pass smtp.mailfrom=cepl.eu; dkim=pass (1024-bit key) header.d=cepl.eu header.i=@cepl.eu header.b=Rjh+i4Wt; arc=none smtp.client-ip=37.157.195.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cepl.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cepl.eu header.i=@cepl.eu header.b="Rjh+i4Wt"
Received: from localhost (unknown [185.22.237.37])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by redcrew.org (Postfix) with ESMTPSA id 5AF6DC275;
	Mon,  2 Dec 2024 07:56:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 redcrew.org 5AF6DC275
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cepl.eu; s=default;
	t=1733122567; bh=YBK4kmhXf6B1qF8Iap9HzKuc0GcWObfJ7oJXjWnYAcw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Rjh+i4WtZjntPrfeEsWoXx9Fvce/svWucGfly0Mt19eNcRV7Bu6WSIU6993bE9FKK
	 gA+CwsfHULQsa04buPa01DGH37QzWjhqhf9j5Hdlubz8YYe9eHvVQwMoFHbMkMOkU5
	 cvpEXNNno/Ejrv5tzBZaMHFfE7qw1PRbmPet8FnM=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=a3d3987f009bbdf708f90694fc71fb4242200d3b10a3832bd469b623c579;
 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 02 Dec 2024 07:56:06 +0100
Message-Id: <D610OBLUGP4J.3OQTEHZ86D8WH@cepl.eu>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation/git-update-index.txt: add an example of
 use
From: =?utf-8?q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
To: "Junio C Hamano" <gitster@pobox.com>
X-Mailer: aerc 0.18.2
References: <20241201222531.1478338-1-mcepl@cepl.eu>
 <xmqq1pyqkcu2.fsf@gitster.g>
In-Reply-To: <xmqq1pyqkcu2.fsf@gitster.g>

--a3d3987f009bbdf708f90694fc71fb4242200d3b10a3832bd469b623c579
Content-Type: multipart/mixed;
 boundary=1c0b69963887f23508bc8b8da6181c16ee80f086419b9f5cf0d9c8c2d684

--1c0b69963887f23508bc8b8da6181c16ee80f086419b9f5cf0d9c8c2d684
Content-Type: multipart/alternative;
 boundary=1329c625f3e73c2a376bb7f426f0535001d5d230ef23528069ba52834b6a

--1329c625f3e73c2a376bb7f426f0535001d5d230ef23528069ba52834b6a
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

On Mon Dec 2, 2024 at 4:01 AM CET, Junio C Hamano wrote:
> Missing sign-off.

Whoopsie! I am sorry, but given that I am probably withdrawing my
submission anyway, it is not relevant, I guess.

> The benefit of refreshing the index manually beforehand mostly comes
> when you are running two or more plumbing commands that do not
> refresh the index by themselves.  We used to implement an equivlent
> of today's "git status" using "git diff-files" and "git diff-cache"
> (yes, we literally ran these two commands in a row to show their
> results in the output, one for "changes to be committed" and the
> other for "changes left in the working tree"), and before running
> these two, the scripted implementation of "git status" ran "git
> update-index --refresh".

I=E2=80=99ve got the idea from https://groups.google.com/g/git-mentoring/c/=
mJnuzbUqyAQ/m/02Pr9uhmAAAJ ,
so I thought it something one does.

Best,

Mat=C4=9Bj

--=20
http://matej.ceplovi.cz/blog/, @mcepl@floss.social
GPG Finger: 3C76 A027 CA45 AD70 98B5  BC1D 7920 5802 880B C9D8
=20
All men's miseries derive from not being able to sit in a quiet
room alone.
  -- Blaise Pascal


--1329c625f3e73c2a376bb7f426f0535001d5d230ef23528069ba52834b6a--

--1c0b69963887f23508bc8b8da6181c16ee80f086419b9f5cf0d9c8c2d684
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
--1c0b69963887f23508bc8b8da6181c16ee80f086419b9f5cf0d9c8c2d684--

--a3d3987f009bbdf708f90694fc71fb4242200d3b10a3832bd469b623c579
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iGwEABECACwWIQSJ70vGKIq/QxurJcPgn+8l2WSErAUCZ01aBw4cbWNlcGxAY2Vw
bC5ldQAKCRDgn+8l2WSErOIpAJ4+TxpI31+fFGwHLeAYTgQEJdezdQCeLbD06KPd
qpcbomjBugu2jSejF2w=
=GCEt
-----END PGP SIGNATURE-----

--a3d3987f009bbdf708f90694fc71fb4242200d3b10a3832bd469b623c579--
