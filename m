Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AFD7260A
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769791687; cv=none; b=Mzc48951S+EJ1bsCy9BNd4jTzS/q3tmrBeplrbOqcRBMIUBHWZRQMayu1FPVsYNxWWu5k+lg+DOAMJuw5dlLnR9cUranrQ79Rg0Mmx3zgHc69t9sMEUpq/2PfwTRndylt3O7/3I4U3zO5dKMa1Q4kvCOrlRp1xxPdo8owOZ4TWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769791687; c=relaxed/simple;
	bh=ttk4leeztg1WMs3MzTpmoCxv7evWWQIiNusRTKNCqJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=MrURxw+Mjvc+6w7pZZTdws+rDj1Zu/jYCbo3eB7iEPTNoII58dQ+15oyurDDdGyM1z2inJ9X46C+opuqztnRHVZ7bqCe0oI8lW3o0ppujkoqT9D8Elzq8bYr6yObxdolOYOiqCHq5jG6AZrk6PiwZM/aPyqGVYlDmu12qHWdwWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4f2hlJ1NklzRpKn;
	Fri, 30 Jan 2026 17:47:56 +0100 (CET)
Message-ID: <dddbb702-5f2b-4c4a-b649-1187273a9854@kdbg.org>
Date: Fri, 30 Jan 2026 17:47:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] t/perf/p3400: speed up setup using fast-import
Content-Language: en-US
To: Tian Yuchen <a3205153416@gmail.com>
References: <20260126165618.596944-1-a3205153416@gmail.com>
 <20260128160717.611391-1-a3205153416@gmail.com>
 <04005f67-3ec5-4fa7-9fd7-37ef9034286a@kdbg.org> <xmqqcy2r83rx.fsf@gitster.g>
 <b6f12614-ecc1-4d37-ac4c-070925054f28@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <b6f12614-ecc1-4d37-ac4c-070925054f28@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 30.01.26 um 17:39 schrieb Tian Yuchen:
> I will send V4 shortly.
In this case, please also undo the unnecessary removal of a blank line
at the end of the patch.

-- Hannes

