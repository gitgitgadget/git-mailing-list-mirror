Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACA191F462
	for <e@80x24.org>; Fri, 14 Jun 2019 04:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfFNETH (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 00:19:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43314 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfFNETH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 00:19:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so572916pfg.10
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 21:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uH3TjF1oi0abyzyObNjJgRNQIbOnaLfEIcMuHplJa/s=;
        b=WKolhLPup2k+6NSJ9LAiUwJOzOKvMnDhjb9KSrYUg61kEyT0f4d4T6OWouIzj/GnoV
         1NXqrjyKaJk57P9HwGK8sGdonxLGgk8SUXEJU18zXp+ED0kHBFJFU3UNJe0F8lKbBiPx
         nhW9F2fn2X45dznZWW3L6LbVrttDddSI4ME9rbLCpJ7IfB9kKEL3Mi+rfKb43VKVYR1e
         /bmu9bVyCEd/6YPQlRTEd4ofzzCFV36/O/ttY4Dlgh7/lyqGOBRrilgftzC9ggJ0n3Ch
         d0F604XiWf6psdp1RU+UKtgS48Zzp5crblNQ9f7Xa7jPSS8CzZNdBAxh9PBXYRZc3pTw
         bBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uH3TjF1oi0abyzyObNjJgRNQIbOnaLfEIcMuHplJa/s=;
        b=ojAF1IVMxy48XDmuc3trUpUrcsepk6TANpciy9TVZPiuP+LUw+NBO5ae6gwd3uMc+I
         ym4wCILJsIDhJqeoYFkXYzpGaI+Z+IltaFWEkUYlQWQvlhbuRcpSJSt0StZ9a12Hltau
         7JCmSplcxg4RyYeuSsmE4Rgzuj61MpVJN6vu9PueYAplcsGdqVBY1sldDr3N2bm+y4Ws
         0IWOjg7/GtOcQcgl03Hi0azgmSPniK5RWUzYmnFDmTWLK1KWCNoAgTUfXJlhwrxYqRIi
         Kv/Z1QwMuYvXjXEAMt12QKLA14rBLpfwJcUOmjIQVIcZQ6vZlXKTI9c126p5InQm60GC
         S4Tw==
X-Gm-Message-State: APjAAAX0IkwahioSVA+fC8PGIErLNF+biHqbiPjD3b0KKaORtP3XNVRK
        D1k6H48rXyf/sU6W3YZeAk2hJSGOjCZH6F3A1Ok=
X-Google-Smtp-Source: APXvYqys6qfvB4cQnIsXlGh5FaVVJO9yLGCMI/euAzRIJUVWtLLntzJV2DdOmTxS0A76b2s1Gigdodi8NMaNG+zcoyk=
X-Received: by 2002:a62:5587:: with SMTP id j129mr96168379pfb.45.1560485946779;
 Thu, 13 Jun 2019 21:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <f0059613-d3e4-a1e2-2c01-727579e069d2@web.de> <CAN0heSriaQV7zd4h8gfazi0dY_Dc5qLBWfJBtZGxOtm1+cgZqw@mail.gmail.com>
 <1473675e-4d27-8221-0e7a-f88eb31ee11f@web.de>
In-Reply-To: <1473675e-4d27-8221-0e7a-f88eb31ee11f@web.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 14 Jun 2019 06:18:55 +0200
Message-ID: <CAN0heSrEK80XHFYYuXhb4rg76Xv6n7-p-oUdyLH39vpAfjkxZg@mail.gmail.com>
Subject: Re: [PATCH] cleanup: fix possible overflow errors in binary search,
 part 2
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 13 Jun 2019 at 23:33, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 13.06.19 um 21:42 schrieb Martin =C3=85gren:
> > On Thu, 13 Jun 2019 at 19:54, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:

> >> Make sure the intermediate value stays within the boundaries instead,
> >> like this:
> >>
> >>         mid =3D first + ((last - first) >> 1);
> >>
> >> The loop condition of the binary search makes sure that 'last' is
> >> always greater than 'first', so this is safe as long as 'first' is
> >> not negative.  And that can be verified easily using the pre-context
> >> of each change, except for name-hash.c, so add an assertion to that
> >> effect there.

> > So all is well. But maybe we should write `(last - first) / 2` anyway.
> > We could then drop the extra parenthesis, and we would keep future
> > readers (and static analysis?) from wondering whether we might ever be
> > shifting a signed value with the sign bit set. A few spots fewer to
> > audit in the future...
>
> Yes, thought about that.  When I saw Clang 8 emitting extra opcodes for
> handling the sign for the version with division I decided to restrict
> the patch to just do overflow prevention and leave the right shifts in
> place..

Ah, ok, I should have known you were on top of it. I guess that means
that clang isn't able to figure out we're guaranteed to be working with
non-negative numbers. Which I guess means that it can't be sure the
shift is safe, but with undefined behavior it has the leeway it needs,
so...

Martin
