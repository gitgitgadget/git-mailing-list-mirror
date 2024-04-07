Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133621170F
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712478942; cv=none; b=R9o2BCVKt8BuMbrsUXNYoJ2ooS1VPU6eH06B28nQTce6pzr8VkzrobskswqjH7fBX5C3MHA/5EzB2Wzt6U06UbAIJ+dDE87IhZ6RGJHGobH3+Xe7+JETSEaL7VD/i4Ftq2hc47Bj61kXr/MQ0NqL9K6f6y4zqXb6S4HAtz0rmrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712478942; c=relaxed/simple;
	bh=rDN8IeB54oga9I27OnkxLRVW1iMKBDrEK6lfGhfCf28=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Q06FMQJGUhiu6bLtMER53O4XCa0feHUm1I/shJp+hP6bLUwvlt5bBQQzXUYZ8z0YmSvVb4DN6WMU6ZrFjEYGF2/yj+hYu3b7FjQRJWFhN014kcAhzt4r9HtVKarfGDNGwwcXtND58o3yjahycfeKPXDDr49JjPwbGmBM+uGxBWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=wP1ar8/B; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="wP1ar8/B"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712478937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFg8PN0X5BMGnflhuWZMkEsxP8dIpTULSqLWv2sARL0=;
	b=wP1ar8/BEMon6O/SXN8ZpgX/OpvEfWB/RcTBYxRv0ZOYiquDtC6hPO6u/g6W9xPUIT5C0n
	PzZ3VgCaBGqdFqUV9HtQnb3jR3QyCUiOke8pwgb5sig2rmRCZbDg/O4FSuIWL75yiaT4x9
	k0iTm8Rpox6OwJPd7NejVF4YhmlUlvU2r98J2lgBgfa/SrySCGV++lQ/yKLHH2/Q0BAX+Q
	cU8fJjq+HiZteiRj9G2d3q+Q72lJXEKOAKAuftCLmNF2FtJFW0wGemjUyTds31u4rUtcKK
	0EtcZpQC5s4JC1qZfTg+3hsqFQ9FJUQSRDrhzDgRJb8wL+hwS2lTzfQTpo2B/A==
Date: Sun, 07 Apr 2024 10:35:37 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Quang_L=C3=AA_Duy?= <leduyquang753@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] Add separator lines into `git log --graph`.
In-Reply-To: <CACXAH50uHNreqhK9hn9_SPARCCq2gfAOs4krGS-Xa0-5GKSvtg@mail.gmail.com>
References: <20240407051031.6018-1-leduyquang753@gmail.com>
 <20240407051031.6018-2-leduyquang753@gmail.com>
 <CAPig+cROH8Ebu9CgR87-48+Rk0H3maN+dwB+Y-N2FTvy5shE1Q@mail.gmail.com>
 <CAPig+cSfpWaanknSqMGEza7rPhXwgQ0k3V9svfuBsZ_C2EaCmw@mail.gmail.com>
 <CACXAH50uHNreqhK9hn9_SPARCCq2gfAOs4krGS-Xa0-5GKSvtg@mail.gmail.com>
Message-ID: <559a32ce4bd3060ff2a1c352c62c6161@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-07 09:06, Quang Lê Duy wrote:
> On Sun, Apr 7, 2024 at 12:52 PM Eric Sunshine <sunshine@sunshineco.com> 
> wrote:
>> I forgot to mention that application of your patch results in some 
>> warnings:
>> 
>>     % git am add-sep-lines.patch
>>     Applying: Add separator lines into `git log --graph`.
>>     .git/rebase-apply/patch:61: trailing whitespace.
>>     .git/rebase-apply/patch:147: trailing whitespace.
>>     .git/rebase-apply/patch:151: trailing whitespace.
>>     .git/rebase-apply/patch:160: trailing whitespace.
>>     warning: 4 lines add whitespace errors.
> 
> Indeed I failed to notice the whitespace `vim` added to the empty 
> lines.
> Appreciate your notice.

As a note, vim can be configured to highlight the trailing
whitespace, making it easy to spot.
