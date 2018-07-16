Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5566A1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 08:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeGPI1X (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 04:27:23 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35404 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeGPI1X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 04:27:23 -0400
Received: by mail-yw0-f195.google.com with SMTP id t18-v6so13879334ywg.2
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 01:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fyEHjLQrmZXB6K7hm7nzKzJZ2hVKgNqnROJWnATaHNc=;
        b=gJIZldua0m4eoNqkwn/YyRn+jUWeKos4I8hmoCkm/9Ao9eA3cdfUcMPwk7FhjaP9Mn
         Dn0sJMTdPCEWWX+9MZ4SbjyvYi8CTyvwJw6lqPy6Reg+g0bWBI8PtDkt8PrdfTVS1lvm
         SU/XkRPkUYXHMglmNkom6D3tSsxRjGPOuYNcjqo80H6OW+O3PmAdo4HROj/OayV6l0OT
         RrBJDMfon0dAxLJxaiKDTrFQRcX3BrOUhxiY4prdz52SmsnmDbW6i5BDIsUvwS426J1K
         MhS9X+iWmnp+47BDVOceE7162ppWwIr0cBRNwtS6QSZ47rehfKcdn193caOC+PdmSxab
         gprA==
X-Gm-Message-State: AOUpUlELTYPjEFJCgWgfcjqqDm9BeoOv0amXTWHcB5j2aXfNT4Rapluj
        vq51RAT/71u0tjUK6bTf2FFcJwjQnPI4sXxgjtc=
X-Google-Smtp-Source: AAOMgpeJsO3H8KgD9uzGWghpLn2RztVJeqGhX1l5c1BtxIN2sZDzq+qb8vCHDLk14U142lDR0Rd5ixwbawHEreqbUWY=
X-Received: by 2002:a81:1001:: with SMTP id 1-v6mr7664074ywq.120.1531728074364;
 Mon, 16 Jul 2018 01:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
 <pull.1.v3.git.gitgitgadget@gmail.com> <799da25ef35d2b23dc0df1e6af0772e634f39f19.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <799da25ef35d2b23dc0df1e6af0772e634f39f19.1530617166.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 16 Jul 2018 04:01:03 -0400
Message-ID: <CAPig+cSin5Em1m7uigSLnNg9wbz+fz8uy4sJOECq2Ke2+v+D4A@mail.gmail.com>
Subject: Re: [PATCH v3 17/20] range-diff: add a man page
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 3, 2018 at 7:27 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The bulk of this patch consists of a heavily butchered version of
> tbdiff's README written by Thomas Rast and Thomas Gummerer, lifted from
> https://github.com/trast/tbdiff.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
> @@ -0,0 +1,235 @@
> +To that end, it first finds pairs of commits from both commit ranges
> +that correspond with each other. Two commits are said to correspond when
> +the diff between their patches (i.e. the author information, the commit
> +message and the commit diff) is reasonably small compared to the
> +patches' size. See ``Algorithm` below for details.

Unbalanced number of backticks on "Algorithm".

> +Finally, the list of matching commits is shown in the order of the
> +second commit range, with unmatched commits being inserted just after
> +all of their ancestors have been shown.
