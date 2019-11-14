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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BEC61F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 12:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfKNMWp (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 07:22:45 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40138 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfKNMWp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 07:22:45 -0500
Received: by mail-ed1-f67.google.com with SMTP id p59so4820564edp.7
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 04:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZlYG4cIfx5u1lDmaYEjzLDBrAr3epT3D+Hpms9YbIs=;
        b=uU1HNdbNRJOFxRf8IcAY5Jb7tBgE0ykVN/GxdWgozSyQTrZNfsSGiQDSAG9svw3hus
         a9Rd7vfa/nJCx5z7XdxiINGkPEN9hGOPDX2Z01W4Rrjq+fsKIrG6AMxO9AbLSNqffgr6
         0h7ohXgP49NAusMjdui0ut1iA61Od18DBNCgAPtekTI7qIUyg2Jaz0Ba+iCB6lBspkXa
         UOhRywHVI9zEnNCH+JGsvgx7wupSCf0yMbMgGUJ3goCM/P6+CKH79efVg52MMM18h+kQ
         Zf+JJmaL8CvgDmPX5WmQlLtUAIRPOYJ0iwjUyefXbV26nrdCdbjgRrodeSeRm4+lcq1F
         Rlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZlYG4cIfx5u1lDmaYEjzLDBrAr3epT3D+Hpms9YbIs=;
        b=mIyvp2NW8mT5XgBY0AvdL1QJsFppHNnsbfwbpDhwpe7I4MJmkVOZuTuALevet1ZQrm
         vxYt0LN3o45xp1qcaAcbO4P/ufoiLBeiPoGJLbewy1KboHuOaEgfjjWHiFE4KaH8ZEYq
         QE833Dwe0u23WBlSEvA01tC2z2QfowPENfVT+pZb7T7qrSKnekkZ2sytzY5reNY5vSf6
         t8y7V7AIAYiCOdTQ9moi1vShQvk1IrbXlwdvlOqtUzfdU3B+aZi7azPlQaV16U06LjPW
         3VZL6gjx1z8p3PB7RJ6kgYl15OnxauW3ZKQTWwVO8O2gfpxZb/8x/eoogP3Mruk5WiHz
         Nl7w==
X-Gm-Message-State: APjAAAUGm//cI+DCNvaw9jLAP3rY2JmoudwYYe1dpsc2uJ6WmXDg4haf
        +zJAh60986PqY4rFNZsvcfydUkNQV9E7S+cL7AJlcaI3
X-Google-Smtp-Source: APXvYqxYuO0KplbNZP62zV61+PW3lkdi5U74R2YlXDUWU4/vZik8OQS0N+FMgOH9s26tkHq8o3f9KCT+TOmmI6CtUYc=
X-Received: by 2002:a17:906:245b:: with SMTP id a27mr8328301ejb.192.1573734163167;
 Thu, 14 Nov 2019 04:22:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
 <pull.434.v3.git.1573507684.gitgitgadget@gmail.com> <60e80b545f0f74e6fb58b5b6a64ecf3c1bd02d47.1573507684.git.gitgitgadget@gmail.com>
 <xmqqmud1ef1p.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmud1ef1p.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Fri, 15 Nov 2019 01:22:31 +1300
Message-ID: <CACg5j26dp4CsZWEhYEzWB=fei05WcvaKqk6B3iCFb72YNn=qug@mail.gmail.com>
Subject: Re: [PATCH v3 01/21] diff: move doc to diff.h and diffcore.h
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 12, 2019 at 8:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Heba Waly <heba.waly@gmail.com>
> >
> > Move the documentation from Documentation/technical/api-diff.txt to both
> > diff.h and diffcore.h as it's easier for the developers to find the usage
> > information beside the code instead of looking for it in another doc file.
> >
> > Also documentation/technical/api-diff.txt is removed because the information
> > it has is now redundant and it'll be hard to keep it up to date and
> > synchronized with the documentation in the header files.
>
> > @@ -245,6 +370,7 @@ void diff_emit_submodule_error(struct diff_options *o, const char *err);
> >  void diff_emit_submodule_pipethrough(struct diff_options *o,
> >                                    const char *line, int len);
> >
> > +/* Output should be colored. */
>
> I am not sure the comment belongs here.  Especially if this was
> lifted from the description for COLOR_DIFF.
>
> Those preprocessor constants have long been migrated to 1-bit
> bitfields in the diff_flags structure and the documentation was left
> stale---description on COLOR_DIFF and friends this patch removes from
> the doc should be reused to explain these fields, I would think.

You're right, that comment was misplaced by mistake, it was supposed
to be a member of the diff_options structure, but that member doesn't
exist anymore, so I'll just remove this comment.

> Thanks.

Thanks,
Heba
