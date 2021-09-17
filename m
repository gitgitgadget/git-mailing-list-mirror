Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809CBC433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 16:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68BCE6103B
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 16:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhIQQeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 12:34:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60562 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhIQQeK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 12:34:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60375F619D;
        Fri, 17 Sep 2021 12:32:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X9pBzHD/A3+sipOCJf+qh4qImkmBGAvpsuWK2J
        pJHoo=; b=RR4H1O8OfywKffIde3BlTv2ODqx/PifKZaj4CU4vPOU6ImD0nOaFX7
        aHrBDPKEb/diW+rCzDeNZQ1VjbTdQFX8GpAA98OSMSFwDNWql0Vy/2VhEV/bNgAT
        cwnzQwasIiat0NQuJRzJQsFF7fLwZTomQCemPMO/yFtHS/cxqtlA0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56AD9F619C;
        Fri, 17 Sep 2021 12:32:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B8127F619B;
        Fri, 17 Sep 2021 12:32:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <87h7f4tf0b.fsf@osv.gnss.ru> <xmqqy288b64q.fsf@gitster.g>
        <87pmtjkwsj.fsf@osv.gnss.ru> <87sfy497ed.fsf@osv.gnss.ru>
        <xmqqy27wrzmj.fsf@gitster.g> <874kaki1nb.fsf@osv.gnss.ru>
        <xmqqzgscqgmv.fsf@gitster.g> <87bl4rk7bh.fsf@osv.gnss.ru>
Date:   Fri, 17 Sep 2021 09:32:45 -0700
In-Reply-To: <87bl4rk7bh.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        17 Sep 2021 10:08:34 +0300")
Message-ID: <xmqqbl4ri2mq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4052B70-17D4-11EC-94D7-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Ah, now I see, but it's exactly lack of documentation (and tests) that I
> was referring to as the "problem of the historical status quo" on the
> Git side, so I was somewhat confused by your original response.

Well, you said the fixup "restores" the status quo, but in fact,
with or without the fixup, before or after it, the lack of
documentation was there.  So I thought you were talking about
something else.

>> I wanted to give you some credit for having worked on "--diff-merges",
>> an effort to generalize things in a related area.
>
> Thanks for that! More to follow )

I somehow expect there was need for no further work in this area,
but there are also many other areas in Git where your talent is
applicable and appreciated, I am sure ;-)

Thanks.
