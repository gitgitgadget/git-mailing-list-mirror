Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 019092023D
	for <e@80x24.org>; Wed, 17 May 2017 01:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbdEQB5U (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 21:57:20 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:35930 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbdEQB5T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 21:57:19 -0400
Received: by mail-io0-f181.google.com with SMTP id o12so1022783iod.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 18:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/qyQlmwwucL5uoXNoU4LUCftMQOTq7p+67rKg7KKhYk=;
        b=GHCM1F7gOpfSk+BMKOlLgAprOcdCF0vUYIWOZDRZMMVJ8h1cHpnYzfmhJnnrtTwRXS
         a7i0BDAQ7p14DdIgIMgRJAYC8itSjBSWmDtiLEe+fwFC+HEbVRXsdyRy5ditQwHJ/2Qe
         y8z5ajKoukHXYJbN1UYP4BDLcXACVTWfLnksgkrTmo+w+6JMnuSy2keUACpNtzKsPlNB
         N5cvlRjNgP2A3NToEGiVfotB3g5PmWFyuZuLWIyfa9kedu1D6DYOHX3ewXPGg88WMQPu
         3tQcHzyFA7wBzZ5H91mstDLFlVbsBuc3IiBF9FCNQjZZ0to9vZNElw3n35QtFlDhIjBj
         kXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/qyQlmwwucL5uoXNoU4LUCftMQOTq7p+67rKg7KKhYk=;
        b=pQha3ilT4z8wUnUORB+tV7O9KvYH7pc9bYKTJbL4keB0W7A6poYFGPzGAQvKRcEfx7
         2fCN/UAt0BHmybuR7gKrvFN8f48vOxbXuw5toG6C9LbzKmXgUm1C2/euvPMfa60OOgMq
         2oUEJ1Q9EoI/2oI+SOjr0Jjl2e+s+1dpL4VfMSmP4naXGxNqL1rdE8XWOGgsNvxCnMJs
         haeLYC3448DpyWl8wE/rpCLCa3mcwAEPt+KIehbRJjVc62wP3TSMnxMFaz6WZRjewsrF
         wNh8mYfUmqyc147j7YF0dbUR/rwJ9g804rY6jNrNOx0ghtHv4AgZCC6DrqOv9A3caNfl
         zubQ==
X-Gm-Message-State: AODbwcCho2pYqqpTJBS+4/ir9Q5P39N1aCWPC9rRBQauU98AdoSqfR1C
        BKYKm8ToosO7Jar+QO2DZbr1ZFuR83HrymM=
X-Received: by 10.107.201.206 with SMTP id z197mr1051398iof.85.1494986238142;
 Tue, 16 May 2017 18:57:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Tue, 16 May 2017 18:56:37 -0700 (PDT)
In-Reply-To: <20170206182754.qxgzl7546i7u5wnw@sigill.intra.peff.net>
References: <20170202023349.7fopb3a6pc6dkcmd@sigill.intra.peff.net> <20170206182754.qxgzl7546i7u5wnw@sigill.intra.peff.net>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Tue, 16 May 2017 21:56:37 -0400
Message-ID: <CAJZjrdXCYwbH4wtY44UiEQii+r47a-coTwLd0qYzhV3VZwyd1A@mail.gmail.com>
Subject: Re: git-scm.com status report
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 6, 2017 at 1:27 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 02, 2017 at 03:33:50AM +0100, Jeff King wrote:
>
>> We (the Git project) got control of the git-scm.com domain this year. We
>> have never really had an "official" website, but I think a lot of people
>> consider this to be one.
>>
>> This is an overview of the current state, as well as some possible
>> issues and future work.
>
> Thanks everybody, for your responses here and off-list. After my mail
> got posted to HN, I got quite a lot of private responses, including
> offers to sponsor hosting, work on the site, etc. I'm still working my
> way through them, but I wanted to try to respond in aggregate here.
>
> First, a few clarifications:
>
>   - The money for the site wasn't mentioned to me by GitHub at all.  I'm
>     quite sure they would continue to sponsor the site financially if
>     need be. The only reason I didn't promise that is because I hadn't
>     arranged it specifically, and "step 0" seemed like first making sure
>     our costs were reasonable.
>
>   - Spinning the site out of GitHub's Heroku account isn't an urgent or
>     impending change. It came out of a conversation I had with people
>     auditing the GitHub account, where it is clearly a funny historical
>     anomaly. So I suspect we could just stay there indefinitely if need
>     be. But it seems to me like the right thing is to move it out for
>     two reasons:
>
>       1. The site was always intended to serve the Git community, not
>          GitHub, and it has increasingly become a community asset (e.g.,
>          with the transfer of the domain name). The hosting assets
>          should be held by the community, too, to help with things like
>          continuity. If I get hit by a bus, the rest of the Git PLC
>          should have access to the site without having to figure out who
>          owns what.
>
>       2. Right now I can't add any other co-admins to handle operational
>          issues. So the bus factor and load of that part of operating
>          the site can't be spread.
>
> The responses I've gotten fall into a few buckets, I think:
>
>   - Yes, the current hosting cost really is unnecessarily high. Most of
>     this is due to scaling wrong. The main costs are:
>
>       1. Using 2x dynos; these have 1GB of RAM versus 512MB. The site
>          does seem to use about 750MB. I have no idea why that is the
>          case. There's probably some low-hanging fruit in reducing the
>          memory use to keep it below 512MB, but I don't think anybody
>          has dug in there.
>
>       2. The site is scaled by using 3 dynos. It would be simpler and
>          cheaper to stick a CDN in front of it, since the pages change
>          very rarely. That's something I haven't looked into setting up
>          yet.
>
>          The prerequisite to using a CDN is actually making sure the
>          content is deterministic and cacheable. There was a nice PR
>          opened at https://github.com/git/git-scm.com/pull/941 towards
>          that end.
>
>   - It's mostly silly for this to be a Rails app at all. It's a static
>     site which occasionally sucks in and formats new content (like the
>     latest git version, new manpages, etc). The intent here was to make
>     something that would "just run" forever and pick up new versions
>     without human intervention. And that _does_ work, but it also makes
>     things more expensive and complicated than they need to be.
>
>     So a viable alternative is to use some kind of static site
>     generator and have someone (or something) responsible for pulling in
>     the new git versions occasionally.
>
>     A few people have expressed interesting this. There's some
>     preliminary work here:
>
>       https://github.com/git/git-scm.com/pull/941
>
>     and at least GitLab has expressed some interest. So I'll let people
>     coordinate in that PR or a new one what the result should look like.
>     Working patches trump discussion. :)
>
>     I have also talked with the GitHub Pages people, and they think
>     hosting it as a Jekyll page wouldn't be a big deal performance-wise
>     (with the caveat that we'd need to pre-render the asciidoctor bits
>     ourselves, as Jekyll doesn't do asciidoc). So that's a viable option
>     for hosting it for effectively free (though I think we _would_ still
>     want to put a CDN in front of it). But if somebody has an
>     alternative option, that's fine, too.
>
>   - Some people offered to help with running the site, or making major
>     transitions (like converting to a static site). The most important
>     thing to me there is that we have a solid maintenance plan. So I
>     would want some evidence that anybody doing a major work would stick
>     around in the community afterwards, or that it be done in a way that
>     the handoff back to community members is easy. So I'd probably look
>     for somebody already involved in the community, or somebody who
>     wants to join it building up that trust by taking on site
>     responsibilities over time.
>
>   - Lots of people asked about small tasks to do. Mostly reviewing and
>     responding to issues and PR is the simplest thing. You can do it in
>     a drive-by way, and that helps take the load off of me. As the same
>     reviewers show up more and more, I think we can build a community
>     and I'd eventually hand out greater access to the site to match.
>
>     I notice I've got over 100 GitHub notifications from people sifting
>     through back-issues, so that will take some time to go through. I'm
>     hoping a lot of them are "already fixed, click closed". :)
>
>   - Several people offered money out of pocket to pay for hosting, and
>     several hosters contacted me to work out hosting deals ranging from
>     cheap to free. I'd prefer to explore the technical bits for now and
>     see what the final shape and cost actually is (if we move to a
>     non-Rails site, then Rails hosting is less appealing, obviously).
>
> So that's where we're at. I think the next step is either sticking a CDN
> in front of Heroku and dialing down the scaling there, or moving to a
> static site. I'll probably stall for a bit and see if patches for the
> latter materialize, and if not pursue the CDN thing (where most of the
> work will be administrative in getting it set up, not technical. I think
> that makes it more or less my thing to do, but if anybody is interested
> in setting it up and handing off an account to the project, that
> certainly makes things easy).
>
> Thanks again for everybody who has offered to help, and everybody who
> continues to do so.
>
> -Peff

So I've finally found the time to get everything set up (in the
process discovering that remote_genbook2 consistently induces a
segfault in VirtualBox's networking driver, impressively enough) and
am taking a look at how much work it would take to get the site
running on AWS EC2/DO or some other hosting provider.

Some things I'm wondering about:

- You mentioned a lot of people reaching out off-list about hosting
options. Do any of them look particularly appealing at the moment?
- How do I set up the ES service?

Sam
