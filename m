Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8A7A1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 15:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeDCP3z (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 11:29:55 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:32772 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbeDCP3y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 11:29:54 -0400
Received: by mail-ot0-f196.google.com with SMTP id 23-v6so19841459otj.0
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LXi6rGyLG76uUqnwkvMzQ7yqWgJ6oW/ad+Vw6MUrSFI=;
        b=bt716hwD+Djo5HSfA2co2xwIERmSyB55JnRWBa8Q3JCHxLSQysfemSHakjQhJGcWlx
         D3PZygi579QnF5jtIj6sy6E4EM8NTqH9HuvK2WtM9TJphPm88ABD8aoXAGHLOG1hGOq3
         Unww0omgj1IvwnsgtZbG9ZVlkPOlvjAllxDFXqAsdCte+I2pMVZJgD3+VbXHj+2jOCTx
         c4pNlMm49eZlnOBYyCTsQnbeYbzdtIGNuNeeDz81W6IZHy6/4leTF1OfBPnSjyJPkq6d
         1e1HWlZAOFNuz34EOpmyUcyj36byj+pggtl/4PnbcYzzfDoc5JZLCUmyZVU+n7FM08CD
         afVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LXi6rGyLG76uUqnwkvMzQ7yqWgJ6oW/ad+Vw6MUrSFI=;
        b=rb1a9BdsNeF3PFxIkYz8d9IpiUAupb532hHis9TyqGCxfKzY+Rvp0g1dSlplVDJ9yk
         AyDH0GLL6F1L2U1hezAfsgzvyZrWVFHKi8V9R8c/0hZx8GSnlBN3wo4zbF/RWVW/J3/Y
         oMG/bxxATOiLEQYYuK8RfgoOcprgdZGdxrLLlRKacFAkd9WRKvHj8BcRZXS98L8ljETt
         wUL+CKYv5Suq0bN/sfw75cQ17iy5WK1fjz22rG7q5EOfgk4WTSHBKCROpBUVzTYDogWx
         Kfr8e7nn0a2GfEJkVOoVjLP1Q33TZWEBU5yHbxfbd7g/FovJPAMd2VyJ/MBdkgSHS2Xw
         NGCA==
X-Gm-Message-State: ALQs6tADXbxECVUuhM0yxoASujIvzwjdzmpUvtGIed+lEEA69jVliOmq
        uELgdWLzb6XnA2rkdPaKE9ms9GSO7T9Wb3xObt4=
X-Google-Smtp-Source: AIpwx4983RzCPWIjJxZAezhOMDLxITOwRSneQBk1Hc0EOnIc6HBjrSKrEfHWdEHFReP+960+OrVvx9/H74knlqpaJPk=
X-Received: by 2002:a9d:24c7:: with SMTP id z65-v6mr8901815ota.152.1522769393947;
 Tue, 03 Apr 2018 08:29:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Tue, 3 Apr 2018 08:29:23 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804031127400.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de>
 <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com>
 <20180329194159.GB2939@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet>
 <87in9dwsxl.fsf@evledraar.gmail.com> <xmqqefk14jlb.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1803302042570.5026@qfpub.tvgsbejvaqbjf.bet>
 <xmqqfu4h2xsl.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1804031127400.5026@qfpub.tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 3 Apr 2018 17:29:23 +0200
Message-ID: <CACsJy8Bt3AEZmjudL+scXqOC_oW1WtU0_QZVD9PM+drGbEBeVw@mail.gmail.com>
Subject: Re: [PATCH 1/9] git_config_set: fix off-by-two
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 3, 2018 at 11:31 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> It is very frustrating to spend that much time with only little gains here
> and there (and BusyBox-w32 is simply not robust enough yet, apart from
> also not showing a significant improvement in performance).

You still use busybox-w32? It's amazing that people still use it after
the linux subsystem comes. busybox has a lot of commands built in
(i.e. no new processes) and unless rmyorston did something more, the
"fork" in ash shell should be as cheap as it could be: it simply
serializes data and sends to the new process.

If performance does not improve, I guess the process creation cost
dominates. There's not much we could do except moving away from the
zillion processes test framework: either something C-based or another
scripting language (ok I don't want to bring this up again)
-- 
Duy
