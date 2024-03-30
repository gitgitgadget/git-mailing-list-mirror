Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AB1BA22
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711786828; cv=none; b=HPQjreOpTJ5EkIugW4NTo+Ptoz1oVbjVGF73hv6Z9ShYL1b/o7fSdKz044ugBBW7MOw5TJ2dRHtl6dNAzLeiKbQozikNymolA55lG0A/JMhsunB/Ru8Eo1wOcvYLmK9BVe1cTcE6tngaZ3CEI6j9VJIMeYdQVDjuQIRn0a8LDr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711786828; c=relaxed/simple;
	bh=Cf/JEcO8vq9bQRrSFdV9avqrPmP/pIUdBs97Qvzq+fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7rZ1skMsiGlwOAamiMxEhcKUtDApvRyVCvfJgqLsdO3mTLPMYFJWQG5ORxJTC9qEzCXFqTnl70yH5PVsMy8Bv0brVYUHxQxlGq5Ft0IJ1wYT9frukuzj366YSA1CH7yEgnopXxFAN43EiPDCQgmc1wOvC+u/WkbhDstN1aXWd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=KM8C0t6l; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="KM8C0t6l"
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id D26381A0A7EA;
	Sat, 30 Mar 2024 09:20:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711786823; bh=Cf/JEcO8vq9bQRrSFdV9avqrPmP/pIUdBs97Qvzq+fw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KM8C0t6lC0TuXQHZ3PxOvlYP4xMPRBsUl3HHRvm64Tf9tLGidEFPTZxFAMixzHKyd
	 VLZdLJLFANgQXzKe+i26ECJBsT0Ov7+tfPeFryPNwQJjY+DeMckKqta8eAQ9CiCLPP
	 U65Tq5DJKrCKL24+XjzhDGZR5qY1vDQgCB+lXeLw=
Message-ID: <f283d6ed-54b6-4bbd-8b14-67c9c8d50a2a@schinagl.nl>
Date: Sat, 30 Mar 2024 09:20:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git mirror at gitlab
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 psteinhardt@gitlab.com, Taylor Blau <me@ttaylorr.com>
References: <2a833bfc-a075-4e78-ae6c-270f5198d498@schinagl.nl>
 <ZYQl_G-S4vQibHWn@framework> <Zad1S3vCuv4KYIzx@tanuki>
 <ZfwY_h70OeuRT7mk@tanuki> <xmqqy1aba6i6.fsf@gitster.g>
 <E5C00398-536B-4CE5-AB25-FE7FCD55CCD8@schinagl.nl> <ZfzUb9HkZLq1UIed@tanuki>
 <CAP8UFD2LmapWutRpfveL6ChSg8xrCkQXyQaJwHyEp8JA0p_Osw@mail.gmail.com>
 <Zf2B5oksaJRDH5WT@tanuki> <1d6a282e-afe6-4d43-a61c-d0259131b11c@schinagl.nl>
 <ZgfK3DoeidDcIaFj@framework>
Content-Language: nl
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <ZgfK3DoeidDcIaFj@framework>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30-03-2024 09:18, Patrick Steinhardt wrote:
> On Sat, Mar 30, 2024 at 09:14:47AM +0100, Olliver Schinagl wrote:
>> On 22-03-2024 14:04, Patrick Steinhardt wrote:
>>> On Fri, Mar 22, 2024 at 11:08:34AM +0100, Christian Couder wrote:
>>>> (Sorry for initially sending this privately to Patrick.)
>>>>
>>>> On Fri, Mar 22, 2024 at 10:41 AM Patrick Steinhardt <ps@pks.im> wrote:
>>> [snip]
>>>>> I'd personally rather go with the latter, mostly because it matches our
>>>>> git-scm.com domain. I also like it better than the current git-vcs/git
>>>>> because of that.
>>>>>
>>>>> So Chris, would you mind adding me (@pks-t, my non-GitLab handle) as an
>>>>> additional owner of that group?
>>
>> I'll empty out my gitscm group, make it private so that it won't be
>> accidentally used and transfer ownership to pks-t. You can then 'do what is
>> needed' with the group. Since gitlab doesn't support aliases (yet? :p) best
>> to park the namespace.
>>
>> Olliver
> 
> By the way, thanks a ton for being this open and helpful during the
> whole process. This is greatly appreciated!

Hey, no problem. I initiated this discussion because I wanted to get to 
this solution. Just because my mirror is not used doesn't mean I don't 
agree :)

Btw, I can't transfer the group, it's empty, but if I delete it _right 
now_, you'll have to re-create it, _right_now_ (well within the next 5 
minutes?).

Olliver

> 
> Patrick
