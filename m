Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 581201F404
	for <e@80x24.org>; Thu, 30 Aug 2018 12:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeH3QUP (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 12:20:15 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:51636 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbeH3QUP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 12:20:15 -0400
Received: by mail-wm0-f43.google.com with SMTP id y2-v6so1772896wma.1
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 05:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qJgMjxURKUhFR/njwsZg3OulI3fx0/g7dKy52alSrIo=;
        b=dtuA5HJ8g1/Si4j0zOgnjz+b8onLvI7IHbeyR1sO6eCJgq+gbercNv7sjwB5lrPOAG
         BuE1MxAiESs76OaQcnpXhPEJyNwBD8CrX7zS7l9LTJPjMy6Yluvo3GkVms5ElcsggwuR
         KxLB/LL7IGD6U5RmPw2UYzk1cD8eG+QDfNf4SP7cNorYdqYgoagQYue8nGoXOd/Bfv8I
         1QlzotCGLKcDbDo6yS+6yNsct84Mhk1kxK8ExTNi1BP1q2uAZgnCGMYoKSNW9JIelcOT
         X5a2868Y6F03bIgpUC6pkGiNHeN7wxoth6tYSlKwnAMnYJYnp60AKqHBTroILrNait/Q
         699g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=qJgMjxURKUhFR/njwsZg3OulI3fx0/g7dKy52alSrIo=;
        b=oLyqtgyIgsXxSd/lXWyAKs6C2f83Jyt79XGYqZDkkPxoKaT4q6AIzZW1Tll78hiyVE
         eOD4xhyHTHuQN9vaK8K3EfFCOZk43Bylo2XEhTQFcjMDR0nQqNx6ENrMjmCoYJbpT3Ca
         gB2z0S4gdwkYzOCC5xUgbgsyTsoSU9OycNv/Hg61lSFB33kcDXfNEVO9m+fscgIU7UsU
         Oys6kHRz2lm3eXC45I0k0qLsUIWWOAJGZZJ+TJl3fwtKZ6FCJkPdgNZkgS9qD2L28OFF
         c4V6i6E9eF34svj+p+z6758RTeN5sRZnNIqgvxVBZyRlB0fmtPMHHjPCauC7JmnihUzq
         2qGg==
X-Gm-Message-State: APzg51CD+nJB6K1bSC48X2LGHJKB80T4P39zUqF0OeXCsqvd6hvcioXs
        0eZtmSuIHaXy9NqAG7fRiW0=
X-Google-Smtp-Source: ANB0VdZUiZnjbH6Mo9fw8x2FwIQbL0nrwkeUt0EVHpaVSKFyv7m/MBSShCDkMPW/3MfEyUDuXMby/Q==
X-Received: by 2002:a1c:9e89:: with SMTP id h131-v6mr1588578wme.13.1535631500888;
        Thu, 30 Aug 2018 05:18:20 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id l12-v6sm8653795wrv.29.2018.08.30.05.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 05:18:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: Git in Outreachy Dec-Mar?
References: <20180828151419.GA17467@sigill.intra.peff.net>
        <8736uxe2pm.fsf@evledraar.gmail.com>
        <20180830031607.GB665@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180830031607.GB665@sigill.intra.peff.net>
Date:   Thu, 30 Aug 2018 14:18:19 +0200
Message-ID: <87sh2wcak4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 30 2018, Jeff King wrote:

> On Wed, Aug 29, 2018 at 03:12:37PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> >   2. To get our landing page and list of projects in order (and also
>> >      micro-projects for applicants). This can probably build on the
>> >      previous round at:
>> >
>> >        https://git.github.io/Outreachy-15/
>> >
>> >      and on the project/microprojects lists for GSoC (which will need
>> >      some updating and culling).
>> [...]
>> I just have a "yes" to the first one of those. Which tells you how much
>> skin I have in the game (and how much you should(n't) listen to me) :)
>
> Yes, if nobody steps up to do 2, then it won't happen. :)
>
> For myself, I don't think I have time to commit to mentoring this round.
> And IMHO the people signing up to mentor should be the ones contributing
> to the project list (since they will ultimately be on the hook for
> working on those projects with the intern).
>
>> Just a question: It seems to me that #1 and #2 is not tied up to the
>> Outreachy process. I agree that finding a qualified intern to work on
>> Git would be a good use of project funds.
>>
>> What's not clear to me is if/how tied up this needs to be to a specific
>> external program such as Outreachy. I.e. do we as a project need to go
>> through that organization, or can that be just one of the ways in which
>> we send out a call for interns?

Thanks!

> It doesn't need to be. As far as I know, the main reasons (from the
> perspective of a project) to do it through Outreachy are:
>
>  - being part of a larger program generates attention and gets the
>    interest of intern candidates (free advertising, if you will)

I was wondering if we couldn't do it through Outreachy *and* also do our
own advertisements / possibly recruit candidates outside of the
Outreachy pool. In that case we'd still get the attention/outreach
benefits, in addition to our own...

>  - Outreachy handles payment, invoicing for external funds, and any
>    legal stuff
>
>  - it's possibly easier to external funding if it's earmarked for a
>    program like Outreachy, since that program provides a framework with
>    particular goals, conditions, oversight, etc.

... but not both of these at least if we selected any a non-Outreachy
candidates. Nice to get a good summary of the pros there.

> I think there's some general value in having a group, too. Because
> there are many interns all participating at the same time, they can
> offer each other support or advice, show off their work to each other
> via blog posts, etc.  And it may be easier for them to communicate
> about their accomplishments and status for future work, since it's
> part of an established program that can easily be explained.

Yup, but just as a clarifying point here wouldn't the participants also
get all the same benefits of this in the case of Outreachy+OurOwnProgram
if we ran OurOwnProgram concurrently to Outreachy?

I.e. I was assuming that once candidates are "handed off" to a project
they're communicating within that project (possibly with other
candidates), and Outreachy is no longer very involved (except maybe for
progress reports / final report, but wouldn't we also do that for a
OurOwnProgram?).

I may have that completely wrong though, which is why I'm asking, which
b.t.w. I'm doing mostly just to get an idea of how what Outreachy's role
is in this exactly, not to strongly advocate for a OurOwnProgram.

> As for reasons _not_ to do it, I don't think the requirements are particularly
> onerous. Mostly it's:
>
>   - it has to happen at a specific time, which might not be convenient
>     for mentors or interns (last year I found it hard to get focused
>     starting in December, with all of the holidays)

Yup.

>   - it naturally limits the candidate pool to under-represented groups
>     (which is the whole point of the program, but if you don't
>     actually care about that, then it's just a complication)

I'm fine with doing selection discrimination of under-represented groups
through such a program. Particularly if, as you mention, there's
earmarked funding for it which otherwise might not be available, so it's
not zero-sum when it comes to a hypothetical alternative of casting a
wider net of our own (and as you mention, that would be more work).

I do think it's unfortunate that the selection criteria for the program
privileges U.S. citizens and U.S. residents above other people,
particularly since they're also accepting worldwide candidates (and
we've had at least one non-American participant that I know about), so
it's not e.g. for U.S. administrative or tax reasons as one might expect
if they only accepted Americans.

I don't think that's some big deal, just something that puts the Git
project as an international cooperation (and one that solicits funds
from donors worldwide) into a slightly odd position, so something we
should keep in mind going forward.

> So IMHO it's easily worth the trouble.
>
>> With GSoC we don't have a choice in the matter, since Google's paying
>> the bills and runs the show, but it sounds like in this case we at least
>> partially do.
>
> I think that the autonomy and level of responsibility for the
> mentors/project is about the same between GSoC and Outreachy. The main
> difference is just the funding model (but again, I suspect we would not
> have too much trouble securing external funding).

Thanks.
