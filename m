Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556131ABEA4
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 23:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722641592; cv=none; b=hbWKRYPR56gUG+z5+qzxzLwpwbInBpaBrFONipui/WDWIDC4TdE7Jmr6xgwhWjjLdfrqnYPgdd4wsfClvpU4HdvTazZunwK/99uFp9Wt2i6bdgUxdSGawBAFxbEK/iuwpi731kZdxyC4LhKt5TzxkVyRA5yUYueeJgFKVgidzVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722641592; c=relaxed/simple;
	bh=QUzRB3HMhm/vNQzGF7ZP7yij4/r+21F/QL6alM8LqJU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=MUtlMX4zb3qvAm860TmCOz+CbndFdWjBBCWrYoiO7Iwdb0E5I/sJRdROKSjj8IExliv6wwC71ZKMi2/0WH5A2Fzc6vp5S2hSiwQhmL09ZrfVeKDIdfmJXTqCg+EDc3Qu4c7iGHL6VdovjujhS4u7kG/0QqVumRfk+KOJqkwqxto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 472NX2Dc3740160
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Aug 2024 23:33:03 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Emily Shaffer'" <emilyshaffer@google.com>
Cc: <git@vger.kernel.org>, "'Taylor Blau'" <me@ttaylorr.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" <avarab@gmail.com>
References: <20240802221948.2367124-1-emilyshaffer@google.com> <xmqqjzgy8psp.fsf@gitster.g>
In-Reply-To: <xmqqjzgy8psp.fsf@gitster.g>
Subject: RE: [PATCH v5] Documentation: add platform support policy
Date: Fri, 2 Aug 2024 19:32:57 -0400
Organization: Nexbridge Inc.
Message-ID: <041101dae534$51a440b0$f4ecc210$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKqRnxj7vnkEvlnESPNn2fxHf/AuAH4lWdGsGYWzUA=

On Friday, August 2, 2024 7:32 PM, Junio C Hamano wrote:
>Emily Shaffer <emilyshaffer@google.com> writes:
>
>> - Wording and bulleting format fixes in commit message and body
>>
>> - Clarify cadence for tests against 'next'
>>
>> - Attempt to clarify dependency version minimum requirement to =
something
>>   reasonable and flexible. Note: This section still probably needs
>>   better wording; I took a crack at it but it still feels awkward.
>>   Suggestions welcome, please.
>>
>> - Be more realistic about finding non-intrusive platform support
>>   approaches ("we'll look for" rather than "we'll definitely find and =
in
>>   fact know a few options in advance")
>>
>> - Move up "Minimum Requirements" section to the top, so we don't
>>   bait-and-switch maintainers of platforms who don't even meet the
>>   baseline but start making effort to set up testing infrastructure =
and
>>   so on.
>>
>> I believe that this version addresses Randall's concerns with the
>> "minimum requirements" policy. Are there any other outstanding
>> concerns with the policy itself, as written, or is this ready to go =
in
>> (modulo nits)?
>
>I won't be able to speak for Randall, but I didn't see anything =
questionable in the
>changes since the previous iteration (I have not yet read the whole =
thing again,
>which I will later).

I still have to think about it, but so far, it looks like I can live =
with this.

