Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7BB8F40
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 01:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727833162; cv=none; b=r/sDKl1XHFs00GFF5Oz/urZaFE9bLm2yj79kGNty3DC28bJ+kQEFnyUpSWBnusHug4K9AHXGPyvbtCqpfz0ZEHBKdXqXw7Vc6AG8+RitRo1gGEgjf5AjdgEhLxd1ScgDPRqi1CFpifVMBOlXr7nHb039ippDBWJJMDUVjPQXT0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727833162; c=relaxed/simple;
	bh=H1ghn0htHe6JJhvOAg3ylLO970SC7UAcBTX4Mt02mD0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=X290lrKRnKsBz/+7Tva/85A13gR3Y7blLsofIucqcfIGVd5R56hC7Ash+YRaVfu1I2R6VYdeg6BcoachFhyhwNORx2KmOOlDP4qPiRw5jgN3qNcZt8c5t75pyVuo1CLyNbIAM9U+9x/sPgKKigu6L8YCMH1+pEzGySpc9t0ESHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=hamlin.carlisle@gmx.com header.b=K01P5aKj; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=hamlin.carlisle@gmx.com header.b="K01P5aKj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727833157; x=1728437957; i=hamlin.carlisle@gmx.com;
	bh=H1ghn0htHe6JJhvOAg3ylLO970SC7UAcBTX4Mt02mD0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=K01P5aKjZTdB/Vy2PD131vpbspqTLcRh31FcJBj7gQOv+qrNAp/etiSnXpKSMsFV
	 hKDx1qisNzakL9313yMFJ1rgsyPY4eUMnDcTEGRyhAqs6aVLZ4H2RCnU8ymqufPoI
	 fwVdTebqAsvmKWIeNy5z4cy3FTeloXr9AMpoplSTxQus+VTMcJ8KInHTYVjHLAuJt
	 fT/2CcFMKQqnefsIok0EtdXmfapVNlQ+g1IBHAfV7X0yk6ogzCn3hGMjXEj7T2fED
	 Jey6TNEjRjLmJ/Uua4/60qSsp4vFD4OiSXVO1GNwj12uLR4s1UTs9wNLX6k2dJZYt
	 peVZ6X6+5YmGSAsiyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.65] ([69.62.178.28]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXp5Q-1sNljF0Qs0-00UkI7; Wed, 02
 Oct 2024 03:39:17 +0200
Message-ID: <b84512cd-2997-48f2-b4d7-b3c6b63f1c89@gmx.com>
Date: Tue, 1 Oct 2024 18:39:15 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can a note be pushed to origin?
From: "Carlisle T. Hamlin" <hamlin.carlisle@gmx.com>
To: Stephen Steves Linda Smith <ishchis2@gmail.com>, git@vger.kernel.org
References: <20240925122918.1719619615FF@thunderbird.smith.home>
 <98470a2b-9a5c-4a22-a913-5098185afb65@gmx.com>
Content-Language: en-US
Autocrypt: addr=hamlin.carlisle@gmx.com; keydata=
 xsAiBEfLBpcRAgD8qfOOlcAEezHtcm6xrrZbwjKLXlIfKXUf/YiTeuaLk7TkfnvTVU5fwUam
 iewb7AN+t3mzKxcgwxViDnFQ8spDAKDtjKSLxKSCTYDVT8WR5w0NwOI3dwH9GetPPjCjJvnk
 JOr7yJOcyF0+T0bwR/cEUJ6nuQfbh2eVSNyWSiixsr14dQWphJf7CwGsTfIfv7vsZ+fIwP39
 rgIA+g8d2waPxl76gDjIygL6TrF6hhTt7KUb2yNgSng9IldkMfcdBYlg3dWOpZNNcZrTGOyd
 6xvhvmMuojRRx8r54c0oQ2FybCBULiBIYW1saW4gPGhhbWxpbi5jYXJsaXNsZUBnbXguY29t
 PsJjBBMRAgAjBQJYh9SnAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQyLm4ydrA
 Bve9TgCdGob4qLVTBIOjrTrY+/PmPPGby4AAn21LQfE5TXjJP298WdZNVCmAzXarzsFNBEfL
 B4oBEADbRPe1kVPw4r1YTMTRjRGKz1zF1juy+w7rgYmbwGE7g59jyb2jQYkiuUykupPom63I
 UAiHsTm7rt+GrHqJ2WjgBfDC7rUM0tWst5pKkt9Ma27l/O9J0T4YDr0kRDGhEUJPHI27V2D2
 NX52bDFgKiPl5WyRxtgAtTZC9KOdCPJ4t9c8waUIWlFn/YeWYerC2b15Sf3AB6bKVhP+2v91
 j/vOsTEFIlfg57fbQpEknGsLRIbO1V5Gx5FhFgycNh50zk86LiTz7pzZ19E6UnYuUEgaozru
 UjTQubdqPYOdgCnReTgcwo4ylon12sXjWHBScODgIYooPEUjAyn8H/m5i7jaSV5l2eZOUPvF
 8NPuuGUUWgMmQ+pCah3DnO3ccdaOOjW2z02Skx1XGep7Zyyn4hzV3cZpIhnOP5udwE1D3Pxr
 ljwVKs4uroPo28Eeh1KiYf95kP5KfzYafOpVx3QyykkiqQ4MEd1k61Y1ZoQ4pz+XskOym1DD
 9w6JdoAimsb7YGAqMQbSrtNSVpDMcYIDpXboDDussRmRD+Xoko/mhhQ2ZpUUyeqnlPHHmzSJ
 va0+hvBhw3QEv0QV7or3V1tN9r72o0KGp1un1n9IZv7JA4CKvs2oWPlR593d+pmHzZswK01Y
 ozFV+96kRXULHziVesdtlJCa+/341vc/p9teqKEJSQARAQABwkkEGBECAAkFAkfLB4oCGwwA
 CgkQyLm4ydrABvf1ogCfcujflHLQUSahVKgWtF/qDpK10+gAmwQ6EVxuZ3Z1GO6EbFxyRtm3 kOwI
In-Reply-To: <98470a2b-9a5c-4a22-a913-5098185afb65@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:41xgtZT8OyhcGwdODtXVA4lIgb17o8CqPTL0NBAaYkLxjQ6dFbQ
 elghtyudqdFhaig6S1ZRTZt1VttZcHkqLhMkLTSFqxr4mwTCu/iqSQvP3lpzHxjLrXcLHmC
 lVvzuA41ZZU9nQqVQtYv7SjBdqGBXKTJtrNRC7ij/5E3Z9Oc66U/AHoi0Lxw7sfMgwemwgS
 69FJB+JYYYon9pxWgbv0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aUTHwk9Zk6Y=;IJlWoiG8DnpOhbMTPVSp4VdXBOA
 wXIRGTTCZhZDtvLmQEWLv/9YERdBUFAcdSPQ9oqvhEXYQoL4gS4BVpMXUNppZrutQQKZQkPeu
 GafS4G0TPEHCdydXOPK7nF89M2Bkp1jNuHyKO8pnMoMIUvqwzlxulVBmEKW48DsaMkmHZ8Qux
 8z0bmDMuRJ05V0TydXaUecnrdvxFj15c9A9SQZ/f1Z16HKMUuGyO/wue2/T1n/QFNzoqdQJBc
 KB0fPguq6HBvgHTK2X6/Kbp5LuUxdjqvUB2ciwZWMnWxqUHckVAGwgDfQ2cuJMrPX95gnpyE7
 +AP729y8PmxcqbUQN8CSGnsa5EKGGcDYyEDxeoCQPSRubaWOxfdOSS2wtoqgdSe1csTLvLWUh
 6M9FcNHLnvNLbQLMHkBTP2fGw0tOVXwzlSk2k55uJYseNvIIF0JIkBfaL1i2pAnbETjf3cWTG
 dW80wszPy7yQtteRYhmqf4stJVuWUoHqZXyCoCR6TRxodyuAzbyZ1GJ00PFBWKt2pxCG7vqbX
 3M0DKFZ/85avcQZBUdmeOUYRVALZMcHP+vXliGtaxqxRXTfOVaTc4Nmk0kDpgGFFHxiJoUTx6
 Nn485PP1Lzl6e7NdgJSnON9d8eWQutd89j7LxFJ0WvbbqdEc4OKxtGbO6c/HRcarZ+SXaYZ2O
 fchr+g1Xlg+9ybkECxgup0ktYi/F7kuYmBrz+tInnx27Q1kUgMYtZLpwUiQqINk/5q7YCxz+Y
 wXAfZGOvvwr45EUpT0Dzwh3rfdHpeZDGUEbD3vGcCZgv57LpCebdVSVI/bq+8a8DONm6LILjq
 YiFvcp8v3Ir2Sctegrv06MFQ==

Oop - fat-fingered it; the commands are:

 > fetch =3D +refs/notes/*:refs/notes/*
 > push =3D +refs/notes/*:refs/notes/*

Accidentally typed an asterisk before the push directive. Don't do that. :=
)

On 10/1/24 18:37, Carlisle T. Hamlin wrote:
> You betcha.
>
> Add to the 'origin' entry in the config file specific to your local
> repository:
>
> fetch =3D +refs/notes/*:refs/notes/*
> push =3D *refs/notes/*:refs/notes/*
>
> Just be aware that other developers will remain blissfully unaware of
> your notes unless they either expressly fetch notes for themselves, or
> replicate your config setup as regards notes.
>
> Good luck!
>
> On 9/25/24 05:29, Stephen Steves Linda Smith wrote:
>> In a project that I am working on, some metadata is currently embedded
>> in some
>> source files.=C2=A0 The question was asked yesterday if there is a way =
to
>> move that
>> metadata a git specific file and link it to the source file or commit.
>>
>> I remembered that git has notes which can be used to add such data to a
>> commit, but I don't believe that such metadata gets pushed to origin no=
r
>> fetched from origin but another user.
>>
>> Is there a currently implemented way to do something like this?
>>
>
>

