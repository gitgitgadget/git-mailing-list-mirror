Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B1CC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 17:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbhLGR2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:28:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52180 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhLGR2g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 12:28:36 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A63CA109A08;
        Tue,  7 Dec 2021 12:25:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q8NmWXElkl1iXrV8lIqMba1vSyP31NHezUW8rx
        rfATs=; b=SUkGwg2pkrNpkMTQXAklqc/GlXIpXilIMkGNUPtITT/8iVnd1ZJhHC
        dFfe/FRZzcTXlNzeDERBFYi4nj7LGeWsUXIZ87pMc+9g0uFyphpUYPnXEipLbfvr
        5MNzzMt9UawMAc4pPwne8Dl/uFch0p6tM684vjzV080qhJpElMyvo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88178109A07;
        Tue,  7 Dec 2021 12:25:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58843109A06;
        Tue,  7 Dec 2021 12:25:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2021, #01; Fri, 3)
References: <xmqqbl1xqheu.fsf@gitster.g> <xmqqilw1b4ry.fsf@gitster.g>
        <ef487c98-820c-010e-e3c9-39d60633b30f@gmail.com>
Date:   Tue, 07 Dec 2021 09:25:02 -0800
In-Reply-To: <ef487c98-820c-010e-e3c9-39d60633b30f@gmail.com> (Derrick
        Stolee's message of "Tue, 7 Dec 2021 11:21:26 -0500")
Message-ID: <xmqq35n4ba4x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DA5F0A4-5782-11EC-B4F5-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I found this output to be a particularly interesting way to get an
> overview of everything going on. It almost looks appropriate for
> being a "table of contents" for the main report. Have you thought
> about adding it near the top of that report?

This was primarily designed to help guide me decide what topics to
merge to 'next' in what order, and it is pretty much a grep in the
main part of the report that duplicates what is already said down
there.  With the number of topics in the report, it may not be very
useful as a ToC, and while I do not mind adding one every time I
send out a new issue of the report, I do not know how it affects
readers to drown them by this list-of-topics at the top.

Another thing that is different in this and upcoming issue of the
report is that I tried to track down the "source" of each topic, so
that it becomes easy to go to a single web page I can view the
discussion on the topic by appending "source:" message ID after
https://lore.kernel.org/git/.  I am still not sure how sustainable
to keep doing this "source:" annotation (it is automated somewhat,
but needs manual sanity checks), so I won't promise keeping it in
the future, though.  At least, not yet.

Thanks.
