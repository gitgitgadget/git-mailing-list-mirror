Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 697901F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 18:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfJUSfZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 14:35:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43535 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfJUSfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 14:35:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id l24so3387056pgh.10
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 11:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gKNVpGfDraDeObTF5LQpWYMeQHWVeOtzVwLp1PKI8ag=;
        b=eNwKhfyvgD+RHpFX65lBx5ggnJXHk9uzzmKHUB0y+k0guQphU2F+5PmG5uKnpl7Esz
         TjYm8vnc8t/oaAyI35pNBFAdF7dvLYW23O/6PjqTf/gDLvycblKVZEvfq53pN9ervg64
         mn89nnJ9K3mkADxnV0m3DsD2uQOjMDm0CebfzKSvdJym0doWjoystFpIcXffLOY8H5eD
         vcoK6ICatp0F52oDjHbyZVsodwk7rmrQC0ixsQ99cYFHG+J0nxaBUWonrgnSXXcRXsYA
         0katdvr855xB/GdFQX0/ZwvGrb8J0pDmPc4ue9fM2IyBkx1ndO7y49AjAY2qBMRI2T/E
         0faA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gKNVpGfDraDeObTF5LQpWYMeQHWVeOtzVwLp1PKI8ag=;
        b=mwoxMy59fU1HGT1pp9S0bo8HKPrt3Cb+jQIjnuGpp0l3Lfm9Uib/Opqr9prvlVdHI/
         dUdj1wzdSrOMk2sN46stsql3/ukZLcx8DJt3uVSF1tXe3m51bKaUXqbB3ZmqcJWa5VYa
         JuxRo2RO1/2ZTltbOa5EgOfRu+eqlPzhkctBHj92E4kuHNIBgsOJDPY8Y4uGe5+zQcln
         Y3M1jw/Od6yGJOHeSYSaSlLEIpcl5/sLCa/l0UeHkK1LEDOydj5du2/FZN+I1RzDkAa9
         3bBzjyKDPnKFmNx3vv5GiPlozI5dtpG8ox8sRf4rJLvAboIZmdEoMDY+wsjhYMyIDEXE
         zZ8A==
X-Gm-Message-State: APjAAAXFPtnbB2r0UoUtDwgJQfFwSnVq+oi+eFyHzLQXursyZYmz43rr
        02Q1fvu1+Bv2GaNw2YWiaP1djg==
X-Google-Smtp-Source: APXvYqw45sysZ9MIMvSS6EVy6NwGKiLwuyaiU3hWwiYZgV9CQqvv7UzH7plyCrZU2q8dp0in2y6JFA==
X-Received: by 2002:a17:90a:ba86:: with SMTP id t6mr31721152pjr.56.1571682923885;
        Mon, 21 Oct 2019 11:35:23 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id p189sm17229180pfp.163.2019.10.21.11.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 11:35:23 -0700 (PDT)
Date:   Mon, 21 Oct 2019 11:35:19 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     "Miriam R." <mirucam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Outreachy] First contribution
Message-ID: <20191021183519.GA139951@google.com>
References: <CAN7CjDCacSKzN8fXgUe4ejNqM+AAe1o7NaDaFgM5WcYYV0bQ9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN7CjDCacSKzN8fXgUe4ejNqM+AAe1o7NaDaFgM5WcYYV0bQ9g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 12:39:16PM +0200, Miriam R. wrote:
> Dear Git developers,
> I’m an Outreachy applicant, I would like to make my contribution to
> apply to this Outreachy internship period.

Welcome, Miriam! Good to hear from you.

> 
> I have found this issue tagged as open and goodfirstissue:
> https://github.com/gitgitgadget/git/issues/230
> 
> But there is a PR from 4 months ago:
> https://github.com/gitgitgadget/git/pull/271  and I don't know how to
> find out if a patch including that change already exists or if it
> makes sense to do it.

GitGitGadget exists to repackage PRs (which Git project doesn't use)
into emailed patches (which Git project does use) when the author writes
/submit on the PR comment chain. In that PR I see Johannes asking for a
/submit, but no submit; next I would check if a patch with the same
title came through in the mailing list by searching on the
public-inbox.org mirror:

https://public-inbox.org/git/?q=is_directory+dir_exists

Looks like, no, a patch with those hotwords wasn't mailed. Finally, I
would check the project to see if it's still an issue:

  $ cd my-git-dir/
  $ git grep is_directory

I still see 30 instances of is_directory in the codebase, so looks like
we haven't made this change. :)

> 
> In case this issue is not suitable for my first contribution,  I have
> also found this:
> https://github.com/gitgitgadget/git/issues/379

This is also a fine change if you want to make it.

Good luck, and remember it's fine to ask the mentor for the project you
ultimately want to help on for help, code review in advance, etc.

 - Emily
