Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D93C43460
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 04:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E0A3613F9
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 04:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhD1EeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 00:34:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55427 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhD1EeY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 00:34:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89144C8AFE;
        Wed, 28 Apr 2021 00:33:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tv0z7pHQA18D68FL3Wjd9WqT8STFlJqXowSkKz
        NtzvA=; b=FKiSUKWTbL7MTX6tL3ScGYDu+dpMhjLzuEpsh0TPBfJQKmJzS5XBij
        /ZEMxRuq643y3lGby19YtfCXC3kMm7PTWFAnK7qNR+AJIPiA45/q+cyIgABOWJx2
        GdhSBndmnzopkglARpV9NKZTb9xXziuY+TP2mGA6WHcvdJvajm+pY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F402C8AFD;
        Wed, 28 Apr 2021 00:33:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0E09AC8AFC;
        Wed, 28 Apr 2021 00:33:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH 04/30] subtree: t7900: use consistent formatting
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
        <20210423194230.1388945-5-lukeshu@lukeshu.com>
        <CAPig+cT=jZdq=oDSHRF6DnvqZVo4OiPGy7x7AzTzdcy6RV76kw@mail.gmail.com>
        <xmqqpmygdwml.fsf@gitster.g> <87k0ona2a5.wl-lukeshu@lukeshu.com>
Date:   Wed, 28 Apr 2021 13:33:38 +0900
In-Reply-To: <87k0ona2a5.wl-lukeshu@lukeshu.com> (Luke Shumaker's message of
        "Tue, 27 Apr 2021 14:41:22 -0600")
Message-ID: <xmqqv987auzh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E755E04A-A7DA-11EB-BBB4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Shumaker <lukeshu@lukeshu.com> writes:

>> If Luke is volunteering to take over its maintainership, it would be
>> appreciated by its users.  It has been in the "abandonware" status
>> for too long.
>
> I think I am volunteering.

Wonderful, and thanks.

> Elsewhere in the thread, you suggested that subtree be taken out of
> git.git, and live as a standalone project.
>
> I'm not entirely opposed to that, but
>
>  1. I'm not sure how whoever picks it up (me) establishes their
>     git-subtree as the "real" subtree (get a blessing from Avery?).

Avery is so distant a past, but a work like this series, while we
still have it in contrib/ in my tree, will help build necessary
trust in you by the Git user/developer community, and when that
happens, it would be obvious to everybody that you would be the new
owner of the tool.

And when that happens while the tool is in the contrib/ in my tree,
and you'd be an established trusted member of the development
community by then, I do not mind if you take it and maintain out of
tree, if you keep working on the tool still in contrib/, or if you
polish it to the main porcelain status and take it out of contrib/
and make it part of the git-core proper.

> On the other hand, I think that in the long-ish term git-subtree wants
> to be rewritten in a better-suited language.  My personal inclination
> would be Go, but if I ever want it to graduate to git-core, it'd have
> to be C, huh?

If somebody is willing to do a rewrite and will maintain it for a
long haul, I'd say that it would not necessarily have to be in C
especially if it is not performance sensitive.

As long as it is done in a widely available language, that is (which
used to man Perl or Python, but my persoonal preference won't carry
that much weight these days ;-)

Then folks who really want it in C can rewrite the rewrite on their
own after that.

One advantage you may have if you choose to take it out of my tree
and make it a standalone project is that you have more latitude on
the future implementation technology, but we'd need to start from
helping you earn the trust by convincing others that "subtree" would
be in good hands with your volunteering ;-)

Thanks.

