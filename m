Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36A621F517
	for <e@80x24.org>; Sun,  3 Jun 2018 11:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751048AbeFCLkw (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 07:40:52 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40499 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeFCLkv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 07:40:51 -0400
Received: by mail-wr0-f196.google.com with SMTP id l41-v6so40346629wre.7
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 04:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6OpPWqEW/xAWStVURq3IFIdSiBO6OpoRWfiCCORfeok=;
        b=GUfo0yEDZ89mQWC1CBWl9ivhrYCvhA+NTuRoH9FFZSZ9Y2aOEQrKj4j2urBx57ND+N
         686+1OnHv7nSgxIpAWCyEl4N1tM0QKerBV1VQulXupqAIGIcwROhhLPqd9JCTlRnU6VY
         g18o/IuJKnxxotmbYkjnNKFUXw+D8m0w+H1P9Nj0W9zyKVD8Ea4Tk++zZWi1ExAnrNEY
         vrslnrC9KNuSbJIzzIDQjStVudAfiPSQlGCrBJ012gX0Fjf68KDYP076yw3tTfcV9NRl
         BS8EdhUQDSNNxU4H/KooB4LVsFHa5O+gK+dLPaYEVpOPct8SznBU50gsbNoAVmZPmuXY
         MeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6OpPWqEW/xAWStVURq3IFIdSiBO6OpoRWfiCCORfeok=;
        b=UiDvQbLceyOkKLQBQuhrSZSTHe/j+7Mjzbd7eFOhjcDGRf0z1HPs4y7pYdfiDX9MR6
         fmSL9Cmfo+hjn1QP4cOhx1tIxt8skhhC4I4J5xXTzBRCVeNSsUaogkeEgN0gXojmrEHx
         6WYm+iKg/laoWBTuRD61cwndfMgC+Cg3OHTz6D2qRWktWOdGrv5+aCd5cGEMT4BhAdAv
         4gToowufGOzCiyLOnmMxBPCAxyop7a4qHap0St1PIDNrYSXsxyvl4rZCHwvKyJndqOuY
         0QSqLtE3a0xsu8aLTQVhSFhet7j0Vy+nWVklhRSZSU3PDw8QUaXbae7FooAisEa2kj9+
         1iqw==
X-Gm-Message-State: ALKqPwcZFwG8lNWMAr1s8R5mDP9dxewg5+7s07GilYe9V068lVsuCtDX
        ycytmkqMRYndDdM7TYLn7La8S8Bu
X-Google-Smtp-Source: ADUXVKKb2bUiGGnt1hhJe6YxlogvvUer5jTcEqpKS6zBapUBhgUaokWiBegKAAbTjsvURN/IGKppRQ==
X-Received: by 2002:adf:824e:: with SMTP id 72-v6mr13864092wrb.127.1528026050085;
        Sun, 03 Jun 2018 04:40:50 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id r6-v6sm49001784wrg.73.2018.06.03.04.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Jun 2018 04:40:48 -0700 (PDT)
Date:   Sun, 3 Jun 2018 12:41:28 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH 3/7] rerere: add some documentation
Message-ID: <20180603114128.GD18193@hank.intra.tgummerer.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
 <20180520211210.1248-4-t.gummerer@gmail.com>
 <xmqqr2m1quja.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr2m1quja.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/24, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > +Conflict normalization
> > +----------------------
> > +
> > +To try and re-do a conflict resolution, even when different merge
> > +strategies are used, 'rerere' computes a conflict ID for each
> > +conflict in the file.
> > +
> > +This is done by discarding the common ancestor version in the
> > +diff3-style, and re-ordering the two sides of the conflict, in
> > +alphabetic order.
> 
> s/discarding.*-style/normalising the conflicted section to 'merge' style/
> 
> The motivation behind the normalization should probably be given
> upfront in the first paragraph.  It is to ensure the recorded
> resolutions can be looked up from the rerere database for
> application, even when branches are merged in different order.  I am
> not sure what you meant by even when different merge stratagies are
> used; I'd drop that if I were writing the paragraph.

What I meant was when different conflict styles are used, and when the
branches are merged in different orders.  But merge strategies is
obviously not a good word for that.  Will rephrase this.

> > +Using this technique a conflict that looks as follows when for example
> > +'master' was merged into a topic branch:
> > +
> > +    <<<<<<< HEAD
> > +    foo
> > +    =======
> > +    bar
> > +    >>>>>>> master
> > +
> > +and the opposite way when the topic branch is merged into 'master':
> > +
> > +    <<<<<<< HEAD
> > +    bar
> > +    =======
> > +    foo
> > +    >>>>>>> topic
> > +
> > +can be recognized as the same conflict, and can automatically be
> > +re-resolved by 'rerere', as the SHA-1 sum of the two conflicts would
> > +be calculated from 'bar<NUL>foo<NUL>' in both cases.
> 
> You earlier talked about normalizing and reordering, but did not
> talk about "concatenate both with NUL in between and hash", so the
> explanation in the last two lines are not quite understandable by
> mere mortals, even though I know which part of the code you are
> referring to.  When you talk about hasing, you may want to make sure
> the readers understand that the branch label on <<< and >>> lines
> are ignored.
> 
> > +If there are multiple conflicts in one file, they are all appended to
> > +one another, both in the 'preimage' file as well as in the conflict
> > +ID.
> 
> In case it was not clear (and I do not think it is to those who only
> read your description and haven't thought things through
> themselves), this concatenation is why the normalization by
> reordering is helpful.  Imagine that a common ancestor had a file
> with a line with string "A" on it (I'll call such a line "line A"
> for brevity in the following) in its early part, and line X in its
> late part.  And then you fork four branches that do these things:
> 
>     - AB: changes A to B
>     - AC: changes A to C
>     - XY: changes X to Y
>     - XZ: changes X to Z
> 
> Now, forking a branch ABAC off of branch AB and then merging AC into
> it, and forking a branch ACAB off of branch AC and then merging AB
> into it, would yield the conflict in a different order.  The former
> would say "A became B or C, what now?" while the latter would say "A
> became C or B, what now?"
> 
> But the act of merging AC into ABAC and resolving the conflict to
> leave line D means that you declare: 
> 
>     After examining what branches AB and AC did, I believe that
>     making line A into line D is the best thing to do that is
>     compatible with what AB and AC wanted to do.
> 
> So the conflict we would see when merging AB into ACAB should be
> resolved the same way---it is the resolution that is in line with
> that declaration.
> 
> Imagine that similarly you had previously forked branch XYXZ from
> XY, merged XZ into it, and resolved "X became Y or Z" into "X became
> W".
> 
> Now, if you forked a branch ABXY from AB and then merged XY, then
> ABXY would have line B in its early part and line Y in its later
> part.  Such a merge would be quite clean.  We can construct
> 4 combinations using these four branches ((AB, AC) x (XY, XZ)).
> 
> Merging ABXY and ACXZ would make "an early A became B or C, a late X
> became Y or Z" conflict, while merging ACXY and ABXZ would make "an
> early A became C or B, a late X became Y or Z".  We can see there
> are 4 combinations of ("B or C", "C or B") x ("X or Y", "Y or X").
> 
> By sorting, we can give the conflict its canonical name, namely, "an
> early part became B or C, a late part becames X or Y", and whenever
> any of these four patterns appear, we can get to the same conflict
> and resolution that we saw earlier.  Without the sorting, we will
> have to somehow find a previous resolution from combinatorial
> explosion ;-)

Thanks for the in depth explanation!  I'll incorporate this into the
document.

> These days post ec34a8b1 ("Merge branch 'jc/rerere-multi'",
> 2016-05-23), the conflict ID can safely collide, i.e. hash
> collisions that drops completely different conflicts and their
> resolutions into the same .git/rr-cache/$id directory will not
> interfere with proper operation of the system, thanks to that
> rerere-multi topic that allows us to store multiple preimage
> conflicts that happens to share the same conflict ID with their
> corresponding postimage resolutions.
> 
> In theory, we *should* be able to stub out the SHA-1 computation and
> give every conflict the same ID and rerere should still operate
> correctly, even though I haven't tried it yet myself.

I gave this a quick try, and the test suite seems to pass with the
hash computation giving the same ID to all conflicts.
