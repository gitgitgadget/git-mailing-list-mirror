Received: from bsmtp3.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5265F1A3172
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781156263; cv=none; b=dyRdEAsBfhJLXzABwBofHEBiSQ9RFITt8X5mZzhi9Di6sGZIQRE8XNMTgyI21Jh6N1SZNp5VG0x2/Mx+vaU63biEqGrYyAGuq9El+DY4WTxR5Ab9VNKZc6j2dpLMqA1PiSyPKvJdl7xR1cGkrRmrKVxNbyNofmQa8BgC/OOzgKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781156263; c=relaxed/simple;
	bh=YJ7lTsMRshaL3Yzie5mFB4VNU+RqrlqwM+Yi7EcDIg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKC7sqgO+12tQGNjEZp7NOcOcnoPsXCghqbNwu/N9u6tvkgwRzFzWLBbwXvqZOQDTJwLuBEWkaiThP5ejSYPt1JOyAP4FW5ZYeW+hNWs4FWRTbZnhaoGKk19e8I9hjJOphQpF1ZbGC0RYCfRqHEfiPGll1XfMCgQC1jrN8au7Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4gbWcq6nvszRq2C;
	Thu, 11 Jun 2026 07:37:31 +0200 (CEST)
Message-ID: <fdf7f988-d345-4107-845f-e089d7829c16@kdbg.org>
Date: Thu, 11 Jun 2026 07:37:31 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] git-gui: silence install recipes under "make -s"
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2318.v3.git.git.1780555730228.gitgitgadget@gmail.com>
 <pull.2318.v4.git.git.1780742303298.gitgitgadget@gmail.com>
 <950f70ea-1615-402f-9cd4-3317bf177c5c@kdbg.org>
 <CAHwyqnUpiWmXo0SVr=7L-+cwA+qhVyqodpV-O4C46w=kLqaLMg@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAHwyqnUpiWmXo0SVr=7L-+cwA+qhVyqodpV-O4C46w=kLqaLMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 10.06.26 um 15:19 schrieb Harald Nordgren:
> What does it mean for it to be queued here, should I expect it to show
> up on seen or next?
It means that I'll arrange that it will appear in the next Git release.
Until then you can find the commit in
https://github.com/j6t/git-gui/tree/hn/silence-make-s .

-- Hannes

