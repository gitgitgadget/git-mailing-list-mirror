Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBB9C1F462
	for <e@80x24.org>; Tue, 21 May 2019 11:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfEUL74 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 07:59:56 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:38249 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEUL7z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 07:59:55 -0400
Received: by mail-io1-f50.google.com with SMTP id x24so25684ion.5
        for <git@vger.kernel.org>; Tue, 21 May 2019 04:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WxVOX4Zxh2ZDIqYe7McVgwoVx+D6itHibQjRw03zNgM=;
        b=FBCsgKzJCH/tBlGO3Cbu63lOWCOFmfqRy32E3KUsyoqLytrOd0To1WXbVy8vpxiOMe
         SiD8lz7WEFTqtCP4R1g8pHj/pnyI0UobUS53wvpTDUS0TCP2Zf1zEd4DFZq7/8+J633z
         GspQlzcSkW7xYxmpMOKNM4N/RgnBwFRX6Hx8imfGFbwMbtFZv2BuT2HrPzuVBgp1xKyL
         gHfr593rDfxBWGTGeYquKU9ZQSfNc5NCb9NrClzWXfYG3vCa+uqUEh1yRJET+MJ/91qA
         Ivj8TKtDE6YZMUsYe9KMVmodJSY7jeH/Uf8emULuDl2skUchhvxpDbn9rRy5yqdEm2wS
         rL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WxVOX4Zxh2ZDIqYe7McVgwoVx+D6itHibQjRw03zNgM=;
        b=lsu17evnFr0Wr12qRZ1WeJxbIZFdO9Ot3QZP+r3A9gO/6z6sPmTVdXFotypY1itAI4
         69Wz1QYQc14XtymDuqoD/3O5DgvBAp175Z24mURWclgx0Vc/xuZqgMtDbi57gWzrj4zY
         f+errNBvfI0KlOVcOolSjY8AtJD5KkM2e5N54LJmrGapHo54lzx4TkYrLAIqLFfSScJj
         YUuRJv2yiNkgKe/o9GWKLzNZokNIddOiPCA639diCMnkYsvfOJWT+nRFfPbQ9WNxS95o
         lcL9H6cdyvTcsQdY8Z//jqk/jrKnNv6vQQGvmVUJoaG8CTi8EFue9hSQdYhsOWxT/IdV
         Pp1g==
X-Gm-Message-State: APjAAAUuLKyzPTaHqgUhxv1NDnqwy0ix1Hx4NqGr9AZ7iMiWY/Pj96Kq
        3JzYIooCstfBh2Tmquy9++RrSDiwy/D66Fuo7ig=
X-Google-Smtp-Source: APXvYqxSH4qgRuZ7s//fcyx6QQKHDyISAK5gkQoLArEC8MD3z8ra3lHKOkLR4YYha9MSQPaLbqZHiAhqxzcOW6Dxk/w=
X-Received: by 2002:a5e:d60f:: with SMTP id w15mr40796375iom.282.1558439994992;
 Tue, 21 May 2019 04:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <019e01d50fc2$324bd400$96e37c00$@nexbridge.com> <87a7fguiwn.fsf@evledraar.gmail.com>
In-Reply-To: <87a7fguiwn.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 21 May 2019 18:59:28 +0700
Message-ID: <CACsJy8DhsU6CL95W9gsWaTSnN+_7Z_+Q7yPjhuDRRKfCrhnz2w@mail.gmail.com>
Subject: Re: [Breakage] 2.22.0-rc1 - t0211-trace2-perf.sh
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 21, 2019 at 6:51 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> But the real bug looks like the trace2 code unconditionally depending on
> pthreads, even though NonStop has 'NO_PTHREADS =3D UnfortunatelyYes'
> defined.
>
> That's why we get this th%d:unknown stuff, the trace2/tr2_tls.c code
> using pthreads is failing with whatever pthread-bizarro NonStop has.
>
> That seems easy enough to "fix", just always fake up "main" if we don't
> have pthreads, but perhaps Jeff H. has another opinion on it...

That's not NonStop. thread-utils.h (re)defines pthread_getspecific()
to return NULL when NO_PTHREADS, which triggers this I think.
--=20
Duy
