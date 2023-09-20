Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5336AC04AA9
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 15:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbjITPwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjITPwl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 11:52:41 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9061A9
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 08:52:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7844236C66;
        Wed, 20 Sep 2023 11:52:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=F+3/GUBYTwLzgX2qn/e51R7vhOiw6qEd4ASc6V
        Z/XGI=; b=JBK6oxiy/cW1BBhHz15uUg63JBvBQZQMX9AL4PfnE961CXW4hnDd0T
        Ban18dUVswattqUKhc/aZ6GTE8Fr4xHwYY/ls/gI1B3JMrAdW/Cl7Bt7pZ2Jg6tQ
        VWyqB/XZw/YJ/B7bxtUlNU+uBgAp71vE5cwCZ0/JWPCtErNW3/kDw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 715BA36C64;
        Wed, 20 Sep 2023 11:52:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D413036C37;
        Wed, 20 Sep 2023 11:52:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Young <hanyang.tony@bytedance.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] show doc: redirect user to git log manual instead of
 git diff-tree
In-Reply-To: <20230920132731.1259-1-hanyang.tony@bytedance.com> (Han Young's
        message of "Wed, 20 Sep 2023 21:27:31 +0800")
References: <20230905121219.69762-1-hanyang.tony@bytedance.com>
        <20230920132731.1259-1-hanyang.tony@bytedance.com>
Date:   Wed, 20 Sep 2023 08:52:30 -0700
Message-ID: <xmqqpm2calkx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B56DBAC6-57CD-11EE-A2A5-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Young <hanyang.tony@bytedance.com> writes:

> While git show accepts options that apply to the git diff-tree command,
> some options do not make sense in the context of git show.
> The options of git show are handled using the machinery of git log.
> The git log manual page is a better place to look into than git diff-tree
> for options that are not in the git show manual page.
>
> Signed-off-by: Han Young <hanyang.tony@bytedance.com>
> ---
> Changes since v1:
> * change wording to clarify not all options of `git log` are meant for `git show`

Nice.  Thank you very much for not forgetting this topic.



>  Documentation/git-show.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
> index 2b1bc7288d..fc46b3687b 100644
> --- a/Documentation/git-show.txt
> +++ b/Documentation/git-show.txt
> @@ -26,7 +26,7 @@ with --name-only).
>  
>  For plain blobs, it shows the plain contents.
>  
> -The command takes options applicable to the 'git diff-tree' command to
> +Some options that 'git log' command understands can be used to
>  control how the changes the commit introduces are shown.
>  
>  This manual page describes only the most frequently used options.
