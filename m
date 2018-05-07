Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A281E200B9
	for <e@80x24.org>; Mon,  7 May 2018 18:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbeEGSf5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 14:35:57 -0400
Received: from mail-yb0-f170.google.com ([209.85.213.170]:45161 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeEGSf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 14:35:57 -0400
Received: by mail-yb0-f170.google.com with SMTP id r13-v6so10263169ybm.12
        for <git@vger.kernel.org>; Mon, 07 May 2018 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=442yO6Mteqx51vWA5Vqs07+maNV/T2CRaGPljTLwI8M=;
        b=cSOiazonVs7Vs/Z+dO9HxVwaaD1odFKer0FQx1gbLyxplZpqADbNCTRaQWfSBvyH9i
         N+cLQnPiPar7rVvW8IdFSM/lbmG2gfdnvyOl7wwLZF9AM2qHao0wFzQwpdFpgM38CgAB
         h1hjYBBP8oTe3SNQ4U7v6XNoSRiaGDI8p33095RL1X1OvciNiGuDQksjh4JdEaxkQLdg
         paQ+AeHdnG4YlACNo5+8v5URI6AkK+6f3Kox/y0ffagzdKNhPH6Npef8xY8Menx2ay8R
         t8IMd0NkRFxChO4Inv70FS7gcpSGPkzWSuChjLXCzFv8kSOtrSeKsPqIUd7Ch0RQFC3O
         064A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=442yO6Mteqx51vWA5Vqs07+maNV/T2CRaGPljTLwI8M=;
        b=HZK7qTGt08sS2Zy5HUBIvp19Nnz574tzeUq/P7ZujBWKhhYiQNvWiGEET8dRjzmsAU
         qNmkqEsBLKmDV06XTq9+tkxArZkHeDJzPNxO3A7DFCsOhNAfEsCBl+eqdZgdJqW7CZcH
         oNSdd2LU4xug1YHxt9FyPxE6ZEbAgwkfbogv2pvmKMZ9VatlkBc6pJ6o0Wa1stDtDaXo
         miBj8ANKy/cQUWzOp866rr95Zrfg+N3d2aAavlElaNT0EBADTDUC+ZftWYLwiDE9IBWk
         oaROWveHc6ipHclrhivSYsU/91N850ruJ1a9gyOjPyFMZOCOhUZ8cI8VxZp02ZDOJsG0
         x2AA==
X-Gm-Message-State: ALKqPwc1JPv/6Zp3XHyhFRTZ8X2eTVjsbWDC7hGp7+G2UycSBOnpgUkO
        kLBsjYNQnmO1sjXuvhC2s+80T1FO2Als550aJ3Xyvw==
X-Google-Smtp-Source: AB8JxZqCFEY7gosVntJH6WEGeZbyVYlLmnSp35TfwXgfXrzXtES7sXWzkmKY0kx+0Sk40/A7zEBzRRA8pbApyht1ouA=
X-Received: by 2002:a25:6910:: with SMTP id e16-v6mr4587224ybc.247.1525718155980;
 Mon, 07 May 2018 11:35:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 7 May 2018 11:35:55 -0700 (PDT)
In-Reply-To: <CAOZc8M9sESwyMQvCq5RpfD=-RYAxQRZ-UxoRBdESriD92xxZwA@mail.gmail.com>
References: <917621a4-b46a-95aa-dccc-905c0cd32b1d@gmail.com> <CAOZc8M9sESwyMQvCq5RpfD=-RYAxQRZ-UxoRBdESriD92xxZwA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 7 May 2018 11:35:55 -0700
Message-ID: <CAGZ79kZU-LsQqYxUeFzxk+6wpmUY0rKpWBa4Us+n9c60JE-frg@mail.gmail.com>
Subject: Re: [GSoC] Yet another blog series about the GSoC
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Git List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratik,

On Sat, May 5, 2018 at 5:24 AM, Pratik Karki <predatoramigo@gmail.com> wrote:
> On Sat, May 5, 2018 at 5:11 PM, Alban Gruin <alban.gruin@gmail.com> wrote:
>> Hi everybody,
>>
>> as my fellow students, I started a blog series about my GSoC project[1].
>> First, I wanted to post them directly on the mailing list, but a blog
>> allows me to edit the content easily if needed.
>>
>> Any feedback is welcome!
>>
>> [1] https://blog.pa1ch.fr/posts/2018/05/05/en/gsoc2018-week-1.html
>>
>> Cheers,
>> Alban Gruin

Thanks for blogging about GSoC!

> Nice post. Great job, Alban.
> Just a little typo I found out there: hazardous -> hasardous.

I would think hazardous is correct, both in British as well as
American English, I cannot speak for more.

Thanks!
Stefan
