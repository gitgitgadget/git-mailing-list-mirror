Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28876C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 22:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC6360F23
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 22:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhJLWv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 18:51:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58043 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhJLWv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 18:51:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6DBC3165DB3;
        Tue, 12 Oct 2021 18:49:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=00iJ7FwKv69YZx3qCfdoo5ehmFfwDl6f4iTCa9
        FZPz8=; b=DaWll3BftMCMbF3f1Uk8V2rVG0Oo9Y0aQMn6vpnsWIOb1DH0a+EsuA
        2bHr3mRdaTO8hquo9dAtslOa2T6UvBRMn6zVsSGxn9mv+R84+daRaGB5mOOJvkcJ
        NcYnXpTIS631lIQxdymCh2GERJz+gS6XozChO/VyQB8bg8r0wYIXY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 667C5165DB2;
        Tue, 12 Oct 2021 18:49:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EB00C165DAD;
        Tue, 12 Oct 2021 18:49:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        carenas@gmail.com, chooglen@google.com
Subject: Re: [PATCH v4 0/7] No more adding submodule ODB as alternate
References: <cover.1632242495.git.jonathantanmy@google.com>
        <cover.1633727270.git.jonathantanmy@google.com>
        <YWYO2TO5tg98oy5q@google.com>
Date:   Tue, 12 Oct 2021 15:49:22 -0700
In-Reply-To: <YWYO2TO5tg98oy5q@google.com> (Josh Steadmon's message of "Tue,
        12 Oct 2021 15:40:25 -0700")
Message-ID: <xmqqbl3t3ll9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5553ED6-2BAE-11EC-B17F-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> On 2021.10.08 14:08, Jonathan Tan wrote:
>> Thanks everyone for your reviews. Here's an updated patch set, including
>> Carlo's fixup squashed.
>> 
>> Jonathan Tan (7):
>>   refs: plumb repo into ref stores
>>   refs: teach arbitrary repo support to iterators
>>   refs: peeling non-the_repository iterators is BUG
>>   merge-{ort,recursive}: remove add_submodule_odb()
>>   object-file: only register submodule ODB if needed
>>   submodule: pass repo to check_has_commit()
>>   submodule: trace adding submodule ODB as alternate
>
> This looks good to me. All my concerns from v3 have been addressed, so:
>
> Reviewed-by: Josh Steadmon <steadmon@google.com>

Thanks, all.  Let's mark the topic for 'next' now.
