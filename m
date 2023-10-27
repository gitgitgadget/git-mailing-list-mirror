Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864F7374E2
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crinan.ddns.net header.i=@crinan.ddns.net header.b="aOagR2Kn"
Received: from crinan.ddns.net (unknown [90.242.223.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93788C4
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 07:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crinan.ddns.net;
	s=september; t=1698417169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nriJmF+OwgzPnX2K4znpt4vOKDLvzannmu6TLfvIRBo=;
	b=aOagR2Kn4+4psRhPF4QnRkmjXsI+UysbyBZQvaHChLjnHiMWbWyqeErwH7b6xOVYDU1ld2
	BoG2B16wLxCcPeze2NgPSD3istmesDaY7LI4Q3Q0aTvkqKFZUDmZMiAr2jKnQh7JwN9DV1
	vsYWxEuMjH/rAkWwBrckAkLkFxS0CCyQAwF2SYnvBFhr/XTXjQkyr9CZkk201MJRO7QXq2
	K3DFVvJcXEN7qhlJQE/dkxWIXVHvoVJ9KP3iL478gsK2blWeYHE8oii17JoJ/hK7LMf5SO
	QQdIw7crpbF7Vh+0rShh8F94ILNsYPFH7Fi5h2gYATnROEpj21qjGIyPNF6New==
Received: from [192.168.1.212] (<unknown> [192.168.1.212])
	by crinan.ddns.net (OpenSMTPD) with ESMTPSA id 9dc86940 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Oct 2023 14:32:49 +0000 (UTC)
Message-ID: <b6ef74b7-2c77-4621-9969-d911c34561d5@crinan.ddns.net>
Date: Fri, 27 Oct 2023 15:32:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ci: add support for GitLab CI
Content-Language: en-US
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1698305961.git.ps@pks.im>
 <35b07e5378d960b93ae8990a3abb525e1762d97d.1698305961.git.ps@pks.im>
 <ZTosPCkpx/FMTDH5@ugly> <ZTtyHScKkMg4qnMH@tanuki>
 <d62b2e38-6e24-4661-b51d-2ecc59eae256@crinan.ddns.net>
 <ZTuUa5bA8dh29cyv@ugly>
From: Phillip Wood <phil@crinan.ddns.net>
In-Reply-To: <ZTuUa5bA8dh29cyv@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: **

On 27/10/2023 11:43, Oswald Buddenhagen wrote:
> On Fri, Oct 27, 2023 at 11:22:35AM +0100, Phillip Wood wrote:
>> On 27/10/2023 09:17, Patrick Steinhardt wrote:
>>>>> +    CI_BRANCH="$CI_COMMIT_REF_NAME"
>>>>> +    CI_COMMIT="$CI_COMMIT_SHA"
>>>>>
>>>> assignments need no quoting to prevent word splitting.
>>>> repeats below.
>>>>
>>>>> +    case "$CI_JOB_IMAGE" in
>>>>>
>>>> ... as does the selector in case statements.
>>>
>>> True, but I'm simply matching the coding style in this script.
>>
>> I think it is quite common for us to quote variables when it isn't 
>> strictly necessary as it makes it clear to anyone reading the script 
>> that there is no word splitting going on
> 
>> and ensures that we don't start splitting the variable if the contents 
>> changes in the future.
>>
> the point was that it *isn't* content-dependent; it's simply the shell 
> rules.

Oh, I'd misunderstood what you were saying which was that assignment and 
case statements are not subject to field splitting.

> of course, many people (apparently you included) don't know these 
> subtleties

I find this comment to be condescending, needlessly antagonistic and 
completely at odds with the norms of constructive discussion on this list.

Best Wishes

Phillip
