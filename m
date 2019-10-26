Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 127711F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 01:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfJZBPD (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 21:15:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33609 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfJZBPD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 21:15:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id u23so2731968pgo.0
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 18:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bmnxIHEU1MliF1FiFnoP6R9CI3/EDMQbmGqCQBYxzPU=;
        b=tr6/OZk/v9pcckhXRKOhDTg7S0BDikg9ErIIIckcjLSRJ1t+K9sUzPgZcqeJSzBUEs
         5Cj6O2LTJAn60Brg1OPDzPvZ7dLNY07MviOGUPFAZkahDZZNRRTm9zcR0oogxMDxD8qR
         +Krop5N6/8w2SHy7fbbGCtVEAYOEtAw8TNWUuvdJGDkAUz6XArFS7ONp+QRivN6Ju92+
         BLxvQY3MbwcSfvFL3h6Pa+PgEdQEktstw6bgX15ATfPJmM8GqVhVtup9H7imlI59r01O
         OqGK7x79YtLSHweYeUJE0BFLTKlXetmkx58Csj73zHuJQEDUTxBe3DZuMTcF82KRhPfM
         QeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bmnxIHEU1MliF1FiFnoP6R9CI3/EDMQbmGqCQBYxzPU=;
        b=OtVFSzrsEK8r6wkeSytdlHYauIBi3zFRvVyHimAH2ulq0qvyD86ICjmuIG9qr5re/P
         tl03rWv25Hq9nEFB/JGJ8thTLHL6ju7+DV6YzKNtCiLL93ZFcC+m8dc9ojVUycwjJubd
         53SQaL8mAeD8yFDFse+wlEtiUs8Z19OHR0cfyTffmwMwVogIi/0xGHG87mx5sYi6BX1N
         Sl+COe4EhxwNNcDkm5FyWuNpTrWFIC7iM88+hv/Yhdm50f022CNUc61EVGdNcIfOQO3b
         lQRGBLiAusF0LkY5C+PtWjvo1OY/xgMZuzohML/HpEwQShm4xXILjZHyxILWZQAY1LDU
         x/lg==
X-Gm-Message-State: APjAAAV58+7kPjnpe40wWwrrs8WKD53ap9Lz7gfFntI46qKD5UYzVWgs
        bayYqk+GmKk+I0j+RJxutNvDbqrJ
X-Google-Smtp-Source: APXvYqwn6RVFjMs2vPx1PZ1NlBYexy4AfYdJ8jn/dlYUhyBr/22qn+3aqvnY64LTeIeOrKT930WY2A==
X-Received: by 2002:a63:ab43:: with SMTP id k3mr7695372pgp.170.1572052502242;
        Fri, 25 Oct 2019 18:15:02 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id i22sm3587378pfa.82.2019.10.25.18.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 18:15:01 -0700 (PDT)
Date:   Fri, 25 Oct 2019 18:15:00 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] myfirstcontrib: hint to find gitgitgadget allower
Message-ID: <20191026011459.GC39574@google.com>
References: <20191026005159.98405-1-emilyshaffer@google.com>
 <20191026005159.98405-4-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026005159.98405-4-emilyshaffer@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:

> GitGitGadget, a handy tool for converting pull requests against Git into
> Git-mailing-list-friendly-patch-emails, requires as anti-spam that all
> new users be "/allow"ed by an existing user once before it will do
> anything for that new user. While this tutorial explained that
> mechanism, it did not give much hint on how to go about finding someone
> to allow your new pull request. So, teach our new GitGitGadget user
> where to look for someone who can add their name to the list.
>
> The advice in this patch is based on the advice proposed for
> GitGitGadget: https://github.com/gitgitgadget/gitgitgadget/pull/138
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Documentation/MyFirstContribution.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Though I'd appreciate an ack from a gitgitgadget specialist too, so
cc-ing Dscho.

> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
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
> +
>  If the CI fails, you can update your changes with `git rebase -i` and push your
>  branch again:
>  
