Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04DE1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 10:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733271AbfKGKXe (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 05:23:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61975 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfKGKXe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 05:23:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4638D8EB47;
        Thu,  7 Nov 2019 05:23:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ALGj1HQj7RyXLbiPxZKCVZ4JUgQ=; b=LyrYyK
        A4SamnSJhg6Lq1uDnzpNtL31eIp/v7486sQ65+BIEBIfnyRtiuDEgiZJCJxWAME2
        rPSwg7VvIxvoa1oA1WVo0fP4Q3uQgsNDpwE6DzKA25549ReAVbSksGu7bmkIVgjv
        YkJgMeWwLaRpo39hnKVi8FAI8bqQGRplfjVHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A1wzlm17DLSMIP8h4cWVPqS1RcfPB9LA
        wX5STkVRx/HY2BRJypk09ZKsprUO3UfznMR8JLcu+6P6J5XMWQ3jgPzuTcm+CgYD
        yuj1U97FyzuK5iFEX+mVt0xzEAANzkOqw3KaD1aIda6C3dJgHMTZQ/dCDgR1zPIE
        p1X3GbjqGi4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E8078EB46;
        Thu,  7 Nov 2019 05:23:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1A8078EB43;
        Thu,  7 Nov 2019 05:23:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "george espinoza via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, George Espinoza <gespinoz2019@gmail.com>
Subject: Re: [PATCH 3/6] This file wasn't supposed to change during my git push for check-ref-format :(
References: <pull.449.git.1573114201.gitgitgadget@gmail.com>
        <078a19e86af6fcf1348d8988dc10cfac2e689ba4.1573114201.git.gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 19:23:26 +0900
In-Reply-To: <078a19e86af6fcf1348d8988dc10cfac2e689ba4.1573114201.git.gitgitgadget@gmail.com>
        (george espinoza via GitGitGadget's message of "Thu, 07 Nov 2019
        08:09:57 +0000")
Message-ID: <xmqqo8xoouht.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4237768-0148-11EA-AD6C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"george espinoza via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: george espinoza <gespinoz2019@gmail.com>
>
> Signed-off-by: george espinoza <gespinoz2019@gmail.com>
> ---

While developing your first patch, it is expected that you make
mistake in an earlier step (e.g. 2/6) and then later realize it and
want to fix, like this one.  Instead of going back to the earlier
mistake and fixing it right there before building more on top,
tentatively fixing with "oops that was wrong" like this one and
building further (i.e. 4 and later steps) is an expedient way.

But once you are done, you need to get your act together before
presenting the resulting series to the general public.

Please learn to use "rebase -i" to clean up the series before
asking GGG to publish it to the list.

Thanks.

>  builtin/merge-ours.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
> index 3980f4899a..4594507420 100644
> --- a/builtin/merge-ours.c
> +++ b/builtin/merge-ours.c
> @@ -11,11 +11,6 @@
>  #include "git-compat-util.h"
>  #include "builtin.h"
>  #include "diff.h"
> -#include "parse-options.h"
> -
> -/* parse-options.h added to initiate replacement of manual option parsing
> - * with parse-options. 
> - */
>  
>  static const char builtin_merge_ours_usage[] =
>  	"git merge-ours <base>... -- HEAD <remote>...";
