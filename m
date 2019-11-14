Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A67E51F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 10:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfKNKOP (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 05:14:15 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39040 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfKNKOP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 05:14:15 -0500
Received: by mail-ed1-f68.google.com with SMTP id l25so4511342edt.6
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 02:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kcDapeMbl/FlR5iP1x+rpmFLYc6Opa+96kIyPj74aGY=;
        b=uqU/CtcOX0ZkPWNL6pw5mmHHb8VAIAOb5N2ASPiAqsCRStLMPoxyibxwq7vkrhrM/m
         PQgSWU+itE1sJTt4rg4NWI8v744dwMLaJwNTzsQlCpZWGEgQ0ASLlqY5rR5ZoJ9Lsd8q
         o+a+8aYqBCpleS0nrkPfRRvIDvu7C8kvGIC2AqhZMGVtKefnTs/9Py2ZmwAqX+X1mhfE
         vbGW004iQ/8UtCEVo4Fcrxcq5/7RggETGdgJQVj/bhByP6RyMJqxn/m8x1Vk9a6iwjK/
         6X+HLhImn13DjOlZ7RkfI2J/CujMlS5o8LfqcWYvxOV3Q/YAVvbkHHetyHCe6paBpq8K
         iV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcDapeMbl/FlR5iP1x+rpmFLYc6Opa+96kIyPj74aGY=;
        b=HgdxTgEG3hEg7Bb7PS5ZT+05dECLad9/zCAxJ3Jo0Qci7dzLb4U5wlAasAdiMNRccK
         jjlTqFQvUllQNvDim/DBSrdMfZWDZNqLFHbse0hrigNcuQIwSO6sJblTKHwzbd4YZNCM
         LRxJNlSwEA0iuW37lF17dThMqTlnqBpv9x2Vv7mYZtCu2zD1zMtEkKMA1pH2/ZUGOOvn
         pM45QeSsD7DxNCvh1QC/XdPtAm2OGV2tmCMrd5/dhVwxgbPorMjs7c4Jph9R6ivOVCLC
         NooSKBPRXJiY04WMBlbHNlW952glH+QqqJkG4gftGaN34yKLy31Tq3ydKzb5phDVxAGF
         rUzw==
X-Gm-Message-State: APjAAAUbgJ02wg0M73i/B/UuN4/U5yG6lCuLZT/Yir1w/MViSnU5VcR/
        ajj40GnMg+jb4pnS5p9e82qkkjL6/dX327sHIdA=
X-Google-Smtp-Source: APXvYqzlNjwizefLcA3TXH2QpWu75XT+7LZxNMeyRBe+UTW8wvBC63qn6s1vGHWp7ef+Rn2r67crBMRREDb/o+jF/T0=
X-Received: by 2002:a50:fc02:: with SMTP id i2mr239588edr.284.1573726453588;
 Thu, 14 Nov 2019 02:14:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
 <pull.434.v3.git.1573507684.gitgitgadget@gmail.com> <1eca7099efeb6f57be646351d19baaf636a31b2b.1573507684.git.gitgitgadget@gmail.com>
 <xmqqr22defr4.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr22defr4.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Thu, 14 Nov 2019 23:14:02 +1300
Message-ID: <CACg5j277BBsEePzBWFL1rC_R4vC57v3dzUVhQ32WJKxxt_W8LA@mail.gmail.com>
Subject: Re: [PATCH v3 12/21] cache: move doc to cache.h
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 12, 2019 at 8:05 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> > diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
> > index 321c0ba6a4..6629122703 100644
> > --- a/Documentation/MyFirstObjectWalk.txt
> > +++ b/Documentation/MyFirstObjectWalk.txt
> > @@ -119,9 +119,8 @@ parameters provided by the user over the CLI.
> >
> >  `nr` represents the number of `rev_cmdline_entry` present in the array.
> >
> > -`alloc` is used by the `ALLOC_GROW` macro. Check
> > -`Documentation/technical/api-allocation-growing.txt` - this variable is used to
> > -track the allocated size of the list.
> > +`alloc` is used by the `ALLOC_GROW` macro. Check `cache.h` - this variable is
> > +used to track the allocated size of the list.
>
> Trailing whitespace.

Right, thanks!
