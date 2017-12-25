Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 237851F406
	for <e@80x24.org>; Tue, 26 Dec 2017 00:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750810AbdLYXnl (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 18:43:41 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:34052 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbdLYXnk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 18:43:40 -0500
Received: by mail-it0-f48.google.com with SMTP id m11so24066603iti.1
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 15:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HzZLYNzIyvTJjhyPq/278BJsgKX1e+JwukLuzTkmri0=;
        b=Qx5Qo1yhDY15VuchhTpuddJkW0pMiN6u8+TkTms8h4o40wzYIqnMWQ9q8MIgY1pPC4
         jWUNSxSNL/ZWf++59hyu4ozYeS0WoQ+ogfbUkoLI7K9o/+aPmrnola5DhXo26a2FlSjO
         +XqatH11oJ1J3SQhah/JrjqSHeaen5GUm3iVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HzZLYNzIyvTJjhyPq/278BJsgKX1e+JwukLuzTkmri0=;
        b=kt3nxtBL8W2SEt5CnyVLxaKa6WB08OZ8RvjL6MVoJ0IyNCn1XEweaYWTxyFdq9ukXM
         t8SJ7sHtwKVqbalZF8OEQbmc80GSyJsvwXAlmR6E8NhEjdRbJYMY9JrHZzHjo14rm3Ee
         Y5tonFb7O6oZtwXOpIzTB7kvrJkMlMZSIFEWEtMVEkgoxe73HphJFgiLG+uaAtDw716H
         AoOqrJFWQPT92uiEYz99nBLmiZL0wePcidxUq1pkfBLw4TByOzWvhw2sgLCo3r7zm/NR
         DJMSJMsRU7QSLWVp2oBK2m6FxaxfPKcAT8Y5wgYuG6/WYkRarBVWSYJ7EwsJACeQshOJ
         uU7A==
X-Gm-Message-State: AKGB3mKGMx5hlkLzBoCWA4oILwXrhO/ieGpa31qVqHsyKLPXFiqHY04X
        ByuX/4OrCbSt0xPhNf2HjAr7DA==
X-Google-Smtp-Source: ACJfBovYgmq3O4MAwk54I09duflPmX2zz5vfRkKEp2HSijsNPxXWxUP1xp0AASShpBKlv/PIG4NUMw==
X-Received: by 10.36.22.10 with SMTP id a10mr30894626ita.39.1514245419217;
        Mon, 25 Dec 2017 15:43:39 -0800 (PST)
Received: from hpz.ecbaldwin.net (c-73-14-102-153.hsd1.co.comcast.net. [73.14.102.153])
        by smtp.gmail.com with ESMTPSA id b3sm11423774ioa.44.2017.12.25.15.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Dec 2017 15:43:38 -0800 (PST)
Date:   Mon, 25 Dec 2017 16:43:35 -0700
From:   Carl Baldwin <carl@ecbaldwin.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20171225234334.GB24104@hpz.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <877etds220.fsf@evledraar.gmail.com>
 <20171223210141.GA24715@hpz.ecbaldwin.net>
 <alpine.DEB.2.21.1.1712232353390.406@MININT-6BKU6QN.europe.corp.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1712232353390.406@MININT-6BKU6QN.europe.corp.microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 24, 2017 at 12:01:38AM +0100, Johannes Schindelin wrote:
> Hi Carl,
> 
> On Sat, 23 Dec 2017, Carl Baldwin wrote:
> 
> > I imagine that a "git commit --amend" would also insert a "replaces"
> > reference to the original commit but I failed to mention that in my
> > original post.
> 
> And cherry-pick, too, of course.

This brings up a good point. I do think this can be applied to
cherry-pick, but as someone else pointed out, the name "replaces"
doesn't seem right in the context of a cherry-pick. So, maybe "replaces"
is not the right name. I'm open to suggestions.

It occurs to me now that the reason that I want a separate, orthogonal
history dimension is that a "replaces" reference does not imply that the
referenced commit is pulled in with all of its history like a "parent"
reference does. It isn't creating a merge commit. It means that the
referenced commit is derived from the other one and, at least in the
context of this branch's main history, renders it obsolete. Given this
definition, I think it applies to a cherry-pick.

> Both of these examples hint at a rather huge urge of some users to turn
> this feature off because the referenced commits may very well be
> throw-away commits in their case, making the newly-recorded information
> completely undesired.

I certainly don't want to make it difficult to get rid of throw-away
commits.

The workflows I'm interested in are mostly around iterating on what will
end up looking like a single commit in the final history. I'm imagining
posting a change, (or changes) somewhere to be reviewed by others.
Others submit feedback and I continue iterating given the feedback. If
certain intermediate throw-away commits have only been seen locally by
the author, they could be squashed into a single minimal new update.

I'm diving deeper into these workflows in my reply to Theodore. To avoid
fragmenting my ideas too much, I'll take the details over to that reply.
I hope to finished that soon.

Carl
