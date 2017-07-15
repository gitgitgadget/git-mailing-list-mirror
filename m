Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F24B12027C
	for <e@80x24.org>; Sat, 15 Jul 2017 08:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751142AbdGOIcw (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 04:32:52 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34027 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdGOIcv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 04:32:51 -0400
Received: by mail-pg0-f42.google.com with SMTP id t186so56223121pgb.1
        for <git@vger.kernel.org>; Sat, 15 Jul 2017 01:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=PI7RMgbicGpj5VVelMwtVManqRngVeKoKRCx/hSX1WA=;
        b=ECHGweXTUavFJ1pubm3blKAoy2O+kqw4aRys6UFtHCi7Eai1oX/OTRb0sVCZhL0zK0
         oQF8qRqsbvldT6C+ubLVgIco3mXLFCq1YBMjdZ6bpUfzsgvxIL1a26OgVGjozVfVa/bI
         7WI6D+38ssUAy2aY0AqEl8aI7rSH7G3N5bWqLqRDNdZlv9FuYDaYO+mf6t8ULMESnpaF
         UxL5O8ySte6kyT7i+80BUs2xhw41r3jr95F5cHrMgMhgmmzRhofLQ4CXCi4LOVR2yLqd
         Fx/gcDOaCapvma/Fu+EtlUFE/tGdEkXAWuT/zoOh24FyqdKUy03yZ1kFXte/e1c+MN/r
         YZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=PI7RMgbicGpj5VVelMwtVManqRngVeKoKRCx/hSX1WA=;
        b=hA40ifYDIqgc1fg/Ddz+R4LNtVwaFh6NSOK2XPDloZFsRMMx/vh99f44uoDg9wlvMr
         sO6RL7fjzJ2xEIgEC2+jmAicjwVOBgiymGcvn2eNgRedZfdKgvtWhNesP8uqTbWa2g23
         JKeYn8/uViEE/1ZxhH3g3/ENe9RzQ8C2S9dkQVWaJS/CUwq78EYHIEb/2IzuYRzHOSsN
         RJguD09DO+Hyxm/gM8/IKpLBWxvcuKnBly6DaifGM6N4xSo0vvNpsvKO0MWCWN8lQkWm
         V4tc/XJj1Fo9Ur6svq3FBYhI8vtCb/25j3us76sY4p0oyYvbESyM3J4W2bCBTK5oSG8U
         tp0g==
X-Gm-Message-State: AIVw110dtF5O4lvSgtL9On4IuiX3oNLQblzovhNYPoRJYSEjQfbTDXRA
        2Fobg7fsqUJfRcHfj3I=
X-Received: by 10.99.60.28 with SMTP id j28mr18542911pga.18.1500107570500;
        Sat, 15 Jul 2017 01:32:50 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id 10sm21018171pfo.134.2017.07.15.01.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Jul 2017 01:32:49 -0700 (PDT)
Message-ID: <1500107583.1850.4.camel@gmail.com>
Subject: Re: [PATCH] commit & merge: modularize the empty message validator
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, me@ikke.info
In-Reply-To: <1500054552.18990.8.camel@gmail.com>
References: <20170706044640.GA11020@alpha.vpn.ikke.info>
         <20170711141254.7747-1-kaarticsivaraam91196@gmail.com>
         <xmqq8tju3eqp.fsf@gitster.mtv.corp.google.com>
         <1499969722.5973.2.camel@gmail.com>
         <xmqqiniww37i.fsf@gitster.mtv.corp.google.com>
         <1500054552.18990.8.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sat, 15 Jul 2017 14:03:03 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-07-14 at 23:19 +0530, Kaartic Sivaraam wrote:
>         * Imagine a hypothetical version of git that aborts when the
>         <message> is empty though a <trailer> is present. This would
>         quite possibly instigate controversies as the "hypothetical git"
>         reduces the "valid commit messages" and would quite possibly
>         reject a commit message as "empty" (which is uncommunicative)
>         though a previous version (which did not have this change)
>         accepted a similar message.
> 
>         SO, bringing in the Occam's razor, let's choose the option that's
>         the simplest and makes the fewest assumptions.
I would like to add a little to the "making fewer assumptions" point.
If we make the fewest assumptions possible, it has quite a few
advantages,

* It would make the implementation that checks for an empty message,
trivial. Thus reducing the complexity of the code.

* It would not overload the meaning of the error message,

    Aborting due to empty commit message.

Thus making the sentence stand for what it means "literally". 
(BTW, I guess an "an" is missing in the message)

* It allows for others to have more freedom in defining what a commit
message should have using the appropriate hook(s). IOW, let us do the
minimal check(message consisting only of whitespaces) and let the
others define what a commit message should have using the "commit-msg"
hook.

-- 
Kaartic
