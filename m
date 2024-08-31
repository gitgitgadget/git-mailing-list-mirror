Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044BA3FC2
	for <git@vger.kernel.org>; Sat, 31 Aug 2024 01:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725068617; cv=none; b=PYBpeYc5xSETQ7GKBeT1wCV4Ep3UAPHI6Q3XhUy16ejzoi2tZ2qBQItBhtJ5onyozD7ziWu0laYpw/amyptl6cfK0Nmt51Mf6IlXQDWMwPApA52mXwxKYaV40YoStLP1/Aj8yb9ywA3mMmUpO5jUa5Fw5Dm6cUHFFw9PnITl0y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725068617; c=relaxed/simple;
	bh=G3nzlvA3ouaf2tMG+10o/OBZCVpryYD65Wpd68HxSpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EF4MCvneLFmzQxbB27uVA6iDTOTaxfDhQ+9W+zIqN3U+REnF+wVM9B0RrVVnqAMjJcmt1qOaYj/u+HXSghl6TrVSPOJHP6KA1xD/9O4KdRaN/Y3+dRMMOx1GFA9KI1aurcvTb/E0Cbvy7GOioEIbWZgk0xi17AjipZRmNslrzSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Al6/u0S9; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Al6/u0S9"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id kD6EsRn4o28tEkD6GsuuSZ; Sat, 31 Aug 2024 02:40:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1725068424; bh=v035kIlOTjSPuoZVDq1m/LEHoy2GKINSrdjQ0jPjSd8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Al6/u0S9G5x4GekUTKG7+CIEjK4UQt92JqJTjJgt0qepcSnGVOU1HXfBMmSk1PXNr
	 ASMyu7QHMcz/0G0mweGAss5u2h7adwyu4Du6fqGK5ColirKYg+0PVx2hcnDXKrNsMH
	 gitYhMBp1M17wc+KpYOH53E5Q/gtB243ORKsT6D1r6Oes2fDknYzV+eigw38k6jkuH
	 I/qQWxtjZqgCgyxZED2PnPyJpLoJSEkR931eBxVc2efwZQSJxpBwPBbX/VmzE234Ga
	 YCLqKTsdcLT49uDRh3ML1a0cvUoT9g5TicZtUiyR4pa8ffQ79ULf35Sfy+thJ/cAOY
	 menh/VeVigbOw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Hda3TTE8 c=1 sm=1 tr=0 ts=66d27488
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=YNQwINirT3CMJDUDQEQA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <44804f4c-26af-4d23-b044-ec32a13b549c@ramsayjones.plus.com>
Date: Sat, 31 Aug 2024 02:40:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] compat/terminal: mark parameter of git_terminal_prompt()
 UNUSED
To: Jeff King <peff@peff.net>
Cc: GIT Mailing-list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <d8c5e920-aff7-4e4b-af77-0d3193466b57@ramsayjones.plus.com>
 <20240829222612.GA445751@coredump.intra.peff.net>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20240829222612.GA445751@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIEhA9bAKqrDHUl3yhesVOMKPnFzaH35Ff7Q0bOHJhH76NTZanSRqamtraO39Tz71qEhglWkmTF5zDAdOyJcAJ0zdkVT6teUfPWB7U1oGfo4j+38KVjA
 PyPEUs2L2EIJw4hTClKvN3/6myXMu4e2ecQyIubhxmAJj2oYj3UnOYGmW5ezcQwq817XS9XnrWaJwIwrqZ7jl5c8c8p38J9djJo=



On 29/08/2024 23:26, Jeff King wrote:
> On Thu, Aug 29, 2024 at 10:57:50PM +0100, Ramsay Jones wrote:
> 
>> The 'seen' branch fails to compile on cygwin (but its fine on Linux), due
>> to an unused parameter. I haven't looked too hard at the code (at first
>> blush, it seemed to me that it should not even be trying to compile that
>> code, but ...), I simply added an UNUSED to fix the build. ;)
>>
>> So, this may not be the correct 'fix' for this, but I thought I should
>> report it here, since I don't have time to look into this now. sorry! :(
> 
> Thanks, this is definitely the right fix. I have to rely on CI for
> catching cases outside of what I build locally, and it looks like we
> don't trigger this fallback code at all in CI (we hit HAVE_DEV_TTY for
> Linux and macOS, and then GIT_WINDOWS_NATIVE for Windows).
> 
> Here's a potential commit message for the patch:
> 
>   If neither HAVE_DEV_TTY nor GIT_WINDOWS_NATIVE is set, the fallback
>   code calls the system getpass(). This unfortunately ignores the "echo"
>   boolean parameter, as we have no way to implement that functionality.
>   But we still have to keep the unused parameter, since our interface
>   has to match the other implementations.

Yes, this reads well. Do you want to send an updated patch or shall I?

> As an aside, I wonder if cygwin could be using either /dev/tty or the
> Windows variant. But that's obviously a separate patch, and either way
> we'd want to fix this fallback code in the meantime.

Yes, this is what I meant by '... it should not even be trying to compile
that code ...' ;) ie I was expecting HAVE_DEV_TTY to be set on cygwin (which
does have /dev/tty).

However, there may be reasons for it not being set - I haven't had time to
look into it yet.

ATB,
Ramsay Jones


