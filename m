Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6271DFCB
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757797456; cv=none; b=LE8UIwLoU2oEJdmGr/wWmBigaycpnWOglUhGkM/RbUsSTvS4N/KpvjcW69VbhrQC/HvHGEA852AWvkzK0hw0zf9Vk3ODHGqVr2EDBDxTAfJEcGH/S+aJU7NyMyz0oTjzZJ2wN8wPRhQxoxXM9hNvQSTZD8uTkuf9HRdcuqnQuTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757797456; c=relaxed/simple;
	bh=sa6z9E6V7ciZQl9tWv1mjzfwz+mtT7HCM5MnxGU04Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ugL2ibkZfkq/ApkeuuLhp8nCImgsbOdSvZvrn306l1+xvlFjuy4V3+BxpCbGuFERW11kHx/r8gtIHsgAHhRYpgHmTB3pllI5EDjF7S3S6esISV+KCoLGQM8rUNJRlUM/Ickh3VnKypqd6RA2aAlJ7DQqDom6nR+3UWYeinrH8jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4cPP114l4Vz7QY4x
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 23:04:05 +0200 (CEST)
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4cPP0s0nkZzRpKk;
	Sat, 13 Sep 2025 23:03:56 +0200 (CEST)
Message-ID: <9a03a436-8240-4566-9383-7afbf740719e@kdbg.org>
Date: Sat, 13 Sep 2025 23:03:56 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] mergetool environment variables
Content-Language: en-US
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
References: <074901dc2422$2039a910$60acfb30$@nexbridge.com>
 <a5e01f0f-1789-427c-83c3-90644fa234c9@kdbg.org>
 <000201dc24bc$a1b8d9d0$e52a8d70$@nexbridge.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <000201dc24bc$a1b8d9d0$e52a8d70$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 13.09.25 um 16:42 schrieb rsbecker@nexbridge.com:
> Let me try to infer what is happening and please correct me if my assumptions
> are wrong:
I'm sorry to say that I can't help. I tried to disentangle what is going
on, but this stuff is far too convoluted to be understood in a few
minutes. I cannot tell if it is possible to write a mergetool that is
not installed with Git.

I would just copy one of the existing tool scripts and run `make
install` from the Git source directory.

-- Hannes

