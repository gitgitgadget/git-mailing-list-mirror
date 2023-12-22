Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEEC185D
	for <git@vger.kernel.org>; Fri, 22 Dec 2023 01:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="aNwcR5If"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1703208601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JiiDmL5zEJOyqLdIf9jjzQsycJgiAW2gY9fIKrosJ38=;
	b=aNwcR5IfPbjQuttLtgMeDYpKpwtJQnWh6wEcoeJF7wzKr8n6XP8qYPpNs9klVRxgXCIq26
	41Qe1yPk9EUSEML/DTDFwWhdtlFospyXaYT2UrwJWRts8bgHoJRGdryVwJrz0tzqHFHc9O
	Lz+Vkooh3AnEW3Eu9UaCl8OWLUxheHYJfjhwjYj8zWBSZv+JswEDKIusIpN2JzZZHPMXZD
	ZPaMYuiV7HGwBGPryxqEly5YloVZaXfsPgXob6QU5WJ++oDVZC6Yijsjuv00brr8Ecoz+/
	SZQtGzWCJkVSFEQ+TXkab9U35EpGqrcCFZk+SwOxfZgTZiXa1ygbqahUxBcV0Q==
Date: Fri, 22 Dec 2023 02:30:01 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Soref via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>, =?UTF-8?Q?Ren?=
 =?UTF-8?Q?=C3=A9_Scharfe?= <l.s.r@web.de>, Phillip Wood
 <phillip.wood123@gmail.com>, Josh Soref <jsoref@gmail.com>
Subject: Re: [PATCH v2 1/9] CodingGuidelines: move period inside parentheses
In-Reply-To: <xmqqedffl13r.fsf@gitster.g>
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
 <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
 <b9a8eb6aa4e87cd96fbf2b5d514350508076d756.1703176866.git.gitgitgadget@gmail.com>
 <xmqqedffl13r.fsf@gitster.g>
Message-ID: <b3b03da0e33b805f1f420a0dc1a19d86@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-12-21 22:03, Junio C Hamano wrote:
> "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Josh Soref <jsoref@gmail.com>
>> 
>> The contents within parenthesis should be omittable without resulting
>> in broken text.
>> 
>> Eliding the parenthesis left a period to end a run without any 
>> content.
> 
> Nobody seems to have commented on this one in the previous round,
> but quite honestly, for this particular instance, I suspect that it
> may become easier to read if we just lost these parentheses, as the
> next sentence "You do not have to include more than ..." is just a
> bit of extra material to support the first sentence like the one we
> see in the parentheses.  Alternatively, moving that "You do not have
> to" also inside the same parentheses might work slightly better.

I agree with simply erasing the parentheses, it makes the paragraph flow 
much better.

> It might be even easier to follow if we moved the list of "approved
> headers" (and the "You do not have to ... more than one" note that
> supports the "currently approved list") totally out of line by
> making it a side note.
> 
>> Signed-off-by: Josh Soref <jsoref@gmail.com>
>> ---
>>  Documentation/CodingGuidelines | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/CodingGuidelines 
>> b/Documentation/CodingGuidelines
>> index 8ed517a5ca0..af94ed3a75d 100644
>> --- a/Documentation/CodingGuidelines
>> +++ b/Documentation/CodingGuidelines
>> @@ -450,7 +450,7 @@ For C programs:
>>     one of the approved headers that includes it first for you.  (The
>>     approved headers currently include "builtin.h",
>>     "t/helper/test-tool.h", "xdiff/xinclude.h", or
>> -   "reftable/system.h").  You do not have to include more than one of
>> +   "reftable/system.h".)  You do not have to include more than one of
>>     these.
>> 
>>   - A C file must directly include the header files that declare the
