Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2E361F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 06:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfKNGhd (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 01:37:33 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:40447 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfKNGhd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 01:37:33 -0500
Received: by mail-pl1-f174.google.com with SMTP id e3so2168456plt.7
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 22:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3rPC/3V4hAlqK9iSmJxB7kaUkNBDMvO1bXiYcqOoJkY=;
        b=n6VS/L2FllBtlBHoS0dPHnLw2QAyRto7tzNzD70roT1n3b5AKcF/3HygaxgNPz1Dbz
         VOOPs5HME4VPIPD7rUpTuPuZdMvrLsMYZIiz1S3vm7JMspK2J+bcdK1AqqNZEyMsyjX2
         wCSt8dX9/z/3l5ACieacHK17ds1KWZNMFgrEjyZ0CNTX9TnwYtusTb9o1nYV8p64ykU5
         b7vv2zqHKGEDxcFlbtVy+Rt8F0hQ30i8a7ohjkyRa9jDUxT5VDh3F5r4+mgbHaTSpezu
         gzgiZ29/+W+vTfky6d2coGNA7Zr26CIe8JdUc95AZpz6SiYAD2T46tROyxuMH2HB7GgM
         g4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3rPC/3V4hAlqK9iSmJxB7kaUkNBDMvO1bXiYcqOoJkY=;
        b=RxV+B/dZs/YpDD8pkOi0nsITK3LV6yGQIh/1LP9ms3rxFrMbK2G0umM4Uev4x3Lzzf
         yYzdKshG07ROu8A1F3EE+Lnw9JtXf61Hv2g0C88GA5JV/PdAvhNQLN1cu3uDM6AQBbFx
         oXxBBzHA0jr++AojTd615J9R0FU88rkYAfcOhwx7+U/DvcSmeSJMrkfdYvZTzjBzCtdN
         E0N3GE5/IHXUA5A9efAS4chtuuupxs8o9lND6oxTb9OaRcz0PLpFXwvsMhUY8/QPwZG6
         QCqpUqWTxz27Wh8/Zkp6cTj0EmXAldmrCwIP98cYg0IrG/yzx+maCM8aoUllIo6iy8kQ
         bJ+A==
X-Gm-Message-State: APjAAAUKH/xvlmDhOMd5xassHeeqSxwJDf0zOfPjeurSiFS2BkMTzaDR
        ZoOLr/20/FO4cGv9Arkd1jUBZ6uEqrcc2qK3uQo=
X-Google-Smtp-Source: APXvYqz//Eojd8RFLNJR/snFSAuD77O0K8joxtiq0n/AY5jREZwNbGo2Oi2BLVFJtmiVPSkZnI0JSqJZAJDk5UP3t2w=
X-Received: by 2002:a17:902:8508:: with SMTP id bj8mr5180889plb.178.1573713452179;
 Wed, 13 Nov 2019 22:37:32 -0800 (PST)
MIME-Version: 1.0
References: <f867512c-e5b2-6bca-2a37-2976f4c182bd@web.de> <20191112175926.GA41101@generichostname>
 <CAN0heSodNonkDK8AT9iJqmWLLCdO0OoHho0ijZOAmri5ren2dw@mail.gmail.com> <ff240bc1-ae2a-17e5-d149-2d08c5367e96@web.de>
In-Reply-To: <ff240bc1-ae2a-17e5-d149-2d08c5367e96@web.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 14 Nov 2019 07:37:20 +0100
Message-ID: <CAN0heSqyGwkeGKv0m_gLDooaUp=gN2_tD7kJYNxeL7LALiPRhQ@mail.gmail.com>
Subject: Re: coccinelle: merge two rules from flex_alloc.cocci
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 Nov 2019 at 22:10, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> >>> This script contained two transformation rules for the semantic patch=
 language
> >>> which used duplicate code.
> >>> Thus combine these rules by using a SmPL disjunction for the replacem=
ent
> >>> of two identifiers.
> >
> > My knowledge of coccinelle and cocci rules is basically zero,
>
> Would you like to change this situation eventually?

Possibly, yeah, but I think the key word there is "eventually". ;-)
But maybe I'll learn something from this exchange.

> > but my impression from this list is that running "make coccicheck"
> > can be expensive, both in terms of time and memory.
>
> The desired source code analysis to detect possible software transformati=
ons
> needs additional data processing resources.
> It is usually hoped that corresponding efforts will help with development
> approaches at other places.

Right. So by that logic, if this patch doubles the memory usage and/or time
consumption of "make coccicheck", wouldn't this patch be affecting those
other activities at other places of the code negatively? ;-)

I'm not saying that this patch DOES affect the time/memory usage
negatively, and I'm not saying this patch IS a net negative. Definitely
not. It's just that considering, e.g., 960154b9c1 ("coccicheck:
optionally batch spatch invocations", 2019-05-06), time/memory
consumption -- and the balancing of the two -- seems to be an actual
real-world issue here, worth thinking about.

(That commit message mentions that processing all source files in one go
requires close to 2GB of memory. We've since started processing more
files.)

> > Do these patches help there in any way?
>
> I hope so to some degree.

If you could have some before/after numbers, that would be cool. If you
collect your patches into one series, you could at least do measurements
before/after the series.

Or if you could make some other sort of claim around "this shouldn't
affect this-or-that because so-and-so".

> How much do you care to avoid code duplication?

I tend to like it, everything else equal.

> > Or could they hurt?
>
> I assume that you ask according to the presented change possibilities
> for Git's SmPL scripts (and not only for =E2=80=9Cflex_alloc.cocci=E2=80=
=9D).
>
> Some changes usually contain the risk for undesirable effects.
> Would you like to clarify each of them in more detail?

Do you mean whether I would like to clarify the risks I see, or do you
mean whether I would like you to clarify which you see? I've tried to
clarify the one I see -- based on passively observing cocci-related
patches floating around this list. If you see other potential risks,
feel free to mention them.

You seem to know lots more than I do about these things. I wouldn't be
surprised if you know more on this than most or all other participants
on this list, so feel free to share some of that in the commit messages
so that others can understand how you've reasoned.

Martin
