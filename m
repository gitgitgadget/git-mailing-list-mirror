Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 430C11F42D
	for <e@80x24.org>; Fri, 25 May 2018 20:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030292AbeEYUdW (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 16:33:22 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35521 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968283AbeEYUdV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 16:33:21 -0400
Received: by mail-it0-f68.google.com with SMTP id q72-v6so8364693itc.0
        for <git@vger.kernel.org>; Fri, 25 May 2018 13:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TZGGxk+Y1w9ulPPW00Q0R9Y43pgrrCGPrTrVnauaJOk=;
        b=jvaFsCjY1jYR+gYFkXPqtd+GgKeBGXKezHgQgyvo2weEwcxjVYPPHvNauO5Q58cAFW
         7HXI5SMN4yvQssaY7xlVXl5iajNps16Y/787AMkWXc9e5AwmnOnbKcLNtFKOwDFCQwlf
         WHe9SouFHZf3H+h13gGdunGFSp/vSw8BWOf9+uztyTPHeUMpptxOrkpnNybJum6Y13yX
         TIHsZrtmw3GI9EftmT67SaE1Up2AK/9hWYhYzDb6CQWWPjoKmSB0Xbuvqp5jHlGiKZ8d
         8uurTiV+hcbPzxK4+DvipQb9BegXoxn8evw3EXeB69MOgQ5cBGONIsMCKgCtG6EUxJlg
         zGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TZGGxk+Y1w9ulPPW00Q0R9Y43pgrrCGPrTrVnauaJOk=;
        b=PY0xc48BV2NbmTJ1qhxxeu7kwR80TEFvUCQHaVtzw5yUKxNZQ+bAjTZjtI3jn5OQyP
         q13vSOhkhNWcPt1m71CCMoo0eyPqQuV7b0edcsAnyECKKVy1bdPQrGe55Nq2uIRG6tqk
         bWjZBORT9rxSibrw62bznPgbcgj9y3eMnuNVHlsgcXHkQXd7NQoYru/rBNdMY75Nhyyf
         r0oQWi0dwUll7g/p4EvAWvoNMIk3iPBKHGcjaOsl+AJsidBT1/iRqbnbGlt628AfzIV5
         BnaCTcCeQlAzsQ8ww1ywcZuNDVHVOjgTzRBwUSZrHDc4WufywI8TwN4t66H/1GOTz7rv
         JUAA==
X-Gm-Message-State: ALKqPweUxlRgjClxfLwEbg2SnAToXZMsNqrc3Q6y/KJA4I4ydu3uS4YG
        a6DrhR54TMXiSW+sEdUg6jDlklTj0q9dfUSkblE=
X-Google-Smtp-Source: ADUXVKLssle4ZW8tVWeW0Tx+BlzfUOHRfg9JyFPU3IBYW8ZTn33aJH5fH1AoM9+mO8YokmVhAVgY3vJPETxdJsA4jkc=
X-Received: by 2002:a24:8a47:: with SMTP id v68-v6mr3300540itd.21.1527280399865;
 Fri, 25 May 2018 13:33:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Fri, 25 May 2018 13:33:19
 -0700 (PDT)
In-Reply-To: <20180525192811.25680-5-avarab@gmail.com>
References: <20180524193516.28713-1-avarab@gmail.com> <20180525192811.25680-1-avarab@gmail.com>
 <20180525192811.25680-5-avarab@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 25 May 2018 22:33:19 +0200
Message-ID: <CAP8UFD2wpdTnis1zcjkHFnWDN5ZB+puWrGDX4m_cFWsgvNHn5g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] config doc: mention future aspirations for transfer.fsckObjects
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 25, 2018 at 9:28 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Jeff King has said on at least a couple of occasions (at least one of
> Let's note that in the documentation so we don't seem to be claiming
> that this is by design. A previous version of this change called the
> current behavior a "bug", that's probably too strong a claim, but I
> don't think anyone would dislike a hypothetical local quarantine
> patch, so let's we might change this in the future.

Maybe: s/so let's we might/so let's say we might/
