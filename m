Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1E9E1F4C0
	for <e@80x24.org>; Sun, 27 Oct 2019 01:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfJ0BjI (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 21:39:08 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:53771 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfJ0BjI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 21:39:08 -0400
X-Originating-IP: 157.45.193.37
Received: from localhost (unknown [157.45.193.37])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 2D12440003;
        Sun, 27 Oct 2019 01:39:04 +0000 (UTC)
Date:   Sun, 27 Oct 2019 07:09:01 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] myfirstcontrib: hint to find gitgitgadget allower
Message-ID: <20191027013900.m7t4u6lo4tc4cdqz@yadavpratyush.com>
References: <20191026005159.98405-1-emilyshaffer@google.com>
 <20191026005159.98405-4-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026005159.98405-4-emilyshaffer@google.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/10/19 05:51PM, Emily Shaffer wrote:
> diff --git a/Documentation/MyFirstContribution.txt 
> b/Documentation/MyFirstContribution.txt
> index b8ffeda07e..2de06de026 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -789,6 +789,14 @@ will automatically run your PRs through the CI even without the permission given
>  but you will not be able to `/submit` your changes until someone allows you to
>  use the tool.
>  
> +NOTE: You can typically find someone who can `/allow` you on GitGitGadget by
> +either examining recent pull requests where someone has been granted `/allow`
> +(https://github.com/gitgitgadget/git/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+%22%2Fallow%22[Search:
> +is:pr is:open "/allow"]), in which case both the author and the person who
> +granted the `/allow` can now `/allow` you, or by inquiring on the
> +https://webchat.freenode.net/#git-devel[#git-devel] IRC channel on Freenode
> +linking your pull request and asking for someone to `/allow` you.

Nit: that's a lot to put in a single sentence. Maybe break it into parts 
like:

  NOTE: You can typically find someone who can `/allow` you on 
  GitGitGadget by looking at recent pull requests where someone has been 
  `/allow`ed. Both the author of that pull request and the person who 
  granted the permission can now `/allow` you. You can also inquire on 
  the IRC channel on Freenode linking your pull request and asking 
  someone to `/allow` you.

> +
>  If the CI fails, you can update your changes with `git rebase -i` and push your
>  branch again:

-- 
Regards,
Pratyush Yadav
