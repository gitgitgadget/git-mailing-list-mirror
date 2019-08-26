Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 676141F461
	for <e@80x24.org>; Mon, 26 Aug 2019 14:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731922AbfHZOnJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 10:43:09 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38785 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731833AbfHZOnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 10:43:09 -0400
Received: by mail-io1-f68.google.com with SMTP id p12so37921937iog.5
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 07:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sJxBmi5C9aAIjsogmoLajwCfdn+lXckoObKAo9pY1PU=;
        b=MdeaMS2yOXjseWtSuOj0fet/cJovaNDoUq/uBncBX7CblPTHmGmr+Y7paPdtqeM0ti
         cuKBoo1bMribsZQ4gv89qG0Wqm+EQu/zxHw+AynTJYUmKD8HqFj1mfzlqOrLAEU6/R4c
         OjuvB+vbJuSEfYxbVpt9BUJxZKMd85cTu/5/7UbqkGBjN1N6p43IqAK3l7cptldba5xt
         nOuesnPxepl5RpQY4AUXYENzbNeMbrCGMzPCwZuRDMtflhOS90zXHJ8X/bEfUysvhTBI
         MnUYFh02Lug3UO5R0T60ofvJcrEi8Cn6mN4cjn5PGdqlc1unkbatC2va/t38S7zPaaL7
         vAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sJxBmi5C9aAIjsogmoLajwCfdn+lXckoObKAo9pY1PU=;
        b=ojc4MzLelQkHS3IEpN1LQGSFMhMLfxCLSAOvUJsLnciT6RgHm5Z4s6CE9EhAxTxMLY
         BBfnAb1jgvXs4FJk20Nv4WSjWsVpiUHSXRZ03HqxM22TeocDXINtf3UDmvBMeisqNAYS
         6ILXRfKwpGOLvYyLbaAKwGc7QOmX4dPIF/IY3C1J9Hn1c2wf6h5s2MR9b3oUfMiPeaZM
         JYXPnKjoopPk3WJUZJOLxYjA5OzGbQxbcwkwOT0vTjBxuRy2+Ao5PyMWcGet+5ZaDuGL
         m6ful3SVfBNNNn6arole4IpRb6zrdbCp7UmZ0EuW+TWNO5/+Z49m+RiMfLdXd4R4d/uE
         WosQ==
X-Gm-Message-State: APjAAAURcXFS89I3y+7KE0MJ17xWDnVhaMu8zhHYjaJeooHOVAMGoL2q
        Q00i6b6p8/pHFSnhWOwO2fvXtYZoVltT6X9zqt8=
X-Google-Smtp-Source: APXvYqx/En0dCQmwDeLCbT0S5ljXmOOtWDcTxTOHJte29spkVhBMQ9qmihEDdNrjxw7u/tnDi/kYH/vBDb7uVgr0HLc=
X-Received: by 2002:a05:6638:c8:: with SMTP id w8mr18325362jao.52.1566830587863;
 Mon, 26 Aug 2019 07:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190818201727.31505-1-dev+git@drbeat.li> <xmqqk1b8x0ac.fsf@gitster-ct.c.googlers.com>
 <CAPUEspg9F7RutCUCoRAAXmRePjiunq3-zG7cN3uz_t5DVMxP=g@mail.gmail.com> <nycvar.QRO.7.76.6.1908261626450.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1908261626450.46@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 26 Aug 2019 07:42:56 -0700
Message-ID: <CAPUEspivEfc82ZM=VaUA_sYhQbz+GtoOODVZK2i9LcCkmHq=Sg@mail.gmail.com>
Subject: Re: [PATCH] grep: under --debug, show whether PCRE JIT is enabled
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 7:29 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Sat, 24 Aug 2019, Carlo Arenas wrote:
>
> > On Mon, Aug 19, 2019 at 3:23 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
> > >
> > > There may be others I am missing.
> >
> > should we still support PCRE1?
>
> While Git for Windows has no problem to just drop PCRE1 support,

FWIW I don't want to drop PCRE1 support, I was not advocating for it,
but in the contrary
trying to find a way to keep it working as best as possible until we
really can't.

> I would
> like to take a longer road in Git. Like, deprecate it first (I don't
> know how to do that effectively, though, as packagers usually ignore
> compile warnings, maybe we need to add a Makefile knob
> YES_I_WANT_TO_BUILD_WITH_PCRE1_INSTEAD_OF_PCRE2 and
> YES_I_WILL_STATE_MY_REASONS_ON_THE_GIT_MAILING_LIST or something like
> that).

FWIW e6c531b808 (Makefile: make USE_LIBPCRE=3DYesPlease mean v2, not v1,
2018-03-11)
put a "deprecattion" warning in the Makefile by =C3=86var, but last time
this was discussed[1] Junio
made an IMHO sound argument for why that should be removed instead but
ab/pcre-jit-fixes and UTF-8 validation are likely to make that more
difficult (even if it is a mostly self inflicted wound AFAIK)

Carlo

[1] https://public-inbox.org/git/xmqqlg4xkh28.fsf@gitster-ct.c.googlers.com=
/
