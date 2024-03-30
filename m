Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B1417745
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711796398; cv=none; b=c9kdy0D2RXSi99mQ11ZEjLeO4R57RlD8unOfuaagxUbvCA0piVC6VoTJnWgD0maNh9BosNON9Q9yOr9SehF+pHxKaFN2/CY8lEeK5VnRMjwkWdg+ne76Jg4k2QDLDzXs4dDZr25m5qizygA372mqfxwrOcQPUuy1KNtWs3Ojy2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711796398; c=relaxed/simple;
	bh=0w9N+q8o65VAi9HOkCsS+Sw+75JJOEmjz4l7oFZgoTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dg3pt+igtOxRuzYIddWWKvYUD+gqNSjS+4+UUn8Nqrq4L3hKbPgYrv6y5ss/+CentodHHJFPekvwD3pV4X3Sj19Ma4GFauMNL3Xa25Mhgxn/x7oSU4i2GAU/8ODeZhzKIPs3xFkrzaaiOCAgyPr5Wv8kKH8K3iHGEootxH3GS5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=vOG19OI7; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="vOG19OI7"
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id C957B1A0AAA2;
	Sat, 30 Mar 2024 11:59:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711796391; bh=0w9N+q8o65VAi9HOkCsS+Sw+75JJOEmjz4l7oFZgoTA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=vOG19OI7kXZksqVSNFzdzeHYyPe54RBrNGbstq8ykE9v+EvA3Ud5egYvDp91M9BZU
	 uc/EqKoTrRhTnn26Fv7U8HSn3DskFrDBAraOoEBOA14+dVr/jMi+5uh/aDbuYBtcEN
	 WVQ2qPUHP5DvJ9YwJjfw3RBM+2vG3agtLYxdAv30=
Message-ID: <68563c5e-af74-4300-84c4-a0d75434167f@schinagl.nl>
Date: Sat, 30 Mar 2024 11:59:51 +0100
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
References: <Zad1S3vCuv4KYIzx@tanuki> <ZfwY_h70OeuRT7mk@tanuki>
 <xmqqy1aba6i6.fsf@gitster.g>
 <E5C00398-536B-4CE5-AB25-FE7FCD55CCD8@schinagl.nl> <ZfzUb9HkZLq1UIed@tanuki>
 <CAP8UFD2LmapWutRpfveL6ChSg8xrCkQXyQaJwHyEp8JA0p_Osw@mail.gmail.com>
 <Zf2B5oksaJRDH5WT@tanuki> <1d6a282e-afe6-4d43-a61c-d0259131b11c@schinagl.nl>
 <ZgfK3DoeidDcIaFj@framework>
 <f283d6ed-54b6-4bbd-8b14-67c9c8d50a2a@schinagl.nl> <ZgfWH_smdZ1jXkLO@ncase>
Content-Language: nl, en-US
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <ZgfWH_smdZ1jXkLO@ncase>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30-03-2024 10:06, Patrick Steinhardt wrote:
> On Sat, Mar 30, 2024 at 09:20:22AM +0100, Olliver Schinagl wrote:
>> On 30-03-2024 09:18, Patrick Steinhardt wrote:
>>> On Sat, Mar 30, 2024 at 09:14:47AM +0100, Olliver Schinagl wrote:
>>>> On 22-03-2024 14:04, Patrick Steinhardt wrote:
>>>>> On Fri, Mar 22, 2024 at 11:08:34AM +0100, Christian Couder wrote:
>>>>>> (Sorry for initially sending this privately to Patrick.)
>>>>>>
>>>>>> On Fri, Mar 22, 2024 at 10:41 AM Patrick Steinhardt <ps@pks.im> wrote:
>>>>> [snip]
>>>>>>> I'd personally rather go with the latter, mostly because it matches our
>>>>>>> git-scm.com domain. I also like it better than the current git-vcs/git
>>>>>>> because of that.
>>>>>>>
>>>>>>> So Chris, would you mind adding me (@pks-t, my non-GitLab handle) as an
>>>>>>> additional owner of that group?
>>>>
>>>> I'll empty out my gitscm group, make it private so that it won't be
>>>> accidentally used and transfer ownership to pks-t. You can then 'do what is
>>>> needed' with the group. Since gitlab doesn't support aliases (yet? :p) best
>>>> to park the namespace.
>>>>
>>>> Olliver
>>>
>>> By the way, thanks a ton for being this open and helpful during the
>>> whole process. This is greatly appreciated!
>>
>> Hey, no problem. I initiated this discussion because I wanted to get to this
>> solution. Just because my mirror is not used doesn't mean I don't agree :)
>>
>> Btw, I can't transfer the group, it's empty, but if I delete it _right now_,
>> you'll have to re-create it, _right_now_ (well within the next 5 minutes?).
> 
> Shouldn't it be possible to add me as a secondary owner of the group in
> [1]? From thereon I could "transfer" the group by removing you from it.

Done and done.

I'll remove myself, or you can kick me :( one I know you have 
successfully received ownership. I tried to invite the group git-scm but 
that couldn't be found, probably you can do that (and then remove 
yourself :p)

Would have been useful to transfer ownership of a group, iirc you do 
that with repo's as well? Under the hood it could use the invite + 
remove members thing. Though this works.

> 
> Patrick
> 
> [1]: https://gitlab.com/groups/gitscm/-/group_members
