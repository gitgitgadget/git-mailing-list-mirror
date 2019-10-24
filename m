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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D89D1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 10:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438905AbfJXKn3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 06:43:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40688 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436873AbfJXKn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 06:43:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id p59so9841910edp.7
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 03:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xUorVOksiivfn8lpkL9cHc813wTBppw4ExXZGElZE9g=;
        b=fCIsILC36gyjGhlwExQ25enlVt1OXZRq1aDWG2Ci0X3iecFv8pefq2/4t9hXaEatTC
         f0styAI5tiDWZCiEdpSo3k+Hb8jHiN976C3wTw1dxgfOT2sE3OSqA3dGQluzLeosdgnE
         tIrAj2A1uuwqyMTW9CQD71yr+CrzJ6sssHHs+furWwe8fdlrxMBhumEZuRia2/cyrPQr
         8hACLNNoRoT3nThuuUFpK8kQ0MJz/K2KPLIRqgcvl0p8TwBRkSQzcBXI+SJHNJkqTmYl
         iScKz8cgaPI+yKt7VgmODgFjPFWe7Wu7Gx2jkwnXY6SqQhT5oRV5xIO3sfM91CwfvJd1
         weKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUorVOksiivfn8lpkL9cHc813wTBppw4ExXZGElZE9g=;
        b=ujV2oFSvfpa1sktRf0XFBCpWS3cmu5tHaSnKWbVJXN3yMv73xDxA+RIf9M2DGiChQ1
         m4IRnbygzi/xAULeVHBtvQRnE8Y0JnrIxuufXXUCQm6XqZau5guukEH4VCffOb+jgtNq
         vMbr7tV8yg8H0vLUyJXIKQ83lX1UFTcqDFNzqe/uKdrFm73kjIfEBM/+d/uf+AYZ1pt4
         o7qKhBEKmqDJUqehPCvDY/+BjhDeEZkfBWzkk+XiajBjWp4k21VNeZGzGdA/K9O8E6Dn
         MSyakSRk1tkIqK28DyDosSqsupgTuLk37zlse2jPHpIgu4hWQCU7INUzCHt0jIzrkhXZ
         Rpng==
X-Gm-Message-State: APjAAAVTDZiAUZ5LLmpdGNgF3Ofid32jjopJfHJixdu7D2KFWO/PpPnU
        tdkaBiYB0b+Yi7bC4gmeawu/Gr2JFfhMtZtaxShe/NKG
X-Google-Smtp-Source: APXvYqxCwCWXsc1Lnp+19F/Td9So2PFtBNUZro/Zw874P59x8y9aYpsWEGLRu1Bu+mr1wkmsoBxlJFO1lXv8vLox4zU=
X-Received: by 2002:a05:6402:1006:: with SMTP id c6mr15299275edu.2.1571913807048;
 Thu, 24 Oct 2019 03:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.412.git.1571768375.gitgitgadget@gmail.com>
 <pull.412.v2.git.1571815556.gitgitgadget@gmail.com> <5cd79e24fe6bde7c5d10e1c2cae660858e3c4051.1571815556.git.gitgitgadget@gmail.com>
 <20191023214404.GB124161@google.com>
In-Reply-To: <20191023214404.GB124161@google.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Thu, 24 Oct 2019 23:43:15 +1300
Message-ID: <CACg5j27yUxR9aPWH8-ji==wx6GcNcEGYQwK3wn+T6-UtLkJqpA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] documentation: remove empty doc files
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 24, 2019 at 10:44 AM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Wed, Oct 23, 2019 at 07:25:56AM +0000, Heba Waly via GitGitGadget wrote:
> > From: Heba Waly <heba.waly@gmail.com>
> >
> > Remove empty and redundant documentation files from the
> > Documentation/technical/ directory.
> >
> > The empty doc files included only TODO messages with no documentation for
> > years. Instead an approach is being taken to keep all doc beside the code
> > in the relevant header files.
> > Having empty doc files is confusing and disappointing to anybody looking
> > for information, besides having the documentation in header files makes it
> > easier for developers to find the information they are looking for.
> >
> > here's a list of the files removed and if the info can be found in the
> > corresponding header file:
> I think you can remove the above; in lots of composition contexts it
> tends to be bad form to say "Here is <something>: <something>" - don't
> warn us that you're going to present it, just present it. :) (Or, at
> least, this has been drilled into my head by many high school English
> teachers...)
>
> Maybe you could say something like, "Some of the content which could
> have gone here already exists elsewhere:"  If you take that suggestion,
> you can probably move grep.h to the bottom, as it's the exception which
> doesn't have content that exists elsewhere.
That sounds better. Okay.
> > 1- Documentation/technical/api-grep.txt -> grep.h does not have enough
> > documentation at the moment.
> > 2- Documentation/technical/api-object-access.txt -> sha1-file.c and
> > object.h have some details
> > 3- Documentation/technical/api-quote.txt -> quote.h has some details.
> > 4- Documentation/technical/api-xdiff-interface.txt -> xdiff-interface.h has
> > some details.
>
> For this list, I think you can remove the numbered bullet, and the
> leading "Documentation/technical/" - we can see the files deleted from
> the diff.
yes.

>  - Emily

Thanks
