Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4025F201A7
	for <e@80x24.org>; Wed, 17 May 2017 21:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbdEQVSD (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 17:18:03 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:35168 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbdEQVSC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 17:18:02 -0400
Received: by mail-io0-f171.google.com with SMTP id f102so17424171ioi.2
        for <git@vger.kernel.org>; Wed, 17 May 2017 14:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EawYis1jiukAyCPI5FYmj0fNy5bIPwmos8b4BrVylXA=;
        b=bpls4/8DOKcBPCT7w+BIsHTE8zjLP6MxaErayRm5TiIuMxpazPc2hsFxT7TNpNnfgo
         p6bpiZJih4NqdVkHxUUp9rctezzGH7dpCNvGo1QCH1MWUECzvCdWNPEJgfbSNTHUsVqz
         U9mD+TOT3VW4WsK5Wm8jQ55Qb22079OdhbLQrxOEsQEBmVXpgT0JlPuf7GnWe5yrHmNg
         9XBnR2/u98WNAQ7jTYP4QKbJSJMMbU7emCZ5d/XXiWtxvEMsjoXkosyWtWoUZM5jkI/4
         Yu0+5TyMajxVwL3E1S6qX/cJMeh+DU+wH/u0ETEe9ofs7Xpnpw5SNYC2mGbBMdJbq/KN
         frZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EawYis1jiukAyCPI5FYmj0fNy5bIPwmos8b4BrVylXA=;
        b=mXhQ1tK0pclbYHRUFWSvgIwzcVOoy41QhwFwX3abPeVNXCoG4NMbsd9Ugq0eh7rdkz
         oSTDGHo0bAGJAoXQT3e+OAIgVSqMeVy9BfuPma5IzWHm7/0RikFn5VcN7Au4hk5rj8OF
         F4DjykPj5bBRYCjfmvbvCLnju1GW91niIp2B00+vUTnvBhxPVyhIo76mtwAPFHyKTQEl
         luHbpSta4uHbLqA5CVXz4bMQCr1AIP0/Hh0iGGHKRe0ei6RdTZmAjQjyLoZn8fC+BkI4
         vQ2i0SV2Y/EVu/Kj2G2ER0ZDj/8B1L3GAwPk3O97M670XErroocU6z25GSIjUgttjtXR
         wGVw==
X-Gm-Message-State: AODbwcCikqfMuvNWkN7qbzNlQbf3jnulSufUyF2nLLZcIVxfF5rTUEXP
        R/4MzPy9sERmvMbRo5D1BBBCMrT/b6Itmxg=
X-Received: by 10.107.35.75 with SMTP id j72mr887046ioj.180.1495055881431;
 Wed, 17 May 2017 14:18:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Wed, 17 May 2017 14:17:21 -0700 (PDT)
In-Reply-To: <CAHd499DNa1zFm+ktWJb-4Rp09DjSc+p4HMqoHiXDj57muwxukw@mail.gmail.com>
References: <CAHd499ADTbO09OJhH_wWBbAcXZeLRLFAqOw5eTe6=abN-JUrUA@mail.gmail.com>
 <xmqq37c4yzb3.fsf@gitster.mtv.corp.google.com> <CAHd499DNa1zFm+ktWJb-4Rp09DjSc+p4HMqoHiXDj57muwxukw@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 17 May 2017 17:17:21 -0400
Message-ID: <CAJZjrdX6iDQeAV4v7S=_OV6McNFe8Tax3sNUatwhrg+nEOR0jA@mail.gmail.com>
Subject: Re: Diff topic branch + working copy changes?
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 9:39 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>
> Would be nice in the future to have another revision specification
> like @{wc} for "HEAD + working copy". I guess this technically isn't a
> revision, but something along those lines. Or maybe just an
> --include-wc for diff or something.

I think the spec would *just* be the working tree, if it ever got
implemented - I don't think it makes much sense to say "HEAD + working
copy".

Maybe something like this would do what you want?

# Diff Merge Base

dmb = "!f() { : git diff ; ref=$(git rev-parse --abbrev-ref HEAD); git
reset --soft $(git merge-base @{upstream} HEAD); git diff; git reset
--soft \"$ref\"; }; f"
