Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 882931F453
	for <e@80x24.org>; Mon, 22 Oct 2018 14:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeJVXBq (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 19:01:46 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53447 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbeJVXBq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 19:01:46 -0400
Received: by mail-it1-f194.google.com with SMTP id q70-v6so12103491itb.3
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SP/2nVOFzKYDlOQd6UNkp9YNfCmDFjPs9ib7KJxJwb8=;
        b=D+kJTIq/O/UlgQT0AWRapIz5XJ2vCxPNBk25NrQzeqa7oIVMuO9R/uZyoj0XIEeFGF
         044kwSD2kLKiKjmURFyxnZ7LDsY0wbU2RP7zxeDSajP5JvgLe1saM+wj3BjWzag7iS9o
         LcIrCHRRGclNwJAvOtdrTHncY8gfTTn4+1yxzVqClkzyID/4dmuMEBJfcFfsZ6RRZu2M
         ucaCNsC1Ozdo2+fSwTmOUdLeqyKesyi0LFyRnFye5m+pR5MAKy+TI4wFdHrU2mJHefDk
         mGGepw4Oy3zK0+n7J+M+E9sPl5qLV4DqirQzvSiLUkSK21vSyZkBJseWkk/XPJaxMuqv
         H8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SP/2nVOFzKYDlOQd6UNkp9YNfCmDFjPs9ib7KJxJwb8=;
        b=IutxcpfryNJfbXTRNOQCDIvWqtBHLTXe+iupxiEIBSBicGOenc9vrVIsofS2nk3+WL
         S7ICPtkKbYWnPF/49z1g7JY+r1a7XpUgTrSgrIM4DkIz5fKw6nxBBC5QtYN4H+LWph9t
         lDiSBgRiNwlJlG433LULN7xLmz6A+anK35Ukui6QenukOU0YbTSk0IqnY7gTpYbKddTr
         dOnmDr5PtoBkrOSK4+jxNwyTL5PSr9Duwlu23htXbrosUeIC/w6Ogm7y3c096UnPt9bw
         Muhb6SARAEPTGDL/hvbh7czsDfmasUZ94uRY31uQlKXD23lJxY+DdRomc+SOnIpT0/7t
         5MbQ==
X-Gm-Message-State: ABuFfogFs+5biHY/gxefXUYYQn1ca8z9+LumNoRPr/ztrLyWvbu/+mxF
        lfjTmasWwjp02AITOqyiseI524H96eJnwwJHtOXlFRkL
X-Google-Smtp-Source: ACcGV62cYSUuz4w/hNo0lGFOAINJ4hdTaVUenK4N2aVCk7DffoI+Fj1U4wzA28CLUQlIV5GVdQQYMfvG5mPnKy8UYo8=
X-Received: by 2002:a02:5748:: with SMTP id u69-v6mr2931445jaa.30.1540219374860;
 Mon, 22 Oct 2018 07:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181020123848.2785-1-pclouds@gmail.com> <87d0s4ctds.fsf@evledraar.gmail.com>
 <xmqqr2gkyz6f.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2gkyz6f.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 22 Oct 2018 16:42:28 +0200
Message-ID: <CACsJy8C+Kv9Exm8vdGRC3c0BoCii+oBSB-o-Ujhnxvw3PajphA@mail.gmail.com>
Subject: Re: [PATCH 00/59] Split config.txt
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 21, 2018 at 1:29 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > I had a slight bias against this when you started this, since I'm one o=
f
> > these odd people who don't mind ~20k line files if the line count isn't
> > contributing to inherent complexity, e.g. in the case of config.txt you
> > could just use the search function all in one file.
>
> After typing "less Documentation/config.txt" and realizing that I
> have to open another file (which one?) to find how we described the
> push.default config, I am already experiencing a lot stronger bias
> against this.
>
> But I know it will pass.  Once this ~60 patch series completes, my
> irritation would peak, because at that point I would not be able to
> even do "git grep push.config Documentation/config*", but I would no
> longer be reaching for "less Documentation/config.txt" anymore at
> that point.  Once Documentation/$group-config.txt (which I think is
> a mistake) are renamed to Documentation/$something/$group.txt,

I'll wait for js/mingw-http-ssl to land, move http.* out then rename
them all to Documentation/config/$group.txt then. I'll fix up makefile
dependencies then too.

> then
> I know I can do "less Doc<TAB>/$some<TAB>/$gro<TAB>" to get my ease
> of use back.  There will still be an annoyance caused by having to
> open another file when reading description of branch.<name>.merge in
> branch-config.txt and seeing a reference to push.default, though.
>
> And the end result makes it impossible to place a description of a
> new variable in a wrong section.  It still is possible to mistakenly
> insert a variable in a wrong place in the right section that
> requires a fix like 8578037b ("config.txt: reorder blame stuff to
> keep config keys sorted", 2018-08-04), but we do not fix all the
> problems under the sky in one series ;-).
>
> So after saying all of the above, I am moderately supportive of this
> series.
--=20
Duy
