Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.33.87.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094937;
	b=BLxhGsBfcpsUmD9HWPQ1gEFZ5tbkxeWIolSoUOsHm1+h0QZth0bP4a39dR2emdLN9uR5
	 COWG6KfiAk+sVjQTbVqTdMOy9s+kZZOFCkIz/h/tlxwV6UZL7tdeErlcRfjF2tGhsVhvd
	 ewVDNWRuV5PVtnOW7IaoMsWGBRcmOpUzQTFvGOMjce1afyVe6d2X+JmqBRhv9ZsZYM378
	 6xTBjGIa/HYAiAj+h0TzNZt2oheIMuGV2VfWNYm8ZaqKplFPwwayJl46/srT2/CyvqDgn
	 jE8DkSOpJeBQlitt08UJfd6cPs3D+oenReVG2S30F7vRwny0j1h825iUMSQ01NaLMSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094937;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=l4o8QQPDnoDbluxWDcqvBZ/0lxQBMRz1gk3Y8GrSHWs=;
	b=zElzy13+C2KYJPH+BmcY68r+MblZaTz8YJCB31MIZRDeXIqdXUXZclC8YSqeO1jLRjhR
	 tjikNYvzbdlAj5apXt+dkjQ3gTXE/y06e+TeukAE9YrJm0c1qpKyYBwtoe1MjaIx0G4ND
	 R30dz2ADZ6OzkMH5vc979FXPASJgAQX93hyiMnaV60u4kPqQqhhztaJKIhUdafUcUAh0M
	 5OPwbEB3iuWQAL0Clfl8KNlfJhKSMgAyh7YuLf2nm2syAnbOck58hlKUtjGhTeahZ1/Bw
	 ETkh1TWNpTaeDGQ36GfnOKw/BmGq1oI718MY2zLLMZ6j5hEMqeOpqYQJzq5vb0Cf51Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kdbg.org;
	spf=pass smtp.mailfrom=kdbg.org;
	arc=none smtp.remote-ip=213.33.87.16
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E52F606A327
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 09:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E52F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.102] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4jDQpk5nMCzRnln;
	Tue, 27 Oct 2026 10:55:26 +0100 (CET)
Message-ID: <004525db-3029-4e99-b93c-ff7ff24e3b4a@kdbg.org>
Date: Tue, 27 Oct 2026 10:55:26 +0100
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
Subject: Re: gitk: add cherry-pick with cross-reference action
To: Ralf Habacker <ralf.habacker@freenet.de>, git@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Taylor Blau <me@ttaylorr.com>
References: <57d4f046-26fc-4dd3-8a90-4132c5941ca4@freenet.de>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <57d4f046-26fc-4dd3-8a90-4132c5941ca4@freenet.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 26.10.26 um 19:42 schrieb Ralf Habacker:
> Add a context-menu action to cherry-pick a commit with a reference to
> the original commit in the commit message.
> 
> This commit closes a gap in gitk’s GUI workflow for projects that
> for example require backported commits to remain traceable to their
> originals.

The patch text is looking good. I picked up the patch and pushed it out
as branch rh/cherry-pick-x to https://github.com/j6t/gitk for others to
consume. But, as I said, I would like to hear more voices that this is a
good thing to include.

-- Hannes

