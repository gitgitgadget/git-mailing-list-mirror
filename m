Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447AC79D2
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 04:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749701790; cv=none; b=oiHlkSEgBRvCxU4XY94LOjuVXvrNTyefkKV9IC5rv0hyIa4TXvLVLkbTFfKvwFWM1CtT95qiAa611SFj7IUrNKE1OK5iXYsWBACrkroCTLPOPQflP1GNwoAW8duzFrcJScpswaI2dwIxIUWl0L8MAeMciSVYXo6czeR7p7/9uNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749701790; c=relaxed/simple;
	bh=bY6fj5utHYXqVVeiQQGgiP/6ENN9ZScX0mHBEqqTOcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Muw3HLqfLYjrEYt1IIvbnedj1xITavXE2PcIEXtealv457f9mdkvTsrY+4ZqlKyMCcXpq2toHGDreiGx+NrZcLVGWa+p/39ZEWEWxS8KCcgzwIH1PuniInnX79iGrRKgHdiP1WNghaRzX7eeIKUak2z/Qn1kvnsF9YQm1yGHKZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id D7359340AB3;
	Thu, 12 Jun 2025 04:16:26 +0000 (UTC)
Message-ID: <ed3d9c32-5de8-4653-be75-d2b5c89340e0@gentoo.org>
Date: Thu, 12 Jun 2025 00:16:23 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Solaris sed
To: Brad Smith <brad@comstyle.com>, Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org
References: <09f954b8-d9c3-418f-ad4b-9cb9b063f4ae@comstyle.com>
 <87bjqteicd.fsf@gmail.com>
 <f2082cde-7eb9-4927-a01c-e6fb3b355d13@comstyle.com>
Content-Language: en-US
From: Eli Schwartz <eschwartz@gentoo.org>
Autocrypt: addr=eschwartz@gentoo.org; keydata=
 xjMEZmeRNBYJKwYBBAHaRw8BAQdAYNZ7pUDWhx1i2f3p6L2ZLu4FcY18UoeGC04Gq/khqwfN
 I0VsaSBTY2h3YXJ0eiA8ZXNjaHdhcnR6QGdlbnRvby5vcmc+wpYEExYKAD4WIQTvUdMIsc4j
 CIi+DYTqQj6ToWND8QUCZoRL+gIbAwUJBKKGAAULCQgHAwUVCgkICwUWAgMBAAIeBQIXgAAK
 CRDqQj6ToWND8aB5AP9r4kB691nNtNwKkdRiOdl7/k6WYzokvHvDamXxRJ0I+gEAjZqR5V8y
 mfR3fy2Z+r2Joeqdt3CIv5IwPs64spBvigLOOARmZ5E0EgorBgEEAZdVAQUBAQdATT46Z06b
 1X9xjXFCYFxmq/Tj3tSEKZInDWTpoHQp4l8DAQgHwn4EGBYKACYWIQTvUdMIsc4jCIi+DYTq
 Qj6ToWND8QUCZmeRNAIbDAUJBKKGAAAKCRDqQj6ToWND8a2RAP40KPfbfoiZAJW5boFmFJ3G
 TUBDJRh9CWHyaPqq2PN+0wD/R07oLzfnJUN209mzi9TuTuHjeZybysyqXSw4MAxkMAY=
In-Reply-To: <f2082cde-7eb9-4927-a01c-e6fb3b355d13@comstyle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Gda27M1z4YzwlJgLzF664D9C"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Gda27M1z4YzwlJgLzF664D9C
Content-Type: multipart/mixed; boundary="------------v9aOS1ec0Aj8Q10v7Yv8pEzJ";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Brad Smith <brad@comstyle.com>, Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org
Message-ID: <ed3d9c32-5de8-4653-be75-d2b5c89340e0@gentoo.org>
Subject: Re: Solaris sed
References: <09f954b8-d9c3-418f-ad4b-9cb9b063f4ae@comstyle.com>
 <87bjqteicd.fsf@gmail.com>
 <f2082cde-7eb9-4927-a01c-e6fb3b355d13@comstyle.com>
In-Reply-To: <f2082cde-7eb9-4927-a01c-e6fb3b355d13@comstyle.com>

--------------v9aOS1ec0Aj8Q10v7Yv8pEzJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 6/11/25 11:49 PM, Brad Smith wrote:
> On 2025-06-11 11:42 p.m., Collin Funk wrote:
>> Hi Brad,
>>
>> Brad Smith <brad@comstyle.com> writes:
>>
>>> Building on Solaris I noticed the following two issues with Solaris s=
ed.
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 GEN version-def.h
>>> sed: Missing newline at end of file standard input.
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 GEN config-list.h
>>> sed: illegal option -- E
>>> Usage:=C2=A0 sed [-n] script [file...]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sed [-n] [-e script]=
=2E..[-f script_file]...[file...]
>>>
>>>
>>> https://github.com/git/git/commit/
>>> e1b81f54da80267edee2cb8fd0d0f75f03023019
>>>
>>> The second issue being introduced fairly recently. Not sure what
>>> would be
>>> appropriate fixes. Just pointing them out if someone has an
>>> suggestions for
>>> fixes.
>> I noticed these as well, but just ignored them since it seems to build=

>> fine.
>>
>> The first one seems like just a warning? Probably something to do with=

>> POSIX defining a "Text File" as "A file that contains characters
>> organized into zero or more lines" where a line is "A sequence of zero=

>> or more non- <newline> characters plus a terminating <newline>
>> character."
> It looks as if it is just a warning to me. I wasn't worrying about that=

> one as much
> as I was the second issue.
>> The second is more tricky. The '-E' option to use EREs was not added t=
o
>> the specification for 'sed' until POSIX.1-2024 [1]. Maybe the script
>> could check for the 'gsed' command? All of the (few) Solaris machines =
I
>> use will have many GNU programs installed like that.
> I can't comment on that especially as the build bits support pretty old=

> releases and
> I have no idea how long Sun / Oracle have been shipping GNU bits like
> this. I do not
> believe this has always been a thing.


The Solaris box I have a shell on, has gsed installed as a purely
optional third-party addon from a third-party package feed. As far as I
know, Solaris never did nor plans to ship "GNU bits like this".

Of course, the Git project *could* declare users must first build GNU
sed, then build Git. Or only build on boxes where the admin is a GNU
enthusiast. But that option seems unlikely and unattractive...


--=20
Eli Schwartz

--------------v9aOS1ec0Aj8Q10v7Yv8pEzJ--

--------------Gda27M1z4YzwlJgLzF664D9C
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaEpUmAUDAAAAAAAKCRCEp9ErcA0vV0nX
AP9N8BmLg6p05OPWzxVDm0FgPhvsyLNacz7kgoeoakWO5gD/U+CO8N74nHtlvJAe2j+dZkHPws6j
4a7eOxYOcgVJ2gE=
=xzDf
-----END PGP SIGNATURE-----

--------------Gda27M1z4YzwlJgLzF664D9C--
