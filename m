Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19D541F403
	for <e@80x24.org>; Fri,  8 Jun 2018 17:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752970AbeFHRPT (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 13:15:19 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:43607 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752680AbeFHRPS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 13:15:18 -0400
Received: by mail-qk0-f172.google.com with SMTP id g126-v6so9182240qke.10
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 10:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=1teenCJQZYDvRcxjxQGSykcTRofZ+k0coNVCR2wIY8g=;
        b=uaGrHWQseThz1KjBFwtZSFh1DFS33NXhVUuq4p3la/PM0FkezTspssdKKdea7c/tuO
         RQxitrYMRANQ34MTrXQHeSAm27BK5TmS7/JZRaWJOLCesJ9fmRy+DaxQrtTequoTDeVu
         WWmHnulZ35EbPtJXyWy0lU9DNB5MFuVQ7PzNBFh+6malW3e0VBsMoN+vPpNXp0ShR/nY
         6OCT9d0N2km+s2XrZnbpHuNCh6VA683VRBeBF2Xs5/S5mSHFdf2lHD5JTKKE+NPNs4mv
         U2OBiFschTfO4ZwXMbAUc6e9+86ZwAsd3wN9LnYeV/0faYzLulwYsTR5nmC/EG1q4rxU
         rcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1teenCJQZYDvRcxjxQGSykcTRofZ+k0coNVCR2wIY8g=;
        b=kyKonhK02FXcy+mT4fz6g39z17z4bEzpNIpqOE27wsIG08XQZd8Ivi48Vusmc9sK95
         uvLHdAZKbv6vdt8x43MEwd73B7lb7AgvyXPuLyF5M1LMMujNvaURWdccDqZfgrAWLv9Q
         bhIEP1BXGUZGrhTiOltjQOmSZKQnuhhUxEL2hZlK2Wd6cEctGgicZYaAZUwgedl2ZUg3
         mLc6kpTbnx6ThYKUkg4t3a/NW+BXF81U4bmofEQZ1o9t5888sH6ucCOMF6E2zZEXSYZ7
         2KA9t0b6fzPkiooo2qtjpyBDXP48DjfVXeca9DmBSxdQtljMY9XYt1oQG3Fk7z10ffPu
         GeEw==
X-Gm-Message-State: APt69E1g6eGtjI0l4M8mKy5zkq71yX6Yd0fSKqTf37PkdVoimS+Nq3xl
        qv7i8JeI8GwMFT1cY08c8LOwTNKH
X-Google-Smtp-Source: ADUXVKLib7uPms40RER61OKhCNzUiqCukJjz+wh0V8BufBlrhDzJL524WEeRIqZx4W1EAIS7xiQSpw==
X-Received: by 2002:ae9:edc6:: with SMTP id c189-v6mr6102847qkg.58.1528478117160;
        Fri, 08 Jun 2018 10:15:17 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:5dc2:24cc:4e85:52e? ([2001:4898:8010:0:46f8:24cc:4e85:52e])
        by smtp.gmail.com with ESMTPSA id m2-v6sm31723112qta.87.2018.06.08.10.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 10:15:16 -0700 (PDT)
Subject: Re: is there a canonical doc about how to deal with whitespace
 issues?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
References: <alpine.LFD.2.21.1806080914520.20892@localhost.localdomain>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b8801d73-71c4-15c8-4b29-8e4edb3faec9@gmail.com>
Date:   Fri, 8 Jun 2018 13:15:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1806080914520.20892@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/8/2018 9:18 AM, Robert P. J. Day wrote:
>    for one of my courses, i wanted to write a section about the various
> techniques for dealing with whitespace issues in git, so i started
> making a list, things like:
>
>    - running "git diff --check"
>    - "git commit --cleanup=" possibilities
>    - config options like core.{eol,safecrlf,autocrlf}
>    - i'm sure there are client-side hooks that can be mentioned
>
> etc, etc.
>
>    has anyone ever written a doc that collects these things in one
> place? if not, i guess i have to write one.
>
> rday
>

I don't know of a doc for whitespace issues, but the contributing guide 
on GitForWindows [1] recommends `git rebase --whitespace=fix`.

Thanks,
-Stolee

[1] 
https://github.com/git-for-windows/git/blob/master/CONTRIBUTING.md#polish-your-commits
