Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDDC520248
	for <e@80x24.org>; Sat, 13 Apr 2019 05:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfDMFjf (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 01:39:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35072 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfDMFjf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 01:39:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so1576518wmd.0
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 22:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VC38Fk7YzYBt+5FN2M7WHA8bvzveVvXI/0YV85FYvLI=;
        b=B0j8bZ+B5WpmJxfNNJ/GiLPW2ccMAceMl2cffCjxj4jcIv4FbgUaPiJi4biH1fMHWM
         EBTUYmfMb99M6X1xSEXxhMNmOhxx77P4DbJR7JUODYM7dvmeEppgGAhYty9hmbrDmPX0
         qMHpe8LM54y1WggocPpj7QbbXbgQHs0fHww85GQ9BG/P7BvBWINBdF6xpVhQ0gAyr3wO
         VufDjmCZYHh8Z0sn2D3aD795EaOTvjp1niPFd5PpKC7u/58nf2gf2lVcVEv1Al3wejjH
         LThAZ77zwiH7zR/5PL9rq/T70QFkm27RRQ+Xe+B0GzrrhZlHXhBouXFmNgoyJeOxXcod
         lNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VC38Fk7YzYBt+5FN2M7WHA8bvzveVvXI/0YV85FYvLI=;
        b=L1ny27Xl4xChMIQuP4Hogm4XJo8e6PQqhiUwsjTaxocUJYw8AIPtkjhQikPVMM0TAt
         1/xw6kIecQqnjGZRz5NgZmUDn12Uz/eJ+INsDl1yPS6g+q0BQSagWNx/Z/fYG1odsdaY
         SaOfZzcGBNFva2DwwqC1gbDhKuOQPnQf1xPW/fAQZe7OGDiDbaFOHnDrLiX0sgNQzn9S
         U6SHG4Rc4THF3R4cld8NecrEN2aUcWSEmQnHPeXI4IJiiQk7DXnDR7hr4tFcCU3S7QVd
         7XoVmQEiFTK7dLV4X9Us8oK5h7B7YeP92QBJhbzfeb2pQnyDO9cu1irs8GTjA+8IyLOV
         wiJg==
X-Gm-Message-State: APjAAAVmJoFyuUmmNb1fuRKp0atB5bGP25KzuSr/m+J9qrl1bgy9JKBr
        TPJvrSwqDyRg3eOEzpzo5hA=
X-Google-Smtp-Source: APXvYqwiVd9nwUz+50QFR9LCgPkrtOhuti6E3SmRGSNXoCdhbMuRn8//bNPH0CLdmGP6XQVTOXR3mw==
X-Received: by 2002:a1c:7512:: with SMTP id o18mr14327873wmc.68.1555133973259;
        Fri, 12 Apr 2019 22:39:33 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id n6sm17859293wmn.48.2019.04.12.22.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 22:39:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Emily Shaffer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] documentation: add lab for first contribution
References: <pull.177.git.gitgitgadget@gmail.com>
        <8b71fe78719aa40feee509e6a6229775daa79a2f.1555007520.git.gitgitgadget@gmail.com>
        <xmqqef67zz7u.fsf@gitster-ct.c.googlers.com>
        <CAJoAoZnY8hQmxPBcFFZEonQvMLT6x2xrfupy7+gcu+uUN1h1cg@mail.gmail.com>
Date:   Sat, 13 Apr 2019 14:39:32 +0900
In-Reply-To: <CAJoAoZnY8hQmxPBcFFZEonQvMLT6x2xrfupy7+gcu+uUN1h1cg@mail.gmail.com>
        (Emily Shaffer's message of "Fri, 12 Apr 2019 15:03:16 -0700")
Message-ID: <xmqq8swexy3v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> I like this suggestion, but don't like the use of "fork" as it
> somewhat conflates
> a GitHub-specific term. I'll take this recommendation but use "create" instead
> of "fork".

The verb "create" is not incorrect per-se.  It stops at saying that
the result points at the commit that happened to be at the tip of
the original when it was created.  But it lacks the connotation that
the resulting branch also knows that it is meant to eventually be
merged back to the line of history of the original, which "fork"
conveys.

The word "fork" is pretty well established in that context of
talking about a branch, in the form of "--fork-point" option of "git
rebase".  It is the point where a side branch diverged from the
mainline.

So I dunno.

        Side note. By the way "fork" is in no way GitHub specific.
        A random list archive search gives us this from 2007 but I
        am reasonably sure that Linus kept using the word before I
        took the maintainership over, in the context of talking
        about "distributed nature of Git makes the 'maintainer'
        honest, by allowing others to fork and become the mainstream
        if the maintainer does a bad job".

        http://public-inbox.org/git/alpine.LFD.0.98.0705010829180.3808@woody.linux-foundation.org/

        So it is fairly well understood what "fork" means in the
        project management sense around here in the Git project.

        In any case, that is a tangent.  That possible "conflation"
        is about forking the whole repository, but the example is
        talking about getting a single new branch to work on, so in
        a sense it is an apples-and-oranges comparison.

>> ... then leave it in your example, perhaps?
>>
>
> Good point. :)  I had wanted to avoid including my own name/email in the
> tutorial; I used a throwaway "Git Contributor <very@smart.dev>" for the example.
> ...
>> Keep a sample sign-off by "A U Thor <author@example.com>" here.


No, use "A U Thor <author@example.com>" as I suggested.  That's the
author ident the aspiring Git developer MUST become familiar with
while working with our test suite in t/.  There you will also find
the counterpart committer ident to use, if needed.

Just FYI, I rarely give a "do it exactly like this" suggestion;
often I instead stop at giving a general direction and leave it up
to the contributers to perfect it.  The "A U Thor" is one of those
rare cases.  On the other hand, "fork" was *not*.

> Do folks on Git project usually engage in test-driven development? I
> would be happy to move the test up towards the front of the document
> and mention the usefulness of TDD, but not if that's not something
> emphasized usually by the group..

I have no strong opinion on this myself.

I suspect that the developer would clean up with "rebase -i" by
squashing before submitting the result of a very fine-grained TDD
workflow, as nobody would want to read printf("hello world") in
[PATCH 1/47] that would become a real feature in a later step.  So
if the tutorial wants to go into that tangent (which might be too
much detail), it may be worth showing from the first few commits,
but otherwise a sequence that pretends the reader to be a perfect
developer who does not make any mistake in the middle may be more
concise and more readable.  I dunno.

Thanks.
