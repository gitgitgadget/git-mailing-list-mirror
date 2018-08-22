Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6EB21F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeHVT6H (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:58:07 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:40740 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeHVT6H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:58:07 -0400
Received: by mail-io0-f179.google.com with SMTP id l14-v6so1915597iob.7
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=+vbwe+w9SqYp2AM4Wz2BDubJdJZIn+FsmD3AGqzQ9cU=;
        b=VRFkr5lV36DzOuj9mldkA3YT8Y+kVmJmLoT24y47Ck5bKK69nfVK/UNdtMcGfQjytu
         CKUHlNhS1wgjA43AJk7bufkustVmxc/vVxs5+XoBKOBq1yBgCeIg8wo2IdphIp41AlDk
         SeHtVHoQSi4rMf4inUjkFYuraOycLlA6ohxb6OnQ16OMJsmQ7c4uECnmXrbUxw9DRtd6
         /rxSsw5SnXY5+N5imBG0pWW/uH7h0OOzplPJnlxEUjE4i12PPC/09rEA3f7GZ91WP5yN
         nZj9Pfwio/XStyL8Ow9S0/M1S/6/V9HVAI0+v8AsKa4P43W8Y9D2FmHR4IQBUTnG37Cs
         fkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=+vbwe+w9SqYp2AM4Wz2BDubJdJZIn+FsmD3AGqzQ9cU=;
        b=NNWE5KYo77zsKf7oOlw/iG66jJsMOmCm5cwu4gnyR02HefSMjkMJ5n9xCduUrbk8OL
         AycvH0ci1LcAJjpteOi/An5HKRXLwyhQwWTtoKJ/y4cfVyPm8OzkIeoS06t2p0I5FWDK
         cowWmrTUgPh8QW68IIFioBBgjgGdXi+SDUVIiSaaTiMQV5eqsT7lNqkMl/Jp5UB3RA3E
         //7O1RMnKq3VlCS8Y5J246JqEdbo4BeSfrf0ST6GXSDpkRsabcy7NVb5bzlhMR5Gh4MU
         sFRY6hCxX2ZSQD0NEsKpm0XOvWu91LU7swGmYpeB2nS2nh86qn7sVZL8DLoSpoFcWvA9
         61Vg==
X-Gm-Message-State: APzg51CfWhMdYTxc6wQVm5jXPpjB3zRDqK8GVFj+6zhkU8gSStJ1TuKC
        neCc2XmuO7ZV4nqGh/KV0jilu//DalK0rF1pmdF1JuzY
X-Google-Smtp-Source: ANB0VdZhh5Jmvpojskz97iXff6x/CjlEXYrZwHBBC9UIDM4kW+slTNKuQSY8SlIlA0phvDYfqoDfMJe5Caucd4IcCXw=
X-Received: by 2002:a6b:500e:: with SMTP id e14-v6mr12934244iob.5.1534955552280;
 Wed, 22 Aug 2018 09:32:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22d3:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 09:32:31
 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 22 Aug 2018 18:32:31 +0200
Message-ID: <CAP8UFD0V8JcaWAP5dGELjgf9FwKuGn0-_9JhnTyAHGczrixTvw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 42
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, lwn@lwn.net,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avar@booking.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Simon Ruderich <simon@ruderich.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 42nd edition of Git Rev News is now published:

  https://git.github.io/rev_news/2018/08/22/edition-42/

Thanks a lot to the contributors: Derrick Stolee and =C3=86var Arnfj=C3=B6r=
=C3=B0 Bjarmason!

Enjoy,
Christian, Jakub, Markus and Gabriel.
