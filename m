Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22C2F20986
	for <e@80x24.org>; Tue,  4 Oct 2016 20:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753722AbcJDUlX (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 16:41:23 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34392 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752903AbcJDUlX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 16:41:23 -0400
Received: by mail-yw0-f195.google.com with SMTP id u124so2994408ywg.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 13:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QbbqNpJ7qn2N9vqka/EVZII5C5HyW5ti4r2DE+n6qCc=;
        b=JqksDPMUFXNxENb5Yd/ulXpbMPE6mpzt8MXJ+9MDTrD9DeRMg6z2gGexlitmC0dwBj
         NSMKYFvcHR4SdKbG4HzerTOKBBbeYX/4clksWDdKIoffh+IpRYEvp57NjVe1meiuAsVT
         73buqXZDoVk+xlg6R2GOs1ZLUH4V2IlToybxBEBxfEG5kShdj/J6F8TAC7DYykA6LFvE
         UnGtCtrFKMRasMH3B6vkQXi0X1YGC8crrHurar9ed6zog2H4DqEBH+gumnz/yUsc3xOi
         J++iXSOA+zsu8FN1Fhy41KAfTDvz7gZoF6Fk7JYfo9Oi6fMh9c/rA2bVEuZODbFnSLd7
         BXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QbbqNpJ7qn2N9vqka/EVZII5C5HyW5ti4r2DE+n6qCc=;
        b=Lm+u75a/NS6LW+W9MLKkSP5yAY5G871CWKIvXAoQ92jDbVV9RYIdIJTbvhtsDjYh8D
         FoFqJudZkYSYSnIxeb2aMy2N4h9SanSE3gR1XJLWa5eV6oMKIOLXwovd1hiqd9AYZqhW
         2YeOVBJOfpVhzephl5pc70UiyDR5a/IPhxI3Foho3mcLHFDI6HLfkAMe3zTyIK2VD0Nu
         ZeTiBfXzK5O/+peJYB1QX008/FsLLuvvJrKTN2/G88qos6sufsGFP9uOM6eSbf9aE5iT
         zIlDHdsDI8pWDpRgeza5OcgdRm7anhe48yict7RG5OazTUWTZlkYQ1IUz+X8XpC6xHaJ
         D+Ww==
X-Gm-Message-State: AA6/9RnmAL3SSsF7HvWoJk3+g/cT/IjQggpZtuxFMDAlAoQTJc/vU8N1X06ZrK4Z3MxXTcgXi27VGd1F2lIv8A==
X-Received: by 10.13.203.79 with SMTP id n76mr4044508ywd.122.1475613682166;
 Tue, 04 Oct 2016 13:41:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Tue, 4 Oct 2016 13:41:01 -0700 (PDT)
In-Reply-To: <20161004134702.evnm6xea7y6mbppo@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203405.nzijl552nlqg63ab@sigill.intra.peff.net> <CA+P7+xoX6XsKRFUCx+vhUo7ARYMEXktzcbFS=zh1NUTgRdhdUA@mail.gmail.com>
 <20161004134702.evnm6xea7y6mbppo@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 4 Oct 2016 13:41:01 -0700
Message-ID: <CA+P7+xoPhbhaGSLtDRg7myjFcBdAVpmSFLSVFHRncTtFkCq21Q@mail.gmail.com>
Subject: Re: [PATCH 04/18] t5613: whitespace/style cleanups
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2016 at 6:47 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 03, 2016 at 10:52:39PM -0700, Jacob Keller wrote:
>
>> On Mon, Oct 3, 2016 at 1:34 PM, Jeff King <peff@peff.net> wrote:
>> > Our normal test style these days puts the opening quote of
>> > the body on the description line, and indents the body with
>> > a single tab. This ancient test did not follow this.
>> >
>>
>> I was surprised you didn't do this first, but it doesn't really make a
>> difference either way. This is also a pretty straight forward
>> improvement, and I can see why you'd want to split this out to review
>> separately.
>
> I was trying to leave it to the end, to move the substantive changes up
> front (and because there _isn't_ a correct style for some of the things
> it was doing). But it just got too painful to do the "don't chdir" patch
> without updating the style. I agree it might have made more sense at the
> very beginning, but I didn't think it mattered enough to go through the
> trouble of rebasing the earlier patches (which would essentially be
> rewriting them).
>
> -Peff

Right.

Thanks,
Jake
