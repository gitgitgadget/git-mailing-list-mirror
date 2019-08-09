Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDA431F731
	for <e@80x24.org>; Fri,  9 Aug 2019 02:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbfHICHg (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 22:07:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44425 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfHICHg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 22:07:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id 44so63312918qtg.11
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 19:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sCdr4Sj5bnL8mo2t0YyMrAz4pKxDywUxdAbgHfJSSpQ=;
        b=XtYotYq9ux0nrfOjZjee+0wx4L9gIgLsfNJ5JrA5ZBkAmNK0Pe3vLGiOQfVdLHNW1L
         NArVeMsLjY5iVmUFSDg9mSjegJ6itV2ls17EwIX6QgOLnnqlDhKFmZg6/FyIjzL7pQxk
         1C0mfbixmJU7zDRHNX7kVPb4HeeWt7VEEtCjSU1NtXbNZxkCHB58OEz6t+7KIbjKAJnV
         0oimv79DvnV+dY/58L6c1N2XDfQYrjibbFw7Hc2cIvqgu7tbk9TorceHuN9oe2k396tX
         tgudQmNMEErf+qgRBwsci2LgVsn+IsqdU+4XDE1ie+2Cn2kbL9VrWzUXFEX6vusd0nZC
         vFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sCdr4Sj5bnL8mo2t0YyMrAz4pKxDywUxdAbgHfJSSpQ=;
        b=pXpLRuUhxTOjLjUsW4tYBI1P+BkhFkk2bJBfkExXcsaMsVttph14dQk/x+XGYANcOK
         b0rmg6rAgLmDu4qZUbMTXXIMYFNVnkS2O9rW63TAPKloGjNm4yKeKLWEBfDycSs32bpA
         RIGG14GDMvserYwOUq8VnZ4PGtm6upV+R5Y90LwWrtOqnCm+mwL3ssC6A0HhXa69wvAb
         eTreQtWCxGET9Nf/1pF1AU+/mD4yMftDW2dmLs6YdsvxYnjZpgogLVXkpbvGYZcvmz8h
         zQ8jUz1g8RjGfcZWsmMExAKMnHG9+9WCJGVC/KiEcak2XLGQkRzPlFAGnIkInrKzFYPe
         vEjg==
X-Gm-Message-State: APjAAAUi1aBbjWqRCNURWefww/H8vajpjxXNtshukqGlNnXRE6qZ7LCu
        V1n5EicSbEKcZQxMOlRhcb7XmS25jidkEw==
X-Google-Smtp-Source: APXvYqw2b+QQRSl8gycXj31v878rYGrBQrgOc6UI4OACkHx9lWknDgs+eyF2JTOPQ5YQX/xT3/y6pw==
X-Received: by 2002:aed:2435:: with SMTP id r50mr12500751qtc.43.1565316454439;
        Thu, 08 Aug 2019 19:07:34 -0700 (PDT)
Received: from localhost ([2605:9480:205:fffe:d944:a1aa:a878:ce5c])
        by smtp.gmail.com with ESMTPSA id i16sm39318611qkk.1.2019.08.08.19.07.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 19:07:33 -0700 (PDT)
Date:   Thu, 8 Aug 2019 22:07:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Phil Hord <phil.hord@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
Message-ID: <20190809020732.GA89008@syl.lan>
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com>
 <20190809001315.GA87896@syl.lan>
 <3C7105E5-5DE1-42DC-A9A4-65C061FD6139@dereferenced.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3C7105E5-5DE1-42DC-A9A4-65C061FD6139@dereferenced.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ariadne,

Thank you for replying. I'm replying myself to the quoted hunks below,
and I very much appreciate your input. I would like to note that I
myself did not come up with these concerns alone, they were merely
suggested to me by a coworker, and I found them concerning.

I am not myself transgender, instead I am simply raising an issue that I
found myself concerning.

On Thu, Aug 08, 2019 at 09:34:15PM -0400, Ariadne Conill wrote:
> Hello,
>
> On August 8, 2019 8:13:15 PM EDT, Taylor Blau <me@ttaylorr.com> wrote:
> >Hi Junio,
> >
> >On Thu, Jul 25, 2019 at 05:19:23PM -0700, Junio C Hamano wrote:
> >> Here are the topics that have been cooking.  Commits prefixed with
> >> '-' are only in 'pu' (proposed updates) while commits prefixed with
> >> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> >> the integration branches, but I am still holding onto them.
> >>
> >> The seventh batch is in; I've merged fix-up topics that has been in
> >> 'master' for some time (i.e. up to the third batch of this cycle)
> >> down to 'maint'.
> >>
> >> You can find the changes described here in the integration branches
> >> of the repositories listed at
> >>
> >>     http://git-blame.blogspot.com/p/git-public-repositories.html
> >>
> >> --------------------------------------------------
> >> [Graduated to "master"]
> >>
> >> *snip*
> >>
> >> * ac/log-use-mailmap-by-default-transition (2019-07-15) 3 commits
> >>   (merged to 'next' on 2019-07-19 at e5669de950)
> >>  + tests: defang pager tests by explicitly disabling the log.mailmap
> >warning
> >>  + documentation: mention --no-use-mailmap and log.mailmap false
> >setting
> >>  + log: add warning for unspecified log.mailmap setting
> >>
> >>  The "git log" command learns to issue a warning when log.mailmap
> >>  configuration is not set and --[no-]mailmap option is not used, to
> >>  prepare users for future versions of Git that uses the mailmap by
> >>  default.
> >
> >Sorry for jumping into this discussion quite late. I was discussing
> >this
> >change with a colleague of mine who pointed out an issue with the
> >eventual new defaults. I'd like to re-raise the issues they shared with
> >me on the list for discussion, and if agreement is reached, I will send
> >a series that reverts these changes.
> >
> >If a transgender person uses '.mailmap' to rewrite their deadname to
> >their legal name (as was the original motivation in [1]), there are two
> >potential issues:
>
> What does myself being transgender have to do with anything?  Please
> explain.
>
> My motivation was to allow anyone to document their name change.
> People other than transgender individuals do change their names.

I think that the '.mailmap' is a good solution for other identity
changes, like when someone leaves a company, acquires an email address,
and wishes to take their contributions with them.

I don't think that being transgender changes one's usage of '.mailmap'.
I do, however, share the concern with my coworker that these patches are
being used to assist in deadname rewriting. It was my impression that
these patches are a response to the thread [1] that I linked in my last
email, and thus that eventually turning on '.mailmap'-rewriting by
default was the solution given to Phil Hord.

> Perhaps the fact that I am transgender means I am more attuned to the
> risks involved in using .mailmap in this way.

I'll certainly defer to your opinion on how this feature affects
transgender users over mine, and very much appreciate your perspective
and insight.

> >  - The '.mailmap' provides a list of transgender individuals, along
> >    with their deadname, which can be used to harass them.
>
> This is potentially a problem but it's not as bad as you depict.  A
> mailmap rule can match against e-mail only, which is precisely what I
> have done in my projects.

Ah, I may be severely mistaken -- my memory was that '.mailmap'
rewriting could be used to rewrite both name and email, not merely
email. I thought that records could take:

  A U Thor <author@xample.com> -> B C Xyzz <newname@example.com>

instead of canonicalizing by email alone. If this is the case, then I
completely agree and share the opinion that this is not as bad as I
originally depicted.

> And to be clear, anybody who is out there doxing transgender people
> are going to be using sources that are more reliable than a mailmap
> file.

Indeed. I think the '.mailmap' file doesn't contain much information if
it doesn't remap author names, and certainly individuals can choose not
to use it.

> >  - If they are not in control of the '.mailmap', and 'log.mailmap' is
> >    not specifiable (and instead defaults to 'true'), then a malicious
> >    maintainer or contributor can submit a change that rewrites their
> >    real name to their deadname, and harasses them further.
>
> The log.mailmap setting remains specifiable in these changes.  Sure, a
> maintainer can abuse mailmap, but they could already do so.  This
> commit changes absolutely nothing in that regard.

I think that I might be mistaken about the intentions of your patch
series. Do you hope to eventually remove 'log.mailmap', instead having
all clients automatically obey the '.mailmap'? If so, I think that this
does change the behavior, at least down the road. If a maintainer wishes
to abuse mailmap, today no one has to see it, because they have the
option to turn off mailmap rewriting. If this setting doesn't exist, it
gives more power to maintainers and contributors with write-level
access to force mailmap rewriting to take place.

> The commit does make `git shortlog` and `git log` consistent which is what most people expect.
>
> >This issue was not raised in the original discussion, but it's clear
> >that this has the potential be used for bad, not good.
>
> Every tool has the potential to be abused.  I would not have submitted
> this merge request if I thought that the benefits outweighed the
> trolling possibilities.

Yes, I agree that tools can be abused, and I do not question your
judgement in submitting this patch whatsoever. Again, I was merely
pointing out that there does seem to be a greater potential for this
tool to be misused, but only if I am understanding it correctly.

> >Given that the release is so close, I propose we revert this change
> >before v2.23.0 is tagged. After that, we ought to discuss ways for
> >folks
> >to change how their name is displayed in porcelain commands, and
> >thoroughly consider whether or not a new plan is exploitable.
> >
> >If you think this is a good course of action, I will send a series to
> >revert the changes that were queued here.
>
> I do not think this is a good course of action and I think your
> justification is extremely flimsy.
>
> While I would like to see the ability to commit a special commit that
> documents a name change, this does not change the fact that such
> commits will be mined in the same way.
>
> While I am glad that you are concerned about this from a trolling and
> harassment issue, I propose that you should allow individuals to make
> their own assessments on what they should do regarding documenting
> their changes using the mailmap file.

I'm happy to defer to the judgement of others, here; again I merely
wanted to raise a concern and share a proposed course of action in
response to it. If others do not buy into the justification, or if I
have misunderstood the feature, then we ought to let the release proceed
as normal.

> >Thanks,
> >Taylor
> >
> >[1]:
> >https://public-inbox.org/git/CABURp0poUjSBTTFUXP8dAmJ=37qvpe64=o+t_+mHOiK9Cv+=kg@mail.gmail.com/
>
> Ariadne

Thanks,
Taylor
