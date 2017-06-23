Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9119920282
	for <e@80x24.org>; Fri, 23 Jun 2017 20:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754949AbdFWUXy (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 16:23:54 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35143 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754872AbdFWUXx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 16:23:53 -0400
Received: by mail-pg0-f49.google.com with SMTP id 132so25351590pgb.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 13:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LBA8M+jNxpzmC135AvP24dHFW5vVU58pnnm3n8K1CYA=;
        b=d5O2zAaTbYfduY+8o1ILmh5WA9Z9jpz1S/QCZbmDJ470y7/tB6Ci/YAxN7n9r0WxYm
         b2hdY7njHG3H0tIHXL6yjWUaMh7/Tk2XQYiJd8oUgKT+oLoTEWkl2ykn9PDs+btcrybD
         wp+eHwXcbOpV5a7LWnpB77Fl796PN41dwVz+AYQWsK9NlHLQAqP4xB9vN5C+CLO4R9Ua
         7OJBh2ABh8tHIevNAgqyMIbhcdAF80AV0e8bAGxCwXVFppF9GJk8Pc0iFCN0LcMjm5hd
         SYLDVg1OCB50diCH1M5fTn59RXSjNlqx8lCVZhZGQgjQkTEVthFD5Op42K4kGNacxEaG
         nM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LBA8M+jNxpzmC135AvP24dHFW5vVU58pnnm3n8K1CYA=;
        b=g3xLb0NxTb36epoQI0Fin/cm1v5ewEkzkbXIjjSSsde84MGne6YhoC5nfIGg7RO/g4
         /bHnDSsAdRfSoP4MGmug4W3wyry9HRzgZBXZtCzLtwIrKGVmDB/KaKWw+NUMR2dPF9rC
         7zjxEgvyTTHMOm//G4EItWf0RTW+y/0KFa6Od5l/19FtvJEyUngqAHUCq2CuR0sxCPOJ
         Mp7qAtPJjGYBbKygNUfbjtkyE68ezDK0MkbcATrDQlTkPz98QnjEX3aWc+Kl2ocOlKyJ
         ake5302khXnAtzYxKUrA2x9hqsjtdsQ1mi8zqavflb13SNkKFeJKue6yc1cgATh+6Ili
         ne5Q==
X-Gm-Message-State: AKS2vOz0S6wujCzJ/GcrPzwfrjh8XtMeFrxJLst33l4I2qGUkTZAQVNX
        dfSZvXpv6w+osUbfLj2buCCsq2aBU46D
X-Received: by 10.99.55.83 with SMTP id g19mr9623640pgn.243.1498249432722;
 Fri, 23 Jun 2017 13:23:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Fri, 23 Jun 2017 13:23:52 -0700 (PDT)
In-Reply-To: <20170623201020.24zus6tsnf2i62d3@sigill.intra.peff.net>
References: <20170623201020.24zus6tsnf2i62d3@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Jun 2017 13:23:52 -0700
Message-ID: <CAGZ79kbKB0hWOHCWsa0k1z=QXeRC2Ab1sSOeQ7pApB7+o6mdFw@mail.gmail.com>
Subject: Re: --color-moved feedback, was Re: [PATCH v2 19/29] packed-backend:
 new module for handling packed references
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 1:10 PM, Jeff King <peff@peff.net> wrote:
> [I culled the cc list, as it was big and they don't all necessarily care
> about this feature]

Yeah I was on the verge to do that, but did not pull through.


>
> In the end, I just did --color-moved=plain,  ...
> "yep, this is all a giant moved chunk, so I don't have to look carefully
> at it".

This is dangerous, as "plain" does not care about permutations.
See the 7f5af90798 (diff.c: color moved lines differently, 2017-06-19)
for details. You would want at least "zebra", which would show you
permutations.

> I'm not sure what the default mode is. When I first used it it seemed to
> italicize a bunch of text. Which I didn't even notice at first, so I
> thought it was broken.

ok, italics does not seem to be popular.
I liked it as I could take the same color for these uninteresting lines.

> I didn't try the "dim" feature; I don't think urxvt supports that
> attribute (though maybe it was what was doing the italics?).

That is on by default (with italics), maybe the default should rather
be "zebra" as that has fewer colors but still contains all the information
needed to be sure about
    "yep, this is all a giant moved chunk, so I don't have to look
    carefully at it".

>
> One minor quibble is that I used with "git log", so I was looking at all
> the commits with that coloring. But the ones that didn't have movement
> had a lot of noisy "moved" sections. E.g., one line moving here or
> there, or even blank lines. It might be worth having some heuristics to
> identify a chunk (I think I saw some discussion on that earlier, and
> maybe it's even there and I didn't see it).

It is not there, yet. It was Michaels suggestions.
I'll give that a try, too.

>> Let's take this patch as an example, if someone were to find a bug
>> in one of the moved functions, they would send a fix based on the
>> function in refs/files-backend.c, such that it can easily be merged down
>> to maint, but when merging it forward with this, it may clash.
>
> That feels more dangerous to me, just because the heuristics seem to
> find a lot of "moves" of repeated code. Imagine a simple patch like
> "switch return 0 to return -1". If the code you're touching went away,
> there's a very good chance that another "return 0" popped up somewhere
> else in the code base. A conflict is what you want there; silently
> changing some other site would be not only wrong, but quite subtle and
> hard to find.

I agree, that is the danger, but the scale of danger is the size of the moved
chunk. A file is usually a very large chunk, such that it is obviously a good
idea to fix that. Maybe we'd introduce a threshold, that the fix must not be in
range of the block boundaries of say 3 lines.
(Then the moved block must be at least 7 lines of code such that a one liner
fix in the middle would kick in)

Thanks,
Stefan
