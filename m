Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44311F731
	for <e@80x24.org>; Tue,  6 Aug 2019 21:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfHFVAW (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 17:00:22 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:36127 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfHFVAV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 17:00:21 -0400
Received: by mail-pf1-f179.google.com with SMTP id r7so42169118pfl.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 14:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DW0HzSJR/Pq2tt9V6wQMZUr93JebXgvSvbB4hVlFKYU=;
        b=EgFKTBgQN5vXhoaAFwlCTF8Z9uY8ts5/ejhBSUpmDtkX75ApMrT+LSW9k9Ng7/agu+
         azxOFktSGpMvnyZtBbTf6gv9qfEcVP2ehPIqrRhOshYnFaFo7Nb4Osn23ta4KO0xjhi0
         I+1e/E/iqxAsZM2fBeo0XeFqfqpzk2HIWhWFVH07CW9LI1dph0T40CWZaD8sKvdfhok9
         9gEq6x6lVlFepTJeBKQa/BNk+JGXt8F6fF6mae2nYGIuldiSkJw4B1gsFgQ4m5hFIGT3
         cynp4KHAto/bhUfj4Bm4ntkyyYsW5o71p7LkyeK+l3xDhCXNUVhxedVOZ2HlrYyzzJUT
         3s4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DW0HzSJR/Pq2tt9V6wQMZUr93JebXgvSvbB4hVlFKYU=;
        b=hXxDrsebW6sEeroM2ccmPHI045fwwP6BKDx4uHxBnrIaHqI6Fptacgp9fz6s/dbief
         SyUFBZ7qwcXbxfR6cGc9fmZWt1R9ztUB7O9aSVc7+GSqfxtLk6CpMrCdMf0yeYsWZSRi
         hVYjv49K9XsAnwvCbEAhtGgK0fSMet88CEd9RNVnLAmi7s3TjlqT6YdxtNbXxhlBGjbh
         z2kKlmtVQ1ZSAXjAbQH01ZsrPTgh8mFoXeDAeLaw7ZBPCYYTskObSLr1M7JT8tCbnm2l
         glikWE3uB3xevLJmEGyqLN6Gv7jPH5wK5mbmykJ9qcHeZFpB40isQJIrRVktg+p4KLf2
         2gYA==
X-Gm-Message-State: APjAAAWNeJOuW/4/Q8dqSo6d+Dn9HI1pF1RMu7dMEsYmnzDKmELZquiW
        hyf4ZLDMoOUNgR4PuSTaMCjfrw==
X-Google-Smtp-Source: APXvYqzWsom63m/tBFEoSez0Q4dmiBVpGVz8VwIK5C6aLj2eCL6oraQqy8niL/6AIkEhtNJt3hEYmg==
X-Received: by 2002:a62:be0c:: with SMTP id l12mr5727229pff.224.1565125220341;
        Tue, 06 Aug 2019 14:00:20 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id d15sm45606846pjc.8.2019.08.06.14.00.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 14:00:19 -0700 (PDT)
Date:   Tue, 6 Aug 2019 14:00:15 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Andrew Ardill <andrew.ardill@gmail.com>, git <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: RFC - Git Developer Blog
Message-ID: <20190806210015.GB196191@google.com>
References: <20190806014935.GA26909@google.com>
 <CAH5451=Qa5BGnoRdvtcmT6mXXK+i8iD7WAkKFfNU4b6J-0bX9g@mail.gmail.com>
 <e97608ed-1900-e2c0-c20d-e73586c1fdd5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e97608ed-1900-e2c0-c20d-e73586c1fdd5@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 06, 2019 at 08:19:15AM -0400, Derrick Stolee wrote:
> On 8/6/2019 12:52 AM, Andrew Ardill wrote:
> > On Tue, 6 Aug 2019 at 11:51, Emily Shaffer <emilyshaffer@google.com> wrote:
> > 
> >> Are folks interested in writing and reviewing this kind of content?
> 
> I am interested in writing and reviewing! Here are some topics I am
> interested in writing:
> 
> * Updates to the commit-graph feature
> * What is a multi-pack-index and what is it for?
> * Git at Scale: What makes a repo big, and how to avoid it?
> * Advanced Git config settings
> 
> Here are some topics I'd be interested in seeing in the wild
> (and was considering writing them myself if I didn't see them elsewhere):
> 
> * Partial clone: what, why, and how?
> * Life cycle of a patch series
> * Crafting perfect patches with interactive add and rebase
Oh, I'd love to write one on interactive add and rebase. Maybe it's
weird to have a favorite Git feature, but mine's add -p :)

Since we're volunteering, my todo list for my personal blog also
contains:

 - How to use bisect
 - How to use Git pathspecs

I also have a couple pre-existing personal blog posts on
nasamuffin.github.io:

 - How to use git format-patch and git send-email for mailing list based
   reviews
 - Overview of Git object types

> 
> It would also be helpful to have a post for every major release
> highlighting new features and giving users examples of how to use them.
> Taylor has been writing these on the GitHub blog [1], but maybe he
> would be interested in writing them for this new venue?
> 
> [1] https://github.blog/2019-06-07-highlights-from-git-2-22/
> 
> > The idea sounds great, and I would be happy to review content - even
> > if it's only for readability and spelling!
> > 
> > In terms of collaborating, I've found the processes over at Git Rev
> > News[0] straightforward and sensible, if you're looking for ideas.
> 
> I agree that the review process there is helpful, and users contributing
> edits via PRs to a feature branch works quite well. I would also suggest
> writing a "request for review" on the mailing list before merging any
> pull requests.
> 
> One goal I think would be important is that this blog is that the posts
> come with some amount of blessing from "the Git Dev Community". That is,
> they should be service-agnostic and focused on helping _all_ Git users.

By this do you mean "not about how to use Git with Github", or "not
about how to use Git for Windows"? I initially read it as the latter but
I think you mean the former, right?

I believe there's a lot of value in the former - lately it seems to me
like the lines are really blurred between which parts are Git and which
parts are Github. It'd be nice to clear up some of that confusion and
writing pieces concerning "vanilla Git".

> That said, I also suggest that the authors can list their professional
> affiliation as some minimum amount of credit to their employers. Something
> as simple as "Author: Derrick Stolee, Microsoft" would go a long way to
> justifying the work it takes to write these on the community blog and not
> a company-owned blog.

Yes, I agree - this seems to have a double win of lending credibility to
the author and giving good optics for the company. Plus, as mentioned
before, crossposting seems like a good fit here.

>  
> Thanks,
> -Stolee
