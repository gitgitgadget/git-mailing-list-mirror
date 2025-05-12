Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2282550CA
	for <git@vger.kernel.org>; Mon, 12 May 2025 05:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747026059; cv=none; b=DxWzaO390xBeYAmxxol8cUatYCQ0l/lD99Dl6HccvjFY6COiNMceeba7VQSOa9pPxfN4OWp5nGNP+/WqJysxQbrFOW184qUbTgTkyZy9LXgOp44kTNPc5uARPpPEFeRscAvAOJnxaY59nnb3qhy3jR+G5nB6dPWEGuC79h27jgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747026059; c=relaxed/simple;
	bh=l1nBRizo2t4SgZoIU/Ghy+47Ls/YFeqdVPKZ+AcKw8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=oJ7wAm2RpyM0MGdfKtxEsLoMu+8BViU/xAbQJBq8ZOBT3ODmW2Ho3SdvVRxqdmU6KZOKqDNbdvSn4NY7vSH+KH76H32StTy0+uV1XHv0qBTQT0/AeIPDmnh03RKLUOCH7Oj/9ZSXrW8yd4QgX/M/gyNcyHCBM08dKRPpmd2t09I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4ZwnVg3mP1zRq1V;
	Mon, 12 May 2025 07:00:43 +0200 (CEST)
Message-ID: <0e17af72-f9a9-454c-9cab-7992d78b95a0@kdbg.org>
Date: Mon, 12 May 2025 07:00:43 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Tamil translation pull request
To: =?UTF-8?B?4K6k4K6u4K6/4K604K+N4K6o4K+H4K6w4K6u4K+NIOCukA==?=
 <anishprabu.t@gmail.com>
References: <CANc+upRgde4sSzMtkss9jNVmBHSRsEegs5up8QmL768UXp__Vw@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <CANc+upRgde4sSzMtkss9jNVmBHSRsEegs5up8QmL768UXp__Vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 11.05.25 um 18:17 schrieb தமிழ்நேரம் ஐ:
> Hi team,
>                  I have created a Tamil translation pull request on
> the gui-gui repository.
> https://github.com/prati0100/git-gui/pull/114
> Then I realized that the workflow is not via PR. So I am attaching the
> file here with this email.  Please do what is required.

We need a commit that is signed off, not just a file. You can submit a
PR to https://github.com/j6t/git-gui.

-- Hannes

