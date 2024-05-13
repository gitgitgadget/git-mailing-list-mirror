Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2633E1DA24
	for <git@vger.kernel.org>; Mon, 13 May 2024 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715634095; cv=none; b=RgAMtXd8tRZ1fsjbm7ISMjeuY1JqBtQZShHGdKlrRJObLfZgdwbhNn0nunZU35qczGwWOLA8r1XasGkGu1S/qzDmV2D2bbqVQkLZ+ka2VgQJJhoduPHU2JpUs6acRIOj+fVl3m2DQlU7DJd7tf+pkWhBfHw9K7YUW5TWpduw8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715634095; c=relaxed/simple;
	bh=sMnUIJpTmpK2yKCxNSEZ0GgktltcbMarwurUPEZ8Jn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjAfP/e5T9WYv9rfpXVftRfafM8kKwa2ZzmB0tFtFHraYjT/popjBGyDoT9Bqqx4FNgh7t4djCRGjRt8imhlmQahNHlvLE6UjlvQfPiQTLqNhEU8MHKhqD5DUntu9cv+OKIyzyFJJ8ToXgdnfxy+vzwaHh2/oqEVMrM0VJUXUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4VdX396LyCzRnmN;
	Mon, 13 May 2024 23:01:25 +0200 (CEST)
Message-ID: <6d7ac19b-fede-4534-aee2-5c0cb20f955e@kdbg.org>
Date: Mon, 13 May 2024 23:01:25 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug in git log -S
Content-Language: en-US
To: Sam Clymer <clymersam@gmail.com>
Cc: git@vger.kernel.org
References: <ED9E5AD9-D15D-4E63-AF80-209EAAEBAD5C@gmail.com>
 <8bfa50e3-996a-407b-9c02-a9fcacfebc4f@kdbg.org>
 <8B9537F6-A76A-4CF8-9EE4-2CC3C98D5784@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <8B9537F6-A76A-4CF8-9EE4-2CC3C98D5784@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 13.05.24 um 20:58 schrieb Sam Clymer:
> There does seem to be a bug on my end. I am searching for
> “net8.0-windows” and it’s not finding an instance where it’s added.
> It is not a line of code that is moved around it is purely added so I
> think there is indeed something wrong with git log -S.

You would have to show more evidence for a bug before anything can
happen. Start with showing the commands typed and their output, ideally
you point at a commit history that shows the problem, etc. Otherwise, we
can only say: "it works here".

-- Hannes

