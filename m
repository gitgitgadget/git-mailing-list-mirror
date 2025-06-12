Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425874A35
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 03:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749700174; cv=none; b=XV24htFgZ1x8lYFbVcSy3HMkR9rsJbTjabnYjWqm/bbqZ7sbqCGKTOnnsjw25rc1wv8yIxOJ7/5Ki6ujV+5aHQUYzf90T8gm0UMeUsMI1mcOoMfAG2IXPll/1I7i6RdeT/tJ8Tl9folr5dNotepCCu0SJUDSCxgXzgw2j+cy1bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749700174; c=relaxed/simple;
	bh=5WhBcmm9Q2UKul3WO54JbR8sU19IwcOvwrxpE/SIsOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEhYFQvN9YAxkxt0AIaI9od4pcA7qjeKQO6vSr/MzhWKet280yXB1eivDkfwMguiCOOujwyNc5pSmlzRLORG4r7+U2r+6RHxj1viZ6+UKXlBwFg9Gtb09sDUn5LkVm76JUTbUqwo/I/dwRETSpE+uev+O0/i71IoMIOgaJP8ezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=fpoFq58i; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="fpoFq58i"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4bHpSD0W6Yz8PbP;
	Wed, 11 Jun 2025 23:49:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=5WhBcmm9Q2UKul3WO54JbR8sU19IwcOvwrxpE/SIsOw=; b=fpoFq58i325A
	94ByyvEIRmH8M1vxL6aEaQsoc3hO7/H5cQHcSqbLEmpVGqnSyyywx2cDZ6BmbeW8
	FrqkeYQ972f7ttopYDw793S2sxKvC+q1Km4Akx+SfiFJtfBVVY0cIW6UhhukBpAx
	njNGY3brpW8iWwT/GzsWyCvkdA1fy9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
	:date:mime-version:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=default; b=gGB
	Gt+/hS+8FmrkRMDSGXQt82gQqMPbzAjqtYWD2LPhx0pMnfAUgkKFPURRZOy1IQGU
	eKEOMYWu3fuV8DMN3Y4njmAa2NKHYLRnds0YpgEmKNb5gzKwUovp0mdE5FmuE7m5
	uxMsTv3aB1RKjvB+bUBDbNnbBSgKMRctLlyP5EHk=
Received: from [IPV6:2001:470:b050:6:142d:4b81:8fea:90b2] (unknown [IPv6:2001:470:b050:6:142d:4b81:8fea:90b2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4bHpSC74zBz8PbN;
	Wed, 11 Jun 2025 23:49:31 -0400 (EDT)
Message-ID: <f2082cde-7eb9-4927-a01c-e6fb3b355d13@comstyle.com>
Date: Wed, 11 Jun 2025 23:49:30 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Solaris sed
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org
References: <09f954b8-d9c3-418f-ad4b-9cb9b063f4ae@comstyle.com>
 <87bjqteicd.fsf@gmail.com>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <87bjqteicd.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2025-06-11 11:42 p.m., Collin Funk wrote:
> Hi Brad,
>
> Brad Smith <brad@comstyle.com> writes:
>
>> Building on Solaris I noticed the following two issues with Solaris se=
d.
>>
>>  =C2=A0=C2=A0=C2=A0 GEN version-def.h
>> sed: Missing newline at end of file standard input.
>>
>>  =C2=A0=C2=A0=C2=A0 GEN config-list.h
>> sed: illegal option -- E
>> Usage:=C2=A0 sed [-n] script [file...]
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sed [-n] [-e script]...[-f=
 script_file]...[file...]
>>
>>
>> https://github.com/git/git/commit/e1b81f54da80267edee2cb8fd0d0f75f0302=
3019
>>
>> The second issue being introduced fairly recently. Not sure what would=
 be
>> appropriate fixes. Just pointing them out if someone has an suggestion=
s for
>> fixes.
> I noticed these as well, but just ignored them since it seems to build
> fine.
>
> The first one seems like just a warning? Probably something to do with
> POSIX defining a "Text File" as "A file that contains characters
> organized into zero or more lines" where a line is "A sequence of zero
> or more non- <newline> characters plus a terminating <newline>
> character."
It looks as if it is just a warning to me. I wasn't worrying about that=20
one as much
as I was the second issue.
> The second is more tricky. The '-E' option to use EREs was not added to
> the specification for 'sed' until POSIX.1-2024 [1]. Maybe the script
> could check for the 'gsed' command? All of the (few) Solaris machines I
> use will have many GNU programs installed like that.
I can't comment on that especially as the build bits support pretty old=20
releases and
I have no idea how long Sun / Oracle have been shipping GNU bits like=20
this. I do not
believe this has always been a thing.
> Collin
>
> [1] https://pubs.opengroup.org/onlinepubs/9799919799/utilities/sed.html
>
