Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A0526E718
	for <git@vger.kernel.org>; Sat,  6 Jun 2026 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780746473; cv=none; b=BbNvov8SyBpui8PsjrSSVqkF+towyB6JHvwN4a35a7Q3kLRgfYocZBolhX0ZI4YzHHHdDeaijFPY3g8gWHdsIlj9hZsYKfKi1PC//sBjnoQFIoHs5JasrISv2v2Lk+rrYDVLdURgDaWusqkCkASq4U0X8m/kN/XXsrrGYKeY1C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780746473; c=relaxed/simple;
	bh=B8qrCatHnOJAy3DHmR7sEH1a7C1pd3uVOwYMiHjMkXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgd3FMJFI6aafEFndEpQkxtYGGRaDFtVAQEsnwcF5zy9/9s9XcSBeqJeYmaddAMXpBSnBfOqcr6YfI2PQYNOU2SnYgcR6TfrHYYbrQGC293WUvb40OZez376jpj6weF2AIUhv/U8NK1z3JEG3Vl7TTcUvcyCrus+sMEbMcx3bD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4gXc4G5vfjzRnlX;
	Sat,  6 Jun 2026 13:47:42 +0200 (CEST)
Message-ID: <950f70ea-1615-402f-9cd4-3317bf177c5c@kdbg.org>
Date: Sat, 6 Jun 2026 13:47:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] git-gui: silence install recipes under "make -s"
Content-Language: en-US
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2318.v3.git.git.1780555730228.gitgitgadget@gmail.com>
 <pull.2318.v4.git.git.1780742303298.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2318.v4.git.git.1780742303298.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks, queued.

-- Hannes

