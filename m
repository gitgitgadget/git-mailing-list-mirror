Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD31754B
	for <git@vger.kernel.org>; Thu, 22 May 2025 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747933818; cv=none; b=rRhtAUuSKv4VrIY3T8YlXev4zSQ1/IE6A6SnCpPQLXwHiNjKOE+o9LHQQhD2WIKQCHELNd/5ofTbjv2wHFLtPGOy2vIGkEhtbtBZDSNiP9aTgOjnL3nJedljkDVFn45vOl43j6HumOgmeLwvRRjk5y51n7/y2ydho+Bx80EbQMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747933818; c=relaxed/simple;
	bh=cdrwwYiTRrTTmQ/oN9fUfyG9HES0ETNjVW3aiwiextU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Ple+dcO7n1TDOcLvyERT+lbvRdrn6V2uEC3JbMupJHwVcFJb63PA86PiRauLYyYEG/SWydacU3ExnaaEnIapqTRRZ202jByxHR+mfrurry4XTmqK9U3Hbg7rwFfc7xheiQbtvueK99Ov1byCC1COCyxzckUTjr2drbSDLuw2FQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4b3FCg5mcWzRpKh;
	Thu, 22 May 2025 19:10:07 +0200 (CEST)
Message-ID: <086214b2-a747-4913-b279-aaf655e4869e@kdbg.org>
Date: Thu, 22 May 2025 19:10:07 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: gitk: regression when opening preferences with `want_ttk=0`
To: punk.lion0906@fastmail.com
References: <087f6a4d-d276-4f1e-94a4-7423b3387b79@app.fastmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <087f6a4d-d276-4f1e-94a4-7423b3387b79@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 22.05.25 um 04:55 schrieb punk.lion0906@fastmail.com:
> This duplicates https://github.com/j6t/gitk/issues/18.
> 
> I found a regression in `gitk`'s commit 904b36b. When `gitk` is run with `want_ttk=0`
> (AKA "use themed widgets" set to off), I cannot open the settings dialog since that
> commit.

There's a fix in this branch:
https://github.com/j6t/gitk/tree/yh/fix-non-themed-combobox

-- Hannes

