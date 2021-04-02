Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF870C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A8961167
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhDBV37 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 17:29:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57064 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBV36 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 17:29:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B4E912FA19;
        Fri,  2 Apr 2021 17:29:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RpExJqiasEE8BjNcLI1n48mhjZU=; b=T907Qk
        lAtji7xRhnsyUOHOyh2QFpDh0RZFDZ+Cb55z+tgOV5bg1xV5yk55c/63GX6KFJJT
        ALwURHc6g8ZI+Tdu6N7i7Q8DjZ71ui3/RHQpXhgXglUMEYRH5rv94nlj1jMaz5sr
        itIoKu0FhRe5kgeQ8btFVFA6i3Gz/DGw69Ve8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O2hIGTNRqz35iPkqZd93RplTEHhvw0Am
        xAMhzodFlat2z14RSUNl3WuzGbHqYp3aRDcGajGcermFREX76UGoyjtnhKPbalcD
        y7lH2hACYFYGyTjuAfFNP9zgivbX2eQvRcKDyJZch3d6cbymAw8MJjUpbZBxpFJT
        lwFsOjGphIs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44A0B12FA18;
        Fri,  2 Apr 2021 17:29:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 77D9012FA16;
        Fri,  2 Apr 2021 17:29:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Firmin Martin <firminmartin24@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH][GSoC] user-manual.txt: fix empty heading of introduction
References: <20210402121303.344914-1-firminmartin24@gmail.com>
        <xmqqwntk2xgy.fsf@gitster.g>
Date:   Fri, 02 Apr 2021 14:29:52 -0700
In-Reply-To: <xmqqwntk2xgy.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        02 Apr 2021 14:22:21 -0700")
Message-ID: <xmqqsg482x4f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90C7CFF2-93FA-11EB-9933-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Firmin Martin <firminmartin24@gmail.com> writes:
>
>> For future reference, here are the content of the relevant & auto-generated files
>> before this commit.
>
> I would have expected to see "before and after".  Is it too obvious
> what the postimage would be?  Otherwise, a better presentation would
> be to show (an excerpt from) diff between preimage and postimage
> output.
>
> Thanks.

Another thing to look out for.  I do not think git.info is the only
consumer of user-manual.txt.  Does this change affect the other
consumer, user-manual.html, and if so how?
