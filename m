Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EAA020248
	for <e@80x24.org>; Thu, 14 Mar 2019 14:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfCNOqv (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 10:46:51 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51126 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfCNOqv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 10:46:51 -0400
Received: by mail-it1-f196.google.com with SMTP id m137so5106444ita.0
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eH1aXwf26/UsHVyg38qKwomGBRD4fdPPx3AlU7NesgI=;
        b=MiLSD3QTfgeovNUXbOTL1f9QReLIga0nDk7IEhjvu0e6hqHILALuKYa6Bie+zRvvAF
         COdstR03fe47gFzqsn/wn41618FsG5C6DKMJC9tJvCLYyfX8tmJl63T0nxis7hLTNkDa
         L1o3oMvJYUr8ec3I3wfeJulScYBSX0y2YTMhlhowMPdCLPOV8i2fEGtZkaqTrC5W9LkP
         xP0rrLvDpqZm7KLLZknQ0K90GzvFgfA8BUcE6wyxy7edJNHSJ7B+cmuLRCUzi7SJw53z
         S1Y5crQNV6jDqDtrj2Xj+pN2XB8uhqzlaDqZzvUx9lxTqa1eqc+C/kOk/SMlLvRlUsHt
         g0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eH1aXwf26/UsHVyg38qKwomGBRD4fdPPx3AlU7NesgI=;
        b=aO7igWw23BijjmlIg/mPfO5+VpI1u4rXkqm1vS9/y07qMx7gX7Demsm/cSHjpEzssv
         DMgrmdRdINcpNy8nlScdlSzKdmZZ2AlhAwkmd6Stk6d05WlPvBA0yxigaE0LnHJ8Aqvy
         1dMRLMX1pC6OwKZcOnotv8+RgkT0E4P6ug1m8qn0ubhHLCDIPrIYGpDbzEwxatTYXv0v
         Yvoypun+Bw9oa7RawgtIrGQQ5b/N3vPmyT8taLw/LofiiDU4L0D6I7ZLU/xLpZ4y48ik
         lXeC3n9/h/FhqzxmWmtuFW6AtDxo0SmTqtjuNQNAxvhQeG+OL+es9VqlgOdGyna7UFs4
         NnTA==
X-Gm-Message-State: APjAAAVHOMEtSC5B04/l5aJDRxAANXTVpcBnuRb+EcMSHWAF/FJkmIdj
        ISCpFWu+rBZu5FdzO1650zezYNFw2/+BcCKAfD2eaw==
X-Google-Smtp-Source: APXvYqxPXm3h7W/eKqdBMu5P4+dWZZIeOj06uumA5A8TDNX04xA5bF1qZU8Qq3KumMC4le6VVCLFinfY57zBupr0Ilk=
X-Received: by 2002:a02:1c49:: with SMTP id c70mr9193020jac.92.1552574810614;
 Thu, 14 Mar 2019 07:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190312213246.GA6252@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1903141235390.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1903141235390.41@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 14 Mar 2019 21:46:24 +0700
Message-ID: <CACsJy8AA_b7NKhoKg-qoGae92antzaE6WPd+P8LkD6zFc20VSg@mail.gmail.com>
Subject: Re: GitGitGadget on github.com/git/git?, was Re: [RFC/PATCH] point
 pull requesters to Git Git Gadget
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Roberto Tyley <roberto.tyley@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 7:06 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> If this is truly something we ("we" as in "engaged Git developers") want,
> I can set aside some time to work on that. I had originally planned on
> exactly that, i.e. supporting PRs on git/git, but I got rather strong
> indications that GitGitGadget is hated by some (Duy, for example, was very
> vocal about refusing to even look at any of the GitGitGadget-sent patch
> series, let alone using the tool himself).

To be clear (and if I remember it correctly) that was the reaction to
how you took feedback on GitGitGadget. Not GitGitGadget itself.

> While I think that this hate is
> undeserved, I cannot change other people's feelings, nor would I try, all
> I can do is to try not to make the situation worse.
-- 
Duy
