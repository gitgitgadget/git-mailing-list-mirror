Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6A91202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 16:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754861AbdKAQma (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 12:42:30 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:44518 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754818AbdKAQm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 12:42:29 -0400
Received: by mail-qk0-f172.google.com with SMTP id r64so3440819qkc.1
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 09:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s28Lc5JfocebKLmvubnk/P9a94aIAMTaTYeBIsbbv4Q=;
        b=ue2kfz3pxOvgcsv1+cnNS4SZmutIQUKGQ+qzqQaBpupYZvfWvdPbXe+3RnPchQG1Ks
         gWY5MGxQTGjdbT//gdyeoG/q1oeFx9r/p2KdT/3qQ6dJBlxaaadAAiINWkWFJ5QVuP3M
         hIlU9lvcGMQK/1PveOKlJGnzimcOplYy33CxSCL3WARUR3OBwPIrbFFtAphz3z9eV46a
         efOE+9rKT7TZq70U2LH7Pi6Zp0UU+QumJyWXbiaOkIcJkxC9CmBej82bAxqbuKmXDbOc
         LbDnhwGxYAIcUMd5SMZv7vj0TvJbgIVvpwQPOvIHuzpMMjUAMex9CYr+mQ32TucAkJHG
         R8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s28Lc5JfocebKLmvubnk/P9a94aIAMTaTYeBIsbbv4Q=;
        b=nw5BtKoRYyedFjhDNqvDTe0LzHL9c6CLTxuLI1hzDa52RNQDJtEOG9vekVwMtQ2MXC
         gSofURTYOmQTDGm/4jKTb6XbL9+597cwTIW9gXitwNB0uPPFI1mqn7LkhYAS7q7sx3Ad
         x4hCllNpZb38DjCMemmj2lAUDn7ptmUBbOrOEX+MPMQLJv3XxfVOznf8II7Ya9OpdSK3
         GB8XC0BDVZFaovec6yjWsOjG+qhhXWUECP7Pi1oRqJ0IBi9I2YS9B/LpS98DfwlewBMq
         jhxijYT3Hyq3bEqZ7w8SrliFqGOi8Uy1dWQggR6UNkRELmyApRbRfpdlkBm0/kwZYXB1
         MB+w==
X-Gm-Message-State: AMCzsaVMSs5C30uAALaSV73NJb30BaELaXJSFHFwxxVArjiahJCWQqnr
        25KU7f019vXcm8uouMflYRLkCzcbJt/wWkp7axrwuw==
X-Google-Smtp-Source: ABhQp+SWaiRNCdfofEr8la6KTr+NEb/DvFDAdi+68LNb/BLqU0V2KWXIleQK1TvV+H1uG3f4fZ2AkQ4nR1X19IZqIaI=
X-Received: by 10.55.129.70 with SMTP id c67mr735136qkd.230.1509554548383;
 Wed, 01 Nov 2017 09:42:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 1 Nov 2017 09:42:27 -0700 (PDT)
In-Reply-To: <20171101071422.c2k4plhntlgpdnbk@sigill.intra.peff.net>
References: <CAGZ79kbHwXpWXhUkokA9=XGN9D1YZevO_8MhbOztMXpkkHMFbg@mail.gmail.com>
 <20171101071422.c2k4plhntlgpdnbk@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Nov 2017 09:42:27 -0700
Message-ID: <CAGZ79kYKK69Xw0-2OxFpo9Q=Kv1hvw8D7YkfhMFFcgzTuevTCQ@mail.gmail.com>
Subject: Re: On the nature of cover letters [WAS Re: [PATCH 0/6] Create Git/Packet.pm]
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 1, 2017 at 12:14 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 30, 2017 at 11:29:37AM -0700, Stefan Beller wrote:
>
>> > I can live with fancily-formatted cover letters. BUT. I would say if
>> > your cover letter is getting quite long, you might consider whether some
>> > of its content ought to be going elsewhere (either into commit messages
>> > themselves, or into a design document or other place inside the repo).
>>
>> I am of the opinion that in an ideal workflow the cover letter would be
>> part of the merge commit message. It may even be editorialized or
>> annotated by the maintainer performing the merge, but not necessarily so.
>>
>> Currently I rarely pay attention to merges, because they are not exciting
>> (in a good way). I mostly know the texts that Junio puts into the merge
>> message[1] from the cooking email, and otherwise there is not much
>> information added there.
>
> Yes, I'd agree that for some topics it would be nice for the merge
> message to give any "big picture" details that wouldn't have made sense
> inside a single commit message.
>
>> However looking at *what* Junio puts there, is "why is this worthwhile
>> to merge from the *projects* point of view?", whereas the cover letter
>> most of the time talks about "Why the *contributor* wants this merged".
>> Often these are subtly different, so it would be nice to have these
>> two competing views around.
>
> Yes, there's really no reason we couldn't have both (e.g., Junio's
> maintainer synopsis followed by a marker, and then the original author's
> cover letter).
>
> The workflow within git is a little awkward, though. You'd want to pick
> up the cover letter information via "git am" when the branch is applied.
> But it doesn't go into a commit message until the merge. So where is it
> stored in the meantime? You'd need a branch->msg key/value store of some
> kind.

branch.<name.>description already exists on the contributors side.
Maybe we can teach git-am to populate that field with either the
message-id only (of the coverletter), or the cover letter text.

Or we introduce a git-am hook, that could populate the value
of that setting.

Once we have that setting there, our man page of git-merge claims
merging pays attention to that setting via git-fmt-merge-msg.

I guess if we put these pieces in place, it may be easier to convince
Junio to try out that workflow.

> Junio's workflow now actually uses the "pu" merges as the storage
> location while a topic is working its way up. But there's a period
> between "am" and running the integration cycle where it would need to go
> somewhere else.

An empty commit on top is a clunky idea. (Though from the data model,
that empty commit "just learns about a new parent" in the merge process).
I think the branch description field will do.

> One other consideration is that the cover letter may get updated between
> rounds (e.g., because you changed patches in response to review, or even
> to discuss alternatives that came up and were rejected). That places a
> burden on the maintainer to update the prospective merge-message.

if there was a git-am hook, that could be smart enough to *always*
update the branch description to the latest cover letter, (or even just
the latest patch of the series, if just the last patch changed)

> So it may make more sense just to cross-reference those merges with the
> topics that spawned them on the mailing list. I.e., instead of copying
> the cover letter contents, just record the message-id (and update it
> whenever a new iteration of a topic is picked up via "git am"). That
> lets you get the cover letter information _and_ see any discussion
> or review around the patch.

That sounds good.

Stefan
