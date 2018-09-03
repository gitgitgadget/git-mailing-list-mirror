Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9999B1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 04:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbeICIyn (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 04:54:43 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:37633 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeICIyn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 04:54:43 -0400
Received: by mail-io0-f173.google.com with SMTP id v14-v6so14901560iob.4
        for <git@vger.kernel.org>; Sun, 02 Sep 2018 21:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q5v4EminebH3qFiF+9W/YA1s5mOR8kTWOEwpiX30wuw=;
        b=NgfjiM5zsdrRobQ1xp03CbaChgxEdcPXKuA1ZVzAslHWZE2VEG0ha+ZEmx3lIvTZ9g
         XZIrtyDGOEx0Dql/4tkVUoWFwye09rINixgMahlB7i43mQl2baITCxeroSmACg/B51ns
         y9i4lddyWhI+UD0JkdIzPBDnIIp6j96ADGa3Fwn35yiCpIbwpNtrY2EcXKECOrI1FmZZ
         OTK1r42Ke1PFD132YT3krvnezZ1R1QEBhzg5TUrae8yS32lyXkMQPDdd4N8eMSnMbK5s
         aCZigdHRZ5OUxrA5Mo+gTSQGmEoUqN1/biuDieL8dWHtHehRSEZCpiKq8jaYu0LYjNNZ
         BNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q5v4EminebH3qFiF+9W/YA1s5mOR8kTWOEwpiX30wuw=;
        b=L1jew92ukl5RfJwFdECgXsRdf3RpMljAR0dgUz/xr6kijxJi3k7O7DU4hiifD4l6pe
         adNiocKmYJhyXVZQxXx36n3JIMV2sIBQc/TnADv0fR4+QfAfF/HKID8zybT9Y014s9FB
         b9PvHdBhbqT3893nBoUJaUIGtK101ulNcULlnsw8rK1gOI58d8zo2VnKQQRYdyuPcZt1
         sdQiQqDsn1Hw/5bAMUVrCC2j2CZ6eXcX6jYItxo6Grx4F4IfzLZzWx3r/VWrt7k9OmkV
         /FnIge2GeeQ9cISGNWKN+QldsQG/ZmRsnCcyWKlswEsZgT+uq2aN2PxYr8ral7YZrcxz
         jzyA==
X-Gm-Message-State: APzg51ClYHz8qXKxr3j7I0KoSmC2jpBuQW5yU16OQWpzA5XD/zmPo5uj
        zzXjtyUA047aehPLprs5cZl9PdgVZwc9VEWaanGjvQEd
X-Google-Smtp-Source: ANB0VdZQiSXTdLh8kXXVgXbblk4SUAeDuS8Iek7M+m13uPE6kDTX/dgUYm1vS4hZ60+H1sopr0NH5PA5ltwOPMYFnRk=
X-Received: by 2002:a5e:9615:: with SMTP id a21-v6mr17934288ioq.53.1535949380139;
 Sun, 02 Sep 2018 21:36:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22a7:0:0:0:0:0 with HTTP; Sun, 2 Sep 2018 21:36:19 -0700 (PDT)
In-Reply-To: <20180901084321.GC25852@sigill.intra.peff.net>
References: <20180828151419.GA17467@sigill.intra.peff.net> <CAP8UFD0SYECLk--7JsZkxBdQeJPuG1Ut5GMLsCJHqM+jG7C0jQ@mail.gmail.com>
 <20180901084321.GC25852@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 3 Sep 2018 06:36:19 +0200
Message-ID: <CAP8UFD0qk3SkBhuEiG+-qhTjXry1SH0SmoFjSNmPr6WZrLfijw@mail.gmail.com>
Subject: Re: Git in Outreachy Dec-Mar?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 1, 2018 at 10:43 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 31, 2018 at 10:16:49AM +0200, Christian Couder wrote:
>
>> >   2. To get our landing page and list of projects in order (and also
>> >      micro-projects for applicants). This can probably build on the
>> >      previous round at:
>> >
>> >        https://git.github.io/Outreachy-15/
>> >
>> >      and on the project/microprojects lists for GSoC (which will need
>> >      some updating and culling).
>>
>> Ok to take a look at that.
>
> Thanks. I think sooner is better for this (for you or anybody else who's
> interested in mentoring). The application period opens on September
> 10th, but I think the (still growing) list of projects is already being
> looked at by potential candidates.

So here is a landing page for the next Outreachy round:

https://git.github.io/Outreachy-17/

about the microprojects I am not sure which page I should create or improve.
