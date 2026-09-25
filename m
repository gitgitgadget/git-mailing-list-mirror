Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADE646D0B1
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324278; cv=none; b=WUJok1HnvPlqF026DO0CpTka0vsi10UyyZJPjFNyl4sJ9wG8wa534GJK2GJ4tMnQ3Vi6vk6CmfCsCo/4xOpx7xKlZtGBVBxavfnG4J8oU25TZ90AmBBa3z5TmLig0si8YiBbzMDbzHA45xHcdTFHQSmFwM6h+xJ8CYNw06B0eP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324278; c=relaxed/simple;
	bh=utKvVato7LAxkrphlCW10zIQFukLdIY/QYX8LtEsxT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0HYRvxXL/a1JQ8gX7zzBYKSa/HioHeDX2zwlFg8asGP/HinpAMjctaPN9rPI0OZZ8r+urJ3OeyIHwJQ9JVGhASjEg6pUYNbzOmpEcvP2UK5onVvtXsFTm4POmiJVXrJZJ5BVGujmdbXkAk93KYSiso1M0jtEzRNnxamP+9bNdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4hrk8t6YRpzRnlV;
	Fri, 25 Sep 2026 10:17:50 +0200 (CEST)
Message-ID: <b4e8375a-742d-4ba0-9413-f5503e2c6b7e@kdbg.org>
Date: Fri, 25 Sep 2026 10:17:50 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] git-gui: add Afrikaans translation
To: =?UTF-8?Q?St=C3=A9fan_Driaan_Turvey?= <stefanturvey1912@gmail.com>
Cc: git@vger.kernel.org,
 =?UTF-8?Q?St=C3=A9fan_Driaan_Turvey_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
References: <pull.2238.git.1790229073946.gitgitgadget@gmail.com>
 <pull.2238.v2.git.1790257167561.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2238.v2.git.1790257167561.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 24.09.26 um 15:39 schrieb Stéfan Driaan Turvey via GitGitGadget:
> Range-diff vs v1:
> 
>  1:  ce1f406d4b ! 1:  3015e1802e git-gui: add Afrikaans translation
>      @@ Commit message
>       
>           Add an Afrikaans translation of git-gui.
>       
>      +    Register the language in po/meson.build and omit source
>      +    locations in po/af.po.
>      +
>           Signed-off-by: Stéfan Driaan Turvey <stefanturvey1912@gmail.com>
Queued, but without this new sentence in the commit message, where it is
just confusing. It would have been suitable for a "changes since v1" note.

Thanks,
-- Hannes

