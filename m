Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E3D91F453
	for <e@80x24.org>; Fri,  2 Nov 2018 01:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeKBKY3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 06:24:29 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:34094 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbeKBKY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 06:24:28 -0400
Received: by mail-oi1-f175.google.com with SMTP id f21-v6so351094oig.1
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 18:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/umoJE+z4+2NwDjH1I2aT3dE2X2mL6/WuKl+7RohGw=;
        b=PrsWe6SpTQ5thVOGTg88d2zxFPoCQ1QgSeFx34NKlhi6Tk0i6DF70Z4ZkiKEQGScmG
         K4zuiXpCnD+W6sJotnfLkFLa/6iGbpx1Dd9BMAo2ARN7mT9igZZ80pht5ryXYOiW5BDL
         v7Qsvrrfhv2g7ZEPoevYFU2aiU3vDMb84bViLrjhjw1LxW1U3R/hVBp0mfaOH4D199Jz
         b1wd2bIbhO10loKbQYnxTcLj2sa7HarQcuk9BrZE//jo0ONRYHex3lAfr6vDA9nYcb36
         9VOKH495ckpltrTw8zZdRmzabWV/+FOTRkQuMzdpdb2Kfmh1Tn5hUu7+PjGuvLFaD+kA
         qdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/umoJE+z4+2NwDjH1I2aT3dE2X2mL6/WuKl+7RohGw=;
        b=hdEaWOvj/ODiz4uT5wIYeQ7wrhNTFLHKF4q/dWhykw7nJcv0jSVlahjym+dcNTKsY2
         VsAySdpVWYZ4lQPI89KaTSKAjifhEqncqt1QJLw7UeKYWzHX5J4iNa/CZN1elNroL+KR
         v9z1iNYi1Z5WWZoncq5kmBGHkABpXbU3Vxy/4C+oymC1IHwl0dWYQ5omnPE77RsUbXp1
         uUmROXMvQQQbr+2J9DP7K+Fc5keFTyiJrlN2YQVm8y0eHwW3BjOP5wxdTdXLkSozuYL8
         4r/7UEzu7gcu58hLJyfoU6y98aQvwj8M3P4nAvrlBvgGUtWbmSLOQnPcFwMGIxgiB/id
         GW3w==
X-Gm-Message-State: AGRZ1gLAKDuS7LdAvnj6UgZwSTcBDG3T7Og+umlt9SdQqbPUuiW5p1zW
        hXE/BOZwlUT4U1eBI46AY/pl6fjPYbyeSI7hf8vP4A==
X-Google-Smtp-Source: AJdET5cmUfOTmRt5TlXMacbNF7qpMHi6AbpOBIrerF8iDxN957kLV9AE4Z7CoPtH3VvTzorXqorLl2lk7heH59o160E=
X-Received: by 2002:aca:ddc3:: with SMTP id u186-v6mr5419887oig.204.1541121549964;
 Thu, 01 Nov 2018 18:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X5Wn76N34oBhRZvXKOwP0L_pF=LYbT6ugTgtPYSvnHg=MZVw@mail.gmail.com>
 <CAGZ79kZ6LxRevLy2mZd1Ag=oO_NtDdmRSuadswR_n=RGpO=rGQ@mail.gmail.com>
In-Reply-To: <CAGZ79kZ6LxRevLy2mZd1Ag=oO_NtDdmRSuadswR_n=RGpO=rGQ@mail.gmail.com>
From:   james harvey <jamespharvey20@gmail.com>
Date:   Thu, 1 Nov 2018 21:18:58 -0400
Message-ID: <CA+X5Wn6nP5sZh8Z2dcTZKpPBWG43nSUATcWx0fzp2dNTJ3UzQQ@mail.gmail.com>
Subject: Re: Using --word-diff breaks --color-moved
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2018 at 1:42 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Tue, Oct 30, 2018 at 7:06 PM james harvey <jamespharvey20@gmail.com> wrote:
> > I think "--color-moved" should have precedence over "--word-diff".
>
> I agree for precedence as in "work well together". Now we'd need
> to figure out what that means. In its current form, the move
> detection can detect moved lines across diff hunks or file
> boundaries.
>
> Should that also be the case for word diffing?
> I think word diffing is mostly used for free text, which has different
> properties compared to code, that the color-moved was originally
> intended for.

That's how I think of it too.  I think I'd be fine if word diffing
stayed not being able to be detected with moved lines across diff
hunks or file boundaries.

> >   I
> > cannot think of a scenario where a user would supply both options, and
> > actually want "--word-diff" to take precedence.  If I'm not thinking
> > of a scenario where this wouldn't be desired, perhaps whichever is
> > first as an argument could take precedence.
>
> word diffing and move detection are completely orthogonal at the moment.
> Instead of option order, I'd rather introduce a new option that tells us
> how to resolve some corner case. Or in the short term we might just
> want to raise an error?

I'm fine with option order not mattering, as it does now.  Was
assuming it didn't matter now, but mentioned trying it in case it
worked that way.  And, mentioned it as an alternative in case it
turned out the two could conflict in some corner case.  I think
defaulting to resolving one way or the other with an optional option
to go the other way makes sense.

> > (The same behavior happens if 4+ lines are moved and
> > "--color-moved{default=zebra}" is used, but below
> > "--color-moved=plain" is used to be a smaller testcase.)
> >
> > [...]
>
> This sounds like you are asking for two things:
> (1) make color-moved work with words (somehow)
> (2) allow the user to fine tune the heuristics for a block,
>     such that default=zebra would still work.

I was asking for #1.  #2 might be a good idea, but I just tried using
"--color-moved" for the first time the other day, so haven't used it
enough to get that far.  If they worked together, I'm not sure yet if
I'd be using plain or zebra.  I mentioned "4+ lines" because I can
remember something said zebra only worked with more than 3 lines.  Not
sure where that was.  I thought it was the manpage, but I'm not seeing
that in there now.
