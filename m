Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66AD41F731
	for <e@80x24.org>; Fri,  9 Aug 2019 03:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405132AbfHIDEb (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 23:04:31 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33134 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733140AbfHIDEb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 23:04:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id q20so127090784otl.0
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 20:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G8pHn3DVWa2I+eLlREvIDWDc1RQjzd4YN3CP1FTOzHA=;
        b=xxZV+nT50POvtpkglvpPH1gpkhtwN3b4gK+qzC08ZcKCZY9GXMorGzrhcLs3eYaQJp
         inoni9fQairwxuq3/wsTVM+7dF5gHMUkjvg84HDleSVkCgQ7+eioFsFifDpJCoDRsixs
         keaIEffvOebSwZzsJ4ZXLJ0XUHglJdB2xtWvjWL7ntxXT15DDFpXIrMF6xHFYkzvOER9
         ocToh7XMFmdKwADWk8qKJsug1PnyC5AIJD8MTfYjuaDpNu4Q3xKFYQI9b5rheJUXWaG+
         Vy4+zlytuamQDN66n9w0KsTfmFG/4jPpBUJlM2z4qATH3xLXY9YoxP90eHFzLcQNynGI
         LhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G8pHn3DVWa2I+eLlREvIDWDc1RQjzd4YN3CP1FTOzHA=;
        b=MZ6lUvdH8pG3LsjTxrDjxdZsI3mPjRh21I8fuE+9TbhVtjFeDbD0Q5zpe1ZQhd/LVQ
         TEJ/bLyAq2187HNvdHZn3svZmvQSA9Zt6nzkK556X+usBBFNoaK5NQqbrZuPAkwY1GnS
         aBnInbastBSnpR61xfasOesDYC9xzJnnCZ4268EP5kTXYOuABPW2zWohad+4ICVmBP14
         rGbHfJtDlAMDdarq3R/CXqUlsRYfFOqI7wY86MMtsr93ibEfg0kiY11Z6FTv33+OGGDe
         2KVRXwjMJHfm2C59PbGqe1jQrk9eNS8vg0uzw/3rhG5Fg8l2XS0uMfBjUpc5jc6Wh3ae
         L2IQ==
X-Gm-Message-State: APjAAAXww8w6e0tnzJfwDj3Jrr1l9GoQAYkU7Xg9oxFhncSC3lSdbiSh
        7UD+lTw7wU9L4Nw0RJeXgwK9AGOiGHXnA9UmGIBqcA==
X-Google-Smtp-Source: APXvYqy+KO6DLa4a9GYkdIaAt46SqAIFQ7GeNGlWEvfhP7tMMKpGenAkNkb1pOsi17sAfYPyWW08P6ZN9EEsS9GGfaU=
X-Received: by 2002:a5d:968b:: with SMTP id m11mr12960367ion.16.1565319869525;
 Thu, 08 Aug 2019 20:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com> <20190809001315.GA87896@syl.lan>
 <3C7105E5-5DE1-42DC-A9A4-65C061FD6139@dereferenced.org> <20190809020732.GA89008@syl.lan>
In-Reply-To: <20190809020732.GA89008@syl.lan>
From:   Ariadne Conill <ariadne@dereferenced.org>
Date:   Thu, 8 Aug 2019 22:04:18 -0500
Message-ID: <CAAOiGNyW9EpPgaMH1wEFG8gNNtypo2FaqOoOCe55i1TyT4L36A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phil Hord <phil.hord@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Thu, Aug 8, 2019 at 9:07 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi Ariadne,
>
> Thank you for replying. I'm replying myself to the quoted hunks below,
> and I very much appreciate your input. I would like to note that I
> myself did not come up with these concerns alone, they were merely
> suggested to me by a coworker, and I found them concerning.
>
> I am not myself transgender, instead I am simply raising an issue that I
> found myself concerning.

Sure, there are concerns with the use of .mailmap being the primary
source of truth for identities in a git repository.  However, this is
the present design.  I'm not against improving the design, but see no
reason to block changes that *improve quality of life* for people who
are both transgender (or simply have changed their name for whatever
reason) and those who collaborate with said people.  I also believe
that this is an *intended* use of the design, since mailmap allows
rewriting names.  If it is not intended, then why does mailmap support
rewriting names?

This isn't an either/or thing.  This is more along the lines of --
lets improve what we have now -- and deal with making a more robust
mailmap replacement down the line, because that is going to require
more careful consideration.

> On Thu, Aug 08, 2019 at 09:34:15PM -0400, Ariadne Conill wrote:
> > Hello,
> >
> > On August 8, 2019 8:13:15 PM EDT, Taylor Blau <me@ttaylorr.com> wrote:
> > >Hi Junio,
> > >
> > >On Thu, Jul 25, 2019 at 05:19:23PM -0700, Junio C Hamano wrote:
> > >> Here are the topics that have been cooking.  Commits prefixed with
> > >> '-' are only in 'pu' (proposed updates) while commits prefixed with
> > >> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> > >> the integration branches, but I am still holding onto them.
> > >>
> > >> The seventh batch is in; I've merged fix-up topics that has been in
> > >> 'master' for some time (i.e. up to the third batch of this cycle)
> > >> down to 'maint'.
> > >>
> > >> You can find the changes described here in the integration branches
> > >> of the repositories listed at
> > >>
> > >>     http://git-blame.blogspot.com/p/git-public-repositories.html
> > >>
> > >> --------------------------------------------------
> > >> [Graduated to "master"]
> > >>
> > >> *snip*
> > >>
> > >> * ac/log-use-mailmap-by-default-transition (2019-07-15) 3 commits
> > >>   (merged to 'next' on 2019-07-19 at e5669de950)
> > >>  + tests: defang pager tests by explicitly disabling the log.mailmap
> > >warning
> > >>  + documentation: mention --no-use-mailmap and log.mailmap false
> > >setting
> > >>  + log: add warning for unspecified log.mailmap setting
> > >>
> > >>  The "git log" command learns to issue a warning when log.mailmap
> > >>  configuration is not set and --[no-]mailmap option is not used, to
> > >>  prepare users for future versions of Git that uses the mailmap by
> > >>  default.
> > >
> > >Sorry for jumping into this discussion quite late. I was discussing
> > >this
> > >change with a colleague of mine who pointed out an issue with the
> > >eventual new defaults. I'd like to re-raise the issues they shared with
> > >me on the list for discussion, and if agreement is reached, I will send
> > >a series that reverts these changes.
> > >
> > >If a transgender person uses '.mailmap' to rewrite their deadname to
> > >their legal name (as was the original motivation in [1]), there are two
> > >potential issues:
> >
> > What does myself being transgender have to do with anything?  Please
> > explain.
> >
> > My motivation was to allow anyone to document their name change.
> > People other than transgender individuals do change their names.
>
> I think that the '.mailmap' is a good solution for other identity
> changes, like when someone leaves a company, acquires an email address,
> and wishes to take their contributions with them.

Then maybe .mailmap should be scoped to rewriting e-mail addresses only.

> I don't think that being transgender changes one's usage of '.mailmap'.
> I do, however, share the concern with my coworker that these patches are
> being used to assist in deadname rewriting. It was my impression that
> these patches are a response to the thread [1] that I linked in my last
> email, and thus that eventually turning on '.mailmap'-rewriting by
> default was the solution given to Phil Hord.

Yes, they *are* being used to assist in deadname rewriting, because
that is the mechanism that already exists in the code to facilitate
it.

In what case would you *not* want to know the current name of the
person who authored a contribution?  There are legal situations
involving auditing the copyright status of contributions where
*current* identity information for the author is desirable over what
was there historically, because you need to contact the author and
find out his or her wishes involving the code.  Situations like
relicensing, for example.

> > Perhaps the fact that I am transgender means I am more attuned to the
> > risks involved in using .mailmap in this way.
>
> I'll certainly defer to your opinion on how this feature affects
> transgender users over mine, and very much appreciate your perspective
> and insight.
>
> > >  - The '.mailmap' provides a list of transgender individuals, along
> > >    with their deadname, which can be used to harass them.
> >
> > This is potentially a problem but it's not as bad as you depict.  A
> > mailmap rule can match against e-mail only, which is precisely what I
> > have done in my projects.
>
> Ah, I may be severely mistaken -- my memory was that '.mailmap'
> rewriting could be used to rewrite both name and email, not merely
> email. I thought that records could take:
>
>   A U Thor <author@xample.com> -> B C Xyzz <newname@example.com>
>
> instead of canonicalizing by email alone. If this is the case, then I
> completely agree and share the opinion that this is not as bad as I
> originally depicted.

Yes, you can write mailmap entries with just the email like I have
done in pkgconf for example[1].

> > And to be clear, anybody who is out there doxing transgender people
> > are going to be using sources that are more reliable than a mailmap
> > file.
>
> Indeed. I think the '.mailmap' file doesn't contain much information if
> it doesn't remap author names, and certainly individuals can choose not
> to use it.
>
> > >  - If they are not in control of the '.mailmap', and 'log.mailmap' is
> > >    not specifiable (and instead defaults to 'true'), then a malicious
> > >    maintainer or contributor can submit a change that rewrites their
> > >    real name to their deadname, and harasses them further.
> >
> > The log.mailmap setting remains specifiable in these changes.  Sure, a
> > maintainer can abuse mailmap, but they could already do so.  This
> > commit changes absolutely nothing in that regard.
>
> I think that I might be mistaken about the intentions of your patch
> series. Do you hope to eventually remove 'log.mailmap', instead having
> all clients automatically obey the '.mailmap'? If so, I think that this
> does change the behavior, at least down the road. If a maintainer wishes
> to abuse mailmap, today no one has to see it, because they have the
> option to turn off mailmap rewriting. If this setting doesn't exist, it
> gives more power to maintainers and contributors with write-level
> access to force mailmap rewriting to take place.

I have no interest in removing the log.mailmap setting, but I would
like to see the setting behave consistently across all applets.  In
other words, "git shortlog", "git log" and "git blame" should have the
same behaviour given log.mailmap being set a certain way.  They
presently don't have consistent behaviour (shortlog and blame always
use mailmap), and I found that surprising.  This allows people to look
at the raw data if they have explicit interest in it, by setting
log.mailmap to false, and ensuring that people get reasonable
behaviour by default (log.mailmap is default to true).

I also want to explicitly state that I believe wholeheartedly that
people will fork projects with a hostile maintainer who renames people
in the mailmap file to derogatory names, so I think that is a
non-issue.  Somebody who is trolling by using mailmap files to rewrite
contributor names is indicative that a project shouldn't be taken
seriously.

> > The commit does make `git shortlog` and `git log` consistent which is what most people expect.
> >
> > >This issue was not raised in the original discussion, but it's clear
> > >that this has the potential be used for bad, not good.
> >
> > Every tool has the potential to be abused.  I would not have submitted
> > this merge request if I thought that the benefits outweighed the
> > trolling possibilities.
>
> Yes, I agree that tools can be abused, and I do not question your
> judgement in submitting this patch whatsoever. Again, I was merely
> pointing out that there does seem to be a greater potential for this
> tool to be misused, but only if I am understanding it correctly.

Based on your misunderstanding of the mailmap feature, I believe
you're not understanding the patches correctly.

> > >Given that the release is so close, I propose we revert this change
> > >before v2.23.0 is tagged. After that, we ought to discuss ways for
> > >folks
> > >to change how their name is displayed in porcelain commands, and
> > >thoroughly consider whether or not a new plan is exploitable.
> > >
> > >If you think this is a good course of action, I will send a series to
> > >revert the changes that were queued here.
> >
> > I do not think this is a good course of action and I think your
> > justification is extremely flimsy.
> >
> > While I would like to see the ability to commit a special commit that
> > documents a name change, this does not change the fact that such
> > commits will be mined in the same way.
> >
> > While I am glad that you are concerned about this from a trolling and
> > harassment issue, I propose that you should allow individuals to make
> > their own assessments on what they should do regarding documenting
> > their changes using the mailmap file.
>
> I'm happy to defer to the judgement of others, here; again I merely
> wanted to raise a concern and share a proposed course of action in
> response to it. If others do not buy into the justification, or if I
> have misunderstood the feature, then we ought to let the release proceed
> as normal.

As previously stated, I think that your justification is flimsy, but I
think that's simply due to a misunderstanding of how mailmap works,
and to what level of consistency mailmap is respected.  Hopefully this
explanation is useful.

[1]: https://git.sr.ht/~kaniini/pkgconf/tree/master/.mailmap

Ariadne
