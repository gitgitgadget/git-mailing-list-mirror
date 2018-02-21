Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C02731F404
	for <e@80x24.org>; Wed, 21 Feb 2018 12:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754059AbeBUMWt (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 07:22:49 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:50284 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752350AbeBUMWs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 07:22:48 -0500
Received: by mail-it0-f43.google.com with SMTP id a75so2015282itd.0
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 04:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=v6SoxexJeiDSPoDc+TJN997lJE3GyOL6UoHTi+gMJeo=;
        b=prqo4cWgnKwI6grrdzdIl2PCUpho5HdbnFSk6sfSd+XGNK06JAUafsx/AQ8sjoIGXB
         8NNyYrswjZccqfr8qWEy3/ik+LtS2vEgJySggdxVsyTrArffXuN3cEQULo0qtydPB3AT
         i8MUsT2pwewd5WhmyDFzZ+r+BrMjrkUN9xhYFfG16OTcAX0tADlhGhLprr4CEwk0jW22
         g6g4XqCZgfJZsO/6FidVAH6B+IziioSQGB/WD09/hJQjbE/eTB+qCiKPBbUbzuvYEBfn
         DzN7YI+AWq0VGjFAyWJjE7UK/F3K7aFwb4phe6w90uCPfR5bRdAvVTBHku3oR53fFoBb
         71GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=v6SoxexJeiDSPoDc+TJN997lJE3GyOL6UoHTi+gMJeo=;
        b=aWdyrDXLsatAojPOMemzR4+XQaPkq8L8Ye1Et9okgdeesP5LNQM1WmHBrnre5bCIV7
         wnpEegtOOgd89YSc7s9z8wHx4xYjasBL16/qsmJg3z1zKkUJF4UstPi5vQFEI8te+AY/
         J2hABCTy/V1/LD3iP9jxakyv2EmGKbjgeOUrWQbrvQ/Y8u1/aNyvfTLMG4BY1J4BlM8t
         G/fpX7F8S8MqwXcvElzFWS2Eo9EiTLjuOuopxAmDyDRNRGknNrRVlnLsv/MVfwyFr0qB
         DLFolk0cMvAl9QS956mAcy4EbD+yB2aNQCQGrMvzoLOzE3nda3zWTCukW4txTdqBx1gw
         //DQ==
X-Gm-Message-State: APf1xPA8XAI4vbD+ofbAAbYmCgE99uCmARjJjM3iYdTkTzfYtnFX9Kuc
        NwBQvJ9xOcxnIv33jMQfaNymRAZEaJldfKACliQsrvyT
X-Google-Smtp-Source: AH8x227vGeybD++PFiJp3nZ5juvKD7EaqxNyoEsrK/P5bmLDDM6/D4Kz9xzG5bbGwNi1bMnhXjJX7rVyB6xoxswoUZ0=
X-Received: by 10.36.88.213 with SMTP id f204mr2908569itb.81.1519215767115;
 Wed, 21 Feb 2018 04:22:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.206.20 with HTTP; Wed, 21 Feb 2018 04:22:46 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 21 Feb 2018 13:22:46 +0100
Message-ID: <CAP8UFD2TZ5v4DMEy4SA1s859a+baDfKRATxi1gVh7STWPbPsNw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 36
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, lwn@lwn.net,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ed Thomson <ethomson@edwardthomson.com>,
        Chris DiBona <chris@dibona.com>,
        Luca Milanesio <luca.milanesio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 36th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2018/02/21/edition-36/

Thanks a lot to all the contributors!

Enjoy,
Christian, Jakub, Markus and Gabriel.
