From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] CodingGuidelines: typofix
Date: Thu, 01 May 2014 10:51:19 -0700
Message-ID: <xmqqoazhcrqg.fsf@gitster.dls.corp.google.com>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
	<1398894312-30763-2-git-send-email-gitster@pobox.com>
	<87tx99zj31.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu May 01 19:51:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfv8q-0001QY-VZ
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 19:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbaEARvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 13:51:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64585 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbaEARvY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 13:51:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8C7EB10FC2;
	Thu,  1 May 2014 13:51:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KWq3iXg/RuhW2JdKDZR2EtntcSE=; b=QYIN9v
	RttuF0AE90UubNsJl4VwVvZrj8l+RduPy9ixNGiQXSZTs85ZgolUy9udnK1Lvbll
	EEoPT0b1wYCXYP+Wg2EIeWUlTHtR0niEPjn4uuqPWUxRnGQCkCqTCzM1SpBfy0SP
	flM54KNw7BLrswV/NCjCCXHazr+gM0EIwPgyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bzWe8jZlDXOK5iRIPXhILLtGh2SNOzT7
	rAekhOTFEK9p4K61lp4ZGXM7b7pUminYpjAhHPcg9X6CNTh4gu0Uh2OUKdthhUbn
	Bm68dP6pZRiEVJO4Z8zVGelBDAXGTN9U1SBKhARMjvAl1oR8pIQ2+rZVbznHgN09
	GaSAev4NPJA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8406310FC1;
	Thu,  1 May 2014 13:51:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 486B610FC0;
	Thu,  1 May 2014 13:51:21 -0400 (EDT)
In-Reply-To: <87tx99zj31.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Thu, 01 May 2014 16:09:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 346C6F80-D159-11E3-8D40-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247817>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> The sentence lacked the necessary verb.
>
> No, it didn't.
>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  Documentation/CodingGuidelines | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
>> index f424dbd..fdf6269 100644
>> --- a/Documentation/CodingGuidelines
>> +++ b/Documentation/CodingGuidelines
>> @@ -15,7 +15,7 @@ code.  For Git in general, three rough rules are:
>>     let's use it".
>>  
>>     Again, we live in the real world, and it is sometimes a
>                                                ^^
>> -   judgement call, the decision based more on real world
>> +   judgement call, the decision is based more on real world
>>     constraints people face than what the paper standard says.
>
> There is one common "is" for original statement and paraphrase.  Adding
> another one turns this into two sentences which cannot sensibly be
> connected with a comma.

Thanks for spotting.

I thought (but I see I didn't by mistake) that I split them into two
sentences, replacing the comma with a semicolon.

> If you want to fix something here, do s/judgement/judgment/ instead.

That too.
