Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B048F1F453
	for <e@80x24.org>; Mon, 11 Feb 2019 07:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfBKHsl (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 02:48:41 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45300 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKHsl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 02:48:41 -0500
Received: by mail-qk1-f193.google.com with SMTP id y78so5844027qka.12
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 23:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H8vyWm5EWdexVZrgqGSwMErSVC+bRWmYJeT6Ov7yd1I=;
        b=E7vFkGz/sMidchrHvEhpdh3F30VuZAUoow7IZzfG6SnCc2aaBbusDSwLhydHMWIlkP
         ypk/Z5LvDuTqQmYL1PBp80AI1W2qABgfOE4lpXYxXecV5NzJfJ3zppEWinuRXPPH5vcr
         GjHN1sFIoXQncM57Em46bnsoHQ7lh9uUA1smevof3AfSGiK6AEZGCTWDEKjxlPtrnBAH
         6lgYb/0V0hl9LyFB3kp4I4Fz3RXvaEUSNy8LTCRx/DvEuDLjjAbWsaITgbBN9ppBPKBe
         vQhjbXYuWIlIfOhiXfsqHB3o83jQZsE6jdhjVOlKBzbsE1EuIbsOhqvW+/1LiFXmUxio
         BrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H8vyWm5EWdexVZrgqGSwMErSVC+bRWmYJeT6Ov7yd1I=;
        b=jp2g0gqHAoh2zG3Y/uh/O6ZEwOjc76VyKp2KI4/EV1yOJFqZ/xBWmXkQZeKvtAJYZ/
         eJTcVT2gLwye7BUpqtWQKhJIb3UrcDYDgHBTk2HwSUeWa6PRJTHGTKYzXGCJmOzLc45/
         QCNXdHt/COT+E1pkJ+vY1OihYPR3v9IF3mPRX0Dk7+ciL+S8NO/jEazEOBS8nRE1MQGR
         1nKMQVbglzIEVbFcc75aajcLfOJQqMSwKbESEyPog8bagH2m5pdJmNyPo06POOj70XYx
         pVIWMccCIPjpkZiN0GBrIFfbPQng+5X7qjwkamcQ07mxGjYb/lPigyMoF9uYtTqTKXOR
         illQ==
X-Gm-Message-State: AHQUAubPL83Dtws8qUsAfHLsbae2k5Cs3YbDlpxlvOygroasFU8jLVTI
        4lfl/TegYKgi+aXjrQi4PX6UviI7PA0SuGAjbUo=
X-Google-Smtp-Source: AHgI3IZdqRQgVLhIQ1WXB2Y+Ltl6xXatoN1uSbTemBOV09ZQg4pkOT14L+LTy7FLH0ASXT/9EwjB81+/gnjwwnc32kw=
X-Received: by 2002:ae9:e211:: with SMTP id c17mr21901718qkc.290.1549871319783;
 Sun, 10 Feb 2019 23:48:39 -0800 (PST)
MIME-Version: 1.0
References: <20190211030639.18761-1-worldhello.net@gmail.com> <CAPig+cSB3Z=tqfN+Homjc-DYCnbNPuY-v=FJRZqrLPR+v8YwWw@mail.gmail.com>
In-Reply-To: <CAPig+cSB3Z=tqfN+Homjc-DYCnbNPuY-v=FJRZqrLPR+v8YwWw@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 11 Feb 2019 15:48:28 +0800
Message-ID: <CANYiYbGf6Oj0k3-K+s0DSO-bZZ2EXcVcoyxoJtqSbbmHEtg_bQ@mail.gmail.com>
Subject: Re: [PATCH] Fix typo: "git bisectreset" -> "git bisect reset"
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> =E4=BA=8E2019=E5=B9=B42=E6=9C=8811=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8811:47=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Sun, Feb 10, 2019 at 10:07 PM Jiang Xin <worldhello.net@gmail.com> wro=
te:
> > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> > @@ -173,7 +173,7 @@ static int bisect_reset(const char *commit)
> >                         return error(_("could not check out original"
> >                                        " HEAD '%s'. Try 'git bisect"
> > -                                      "reset <commit>'."), branch.buf)=
;
> > +                                      " reset <commit>'."), branch.buf=
);
> >                 }
>
> This duplicates a change made by [1], although that patch was
> withdrawn (temporarily).
>
> [1]: http://public-inbox.org/git/20190209213044.29539-1-jn.avila@free.fr/

Thank you for reminding.  Please use Jean-No=C3=ABl's patch v2 (forgot add
v2 suffix?).
