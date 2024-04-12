Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25782233B
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905024; cv=none; b=DnT1XnZq16aA7SCNulA/mBTe7w+23iD1dF1t8NgUgDtyINYhHRIsk2MBi/+nBL28RELjyxSFGIkbpJgS3n08V5pscEzZ8uhfG0WNmpMDetZevqqOw9eDIe5KgTeq2wYhMPgOp/jlrT+k2AVNYiSxJg9JOE/04mZ9GmpbU7ThV9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905024; c=relaxed/simple;
	bh=RubLfixlvKsXy/PlGb65YLvVVbhr3bonlUuWL2ZvK4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=YocooWhiw47C5583Hz3/ylQ/iYyriPUYJj21hvWp5V6kyWjlJoDfEWqpKqCk58dAB86IKws5QVjKyeW+XaIPAPVgKmKyHyU4NQAGbP2qfY00ciXq95WAmUmL944UhxXhduiepzz5sMd9pv9nMLNFenQNWq0sL1c2fcEt+i8bnGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4VG6n33vyYz5w26
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 08:56:55 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4VG6mt68tCzRnmP;
	Fri, 12 Apr 2024 08:56:46 +0200 (CEST)
Message-ID: <2f069d1f-aa4a-4259-9cc5-dcf912f59a17@kdbg.org>
Date: Fri, 12 Apr 2024 08:56:46 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Clones from local repositories do not work correctly under
 Windows
To: "L. E. Segovia" <amy@amyspark.me>
References: <44020a6a-707f-4505-adde-e79cda63d711@amyspark.me>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <44020a6a-707f-4505-adde-e79cda63d711@amyspark.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 11.04.24 um 19:03 schrieb L. E. Segovia:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> Under Windows 10 21H2, I cloned a Git repository off an existing local
> copy, then applied a patch to it using `git am`.

This is an imprecise description of what you did. I did my best to
follow these instructions, but could not reproduce the problem mentioned
below.

You should post the commands you have given with their output.

> 
> What did you expect to happen? (Expected behavior)
> 
> Operations on the repo like `git status` and `git log` should work out
> of the box.
> 
> What happened instead? (Actual behavior)
> 
> I keep getting this error:
> 
>> error: unable to normalize alternate object path:
> /c/Users/Amalia/.cache/cerbero-sources/librsvg-2.40.20/.git/objects

What is this .cache here?

-- Hannes

