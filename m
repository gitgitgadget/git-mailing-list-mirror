Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A78DE1F404
	for <e@80x24.org>; Sun, 16 Sep 2018 06:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeIPMBW (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Sep 2018 08:01:22 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:38203 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeIPMBW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Sep 2018 08:01:22 -0400
Received: by mail-io1-f52.google.com with SMTP id y3-v6so9081494ioc.5
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 23:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d8hVD00dkP5mkKB+vy4SgzYP6zAPE2QzBesoTj1GyC8=;
        b=gUZby6q+QKNzfEo4kTC6EiWEwlA8hyYqvLnYyIxyaeWyXiDexPe49zT0XFz7E301Vq
         tfuQQR/gIRyO0+nUhjphLE9cCKjtBl+hojufkIgmJuPAqYJkI/PILPjW8BkP2KMCJMUY
         TRydZN89qZBZQrsfFwCzxqkIbgkY1kpGs8sT6zAYPHLmorAWw/vyjmyJus3WS2VXCuJN
         ZM84ymspfGsYWOgGNcFLRyWm1/ESkzLg554JLEt/2F7mtKc+1KDzDnUD1hCsPrIy6J6M
         /m3zq4W1e/1cXnQROGka1MsEclo8Jn+0gd/GiR2VqdIW/q1mj5VlTvWJIJ18vsIMK711
         EXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8hVD00dkP5mkKB+vy4SgzYP6zAPE2QzBesoTj1GyC8=;
        b=FzE3ocYABYua4UhyW6Gi15Krv07XT80e1MH1gfIhsAc2vEV4IwdfqmEyoTSEc476E5
         bSLcmOX9xkSpQtRnEeFxUi+/sgSeR6z2m6XYD63yJ0LuZopz14p/c/dm0+210fMa3rdz
         FGTGIjUemOHz/ihMICFmlLOWGOQFfu3Z23/G/bW4xunMm1rKKw3kvHdRBK2lpMBa+2pb
         TwviwvaTpNwsfA+SHLHCneeE7BfAzA+Hv7+RZ2tAuzw2w9A78cdL2VdJu4epUzkCCzOZ
         xIoei/VU/WfNOnm50tnPNDGmxLL6gAVJ1IpyT5M+SFBbnCxuwFen1inshApO6YQxVvBO
         KviQ==
X-Gm-Message-State: APzg51Ao32e1jQ9Rz/mfoHmZwLrt14uMBjGei3eAKVoGFa0t1ZMXr7Zl
        aAeQNCdq25SqYU2KbkGP90c1D6aZ45Pv/uCvDa8=
X-Google-Smtp-Source: ANB0VdZfhI/apkUg89foc6RKF/3Li77/5SjVE+HAXR70O2GQTVrQ5GGbSTy92J2Tzpgiz+xz6mjn3i58vlwiD/09tC8=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr15199740ioe.282.1537079969714;
 Sat, 15 Sep 2018 23:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 16 Sep 2018 08:39:03 +0200
Message-ID: <CACsJy8DXT8rF_WYE3C0ak7E8_8j=kRS+Yhi1pZjKd5Rr4OsM_A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2018, #03; Fri, 14)
To:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 14, 2018 at 11:56 PM Junio C Hamano <gitster@pobox.com> wrote:
> * jn/gc-auto (2018-07-17) 3 commits
>  - gc: do not return error for prior errors in daemonized mode
>  - gc: exit with status 128 on failure
>  - gc: improve handling of errors reading gc.log
>
>  "gc --auto" ended up calling exit(-1) upon error, which has been
>  corrected to use exit(1).  Also the error reporting behaviour when
>  daemonized has been updated to exit with zero status when stopping
>  due to a previously discovered error (which implies there is no
>  point running gc to improve the situation); we used to exit with
>  failure in such a case.
>
>  What's the donness of this one?
>  cf. <20180717201348.GD26218@sigill.intra.peff.net>

This topic has stayed in 'pu' for a long time. I thought it was
concluded that this was a good change? Jeff, Jonathan?
-- 
Duy
