Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79C6C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97EF92075D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HBOqPRE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgG2SQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:16:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51639 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2SQw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 14:16:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D991E3BFB;
        Wed, 29 Jul 2020 14:16:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TEbv0QPsKY08CliaUOMoJTmJoVs=; b=HBOqPR
        E2GY4UItGZ8Soo6LpEDZBnzwrXSoNqIy6DJwfAeWNIRjv61fyMcMsNkq/dNd1T3E
        Ok2SlazTS6YMOYQ6gSRYhz71+mhknjrE9ilyvozpSnKqyDyFuzx8PnkAnFwKIK+6
        lr9GAGIUEqLJbz9RfNLZYBzXRBO2fie3LRTvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UiC8spL1SOCNeKn8I81DDhC7B3J0WUXq
        KDtLS5Oyg0wII/U23ewqlvEdj+RHUQX9T7U05ICJYLGl0oxBhy4+8AkgfcAUqD2S
        UXIAk8uNrgHBo13dHrmje9OkPZIi9dzllDvz2mtKqPPawNobdc5nqf/FroHzKI1G
        Znj1NBM9efA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 85712E3BFA;
        Wed, 29 Jul 2020 14:16:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BAE7DE3BF7;
        Wed, 29 Jul 2020 14:16:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Steve Kemp via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Steve Kemp <steve@steve.org.uk>
Subject: Re: [PATCH] comment: fix spelling mistakes inside comments
References: <pull.685.git.1595993608886.gitgitgadget@gmail.com>
        <571792b3-e65b-e6e8-34b9-56a87a47de8d@gmail.com>
Date:   Wed, 29 Jul 2020 11:16:46 -0700
In-Reply-To: <571792b3-e65b-e6e8-34b9-56a87a47de8d@gmail.com> (Derrick
        Stolee's message of "Wed, 29 Jul 2020 09:45:21 -0400")
Message-ID: <xmqq4kpqb301.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA85CD2C-D1C7-11EA-92E0-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I'll leave it to more experienced contributors to comment on how a
> comment-only patch fits with this section Documentation/CodingGuidelines:
>
>  - Fixing style violations while working on a real change as a
>    preparatory clean-up step is good, but otherwise avoid useless code
>    churn for the sake of conforming to the style.
>
> In my opinion, this change is not harmful, but also isn't super
> necessary. I could go either way.

Typofixes in comments has no chance of breaking things than a
carelessly done code churn made in the name of cleaning up, so
cost-benefit comparison is much more favourable.  I'm sure that I
won't be exhausted after reviewing comment-only patch as much as
after reviewing code-churn only patch.

