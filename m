Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BF71A260
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 06:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732604165; cv=none; b=VWe3trVXVeJtyjUPb/+HA6CcrSiHLnSTvNsXsXpDd2QHLxiQVwMpwRSCH4qpHQ3YUoB64zgBpeMh74uPOmxejoyI6G6sZTtZF1tbCkZKxhDdmlh7emqNP8MN0BWM8q+Axu5n1CvmcfUJMUOYkWzrnPm0rM2Z9tBErWFqtXO/QUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732604165; c=relaxed/simple;
	bh=2qWOrYOcw8I9QUFLpdTdEkfUcJ/bj8NdUoCzB0bZ5+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+qquZZOtkAyCPskgbhfaRYMS6FHPe05wU9noDeOubw7qwfrxMlTytlqWE+a4joXhTB3xLvDo9pnk5872iR+/uDjV3IH2Eb1Rfl2RDWcm4JIcIOIS2SwBYs/GpFtRszWwfX8DQD3Flk2HStxwBYCSpLmE8PhdPRhx+3/QsBmqZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4XyCyb1sCYzRpKt;
	Tue, 26 Nov 2024 07:55:49 +0100 (CET)
Message-ID: <96157f25-655d-4d3e-ba56-d76a8f12ced7@kdbg.org>
Date: Tue, 26 Nov 2024 07:55:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] doc: git diff reformatting
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
References: <pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
 <pull.1769.v4.git.1731967553.gitgitgadget@gmail.com>
 <xmqqv7wa1up7.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqv7wa1up7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 26.11.24 um 05:32 schrieb Junio C Hamano:
> "Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This is the continuation of the editing of the manpages to reflect the new
>> formatting rules.
>>
>> Changes since V3:
>>
>>  * rework the description about -1, --base,...
>>
> 
> This latest round did not see any feedback, but I re-read the
> changes again, and did not find anything suspicious.  So unless
> there are things I missed that others point out quickly, let's
> merge this down to 'next'.

Yes, this round looks good to me, too.

My comment about dashed vs. non-dashed commands in 3/5 hasn't been
addressed, but this is OK since such a change is outside the topic of
this series.

-- Hannes

