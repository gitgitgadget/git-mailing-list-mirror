Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 150181F858
	for <e@80x24.org>; Mon,  1 Aug 2016 05:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbcHAFET (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 01:04:19 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38193 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbcHAFER (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 01:04:17 -0400
Received: by mail-wm0-f41.google.com with SMTP id o80so226201324wme.1;
        Sun, 31 Jul 2016 22:04:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N4AAXK5EYQSsxQMEEbgTVrmBfeez4+Jpf4NFRhKcfHg=;
        b=Zm6wZrVQV4p3R5btfpTjUcw1dIpV8o6LIwjgja4+KkBsT2ghsfvket78K04J8+hj6U
         s37t28W+ByTwP48btlpqXJtjT78D5vYkH0qURp8C1p2rNPzUJKJjVaMpvL3P/HrEKXRT
         qtXFUuWjBdHoL125fro19VaZQ+JwmShUoZMa/zdAQV9PNPRKk939OYA0ODqnFLssoaKK
         /whkRAe+mitiiWW4S5OTs1b/FAuimf1jXK+q/9J6APUORVg+rYNoDYdZ5fXdxFf9nz4t
         2YOm2XFmCSUp2C8a0WUQtp6y89is3fIAsFYko1Jdt0ynKAsPe4Ly3Af6jwOFGQGbX+sl
         MZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N4AAXK5EYQSsxQMEEbgTVrmBfeez4+Jpf4NFRhKcfHg=;
        b=PvneuRfnO7kKwJriVV6mhjiV/jk+HsUzqMWcsnGo71Id+h8dt9dybXJ70yn1dyHxAJ
         qksy+qI1lmX1W18fvmUr3dVDm0PkO6M4sYzhhHnLUTLTFu9btnwooNCrKdzUcn3Y9AQ0
         qNn0AG0+aPxK9v8bKL9zqURhGkkEGCBSFFm8cHLWZkiOqTXE8DHwzL7eR6teMcmxSISt
         TlwGrJB7sJ+XrhdP1XKez8qTJqyr5ql+4Hq7HCfmSW+S6MHt/FLmg6szpuQLHNahfeCY
         kNo2Xcm5n6MeEAXv1Fg0iTsIPghJQ+OJnJ/L+P9BCb6YBtcvnnNZ+GhRf18OO7MpIvXL
         jXNw==
X-Gm-Message-State: AEkoousfs1O57BLd9EmNBdBPO0qyfJpYtkuvTENqIMIQ7qB0D62IKIeK0mL0Xh8agUEt8+NJuryasd8/K3OrxA==
X-Received: by 10.28.103.6 with SMTP id b6mr57135715wmc.89.1470027855936; Sun,
 31 Jul 2016 22:04:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Sun, 31 Jul 2016 22:04:15 -0700 (PDT)
In-Reply-To: <20160729101011.GA3469@salo>
References: <20160729064055.GB25331@x> <20160729101011.GA3469@salo>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Mon, 1 Aug 2016 07:04:15 +0200
Message-ID: <CAP8UFD12Jk0s0HPPWS3CqFcB37gzhzZZi-V0PfqrRhZO4zhHOA@mail.gmail.com>
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
To:	Richard Ipsum <richard.ipsum@codethink.co.uk>
Cc:	Josh Triplett <josh@joshtriplett.org>, git <git@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, dborowitz@google.com,
	Omar Jarjur <ojarjur@google.com>,
	Harry Lawrence <hazbo@gmx.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 12:10 PM, Richard Ipsum
<richard.ipsum@codethink.co.uk> wrote:
> On Thu, Jul 28, 2016 at 11:40:55PM -0700, Josh Triplett wrote:
> [snip]
>>
>> I'd welcome any feedback, whether on the interface and workflow, the
>> internals and collaboration, ideas on presenting diffs of patch series,
>> or anything else.
>
> This looks awesome!
>
> I've been working on some similar stuff for a while also.[1][2]
>
> I'm particularly interested in trying to establish a standard for
> storing review data in git. I've got a prototype for doing that[3],
> and an example tool that uses it[4]. The tool is still incomplete/buggy though.

There is also git-appraise (https://github.com/google/git-appraise)
written in Go to store code review data in Git.
It looks like it stores its data in git notes and can be integrated
with Rust (https://github.com/Nemo157/git-appraise-rs).

> There seem to be a number of us trying to solve this in our different ways,
> it would be great to coordinate our efforts.

Yeah, I agree.
