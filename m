Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B49BC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 19:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242132AbhLMTIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 14:08:09 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65428 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbhLMTIH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 14:08:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 551E015D094;
        Mon, 13 Dec 2021 14:08:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u409JyO/tWwrriXcqzv9LVpGgjPgHxpLebwF3n
        unANw=; b=i16S3PHNB7w+wkr3+c+JJLQoVeArCOX03EgWH/UHJxDRYOHfgx+/y0
        81gC1Lqs4bTigRBH2HgueKeXZ4MpY45J1ZCKJHtTEpNxGlbZ8uHkgEKPN0jq6zAw
        dMGyr326oDvq4GZDxr61ABR1pmg9D9f7wIuXYUKE0rm9CJiv/14Q0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C8E915D093;
        Mon, 13 Dec 2021 14:08:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A6D6015D092;
        Mon, 13 Dec 2021 14:08:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2021, #03; Fri, 10)
References: <xmqqilvvluoa.fsf@gitster.g>
        <93deba56-1613-d468-8822-c0a9a1370bef@sunshineco.com>
Date:   Mon, 13 Dec 2021 11:08:02 -0800
In-Reply-To: <93deba56-1613-d468-8822-c0a9a1370bef@sunshineco.com> (Eric
        Sunshine's message of "Sat, 11 Dec 2021 03:39:51 -0500")
Message-ID: <xmqqh7bccoh9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF47E17C-5C47-11EC-B3CA-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On 12/10/21 9:52 PM, Junio C Hamano wrote:
>> * es/doc-stdout-vs-stderr (2021-12-04) 1 commit
>>    (merged to 'next' on 2021-12-07 at d6487c1256)
>>   + CodingGuidelines: document which output goes to stdout vs. stderr
>>   Coding guideline document has been updated to clarify what goes to
>>   standard error i nour system.
>
> s/i nour/in our/

Thanks.  This time I won't forget ;-)

