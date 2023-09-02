Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E8FC71153
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 18:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjIBS5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 14:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjIBS5D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 14:57:03 -0400
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE31ED
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 11:57:00 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1693681018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gYFnjuotlGkXHWG4sMVo6Iy3VYGb4D4Smo/9W16c5OY=;
        b=g79qESsbIoj6hIxnHQfsAR58/ZxJdYZCE1PWrmDkakGe66bh423crMXt0As6ot2w/woAJH
        aZyzXrGNkGrT8K/VjU+u8+ifKNqxskhYdFEzB+H0jGAAbzqueMPCrkfcXNKIsUEny9CsRG
        /dMbymckxtfgSLEFX6pqDE3p0g3rZhwROPDC5p5JY3YdxYQVdFgoaxRqNC23Kameeh/T/X
        QvwG4FIVP2mK+XoS4OthosBgyDYsAJNCxvZXscl3srzuoIs3kKMJrzU8Wia9S/63fxYi6y
        CxSagIP3y1a/KRxd2hJu1Un6+u7BvcW0hB8Y0NQkRjGXN6uMrDPOFwBHbdql4A==
Date:   Sat, 02 Sep 2023 20:56:58 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] New configuration option "diff.statNameWidth"
In-Reply-To: <xmqq8r9ommyt.fsf@gitster.g>
References: <eb8f524eca3975f086715ec32a8a1fbb@manjaro.org>
 <xmqq8r9ommyt.fsf@gitster.g>
Message-ID: <72c114086590b9b15a3fdd9e0d6bd67e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-09-02 20:47, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> I'd like to implement support for a new configuration option named
>> "diff.statNameWidth" and submit the patch, so I'd like to check first
>> would that patch be accepted and merged.
> 
> In general, we do not give promises or estimates.  The devil is in
> the details and until we see the design we may not know if an
> overall idea is good.  Even when it is obviously a good idea, we
> would not know the quality of the implementation until we see it.

Oh, totally!  A good idea with a poor implementation is something that 
simply can't be accepted and merged.  No promises can be made until the 
code is available for review.

>  - If something is worth adding, even if we do not accept it in the
>    upstream first, it will spread among users and developers, and
>    eventually we may realize the mistake of initially not taking it
>    and we may come begging to the contributor for upstreaming.
> 
>  - On the other hand, a new thing that even the contributor
>    themselves are unsure if it is worth investing their work in, if
>    it is only to use it for themselves, is very unlikely to be of
>    interest to us or our users.

I agree, the mantra of open-source could be formulated as something like 
"find an itch and scratch it" or "build it and they will come".  In 
other words, if someone finds something useful and worth investing their 
time, perhaps other people will find it useful, too.

> "If this will be accepted, I'll work on it" is a very counter
> productive thing to say around here.  It is easily (mis)taken as a
> sign that it is the latter case.  "This is a good idea, I believe in
> it, and I'll work on it whether you initially show interest or not"
> is what we want to see, and such a patch will not need a "check
> first" letter.
> 
> In other words, make it so good that we would come to you, begging
> ;-).

Thank you very much for your thoughts and the time required to write it 
all down.  I'll do my best to make my patch(es) irresistible. :)
