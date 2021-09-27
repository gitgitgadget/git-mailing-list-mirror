Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9042C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 17:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A209161206
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 17:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbhI0RgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 13:36:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64736 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239222AbhI0RfF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 13:35:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 511A9E9575;
        Mon, 27 Sep 2021 13:33:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xgZ2S9XO7/AQvHOnoag/zdqd+v0zIy0DHw9zVA
        7k4UU=; b=G1xtakAryZv+K6Zzebu39zBTqg/vkQhgfmfNNjrTrDCmY5mPDKIdvT
        JqTIf0taHQA+eMotPzZIL+C0DrBIFQOZK6H/K2NNEPPUkW6y0I6br+rf1zJq8bAc
        m6zhaG0+UxIqd8e2FhXPdU9Qov5Lz9vfHV9FWTDL5/gXtFY/DgkSk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 483FEE9574;
        Mon, 27 Sep 2021 13:33:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AE98EE9572;
        Mon, 27 Sep 2021 13:33:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Sep 2021, #07; Thu, 23)
References: <xmqqa6k2yj1j.fsf@gitster.g>
        <95edb81b-f440-50eb-77e6-282de1a452d6@ahunt.org>
Date:   Mon, 27 Sep 2021 10:33:25 -0700
In-Reply-To: <95edb81b-f440-50eb-77e6-282de1a452d6@ahunt.org> (Andrzej Hunt's
        message of "Sun, 26 Sep 2021 18:00:06 +0200")
Message-ID: <xmqqbl4drkii.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05BD5CBA-1FB9-11EC-8BC6-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrzej Hunt <andrzej@ahunt.org> writes:

> On 24/09/2021 01:22, Junio C Hamano wrote:
>> * ah/connect-parse-feature-v0-fix (2021-09-23) 1 commit
>>   - connect: also update offset for features without values
>>   Protocol v0 clients can get stuck parsing a malformed feature
>> line.
>>   Will merge to 'next'.
>> 
>
> I hope it's not too late - I ended up sending out a V2 at:
> https://public-inbox.org/git/e1395ff2-e697-83b2-082b-d5468b7a11ac@ahunt.org/T/#md3a45bb0fdf9cfd49e0fabdb1b21cd045df523c5

Thanks.  Will take a look.
