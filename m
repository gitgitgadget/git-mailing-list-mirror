Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28CC41F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeDJVyV (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:54:21 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:44015 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbeDJVyU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:54:20 -0400
Received: by mail-yw0-f179.google.com with SMTP id i187so4544308ywd.10
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 14:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vsRZ8hxIqAMILBFouRO7LUzp5qz1SElbGW12/+x2N7M=;
        b=vFc46qMFcnzFCYs+aA1FkS5/n7arSXU/4sG/l6cK0x8xVm+U/ncglNOGtiK6x7/aYA
         7IB78RbsbALu/1fOa8oSfEDkfeIcU60ROYX0RNVksZRpUgoluJNP/kD32Oxk9Qn99p0a
         qH7DToeuaum6Pc55O3Kkb3qx3cWhrt1HA43Vcr24f03IZyaL9+1P63H4f8Dg4QGk8kDy
         vZu2116cmZewmzcfzZEl+BYxzer/ZSGuVQSjotmMIIArervDSDZMnF0t3T/UDdzWNRQK
         NWr/pMlLKWpzJ1Ah1WMBxAxzH/tKqlrASzPEjGj61iZar5i06ZXkqN9ecbpfPdRqah6i
         lMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vsRZ8hxIqAMILBFouRO7LUzp5qz1SElbGW12/+x2N7M=;
        b=gox7aBpJcOFinCaQaQgk+WQsnmGpo0FwqjMf++CpfpcBWUbrV/lUHNy5TZm5z/jDif
         6UGuuRe2V3qL4ABqivtN0m/GMi1hlGpJrXTWER+mGOhcGu6oI8HBCRmKFUQvp1N/kmHi
         Ik7hNCnia7E/s5rLZahoNSiLueVH+RHLq1n0uuITTKFk5nWulUEgmazCWgPK5fRW7HYI
         ma7G6ZByG++oWqEZ/E4kIyap2Ddk6iYlYJA5oqUlUi8Je9vY6DS5HYHBfbR22ByA9ttr
         6SJBn7f8bjcM72/h/UayDfxOeIlF30uulrQHfOnhb/eejmazyb4bwpFAju0oBhY3tNub
         pejw==
X-Gm-Message-State: ALQs6tBmu3wK7QAVIU+Njvylx34mpuw6y4Wez8iE1rwyC/gWIVJgrcNB
        Y7A7qcXIPy291ffPuTnVyssQm0rHRha96ghSAB22ig==
X-Google-Smtp-Source: AIpwx48VCVuoMXMCzcxla3JzrgZMsaQKTp2iqxerTWs/WUs4xKqhQAbmYs6LysCC/gXCdaS2owpG9BOM3Urn023KI80=
X-Received: by 10.129.232.5 with SMTP id a5mr1249950ywm.421.1523397259402;
 Tue, 10 Apr 2018 14:54:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 10 Apr 2018 14:54:18
 -0700 (PDT)
In-Reply-To: <xmqqtvsi214p.fsf@gitster-ct.c.googlers.com>
References: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1804102301200.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <xmqqtvsi214p.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Apr 2018 14:54:18 -0700
Message-ID: <CAGZ79kb4ny9LNbbYe53WO9eqTAmjUSprUeX9-rhvAehVR_cPgg@mail.gmail.com>
Subject: Re: git-gui branches, was Re: What's cooking in git.git (Apr 2018,
 #01; Mon, 9)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 10, 2018 at 2:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Mon, 9 Apr 2018, Junio C Hamano wrote:
>>
>>> * bb/git-gui-ssh-key-files (2018-03-02) 2 commits

This looks good to me.
Please merge down.

>>> * bp/git-gui-bind-kp-enter (2018-03-02) 2 commits

I tested and reviewed this, and it also looks good to me.

>>> * cb/git-gui-ttk-style (2018-03-05) 2 commits

While this looks like it doesn't break anything, and it does what
it intends to do, I am not sure if that is the best approach.
I'll look into Tcl and experiment to have an opinion.

>> What is your plan with those? I thought they were on track for v2.17.0,
>> but now I see that they are not even in `next`...
>
> There is no plan. I was waiting for somebody to raise noises, get
> irritated by lack of active subsystem maintainer(s), which would
> eventually lead us to find a replacement for Pat.

Ok, glad that Johannes made noise then.
I am a heavy user of git-gui myself so I would feel sad if it wasn't
properly maintained. (On the other hand it "just works" -- for me)
I'd be ok to step up as a maintainer there in the long run if nobody
else steps up.

> I can play patch-monkey for git-gui part but I do not want to be the
> one who judges if proposed changes to it are good ones.  Have they
> been reviewed by git-gui competent people?

For now please apply (or monkey-patch as you put it) the
first and second.

Thanks,
Stefan
