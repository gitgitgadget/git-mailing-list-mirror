Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C91431F516
	for <e@80x24.org>; Thu, 28 Jun 2018 16:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754533AbeF1Qyx (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 12:54:53 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:44588 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933192AbeF1Qyw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 12:54:52 -0400
Received: by mail-pg0-f53.google.com with SMTP id b10-v6so2721533pgq.11
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 09:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YE51ywtS3BjzTZMTLnvU7fZ22kzPJygaVcSLaTkviZM=;
        b=Hr1SLMwtYSwVO3tTTb+EvB9NIV3kDVhuJVLjJG8JTHF8fkNHLWKeCjBoqiC9/UMqg+
         7aWTnTFD93qTE22Wo/rrwnET51R5xOlBfMP5NOghgeQVxpeZUDb9B+1SHEMGx2v4RnYr
         ztqjp1xA0g1uRKVn6pz5HX8rZVe2Oc1AbXXjeipixi59WeJ3VZB/vsU4RzEtJpk545gV
         sLgAXI8KyoGBuJfdnkjysG9952j1urKt9xc6JEc5TFw9aLssVQyFNYJ0nvDs8EP8r8VC
         dHFdWgDNKaqVgOsoaVob/wQqo/na5RA5QS8HbONbmFRnx6i7kq7aGq4L6/JmfiJmpTpl
         F6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YE51ywtS3BjzTZMTLnvU7fZ22kzPJygaVcSLaTkviZM=;
        b=h748OxuLp/HCSLkjPsqOaj/llW8WHP1TK6djQhv2JSQrDWcSznnpTH3CHKV0zGcF9r
         pEDEbGc6JBoAhK+nF6i+yqbd76DCOzXSmwGtH9XsSettmtUww5qbkbfqcFk5uyb3TOHT
         ZtOiWtflis3wh6sJrZhDp+cqGFD8ZImvvZzq3ObQbEc7+oyl7CYoigaR67yUcfbvqIqK
         C5m1bGGbDWRUTsWKKdlPPzgn0NBixnlODiyVaAsqKACe4hKh6P5Lp+qUSi2UtUe17fHG
         GTJT8B/9DTWhV1zLxMKvkUOa8P6sd0tELT9RWKxw/u9UQ8FjyiLYjifIhP7b+9+vVyQD
         BQLg==
X-Gm-Message-State: APt69E0TIimk82cSIiprHlpiCQmTckRkQsSptIThurzovZvzT36zea5f
        mL+CK2HZW3fhG/OlDBYDbPKfmQ8v+FbrHkOzEGno2A==
X-Google-Smtp-Source: ADUXVKK7olv8Hra6MiFwxtkeBoJrarnxl+5DwUQOR4GYg4Mcy7mFW03qPnsEPnuoAgD3k/yuP2YGuwLeXDljR/ukqGM=
X-Received: by 2002:a63:8dca:: with SMTP id z193-v6mr9622619pgd.228.1530204891766;
 Thu, 28 Jun 2018 09:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAMYKhtUi3nCmTjZ8pXbNCxaKa6h9+1OSD7YitTeip+807w7dJA@mail.gmail.com>
 <c48629f1-7b41-d516-84f5-c07ef7881e03@gmail.com>
In-Reply-To: <c48629f1-7b41-d516-84f5-c07ef7881e03@gmail.com>
From:   Grant Welch <gwelch925@gmail.com>
Date:   Thu, 28 Jun 2018 09:54:16 -0700
Message-ID: <CAMYKhtUCm8+_vK2y3Fxd=Cj5Lq7=pkORNm0T1y+UFmdtwR6DMQ@mail.gmail.com>
Subject: Re: Inconsistencies in commit-graph technical docs.
To:     stolee@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the quick response and for the patch.

I started writing such a long process document because I _thought_
that I found a major issue with the Large Edge List. But, in the end,
it was user error. It turned out that I was looking at index '11' when
I should have been looking at index '0x11' ('17'). Whoops!
On Thu, Jun 28, 2018 at 5:49 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/28/2018 1:11 AM, Grant Welch wrote:
> > I recently read the "Supercharging the Git Commit Graph blog by
> > Derrick Stolee. I found the article interesting and wanted to verify
> > the performance numbers for myself. Then that led me to want to know
> > more about the implementation, so I read the technical design notes in
> > commit-graph.txt, and then I jumped into the format documentation in
> > commit-graph-format.txt.
> >
> > Along the way, I noticed a few issues. They might just be errors in
> > the documentation, but I figured it was worth documenting my entire
> > process just to be sure.
> >
> > "Supercharging the Git Commit Graph", by Derrick Stolee:
> >    https://blogs.msdn.microsoft.com/devops/2018/06/25/supercharging-the-git-commit-graph/
> >
> > # TL;DR
> >
> > I found a few discrepencies between the documentation in
> > commit-graph-format.txt and the results that I observed for myself.
> >
> > 1. The "Commit Data" chunk signature is documented to be 'CGET', but
> > it should be 'CDAT'.
> >
> > commit-graph.c:18
> >    #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
>
> Thanks for catching this! Thankfully, this is an easy fix, as we only
> need to update the documentation.
>
> > 2. The "no parent" value is documented to be 0xffffffff, but is
> > actually 0x70000000.
> >
> > commit-graph.c:34
> >    #define GRAPH_PARENT_NONE 0x70000000
>
> This is a more important mistake, as it affects the data that was
> written in the commit-graph file.
>
> Part of the problem is that leading hex digit of 0x7 which in binary is
> 0b0111. We already designed a limit of at most 2^{31}-1 (~2.1 billion)
> commits in the commit-graph because of the way we track octopus edges,
> but this mistake has cost us more: we cannot store more than ~1.8
> billion commits.
>
> I'm sorry for this mixup, mostly because it is aesthetically unpleasant.
> Those extra 300 million commits mean less to me than having a clean file
> format.
>
> > 3. The "generation" field isn't set on any of the commits. (I don't
> > know what to make of this.)
>
> This is a difference between 2.18 and current 'master', which merged
> ds/generation-numbers. Commit-graphs written with Git 2.18 have all
> generation numbers listed as GENERATION_NUMBER_ZERO (0), which lets
> future versions know that the generation number is not computed yet, so
> the next commit-graph write will compute the correct generation number.
>
> I'll send a patch soon fixing these doc issues.
>
> Thanks,
> -Stolee



--
-grant welch
-gwelch925@gmail.com
