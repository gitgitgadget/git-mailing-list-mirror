Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E3E71F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 02:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932714AbeGGCQH (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 22:16:07 -0400
Received: from mail-ua0-f169.google.com ([209.85.217.169]:44663 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932362AbeGGCQG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 22:16:06 -0400
Received: by mail-ua0-f169.google.com with SMTP id v15-v6so8650555ual.11
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 19:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xT9Tsv41+0H4B/uIi1izQg3wb7KQQKSj5Qzy8/WRYbE=;
        b=nwNeJQemOQJYkpb8MuBKGXQcd7iro+PhXA7ahWh8wxD/VIp/0v6lk+hYusItUv0tm6
         SWy5exGwRpQweAOMxrE3uJnFEzLStCEXCPcXZzWUkp1S/eeZlCT1cJQETuI9RaDiKqb2
         4Ms7uqHJssY/7cGYvUzEm/DDUwhV8wqiUp7Srz1zM1K/lEtjSpTrIj7WD7WKYWFBv61O
         oAl85c8Gr2z0xI6xLiSLq5wDvDtWFmNerEw9mq5hrezmqZ9o+f3SkwFRsqT8PSMaxiO/
         Xg6JKPpuxMNup0P+jkMjrmJvt2vPsedFfFmqFiJYs4yaCu3hvsCLkng5DNkmJ8/oJLMQ
         TrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xT9Tsv41+0H4B/uIi1izQg3wb7KQQKSj5Qzy8/WRYbE=;
        b=E69IUf/ZlqodB/tNxnAlDRhi+51Yh437dm3iwnhefhOQgUwXqw5VceBdJHiEqK0mN+
         0BeSp1rKz4pTONcOy9v0m8Ug1R+vLYsTFibq7jpzofS4qTOWklFWcDvE0G5wNk38k3bj
         Bau9pbE14wSko0ljYDN/Qi2jglEZyNdSDar1SIIbcFSaCnT1bsshxMEgvZuPUaEV7xc1
         UoET4oTrug80/1SaD9oK/it7EeeZ53r7VfQixTsRMlNnoV4QeGBJ4ZujNZG+LN+gzptU
         XG67QiT865pH+FUvANCrzNPJ9DfJxvDsAH12vTLrJiq5ewy+BqS53gzG2+riTfesK66r
         pQZA==
X-Gm-Message-State: APt69E0SL7AdHLIIMZlwVKdpIsaI8b7/ovt7ch7uZFBUpnghiRuk3gEs
        mjTVKSDFKOsKDPSizmVjPB7f0ma4kYLI0e69/8w=
X-Google-Smtp-Source: AAOMgpfjx85Q8yW2Xzh+HJOloAkpUqG7Fg3eXyv9PnDfyU9oTwExWykVe/nL5A19dwR2yKEVzCKTwf10r1U28icqRIA=
X-Received: by 2002:ab0:4eef:: with SMTP id x47-v6mr7629588uah.23.1530929765306;
 Fri, 06 Jul 2018 19:16:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 19:16:04 -0700 (PDT)
In-Reply-To: <xmqqlgaogeff.fsf@gitster-ct.c.googlers.com>
References: <xmqqlgaogeff.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 Jul 2018 19:16:04 -0700
Message-ID: <CABPp-BFs1gYzBY5+QrrLEB5kJTaierSGDnYWs=5HKRcPksx9cw@mail.gmail.com>
Subject: Re: What's (not) cooking
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        kgybels@infogroep.be
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 6, 2018 at 3:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I'll be pushing out the integration branches with some updates, but
> there is no change in 'next' and below.  The following topics I gave
> a quick look and gave them topic branches, but I had trouble merging
> them in 'pu' and making them work correctly or pass the tests, so
> they are not part of 'pu' in today's pushout.
>
>     pk/rebase-in-c
>     en/dirty-merge-fixes
>     en/t6036-merge-recursive-tests
>     en/t6042-insane-merge-rename-testcases
>     ds/multi-pack-index

It looks to me like the main problem is that pu itself has lots of
test failures.  It seems to bisect down to
kg/gc-auto-windows-workaround.  If I revert commit ac9d3fdbebbd ("gc
--auto: clear repository before auto packing", 2018-07-04), then pu
passes tests again for me.  With that reverted, I can merge
en/t6036-merge-recursive-tests and
en/t6042-insane-merge-rename-testcases without conflicts and the tests
pass without incident.

The other three topics all have merge conflicts.

en/dirty-merge-fixes has a small conflict with the new topic
nd/use-the-index-compat-less, which I mentioned as a possibility in
the cover letter to my series.  I'm happy to do whatever makes it
easiest for you to pick up; I can easily rebase on that topic branch,
but I thought you wanted to see that topic redone first (to avoid
"useless churn"), so I'm unsure what the right next step is.
