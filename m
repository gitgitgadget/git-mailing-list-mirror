Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D641F1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 13:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936225AbeBUNeG (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 08:34:06 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33349 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933420AbeBUNeD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 08:34:03 -0500
Received: by mail-qk0-f170.google.com with SMTP id f25so1917614qkm.0
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 05:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gnustavo-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hm64wt/u6UKdIQ37lMyoNShvj3jGgyg+7wctMwOp6zM=;
        b=JbShoCO6AJIeVm1cywMhD7grCAO8sRPTXyOi0Eil1kjG5WfrS3dVGqK72xIL0Bp4bT
         fdwPkRbledVegtjNIgedg2cu2taoel110Ye38FJO74PI7q3/0ZS7i3oIfv/YnjEOm0nJ
         yaOBWmgSQGWCj27lAdODCWmAXp+kVSdvq/7vheaAZclKo99ZsFlO1ZeTqC4VzLQfLXLm
         xeqSK7XcapqZJ2YOV+kilDuqBxB7GzE2oGmQDtgHZQ2W6CXmZ8uuvExtPRIGDWS04MnQ
         7Dk15wt6Uk47MECTmanMbcBHxzaBfU6389cgHZgu0ztJ7rHPztClClbeJt1s1AN/ttK7
         IJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hm64wt/u6UKdIQ37lMyoNShvj3jGgyg+7wctMwOp6zM=;
        b=tb8wpxD5/Qx8yEFBSkfjR9H3qcsWU0pT53jY89BDh1mHgG8AgFPvZbnR2qCaulvoo7
         L6bt5QZydEcb8d1WLzKUubEZTyonWG4A/b+FGkVYQH1I8o4RPrTVf/z3rmJC9aDusG2m
         eC+3X7ycx6708RcR/xQ0lg+46FNkErIKX+Hf7hRhr+aPUdruXvQmkoplTfpl/l1R9jKI
         TlitWTGI2hjIgjW18Ah+hxE6HHmqKfY652lsx1VSjnQrfcoSb2bu3oqf1pQ6ezp0U/FC
         TKAtMMLKqqjyS4ocRpNN42YfaJMcXF8ZoY9lExV0C7IAzKw32h5TbLHRuNF/aRLkZ3lT
         X2HQ==
X-Gm-Message-State: APf1xPBQiJhDil2f9X806REYngxSvPYqAUFU+Fvo9ZKdAtYhIznzWCPg
        weR6AYVhAw6dC8EzoKxSw4vBCYr/mocJIJy9NdyqYw==
X-Google-Smtp-Source: AG47ELst2dDNl3/cX26/7hpvqgq7j/L7T3eN57HBk8Itb66glAvr8rzUwN7NmZftIniR9y1w7GfTmcssKcYggaefxNQ=
X-Received: by 10.55.77.77 with SMTP id a74mr4843476qkb.239.1519220043128;
 Wed, 21 Feb 2018 05:34:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.80.145 with HTTP; Wed, 21 Feb 2018 05:33:42 -0800 (PST)
In-Reply-To: <xmqqfu5v4k4c.fsf@gitster-ct.c.googlers.com>
References: <CAPx58qqv84+i0JbdsVzFqWB=bRDecWHxss8frD4=nWOsFj-NPg@mail.gmail.com>
 <CAPx58qoS-J+yJ_J4QOOnKyG=EOrT5J=UoCrXfXxEijq4Z2Z_3w@mail.gmail.com>
 <7ff6079d-5834-3bbd-781b-a2fc0659e7e5@talktalk.net> <xmqqfu5v4k4c.fsf@gitster-ct.c.googlers.com>
From:   Gustavo Chaves <gustavo@gnustavo.com>
Date:   Wed, 21 Feb 2018 10:33:42 -0300
Message-ID: <CAPx58qp4VssKSKWJ=ng9CwHZUqkgnw6=D5iJLFyhYzwMz-zocA@mail.gmail.com>
Subject: Re: Why git-revert doesn't invoke the pre-commit and the commit-msg hooks?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@talktalk.net>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-02-20 15:00 GMT-03:00 Junio C Hamano <gitster@pobox.com>:
> It would make more sense (if we were to add
> an option to run any hook we currently do not run to the command) to
> run pre-revert/revert-msg hooks instead, and then people who happen
> to want to do the same thing in these hooks what they do for
> ordinary commits can just call their pre-commit/commit-msg hooks
> from there, perhaps.

I like this idea very much as it doesn't break a long standing behaviour and
simply introduces a new feature.

-- 
Gustavo.
