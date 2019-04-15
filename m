Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D2F520248
	for <e@80x24.org>; Mon, 15 Apr 2019 17:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfDOR0P (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 13:26:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38248 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfDOR0P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 13:26:15 -0400
Received: by mail-qt1-f194.google.com with SMTP id d13so20076088qth.5
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 10:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19Pr/Pf2dnaTIGROfqo85vDUU54+d7B7UaNHbGuj0w0=;
        b=Gic3LI5dmU8x+yghbgEOwZroL3jfiYWxvnssgTXgrgv0U3zmwA+ttkROUYUiMyzxqi
         DTmxNbB1Hb/l3Nz7o0CQJRggWHUBJd2pSLIlObb87w87nyktm8JmgnPAg+525KVhC1Gi
         TGDD+qBr5gwPzzg41CE7JkZlMd7SL8au+8zrES1Om+4Sjm/3bGhIAxFdktqIMCgotMlt
         4IZhrROm5LadBWLxSOWfyktdm3oRAslGsFxBqMr/9cNph2ZBY0VS25L6thB5nzn9R5eZ
         ZXhFTFCym7CggZNOGgSPKfAxy0lP6rGUtNfxYy6HjvRGExjMwIjP8l0CICRVoXJDgLyd
         uIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19Pr/Pf2dnaTIGROfqo85vDUU54+d7B7UaNHbGuj0w0=;
        b=MWYHjGvXBnSuUWV0lL0ws4W5Kk4cSVKhA/datAKseJ1vw50ZPj4hIiYMwrQiKAPtz8
         FSCUAxWuQqyTNrj0RgqdWL80angUo7cPICAbFXfLC+ZHRT14PyMMagd78FIT6VVi93xA
         7fHLcAnS1VpTsbJHQgvE0mEQhcPCPdys5hfOyJTiOGyfPXYNyOtJS5U2WdTlEZQfdb3y
         zJ4XxjcwpEG4hUiglS7Pl1M6sIiFeviqiDFIPqiY4Xxr7q6pIoIcrneSM4OnDjE05o1g
         Q35JE/TRUei8qArs0ZAOIv254VUM2Kj/YH+scHFwSWpVSpC2S4TFFFldzazmNr3hYhnT
         q05g==
X-Gm-Message-State: APjAAAXcr9Bua7jXMJU7p6XKbyx2OHfZeG/8ANQ5/oHaxVtyaZBXUlYv
        zxQXJKDfRbIcVe+2zZ/96MEF8a381onC+jDL28p+Gg==
X-Google-Smtp-Source: APXvYqwa8f5JKuzSOQxKUq4BnnnvmDxv38yOKiGrMCLNlCUqcZjMKVBg9LwmBIpdMo26FcMZLfklMxhW+AInUnCDsuo=
X-Received: by 2002:a0c:d498:: with SMTP id u24mr61988246qvh.117.1555349173656;
 Mon, 15 Apr 2019 10:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.177.git.gitgitgadget@gmail.com> <8b71fe78719aa40feee509e6a6229775daa79a2f.1555007520.git.gitgitgadget@gmail.com>
 <xmqqef67zz7u.fsf@gitster-ct.c.googlers.com> <CAJoAoZnY8hQmxPBcFFZEonQvMLT6x2xrfupy7+gcu+uUN1h1cg@mail.gmail.com>
 <xmqq8swexy3v.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8swexy3v.fsf@gitster-ct.c.googlers.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Mon, 15 Apr 2019 10:26:02 -0700
Message-ID: <CAJoAoZkj_95ZWSGQ1Rpj02OAu==Wz=e4sFZnvuRr0dFQk3ZP8Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] documentation: add lab for first contribution
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >> ... then leave it in your example, perhaps?
> >>
> >
> > Good point. :)  I had wanted to avoid including my own name/email in the
> > tutorial; I used a throwaway "Git Contributor <very@smart.dev>" for the example.
> > ...
> >> Keep a sample sign-off by "A U Thor <author@example.com>" here.
>
>
> No, use "A U Thor <author@example.com>" as I suggested.  That's the
> author ident the aspiring Git developer MUST become familiar with
> while working with our test suite in t/.  There you will also find
> the counterpart committer ident to use, if needed.

Done.

>
> Just FYI, I rarely give a "do it exactly like this" suggestion;
> often I instead stop at giving a general direction and leave it up
> to the contributers to perfect it.  The "A U Thor" is one of those
> rare cases.  On the other hand, "fork" was *not*.

Sorry about that. I've found it's good practice to "show, don't tell"
when I make review
comments to avoid confusion, which isn't quite the same as "do it
exactly like this"
but looks similar on the box. So I guessed wrong this time. :) Will
push a fix with it.

>
> > Do folks on Git project usually engage in test-driven development? I
> > would be happy to move the test up towards the front of the document
> > and mention the usefulness of TDD, but not if that's not something
> > emphasized usually by the group..
>
> I have no strong opinion on this myself.
>
> I suspect that the developer would clean up with "rebase -i" by
> squashing before submitting the result of a very fine-grained TDD
> workflow, as nobody would want to read printf("hello world") in
> [PATCH 1/47] that would become a real feature in a later step.  So
> if the tutorial wants to go into that tangent (which might be too
> much detail), it may be worth showing from the first few commits,
> but otherwise a sequence that pretends the reader to be a perfect
> developer who does not make any mistake in the middle may be more
> concise and more readable.  I dunno.

In that case, I'd just as soon leave the order as it is. I think that
a developer,
outside of the context of a tutorial, will end up writing tests in the
order they
prefer regardless of the order of a tutorial they did one time. Maybe I can add
a note about tests being required for incoming patches to discourage readers
from glossing over that section.

>
> Thanks.
