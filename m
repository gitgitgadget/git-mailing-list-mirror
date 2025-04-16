Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5B924A060
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845498; cv=none; b=SxM/uerBKtYI2THifM9ZSTECyfOg/1DcQrNKE6xWwDPOXSgh99wSfPFVyhZIJz/+Dt2WFTnB6tTKdCEsrEpc4wUCZT9n+QWGLIOX0v5uxsUp1/M6MFMeI+SiaR8QEffoVeKFXGCQNrUWcunHi3/IvDnkPJ4ZS8yAljGjAegMC+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845498; c=relaxed/simple;
	bh=SY7TG4eW5n5QMEOBghk8/M7ng9/YJYqQpZLvo6yCBx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NLSmJ6iNsqHNGz7h22UVrjZvSFSVwvYPYLmB7/stok4otvZYp6dz2QCvzYclmDq/7WpFcW2MGbGKx4/OY99eg4t7kHk8BOkZ0xgY1c1CA+KRkH6YvkQGH31+EVjQ5C80ZRV3xgSqQhuc0F6VCqdGc3Q4UwrBWlTdRhWk7LZ91lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=QMhwecie; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="QMhwecie"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 5C17uLy6ZjZe55C18u8KOl; Thu, 17 Apr 2025 00:18:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744845486; bh=iujjf9NaTAobyyuIe8Y0scyzmIG2OkOXXsxRIDrmKe8=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=QMhwecieZpiRjH3yd5OaM8q0/APdbFBdTpsO7irA+Dp9M90CD7iS3NssxXYGzHgpq
	 RrZb7N5LsuME52DemXfewiMf4A5lVW4m0+gfbt8bek0OeYasOnwpp/VzWvy3+tpRYs
	 mNQ2mr6Yz5qtJtnIswAETzHstyfJPkajumiTeFPVRmHw5XUMTVhTSDhK5D5Wq+K25i
	 it52g+4LF5+Jm54pa2b+8O6qGwMbC8HENwBGt5NZQv4B5FXHnPAkqp2auPLHpdEYaH
	 +DKAee0kj8BT8i+XsmKxpk0dFwiGs826eFyqxOxhBqtne0I2w3QO7Oc1gXwey7OjyH
	 PYGaGu0bBYSzQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=68003aae
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=joTYzCb8VwXEkBmcTb8A:9 a=QEXdDO2ut3YA:10
 a=LaJU0EyywUG5EMM38bpS:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <8790c486-8ebf-41b4-bf38-6e8b9f4d55bb@ramsayjones.plus.com>
Date: Thu, 17 Apr 2025 00:18:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Apr 2025, #04; Tue, 15)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqbjsxkn6x.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqbjsxkn6x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIi4CuznPGVtuPUMrtjN6l2O7az1Hs3Qya4wf/OS8k/+F5kSgDmMIyUkVSGj5CW3Ddmk2gXEO+wA2BKlYOVspnyS2N7IW8qLj2Unnh1i9VnrLS88AuUQ
 bznPeuezY97I6wHj+UnE5XzfXbgRxlrrZuNZ3Lg81REbW7N4PtI7O81PliYZzpRmq5D4A1K+iVz4W430lHWSSLrmrbiYTb9EWNk=



On 16/04/2025 00:41, Junio C Hamano wrote:
[snip]
> * rj/build-tweaks (2025-04-09) 13 commits
>  - config.mak.uname: set CSPRNG_METHOD to getrandom on Linux
>  - config.mak.uname: add arc4random to the cygwin build
>  - config.mak.uname: add sysinfo() configuration for cygwin
>  - builtin/gc.c: correct RAM calculation when using sysinfo
>  - config.mak.uname: add clock_gettime() to the cygwin build
>  - config.mak.uname: add HAVE_GETDELIM to the cygwin section
>  - config.mak.uname: only set NO_REGEX on cygwin for v1.7
>  - config.mak.uname: add a note about NO_STRLCPY for Linux
>  - Makefile: remove NEEDS_LIBRT build variable
>  - meson.build: set default help format to html on windows
>  - meson.build: only set build variables for non-default values
>  - Makefile: only set some BASIC_CFLAGS when RUNTIME_PREFIX is set
>  - meson.build: remove -DCURL_DISABLE_TYPECHECK
> 
>  Various build tweaks, including CSPRNG selection on some platforms.
> 
>  Expecting a (hopefully minor and final) reroll?
>  cf. <39bd9980-0009-4b2e-a8e8-b07b0013c2ec@ramsayjones.plus.com>
>  source: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
> 

OK, I'm just about to send v3 (hopefully I won't mess up with
'git send-email'). I forgot to mention in the cover-letter that
I did a test merge with master@77d6ee513f, next@fd585f713e and
seen@eab9365253; master and next auto-merged without incident,
but seen had a trivial conflict (I'm not sure why!).

ATB,
Ramsay Jones


