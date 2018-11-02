Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1A101F453
	for <e@80x24.org>; Fri,  2 Nov 2018 17:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeKCCgC (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 22:36:02 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43618 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKCCgB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 22:36:01 -0400
Received: by mail-ua1-f68.google.com with SMTP id c89so914483uac.10
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 10:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fDEE32f32dUvS0DqY6i1WGBvfvMEAi2UtkIQ7RX/zlA=;
        b=NfwX8xVvPqpRneL7jDQpRzuKRspXI+bNynnHgYhyyds3OhRuUeeKe2fFY71qZqzRo2
         AY/JMO5xnW2h2kMiKPr8i8ghj/aM0bPduDNwH6BNGWzuATRXhuy+lPANeoxEsPChJn+H
         IXTwuX6I8apwaI+W8BI8G/jjUiRZGJF1nQH5qQmT6Bis+t++ojgXmpguFHtTJ9BjHgJf
         9L0NID7vlIXx5638evMpgTmemZn6pNo6OKkbkqo3yc4m8gx2saq6J5aTiarxn0SuCqWb
         HLBqPDrOPAPYsKcfSQip3dK5CCym1rINgmtrJFX5+4EpVcgOcQI9Ugo5v4TqHv/psTl6
         jT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDEE32f32dUvS0DqY6i1WGBvfvMEAi2UtkIQ7RX/zlA=;
        b=kz4GFOxrcIoVkxYSLlJGlovqi0txAHbWoDxlxK1PxVjYs8u+5Hi+OI0z7RE14NO7Ru
         f30QiqTRi1aiLDIRDwmUwEut2JruhltyDtH5Yo0PG8WofaqT5DCr5cmamLa64DhCMrDG
         n6+I5FB75WmdLVN85Okjl3RxRFXy4VoMaejnyNvLQRXRASexYqR3dXnnAtNEhvvPO1U3
         IclUHNgI4TIeSfcqWBLn8TqnJMtHROa6EO6Oq0wIRSJ4Yc+rP5DJDS0892TPkfsUO4LU
         88ik/Njg1KlQZLsO4VNLS6cq4r0+JOMU/RSQQYb1x8E6pfEYyOPGZDLTqUbtL5f9ZAeG
         NY8g==
X-Gm-Message-State: AGRZ1gLaWzhynuks7daJ2Eigw8osZymV+ev+SpC3+lcjKN2AvnR9MXsB
        nfwOCddgHj6TDmRyZZEmyF5Hm7YuPLsjKp0KDSU=
X-Google-Smtp-Source: AJdET5f4t+bbL3IiY5k7b5A/cuktUQXXlSDN8n8NPRNv45A86dkWNOIVXBmMwGMKmxi0KkisaWO2obXCurgEk+mAq8w=
X-Received: by 2002:ab0:60da:: with SMTP id g26mr240115uam.104.1541179686353;
 Fri, 02 Nov 2018 10:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181014020537.17991-1-newren@gmail.com> <20181019193111.12051-1-newren@gmail.com>
 <20181019193111.12051-9-newren@gmail.com> <d23b4e26-4df4-273d-a75c-a0af915a6e5e@gmail.com>
 <CABPp-BFZugCFDS_A7FrWdRhp7WO0m8jhsqbSnNCSUWnAVz7mtg@mail.gmail.com>
In-Reply-To: <CABPp-BFZugCFDS_A7FrWdRhp7WO0m8jhsqbSnNCSUWnAVz7mtg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 2 Nov 2018 10:27:53 -0700
Message-ID: <CABPp-BFwimcDhwMeFcTJLy-omXiBNzZApkyCnSSRfwXvKi2OUQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] merge-recursive: improve rename/rename(1to2)/add[/add]
 handling
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 1, 2018 at 12:01 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, Oct 31, 2018 at 8:08 AM Derrick Stolee <stolee@gmail.com> wrote:
> >
> > On 10/19/2018 3:31 PM, Elijah Newren wrote:
> > > [snip]
> > >
> > > +                     char *new_path = NULL;
> > > +                     if (dir_in_way(b->path, !o->call_depth, 0)) {
> > > +                             new_path = unique_path(o, b->path, ci->branch2);
> > > +                             output(o, 1, _("%s is a directory in %s adding "
> > > +                                            "as %s instead"),
> > > +                                    b->path, ci->branch1, new_path);
> >
> > I tried really hard, but failed to get a test to cover the block below.
> > I was able to
> > find that the "check handling of differently renamed file with D/F
> > conflicts" test
> > in t6022-merge-rename.sh covers the block above. Trying to tweak the
> > example using
> > untracked files seems to hit an error message from unpack-trees.c instead.
> >
> > > +                     } else if (would_lose_untracked(b->path)) {
> > > +                             new_path = unique_path(o, b->path, ci->branch2);
> > > +                             output(o, 1, _("Refusing to lose untracked file"
> > > +                                            " at %s; adding as %s instead"),
> > > +                                    b->path, new_path);
> >

So now I'm confused.  This block was not listed in your coverage
report[1].  And, in fact, I think this block IS covered by testcase
10c of t6043.  However, there is a very similar looking block about 30
lines up that is uncovered (and which was mentioned in your report):

            } else if (would_lose_untracked(a->path)) {
                new_path = unique_path(o, a->path, ci->branch1);
                output(o, 1, _("Refusing to lose untracked file"
                           " at %s; adding as %s instead"),
                       a->path, new_path);

covering it, I think, is just a matter of repeating the 10c test with
the merge repeated in the other direction (checkout B and merge A
instead of checking out A and merging B) -- and touching up the checks
accordingly.

However, now I'm wondering if I'm crazy.  Was it really the block you
had highlighted that you were seeing uncovered?

Thanks,
Elijah

[1] https://public-inbox.org/git/62f0bcf6-aa73-c192-d804-e6d69cac146f@gmail.com/
