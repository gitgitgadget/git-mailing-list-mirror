Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA1561F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 10:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfJIKgd (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 06:36:33 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:37218 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbfJIKgd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 06:36:33 -0400
Received: by mail-ed1-f42.google.com with SMTP id r4so1560012edy.4
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 03:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OaX1UiDvAxPcvL+N2FKIGadfgRIgSog1RLOEbI9lL5A=;
        b=VLqVrNTMSygRcbwokiDLRY9sCWEeQVqdMwiEhjjrMAipwNheLc1QtjuuR59sgz1MhI
         p5P/NIHJYiMYek6D+6npDs2IrAqSry3Y0ZZAcZGYR3bvT5BWhmMKTW/PM/9Ka0SsE0pO
         7KEm2D/HlqXinXC6Ez29eVYy+rqj41WwR1BDCvf1Hwvc1oio+St4k6vTKk+Nzbe56Ubz
         F8Wy/NdsIKVolvwF/batuAjyQe4CENKCYUIno6Yd3DIIx4LHRd0D3GXramyEq79Nlx9V
         JJZ3FWLGFIEnLHS9OHZX+0z2zle7HVTIcUx5t86k7CFkzSjDO8CAT5qjOgpr3srBrgiA
         tIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OaX1UiDvAxPcvL+N2FKIGadfgRIgSog1RLOEbI9lL5A=;
        b=Lfk2Sj3KCbtF16BaARxNX+bcVusMbjSb9oVExfoG6Pvg1HrfdVTyyHjgMFbT8yfcEN
         uutU9WRv/6WIjyTvBMYEDUI+AHOL03oFgcBWj+ibWiyxOD9zdk9gC1bjZUXA4v2X5OWY
         RMRHjpDa3egFUptT39T602rawi9jBLxae88Jn9SA9QW0XcuufF1IsVGnM5582f/hb25P
         ZFVWYHo4l02dkbYDcgZ9ZoYaqD9Zn8DDAK2nb4TWKSdVCHFSqkqDNJn1f4tpX/Rlbwgp
         4zTRF58WbC5qlVEWH+aC5gGwP/gHavmrUK0UqCCzBrzSzr4a4vafPSEAKfZnDF4iaXw7
         U0wQ==
X-Gm-Message-State: APjAAAUtxNXPrFTclGUv5hBoHA7rHWLPpGla9XnynArAHiyN1FTMbIzM
        /lHsqIkbEU3zha89NaMsZigM/B6bG1GE0jLFbyIRECslR/Y=
X-Google-Smtp-Source: APXvYqxxl909snEfofXIHGcoETvYDGa6nRNQTffbkdIBNaqa7QvNqntd8vYRTmS1Z7b8Tof8iXXU2bQd+7NORNZS+MM=
X-Received: by 2002:a17:906:c801:: with SMTP id cx1mr2143688ejb.266.1570617391667;
 Wed, 09 Oct 2019 03:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36g5444k.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910082111220.46@tvgsbejvaqbjf.bet>
 <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 9 Oct 2019 12:36:20 +0200
Message-ID: <CAP8UFD2Cm9+HkNndejOsop0bJ8c=PyMMemPobSPtgqguPFC8+w@mail.gmail.com>
Subject: Re: Raise your hand to Ack jk/code-of-conduct if your Ack fell thru cracks
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 9, 2019 at 2:20 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> For reference, here is the CoC the patch wants to add (there is no
> such topic yet locally, nor a single patch that can be made into
> such a topic, so there isn't exactly something people can Ack on
> yet. So here is a "preview" of what we would see once such a series
> lands).

Acked-by: Christian Couder <chriscool@tuxfamily.org>

Thanks to everyone involved,
Christian.
