Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5222517D341
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731483572; cv=none; b=LcdNIunAcOB4+QPh5yJ/IyLBLycbxoz+A6PEmbCKvlMJB28+FnMYQM6rFArilTrPnMpUaZTF8NTezzgB147UiTWEumY58S9cowZasJwogpzgl/j2Gdi2SDtg8f5reMuY5r8sLbT1iGzoGEeAslIDabzTO9zC0TkAZZyp0NSQbw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731483572; c=relaxed/simple;
	bh=qs650u/VJsU76EWvqy9J0+s4NNx+LEUibXoQlKu/DuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArkHNui7A/vhoZhOgeASfM6m0G24oap58EJQbw3tmhPl70Ctw3pa2rlj27ZlOUX/jDPIGy2fpWGZzvaSMfyEpww7MTuwyfhpzO/0YeoYxc9HAKKAt9ADcPMSU27Uo+Sdg5eF/x4SqKMHK/yjFze7ccrkuuk99gXpwSRUuwJaUJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4XpFXq5f7kzRq1T;
	Wed, 13 Nov 2024 08:39:22 +0100 (CET)
Message-ID: <277d6532-fbf8-4015-979e-40bb58702b57@kdbg.org>
Date: Wed, 13 Nov 2024 08:39:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] doc: git-diff: apply format changes to diff-format
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
 Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
 <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
 <8fec37ee17481039998af65ce1abec753cf30897.1731343985.git.gitgitgadget@gmail.com>
 <6c1c1ae2-f38a-4458-a9ad-2fad3e56fc32@kdbg.org> <xmqq8qto3vhy.fsf@gitster.g>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqq8qto3vhy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 13.11.24 um 00:03 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>> Now that the backtick formats the content as in the synopsis, why is it
>> written _<tree-ish>_ and not `<tree-ish>` in the running text?
> 
> Perhaps that is because the body text does want to show the
> placeholder in _italics_ but not as a `literal` string?

OK, I can agree with that.

-- Hannes

