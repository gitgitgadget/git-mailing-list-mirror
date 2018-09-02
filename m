Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 569A01F404
	for <e@80x24.org>; Sun,  2 Sep 2018 07:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbeIBLwv (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 07:52:51 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:44876 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbeIBLwv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 07:52:51 -0400
Received: by mail-io0-f175.google.com with SMTP id 75-v6so13598786iou.11
        for <git@vger.kernel.org>; Sun, 02 Sep 2018 00:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OFtTCbxDFaUi03y7D+qtyptSlKmDwA1/IticFVm2Ybo=;
        b=Jwvtz4M5P6cyUsbdStc8IOwFGZ/E9VKWeuKuxj8k/b0T7n/XYxzSk1BN7P0IbkVQZo
         hB4uQDGdj8fxrKG51XNenxY+UoG1lUm+78wfDSexU6Tem1umO0kN2X0mvWKGJsiHb/oR
         68S5cXz+S1dt2fl6kMKFh7phalfIcfo4tlVPkAVYxVhhiGlWqS/r89yGgeIWko8pSrZY
         L4/YdociituJQNL3f57uBP4tp5zLwxvNxFuL/c/Y07SFd2z0ch9qiM36U2rV7ggt/Eek
         +znC76zQYDI8myjddYZ6tbyzomOSFqFIXZM2OpQYHER6ca0QSkWHlaGpWk6+5+nDYGoU
         55/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OFtTCbxDFaUi03y7D+qtyptSlKmDwA1/IticFVm2Ybo=;
        b=FxSifllsPUlRT/S1YM/ZPzGDNDq8yKaFiIlQu7zl6XIT8X9kRN3OWnyhjchFmtOftp
         HLnU/OGVVAceXrgKAvqa73ODnYU+nmVsO5Dc57UAODnKLlmV9WMcOkuSk5CARFV4v4MD
         LWHEzx7bqViibfVUibyB9mgl9w/RksL0yt/VdsAm/tMCr2acN+E+LA5f+L5qouAzMzjl
         qd8E5AqnbWo+GwxGke7C6/gVzH91r/Anm8tAvqWPb3BeuWSjK4aRDcktkcW+QASFCE80
         doHAyj+VfXkrgzrq9bIN7HkLXnoCahSQhjKgWpWR2zVHDp5fuWELKIUHHIXL2YedwKa0
         a6Bw==
X-Gm-Message-State: APzg51DJdTP59BfS1dgy6kAFRwEmHkXi114dgzjUFmo7+ElqLhnLV6Zh
        VGRJ5SIR4naOgfoGTJR3sVlwl2yS8UxulbkBQ7+y/IP8
X-Google-Smtp-Source: ANB0Vdbh6NcKCxbmmJeZtvuAVIxybu1t9tKO0W8dzZCeiS4O8v23UyR8o0VFxvIC2cv4cAGzso/leBJKhJQga2ZRMuM=
X-Received: by 2002:a6b:500e:: with SMTP id e14-v6mr13521156iob.5.1535873880630;
 Sun, 02 Sep 2018 00:38:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22a7:0:0:0:0:0 with HTTP; Sun, 2 Sep 2018 00:37:59 -0700 (PDT)
In-Reply-To: <20180901084321.GC25852@sigill.intra.peff.net>
References: <20180828151419.GA17467@sigill.intra.peff.net> <CAP8UFD0SYECLk--7JsZkxBdQeJPuG1Ut5GMLsCJHqM+jG7C0jQ@mail.gmail.com>
 <20180901084321.GC25852@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 2 Sep 2018 09:37:59 +0200
Message-ID: <CAP8UFD1yZzbfuss8PyrXQ9SS+rKuS2vey4Mn9xtxWL4rJy2q_A@mail.gmail.com>
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

>> I can also look at getting outside funds.
>>
>> My opinion though is that it is probably better if the Git project can
>> use its own fund for this, as it makes it easier for possible mentors
>> if they don't need to look at getting outside funds.
>
> I disagree. An internship costs more than we generally take in over the
> course of a year. So we would eventually run out of money doing this.

I think we would have time to figure out a way to get more funds
before that happens.

> I also think it doesn't need to be the mentor's responsibility to find
> the funding. That can be up to an "org admin", and I don't think it
> should be too big a deal (I had no trouble getting funding from GitHub
> last year, and I don't expect any this year; I just didn't want to start
> that process until I knew we were serious about participating).

My experience so far with org admins who don't mentor is that they are
likely to loose interest in the program over time and stop doing much
(which is natural, I don't blame anyone). This is what happened with
GSoC org admins (who don't mentor), so most of the admin work now
falls back on mentors (org admins that mentor).

That's why I fear that in a few years the burden of finding funds for
Outreachy might fall back on the mentors too.

> So if you (or anybody else) wants to mentor, please focus on the project
> list and application materials.

Ok, I will do that. Thanks for taking care of the funding.
