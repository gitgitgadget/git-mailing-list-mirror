Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F177E1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 03:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeHWGam (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 02:30:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54280 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeHWGam (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 02:30:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11FC0F567E;
        Wed, 22 Aug 2018 23:03:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=f49W5cfaY1cl7zTyGPHrRC2yLOE=; b=yO6SFQ
        adpdg1ijnQ5dPSe0kvhFCK+1D3bv+FMR+ktJRjylzqpM8JKX8hrqTmjImeRKQurW
        mZ5q4jZ52wgJzXqLPALLNT3Ocmkaq0BYq1mPlS+Ffz2cTPqIoeeik25L0PLBlxaG
        VE712x0VeZ7rpkPzRWFCZe+nvCPK0fVdC4ebE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AABCF567D;
        Wed, 22 Aug 2018 23:03:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=v6xWWLXr76nudPuHa6tXM1PBK48eU/bDz79B7NhjtDY=; b=ygpWnfdcwc9eyCdyfq94BuWeQnzqNjQ9SmVvqzJ6AGkon2IenmwCMT1RdN9OxRfI4uIcP+toyZfIyWu0q4B5o9ngA2tNr780JIH56NTneq2fqKvaYI6Sr2Q97Hk254uIrfY39Ok0Ke3qZpY6OqVK0T5gYH3OkTQq15+0hiiQ9eI=
Received: from localhost (unknown [76.118.43.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8AED9F567C;
        Wed, 22 Aug 2018 23:03:13 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] range-diff: update stale summary of --no-dual-color
In-Reply-To: <20180823024719.GG92374@aiede.svl.corp.google.com>
References: <20180823023955.12980-1-kyle@kyleam.com> <20180823024719.GG92374@aiede.svl.corp.google.com>
Date:   Wed, 22 Aug 2018 23:03:12 -0400
Message-ID: <87wosh7pjj.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1313055E-A681-11E8-BEE0-063AD72159A7-24757444!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

[...]

> What is an outer diff marker?

The diff markers from the diff of patches as opposed to the ones from
the original patches.  I took the term from git-range-diff.txt:

    --no-dual-color::
        When the commit diffs differ, `git range-diff` recreates the
        original diffs' coloring, and adds outer -/+ diff markers [...]

    Use `--no-dual-color` to revert to color all lines according to the
    outer diff markers (and completely ignore the inner diff when it
    comes to color).

-- 
Kyle
