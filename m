Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3643EC822
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496147; cv=none; b=CImCrzCRZuTOlXHqw1AXqu6wfqVQroqp1TUDF0pv3ae07/ZZh5BQhaF6GfKIxiDHk1tbnngLuDxJjmXzKa9T1jbK+/V6Zl11Hvy/ZWRv6eNZwk3w9QzsbnQjObprCzUR7RLm6scn2+ZmM5U2Amwd9WLgPMC8sP7KeRKixjirBpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496147; c=relaxed/simple;
	bh=GbgJQkXSVIfi+QUt6aDFYWWxpBWZD2L+Iyy4mZXbLpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=QowYH+By4NEIV7wBwjMtYheT7xHaKvEpb7VbfpL5wsjroKwBZ0qJvthGBzmcnC0ZKnJ0o8e5FW0x9gLyAARLs2AXwvJe43E2Ahmu17QoAMQxX94wTj4LBeGYXlqwl/zyNcvTTZlKQrBEjBKy5fMgmBDcDuulSb3vFybcClcxuto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (213-225-9-246.nat.highway.a1.net [213.225.9.246])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4hBNc44FPNzRpKv;
	Fri, 31 Jul 2026 13:08:52 +0200 (CEST)
Message-ID: <d5ec69c8-e441-4134-a6bb-665fc06db187@kdbg.org>
Date: Fri, 31 Jul 2026 13:08:49 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git trailing blank lines feature configuration
To: Thomas Nemeth <tnemeth@free.fr>
References: <6022080.DvuYhMxLoT@cixi>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <6022080.DvuYhMxLoT@cixi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 31.07.26 um 12:19 schrieb Thomas Nemeth:
>     I have the habit to keep 1 blank line at the end of my files. To me,
>     it eases the EOF modifications (selecting code blocks, pasting them)
>     in vim.

(Call this is [x].)

>     Would it be possible to have a configuration option to avoid warnings
>     (because I see that as a warning) about trailing blank lines ?
Hearing the first time that an extra blank line at EOF is necessary or
useful. Would the correct question then perhaps be: how do you all
handle [x] without an extra blank line at EOF?

That said, are you looking to disable blank-at-eof from core.whitespace?
Collect all "enabled by default" except this one from [*].

[*]
https://git-scm.com/docs/git-config#Documentation/git-config.txt-corewhitespace

-- Hannes

