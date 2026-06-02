Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7733126C2
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434522; cv=none; b=FEYepE86jmra79ZDSjmLQUINCIox062Et2PXpYMp60L8+npZIuBitCMVYmqkct0HWMHGdOw3M0r9oe/pZjyKFy+IXp7LCTkwPHVkTwGcfJ9CoytkphNOv0/4bdOkapIiigXhnq+pwGIfzaXTwgQJiMSW0f/+B4STmaPmtrY5MGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434522; c=relaxed/simple;
	bh=+J5ixQ7JVe6CnjoQoeM+/fzPCYpx1xrjRnMvltvI6CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PatNY+jP06bgOp5qu2oDB/jYuOXP/9g9TR6zJYnV1ctk0jpQ5Em3jkPQYRrygIACBCbXSojrHljiKv8/vZOj25021cbgHoi7TCR1LCOkyDOqtDZL6hTArQ4+ZekVrVqJ1EOt3Yi8poRUwNNmSzGwOtBsH5L2HQKb0ZEGHy8olPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4gVNf36JVWz7T6Bm
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 23:05:47 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4gVNds5VP7zRnmG;
	Tue,  2 Jun 2026 23:05:37 +0200 (CEST)
Message-ID: <9889a979-dfb9-4818-ad11-c4e82a8aacd6@kdbg.org>
Date: Tue, 2 Jun 2026 23:05:37 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] Improve git gui operation without a worktree
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260531230225.126817-1-mlevedahl@gmail.com>
 <8515a482-9a08-4b0a-bd7c-385e1bda1a20@kdbg.org>
 <6f4276f9-cf0e-4840-88ce-9e0009c669a9@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <6f4276f9-cf0e-4840-88ce-9e0009c669a9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 02.06.26 um 20:54 schrieb Mark Levedahl:
> You have duplicate signoffs on 02/12 in your repo.
That's intentional. The patch went from my hands to yours, then back to
mine.

-- Hannes

