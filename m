Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD98C433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 00:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508CC2312A
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 00:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393769AbhAMAnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 19:43:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51318 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392349AbhAMAXv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 19:23:51 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C0C99ED2F;
        Tue, 12 Jan 2021 19:23:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=usr+97APonGqG37VDwcaGv1D8DU=; b=clVnwf
        Mo6XsE+27n3q9tWC71Y2B89Y/WeITTdMVaMCpVniD3SSmnLnvkupxoJCqOuUWqAz
        VgHVybO7KcfQby1aCFBsw3A+p7uX3/odK82jYlIu6hub8C2TWwH4seu9jVOGfAft
        xe0wF2mg2uWUFnSxqML98ihcpcMnWFxTYmsA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a/hWJd0FHsGlegQfRq3I9QJUdK66LLCl
        FFE/juKWpBdHe7IkCGKToCR15zHshqK6b2sXwelOF4Gh3o7Q8WIDwYJ9t/LdMOTg
        NUleBf56keOz/HryOvXJqr1xFKvesmuOWuPo2odVNHX35778kl1UDMJ+o02sUAXq
        65xfVcPBozk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4218D9ED2D;
        Tue, 12 Jan 2021 19:23:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD4EF9ED2B;
        Tue, 12 Jan 2021 19:23:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com
Subject: Re: [PATCH 00/20] pack-revindex: prepare for on-disk reverse index
References: <cover.1610129796.git.me@ttaylorr.com>
Date:   Tue, 12 Jan 2021 16:23:00 -0800
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com> (Taylor Blau's message of
        "Fri, 8 Jan 2021 13:16:39 -0500")
Message-ID: <xmqqk0shznvf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F0072AA-5535-11EB-9D21-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This is the first of two series to introduce an on-disk alternative to the
> reverse index which is currently generated once per-process and stored in
> memory.

Queued; seems to be killed on Windows but otherwise looking good.
  
  https://github.com/git/git/runs/1691849288?check_suite_focus=true#step:6:164

Thanks.
