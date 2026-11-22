Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.33.87.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795336422;
	b=xJNWNneVKeRBtBoXBpMRACFQXssNjdzcEQ/eZkoIOgzn9rtjojptAS+jcfxS3LD/P7kR
	 fBLf1MMiMua35MROK1RYGo+bhQN1xYxQ8ttVq62ofiEIvYK1qLGcGqYOrzs4NXsvkLeRS
	 /xjAERcQ7oGV5RPcYnlqdOvGMf7I2/Bl+CbYDcNxIMvBZ9gLBQ8QjNyK1CUp0M5HJmggE
	 57EFYNTUpEl8jyvuJrfqWPfbkG4PZ6/1TFJ+2hTVbmkN/76wzdJRreBeMXYobFnnxDD27
	 ad/RJ7sB2fRi4ZcnADZ1cTzmRLu+1Qjlh30hS12+dYdRAAsS+wVkDXUtEDue0cwOxNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795336422;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Sth6wa9MZoQTEj1b1BpPT+jSCLcCPvmbUKwgbT1CulI=;
	b=tyJfEBEniAnQQSjZkmwI+gP6iGwyowwU1CACupqWT+DzwamximfCZy2GUmSsJmdrkin+
	 UINftjeqyhMA8QURbs9BUSIRZOOkPW4S/Z/Ihmdu7m6LwrkJj/hABZF+8aXxc8Xdt5h0q
	 Q6VAoOI/55XPF0rdu8yYMwlOkudSE320L+fyZ8FoheMeVd3Q6+beDcAGHEY43sIYro2OY
	 HKDOV4KqLSs3bSLNzRLIm8C1q4osXMZXm9fJVOWNVioe9fuzD39LAhMj1iGy1CzwMPp3v
	 gCw8zH28VumR9ah1OQUIzXL6PSdjOQpyoAmGTvs45kEFifoDxvMgDfpyXsVKb0GQoyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kdbg.org;
	spf=pass smtp.mailfrom=kdbg.org;
	arc=none smtp.remote-ip=213.33.87.15
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3101606A320
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 08:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3101606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4jXMmD2wkXzRnlV;
	Sun, 22 Nov 2026 09:33:32 +0100 (CET)
Message-ID: <a40ef0d6-0451-48fb-8d41-fb3c83c4e753@kdbg.org>
Date: Sun, 22 Nov 2026 09:33:32 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git-gui: fix typo in comment
To: Ophir Bleicher <ophirble@gmail.com>
Cc: git@vger.kernel.org,
 Ophir Bleicher via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2498.git.git.1795278449118.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2498.git.git.1795278449118.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 21.11.26 um 17:27 schrieb Ophir Bleicher via GitGitGadget:
> -	# Keep only the first occurence of any duplicates.
> +	# Keep only the first occurance of any duplicates.

My dictionary doesn't know "occurance". But it does know "occurrence".

-- Hannes

