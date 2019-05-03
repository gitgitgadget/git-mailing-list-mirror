Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6540F1F453
	for <e@80x24.org>; Fri,  3 May 2019 19:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfECTMq (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 15:12:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52110 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfECTMg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 15:12:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id t76so8338336wmt.1
        for <git@vger.kernel.org>; Fri, 03 May 2019 12:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F8jLTzDofwSTUCaL0sJ2fFMUYQcdSYCwhhJMmT+wmfQ=;
        b=qqwT3j8clL2LfVENVZaiRkkfRxl8AlzPPWCb8nDkX9SD9WqGwZ2UHx2K6kxBM5j8u0
         d8TNz1Wicxu51rTvenXvX7O7d86kSwlptns0U5tvtt9Q8qKrnNjuJLIkRInIjcSoDePd
         YEZPI7Toowyx2vJSFs6p1n3MUpR3Orf4ZNuanO0//esYdvoJJUfIQPtswH10xR6e9D64
         3hMzCz0OSoHSNAeWhUSh4ASSrR7mREfmQ08jXv9UwV5Gmj+b1nLvEpu0ktOCYBo3G3k8
         fG+YdZh4VoIvuXAGIlzm2JG5wdBgQlAvwDWkZzQBs6Oh+JG+EDFFQ3Jg5dAzD+1kQJhr
         8Wzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F8jLTzDofwSTUCaL0sJ2fFMUYQcdSYCwhhJMmT+wmfQ=;
        b=IJbZ2rroIjSO1YixOf9nRRwzyhyNcD4QuLha1FzxMEkBRUqA7myC4Cq5n0ist8dM52
         /jFjwrBHTs7vsAXzgEAprG1YnOevLXc7rlnfl1+SzxmPe4pMWHuvA26LA0J3rR8lI60N
         8MkG98ihkbVz/hVXozuwC6p0A0Aiko5lxsfn7LaQnTFWov5qWW5572DOqRXdn4ymZv3w
         duFDbcubadQPjoDqX76oRAs+w/t30JhVT4NEgExXQfH9SRKkNr9oLu3gaYTgIzZCrR4Z
         DluE4CH6SH+cLepQE4xPh0srZsYBDWbp5HV2YQ33YiRLyo3KYRLwPfIH9M+btbxJ+LbO
         LUzA==
X-Gm-Message-State: APjAAAXX7D1x1r0M//CROqft+EhKFvu4W41gRL6r0r0kOe7rQRJb+Aiy
        e1YCx0fBJfwC8lW4J55djQ8=
X-Google-Smtp-Source: APXvYqzhLBL66NZSYhLpza3rtfhnkpaLXHa/gL3X+sZ6xWULeYtHj9Im1w9VuDDbuNu7vcMXwCr4RA==
X-Received: by 2002:a7b:cb11:: with SMTP id u17mr7947694wmj.144.1556910753700;
        Fri, 03 May 2019 12:12:33 -0700 (PDT)
Received: from esm (ipbcc038b1.dynamic.kabel-deutschland.de. [188.192.56.177])
        by smtp.gmail.com with ESMTPSA id q24sm3322844wmc.18.2019.05.03.12.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 12:12:33 -0700 (PDT)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Fri, 3 May 2019 21:12:31 +0200
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Merge commit diff results are confusing and inconsistent
Message-ID: <20190503191231.GA5426@esm>
References: <CAHd499BEHd79zL76um2oB4YMdScM2icrMXstg1g=xwdBqk43EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd499BEHd79zL76um2oB4YMdScM2icrMXstg1g=xwdBqk43EQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 03, 2019 at 10:55:54AM -0500, Robert Dailey wrote:
> I have a merge commit. HEAD is currently pointing at this merge
> commit. To be exact, HEAD points to master, which points to the merge
> commit. My goal is to diff only the changes in the merge commit (stuff
> committed directly in the merge commit, such as conflict resolutions).

Hold on. Basically, there is no such thing as "committed directly" for a
merge. You only have differences of the commit to its parents. What you
aim for are changes that you cannot find in either preimage - and this
can be observed best with the --cc option. Maybe also interesting would
be -c for showing a comined diff and -m for showing diffs to parents
after one another.

> To start out, I learned about @^@, @^!, and @^-. @^! sounded like what
> I wanted. It gives me this output:
> 
> $ git rev-parse @^!
> 21f5a4b9fee4f12e7793919f65361d2c16f7d240
> ^14bd840c1d591c9dc066ed1aab59b5ec14d502bb
> ^944af379480826764f2f31b67848e2885b95b4a6
> 
> Perfect. This should give me just the diff of 21f5... and exclude
> everything else, right? So I did this:

There shouldn't be "just the diff of <commit>" - you always have to tell
where to diff it too, intrinsically Git does not save patches, but the
whole content, after all.

> 
> $ git diff @^!
> 
> However, I get *all* changes on the branch (second parent) and changes
> in the merge commit itself. Basically it acts as if I used @^-, which
> seems wrong to me. So to test another angle, I used the revisions
> output by rev-parse directly:
> 
> $ git diff 21f5a4b9fee4f12e7793919f65361d2c16f7d240
> ^14bd840c1d591c9dc066ed1aab59b5ec14d502bb
> ^944af379480826764f2f31b67848e2885b95b4a6
> 
> Interestingly, this showed me only the changes in the merge commit
> (21f5a4) and nothing else. Between this command and @^!, I feel the
> two are exactly the same. So why does @^! not work as I expect, but
> explicitly specifying the revisions does? What am I missing here?
> 
> When I use @^! in `git log`, I do only see the merge commit and no
> other commits. So at least log is treating it correctly.

Somebody else might know better why the diff actually produced the
results you were looking for. I admit it is puzzling to me - I would
have expected to error it out on the output of git rev-parse as there
are three items.

Greetings,
Eckhard
