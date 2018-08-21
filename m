Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66A571F97E
	for <e@80x24.org>; Tue, 21 Aug 2018 21:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeHVAvs (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 20:51:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42034 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHVAvs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 20:51:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id v17-v6so2409555wrr.9
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 14:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mwIuE5FdlW5NI3wBrkG8xL+ONRZ292RS3nrqESra3Uc=;
        b=Pt1h43Kf7tH8obAoiiQci85Uiv7Qf6AXh/34V37aVqerWrc6OufsZeuEnQMBPrpUbW
         /uWJpTDRstu2LprxZYl3YrF0PnOjAMRSXdqXy1z1mgsKDMt9FAbpjxBck91quE1rS7h5
         Kxes8icpgJYWmIp47twFDStRP5uKhhykHU29ICGvNRU2nX05vkMVE0h8UP/KSi6UC0MO
         06dBucT/j+J1Xbq67ioC9kaa10S6FJxaCrxDlCBwY4tPQ//GrdFehvP5NGD29FHyR6xN
         AVlRxsOfGc/0e2baUHWmE0+392avvVhB0cqnZKvlX/qDWCbagQizSADWvccfJG8ABuuU
         kvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mwIuE5FdlW5NI3wBrkG8xL+ONRZ292RS3nrqESra3Uc=;
        b=smwJj1qT3ggysd6y2Rl85janB/RxwPgl/1fiJz6h6FMmu3UIR5j6rJrFztmphcOQMA
         wt+SzBF/jLfb1bam5BvjD6UElBgIuGMdUYPp4uPO1rCz0silIvgzAxDYhE5Spt24NIWU
         GjG1QlnPmJA2PFZkrPyoueoE94C5hJeYWVCYdvtX7FrNJ/elJ6MUeN400oWBU+LGt2Uq
         ghQJiVEvCsrQr543WPZV2fRd8okcxlQZk+3Xsph5trvhEULNndcKCzjA5h6vKY7sZ7tx
         TEg/4v4HcGzW593UdsaGtK4CNQkXJPiFUCu5UbnVW5DRPKFMxk8t+hm8vP4DySWJNit7
         TDPQ==
X-Gm-Message-State: APzg51CK8WC1irKwK5bwLOFpNco/fwN3kZ69exGtIzyyCQmb0dOrnNVH
        CCQIntzBd8gAVEF3dk78OFY=
X-Google-Smtp-Source: ANB0VdY86c5TLI1zodB5MESc0QLl40cvoAsFDSVy3oZgZReJ7DIaSILEjAPrLt8OinURPkfT5Wg8Ew==
X-Received: by 2002:adf:f112:: with SMTP id r18-v6mr2614444wro.29.1534886996392;
        Tue, 21 Aug 2018 14:29:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l18-v6sm459255wru.75.2018.08.21.14.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 14:29:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/2] commit-graph.txt: improve formatting for asciidoc
References: <pull.22.git.gitgitgadget@gmail.com>
        <pull.22.v2.git.gitgitgadget@gmail.com>
        <6cf253c2a6a091520e1376839dff8b97869c9808.1534879749.git.gitgitgadget@gmail.com>
Date:   Tue, 21 Aug 2018 14:29:55 -0700
In-Reply-To: <6cf253c2a6a091520e1376839dff8b97869c9808.1534879749.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 21 Aug 2018
        12:29:13 -0700 (PDT)")
Message-ID: <xmqqtvnn76i4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> When viewing commit-graph.txt as a plain-text document, it makes
> sense to keep paragraphs left-padded between bullet points.
> However, asciidoc converts these left-padded paragraphs as monospace
> fonts, creating an unpleasant document. Remove the padding.

That's completely backwards.

These indented two paragraphs that follow "... the following
property:" do not fall into the same classes of paragraphs as
others.  The way the text version makes them stand out by indenting
clearly show these two are what "... the following ..." refers to.

Perhaps these two would want to become a bulleted list or
something.  

>
> The "Future Work" section includes a bulleted list of items, and one
> item has sub-items. These do not render properly in asciidoc, so
> remove the sub-list and incorporate them into the paragraph.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/commit-graph.txt | 43 +++++++++++-------------

I said I didn't check if commit-graph-format.txt doc format
correctly, but that does not mean you do not have to ;-).  I suspect
that most of the contents would become monospaced wall of text,
which is no better than the original text and because only the
headings are typeset in different font, the result actually would be
harder to read than the original.

We are not in a hurry to do this during the pre-release period, are
we?  My understanding is that the original text documentation files
will be shipped and installed, and they are adequately readable
(correct me if it is not the case).

Unless we are making the result a lot more readable as the original
text, let's not distract ourselves by rerolling this in too quick
cycles without giving us sufficiently big improvements.

Thanks.
