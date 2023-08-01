Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34BCC00528
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 21:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjHAVHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 17:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHAVHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 17:07:16 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028B3129
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 14:07:16 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 484BE1B0948;
        Tue,  1 Aug 2023 17:07:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Dr8fOqrGiBJPztQr3Zgjdw4bgowKLbB2LVe4DT
        wzstM=; b=RxWb3ZAqKBZX83hE55JRXra3Bi/Sd3tDqFIa+IM58I29svW5MWbjta
        0ihJqpPQ1Z/AtaQPKG2Bk5SmNTcDYAbhtkpuAD0SsASw7duLcdLVA8dDIxBYvtPV
        rQOrG3TSjBeXcuCHPzUvqAzp3/RdKw02k9kEkd+9li8WUAeIzMtiU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F0F41B0947;
        Tue,  1 Aug 2023 17:07:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9AB641B0946;
        Tue,  1 Aug 2023 17:07:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v7 0/7] Changed path filter hash fix and version bump
References: <cover.1684790529.git.jonathantanmy@google.com>
        <cover.1690912539.git.jonathantanmy@google.com>
        <xmqqbkfqbo21.fsf@gitster.g> <ZMlyEpRCPPNG7jQP@nand.local>
Date:   Tue, 01 Aug 2023 14:07:13 -0700
In-Reply-To: <ZMlyEpRCPPNG7jQP@nand.local> (Taylor Blau's message of "Tue, 1
        Aug 2023 16:58:58 -0400")
Message-ID: <xmqqpm46a2v2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63C80194-30AF-11EE-9363-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Aug 01, 2023 at 11:44:06AM -0700, Junio C Hamano wrote:
>> Jonathan Tan <jonathantanmy@google.com> writes:
>>
>> > Taylor also suggested copying forward Bloom filters whenever possible
>> > in this patch set [3], but also that we could work on this outside this
>> > series [4]. I did not implement this in this series.
>>
>> I think it is a good place to stop, as it would merely be a quality
>> of implementation difference and would not change the transition
>> story very much.
>>
>> Thanks for working well together.  Will queue.
>
> Thanks. I read through this version and feel good about the results.
> I agree that queuing this one down makes sense.

Thanks.

ps. no more comms from me for the rest of the day as I am feeling
ill.  I've pushed out today's integration result already, merging
three or so topics down in 'next' and also absorbing a few new
topics in 'seen'.

