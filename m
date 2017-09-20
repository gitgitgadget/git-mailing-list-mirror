Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51CA020A28
	for <e@80x24.org>; Wed, 20 Sep 2017 12:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbdITMGx (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 08:06:53 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38408 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbdITMGw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 08:06:52 -0400
Received: by mail-it0-f67.google.com with SMTP id 85so1324004ith.5
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 05:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OGKqKb45kZScwIcZ0CZPpPJ/SprG7+XZ4Hdaf/09urI=;
        b=jaRBfFnBG+PRrPYv6nRaSHv65T7qpgFyO5ZUIKnPO48eF95pzWugh85lCEJKdJvT3F
         Vh4wQdFlckuNsmZ5tshvBPOr8Hp3fBqvaAco1znJmM97MFwxauTjXVSr1NO34pGCxzkA
         rGcnaEZdLJHmelAPdAr6g0Nc9LFiBPrriGRgvk2JXweP7wnGiCl9LAkOZ3NlgCxcbtgc
         ldJCzLsb08kUaUCJlwdZysk2XvCrnjzgYVWdtY8TnBvp9EoEVE0eiFN9eL8fXZXDf2v0
         hbgQ1iDwG8xkR6NuzaqPxiSIZ32uppa8lOPg9aFpoVh0W4GIK0MfNTgsecrBSmvjtGYJ
         CtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OGKqKb45kZScwIcZ0CZPpPJ/SprG7+XZ4Hdaf/09urI=;
        b=sBUclGPPr2WQhi4pMbJK5j7MHwgHuS5tAkxXoHvwmShAikvdR5lE5tD9aeLf8eWf5i
         Bp76XCwWL8KJouDoJEi7Ck70PXRFq9JMt3j6vXVhRF7TUZWPchKgQShDbg+yxxNdTSSF
         t7M1ZYVBl85MI85XesZW+mA+LGWhdZDEDzzFVhd+YYIZzU06Qz85i/1KDUdc2GJVL0wX
         YvQVaBD2BHo7Y59uXbD6l9ZUGfCaaoi/mCOwf9YMfwtseRvNrApv/cRyDs4mGdnF9tNp
         pRNERzAHvThCGPpk4DoVwQVUxa+FCMFGlNM20rcAAFD1dXy+jXMbja74zI8kvXw4+7Ni
         8zSQ==
X-Gm-Message-State: AHPjjUgGiBDGqHrmg5gSSNCsJAxqL8Ud3LDNmxqFUTnwxwdcKRyffI4H
        BJJKJFVQfqv3LkSxLeaoXWCx65yzyK2bf3ZoB5Xbcg==
X-Google-Smtp-Source: AOwi7QAdeoGJzZ4Ghsf1D3MsgDbQ5Jf74NEerPhqucOwz43y+gaihB3aZ7q3bk4Wrp0xIvnAyI9FW8Iiq9z6ee532GM=
X-Received: by 10.36.5.84 with SMTP id 81mr2525110itl.96.1505909211393; Wed,
 20 Sep 2017 05:06:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Wed, 20 Sep 2017 05:06:49 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 20 Sep 2017 14:06:49 +0200
Message-ID: <CAP8UFD3Rs47HMcw4=tr5DFnKAS3TtpceAffSWNfjTzoHe-DFwg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 31
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 31st edition of Git Rev News is now published:

  https://git.github.io/rev_news/2017/09/20/edition-31/

Thanks a lot to all the contributors and helpers!

Enjoy,
Christian, Thomas, Jakub and Markus.
