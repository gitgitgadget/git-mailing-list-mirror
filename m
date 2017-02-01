Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BE7520A78
	for <e@80x24.org>; Wed,  1 Feb 2017 23:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751021AbdBAXQs (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 18:16:48 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36046 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbdBAXQr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 18:16:47 -0500
Received: by mail-pf0-f194.google.com with SMTP id 19so32783199pfo.3
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 15:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZQ1wAtU15NCzqImDEwmPjM9MLAalPLKkT237/7qr93I=;
        b=BtC/a2/lnQyJPneBm3HrgTqZbAT22ZhKp7pGJB7ZcevGN0+mgzhA0mEFyEej8bZ4dQ
         uDbgy/B1Zp82Pla+1rP8CAkj4Q90ela/iMwbzhQbJ/Q1gcQOQa65kJnSsmxU9Ly1b1wS
         H65OyPhvWvN1ICTUW1kVMrPaC2KX5tv/NXMyneA5d1AAeClyko3Uyv1sHxSZRF/O/y/K
         EhXcYEPaDvUVsq1bDFrCe3riJWDrs/eel7jrv1H1NSQTGPGptuu4xkir1sgNVAtl4DL0
         wyjXPaddS1PFl2v8QVQIn0NI7y78foVrw1TakP0S/+aAw/knsdOjBwJ3+cGAQkSzgR9U
         MwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZQ1wAtU15NCzqImDEwmPjM9MLAalPLKkT237/7qr93I=;
        b=L3ZwiXo8i1S3+PICC5I/Xeodt5acDtbrKzEcT3PmHIwAQfOyK4ynRtqlC8H4lAvpoW
         N+MXqtzkT9PWtoLyH+RbK1+41ZOiFfq/U6/FUPbgNH2zFx3bZ2sEQzjCHBon6VpcGYQ2
         CjOLBPI6q77dVz1ww2BrH6pG4NFKSL+yUDBG2Ah6ZZDv8ayTLknTFBXn/XW1YKcmr+L0
         ZQ82HJDuA+k4G1DWjdHRgJiPXL0qkRVFWfOG6fTS8hp4dV8UzS921yI347xcA4TDDz0E
         8c1+XCse/Ao4HbcF9lQkqhuCvtdWIMpoMGem8IcibswIzEHpnXIjfRAZRE4yjmJe3Zv1
         DBvw==
X-Gm-Message-State: AIkVDXIUKDqlsrTf1db02Hhw6Y1RJa7tdGRTy/2w4uE7Hlds3RB3MhLg4aL1nEwf3ScY6w==
X-Received: by 10.99.62.73 with SMTP id l70mr6847096pga.97.1485991006643;
        Wed, 01 Feb 2017 15:16:46 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id p25sm52392001pfd.0.2017.02.01.15.16.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 15:16:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     cornelius.weig@tngtech.com
Cc:     git@vger.kernel.org, bmwill@google.com, sbeller@google.com
Subject: Re: [PATCH 1/2] doc: add doc for git-push --recurse-submodules=only
References: <20170201230753.19462-1-cornelius.weig@tngtech.com>
Date:   Wed, 01 Feb 2017 15:16:45 -0800
In-Reply-To: <20170201230753.19462-1-cornelius.weig@tngtech.com> (cornelius
        weig's message of "Thu, 2 Feb 2017 00:07:52 +0100")
Message-ID: <xmqqinotmrhe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cornelius.weig@tngtech.com writes:

> From: Cornelius Weig <cornelius.weig@tngtech.com>
>
> Add documentation for the `--recurse-submodules=only` option of
> git-push. The feature was added in commit 225e8bf (add option to
> push only submodules).
>
> Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
> ---
>
> Notes:
>     This feature is already in 'next' but was undocumented. Unless somebody reads
>     the release notes, there is no way of knowing about it.

Good eyes; the topic bw/push-submodule-only is already in 'master'.

Looks good to me; Brandon?

>
>  Documentation/git-push.txt | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 8eefabd..1624a35 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -272,7 +272,7 @@ origin +master` to force a push to the `master` branch). See the
>  	standard error stream is not directed to a terminal.
>  
>  --no-recurse-submodules::
> ---recurse-submodules=check|on-demand|no::
> +--recurse-submodules=check|on-demand|only|no::
>  	May be used to make sure all submodule commits used by the
>  	revisions to be pushed are available on a remote-tracking branch.
>  	If 'check' is used Git will verify that all submodule commits that
> @@ -280,11 +280,12 @@ origin +master` to force a push to the `master` branch). See the
>  	remote of the submodule. If any commits are missing the push will
>  	be aborted and exit with non-zero status. If 'on-demand' is used
>  	all submodules that changed in the revisions to be pushed will be
> -	pushed. If on-demand was not able to push all necessary revisions
> -	it will also be aborted and exit with non-zero status. A value of
> -	'no' or using `--no-recurse-submodules` can be used to override the
> -	push.recurseSubmodules configuration variable when no submodule
> -	recursion is required.
> +	pushed. If on-demand was not able to push all necessary revisions it will
> +	also be aborted and exit with non-zero status. If 'only' is used all
> +	submodules will be recursively pushed while the superproject is left
> +	unpushed. A value of 'no' or using `--no-recurse-submodules` can be used
> +	to override the push.recurseSubmodules configuration variable when no
> +	submodule recursion is required.
>  
>  --[no-]verify::
>  	Toggle the pre-push hook (see linkgit:githooks[5]).  The
