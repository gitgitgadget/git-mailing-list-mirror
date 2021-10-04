Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D32C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 18:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CDC36140D
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 18:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbhJDS7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 14:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbhJDS7f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 14:59:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4475C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 11:57:45 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id bm13so18541800edb.8
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 11:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T7+f9vIlbesWXHol42fqoL2Afi1Bb/GBJ0N9LcAPAbE=;
        b=gK/UbnmHmSgTihwSEK3JQeTnlBaZOwRXCLDTjhJFy9FOTP8OK6j1QL8y+cZrfr93/s
         T7lpkJG/G2E9bl14jaYEfmp4vheKYFa6OZ07S7J6Nr5eG78MBQ9LF5arUJMp4dnz3uRz
         la3n/leLHZOdNHYYyXAWRfl8aMKDJDJ1mHnRgYWEs5CyVtyX9Cdm1JavgaoigCPBbGBd
         9u8QjsQixD6KLpC5PSHjBYdO+UGdwS2TvFHfa0WQqWOlgAz9keTf3pL2R1y7GC/DSlZ4
         0IgQfpqAFOlQqc3GZ8GhO/zsCJ8efVOq5+pBibjO2vMAbMfQtPzP72eQ5lcc8dywUGar
         qriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T7+f9vIlbesWXHol42fqoL2Afi1Bb/GBJ0N9LcAPAbE=;
        b=VeeCwdkTDqYRm5l5PxurVEStB4icKftDGrj4B14gcqyLFqfvbpQQrzL5uPFzOHghA3
         fSWPsQ2Sij8yQUnywOwBdG2+I1Lx2v1YhXMFFCxEfQYVJqmSHuKc+BuZxiFvitvAJX2T
         nRT7OGZETV7oHzcTnHzB/O8Xt0BcIwqzzdagP0gDds7L5CUyEQxKQq9AtjGp2icDe3ko
         cBzu+7ANzYRkp05nuDjJR8br/THC0xFTR2+5rcZmWJUXzFdbYYI5RrjjpDOUjhfsRv1M
         GYuAbuK8hD7j71aTKhk40cygXrANf7uaj6jr6gTBJJ4cqwjde5sbPMFJzysj7HdFRIaE
         9nrA==
X-Gm-Message-State: AOAM531OdxaK5xrqvKBeZW14ugm6kSOnhI0JSujo2IBjDi3IeLNgnY85
        Zk/99R7Jivvi9B3FjSoRaLg=
X-Google-Smtp-Source: ABdhPJzhOwgO81v8IudxY80qclbz970c0fztJCtIeKc+E2rjP1xCil/z11HTbAH2aTpQ6xgkxN6TcQ==
X-Received: by 2002:a17:906:2441:: with SMTP id a1mr19050046ejb.414.1633373864322;
        Mon, 04 Oct 2021 11:57:44 -0700 (PDT)
Received: from gmail.com (178.115.74.220.wireless.dyn.drei.com. [178.115.74.220])
        by smtp.gmail.com with ESMTPSA id g2sm7543534edp.74.2021.10.04.11.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:57:43 -0700 (PDT)
Date:   Mon, 4 Oct 2021 20:57:41 +0200
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] Documentation/git-status: document porcelain status
 T (typechange)
Message-ID: <20211004185741.rktidu2ptn4v5kll@gmail.com>
References: <20211002213046.725892-1-aclopte@gmail.com>
 <20211002213046.725892-2-aclopte@gmail.com>
 <CABPp-BFqJi0q0844NKfU8K5HRpAJ7yP2OkyBUiFQSAw-ZjNoyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BFqJi0q0844NKfU8K5HRpAJ7yP2OkyBUiFQSAw-ZjNoyw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review, I'll send v2 which addresses comments and makes some
minor hanges to the commit messages.

On Sat, Oct 02, 2021 at 04:29:52PM -0700, Elijah Newren wrote:
> > A porcelain status containing C (copied) is impossible because "git
> > status" does not detect copies, only renames.
> 
> This is no true (since ~2018); here's an example:

Ah my bad. Turns out skimming git-status(1) was not enough.  I added patch
4/4 to make that easier (or at least document that it *is* possible).

> 
>     $ cp -a README.md README-copy
>     $ echo garbage >>README.md
>     $ git add README-copy README.md
>     $ git -c status.renames=copy status --porcelain
>     C  README.md -> README-copy
>     M  README.md
> 
> You can also use diff.renames instead of status.renames, since the
> latter defaults to the former.  Note that you do need to both modify
> and stage README.md in the example above to see the copy status.

Wow yeah, this is quite a special case.

> 
> > I was going to delete
> > mentions of C from git-status.txt because it keeps confusing users [2]
> > but a discussion from 2014 suggests that "git status" should re-learn
> > to detect copies, which was disabled in 2005 for (obsolete) performance
> > reasons [3].
> 
> That thread you refer to suggests it was turned off because copy
> detection meant the equivalent of find-copies-harder, and that thread
> also provided numbers showing find-copies-harder would still be very
> painful performance-wise.  Perhaps the "obsolete performance reasons"
> was meant to imply that basic copy detection is cheaper since it does
> something different today than what status's copy detection did back
> then, but summarizing this as "obsolete performance reasons" feels
> misleading to me.

Right, I should have acknowledged the change to copy detection.

> 
> Links to lore.kernel.org would be much preferred to marc.info links;
> here that would be
> https://lore.kernel.org/git/20141202200910.GB23461@peff.net/.
> 
> The lore.kernel.org links provide an interface to easily search for
> other mailing list messages, and use the Message-ID in the URL which
> makes it easier for people to find the message in other locations,
> etc.

got it

> 
> >  [ D]        R    renamed in work tree
> >  [ D]        C    copied in work tree
> 
> This wasn't something you added; it appears these two came from commit
> 176ea74793 ("wt-status.c: handle worktree renames", 2017-12-27).
> However, I don't think the 'D' part of these examples is possible.  If
> a file is deleted in the index relative to HEAD (what the 'D' means),
> then comparing the index to the worktree means the file didn't even
> exist in the index.  Thus no delete pair for that file will be passed
> to diffcore-rename, and without a delete pair for some file, there is
> nothing for the add pairs to be combined with to create a rename or
> copy pair.  So these lines are misleading and should only have a space
> in the first column rather than either a space or 'D'.
> 
> That said, of course, since this wasn't caused by your patch, you are
> under no obligation to fix.  It would go nicely with your series,
> though.  Would you like to add another patch to your series to fix
> that, or would you rather that I contributed such a patch separately?

Ok I've added patch 1/4
