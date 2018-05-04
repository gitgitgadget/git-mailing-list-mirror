Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD81D1F42E
	for <e@80x24.org>; Fri,  4 May 2018 07:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbeEDHOx (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 03:14:53 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42354 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeEDHOw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 03:14:52 -0400
Received: by mail-qk0-f193.google.com with SMTP id j10so15894192qke.9
        for <git@vger.kernel.org>; Fri, 04 May 2018 00:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=3d5b2cZSzMpkVE06ZRQ9Nober+Cs3mMqVimv4Me86YQ=;
        b=vFj4eQH45Eu1rt21e6sDDUBk1JojaD+W7L7HWD+uMXqAsD19T20oRxIgW8N6LK8580
         9xQ0rZlA16yPw17AVCmAbPMd1eZuB1CFF7SYJ5pqScp5jabnmXiXJl3tps0rBkhoHwUj
         ovPh9HobLU74Wt3wCObsiVWH+HK/+37PLMZES5qwSMhUaLo+LNeA7/e3n3xjIKRrpJD6
         ZWiJAP2Gr+9nYfTnMqUC/tyC+yrWROjDLxbNWdJsy7oMxQxsA2xNASZEGT7N3cdw0m+k
         IiOHCyHLOePo7A40/Pb3QHW/oyCRX/JH+ulhoD4MxUPENYcFdUFFLLKpydYjAPd5qrVD
         vvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=3d5b2cZSzMpkVE06ZRQ9Nober+Cs3mMqVimv4Me86YQ=;
        b=JLyftWK5NKEh+LyiJxIhUhA4i7Cq3M8DqaXyZW2P0MKqKozJ2SDaNMYGAMJaC63S8D
         EymR/PMEitTsO0TngP/yDWhfrQAm753O2/uarz/3jCC0SCxd2m9dMT5ptXpxBqplyY16
         BQlK7ezLmjlUzqc3Fzo9PYnPqB7QyhyCjXM33e6YO0AuVz6UMKS1r4fIlkiW1uuG4oJD
         ziBW//yoxQQAVSsHP8ZhyhTlUFuBU7yMRFMEiWA2kEVaKh1x2P0uszDk50CrSuZKxGBB
         GMquVtjOdTN6jaO5/W4wwgpOvQ+PTmiTe6K5rPSiRTocrT4i5tbna1jJHA/QnyIWjE/7
         sNjQ==
X-Gm-Message-State: ALQs6tBVyopdBw+gwreJ+sHjly+yGOFwVBOVoHE4MlTeaI7gK+KF6Gs7
        8bK1DxuPJ46wc7PdkMfLs5PeH1iorWafGT2bpXc=
X-Google-Smtp-Source: AB8JxZq/etXnZ5W/GNBkF7tC5IXXU/LP0JkiTX8KZKE7Y9oBP2v5rdXzbUZzNwGEVaqKsPozIbZ8ihsIrBRjOm9POZ8=
X-Received: by 10.233.220.1 with SMTP id q1mr19555529qkf.361.1525418091118;
 Fri, 04 May 2018 00:14:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Fri, 4 May 2018 00:14:50 -0700 (PDT)
In-Reply-To: <87y3h1ykwn.fsf@evledraar.gmail.com>
References: <20180502105452.17583-1-avarab@gmail.com> <CACsJy8Ae9PP8BMbyX5mPJukGpC06jMvvbg0fMFL+fu+EUg1kPw@mail.gmail.com>
 <CAPig+cTZyYC-1_TxL2PrfOF6HAktUxxM+g5EXcByS5fCDMdCHg@mail.gmail.com> <87y3h1ykwn.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 4 May 2018 03:14:50 -0400
X-Google-Sender-Auth: ydjuhmSFcFHPG94iMUvcM35eR3I
Message-ID: <CAPig+cSRBBzXDWMJd5k=ZGOt_ayATWB6fZQrcMqJkP8ja4Tq+g@mail.gmail.com>
Subject: Re: [PATCH] checkout & worktree: introduce a core.DWIMRemote setting
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 2, 2018 at 2:25 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, May 02 2018, Eric Sunshine wrote:
>> A few observations:
>>
>> 1. DWIM has broad meaning; while this certainly falls within DWIM,
>> it's also just a _default_, so should this instead be named
>> "defaultRemote"?
>>
>> 2. Building on #1: How well is the term "DWIM" understood by non-power
>> users? A term, such as "default" is more well known.
>
> I've got no love for the DWIM term. And I think I should change it in
> v2, I just want some way to enable this functionality since this
> behavior has annoyed me for a long time.
>
> I wonder though if something like "core.defaultRemote" might not bring
> up connotations about whether this would e.g. affect "push" in the minds
> of users (not that my initial suggestion is better).

A reasonable concern.

> So maybe something like checkout.implicitRemote would be better? And we
> could just break the rule that only git-checkout would use it, since
> git-worktree could be said to be doing something checkout-like, or just
> also add a worktree.implicitRemote.

Considering that git-worktree runs the post-checkout hook, it seems
pretty safe to say that it does something checkout-like.

Personally, I find "defaultRemote" easier to understand than
"implicitRemote", but I suppose I can see your reasoning for choosing
"implicit". Whereas "default" is something to "fall back upon" when
something is missing, "implicit" suggests what to choose when a
something has not been specified explicitly.

>> 3. git-worktree learned --guess-remote and worktree.guessRemote in [1]
>> and [2], which, on the surface, sound confusingly similar to
>> "DWIMRemote". Even though I was well involved in the discussion and
>> repeatedly reviewed the patch series which introduced those, it still
>> took me an embarrassingly long time, and repeated re-reads of all
>> commit messages involved, to grasp (or re-grasp) how "guess remote"
>> and "DWIM remote" differ. If it was that difficult for me, as a person
>> involved in the patch series, to figure out "guess remote" vs. "DWIM
>> remote", then I worry that it may be too confusing in general. If the
>> new config option had been named "defaultRemote", I don't think I'd
>> have been confused at all.
>
> I hadn't looked at this at all before today when I wrote the patch, and
> I've never used git-worktree (but maybe I should...), but my
> understanding of this --[no-]guess-remote functionality is that it
> effectively splits up the functionality that the "git checkout" does,
> and we'll unconditionally check out the branch, but the option controls
> whether or not we'd set up the equivalent of remote tracking for
> git-worktree.
>
> But maybe I've completely misunderstood it.

Yes, you misunderstood it.

The setting up of a remote-tracking branch is DWIM'd as of 4e85333197
("worktree: make add <path> <branch> dwim", 2017-11-26); it doesn't
require an explicit option to enable it (though tracking can be
disabled via --no-track). The "guess-remote" feature does something
entirely different; it was added to avoid backward compatibility
problems.

In long-form:

    git worktree add <path> <branch>

adds a new worktree at <path> and checks out <branch>. As originally
implemented, shortened:

    git worktree add <path>

does one type of DWIM, as a convenience, and pretends that the user
actually typed:

    branch=3D$(basename <path>)
    git branch $branch HEAD
    git workree add <path> $branch

which creates a new branch and then checks it out in the new worktree
as usual. The "guess remote" feature which Thomas added augments that
by adding a DWIM which checks if $(basename <path>) names a
remote-tracking branch, in which case, it becomes shorthand for
(something like):

    branch=3D$(basename <path>)
    if remote-tracking branch named $branch exists:
        git branch --track $branch $guessedRemote/$branch
    else:
        git branch $branch HEAD
    fi
    git worktree add <path> $branch

In retrospect, this DWIM-checking for a like-named remote-tracking
branch should have been implemented from the start in git-worktree
since it mirrors how "git checkout <branch>" will DWIM remote-tracking
<remote>/<branch>. However, such DWIM'ing was overlooked and
git-worktree existed long enough without it that, due to backward
compatibility concerns, the new DWIM'ing got hidden behind a switch,
hence --guess-remote ("worktree.guessRemote") to enable it.

Unrelated: Thomas added another DWIM, which we just finalized a few
days ago, which extends the shorthand "git worktree add <path>" to
first check if a local branch named $(basename <path>) already exists
and merely check that out into the new worktree rather than trying to
create a new branch of that name (which is another obvious DWIM missed
during initial implementation). In other words:

    branch=3D$(basename <path>)
    if local branch named $branch does _not_ exist:
        if remote-tracking branch named $branch exists:
            git branch --track $branch $guessedRemote/$branch
        else:
            git branch $branch HEAD
        fi
    fi
    git worktree add <path> $branch
