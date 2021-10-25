Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21534C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 17:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F395A61002
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 17:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhJYSAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 14:00:33 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:35417 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhJYSAc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 14:00:32 -0400
Received: by mail-lf1-f54.google.com with SMTP id p16so14332689lfa.2
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 10:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6glalwVzWzGZ3ZKdbZKU+7T2ZAIE2jAEz/hY+ffEgU=;
        b=yFspkwmZLNhjpRkvezKJIWYjcaPRj0ESW30TzurzoquIDBKeLN0Mzpe6+R0bIavd+e
         SFp07j8rQntugosBbYUp5h00PyCAfs4gdHs0sR0QHo2+mskU+5QsMR3XfKpKPkCnlxvI
         Kp8+UQOF3Ri2WpNxJzP/cFobqUQmVhJHFO2Nc/SaZEqRiE5oXBkOTm/ouw5GmG4/DMxM
         bZ+2HUyGX684yBB43aaeQDXaCClWRmtrLBaGZuBys5qNL+CVLA9Vzxzm0+v9VrA22uqC
         bcQLtD0fhmL++vhlLGx7kFY0T9l/TicTBFWcU94TVShhNfWupC3S5A1rKHcBAk3Au6O+
         dGCw==
X-Gm-Message-State: AOAM531ZvtYjD5HgYBzE0zvyk7H+f6NI/hVFrTJY0COjz+BvvRZ0s0Ye
        X2u4hpfQV3QudTc3WyOo00GuQ0UbARSQPPRnaXACTKY7
X-Google-Smtp-Source: ABdhPJwEL173GYuW1uQCiitBow0/taBaJ7ZsbWwVH9Mey5ukyuwtRN2FyrPKODuyXQ3yUJtTZHv9h1zn26wJSk4cy8I=
X-Received: by 2002:a05:6512:3b5:: with SMTP id v21mr8656855lfp.352.1635184689215;
 Mon, 25 Oct 2021 10:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211022064543.28950-1-bagasdotme@gmail.com> <CAPig+cRAi4ZR+_+Dh+DoUBkG=sgWTekxadob2YvThJQhr9tqfA@mail.gmail.com>
 <xmqqcznvbg2m.fsf@gitster.g> <CAPig+cQ8NEKY3nwuFi_7Hc7L7rnbcUShf3zw60PvBB8LOPEgPA@mail.gmail.com>
 <xmqqsfwp0zcv.fsf@gitster.g>
In-Reply-To: <xmqqsfwp0zcv.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 25 Oct 2021 13:57:58 -0400
Message-ID: <CAPig+cSiAM5wq0+wcpdaEHpyXwJkC2j0WnErf_hS0ZXsjUxA_A@mail.gmail.com>
Subject: Re: [PATCH v4] archive: describe compression level option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>, vagabon.xyz@gmail.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 25, 2021 at 1:49 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >> In summary, perhaps something like this?  I still have "-9 (best
> >> ratio)" which does not say it is merely the intent and not
> >> guarantee, but the resulting text read a bit funny with "best ratio"
> >> replaced with "try hardest".
> >
> > This version looks fine. Thanks.
>
> Thanks for proofreading.  I have locally fixed a grammo ("Larger
> values allow the command"), by the way.

Bleh. My eyes slid right over that grammo. Oh well.

With that grammo fix, it looks even better.
