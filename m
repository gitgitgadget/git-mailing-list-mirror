Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C6D31F428
	for <e@80x24.org>; Mon, 13 Aug 2018 21:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbeHNADR (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 20:03:17 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46340 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729815AbeHNADQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 20:03:16 -0400
Received: by mail-yw1-f67.google.com with SMTP id e23-v6so14669677ywe.13
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 14:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hw7lNreotNZ9KBvuiFIQlhVo+uCCbmXOnNd/nnlzMv8=;
        b=Dj7+w8UeSCbkuR0G+azBpnUAdhSE1erVxllmxKqBQaie/HmPDRq3CMTy6Bl+ZsLXH9
         g5NLtu/e6A6RkZfTsPPXpUndAqF3Dc8hNKEkjIp1V0dmcYeDat8vtjpxdaqlHl9UdYtg
         uikbD9MPixoywnCGvrH8v+Z7UWPxWTZ3lvGaswHa1SPG+otEEn6lEYOTSrJ4ZUruZcDv
         aIx82uxxjonW4Bx5bDl+HBKmPEyIGP2D8xj8qazo3U90F5q0diMRAGQMApXK0ZCrPjOd
         gDi6D4i4V8zW0PWuZzO/TuXItNbK4/qCMuQeArLk1V7i2CgAJG9LnepWJFBiXbWcZd6H
         Eu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hw7lNreotNZ9KBvuiFIQlhVo+uCCbmXOnNd/nnlzMv8=;
        b=aZRRfm2bBxxQLpyUYiTmLOFGmfslhYRd1qpea5q+6eb0eA2jtgWOSOp9qnybAJRZ2s
         mWy0U8LiEx7TI6ETf4ynbCfdFhrZLywxCuqJY3EcHDesl+rVyD0D8qPjUBF7lh+4z0ZN
         AwTFgvHuzArjBY1Xt8UGN91SDXWJWBC9gbEH/CzaiH2GCSiCumjraD3FPZdHIZFGKYqH
         b6l9z551IQBlT+uAQYi417+nBxzttrVEPl+q83MXzDoAZ97gbTN0mA8s/W4xSAmpkWuG
         PgmApJxdSNuyCz3u4tEQPyBjDUaaz8N+MLBqWkL+05DnCoCn8p1ZZuQSHL+QiV3A4+wZ
         SykA==
X-Gm-Message-State: AOUpUlGfoMGHf7ThPmUdFze0vU2SEBuM7GXnGSgmde6lUswSy7foEGGQ
        m/3Eg+p/LXlpDhoj/B604z6W1TZK2C7299kEHdWmDw==
X-Google-Smtp-Source: AA+uWPwo0bBhMtRkAAfRO2A01H7Og3uou+jCtVAAM3CeZLpWKB4cebwXYSLdDGzafOStjahEOgCxCW7vxAsJZcdaeEk=
X-Received: by 2002:a25:cc03:: with SMTP id l3-v6mr10051225ybf.334.1534195158562;
 Mon, 13 Aug 2018 14:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180813163108.GA6731@sigill.intra.peff.net> <87h8jyrtj6.fsf@evledraar.gmail.com>
 <xmqqh8jy3sx1.fsf@gitster-ct.c.googlers.com> <CAGZ79kbLVoGFEEPHgEJxBFqAMCzjgXK6gxRix__P5PWL8M2MyA@mail.gmail.com>
 <20180813210617.GA19738@sigill.intra.peff.net>
In-Reply-To: <20180813210617.GA19738@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Aug 2018 14:19:07 -0700
Message-ID: <CAGZ79kaNa2bo31rQexs4rAH6bAz1rMzpxS3-fSFE6Cj87E8saw@mail.gmail.com>
Subject: Re: Contributor Summit planning
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 2:06 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Aug 13, 2018 at 01:41:51PM -0700, Stefan Beller wrote:
>
> > > Oh, using "git shortlog" might be also simpler ;-)
> >
> > I guess you'd need to memorize a different set of flags for that
> > as without -s it would be harder to parse than the oneliner above.
>
> I frequently using "git shortlog -ns" to see who is active (especially
> coupled with "--since=".
>
> I also use "--no-merges", because it makes me look a lot better when
> compared relatively to Junio. :) I agree with you that "--no-merges"
> means we don't capture all the work that goes into integrating. But
> there's a lot of work that isn't reflected in commit count (reviewing,
> bug triage, the fact that some commits are much bigger than others,
> etc). So at best it's a starting point for figuring out who
> participates.

Heh. I tried finding that out, by looking at the public inbox repository
that contains the mailing list. (Recently I was looking at that repo to
learn about our workflow for different reasons, too)

However the mailing list participation numbers there doesn't really
help me:

~/git-ml$ git shortlog --since 2017 -sne
  3721  Junio C Hamano <gitster@pobox.com>
  2166  Stefan Beller <stefanbeller@gmail.com>
  2071  Jeff King <peff@peff.net>

and I certainly do not provide as much value as Junio or you do;
I am just good at resending long patch series to drive up the email
count. But I think that data would be also interesting to look at if
we were to find out what drives the community.

Maybe some derived metrics posts on mailing list divided by
commits appearing in origin/next can guide if one is a effective
contributor; but then as you said there are other ways to contribute
effectively as well.

Reviewing and bug triage do show up in the mailing
list but not as commits in git.git, but the numbers alone would
not hint at the quality. In fact the opposite is the case: if you only
need one email to diagnose a bug, suggest a workaround and
include a proper patch, it is more helpful to the community than
having more emails, potentially going back and forth.
