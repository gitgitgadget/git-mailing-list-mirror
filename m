Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 171961F404
	for <e@80x24.org>; Sat, 23 Dec 2017 21:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbdLWVBq (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 16:01:46 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:42492 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbdLWVBp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 16:01:45 -0500
Received: by mail-it0-f53.google.com with SMTP id p139so17678703itb.1
        for <git@vger.kernel.org>; Sat, 23 Dec 2017 13:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xjPcAa8E6InGmXP2EkD2PjkwQABghTmaRu0uTxa/eMs=;
        b=aZudjdrUFoGNBS7sH8CYyA+8D1c+GkL+KEwGLwkxXj0XiDtC4xUl61r8bZ2rQwnAis
         hqwA/18XX6GPOyibxW0ZOJhreHzDLwgLzAx9YRLfaeTHL/o4CP7YCNVX2XzjzSVgUsAT
         JLgvc9XMyEw7u1SuAI/DbGXDQun4u88RGrQ5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xjPcAa8E6InGmXP2EkD2PjkwQABghTmaRu0uTxa/eMs=;
        b=hF9D4Pr5Xc1QfhhgvoEM3LNEjueRH3wuIWimzNe+cJNE9h5e3n6K8HhhZW3QrDvNg5
         VN9j2gios91otP2meYBtU8Uv+ctlSEt9ofRXhDqya2asBJWSkjwH+vVj2lYKqLcm6SrT
         N1cIrnf8FOQPuzaTPmBTQawpUWTKaeS7oKFDdtEXV9aEm7wuqZSz3JENZ+f5XwBO5QN1
         ZRb+EwaTxomxypvzMsaobiLjodNcacDq9mB3XVeZoGKR+vbyzooDwFx5K3yXknBuGqrR
         T8wGG6gQpLudz8rrOOgQbqfrOvxCVYwW35/Jkm4qV9oo5vls5l2As1/SjSriW2dn08lk
         B0+g==
X-Gm-Message-State: AKGB3mLv6bCk+QLSGpfawkfhyveihCzvAe+GlVYfzW8mrYc47dR0hRD4
        PZtJgpl5jYuDZ/5QyKohcbIl+A==
X-Google-Smtp-Source: ACJfBoubV0VMuM6Uzzns6MZ44QjyCUFYoShXYHkVR5jDTFTCy1hL9KCBKMZNLhr1RpSGBE4i7isBUg==
X-Received: by 10.36.211.4 with SMTP id n4mr24384544itg.88.1514062904927;
        Sat, 23 Dec 2017 13:01:44 -0800 (PST)
Received: from hpz.ecbaldwin.net (c-73-14-102-153.hsd1.co.comcast.net. [73.14.102.153])
        by smtp.gmail.com with ESMTPSA id f2sm4376266ioi.62.2017.12.23.13.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Dec 2017 13:01:44 -0800 (PST)
Date:   Sat, 23 Dec 2017 14:01:42 -0700
From:   Carl Baldwin <carl@ecbaldwin.net>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20171223210141.GA24715@hpz.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <877etds220.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877etds220.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 23, 2017 at 07:59:35PM +0100, Ævar Arnfjörð Bjarmason wrote:
> I think this is a worthwhile thing to implement, there are certainly
> use-cases where you'd like to have your cake & eat it too as it were,
> i.e. have a nice rebased history in "git log", but also have the "raw"
> history for all the reasons the fossil people like to talk about, or for
> some compliance reasons.

Thank you kindly for your reply. I do think we can have the cake and eat
it too in this case. At a high level, what you describe above is what
I'm after. I'm sorry if I left something out or was unclear. I hoped to
keep my original post brief. Maybe it was too brief to be useful.
However, I'd like to follow up and be understood.

> But I don't see why you think this needs a new "replaces" parent pointer
> orthagonal to parent pointers, i.e. something that would need to be a
> new field in the commit object (I may have misread the proposal, it's
> not heavy on technical details).

Just to clarify, I am proposing a new "replaces" pointer in the commit
object. Imagine starting with rebase exactly as it works today. This new
field would be inserted into any new commit created by a rebase command
to reference the original commit on which it was based. Though, I'm not
sure if it would be better to change the behavior of the existing rebase
command, provide a switch or config option to turn it on, or provide a
new command entirely (e.g. git replay or git replace) to avoid
compatibility issues with the existing rebase.

I imagine that a "git commit --amend" would also insert a "replaces"
reference to the original commit but I failed to mention that in my
original post. The amend use case is similar to adding a fixup commit
and then doing a squash in interactive mode.

> Consider a merge use case like this:
> 
>           A---B---C topic
>          /         \
>     D---E---F---G---H master

This is a bit different than the use cases that I've had in mind. You
show that the topic has already merged to master. I have imagined this
proposal being useful before the topic becomes a part of the master
branch. I'm thinking in the context of something like a github pull
request under active development and review or a gerrit review. So, at
this point, we still look like this:

          A---B---C topic
         /
    D---E---F---G

> Here we worked on a topic with commits A,B & C, maybe we regret not
> squashing B into A, but it gives us the "raw" history. Instead we might
> rebase it like this:
> 
>           A+B---C topic
>          /
>     G---H master

Since H already merged the topic. I'm not sure what the A+B and C
commits are doing.

At the point where I have C and G above, let's say I regret not having
squashed A and B as you suggested. My proposal would end up as I draw
below where the primes are the new versions of the commits (A' is A+B).
Bare with me, I'm not sure the best way to draw this in ascii. It has
that orthogoal dimension that makes the ascii drawings a little more
complex: (I left out the parent of A' which is still E)

       A--B---C
        \ |    \                    <- "replaces" rather than "parent"
         -A'----C' topic
         /
    D---E---F---G master

We can continue by actually changing the base. All of these commits are
kept, I just drop them from the drawings to avoid getting too complex.

                A'--C'
                 \   \              <- "replaces" rather than "parent"
                  A"--C" topic
                 /
    D---E---F---G master

Normal git log operations would ignore them by default. When finally
merging to master, it ends up very simple (by default) but the history
is still there to support archealogic operations.

    D---E---F---G---A"--C" master

> Now we can push "topic" to master, but as you've noted this loses the
> raw history, but now consider doing this instead:
> 
>           A---B---C   A2+B2---C2 topic
>          /         \ /
>     D---E---F---G---G master

There are two Gs in this drawing. Should the second be H? Sorry, I'm
just trying to understanding the use case you're describing and I don't
understand it yet which makes it difficult to comment on the rest of
your reply.

> I.e. you could have started working on commit A/B/C, now you "git
> replace" them (which would be some fancy rebase alias), and what it'll
> do is create a merge commit that entirely resolves the conflict so that
> hte tree is equivalent to what "master" was already at. Then you rewrite
> them and re-apply them on top.
> 
> If you run "git log" it will already ignore A,B,C unless you specify
> --full-history, so git already knows to ignore these sort of side
> histories that result in no changes on the branch they got merged
> into. I don't know about bisect, but if it's not doing something similar
> already it would be easy to make it do so.

I haven't had the need to use --full-history much. Let me see if I can
play around with it to see if I can figure out how to use it in a way
that gives me what I'm after.

> You could even add a new field to the commit object of A2+B2 & C2 which
> would be one or more of "replaces <sha1 of A/B/C>", commit objects
> support adding arbitrary new fields without anything breaking.
> 
> But most importantly, while I think this gives you the same things from
> a UX level, it doesn't need any changes to fetch, push, gc or whatever,
> since it's all stuff we support today, someone just needs to hack
> "rebase" to create this sort of no-op merge commit to take advantage of
> it.

Avoiding changes would be very nice. I'm not convinced yet that it can
be done but maybe when I understand your counter proposal, it will
become clearer.

Thank you,
Carl Baldwin
