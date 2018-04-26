Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2076B1F424
	for <e@80x24.org>; Thu, 26 Apr 2018 21:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755818AbeDZVqy (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 17:46:54 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:50176 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754479AbeDZVqx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 17:46:53 -0400
Received: by mail-wm0-f44.google.com with SMTP id t11so286955wmt.0
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 14:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B/8bjoIbUf6pblm6jrG5X6Vnre94Ev6MYXqU1GoHnDM=;
        b=HXxcNF+q2OfjW27QkQW6qHt+J9j4tM2fy6EwtCpQMwIrCZJK99Kbzyf916Z3tNU9tc
         IivC4f/WoHByi3Lm+OpQku4jzrkqiu/f5VspQqQ2RrMZh27cwo31Vo1n2OSczu3tx+VB
         t3ht+T98WIpfwvToInt65jQhd+5aXeNWATv+oMjD4iyBby8/17BnBo4kIA7LdjzPezHg
         nF0/W9iMbY5FSVWtKbcMGQyJOVLk2aWRPG/HWpiR2+MvqEl/jOFm14/R4kXicHUNrYQY
         enUj1zTAQR06RamhxpM7zwKh4ieFDd7KxyUg14iE90yoXWr7vMbRp0vH8u+iLMGRU6PQ
         zHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B/8bjoIbUf6pblm6jrG5X6Vnre94Ev6MYXqU1GoHnDM=;
        b=gZO0rdykWKndaUOspy95SRvGtR3f6RKfhgr4eFw/4kClQHbu9F8w4iuXKsgAX9hVgb
         8sAD8rRrUg9/qpfidHgbVr7VKr1dSOjWh+oIJ8CNIJDe61syX9n4ybZr/lyWAAuhrG9E
         Le83VRYhwCdXJqjEshf5GrCSb6vCe0kHIWyR+mJKc9zUUAvwiMSH+o+ohv69VVn8zitz
         FQ+i3Wjy9imeXlRKMLQmqCsN/PkPaklIU3zfcBlIJkWYcZRKYrF7qhvbuFHGsarAhJqx
         V1verZH/3oxFpgaNOUhzDGstr72LEnWJgccsu7VNAVqZ65JaoIzjcY7SvPeZrssfgkk6
         z4sw==
X-Gm-Message-State: ALQs6tAl4ZsBsdlyrV0ofvwoL9GoLXI8uofFfWNAdGlmhR30KUMKt1Im
        0OvQ9pJP4R0UhY/cAaNAKQnujkNqJ/TNEA8hpMk=
X-Google-Smtp-Source: AB8JxZrOrw4el6FRjzOy9ubCq8OZKQbCNM9R48H8GPmyhbAMGPD39aAX7KtT+ugiwHreCZADNqH+0fJ4Z7NYewp3zcw=
X-Received: by 2002:a50:cd45:: with SMTP id d5-v6mr253864edj.118.1524779212589;
 Thu, 26 Apr 2018 14:46:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Thu, 26 Apr 2018 14:46:32 -0700 (PDT)
In-Reply-To: <CAGZ79kZA_R-5bA6mPdoHkVW-C21pNn_0x6FayhuuXqnOTrmjWw@mail.gmail.com>
References: <1524739599.20251.17.camel@klsmartin.com> <CAGZ79kZA_R-5bA6mPdoHkVW-C21pNn_0x6FayhuuXqnOTrmjWw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 26 Apr 2018 14:46:32 -0700
Message-ID: <CA+P7+xrUwq0G2YySC3SLKqyihhPnFPCiQnQpoVVa89+=W9O9+w@mail.gmail.com>
Subject: Re: git merge banch w/ different submodule revision
To:     Stefan Beller <sbeller@google.com>
Cc:     "Middelschulte, Leif" <Leif.Middelschulte@klsmartin.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 10:56 AM, Stefan Beller <sbeller@google.com> wrote:
> We often treating a submodule as a file from the superproject, but not always.
> And in case of a merge, git seems to be a bit smarter than treating it
> as a textfile
> with two different lines.

Sure, but a submodule is checked out "at a commit", so if two branches
of history are merged, and they conflict over which place the
submodule is at.... shouldn't that produce a conflict??

I mean, how is the merge algorithm supposed to know which is right?
The patch you linked appears to be able to resolve it to the one which
contains both commits.. but that may not actually be true since you
can rewind submodules since they're *pointers* to commits, not commits
themselves.

I'm not against that as a possible strategy to merge submodules, but
it seems like not necessarily something you would always want...

Thanks,
Jake
