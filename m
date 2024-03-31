Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585E96FCC
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711916479; cv=none; b=GnrjKQd/axXYcHDLIwuq3obPz0hSgkE3JAZyt92MQdH66uBMJOSQuHNpMc7bt9P+A7QI8rfmMaSLipI5w96jpNk5E1gQmo8el5uSrr+US7eZBCxA2nxJ+zd9uQ0Jl0SMFqEwLjXp/8mlmLUa/8m/A2mYE8kQkg+BaCTG3g0PcOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711916479; c=relaxed/simple;
	bh=0usSLrgHa0TeRo8jYK38K/t61ev7LeMxjc/AeCKUiW4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=s7NM6Q/PfmpHpfdDwwmUTznPb+vaNFrDrD4wJCQ3OEWeD/KBz/CV7ZyPOKQCylCBw3hFbeOOscHTDnCTYpFc23maOD0/hyHASTxgkm256cmISsQfL3PATmfxtVq7g92dSMLwZzxH9lZXvgUP3RV2/YgSRlUz6avaT/eEREOMbpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=JhnR6OlN; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="JhnR6OlN"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711916474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y58zYEap9QMTjbE0z5HedNbyLZk23jBMbCt/AxGC58c=;
	b=JhnR6OlNODnPq4giWhMQdmGOrGXAc6i0VI0/fI73bMAemrpPts+KLcOcmErzXK5XzSFoRZ
	ALQw71pkcnbyclhEasa7zCJDlUUIT48p2cl8r8s4z82hLil/5uXhF8meFZxHmfS6YcxS+C
	jQMdhFtiPNmMkbnNRAgO9dTZuJEO3lCUVpGVLWeCO8/ZzwnbtBJ6t1Sm/s1SlZuDhJhlhi
	E97jLmSsesI7AXJhX7wLcMXihW2yQ1lBgN/XlnCPx414utb1DaU8Mwz8zWU86HGjCafu3z
	EMcDH16wPd6wDYZAVO5wJBdf5zoQXXOeYK+SWEhbMoVkrGGT1DQRCeimw7XyXA==
Date: Sun, 31 Mar 2024 22:21:13 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] config: fix some small capitalization issues, as spotted
In-Reply-To: <xmqqo7avlaqn.fsf@gitster.g>
References: <6f6f821fc090fb59f632fcdbd061154b897b1244.1711772691.git.dsimic@manjaro.org>
 <xmqqo7avlaqn.fsf@gitster.g>
Message-ID: <769daf078b53d62f8232209b5547e6ed@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-03-30 21:34, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>>  On some file system/operating system combinations, this is 
>> unreliable.
>> -Set this config setting to 'rename' there; However, This will remove 
>> the
>> +Set this config setting to 'rename' there;  however, this will remove 
>> the
>>  check that makes sure that existing object files will not get 
>> overwritten.
> 
> Looking good, except that we do not want double-space after a
> semicolon.

Thanks, I'll send a v2 that fixes this issue.
