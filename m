Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEE371F453
	for <e@80x24.org>; Fri, 22 Feb 2019 09:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfBVJOZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 04:14:25 -0500
Received: from mail-it1-f179.google.com ([209.85.166.179]:37814 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfBVJOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 04:14:25 -0500
Received: by mail-it1-f179.google.com with SMTP id z124so2185686itc.2
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 01:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=GdLLRVsynaS4rXxQc/oKTFo/aLVHwzlsUI53G+EQrsQ=;
        b=gth8vsPUtaAiGIy2g4dR5M5MX4cbjZbO9cRRnPGE+Dn61VLNpT36P2+Ti5/Qm7beLC
         qA9DoxY3fzKPNaD8D0iQVFBlHs+JRKjfWJxSCAsomZGa/3/HYO5ThOAUGdqP53HPOybq
         XYPFXlU9GaeCxet6yDV0Ztt0xJyQXbCYrSDTR4ulNvgZcSc1YaeV15WOsC3wI+8m6wAX
         f84FpQJKFkfW24nIpfQPrE7F01/X9KRiHaXecrLIrnkRpN+xLCpRs4YbslaZMf0mBkPO
         E5TqIG3dxAtkGoqSEzCNd6BDsa/6Lk6Qriv1qSwtI/Vx5jHZR7xzWI2a/tZ5vRZ09FMH
         kplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=GdLLRVsynaS4rXxQc/oKTFo/aLVHwzlsUI53G+EQrsQ=;
        b=DnwdbaT3siAfdLV0BMcjRXzU2fYc1zBylTZ03DqdB/9XsI1ZuaaeHTriRQ7Vwr9VBd
         xIZ6O2iQO1zIuBjOuWpoGjGxe800h0h15VDSEqmBn9N+nw+oyqWAQ1Jo/1A5hpJQfcJv
         usbhdlTzZYlGOweOeA8JDgZgkkdd04kudhGpx5l0z5VeWIvQc6dyzx6cRafxo25HkpQo
         yFjTEx1OccgLc8c3VzKuDW7S7F1K/OPfozN0YXlvWYYHdVehzqC1T2GQNQ0gL6Kkos6m
         JlUzGDvLd0ouRCiNHfizoptiMCtadVWtocSfO2kUjquDz2T0LsMl/HPZ4l8y/690+nfm
         R2pQ==
X-Gm-Message-State: AHQUAuYmm2dJlpySHOoqPXUzV1ssKLV6l/L4d9u4kL3wFrJjMJ82uzb2
        ukXh3Eyy0dxmi33dFx8VvqIEiG7Nr/K2rbu9Vlo=
X-Google-Smtp-Source: AHgI3IbAZ+ywRBeomD49I8jUUyZ8e3k66n1b/Sf1GcPSu4hz714RkYIWYhTpHbXuccLktci83UGJ85d3lb5j4AH/rXo=
X-Received: by 2002:a24:7542:: with SMTP id y63mr237796itc.70.1550826864535;
 Fri, 22 Feb 2019 01:14:24 -0800 (PST)
MIME-Version: 1.0
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com> <012601d4c8b5$54f1b730$fed52590$@nexbridge.com>
 <xmqqftsiw8l8.fsf@gitster-ct.c.googlers.com> <CACsJy8D=-+TqZSf1oyTJs_O+=KAV66OE_As5cTKXxHoXAhzkGw@mail.gmail.com>
 <20190221235534.GC488342@genre.crustytoothpaste.net>
In-Reply-To: <20190221235534.GC488342@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 22 Feb 2019 16:13:58 +0700
Message-ID: <CACsJy8BMSWLWwsFbjBbO5sZnibiqp5KYD2Zk+5YUEkTiVQwWLQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.21.0-rc2
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 6:55 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On Thu, Feb 21, 2019 at 08:10:00PM +0700, Duy Nguyen wrote:
> > On Thu, Feb 21, 2019 at 2:41 AM Junio C Hamano <gitster@pobox.com> wrote:
> > > Another mention of /dev/zero appears in t/helper/test-sha1.sh (not
> > > to be confused with t/helper/test-sha1.c).  This seems to be run
> > > only with an explicit "make -C t/helper check-sha1" request, so
> > > perhaps nobody on your platform ran it to get hit by it.  I wonder
> > > if anybody runs this on any platform, to be honest, though.
> >
> > I vaguely remember Brian added something to test SHA-512 performance
> > but I can't find it. Maybe when he adds something (if it's not there
> > already) we can retire this script, or update it to check sha-512 too.
>
> Doing git blame on that script seems to show that it was written mostly
> by Junio. I think you may be thinking of test-tool hash-speed, which can
> be used to benchmark a hash implementation. That's what I used for most
> of my testing.
>
> We may not need both anymore, though.

Well since you're basically killing sha-1 everywhere. I'll leave it to
you to delete check-sha1.sh if you delete hash-speed too :)
-- 
Duy
