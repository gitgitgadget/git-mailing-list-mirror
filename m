Received: from redcrew.org (redcrew.org [37.157.195.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C082F2A
	for <git@vger.kernel.org>; Sat, 10 Aug 2024 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.157.195.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723285636; cv=none; b=st/++DCOCtekWl7PXu0O7cYALR/yhoVVJJRioVudJpHgYx5GfGUYyaeWtvMsgcGT+EYTTBcnzfGfA89Y55FAQiTHvX1hmhBj2XnvjbAcRXDSseCKRtMqo9JB+VmgNyk5i/S+Sw2wfPMRmejk0t+U/uUYt9p2mrl53Wom1UwIxys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723285636; c=relaxed/simple;
	bh=FBzBO5fgsII0XsO0Pr+7Yc+z9TshyCBIi5ImsmXHv24=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MVZIbtKEkgpSYOKr34hmKMmWiREVWerQIBIxbbd7ly+VQPF7z2JmmpKuogFT+jP5px0BLyHRShCRST78WH3hzrNiEYrlk1CJVMHx0Udm+MOF1qc2dFlERhbk8aGMnFElgL8YLVlV8/2C+N3Vw61fivX+kiNs7PwWxUlfl7370ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu; spf=pass smtp.mailfrom=cepl.eu; dkim=pass (1024-bit key) header.d=cepl.eu header.i=@cepl.eu header.b=fgyJG8pJ; arc=none smtp.client-ip=37.157.195.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cepl.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cepl.eu header.i=@cepl.eu header.b="fgyJG8pJ"
Received: from localhost (unknown [185.22.237.37])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by redcrew.org (Postfix) with ESMTPSA id 39F508207;
	Sat, 10 Aug 2024 12:27:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 redcrew.org 39F508207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cepl.eu; s=default;
	t=1723285623; bh=vFUQ0uvqtg0NmEhDFEwZZrrlJT4dXV2ZuGfJmDYd3XU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=fgyJG8pJy1zKDr14qroQLq7sWJk2Elvl85gIZKD0sN65CZSxvpek7+MTHVBHB2FzY
	 WNqGgBaQ53NDZHdswgUf9EDTuwaIzdEJV9a4x/HRVYsR10r2xQbI2nODZYCYmJcJZe
	 qnFvOsHeaaS/5/ZjfN8FW5Cul0ee2iwFcOxdLVtU=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=63fbf493f033968ce00fd6e4a454f9b5bcf9690c3302ed93bc0b8f0a6f1a;
 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sat, 10 Aug 2024 12:27:03 +0200
Message-Id: <D3C5RQ4Q7N5K.1OE55HRDAYH0A@cepl.eu>
Cc: <git@vger.kernel.org>
Subject: =?utf-8?q?Re:_git_send-email_with_ancient_SMTP_server_=E2=80=A6_dh_key_to?= =?utf-8?q?o_smalll?=
From: =?utf-8?q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: aerc 0.18.2
References: <D3BAXOA4NL74.29XYKS0IO8UFC@cepl.eu>
 <ZrZrVpYdSPb731_p@tapette.crustytoothpaste.net>
In-Reply-To: <ZrZrVpYdSPb731_p@tapette.crustytoothpaste.net>

--63fbf493f033968ce00fd6e4a454f9b5bcf9690c3302ed93bc0b8f0a6f1a
Content-Type: multipart/mixed;
 boundary=3671eeba40820372703a25c4da2d4efb2f1280f7c9aae882e47eff030e57

--3671eeba40820372703a25c4da2d4efb2f1280f7c9aae882e47eff030e57
Content-Type: multipart/alternative;
 boundary=e37fa6a1d8172f7bffd99663f23400e6aa7d8d930c8890303876f40f1cbd

--e37fa6a1d8172f7bffd99663f23400e6aa7d8d930c8890303876f40f1cbd
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

On Fri Aug 9, 2024 at 9:17 PM CEST, brian m. carlson wrote:
> If you're using level 2, then the requirement is the equivalent of 112
> bits of security, which is still inadequate by today's standards (which
> suggest 128 bits of security, or level 3).  Level 1 is 80 bits, which is
> probably attackable by government agencies.

We are talking about sending patches to the public email lists
(and yes, considering my other emails, I can live with them
being snooped on by government agencies, they are welcome to my
ramblings in emails).

> What you're looking for is an OpenSSL configuration on your system.  On
> my Debian system, the configuration file is in `/etc/ssl/openssl.cnf`.
> The steps for what you need to set are available at several different
> places online.
> https://askubuntu.com/questions/1233186/ubuntu-20-04-how-to-set-lower-ssl=
-security-level
> is an example you can use.

Well, but that would degrade the security of the whole system for
all purposes it uses OpenSSL, right? That=E2=80=99s rather too drastic.

> I don't believe that Git provides a set of TLS configuration options for
> `git send-email`, but if it did, you could control the configuration by
> specifying cipher suites as `DEFAULT@SECLEVEL=3D1`.  You might, but
> probably would not, need to configure the minimum protocol to something
> lower as well.  I believe CentOS 6 does support TLS 1.2, so that should
> be a fine default and shouldn't need to be modified.

Thank you, I will take a look. I found
https://stackoverflow.com/q/34176433 and
https://stackoverflow.com/a/36417794, so I will take a look at
the Perl code.

Best,

Mat=C4=9Bj

--=20
http://matej.ceplovi.cz/blog/, @mcepl@floss.social
GPG Finger: 3C76 A027 CA45 AD70 98B5  BC1D 7920 5802 880B C9D8
=20
See, when the GOVERNMENT spends money, it creates jobs; whereas
when the money is left in the hands of TAXPAYERS, God only knows
what they do with it. Bake it into pies, probably. Anything to
avoid creating jobs.
    -- Dave Barry


--e37fa6a1d8172f7bffd99663f23400e6aa7d8d930c8890303876f40f1cbd--

--3671eeba40820372703a25c4da2d4efb2f1280f7c9aae882e47eff030e57
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
--3671eeba40820372703a25c4da2d4efb2f1280f7c9aae882e47eff030e57--

--63fbf493f033968ce00fd6e4a454f9b5bcf9690c3302ed93bc0b8f0a6f1a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iGwEABECACwWIQSJ70vGKIq/QxurJcPgn+8l2WSErAUCZrdAdw4cbWNlcGxAY2Vw
bC5ldQAKCRDgn+8l2WSErIZcAJwNihPg8GQsWo0d1mD18REUzWOVrwCfTsc5PsPg
yPtX+EOYN2BILQcV0eA=
=UYPW
-----END PGP SIGNATURE-----

--63fbf493f033968ce00fd6e4a454f9b5bcf9690c3302ed93bc0b8f0a6f1a--
