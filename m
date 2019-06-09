Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 570091F462
	for <e@80x24.org>; Sun,  9 Jun 2019 18:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfFISC4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 14:02:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44433 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbfFISCz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 14:02:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id b17so6863538wrq.11
        for <git@vger.kernel.org>; Sun, 09 Jun 2019 11:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rJrknrATBzTzkBoSDOuLl5nNqgAbx2hko0j+psp0m6A=;
        b=Vgr0Bxs+9MvkbFsP4BAjU6cyOr88O9XOjmy6gqc/CmXc34bGXIQJLXW7rR2KKimxHv
         yzzSojHdqOXVk3FtympG7LV8VQJnDr7/pzMROARLWzK6+/weokWxFeXCfEVgJ1yGDwSM
         8CVQdsO233vaKeU0hBAwbNE1MZuBJNJV81xiXHd/2LrYl/Id4L2AjvluHhyTfQk4jeiq
         NVDgh64e0/DBvNH4JUHj6LQAoVwf545FsWphkcgT2M2nbs9zBPMrJoEpiv08iS7sAKo/
         VL0DQNOPReQYiBJ6Ch7nF4o/XcchKRjhpACrEIK9oKVelqx/4D0LSghAHyIkGsvFEMAi
         j2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rJrknrATBzTzkBoSDOuLl5nNqgAbx2hko0j+psp0m6A=;
        b=jxRmuIgEsropBE8FT8uJxBRkHyceWSd44CLCVzoeYOUEZlPqNMdr5EMwnRtsZMhPh/
         rX5/+duyBl+LGfP6OYZ3vWfhulkReLvKq/nxZPL1MzWJlr4dD62O6Bs2wuIdGOj8GO5I
         EK/KfM1dc0z5rYkLkgHSXRvsUDkINYyrJAdZEjOwdSk4YutZO8fxt5hR2pts2t+UPERp
         Ct0FODEiSV78qNijknGn2s9xWC8fYpQM8BfsbtzsZTwil4+Nn4TtiRLveRjZxabyAsqn
         2Xz92vXh+IA9PqfsDLMVdGzY8+fgmqy2bT+YzTYzApAEa1WbpARRszfdqlzbQCScFCpF
         R3NA==
X-Gm-Message-State: APjAAAX3nS0YCve1q30EujUVyzyopfp3frpqRqDOlPVjGgZNkOQk2C5/
        8Rwv0HqjFxpC7O9MWc+Q2XQ=
X-Google-Smtp-Source: APXvYqx2acKLX81L0CGnn1r0IJkniK7bARm6ePokDiv+k/gefWQsi9coK4Pq1lW52t1GbivxKnly9w==
X-Received: by 2002:adf:8307:: with SMTP id 7mr25650275wrd.86.1560103374250;
        Sun, 09 Jun 2019 11:02:54 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id g131sm4808650wmf.37.2019.06.09.11.02.52
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 11:02:53 -0700 (PDT)
Subject: Re: [GSoC][PATCH 3/3] cherry-pick/revert: update hints
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>, git@vger.kernel.org
Cc:     newren@gmail.com, t.gummerer@gmail.com
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190608191958.4593-4-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <61a8bfde-018c-5a69-5abd-89d4a332e39e@gmail.com>
Date:   Sun, 9 Jun 2019 19:03:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190608191958.4593-4-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 08/06/2019 20:19, Rohit Ashiwal wrote:
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>  builtin/commit.c | 13 ++++++++-----
>  sequencer.c      |  4 ++--
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 1c9e8e2228..1f47c51bdc 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -60,15 +60,18 @@ N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\
>  "\n");
>  
>  static const char empty_cherry_pick_advice_single[] =
> -N_("Otherwise, please use 'git reset'\n");
> +N_("Otherwise, please use 'git cherry-pick --skip'\n");
>  
>  static const char empty_cherry_pick_advice_multi[] =
> -N_("If you wish to skip this commit, use:\n"
> +N_("and then use:\n"
>  "\n"
> -"    git reset\n"
> +"    git cherry-pick --continue\n"
>  "\n"
> -"Then \"git cherry-pick --continue\" will resume cherry-picking\n"
> -"the remaining commits.\n");
> +"to resume cherry-picking the remaining commits.\n"
> +"If you wish to skip this commit, use:\n"
> +"\n"
> +"    git cherry-pick --skip\n"
> +"\n");
>  
>  static const char *color_status_slots[] = {
>  	[WT_STATUS_HEADER]	  = "header",
> diff --git a/sequencer.c b/sequencer.c
> index f586e677d3..e889427eef 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2654,8 +2654,8 @@ static int create_seq_dir(void)
>  {
>  	if (file_exists(git_path_seq_dir())) {
>  		error(_("a cherry-pick or revert is already in progress"));
> -		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
> -		advise(_("or  \"git revert (--continue | --quit | --abort)\""));
> +		advise(_("try \"git cherry-pick (--continue | --skip | --quit | --abort)\""));
> +		advise(_("or  \"git revert (--continue | --skip | --quit | --abort)\""));

If the user has already committed the conflict resolution then we don't
want to recommend --skip as there is nothing to skip.

Best Wishes

Phillip

>  		return -1;
>  	} else if (mkdir(git_path_seq_dir(), 0777) < 0)
>  		return error_errno(_("could not create sequencer directory '%s'"),
> 

