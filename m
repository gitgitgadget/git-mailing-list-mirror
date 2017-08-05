Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 272C320899
	for <e@80x24.org>; Sat,  5 Aug 2017 22:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbdHEWye (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Aug 2017 18:54:34 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33095 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbdHEWyd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2017 18:54:33 -0400
Received: by mail-oi0-f45.google.com with SMTP id d71so41187544oih.0
        for <git@vger.kernel.org>; Sat, 05 Aug 2017 15:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3pN9dU8z8iwjRhFiLZcWC0pJTmfdHv5suBquXLmZooI=;
        b=DiN49ZxN6YSRBrac1KgB3UO3pVfkqBqYj+SF8ZwAgQGBbMsefhSQdfdfz2EYxkiF1F
         I8YgRa35amKW2W1zH6tKSciGNdtLswmTmIwmLHIfPP6jjoNWD5qAsrooqtA4MJ8i2x0W
         1W57K4Kowz/34bNQFH3Pgb9vCRqRaySPn4XXi8E/Y4ozqRs/inHD56vrU98rDui8oKEL
         RNsSUR825JBXRZ8XIbmPhmpjWRLb7yTjGfhtJdXZ8Y3l8yq+7KOJeiL0qkSfYZYzR37/
         K4WE2GiLk2ASxN4RS6DBK1bBE3cuDX7FHMNpXGnYiNULiyxABx97G5ub3cLVXUeVY54k
         Mv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3pN9dU8z8iwjRhFiLZcWC0pJTmfdHv5suBquXLmZooI=;
        b=mx36pnBDN8Czzxqj1947bFKi9xtn7U6oMROGehrf5EWRDcYECOsvUgH9uIOCwiFXC9
         RrOk+IL3sot+DW8a/oYeZWcTTi25NloOtdPEdVAsVOr3gfEVRJcuvukUxNlzKWJa8kkT
         o2RPzORmoT1rcTElzIXIw1ygli0BAaCo70h7FpLooN93IM06oYXXQm7FI5EdgS//EgWk
         zu9zTWipNA/LoZgCs3rM7Aht+ClfD7rY2jxcVMzAkmaKfPJHNB8f9MHDtVcRvlj/Xcay
         UAVf5Am2b8CWu40V3bboLp7UGxaL1Bx02JUSfis6eoLQ5NR3L4DI/qMf7jrv+qu4sumn
         So2Q==
X-Gm-Message-State: AHYfb5jVoUl1TaAKWkRW2vuKTbwAyLv4OwMs13RQn9pdByNpX31x4Ajl
        u1bOSfcKbJGBHhkC0iLLnQWJ7+uh1Nut
X-Received: by 10.202.7.65 with SMTP id 62mr3960149oih.81.1501973672512; Sat,
 05 Aug 2017 15:54:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.139.81 with HTTP; Sat, 5 Aug 2017 15:54:32 -0700 (PDT)
X-Originating-IP: [2601:647:5100:4a0:8a6:e1ff:fe64:a87d]
In-Reply-To: <xmqqlgmxskm6.fsf@gitster.mtv.corp.google.com>
References: <20170805064905.5948-1-mforney@mforney.org> <xmqqlgmxskm6.fsf@gitster.mtv.corp.google.com>
From:   Michael Forney <mforney@mforney.org>
Date:   Sat, 5 Aug 2017 15:54:32 -0700
Message-ID: <CAGw6cBtKF-Xt4z3m4gBDQvaSnurbtHURe737s8XMX78ca_RTcA@mail.gmail.com>
Subject: Re: [PATCH] Drop some dashes from built-in invocations in scripts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/5/17, Junio C Hamano <gitster@pobox.com> wrote:
> Have you made sure that all of these scripts, before calling
> 'git-foo' in the current code, update their PATH so that these found
> in the bog standard place (i.e. GIT_EXEC_PATH)?
>
> The reason I ask is because we can rest assured these changes will
> be a no-regression improvement if you did so.  I do not offhand
> think of a reason why these scripts wouldn't be doing so, but it
> never hurts to make sure.

I just checked and all the scripts make some other call to a built-in
with `git foo`, so I think it should be safe.
