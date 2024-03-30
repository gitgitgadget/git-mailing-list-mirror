Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3121C0DFC
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711786492; cv=none; b=R+j77ACe1gFAztSj4uGe62xqqhNZcno/w5nCgUYTgG3HTFjjwo/Pq9xX9wIZHPHgUb3V3sTe6p/m9tf8kd1Gs5c2596R3Ekz5OIm9KIorXCIVIKr0l9RIElwc9Swhn0dvdKdKx/G8sLI5NvaBWrK0KWbOVLlJjLF8KtMBThN05Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711786492; c=relaxed/simple;
	bh=AUegbmUPK25YidUafGsOHRoHC+FiA8tAd+blYQkhNcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jY1UCoShHqtL1w+qOa7g1Y9u+NsihBs7Ustu0t914oL1bUfsDwC0oeyQl6LVAusuFWNibjtQW2LiiK0ISdzu32N6BYxA97B/zWuCrFLmOiOKGLfqp5bRGCSoECJp/3DJPcJaHRWxDcp8vrdaiHMeOcpouNlADoy70jveFCzecsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=occtvKwb; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="occtvKwb"
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id CB43A1A0A7D2;
	Sat, 30 Mar 2024 09:14:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711786487; bh=AUegbmUPK25YidUafGsOHRoHC+FiA8tAd+blYQkhNcE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=occtvKwbr9hH1CeKKPictxKmLeX9v0e4uz6TA46G08dbd69eiHn486tPGioMG1Rn4
	 QLxJ5mZ6ZwGbWHgNGUwGvHv0fkzrgG7AgqC57dlTe0g45NsORXFAlmYv1pY43Jvq7Q
	 8LaWZ7V5FMjy5badV7O4nb2HiKnvS5gMMjlfV+ao=
Message-ID: <1d6a282e-afe6-4d43-a61c-d0259131b11c@schinagl.nl>
Date: Sat, 30 Mar 2024 09:14:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git mirror at gitlab
To: Patrick Steinhardt <ps@pks.im>,
 Christian Couder <christian.couder@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 psteinhardt@gitlab.com, Taylor Blau <me@ttaylorr.com>
References: <2a833bfc-a075-4e78-ae6c-270f5198d498@schinagl.nl>
 <ZYQl_G-S4vQibHWn@framework> <Zad1S3vCuv4KYIzx@tanuki>
 <ZfwY_h70OeuRT7mk@tanuki> <xmqqy1aba6i6.fsf@gitster.g>
 <E5C00398-536B-4CE5-AB25-FE7FCD55CCD8@schinagl.nl> <ZfzUb9HkZLq1UIed@tanuki>
 <CAP8UFD2LmapWutRpfveL6ChSg8xrCkQXyQaJwHyEp8JA0p_Osw@mail.gmail.com>
 <Zf2B5oksaJRDH5WT@tanuki>
Content-Language: nl
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <Zf2B5oksaJRDH5WT@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22-03-2024 14:04, Patrick Steinhardt wrote:
> On Fri, Mar 22, 2024 at 11:08:34AM +0100, Christian Couder wrote:
>> (Sorry for initially sending this privately to Patrick.)
>>
>> On Fri, Mar 22, 2024 at 10:41 AM Patrick Steinhardt <ps@pks.im> wrote:
> [snip]
>>> I'd personally rather go with the latter, mostly because it matches our
>>> git-scm.com domain. I also like it better than the current git-vcs/git
>>> because of that.
>>>
>>> So Chris, would you mind adding me (@pks-t, my non-GitLab handle) as an
>>> additional owner of that group?

I'll empty out my gitscm group, make it private so that it won't be 
accidentally used and transfer ownership to pks-t. You can then 'do what 
is needed' with the group. Since gitlab doesn't support aliases (yet? 
:p) best to park the namespace.

Olliver

>>
>> Done.
> 
> Thanks! I've set up the repository at https://gitlab.com/git-scm/git
> now. I'm coordinating internally to get it signed up for the Open Source
> program that we have at GitLab for CI and mirroring functionality.
> 
> For any of the stakeholders in the Git project, please feel free to
> shoot me a message with your GitLab handle so that I can add you to the
> group/project.
> 
> Patrick
