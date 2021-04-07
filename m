Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E995DC43460
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6AB061205
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhDGU50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 16:57:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60221 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhDGU5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 16:57:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 94C51135219;
        Wed,  7 Apr 2021 16:57:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0ga2BIUko9ELin/US3T/6fjhx1s=; b=Hv5bfN
        B1O8GMeb10GJJXVvpzql+f0JTmcWqtK9iYvT43uwQadIkvCfiOcsVwXGCHgC8nLH
        imLQNuGMkwsQPMcaPrJPfDHZjXGF/6BDmIxb2T4N/Sj+jyOhCoyVNDEARReVednO
        rLZQuHI29QPrpjDijKQ0GzSRuhLXEaR1pQ2N0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kp3ka3qdsXDqv1I6bb1vLTpniomca92c
        aHCgjxQD9dOx9VQ5bUT2XlO4vsmcoEh2QK0xJHz2wK8SWi9RwVx/vabqt+VO2aOx
        gRAbPQqiR37r/HA3KKxwHfif5jVlrD/nA5CnwB15F0I4k33OrV+eUtUsvc47FPHq
        CX4RoXtTSAI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 77C8A135218;
        Wed,  7 Apr 2021 16:57:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9EEF6135217;
        Wed,  7 Apr 2021 16:57:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: Reviewed-by given by celebrities (no subject matter expertise
 on Git development)
References: <345a7b27-8ee4-4b64-0340-40b002a25d1f@gmail.com>
        <xmqqeefqzsvz.fsf@gitster.g>
        <YG4U5phu1uXZe6Tn@coredump.intra.peff.net>
Date:   Wed, 07 Apr 2021 13:57:10 -0700
In-Reply-To: <YG4U5phu1uXZe6Tn@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 7 Apr 2021 16:24:06 -0400")
Message-ID: <xmqqv98xyfrt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D37F970C-97E3-11EB-A870-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't usually post "me too" responses, since they are usually just
> noise. But I could not resist it here, for two reasons:
>
>   - this is such a nicely written summary of what "Reviewed-by" means in
>     our project that I think it deserves some praise. :)
>
>   - because it is ultimately about "what does Reviewed-by mean within
>     the Git project", there is some small value in having another
>     project member say "yes, that is exactly what I expect from it,
>     too"

Heh, thanks.

Are you hinting that some of what I wrote (with typofixes like
s/arond/around/) should be inserted to SubmittingPatches or
somewhere near it?

I am still scratching my head why "celebrities" were brought into
the original question in the first place, but I can say that we do
not discriminate against "celebrities" who review patches with
prejudice like "that lady only plays a hacker on TV, and must know
nothing to qualify to review our patches."  Celebrities or not, once
somebody demonstrates enough competence and earns reputation on this
list, opinions by that person would count more than others.
