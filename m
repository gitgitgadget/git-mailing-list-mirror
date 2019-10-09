Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6380D1F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 18:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbfJIS3c (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 14:29:32 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:45846 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJIS3b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 14:29:31 -0400
Received: by mail-vs1-f54.google.com with SMTP id d204so2154280vsc.12
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 11:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dW8o2p81Xe5xYFDHpY+wy+mhyrcnch8jzSq94j/dIzQ=;
        b=L8hX3IQ+sKc5XXjPGMeOb8eDZcqp2y1LcmiMHR4+RbQRXCJJJUH3aQy0Hf5MdDPNvn
         g0h3SCz18lJTggEHXou+A/d3Xp052YixUdDtyw3xKl4ngXdepNQKFiYfKcTQYdD7+VRY
         yaqQlOcQ/e9IEwtbQbDxqLCAC91sFKT4gYouGikgL1dNvBIwargc//3r+9QEVpMaN6H8
         BWnIKt6+Y/PE11kTG3sOSfSEflMJFvSDbBlnfDyIG+Ddu7UwE4YSrmYI8VAninm7B1Ch
         xqHECKjOyVah4+dKf/N18llezgz04IERdvCowKa1IIvJ6LyQrzaDYA4GSoTkfF2I72VM
         8eAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dW8o2p81Xe5xYFDHpY+wy+mhyrcnch8jzSq94j/dIzQ=;
        b=jjH/oCuFPoH/+0ktUEC6Xjgof4eRGA14iKPXfuygRDabGvK6sg/lpcwO4Si1WBkn9Q
         TFhwnLc/0K28dq2Y0Y+gmEvUD/Gm8lXsoyDku9DfkVcX23ofxyfSE9YOQ77CJXQdUU12
         6Dnx7qavolenxCDHJ8u1P7hQRg83/LFe0YKhk3FO9HTNLoaGlGPW+UMatbraMnobM7zL
         VVfJ1+4e0z0EFmc+MB3sUwj1P+07SC5V0c0DzEyOHw0zNoEfwkEPvbzo4vq9NWrrXzL0
         YRdk5hKHLXmCXJ6JUp8nAzypVntVyMK1K5DS8+C57z2EbEDs80cDPmmhPrDCzMiRGaum
         AtBw==
X-Gm-Message-State: APjAAAXV2xZ7DayVgiqwM5+fFU6W+BqJz4r4YiUlDhAsZf4jJO/TzEkr
        BgcKH3qMNFxc+uZw9vFVZbx3eatI7yvmrQnhS2c=
X-Google-Smtp-Source: APXvYqyCY0Rrit4a1l1I9pRSrx9TuG7LJJIgiboD0SPN7RWjj3ZcRnOdoJJag9sa7+3VL5BtM8xMLc1PfERnCPWM2l0=
X-Received: by 2002:a67:f84d:: with SMTP id b13mr2710798vsp.136.1570645770642;
 Wed, 09 Oct 2019 11:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36g5444k.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910082111220.46@tvgsbejvaqbjf.bet>
 <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 9 Oct 2019 11:29:19 -0700
Message-ID: <CABPp-BGjaOofi_gWEatKnnkpY04OOyMDZucXqQ-FPYw8yeCacw@mail.gmail.com>
Subject: Re: Raise your hand to Ack jk/code-of-conduct if your Ack fell thru cracks
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 8, 2019 at 5:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > In other words, the commit message can be augmented by this:
> >
> > Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Acked-by: Derrick Stolee <stolee@gmail.com>
> > Acked-by: Garima Singh <garimasigit@gmail.com>
> > Acked-by: Jonathan Tan <jonathantanmy@google.com>
> > Acked-by: Thomas Gummerer <t.gummerer@gmail.com>
> > Acked-by: brian m. carlson <sandals@crustytoothpaste.net>
> > Acked-by: Elijah Newren <newren@gmail.com>
> >
> > Junio, would you mind picking it up, please?
>
> I trust you enough that I won't go back to the cited messages to
> double check that these acks are real, but I'd still wait for a few
> days for people who expressed their Acks but your scan missed, or
> those who wanted to give their Acks but forgot to do so, to raise
> their hands on this thread.
>
> Thanks for starting the concluding move on this topic.

Agreed, thanks.  There is one super minor issue, that I probably
shouldn't even bring up but... Looking at jk/coc, it ends with:

Signed-off-by: Jeff King <peff@peff.net>
Acked-by: Christian Couder <chriscool@tuxfamily.org>
Acked-by: Emily Shaffer <emilyshaffer@google.com>
Acked-by: Garima Singh <garimasigit@gmail.com>
Acked-by: Junio C Hamano <gitster@pobox.com>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Acked-by: Jonathan Tan <jonathantanmy@google.com>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Taylor Blau <me@ttaylorr.com>
Acked-by: Elijah Newren <newren@gmail.com>
Acked-by: brian m. carlson <sandals@crustytoothpaste.net>
Acked-by: Derrick Stolee <stolee@gmail.com>
Acked-by: Thomas Gummerer <t.gummerer@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

Those Acked-by's are nearly in alphabetical order (at least at first
glance) until Brian, Derrick, and me.  I know it's a trivial thing,
but for the OCD among us, could it either be randomized, ordered by
when people acked, or alphabetized?  Sorry if this sounds really
trivial, but it's kind of like trying to hold a conversation with
someone at their office when the cord to their phone was all twisted
up; it's really difficult to pay attention to anything of substance
until that problem is fixed (though, thankfully, a job change in
combination with cell phone prevalence have almost completely
eradicated the phone cord problem years ago).

I'm kinda worried that sending this will result in someone
alphabetizing everyone in the list except me, but oh well...

Elijah
