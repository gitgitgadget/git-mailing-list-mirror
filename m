Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 535D120A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 20:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeLMUnj (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 15:43:39 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:32955 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeLMUnj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 15:43:39 -0500
Received: by mail-io1-f65.google.com with SMTP id t24so2749091ioi.0
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 12:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+nRB+G03PeLUzOdA9cdQx0yr4I4bhvPkn60Sdp73LM=;
        b=AobKK7WjEw5V+7yhL2oxMB7gZgJZxZJk3XORCGucw2S0C77Vzws9+hQjnsXmUWzXvJ
         b4Gjwfm7bfmXV5JyZjE5/+ld+AjUv6JOckdaxwFoWLl/eZCg+yVhW0f+0mNtw6/40wDj
         ATRXSn2yP8oGX8ArDYaydekEpb0Zy03iCDi1hzYwKtGSRhZVEaoyhdqG6+pMwWKkMeFn
         0vD8tgc75/D2l5mm8njdajqYaFOp52ryWR44loyzmsG1eWGdMQQ6uU6zNH84RgXi5RBo
         hYFGCvXbiuoDoECtU7iEIQlsObkQe5l8AyN04ZCTD9rZbbkMOzG4tDdPuFB1NKz1DL1s
         beyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+nRB+G03PeLUzOdA9cdQx0yr4I4bhvPkn60Sdp73LM=;
        b=bcLnhBW0Iypfiw1aiqWBSr0aIuOUI3xx3UCqzfGo6ggfpYns5xAO4cmKxHzgKkXXcM
         3H1at8fhx6fBJ+v+P1Ub1bTcAf5ZPnLDVg8GfS66szjkqvVMhb6zAkFysH72PNSvC3TB
         4hTBWG/I+kptLatxJxh3qVfrinAciHPpyaSla/cUAbLCcmCwL7Xg11ftQ+TZVl8aUfTS
         WW1KTHk3agoFIh+NfuIO0bW5C8RgvGeKf+feKazEScrhVRZzr5CVzmhnLFCTT65mXS4T
         kLrc37Nj7Gls1eYs6uuZPMvYW3Yqa92TZnUUqfDpQZX4A3iBxEX0z4HV+JyoBgIcdZ83
         UwWw==
X-Gm-Message-State: AA+aEWaIUeVD5u/RA6pvE76ZML37C0k33YPSpc7A+RrBORWvwjKqA3NT
        cckKnKpfHmm8LVp960QSWtA2vVR/2EKM0WdEmek=
X-Google-Smtp-Source: AFSGD/UEZh7Dj9XAzjsOB8BSfwIzn1zPwlG8rAsTVUBEWV15rJZVWzCr12YQh3e4MoJAZU2XjqmIon/Lz4JJLP2g1c0=
X-Received: by 2002:a6b:7b42:: with SMTP id m2mr238927iop.236.1544733817948;
 Thu, 13 Dec 2018 12:43:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.100.git.gitgitgadget@gmail.com> <13ee60e44f91ca06d182ff50fa4c69e137650fd2.1544730848.git.gitgitgadget@gmail.com>
 <CACsJy8AsRT+k4kdwC3gGjDOPiDn-L0GJs7-SQHb88Ra_gt4OcA@mail.gmail.com> <CANoM8SVMYBRg-nL4r=JJDFU_qZ=grzSmRs-B2nLYUnv5kFc00Q@mail.gmail.com>
In-Reply-To: <CANoM8SVMYBRg-nL4r=JJDFU_qZ=grzSmRs-B2nLYUnv5kFc00Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 13 Dec 2018 21:43:11 +0100
Message-ID: <CACsJy8Bj=8xHp3JA8dLbyM=RwJey7utMK6DTVe_0AjBNVHxJyg@mail.gmail.com>
Subject: Re: [PATCH 1/1] worktree refs: fix case sensitivity for 'head'
To:     Mike Rappazzo <rappazzo@gmail.com>
Cc:     gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 9:34 PM Mike Rappazzo <rappazzo@gmail.com> wrote:
>
> On Thu, Dec 13, 2018 at 3:23 PM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Thu, Dec 13, 2018 at 8:56 PM Michael Rappazzo via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > >
> > > From: Michael Rappazzo <rappazzo@gmail.com>
> > >
> > > On a worktree which is not the primary, using the symbolic-ref 'head' was
> > > incorrectly pointing to the main worktree's HEAD.  The same was true for
> > > any other case of the word 'Head'.
> > >
> > > Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> > > ---
> > >  refs.c                   | 8 ++++----
> > >  t/t1415-worktree-refs.sh | 9 +++++++++
> > >  2 files changed, 13 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/refs.c b/refs.c
> > > index f9936355cd..963e786458 100644
> > > --- a/refs.c
> > > +++ b/refs.c
> > > @@ -579,7 +579,7 @@ int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
> > >                                 *ref = xstrdup(r);
> > >                         if (!warn_ambiguous_refs)
> > >                                 break;
> > > -               } else if ((flag & REF_ISSYMREF) && strcmp(fullref.buf, "HEAD")) {
> > > +               } else if ((flag & REF_ISSYMREF) && strcasecmp(fullref.buf, "HEAD")) {
> >
> > This is not going to work. How about ~40 other "strcmp.*HEAD"
> > instances? All refs are case-sensitive and this probably will not
> > change even when we introduce new ref backends.
>
> The current situation is definitely a problem.  If I am in a worktree,
> using "head" should be the same as "HEAD".

No "head" is not the same as "HEAD". It does not matter if you're in a
worktree or not.

> I am not sure if you mean that the fix is too narrow or too wide.
> Maybe it is only necessary in 'is_per_worktree_ref'.  On the other
> side of the coin, I could change every strcmp to strcasecmp where the
> comparison is against "HEAD".

If you make "head" work like "HEAD", then it should work for _all_
commands, not just worktree, and "MASTER" should match
"refs/heads/master" and so on. I don't think it's as simple as
changing strcmp to strcasecmp. You would need to make ref management
case-insensitive (and make sure if still is case-sensitive if
configured so). I don't think anybody has managed that.
-- 
Duy
