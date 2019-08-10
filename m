Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,SUBJ_ALL_CAPS shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28091F731
	for <e@80x24.org>; Sat, 10 Aug 2019 08:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbfHJImr (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 04:42:47 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43903 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfHJImr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 04:42:47 -0400
Received: by mail-ot1-f66.google.com with SMTP id j11so41361440otp.10
        for <git@vger.kernel.org>; Sat, 10 Aug 2019 01:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H+uhaKr3tdg+/xRZLAFccCMZQUH6pKFA/dBs7Iu9r+s=;
        b=vPI7qR6yZgKuCdZuFeXngziIa6qxCzvddR1dLWHgMAUY0fX1Ke8z96/i5kKcyFdA38
         PKPtkla3mgb64gHwAn6jdpoMGRqoYdRy1MbnjCoC9DjOmXK5BiTalAip826/cbIJ6fNl
         lWW4Da1ll0Y7jIxnLnRePHGXMYgFeM9936KlPclhne3LvtsOb9B7gRlOyMzOKUbsV+rc
         dFdFAxUE61Ycz1cKgnWnzkEzohEKpNcog8r2jkrsuXDA4Nq0rA0UuE89i3fjoqIbwaMu
         0QBThNzT6v2ClJg4Jj+N7y3WlDhzvy8mMR0e19Hf3V1VycFa8CGX7PzRB5SB4h4sWtPR
         FD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H+uhaKr3tdg+/xRZLAFccCMZQUH6pKFA/dBs7Iu9r+s=;
        b=kCrN98LjQtNHPYJFxLtkarz/qxPysqURJsdlWvuVU+CrvVDuaj8nbE/wwunX0lASXT
         tjvCJug/jK0nShZoKiSTybxMiHnVdDyYtS/e0jdHO26g7OjvHOBYoYW3G0YQ2d9ZKcEU
         TokQ++57Qyr4WmDsXRhrBGTCnUv9FS9qNfl1sgGxwvNJFZuQB7jsCRu8TmnH3pJREgq0
         JaUMoPUnCBvi/Bi13PxjmYpssuHnzeCN+HueU66EgrTD0+FtbiwZMn7Cd3I7ApJq/YoJ
         wiJUitDKwQDSQejZdQSwYU2M1HU0vg+FNP+4zJF7fkBvyu52XHbav9diCamSCrbHlJ59
         JsIQ==
X-Gm-Message-State: APjAAAWi5FeNVaUTAE5rvWzVXIo1VA5H9J2dSlWQx/evtOLLdeapwvFg
        JtYGU/AFhikbHG7Lne+O7SBQnc7jr8F/PMPYcww=
X-Google-Smtp-Source: APXvYqx4quEbo5mau3KJnNH0Op8CieCrKgKARUK+6A1cArgScwn26r6E+wTRMW+hCYQShzbm6CUZzXjTfH6fFIWqCWE=
X-Received: by 2002:a05:6602:2413:: with SMTP id s19mr25402530ioa.161.1565426566361;
 Sat, 10 Aug 2019 01:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.1908092325480.46@tvgsbejvaqbjf.bet>
 <20190810030315.7519-1-carenas@gmail.com> <f78b57a6-9ede-c87c-fc42-292851d79fad@web.de>
In-Reply-To: <f78b57a6-9ede-c87c-fc42-292851d79fad@web.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 10 Aug 2019 01:42:33 -0700
Message-ID: <CAPUEspjtZhhynEmJu_weROaao=1zL+De1h50R-grG36ok+EAyw@mail.gmail.com>
Subject: Re: [PATCH] SQUASH
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     johannes.schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, michal.kiedrowicz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 10, 2019 at 12:57 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 10.08.19 um 05:03 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
> > Make using a general context (that is only needed with NED) to depend
> > on NED being selected at compile time.
>
> A custom general context is needed to convince PCRE2 to use xmalloc()
> instead of mallo().  That is independent of the choice of allocator.
> So this change would be a step backwards?

My bad, you are correct.

Do you mind then if I "adopt" your patch and submit a reroll with it,
will also add an "equivalent" one to fix PCRE1 as well then, and we
will tackle any performance deficiencies or other issues in a future
series.

Carlo
