Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAB8E20D0A
	for <e@80x24.org>; Mon, 29 May 2017 19:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbdE2TkM (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 15:40:12 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34831 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbdE2TkL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 15:40:11 -0400
Received: by mail-pf0-f174.google.com with SMTP id n23so52176428pfb.2
        for <git@vger.kernel.org>; Mon, 29 May 2017 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CMZoibolgNWxXPJADKlq8kLcU4JlfinLhAeOCRSgiFE=;
        b=ZPis4GruUmDEuBYxypICA6gRsg3ck21qM1KWmIPKsjPcmXKjUOZJduMZ1SEyVZnbDE
         a5srfZVJ3VyX2N7nvCP/JFH6dpUPczrFiMEqRqYCbMAD17Rstpyf1kmfB8p3trx+k0uX
         ZirWvsWUsZjWxdlGniHPbJT9KCQ0WXptolNueCl+8fp1VOLFWkoltO3Ucr67h5pAFWMs
         XxTVy/x3XMrJ9nvZEo4hwqEAqvr4CmnhL9ipzaGxogTVQ9X6E/zr8QbWXWKuY7ep1D2P
         jBhL+4HxvXHFZstd+WMxosRSqW934j/pxLNhx16r2u645VmJqa4zHckbMAcwsM6BFnsd
         kF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CMZoibolgNWxXPJADKlq8kLcU4JlfinLhAeOCRSgiFE=;
        b=p2mFnTa7YBcSAcYxAhMrFFmsxK7dURi3mybw9qsi6ayXK6YTVc9IdDrwfhW5yj8pr8
         ONFRynATy5q6vYd0g43QfB2PL1yj1vC4lfJgS03AWALxNY5sLLSgvjnQaVCrAFME4lVm
         nz2oGqgwsNwIZPKw+viP4UbCtoYggbLLhg1J4PxM663KRdc1rzvShdcDapqyOnfJ7T+b
         CtxQt3w2PRP1nh4AS5ReXAwwDfuG7UtZnvq9ZK8xOnyYa+LxfJ2bFK8yF/RF5UXMYsoZ
         aHVLPC0gCgkgCETC+x7scqEFRPIqKZm3HdbY0x0lDkRLC66J9ihHS6yvtGCFueL/JglE
         mqoA==
X-Gm-Message-State: AODbwcA0AnCbfGeZXzVPUSziZTl9WM3+s/yPR8rJzUOA4I5e3J3lNEah
        rCeQAqgljGxwZgH3z2GtIXBoRTkpnw==
X-Received: by 10.84.143.68 with SMTP id 62mr72271494ply.123.1496086810917;
 Mon, 29 May 2017 12:40:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.151.14 with HTTP; Mon, 29 May 2017 12:39:50 -0700 (PDT)
In-Reply-To: <xmqqr2z88lcy.fsf@gitster.mtv.corp.google.com>
References: <0102015c5146c8ca-e5144538-326b-47b8-8c81-af31da4cdfe0-000000@eu-west-1.amazonses.com>
 <xmqqr2z88lcy.fsf@gitster.mtv.corp.google.com>
From:   Sahil Dua <sahildua2305@gmail.com>
Date:   Mon, 29 May 2017 21:39:50 +0200
Message-ID: <CALiud+mYqVoVoFOsRDcXyXXRj857vRC3n6f0PPyX0qBvJs8C5A@mail.gmail.com>
Subject: Re: [PATCH/RFC] branch: add tests for new copy branch feature
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Junio for raising all these important questions.

Indeed, showing tests in order to explain my thinking about the
feature was a bad idea. I realise that I should have explained the
feature first instead of getting the tests reviewed without any
elaboration of the intentions. I will explain it now.

My definition of "copy" for this feature is "copying from A to create
B, keeping A intact". That means "copy branch A to B" should do
whatever "move branch A to B" does except it shouldn't delete A and
should keep A unchanged.

1. When a branch topic-2 is created by copying from branch topic-1,
topic-2 branch reflog should now contain the all the entries of
topic-1 branch (before copying) followed by "Copied from topic-1".
[This is debatable though, I want inputs/suggestions about this.]

2. Copying a branch should also copy the git config section for that
branch. This means if topic-2 branch is created from topic-1,
"branch.topic-2.remote" should now be same as "branch.topic-1.remote",
if set.

3. "git push" to copied branch for example - topic-2 should push a new
branch with the same name in the remote repo. That means if topic-1
was previously pushed and a new branch topic-2 is copied from topic-1,
"git push" on topic-2 branch won't push to the same branch as "git
push on topic-1 branch would.

4. "git branch -c new-branch" should copy the currently checked out
branch and create a new branch with name "new-branch".

On Mon, May 29, 2017 at 4:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Sahil Dua <sahildua2305@gmail.com> writes:
>
> > New feature - copying a branch along with its config section.
>
> That's an unusual non-sentence (without a verb) in our commit message.

Indeed terrible. I will remove it.

>
>
> > Aim is to have an option -c for copying a branch just like -m option for
> > renaming a branch.
>
> What should it copy literally, and what should it copy with
> adjustment (and adjusting what), and what should it refrain from
> copying?
>
> For example, when you create a branch topic-2 by copying from a
> branch topic-1, do you copy the reflog in such a way that topic-2's
> reflog contains all the entries of topic-1 before the copy happens,
> capped with a new (and not shared with topic-1) entry that says
> "Copied from topic-1"?  When topic-1 is set to pull from a custom
> upstream 'upstream' (i.e. not "origin")'s 'trunk' branch, by setting
> 'branch.topic-2.remote' to "upstream", i.e. the same as the value of
> 'branch.topic-1.remote' and 'branch.topic-2.merge' to "trunk",
> i.e. the same as 'branch.topic-1.merge'?  Should a "git push" while
> topic-2 is checked out push to the same remote as a "git push" would
> push to when topic-1 is checked out?  Should they update the same
> branch at the remote?  Why and/or why not? [*1*]
>
> > This commit adds a few basic tests for getting any suggestions/feedback
> > about expected behavior for this new feature.
>
> Writing tests is a good way to prepare for an implementation, which
> must be done according to the design, but that happens after the
> design is polished and judged to be a good one.  While soliciting
> comments on the design from others, tests are a bit too low level to
> express what you are aiming at.  It is a bit unhelpful to those who
> may want to help to figure out answers to questions like the ones in
> the previos paragraph (the one that begins with "For example,...")
> by telling them to "read my intention from these tests", and when
> you want as wide an input as possible, that is counterproductive for
> your objective ;-).
>
> > Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
> > ---
> >  t/t3200-branch.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >
> > diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> > index fe62e7c775da..2c95ed6ebf3c 100755
> > --- a/t/t3200-branch.sh
> > +++ b/t/t3200-branch.sh
> > @@ -341,6 +341,59 @@ test_expect_success 'config information was renamed, too' '
> >       test_must_fail git config branch.s/s/dummy
> >  '
> >
> > +test_expect_success 'git branch -c dumps usage' '
> > +     test_expect_code 128 git branch -c 2>err &&
> > +     test_i18ngrep "branch name required" err
> > +'
>
> OK.  Do we want to support a single-name format (i.e. copy from the
> current)?
>
>
>
> > +git config branch.d.dummy Hello
>
> Write your tests to do as little outside test_expct_success block as
> possible, and do a set-up close to where it matters.
>

Regarding putting code outside test_expect_success block, I wrote this
to keep tests consistent within the same file as I saw other test
doing it this way. How can I improve this?

Here, I needed to set branch config before I copy so that I can
confirm that the new "copied" branch has the same config as well. How
can I improve this and take it as close to where-it-matters as
possible?

>
> > +test_expect_success 'git branch -c d e should work' '
> > +     git branch -l d &&
> > +     git reflog exists refs/heads/d &&
> > +     git branch -c d e &&
> > +     git reflog exists refs/heads/d &&
> > +     git reflog exists refs/heads/e
> > +'
>
> A reasonable design of "copy" is for d's log to be left intact, and
> e's log to begin with a single entry "created by copying from d".
> Another possible design is to copy the log (making them identical),
> and then add one entry to e's log "created by copying from d".
>

Yes, this is debatable as I mentioned above. My personal choice will
be to use the second approach mentioned by you here.

>
> The above test would succeed with either implementation and does not
> answer "should reflog be copied?" (see above about why "here are the
> tests that shows my thinking--read them and comment" is a bad
> approach).
>
> "move" that makes the source of the movement disappear after the
> operation has a stronger justification of moving the log under the
> new name (the only alternative is to lose the history of the source
> forever), it is debatable if "copy" wants to retain a copy of the
> history of an otherwise unrelated branch, which has its own history
> retained after the operation.
>

For example, if branch topic-2 is copied from branch topic-1, "copy"
option should make sure the history of branch topic-1 is retained. I
will need suggestions about this too, in case I'm missing some
consequences/corner-cases of this.

>
> > +
> > +test_expect_success 'config information was copied, too' '
> > +     test $(git config branch.e.dummy) = Hello &&
> > +     test $(git config branch.d.dummy) = Hello
> > +'
>
> The expectation is that a configuration like 'dummy' that does not
> have any meaning to Git itself will all blindly be copied, which is
> similar to what "move" does.

Yes, any configuration for topic-1 branch should be copied to topic-2
branch while keeping the configuration for topic-1 branch retained.

>
>
> > +git config branch.f/f.dummy Hello
> > +
> > +test_expect_success 'git branch -c f/f g/g should work' '
> > +     git branch -l f/f &&
> > +     git reflog exists refs/heads/f/f &&
> > +     git branch -c f/f g/g &&
> > +     git reflog exists refs/heads/f/f &&
> > +     git reflog exists refs/heads/g/g
> > +'
>
> Hmph.  What's the reason to expect this not to work?
>
>
>
> > +test_expect_success 'config information was copied, too' '
> > +     test $(git config branch.f/f.dummy) = Hello &&
> > +     test $(git config branch.g/g.dummy) = Hello
> > +'
>
> Isn't this part of the "should work" test above?  The definition of
> working is not just reflog is created for the new branch without the
> old branch losing its reflog, right?
>

Right, I will put them in one test together.

> > +test_expect_success 'git branch -c m2 m2 should work' '
> > +     git branch -l m2 &&
> > +     git reflog exists refs/heads/m2 &&
> > +     git branch -c m2 m2 &&
> > +     git reflog exists refs/heads/m2
> > +'
>
> Is it OK for the configuration be lost silently?

No, I will change this accordingly as well.

>
>
> Thanks.
>
>
> [Footnote]
>
> *1* One way to avoid having to design an elaborate "definition of
>     copying" from scratch is to piggy-back on whatever "move" does.
>     Your definition of "copy" could be "copying from A to create B,
>     followed by deleting A, should leave the identical result as
>     moving A to create B".  And ask people if they agree with that
>     definition as "the first principle".
>
>     All the questions in the paragraph that begins with "For
>     example..." and similar ones can be answered by followingthe
>     first principle.
>
>

Thanks.
