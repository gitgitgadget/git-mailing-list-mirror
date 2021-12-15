Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CC1C433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 18:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343893AbhLOSmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 13:42:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61078 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242070AbhLOSmP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 13:42:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDFCB10C316;
        Wed, 15 Dec 2021 13:42:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=An5Xj9V63LyGMEmHTNg3/Sxls318N83PF6e/vL
        3nAOM=; b=r1CdvFmLmUwAMv/ZpybJ3O6I2AICZDWVgMpA4Fw+hyWaodNTMV5tuw
        4h2Q7npWUceI6vR9U9JVu56nEJ3cSqQJPLvAD6Sth+oTDz6mOOM4JsUWcEfLd4Ux
        VCJUpv+VGN6yUvXuBwzj/4r3VeeuR8niIwITcmZgT3mLuXLGsrkfY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B548910C315;
        Wed, 15 Dec 2021 13:42:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2476D10C314;
        Wed, 15 Dec 2021 13:42:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: taking a break from Git
References: <YboaAe4LWySOoAe7@coredump.intra.peff.net>
Date:   Wed, 15 Dec 2021 10:42:12 -0800
In-Reply-To: <YboaAe4LWySOoAe7@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 15 Dec 2021 11:38:25 -0500")
Message-ID: <xmqqwnk57lrv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7EAD614-5DD6-11EC-9DAB-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm going to be offline and completely absent from the mailing list for
> five months starting at the end of December. After that, things are up
> in the air, but I may not be as involved in the project as I have been.
>
> Sorry, there's no juicy gossip or drama to share. I still like everyone,
> and think it's a cool project. ;) After 15 years, it just feels like
> it's time for a break and to perhaps apply my brain to something else
> for a while.
>
> There are a couple logistical things related to this:
> ...

First, let me thank you for the tremendous impact to the community
your contribution had in the past years.  All of these "hidden from
public" contributions of you have been very valuable, of course, but
I am sure many of us will miss your public contributions, insightful
comments on technical issues, suggestions to pursue possible
different approaches and alternative solutions, encouragements given
to new developers with gentle nudges, and helpful hints to new
users.

The development community wouldn't have been what we have today
without you.  It has been a fun project for me, too, and that's
largely thanks to your presence around here.

I hope that whatever you'd start doing next year is as enjoyable as
working on Git with you has been for me in the past 15 years.  If
you find renewed interest in Git after 5 months' sabbatical, that
would be more than fine, too ;-)

