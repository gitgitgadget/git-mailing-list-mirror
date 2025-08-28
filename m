Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D643219DF62
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756403652; cv=none; b=MNOaYz7KPjzu003e5EoQY8CWvqq80hw/At/p37SB0h0B9WrE8y0gTdUhMvf6UpE6Ebt39/xJ75x6w1mfriw92qiS6DcFLX3G/fYGODf+1+e7z4IQlvlOsjOufUQYg/+VMsg679IYHeuU6FCEP+J7a1/FEfFlD7yD0bs4ZsO4w3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756403652; c=relaxed/simple;
	bh=mySz1fXKvXEQKOfQI4JVL8cC/v3i538pWs863Li2u9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=qrgVEQhJVv4CmfprejgSTLeFs1KsmGfRWKp0Kn0bHAAYrjGZ78j8geslDB9XdDi+AAyOCDls8hPjyMMUM84PeGDnM1O+t3dv+rGVOSf3LgJIlby7cebSKR/er2YplhicUOPHpicObxkpErc1zSsr0ToIy7Cf7ziQnW3ctOB/0+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4cCTY60DMLzRmx3;
	Thu, 28 Aug 2025 19:54:01 +0200 (CEST)
Message-ID: <86240b73-c775-4d4d-8904-30e8b536e5be@kdbg.org>
Date: Thu, 28 Aug 2025 19:54:01 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] gitk: add README with usage, build, and contribution
 details
Content-Language: en-US
To: Michael Rappazzo <rappazzo@gmail.com>
References: <20250827231417.12449-1-rappazzo@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <20250827231417.12449-1-rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks, queued after fixing up this glitch:

> \ No newline at end of file

