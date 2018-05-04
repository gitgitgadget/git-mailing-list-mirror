Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 924F1200B9
	for <e@80x24.org>; Fri,  4 May 2018 16:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbeEDQak (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 12:30:40 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36131 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeEDQaj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 12:30:39 -0400
Received: by mail-vk0-f68.google.com with SMTP id i185-v6so8556699vkg.3
        for <git@vger.kernel.org>; Fri, 04 May 2018 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xXlYRmphn87uE0X8rMmjtkOmeuaLYdyLjS+bmdceAUM=;
        b=B40+ACa/z5fJ9FaJ3cT3l263EX/ZSpeMUDwLRzjAejFyOxaeehEN8RRlMGafU1kPnj
         bP4SxQE0FY60Ghxjcx5MkhICv/L4vPGaEsu4h+vLMRzx/WuddvYy95sNrZx9kC2kxaqL
         oIUkhcfp0Wh+NqhXoUuVXJK7YzGZF4lx8MLBMjgATnaRMd1PRy1kziOweeBbtr8aRjqJ
         070aXkaYtyg7WarapKUBm5xkABr+4DomrI+xg6x9eaysivPDVPl9dgTIROk0irGe/puA
         nI7TrIwCaKjvG69y06q3kKmwEHpKis/wfAVyrABVzJufecxSSxzulci0X/IHZuJ9W2BT
         13XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xXlYRmphn87uE0X8rMmjtkOmeuaLYdyLjS+bmdceAUM=;
        b=W6RlDTrOrq8iLV/HBO1uIANVWMesGCvX0S3EJkDhH9WQReGv8GlbrE/t2aNLoWnXAQ
         pKApLYk04WqqQ6ZbHk80TwjrVEFYusvhjJAIrxPPtXTVdynfhSSFKDwFKpghwFy+OkdL
         nnn6vytq0lCR7EJ0/MtTnrypIA7ogoFsWsx2THhs71cHVutPat3eY4sy2Eax1tIFxbuf
         1PQLBfyFtfZtC4RQduERbnpfYkxLLAFH0Nx8X+BiLEVJDrtk68yxZsex4TpFc67mQtQq
         ZUZF8oamLSItOUjmoTUhKCFmCSzt0SB1NwJ0dHSDppl7zedauTlWujKpAGD2wWxgtxZG
         Nc5Q==
X-Gm-Message-State: ALQs6tDFPQIFmY+TlURV4VzlNvRrdn/uMB+0gsIeaBSP8XhXf4BFfGXt
        OBRR6Gbmx5x7FSKYN5m2bmf+2Z43KeAqVHEka2M=
X-Google-Smtp-Source: AB8JxZrOzfiwO0q/6WorjJNQtf7fjphscvPBQQEtGonDRSpf27kibEgcQJL2Y1ANptr9ZjGxLmYkJat+1I7GyJ9L5Kc=
X-Received: by 2002:a1f:824a:: with SMTP id e71-v6mr24050507vkd.7.1525451438525;
 Fri, 04 May 2018 09:30:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 4 May 2018 09:30:37 -0700 (PDT)
In-Reply-To: <CABPp-BEEgeo=5hkaTe8LrOMONSv3VdPi_cP4ADMC69oG3htC1g@mail.gmail.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de> <CABPp-BEEgeo=5hkaTe8LrOMONSv3VdPi_cP4ADMC69oG3htC1g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 May 2018 09:30:37 -0700
Message-ID: <CABPp-BF_F2rzmyP+1C7=ucM25DGP6w-u2Qd7QNMUcdtGjwZs2Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Add `branch-diff`, a `tbdiff` lookalike
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, May 4, 2018 at 9:21 AM, Elijah Newren <newren@gmail.com> wrote:
> On Fri, May 4, 2018 at 8:34 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> The incredibly useful `git-tbdiff` tool to compare patch series (say, to see
>> what changed between two iterations sent to the Git mailing list) is slightly
>> less useful for this developer due to the fact that it requires the `hungarian`
>> and `numpy` Python packages which are for some reason really hard to build in
>> MSYS2. So hard that I even had to give up, because it was simply easier to
>> reimplement the whole shebang as a builtin command.
>
> tbdiff is awesome; thanks for bringing it in as a builtin to git.
>
> I've run through a few cases, comparing output of tbdiff and
> branch-diff.  So far, what I've noted is that they produce largely the
> same output except that:
>
> - tbdiff seems to shorten shas to 7 characters, branch-diff is using
> 10, in git.git at least.  (Probably a good change)

Sorry, a quick self-correction here:

tbdiff, when using an actual shortened sha, uses 10 characters.  But
when a patch doesn't have a match, tbdiff seems to use seven dashes on
one side in lieu of a shortened sha, whereas branch-diff will use 10
characters whether it has an actual shortened sha or is just putting a
bunch of dashes there.  So, this is definitely a good change.

> - tbdiff aligned output columns better when there were more than 9
> patches (I'll comment more on patch 09/18)
> - As noted elsewhere in the review of round 1, tbdiff uses difflib
> while branch-diff uses xdiff.  I found some cases where that mattered,
> and in all of them, I either felt like the difference was irrelevant
> or that difflib was suboptimal, so this is definitely an improvement
> for me.
> - branch-diff produces it's output faster, and it is automatically
> paged.  This is really cool.
>
> Also, I don't have bash-completion for either tbdiff or branch-diff.
> :-(  But I saw some discussion on the v1 patches about how this gets
> handled...  :-)
