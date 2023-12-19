Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC913D0D3
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="fUFDqzl4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703004166; x=1703608966; i=l.s.r@web.de;
	bh=XyL9jp8iygKdafpoUndenfXbKqEXZlrljmsrozXVXDw=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=fUFDqzl4FhgfT/EEiBZFsBG5QIRDaooB8feWUyaWocVIBtgC9nAbmVpXxZ5FPyTT
	 O2I14CoSdcKVN9dWM+tz3OsHTyJBlIyOFtCQz/d8nolOXSBjxflFGcuQeBJ+C66e1
	 OokrHAZJ/tgjC41FEqLY/TQ7cNUbkGOmFW0Vp2ZS98L7+Nib4tm1tWjpaoI9nClMv
	 fdxXsKhSOoe73ri1x4htaXXHNULSNxlnVgtAKvxt3vVvwbazkTP18gBdS7vF5P1Ae
	 psKagaKOpNsr028xTXQgKqAA4NvsdHZYrcsPEu51AtDI8tTi9+V9NWYa6p5GS3WrA
	 Th5gRboy7MYM5mOIrw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvsln-1qzD1N2d0x-00sX2N; Tue, 19
 Dec 2023 17:42:46 +0100
Message-ID: <3e6c7e70-33c2-4607-b9a3-8d70d2a83ff5@web.de>
Date: Tue, 19 Dec 2023 17:42:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Dec 2023, #03; Mon, 18)
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqr0jjc86e.fsf@gitster.g>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqr0jjc86e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7gLvvDgbNmKaw4MxTJg12boqFFiIghQdKC557bMcZFRpz3Ag9lj
 UQfFMXVsMItd/tSRhBcmRt2zym98/TsMdKOO5E5Nkqk0a/rYPhLAEWsZzRu4WVtF0OG0J15
 ktlgfbhIQ2vD3yIEnlmjARDNDBdlltOuBrO9Zk9jXqkQrtz4p30a3wgO/lINSOmAEszmiPw
 p4lnd8reJZt0KuIVkOTBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jotuOyqPrn4=;SDFn2z9dw7S9Yjd6xibi09M6s5F
 zj0liSQMim005zpRTtv4QK95U1HcNAKodQMJ4gmZSu8FzGCYyZrYwmr55MPTsEInseFKKIC8o
 mBZQ7TIf6SnpN+X4CpkB++RNEe9jb1zwP21rw3dO+3Pwb0wgB9uS8KYJ934oyueKscImu8THU
 c3a5UuY4VXQhRQSaM6YQ7UXbIZY11pNxUoCBb3ods6WNPxYrnlar2jIPnsHh7pw1jM+Xo+Utq
 w9Hp/7bylycc97Wlcuoekf4XY23j6uObC/nTkmkW7yHBbpt+zSIDcajUj9nExK0gnJdgalAjB
 DDPoaGbddrZ0L1PnalnhKu6RtUPhGB6zIK1p51HxKC5fMWkjFNWMAfuGgbJvEUi4d+9fCCkcp
 zCJTbA0gX/BE4yaeasec/F80N7sbOFVN+GCzmC5SiNuWS0j73LbE/NLRDESDeUWHB1gtfhiQ9
 uwW16wcbtkjVKuMfWc0hcFPdmdm0/AHcMW9j9rzzs1DsnMlXXsolzF19v+AZQXnbLewxJrkeG
 o8TXSWW+QWAoQNzqXw7OeEkN23Q8ut1V2DBwPrxBhaiVxHYobFQV/h0Kuw3x+CQBAK6Dxg+li
 rvzsJA973nXs14uTgXElVX0yf0LN53ltjobHYvR+hMk1/CERQszWw6tX8PAmt9NPQILQNfPON
 TkRINkARR//okEXrCz+QuTiVMbM2iP9mJi9HrZFRsgnxxxsedf0vXDkG7Sj1EvnvVZ6XSV5lF
 6hF4GxSm01OJ6MKwORbg1pjoyWU/6jaog2wxy4VSsNynltbDF2lkvitmKZ2wR2b+NBFFuNoVg
 dqLuBdO8FNuJZaGXIX0nUswD7q+coAUFs1j5j1XM/3dIagOjzDX5MWW+4afaHi0aFw43QbV7G
 aHNNnsxuK1UFvfVVZZL13AqDCvWXrS1cc18Llikz1T3s4BLz/DkWTalKMrmGrHXy+RgomUbkr
 b1nC7w==

Am 19.12.23 um 02:06 schrieb Junio C Hamano:
> * rs/t6300-compressed-size-fix (2023-12-13) 2 commits
>  - test-lib-functions: add object size functions
>  - t6300: avoid hard-coding object sizes
>
>  Test fix.
>
>  Will merge to 'next'?
>  source: <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>
>  source: <ff735aac-b60b-4d52-a6dc-180ab504fc8d@web.de>

The first patch is good to go.  The seconds one isn't; please drop it.

Ren=C3=A9

