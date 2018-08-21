Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8360C1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 19:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeHUW5U (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 18:57:20 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:36470 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbeHUW5U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 18:57:20 -0400
Received: by mail-qt0-f169.google.com with SMTP id t5-v6so21632826qtn.3
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 12:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZr3s1HEaNZjwL7QHgCX8EVk9h/VA/jw538UH0gG0zQ=;
        b=bXlJFiV6+vetHLo/L/QW2b6Vnlj5KCvu0vRC6GQOMoPvrCaNcrZlO8pPBAV1S0Mv8Q
         c9+1a1yKW4INivuc9xF6xGnHxUDXQ7rSjqJGUkwhxFz7RoTP6QyoSVaykV6SXGtZXPBX
         Rwo8xU17X9DyfwCBgsDKC8cGFpPYjOBEnqXhrSc4VFTQZTVlyqhbuIhvQyYsLBHqaXef
         7xMxs8cfi8nPR3wqunyghzSCOgAYqPyW6Vfw1rHfi+BEiq8XKFPI41UuDuta3Uj8E7sf
         EL9OoXtkJceSx0SFBafbStkX2PT4/RyqXxG/uOtVi6VyneeZm819LH9HQbDlgJQ3XWAE
         uhzQ==
X-Gm-Message-State: AOUpUlHNjBH+NHTsx1/ra5CV6jMP2o7w18X1kPDIixc16TUxrfR4LlJX
        T7nw22xCh0GveMME2uEA+KRhlK9crL611FmMkaU=
X-Google-Smtp-Source: AA+uWPwUgxkic1Y2GRDy5TAOohaI0UVi03OXseakUWAmwv6iyZYBZCxZQ3p5+vV26UfkKPQvyJZd2I+oLJ+sTZifNxQ=
X-Received: by 2002:ac8:e84:: with SMTP id v4-v6mr13035754qti.220.1534880151875;
 Tue, 21 Aug 2018 12:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.22.git.gitgitgadget@gmail.com> <pull.22.v2.git.gitgitgadget@gmail.com>
 <6cf253c2a6a091520e1376839dff8b97869c9808.1534879749.git.gitgitgadget@gmail.com>
In-Reply-To: <6cf253c2a6a091520e1376839dff8b97869c9808.1534879749.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Aug 2018 15:35:40 -0400
Message-ID: <CAPig+cR7OuF8LfZFY-b6egCOn0-p1uC5KeerhOig5FAC4rqrrw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] commit-graph.txt: improve formatting for asciidoc
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 21, 2018 at 3:29 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When viewing commit-graph.txt as a plain-text document, it makes
> sense to keep paragraphs left-padded between bullet points.
> However, asciidoc converts these left-padded paragraphs as monospace
> fonts, creating an unpleasant document. Remove the padding.
>
> The "Future Work" section includes a bulleted list of items, and one
> item has sub-items. These do not render properly in asciidoc, so
> remove the sub-list and incorporate them into the paragraph.

See: http://asciidoc.org/userguide.html#_bulleted_lists

And...

> diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
> @@ -148,13 +145,13 @@ Related Links
> -    "I think we should be moving more in the direction of keeping
> -     repo-local caches for optimizations. Reachability bitmaps have been
> -     a big performance win. I think we should be doing the same with our
> -     properties of commits. Not just generation numbers, but making it
> -     cheap to access the graph structure without zlib-inflating whole
> -     commit objects (i.e., packv4 or something like the "metapacks" I
> -     proposed a few years ago)."
> +"I think we should be moving more in the direction of keeping
> + repo-local caches for optimizations. Reachability bitmaps have been
> + a big performance win. I think we should be doing the same with our
> + properties of commits. Not just generation numbers, but making it
> + cheap to access the graph structure without zlib-inflating whole
> + commit objects (i.e., packv4 or something like the "metapacks" I
> + proposed a few years ago)."

Perhaps this should be using a quote block:
http://asciidoc.org/userguide.html#_quote_blocks
