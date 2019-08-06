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
	by dcvr.yhbt.net (Postfix) with ESMTP id E03F01F731
	for <e@80x24.org>; Tue,  6 Aug 2019 20:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfHFUtc (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 16:49:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32812 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfHFUtb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 16:49:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so1400372pgn.0
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 13:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9twzaC/PWw42FG1pwqCPypcHbaizB1zN2yNcY+DHmJk=;
        b=Bx7do2/3cGIakZhBn538HMrUcqE06IvF161WIoovdip1bljERxaT2yff0DxqiFfvi5
         hms8z+WU/oVslNdG/f++u17pBXMKrDbhGLCyXEcSQX8H8PrRWOD/+WDDk7xEsrSn+BXr
         icOh0xrYWW09hV8eblLLUfyF65QG8FIZ/y2rc3ZJF3oXuufnZc8NmPBNxILv1biJvGbm
         iKT+q6wX9owiUNRukbDfY+foH1kvmE1/23rDsWbnbOw2y0KjNx6CjOrUHJZIi6S+VyFK
         wmwJBcx8NWr0VIckmkTOwlQE6jl4lRVqCdK1iGbIcNEMW6x5fTfLdfJSLscYWp7vA8js
         wYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9twzaC/PWw42FG1pwqCPypcHbaizB1zN2yNcY+DHmJk=;
        b=QqqmECZ1D4bHx9zo9rCnvGGj7GWMDFOvpPZ6sPMIF9VMViKDsKlq4Z5ryXGAo2jfZB
         8Ht5wRwwhS6OwpXgOCUlFzSA0pDc8t+jG0IgHDrwpRf4Ju7KX0sOwkknPxaER3dAPHTo
         zW36r6P9UbHTsRaLR03j532V9C/6q/admoKUMBCNpdSuj/Sozuggp8ql+t5o7lCQhIBX
         Tpa/ftb9+QGOdowPbvk6gqCDIQTyKfCMfiHCNTouO6kI1Lj+kaayiXgRJzLwYBHetDK2
         vuSKzpd0UKf5f7UzdD9n1nINopUjqcUIpvmC6PVQ86d60DdJxkwYLV/eriEtvJjyVMlX
         Hisg==
X-Gm-Message-State: APjAAAWWrMCW4SLAQGVrlNUuGturFUbmqTBD3JVfiM98LZURAzO9buOK
        iIsxBMooupxKhKJzxNpuBAN3uT1Z8gcEew==
X-Google-Smtp-Source: APXvYqyxR7FrozHPVR3gsmMQhKPSPJiANpe+ht/wKiWq5oIAoKWyRpJj2Tj3fPaKbUDZjGkUqDCP+g==
X-Received: by 2002:a17:90a:db44:: with SMTP id u4mr5035973pjx.52.1565124570304;
        Tue, 06 Aug 2019 13:49:30 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id a16sm97127936pfd.68.2019.08.06.13.49.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 13:49:29 -0700 (PDT)
Date:   Tue, 6 Aug 2019 13:49:25 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: RFC - Git Developer Blog
Message-ID: <20190806204925.GA196191@google.com>
References: <20190806014935.GA26909@google.com>
 <20190806132052.GB18442@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806132052.GB18442@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 06, 2019 at 09:20:52AM -0400, Jeff King wrote:
> On Mon, Aug 05, 2019 at 06:49:35PM -0700, Emily Shaffer wrote:
> 
> > Are folks interested in writing and reviewing this kind of content? Any
> > ideas for where we may be able to host (maybe git-scm)?
> 
> I think it would make sense to have blog.git-scm.com (and .org) with
> this content. I'd be happy to deal with the technical side of setting
> the name up. I think it should live in a different repository than the
> main site, though (which is an overly-messy Rails app).

I'd certainly be happy with that setup if others agree, although the
incorporation with Git Rev News sounds interesting too (I'll reply to
that post also).

> 
> There actually used to be a blog section on the site. It discussed
> various high-level concepts that hadn't made it into the Pro Git book
> (whose content makes up most of the site). But as most of those were
> eventually added to the book, the blog posts became staler versions of
> the same content, and we dropped them.
> 
> Just to play devil's advocate for a moment: another venue for topics
> like these:
> 
> >  - Using `git worktree` Effectively
> >  - Overview of the Git Object Store
> >  - Finding Regressions with `git bisect`
> >  - Life of a Git Remote Request
> 
> might be to actually add them to the book (which started as a
> single-author publication, but is CC-licensed and has taken lots of
> community content over the years). The advantage there is that the book
> content would always represent the most up-to-date coverage of those
> topics, whereas blog posts sometimes grow stale over the years as nobody
> is interested in updating them.

To advocate your advocate, does the book content really stay so
up-to-date? (I have no experience with that repo, so I really don't
know.) An advantage of blog posts is that they come with a date and so
users can judge for themselves how stale it is or is not. In fact I
think it'd be odd to see reviews to update a blog post that's a few
years old; if the content is so different I'd expect to see a brand new
post and an editor's note on the top of the old one pointing forward, or
at least marking it as obsolete.

If it's a concept that's so specific that it really will stale out
quickly (e.g. exactly how to use git worktree down to the commands
without much context) vs. a higher level concept (how does git worktree
work and conceptually how do you use it) then it probably does belong in
the manpage or book. But I suppose I envision these types of posts doing
the latter, instead. Hmmmmm.

Maybe it's enough to say during review, "This seems like a good
candidate to move to manual/tutorial/git-scm book".

> 
> One downside is that it may be more annoying to try to integrate content
> into the existing structure of the book. Another is that a blog is
> something people subscribe to, so a post may generate attention/interest
> in a topic (but nobody wants to see a feed of book updates!). A prime
> example is something like a highlight of features after a new release,
> which is not book content at all, and just serves to generate attention.
> :)
> 
> So I don't think I'm really seriously suggesting this as an alternative,
> but maybe something to ponder.
> 
> > It could make sense to review contributions like this on the mailing
> > list, so that we get the attention of those who wrote the features
> > that are being covered in the blog posts - are we okay with the
> > additional traffic?
> 
> Additional traffic is fine. I do suspect that blog posts in particular
> would benefit from a more integrated review system like GitHub (or
> similar):
> 
>   - I'd expect there to be a lot of images, and those systems make
>     image diffs easy to see
> 
>   - the formatted output is going to be important to review; a
>     browser-based review system makes it easier to see the formatted
>     output (especially if they're written in markdown)
> 
>   - we're more likely to get/want drive-by fixes like typo corrections,
>     so reducing friction for non-regular contributors is more important
> 
> Obviously you can apply many of the same mailing list vs web review
> arguments that we've already had for writing Git itself (e.g., is
> reviewing formatted output much different than looking at the output of
> a compiled program?). But I think the nature of blog posts pushes it a
> bit further towards web-based review.

I follow, especially re formatted output and images, but I also don't
want to provide too much distance between the ML and these kinds of
posts. I wonder if it makes sense to mandate use of GitGitGadget, and
accept review comments both on the ML and the PR?

> 
> -Peff
