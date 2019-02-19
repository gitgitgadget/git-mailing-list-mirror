Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_RP_RNBL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A4861F453
	for <e@80x24.org>; Tue, 19 Feb 2019 22:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfBSWcD (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 17:32:03 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34668 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfBSWcD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 17:32:03 -0500
Received: by mail-vk1-f193.google.com with SMTP id y14so5086150vkd.1
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 14:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uIHm9mJlqWU32HQYXZzGALlOZVQrszkIB7RDlaQB1jU=;
        b=nQoBvORRmOzpA1DxI86euU937dC2yplkwdPu8lgLnKLZJLlJbmU34Fsvfoisrbfe/s
         85YsXc+9EvWouFS+NzvDX41uqaIEDP3r+Tq2mMIkFmZ/H38YNqiZM2K9GFdCJPtpqu6s
         /OCWUadVk/g/WncYxpiD9GDFni0S9+qdjoFvfCH85u6UIiQKaSeyUm2sK1OzpYcIiql+
         oBqp2ZO2srl1xreF/E7I3+N43H2IGX5ERB6yThXbtoFdAqCwv1sCepqiNjOiGBKGhQ2X
         yb9rs1kW8Git2Yg7nlqdgwpMmOP20Ry88a8R+8ydQg+d56I6/Bz9W/YZBfHoMSVSOcLk
         so5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uIHm9mJlqWU32HQYXZzGALlOZVQrszkIB7RDlaQB1jU=;
        b=K23fkbmEn9UuqX2t4hVXmbHLGJa7jNeOSv8i/Cf8A7+zfaF298t+UNDfHkXpy7Wjpa
         Jdeml8sc+s/aDyduCammexgwEn3zwl8HdGYDruNwVsnceUe5niphjjucXSyGSx+AmlUW
         AoNvrXBpP4TmCZgIeSFcVDYVxeS9k1wV4QC4YgBCL1vyI1GsJbM23eRsjcs1kXQq+QNI
         HjJ6GgLjCoXawuznmIvjgsxAlBzO34mcTVrEGtmiNlixhPpjMdJ4RySCbyiXZ7dNS5Oi
         zw2BOW3zmwoXZLB2+5W+tz2lyGepFc70UdYxTQ3TPEA9fFLIzSFcALqYaCX9Jz4Oes0l
         9tRA==
X-Gm-Message-State: AHQUAubB+DyrvyQOiE1xfPC7GMLV3yriKSQANw9/9MGBT5xpnTtkPgKR
        MM2Zx2CDtonQj712ePBFKC/kHmBPsHmTQAbc2bI=
X-Google-Smtp-Source: AHgI3IY5luyiUfxt/OcM29vBTBanYdKfIz6mC4spLSW8dPdwB/bg8QswZVXm479D7FnqBxSy5ugWCS7b7h+VwjXEDqk=
X-Received: by 2002:a1f:a147:: with SMTP id k68mr12096802vke.1.1550615521843;
 Tue, 19 Feb 2019 14:32:01 -0800 (PST)
MIME-Version: 1.0
References: <5C6BAA4E020000A10002FBFF@gwsmtp1.uni-regensburg.de>
 <20190219170709.25463-1-newren@gmail.com> <xmqqk1hv1sms.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1hv1sms.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 19 Feb 2019 14:31:50 -0800
Message-ID: <CABPp-BGGujXxdmdv0P+TwHwwKaK2maA6rJ7=WpiJYq7ZZivkpw@mail.gmail.com>
Subject: Re: [PATCH v2] merge-options.txt: correct wording of --no-commit option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 19, 2019 at 11:32 AM Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
> > +With --no-commit perform the merge and stop just before creating
> > +a merge commit, to give the user a chance to inspect and further
> > +tweak the merge result before committing.
> > ++
> > +Note that fast-forward updates do not need to create a merge
> > +commit and therefore there is no way to stop those merges with
> > +--no-commit.  Thus, if you want to ensure your branch is not
> > +changed or updated by the merge command, use --no-ff with
> > +--no-commit.
>
> While the above is an improvement (so I'll queue it on 'pu' not to
> lose sight of it), I find the use of "do not need to" above somewhat
> misleading.  It solicits a reaction "ok, we know it does not need
> to, but it could prepare to create one to allow us to further muck
> with it, no?".
>
> IOW, a fast-forward by definition does not create a merge by itself,
> so there is nowhere to stop during a creation of a merge.  So at
> least:
>
>         s/do not need to/do not/

Yes, I agree that's a good change.  I'll wait a few days for other
feedback and resend with that and any other changes.

> It also may be a good idea to consider detecting this case and be a
> bit more helpful, perhaps with end-user experience looking like...
>
>   $ git checkout master^0
>   $ git merge --no-commit next
>   Updating 0d0ac3826a..ee538a81fe
>   Fast-forward
>     ...diffstat follows here...
>   hint: merge completed without creating a commit.
>   hint: if you wanted to prepare for a manually tweaked merge,
>   hint: do "git reset --keep ORIG_HEAD" followed by
>   hint: "git merge --no-ff --no-commit next".
>
> or even
>
>   $ git checkout master^0
>   $ git merge --no-commit next
>   warning: defaulting to --no-ff, given a --no-commit request
>   Automatic merge went well; stopped before committing as requested
>   hint: if you'd rather have a fast-forward without creating a commit,
>   hint: do "git reset --keep next" now.

Good points.  I thought of this last one before sending, though
without pre- and post- warnings/hints; without such text it definitely
seemed too magical and possibly leading to unexpected surprises in a
different direction, so I dismissed it without further thought.  But
the warnings/hints help.

> I do not have a strong preference among three (the third option
> being not doing anything), but if pressed, I'd say that the last one
> might be the most user-friendly, even though it feels a bit too
> magical and trying to be smarter than its own good.

I also lack a strong preference.  Maybe mark it #leftoverbits for
someone that does?

> In any case, the hint for the "recovery" procedure needs to be
> carefully written.

Yes.
