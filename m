Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6EDC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 01:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B9160E09
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 01:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhG3BES (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 21:04:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54960 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhG3BER (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 21:04:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5233F13C7C1;
        Thu, 29 Jul 2021 21:04:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Aw5gaGuMp+eJ4EwelSv86UHChFYZJJqLxootFM
        3WQy0=; b=aTZhjR4PixOieTGolprfeehM4Uznm3bNLzqk08++Z8QvGKK5RNEeac
        LVzzXPnY2eg6EnHOtn29q6a1AHIu3uPLKFmhHP9EFo/3MBslFzocAZdrXN4ijriu
        0q8E9QQqNk4RmDP0venCDGisn6JISbml3/4ffUGgQPs7rilaAULmY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4AB2913C7BF;
        Thu, 29 Jul 2021 21:04:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9623213C7BE;
        Thu, 29 Jul 2021 21:04:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Boeckel <mathstuf@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/1] Improve automatic setup of tracking for new branches
References: <20210728135041.501850-1-mathstuf@gmail.com>
        <20210729020125.746206-1-mathstuf@gmail.com>
Date:   Thu, 29 Jul 2021 18:04:08 -0700
In-Reply-To: <20210729020125.746206-1-mathstuf@gmail.com> (Ben Boeckel's
        message of "Wed, 28 Jul 2021 22:01:24 -0400")
Message-ID: <xmqqim0s394n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C5F9D82-F0D2-11EB-A515-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Boeckel <mathstuf@gmail.com> writes:

> I searched the docs (including `Documentation/gitworkflows.txt`), but
> didn't see anywhere to describe the fork-based workflow common on forges
> (such as GitHub and GitLab) where this felt "at home".

Before you came, many users have used Git with these forges, so it
might be just the matter of correct terminology to use to find what
to read about.  Does the keyword "triangular workflow" find what may
help your way of working?


