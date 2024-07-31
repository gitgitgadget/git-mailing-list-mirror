Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBA31AB53C
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417684; cv=none; b=JvGM4/uHq16EZ7fHyPEKwT6O48hiMiSXMIrxpueRmZSfBR1F3YDsOVXahiLX7wmejPNdUmaVJZMmmI2JpyunL1qA0VB+hzdHF2sgrCu0A3RKdQJsvOrXgh7gYVHncltM9RiUiomb0/qS5B8e8e3lCFHs3Mnr3fDw/xpwF337Ii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417684; c=relaxed/simple;
	bh=TDXeQI2DXEq6iI1SoyWqXPLryA40qTMRsS7t0Grceuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JdSZ/cnEANfzKJmM/lOwZToiWqHao1C8QM5l56vmzb2qy0VCP0LNWDyKrHk5Z/Szof1gl5PaAfRmYlGvKPm2iAwz/LBTWpsChpCn+Ow50wagimZ3MJm9RgGjslCZnVblZq//oqDqL8aw6GKDfMtnFcM4QARD+DOQW1LfPWjNsH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Uc9eOnwD; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Uc9eOnwD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722417679; x=1723022479; i=l.s.r@web.de;
	bh=6CofaKl3vJKSTvU3QAlK7H7yHdfn0NKnVTMg7S9tiJE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Uc9eOnwDB8hladY/NtzgytBPKi/FBQqENxl6ssoW5XViLlxJFEy2W24UYwfQ5CoK
	 OEay/BVqPkpxHv5rMG6jkNAIboWWTeulxgFFmMrJtm5o2iaftpxItabkfdMIIPw3J
	 wRr3rUjE9jLhYUCcxxYB99uLsFKImkZLuif++p27tGnGw3P3CiwzCywYgyUqXbOV5
	 +y2v9Yy9AGj04zUow9Rxg8IGQJIOBJwMCDtHpkb0mqlzrnGWffIZr7Wwotr/Cw009
	 PpOBMKZJwV4G+o9G/A0MnVWK0rihAG5X78ErcnhkNg6JMs5Ljy3u/HqnJsrVe383b
	 mLwDtfSgovXntyImFw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.126]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmymp-1rs5jk0Yjv-00oGWj; Wed, 31
 Jul 2024 11:21:19 +0200
Message-ID: <333d0d04-5fe6-4fca-8cce-1bb557740a70@web.de>
Date: Wed, 31 Jul 2024 11:21:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t-example-decorate: remove test messages
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
 Git List <git@vger.kernel.org>
References: <5c838884-b606-465a-8f7e-ab760ddadef8@web.de>
 <D33CBWZJZSRS.1V3U16NM91BOA@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <D33CBWZJZSRS.1V3U16NM91BOA@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RKIi3fdW5gJfTsxod/vSnk6e9nMhcdHpBO8tX+CCHPCI+F+d7ZY
 /NgahatVe+SzRL14eSvbaPz10J21f9Pi6wrc8Bm9hkH2e8qNllyC/9cIlBPD3F3opiQQUYd
 euKwvcQRVECQxhWDfIPr3ACjkIt/+bJ3SgqGOzVfE9uCeQ2Gbtrpb35z8NonocFWVW9/bAS
 HqHI1DDsBcyU0/+QiTHfA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xfOKn2OikyE=;oKsgChxBwBUXeMM/R9OmKAsZDcY
 BBQ7o4BNj3f+hJA8F/IMzNYSD+UQ1G/3cAUy654Avn0CHWA4FSYxq7eGNhsfEljRb/Ktke1Mb
 SVFD8OyvJtnbtxxGRWsx52qICo8MZL0Qz4O6VZhaO2i6IWDKy65J35J+yb3jwSoc/CNyPD70U
 sTIjryhcLsF/9E/Lv+KSmBKdcjH1UE6aFp7VVPwSDYrqWKRgzbhYr86SYClp/BMNuRB59YiXN
 +8UNUGXG4aMvYXZDlGld+LUAmlVnsITpDeRycm++qJTqt89do5M5msz54X3REw0apz9kgmVvn
 mSnhte52Ww6Hv12FlakrrcIbC/ZKlhJWjw2BDL8RHL2jsYT8HIVIW4YOwZftAHwy8rLMZ1Zsg
 uYpTUkrdsn12wP5NVPIL46ATekyhE91eE495em5jqDS7Om86kKUGKFAdsWdhIQTr8nLQl67We
 EImI/RKHW8RwIougxNk+V8MktXUYvMkjUJ8l7FM2LbvLX+uto6XjzbCMim7J/8Hbrhi4IT1Gn
 2WrpwNyM2aEZ7BHNTwG0KhvhmpmrzLKsUCSEw57Swv7T90GuucWYJA5Q5lOs37Ua81FJAVfay
 l6xY28WsmxMV8l5nT2S9eqHF0SHo54j+OthtYvdPviI9Dm9ZfrtKUFWrVS9wTftx3v8Z7nqLe
 BrkuF9DyjPG2m2aJ7xh48MZHlLemh3gMgrgDJ0q6L8B9XMg8OpStETgOTEo/m43qezILk+LLQ
 09Ef/orhLbJW/yTDo5YopNuwY2kmQ5ez/6oM51icpVpA9Fb8YfDJ7zLpRMyES9G1Q2skT+FuR
 AOXNvtCt39Jkpe3CncBdStUQ==

Am 31.07.24 um 03:41 schrieb Ghanshyam Thakkar:
>
> If we want to further simplify, I don't see any need for having 'ret'
> either and to just call the methods in check():
>
>     check(add_decoration(&vars->n, vars->two, NULL), =3D=3D, NULL);
>
> which would also provide more context in the stdout rather than printing
> 'check(ret =3D=3D NULL)'. But, I believe you would have already consider=
ed
> that but kept 'ret' in favor of code readability, so I am also fine with
> it. Thanks for patch.

Good idea!  Worth a separate patch, though.

Ren=C3=A9

