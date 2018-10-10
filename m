Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 510441F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 00:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeJJICX (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 04:02:23 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:35525 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeJJICW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 04:02:22 -0400
Received: by mail-oi1-f172.google.com with SMTP id 22-v6so2755765oiz.2
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 17:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVlUxOpeSc+rJ2CwQzeYw1HKMl8pydVxYs2NGyl7M6Q=;
        b=shnImGKPhF4+wfpA43YnZjZDJo2eQhfmRGPgUUFSB3135s+H93HSLcl1eoYxPkknw1
         p92VMg0EOy6PTdmruwaSg8Pc57O7FAeZh2nW6lbYx676urjv39HCezMnNJbJ4SfGzhuv
         HkNsWbsKpf6ilJj6m6gcPEG6RLqCa8dh1Ngsxl6HE3q5xxZ9EeK9bX8UJ/j3s9e0BPUv
         g4hMYsbbAj7VM2VYiwW4xQkzEOfp16p1R+jZrIPCXypyBKZ4TEbSrhZaWHTFK3vLyxi6
         LEBOjf3d+K9OgsBoU76nK72dL0ML54tsEJT28i/kRw6oTvQ72R8UShYvgsU0TyBdwTf2
         iOPg==
X-Gm-Message-State: ABuFfoi+2lEyR17lkg5a/+cBycD7JH1dr02Npo2H3aoWE52avi+X3hJz
        Ch6j5etrEFzYddLFVSIGZZ3TzdzLcTj4ujCqo4A=
X-Google-Smtp-Source: ACcGV616dZZtqTAY+SKj0Ekked8g17PG8/tjfcd3mkNSelKTxzpJOEAjgIggb9YSS0/9sNJlMs6tklRll7Cky+jsU5w=
X-Received: by 2002:aca:b04:: with SMTP id 4-v6mr415724oil.192.1539132172375;
 Tue, 09 Oct 2018 17:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAM-tV-9gAGBLsEh3=aa-bHT2DmJb=dfahq+kUW+0GLoc7eFq0w@mail.gmail.com>
 <CAM-tV--dHGJbxfWGKrRde+Q2-cnmCXNshQtX4PN7jnMWER_+bg@mail.gmail.com>
 <20180625162308.GA13719@sigill.intra.peff.net> <CAM-tV-8sbbht7NUwf87-gq=+P=LNPyiEcv3zL+1BxfXK+ktmVA@mail.gmail.com>
 <20180806212603.GA21026@sigill.intra.peff.net> <CAM-tV-_=4WuMGemm6RTB902-m8JfMKGp_OkQFuJMagPE8bOOtg@mail.gmail.com>
 <20180908161316.GA326@sigill.intra.peff.net> <CAM-tV-9N36puQHKQ38JxAxNR5Zen=3jM7pG7vHioYvvGTxLHCg@mail.gmail.com>
 <20181003042437.GA27034@sigill.intra.peff.net> <CAM-tV-88J3ZAALwZeEqTuvKXRwLzb848G0AET2Ec6ic85=7o8Q@mail.gmail.com>
 <20181009045138.GA11376@sigill.intra.peff.net>
In-Reply-To: <20181009045138.GA11376@sigill.intra.peff.net>
From:   Noam Postavsky <npostavs@users.sourceforge.net>
Date:   Tue, 9 Oct 2018 20:42:38 -0400
Message-ID: <CAM-tV-97PJMGvaY_U=OmC36RXQ0KuxT1POj0ADgzeMv_8=iUxQ@mail.gmail.com>
Subject: Re: [BUG] A part of an edge from an octopus merge gets colored, even
 with --color=never
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This whole version looks good to me. "git am" is supposed to understand
> attachments, but it seems to want to apply our whole conversation as the
> commit message.
>
> You may want to repost one more time with this subject in the email
> subject line to fix that and to get the maintainer's attention. Feel
> free to add my:
>
>   Reviewed-by: Jeff King <peff@peff.net>
>
> after your signoff.

Resent with git send-email. https://marc.info/?l=git&m=153913190617067&w=2

> Thanks for sticking with this topic!

Thank you for all your patient reviewing!
