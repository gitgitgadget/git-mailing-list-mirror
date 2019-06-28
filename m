Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C931F461
	for <e@80x24.org>; Fri, 28 Jun 2019 12:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfF1MXU (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 08:23:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45657 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfF1MXM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 08:23:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id a14so10602029edv.12
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 05:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EDEZ7CJ9a5gOCaEKCSYA2CkHm2YrIFlhrhE8yrYn53I=;
        b=FOEZP2Ggt5pkaMVLlfdK4aSVYRMIt3nZDK9pisjwvO6S6GPK3iMVNHZI9NbkXjKCCl
         VqMJphMJK46WzVQFFgionXurb8SYaQUCLP7YHsoj2/VjAh9muA8qV9aSBr+mnCG7Exaz
         Rla94K+2g5G5IjBrHnP+m6MrPJrO4Z5JN0Tn8kDTa/P9Td+XiPMF5m5RpxT++SXf2hvy
         z77r90kRwLAuLOb+KcrXFqk3m2QbXTP6Qy5s8kaOYNEGOrgP79qKzQ+Wm1r4DCUYKmsz
         SThi9LIt2w0ibNh4igYnvy7zOfvQ1bUVwgPKYxY4d8R0+4rPmM2lqvvJtftWX/1G9Z6U
         WY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EDEZ7CJ9a5gOCaEKCSYA2CkHm2YrIFlhrhE8yrYn53I=;
        b=pp+wrHKG89cl5dt07y53C/B91uap+Bp5oZdtWCR6vMs74FbDkvs3VltIGYlexjMKpy
         x8t3K6n7KwWVH3OjKbWOFHnqE02kg4v/iXqJXukZKwtinVZHD9c2A2rARAm2mE+wyHAr
         SIrmauPjz6srQcNbMSwrMOYZdT7B18xA9Bk4uNxcZKh67zhW3auL+dPeK80on2lWSTbr
         Ib+EA9kn2MRdxcJtg7PlfHVflEFQDA8RSWTO62jszyeIbo0A2/ELBfEH3cAq8qQfN7Oc
         KGYLrkqIlAdALDguPkzHrhPMinkPPZg9z/bmN3JmhM6auW2Md7hvblFw9kZvVa4pv0ZT
         TYLQ==
X-Gm-Message-State: APjAAAWe5gcQ6EgTCpCz35esf6gIX09RmYVitYl2qKNVfeUHx393uJ4+
        IWbB0RyRG7kXAM3bfLLcFcXJGgYGyZit6bUMUu/bFnt/q6A=
X-Google-Smtp-Source: APXvYqyJnc/LW7cb3/jWyXZSReF5rpSSoGCjQzuBDAoh2rs/eZu8r9KuT5mi8OHf+NkZkYPTRyZczfVDk/f2T+S4jZQ=
X-Received: by 2002:a17:906:1914:: with SMTP id a20mr7999624eje.294.1561724590259;
 Fri, 28 Jun 2019 05:23:10 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 28 Jun 2019 14:22:58 +0200
Message-ID: <CAP8UFD3AbZAfdG92orA=dv6qQ74Qk3-yVKQ1gRunZnkcvwC75A@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 52
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
        Jeff Hostetler <git@jeffhostetler.com>,
        David Pursehouse <dpursehouse@collab.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 52nd edition of Git Rev News is now published:

  https://git.github.io/rev_news/2019/06/28/edition-52/

Thanks a lot to Jeff Hostetler, David Pursehouse and Johannes
Schindelin who contributed this month!

Enjoy,
Christian, Jakub, Markus and Gabriel.
