Received: from redcrew.org (redcrew.org [37.157.195.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63FC3C3C
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 02:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.157.195.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731293642; cv=none; b=R7Vwh565ziJX/bVsg+SZRZTob/j5hnQHmRY7k2bEnmS4JbzXLvYyTGkBGX9112GWtvlUOW0n6v41+pQ/RD4S10QbISvWVMnDKNSLB9Wdz30L7+ERpCNIbdCf6EwLsH8b2UXi5x38MuDWZZTbR3PK0coeGlPF2u6BCJA7kwmttRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731293642; c=relaxed/simple;
	bh=BaBH0uArCOlxbisr7CGbw1M0Shvo67VcLgPzVpS75lU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Vk95W7fAp+trTGulTjJKBK4uzdrNHTLsXzimOz1H9OTB71PJXgETbto00gHosDHeL0FfxtT9C+KjMRwN5GA6v+f4jxloK+PM8aLn9cg3++SabBIimJZoKjPUwMp/5/qSBVU9WL5DxDFhEd9Z2C4FOfvrQ3EnSD9gnDhtYEekogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu; spf=pass smtp.mailfrom=cepl.eu; dkim=pass (1024-bit key) header.d=cepl.eu header.i=@cepl.eu header.b=Hcdr1EPl; arc=none smtp.client-ip=37.157.195.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cepl.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cepl.eu header.i=@cepl.eu header.b="Hcdr1EPl"
Received: from localhost (unknown [185.22.237.37])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by redcrew.org (Postfix) with ESMTPSA id D5806C001;
	Mon, 11 Nov 2024 03:53:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 redcrew.org D5806C001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cepl.eu; s=default;
	t=1731293628; bh=1P9BTD8ay4KZzax01GMSjIm/ejVRBoD5RUF0wAiawXM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Hcdr1EPlfuhd9eBXazoG4N32FXGcRMEhlZ+z/J4Nt3XxMOQMIFladmoSfiR3Zkw+P
	 SSc4Pv6iGsizA2ajgE2YeACLVHhPGXVd9OK7jws849YuKlVaoE46M45q+DaicqueZH
	 Xsnzgg+xvV3nwktV/e1P0LYDR40elxAn+xIh2ckY=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=1117f86fd9d90b73ea0058c966a7665838786e035e0e5c227207ccde8c3c;
 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 11 Nov 2024 03:53:47 +0100
Message-Id: <D5J0DCN2Y2V1.3C2JLTMGY8VAM@cepl.eu>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 <git@vger.kernel.org>
Subject: Re: Feature Request: Interactively pick fixup revision
From: =?utf-8?q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
To: "Martin Imre" <martinimre25@gmail.com>
X-Mailer: aerc 0.18.2
References: <CABg7He2asYQbdRvSvfh1YZ2FRPchVfvta8yBv4PFdVNnhzX6Ow@mail.gmail.com> <D5HQH12Y4SWF.2W70SKEDB7HBF@cepl.eu> <debabf92-7d23-4d17-bb0e-36691c94430a@app.fastmail.com> <D5HWL26B3HOT.1ZVXUC37BCGL@cepl.eu> <CABg7He0upi8kmagGO13UMwSWOLeHoryZQU5CGsfbhgqedBKw=Q@mail.gmail.com>
In-Reply-To: <CABg7He0upi8kmagGO13UMwSWOLeHoryZQU5CGsfbhgqedBKw=Q@mail.gmail.com>

--1117f86fd9d90b73ea0058c966a7665838786e035e0e5c227207ccde8c3c
Content-Type: multipart/mixed;
 boundary=9060e650afcbd622dcd9294662aaad81d7c8951c5126fb201c0ddbc27d2b

--9060e650afcbd622dcd9294662aaad81d7c8951c5126fb201c0ddbc27d2b
Content-Type: multipart/alternative;
 boundary=5c1dc6584eb478f710e34bbbfc591fee5b2d4a7ee2aa604b1df76112c4c3

--5c1dc6584eb478f710e34bbbfc591fee5b2d4a7ee2aa604b1df76112c4c3
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

On Sun Nov 10, 2024 at 8:55 AM CET, Martin Imre wrote:
> Just as a general question: With 2 (or even more) different
> implementations that solve the same problem, wouldn=E2=80=99t this be a g=
ood
> addition for a future version of git?

There are few problems, one which is the implementation language:
git-absorb is Rust and git-fixup is bash (using arrays and other
non-POSIX constructs).

Documentation/howto/new-command.txt declares:

    Most subcommands are written in C or shell.  A few are written in
    Perl.

    (And Python scripts are allowed for some specific tasks, namely GUI)

Shell script here quite emphatically means POSIX shell (or at
least not using widely non-POSIX constructs like arrays), not
bash. In order to even be able to consider any of these commands
to be submitted to git proper, it would have to be ported first.

Best,

Mat=C4=9Bj

--=20
http://matej.ceplovi.cz/blog/, @mcepl@floss.social
GPG Finger: 3C76 A027 CA45 AD70 98B5  BC1D 7920 5802 880B C9D8
=20
Never ascribe to malice that which is adequately explained by
stupidity.
    -- Napoleon Bonaparte (or many other people to whom this
       quote is ascribed)


--5c1dc6584eb478f710e34bbbfc591fee5b2d4a7ee2aa604b1df76112c4c3--

--9060e650afcbd622dcd9294662aaad81d7c8951c5126fb201c0ddbc27d2b
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
--9060e650afcbd622dcd9294662aaad81d7c8951c5126fb201c0ddbc27d2b--

--1117f86fd9d90b73ea0058c966a7665838786e035e0e5c227207ccde8c3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iGwEABECACwWIQSJ70vGKIq/QxurJcPgn+8l2WSErAUCZzFxuw4cbWNlcGxAY2Vw
bC5ldQAKCRDgn+8l2WSErPOlAJ0dtqtZIaFmytx439UhZ/ic8PdrhwCeP/7R60fX
nJeeHLAAW1K1cb6b3e4=
=17ea
-----END PGP SIGNATURE-----

--1117f86fd9d90b73ea0058c966a7665838786e035e0e5c227207ccde8c3c--
