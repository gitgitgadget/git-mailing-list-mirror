Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A1020248
	for <e@80x24.org>; Sat, 16 Mar 2019 15:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfCPPbe (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 11:31:34 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:36344 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfCPPbe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 11:31:34 -0400
Received: by mail-ed1-f45.google.com with SMTP id e4so10072683edi.3
        for <git@vger.kernel.org>; Sat, 16 Mar 2019 08:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tpQ1khv18Tc3NDTYgMO12CcD0go2pd3B0l1wwEjAfbA=;
        b=mzjOEQtS6Yfcv7Uw74jsz1xG0F+mA5D4oaR/su+5K7LjfdFQaaHYrQipSU80zzWjdy
         sXwgO3uJA0giIXv2noronSwEzfDKTRaCWYHJuhIzDqLaMRO9kb5MTipnbyxXpquL6Clz
         0RORjq9Y7d5R4+3AmYNePcbRTl1ckFQQLATuYPxdU9HFTUQjZZbSEqrOflyCYKQBmez+
         Je4AGtZh9VSQ2fvDzCg11EuRL7w3yIujfqdnMCpuwvOkR+rMMI/EVF4UOhDtMRXVnlZU
         Fc/rqRFWEOEWzaq8JrwDeTaU4wsrXAhRoREIHHkVfrNMV0+/ZCus0WDj/7AhrkbSxD9P
         lDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tpQ1khv18Tc3NDTYgMO12CcD0go2pd3B0l1wwEjAfbA=;
        b=j7cCiEuBMDzsRgOyG8i+bo/BVZg8ifZQ0ersKSrSoIJKsAvIixI7w6745BiSMgnX6j
         nk3Y77jDMZ24Mjys9V6rt6gPg55KV8c3Xf/RthTNNsA3getbKZu8uUHIIrpOO+ACPkrA
         ATYhpAcoAsM+KJuMZ1V68g1TbsmcAojieaJ4BH18cUrFdVcfFfWAepf5AXBE6Gxrj1Q5
         PQSa0nDcutri+xZbl4FBpnGsrZrPf0HWOZLdUU96k2oh6C/iSu5RVojclzpRRYDGkg8Q
         nPWvmHDQFWXno3r5F+lK6fAl/7ktpQKxwYI71hW4DFAmaSdSh7MEgEMqgkHmv3r4yXOE
         F86A==
X-Gm-Message-State: APjAAAUtiIqi6qMMVFC+h8M0CWFUTJanLg4sWVfaaJOwsuGNskTMw5+t
        f9tmTcASC9x7y0MWNM+E2umIvtbBkhrzpa3q3wE=
X-Google-Smtp-Source: APXvYqz2agM1YJ2A3HKFaszKTmja/HuPeqDiM6/oBl4+BPo5SCgWIF7J6rC7Ko2fOD6xB3mw67Bb6OYl6WJ91YR8X2E=
X-Received: by 2002:a17:906:48d8:: with SMTP id d24mr5585209ejt.172.1552750292528;
 Sat, 16 Mar 2019 08:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181109104202.GA8717@sigill.intra.peff.net> <2139295744.18413.1550666884748@ox.hosteurope.de>
 <87ef82628j.fsf@evledraar.gmail.com> <20190221045904.GA29732@sigill.intra.peff.net>
 <20190221082218.GA3335@sigill.intra.peff.net>
In-Reply-To: <20190221082218.GA3335@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 16 Mar 2019 16:31:21 +0100
Message-ID: <CAP8UFD2+J2KMWXu1FSfBRifEXd85Lg-W6Pmix2bUcyrMsfGThg@mail.gmail.com>
Subject: Re: Git Merge Conference Recordings [was: Re: [ANNOUNCE] Git Merge
 Contributor's Summit Jan 31, 2019, Brussels]
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 9:24 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Feb 20, 2019 at 11:59:04PM -0500, Jeff King wrote:
>
> > On Wed, Feb 20, 2019 at 02:03:40PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> >
> > > > I wanted to point a colleague of mine to one of the talks.
> > > > Unfortunately I could not find the recordings of the talks anywhere=
.
> > > >
> > > > Are these available?
> > >
> > > I have no insider knowledge, but can tell you that in past years it's
> > > taken GitHub a bit to process these and put them on YouTube[1].
> > >
> > > E.g. last year's conference was in early March, and the videos trickl=
ed
> > > in in late-March to early April, the year before that it was in Febru=
ary
> > > and the videos were published in May of that year.
> > >
> > > Historically the 3-4 month delay has been more of the norm than 1-2.
> >
> > I think they're shooting to have them out sometime in March, but I've
> > asked if they have a more specific ETA.
>
> The word I got today was that they're trying to have them up before the
> end of the month.

It looks like the videos are available now:

https://www.youtube.com/playlist?list=3DPL0lo9MOBetEFqBue4vNcTEnkBjgIQU1Q3
