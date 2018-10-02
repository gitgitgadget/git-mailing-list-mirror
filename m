Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66721F453
	for <e@80x24.org>; Tue,  2 Oct 2018 22:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeJCFat (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 01:30:49 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:43387 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbeJCFat (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 01:30:49 -0400
Received: by mail-ed1-f51.google.com with SMTP id a4-v6so3558129eds.10
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 15:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vjsXumnK/ndpzpGMnEVNU+enGKVbbgYFb7PiK5dE9qU=;
        b=lVcMO8CH8y2ZdUbG6UFpyRbrM4Pz3l9oVLV4Dzg0O6WQviwTnOkPzySYWY2s3sTfdV
         2kYI9wo3QezTlMiieVDUyKu3aOAQ3MSM8CwZPZP6X8ZVAPRgaJzVqQ6X6uQa7oNezZbh
         odOGPdZ8T3Xltd56D69WJw6YRVcmzTGTmU2t5YMRaswpQmf10+hsz1XfERlAQ+DcaUwo
         NEZELYmuLJr5c0VjprZF8BIE2L9PpttFJGBmXdYPUuaHCCbZVH2NKoKQvLDu/uwETexI
         cjd3HSuqX9M4X3RCP/mgMQibgrZUmfXz48QybYKONlv3gmoOEqfPf54c2dDXx4y2yn7r
         Dc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjsXumnK/ndpzpGMnEVNU+enGKVbbgYFb7PiK5dE9qU=;
        b=NuYjnRsTMPs1pacRHCnDXycwMvsVp2+mKqN4u7uBwKZR8E6lY8EWVNbsSWvNu3mL9J
         vNmkEWVhSzhH6yEbCG8OMOA0a9EBAnFrs9GpiR/f8wg9kX00EJ7CKRcStpgMn6U+fgZU
         M9WzVvAt+EkZRB1Dzs2S1iHc5R39V6WIO5p+4+YNNQKNVs/WqmzgN0gUf3vVUE21oacs
         iseLdRvNJIJWWAaUYkMraCkNYDoIAXuaos84YpiHrmLpnhLkr3IE54c9Y410iNPpGHqU
         j35w95d2irjxVYgPOdWSBoGpQm/ix7/yOQm6gD8IuotSsrFzhulXQuJWkMPcMQ6Ap77s
         q4hg==
X-Gm-Message-State: ABuFfojHhvofiR1jqy+ZN0HRF9igHt2OdEAdGO3DpdToUdvDwY+f6M2q
        lfOx4dtQ9OrP/qzsc2brkEF3Q/Me3xBK1qZT1Bl4KA==
X-Google-Smtp-Source: ACcGV619f/s5QoMh4xpMt8W29pBQ/9BXTOuo7W2oCaEOPVEffwd8pcBxG2cqiiOurb7hMLHITE49rILjQjxOfkCRpdQ=
X-Received: by 2002:aa7:d9cf:: with SMTP id v15-v6mr13036054eds.25.1538520307160;
 Tue, 02 Oct 2018 15:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.42.git.gitgitgadget@gmail.com> <6906c25415eddf79cc3f71f905a77b140f2f66f0.1538492321.git.gitgitgadget@gmail.com>
 <CAN0heSomOen+mWg1CuPGUCJFgmDQUjGLtAdxpWLwrStRU4Me8g@mail.gmail.com>
 <CAGZ79kYtNnNPMv0=rB4ie=tOoYEPPZ=CmYFg4PG2_j96vjODeQ@mail.gmail.com>
 <CAN0heSqOjYDXRf4KE_C0GDnFW8r4qVfWnUVuW-Q+4D87nhFURQ@mail.gmail.com>
 <CAGZ79kb2pE3pFQx4A=oo-mYORjN1ubCgV6Gotc78i7d+BqZdBw@mail.gmail.com> <20181002223434.GA5588@sigill.intra.peff.net>
In-Reply-To: <20181002223434.GA5588@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 2 Oct 2018 15:44:56 -0700
Message-ID: <CAGZ79kaatUeHEGnW9HXv7Xgsj1Sf_M6hcgQ_5oVAOM85rqn34Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] commit-graph: clean up leaked memory during write
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> My preference is to avoid them in the name of simplicity. If you're
> using "make SANITIZE=leak test" to check for leaks, it will skip these
> cases. If you're using valgrind, I think these may be reported as
> "reachable". But that number already isn't useful for finding real
> leaks, because it includes cases like the "foo" above as well as
> program-lifetime globals.
>
> The only argument (IMHO) for such an UNLEAK() is that it annotates the
> location for when somebody later changes the function to "return -1"
> instead of dying. But if we are going to do such annotation, we may as
> well actually call free(), which is what the "return" version will
> ultimately have to do.

Heh, that was part of my reasoning why we'd want to have *something*.

> I'd actually be _more_ favorable to calling free() instead of UNLEAK()
> there, but I'm still mildly negative, just because it may go stale (and
> our leak-checking wouldn't usefully notice these cases). Anybody
> converting that die() to a return needs to re-analyze the function for
> what might need to be released (and that includes non-memory bits like
> descriptors, too).

Sounds reasonable, so then the consensus (between Martin, you and me)
is to drop the UNLEAK.
