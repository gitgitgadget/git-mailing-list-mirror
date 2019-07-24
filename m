Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 286D91F462
	for <e@80x24.org>; Wed, 24 Jul 2019 15:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfGXPz6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 11:55:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42485 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfGXPz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 11:55:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id v15so47590372eds.9
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 08:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=YbfxFfq7Hm9b4KvDQgiBLyTlgVUEeyTnKfdAu/62dLI=;
        b=jqP4U3reUBUXPlGLdKldt4UuJbGLlBZDzzBAJ5Hj8DFuX4PBSoz+d011DJ5qYDwvAC
         kj390U4tQ1Vx2+nQz5U3+dHPVqQMTUSj2dpupC1tZA1ztKiwClvkOTemLO8MLlYgW2iO
         KPm3jbW9L/wch1xgK5hSBT0ND41Jg+wcFN0lELD1/bB7nr5G4UOqO6xaFfoUnPje/3tb
         kkhCH9LOd3vJEOVo5RPkeMeZnwCZ2XIjHJvjcrk8BM6iWsZStFtEgYmUsRFzodfmsoZH
         gSk5l4co4iijH0a8EcIrsVwIyhNAYwzZw2UG8joMuO5eiNK8fpp2na/BjZdDQ2E6KIzp
         cfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=YbfxFfq7Hm9b4KvDQgiBLyTlgVUEeyTnKfdAu/62dLI=;
        b=Sv9WqI3EyGOH7/VVzFdw0yH8lr/Pjj+DFy/LRUazbaHFod3v2IhvD/RK2jcF4gl0ep
         JFeTn/+6F2wNY2D+wkQwPMvaLa0725+m9X+RuPvIJwXskgKkimyTZFxfafRTAehCPhNQ
         N/g22jkg7vDJH0BbAkx9B6rwLU15cMIJK3VuzbVekHP2gkefK43gLlvAV2btItfgV1qG
         pwzH9C+d7p7H+ImkIwWbd0AlYZ+CV9+BJkebOlJ5LhvBOHy4aeCaQLGcdfZWtmWyX8kR
         WOfWCZvICbanBnDKFxg26/JupFIPx6+K2cZ9NYZSYelF9XdX7ef/Ss2oTHXi9Zmdp1B4
         Zcrg==
X-Gm-Message-State: APjAAAVnvKWBxfMPdjWHKhy245hs7gaTlaNMLsJomiAOoa+TE5UdaIYp
        EnWKXgjE0cBbXJ2UEQ2lkR8WtSvHAxi8mM35w8a2vBv8MRw=
X-Google-Smtp-Source: APXvYqwVnBTvFbuqouHZrSPWhwjlmIxNaqdJMioMA+bktyHNsWeaITiqa5nflBjun3DUHw1PTYFCcLqTmBrfV39iQc0=
X-Received: by 2002:aa7:d6d3:: with SMTP id x19mr71641123edr.119.1563983755571;
 Wed, 24 Jul 2019 08:55:55 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 24 Jul 2019 17:55:44 +0200
Message-ID: <CAP8UFD0et8CNHXmmdyJp2mTA5OegduT2Am234SzG06o_X+4QGg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 53
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        jaime.rivas@synergy.page,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 53rd edition of Git Rev News is now published:

  https://git.github.io/rev_news/2019/07/24/edition-53/

Thanks a lot to Jaime Rivas and Carlo Marcelo Arenas Bel=C3=B3n who
contributed this month!

Enjoy,
Christian, Jakub, Markus and Gabriel.
