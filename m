Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF6081F453
	for <e@80x24.org>; Wed, 24 Oct 2018 10:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeJXS6i (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 14:58:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39463 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeJXS6i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 14:58:38 -0400
Received: by mail-qt1-f193.google.com with SMTP id g10-v6so5054066qtq.6
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 03:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wSnppQORdOOZ1sHC7N4B3PfJSgRddzRJC2SOnzH+AtM=;
        b=kFPkEW8FoItdzkgp/h3U6+owzj43oK09zxk88MuQfjRtRWHbPvf0EavFNjr0WbWoqf
         2kaCExx1YCq7I6hOJare33i40iuQ/j2WkJTwm97vVyJF3ruRq3jjmYq8py7EPXDtKfbi
         7BTVWA47BboboFe2yppX1Bktpoyhnpjm+K4RoCjAJycqimjKAmjprXgLQkri8zgHGamn
         ZA4LaF/GhaFqfNFaubuIRtGjeYTg+3t3MomJaGdDxtEuftp2NbEbJ3F09UW3Cg6+Qixi
         SlFUAvBlPXwTtwYYQJwaPLovMaViWaB6qLWtpmXEo/WbrUqXfaRiF16eqovy2eBjQzdr
         QtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wSnppQORdOOZ1sHC7N4B3PfJSgRddzRJC2SOnzH+AtM=;
        b=W8TRcUGzWG8hb24X0De61kHYNfpkJRJLGjl9CujS0P21SE3o9AJISZqe4aXP1hccjf
         Tl4zb/YA1CWG6wJlwJxMYei2W1rUuokqWq4m8E55vcI215HZNXsOEgZLZN3qfG1njHqw
         LAEerjiyanM25z9PAuB7ApjIP9zZBrzE809l8EQp/Flj4qcCXUMc32msgPVmthCpw2G3
         tqTWd6rs3l5Rmwv/UpDPkctfwaTOGL/j+ZMMeLGwlsXZjD54KkUgw/qMCfH+RyZZRMoK
         YP0rsRsr9cydeo0KFdBIN9zkKUFYEmwYKCDi+H3wdrxrpbq6AKPVa46UznyjVM7NfDi3
         QSEA==
X-Gm-Message-State: AGRZ1gLt2ZfshL8CqvZb6kUlG0uQzX+Q9dUZsJUSUJwQMwSXJBVWKXyI
        rLNLvidE9QUpspchqimIjQeG9RTpq38+aVx96SWbJI8b
X-Google-Smtp-Source: AJdET5dDlQ7TOsbcHChZzYRcNUyIjRoTJqLbGLfI6Nykqp0kDLJRUIJxpRZfDLg4SDNdz0HjBRLN6Ep66/WOx8vezZ0=
X-Received: by 2002:ac8:6754:: with SMTP id n20-v6mr1826232qtp.70.1540377065074;
 Wed, 24 Oct 2018 03:31:05 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 24 Oct 2018 12:30:53 +0200
Message-ID: <CAP8UFD1Ys+izT5ULuWy-BqMTdR+FVKq3mOB6f12ifO4hiR22EA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 44
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, lwn@lwn.net,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Luca Milanesio <luca.milanesio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 44th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2018/10/24/edition-44/

Enjoy,
Christian, Jakub, Markus and Gabriel.
