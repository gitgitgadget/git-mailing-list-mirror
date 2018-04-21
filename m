Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB331F424
	for <e@80x24.org>; Sat, 21 Apr 2018 07:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbeDUHAY (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 03:00:24 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41545 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbeDUHAY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 03:00:24 -0400
Received: by mail-pl0-f65.google.com with SMTP id bj1-v6so6417599plb.8
        for <git@vger.kernel.org>; Sat, 21 Apr 2018 00:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rV9Yo+BVnxobI9x1sEQrgrYKntHtbJScm5eSBxMoGeg=;
        b=gV/hJazDgAkJfMMhb0ocv6NXikFT5Q+HRiQAhvN3CscjetK9neSdzsCzQ9p2EJ1lcl
         kWBNKhZT+xFpT+HwM14PsdgnFx7o1DL/yE6R76TK5qMJrgegeNNn8oC/jF2MgKCuIQkD
         L3yAhrCWUgj0q9C5wW7qnMPWVRJJdZdLDoncOrC1cNq1OXcvHYju3GW1BVNdaojj8vrw
         32VVyOsx7KeroR5td6gg4rGtI0fY9ItTjaNkrKs1VFQwGUdhpTEYUqr6ks78vzgQmnl0
         rQbsX4RZr5nH8qRcJX38As/qrSuY2nokpOtpGKlnHVxkbynT28NpoKzOPdcG4m0QexLu
         pdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rV9Yo+BVnxobI9x1sEQrgrYKntHtbJScm5eSBxMoGeg=;
        b=CXbe5Y0+M+eQOSkbHPt1uhUQSpjsU0mJNo2ovaRvOizGgID+q0U4W4FmUceTkNazdp
         /QsChN/OQhHjaEuFv/rFiNQ0gOD1acr6LmWJsu9IWI4f99GRBG0zlEXV/NHThfpkvzSJ
         KtAoU0IE24rI20wV9SPZ3rcNwIrdNJNIsAlIbWo6a4e5/NK+3tbd6H7koDjJEbfjv7x1
         HjMfN8xYQRZmjRVCjgVwV+FX8obHKTFmStDcuIIZQDSoAu8EBxopkAGAQACpu2gVe7fm
         YRlAn7Apr+Kmr+wu5e+I7mAWvf3749LZn3Lsp/oBjQjcEmXAqAVmXLsMop9clsTu+qMD
         R5FA==
X-Gm-Message-State: ALQs6tB0KbeCE8fmQM4vZLvaemvlSSflsIwfgU/YvjhyAvmx4FLrtpyR
        +35r/8Bxpo7bcv0BZCEhAclNlbXftUje+/sQ1bY=
X-Google-Smtp-Source: AIpwx49Z1BoPPnpabqU7N6han9ESTXfoeymatm6FZkGFosGJpIK+Zvv3Wmme9a20FmM5oaWC+P/ROdqOV11s+72NinM=
X-Received: by 2002:a17:902:1c7:: with SMTP id b65-v6mr10631556plb.298.1524294023753;
 Sat, 21 Apr 2018 00:00:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Sat, 21 Apr 2018 00:00:23 -0700 (PDT)
In-Reply-To: <xmqqh8o5b4ww.fsf@gitster-ct.c.googlers.com>
References: <nycvar.QRO.7.76.6.1804202258071.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180420221231.4131611-1-martin.agren@gmail.com> <xmqqh8o5b4ww.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 21 Apr 2018 09:00:23 +0200
Message-ID: <CAN0heSqQckJT-4mHbwoP_XjbE2-UH8+k2nG6mnN76_t3nzO_xw@mail.gmail.com>
Subject: Re: [PATCH v3] fast-export: fix regression skipping some merge-commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Isaac Chou <Isaac.Chou@microfocus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21 April 2018 at 05:43, Junio C Hamano <gitster@pobox.com> wrote:
> but I do not think the updated "fix" below is better.  It might be
> just aesthetics and I suspect I won't find it as disturbing if we
> could push with
>
>         object_array_push(commits, (struct object *)commit);
>
> or something that is more clearly symmetric to object_array_pop().
> The "Queue again" comment is needed only because use of "add"
> highlights the lack of symmetry.
>
> With add_object_array(), it looks somewhat more odd than your
> previous
>
>         peek it to check;
>         if (it should not be molested)
>                 return;
>         pop to mark it consumed;
>         consume it;
>
> sequence, in which peek() and pop() were more obviously related
> operations on the same "array" object.
>
> And I do not think it is a good idea to introduce _push() only for
> symmetry (it would merely be a less capable version of add whose
> name is spelled differently).  Hence my preference for peek-check-pop
> over pop-oops-push-again-but-push-spelled-as-add.
>
> Not worth a reroll, though.  I just wanted to spread better design
> sense to contributors ;-)

Thanks for your wise words. :-) One thing that just occurred to me is
that if the original site where we `add_object_array()` all objects
starts adding a non-NULL `name` for some reason, then we need to
remember to do the same with this new caller. I suspect that at that
time, at the latest, we will be switching to peek-check-pop.

Thanks for sharing your thoughts.

Martin
