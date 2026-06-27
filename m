Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C3337C91A
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782552901; cv=none; b=MNDUV6u+2xexw+xKxbg0ZsjELIxlmgvrhm2V/iJcVzO06zJ+niQglnE0/DkXvDQ+6WbZ+WLjRUAWWxMQJgb8ymfhDXryW1s3DFORJX7srB33+DR1tnM4+2A7NBuYPKZEN33yw0VWvmzzJ5yEsGEFoGoDY4CTLkTUF9JWOVO1V2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782552901; c=relaxed/simple;
	bh=TLRMLh1mhhC1FwEKoMUnvPEWhVMzZ6cuL5viPNH/MJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PK5155S3wUsb+V4HFNoF6YuUjVViGFECMMHQfqN1kUj78S30JkODMIYY5LGZU58lF8lnyqqxFjJeMXk3vCV09/1CRbyFgziHyuenuzCG6JcooUYWDEPS1KnK7dUcqUFjQnB/8ClsG2o1jmdTngvUXuX/k8YXPrh8c3JqXQayGIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4gnS7H1FnxzRnlY;
	Sat, 27 Jun 2026 11:34:50 +0200 (CEST)
Message-ID: <40b7eee4-6b45-449f-a3a0-0ae415097041@kdbg.org>
Date: Sat, 27 Jun 2026 11:34:50 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Silence po catalog output under "make -s"
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2339.v2.git.git.1781995570677.gitgitgadget@gmail.com>
 <pull.2339.v3.git.git.1782053803.gitgitgadget@gmail.com>
 <d38d233c-a7c9-4457-96c1-bfb75af71ffe@kdbg.org>
 <CAHwyqnX78ePVhiL+_T3FzCSA5oGaU_RPvQj6YP=s1WyULg=tdg@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAHwyqnX78ePVhiL+_T3FzCSA5oGaU_RPvQj6YP=s1WyULg=tdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 26.06.26 um 21:27 schrieb Harald Nordgren:
> What should I expect here, will it be merged to master now?

These patches are cooking in my respective j6t-testing branches in my
repositories[1][2]. I'll ask for inclusion in the Git repository in the
coming weeks (but certainly not for v2.55).

-- Hannes

[1] https://github.com/j6t/git-gui/commits/j6t-testing/
[2] https://github.com/j6t/gitk/commits/j6t-testing/

