Received: from cicero10.metanet.ch (cicero10.metanet.ch [80.74.152.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE8728DD3
	for <git@vger.kernel.org>; Sat, 27 Jan 2024 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.74.152.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706369240; cv=none; b=lIrxDqrRevTq9mEQeFmVw0n2VkR/PV3t35Yicoh9ORXQiQq68EgcNUp2AWO8rgj78UUFRZbESfsRLbFIRKC6bnnlHLYnagTElMCO9stE6h+vXsThwMe5VpwDmBHkLJ1qKlb4am6Lyxog66H/32V6AhQGCoCOShwQp2Y2f9Azv6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706369240; c=relaxed/simple;
	bh=cYbz8DH/P9rY7864giq5XKvCh4M2994PDNRZ/uzpH2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KtQH8cEUKAI6P4mWSTbCenP8VBktn2omyy1WDDkmHxGcPQm7vTaLJC2n8BCgCwSXV63EqETOSRbd2CMKi+HZFRLzhXWt7aYUC4Ybc/AxePAzO2ATkLVbF/2EaQ4UW2j98kBBN9wxBOgnFvlc0fNTmWAcO7tnUWXkgh72k+8soEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=king.ma; spf=pass smtp.mailfrom=king.ma; dkim=pass (1024-bit key) header.d=king.ma header.i=@king.ma header.b=HxrwDRfZ; arc=none smtp.client-ip=80.74.152.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=king.ma
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=king.ma
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=king.ma header.i=@king.ma header.b="HxrwDRfZ"
Received: from [192.168.111.27] (localhost [127.0.0.1]) by cicero10.metanet.ch (Postfix) with ESMTPSA id 350817490496;
	Sat, 27 Jan 2024 16:27:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=king.ma; s=default;
	t=1706369232; bh=/RGSfqDGFnc/0sEGMhTlsxD2BGx4AoXv1clUiibqB48=;
	h=Subject:To:From;
	b=HxrwDRfZhghcFatFoWg46u0Ew9QW247+/8YzlV7nqETdfQhRvtOB8vua4xUlICQsY
	 KVcZ4pqcw9w5qRoAPnFXv/7VmnaZJn7h+H40qkzJ9Cot60xRwF4fomApD9oU1zCjIj
	 9XKXx6/1RWm/mPtI07QD+9smhYXMA+xnrrBjoMi8=
Authentication-Results: cicero.metanet.ch;
        spf=pass (sender IP is 83.97.87.43) smtp.mailfrom=johannes@king.ma smtp.helo=[192.168.111.27]
Received-SPF: pass (cicero.metanet.ch: connection is authenticated)
Message-ID: <e64ea18e-a733-4a01-af1e-22a7f9d974dd@king.ma>
Date: Sat, 27 Jan 2024 16:27:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: add two steps
To: Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
References: <66e4baf4-439a-4a1b-ba95-1f9ed222d42a@king.ma>
 <a420cdc5-8294-4ffb-9f6c-06e1416ada43@drbeat.li>
Content-Language: en-US
From: Johannes <johannes@king.ma>
In-Reply-To: <a420cdc5-8294-4ffb-9f6c-06e1416ada43@drbeat.li>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I'm talking about installing git from git-scm.org. That _is_ a software 
that is installed.

On 27/01/2024 13:23, Beat Bolli wrote:
> On 27.01.24 10:43, Johannes Kingma wrote:
>> For git to work at least a user.name and user.email globals are 
>> needed. would it make sense to include this in the installation process?
>>
>
> The Git projects only distributes source code, so there's no 
> installation process as such that could be improved.
