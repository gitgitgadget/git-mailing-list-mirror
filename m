Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DE1F20248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfCTL2K (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:28:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44340 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfCTL2J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:28:09 -0400
Received: by mail-ed1-f67.google.com with SMTP id x10so1615190edh.11
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IK2B29k6BhpUqqHzckfy+XDU31Vn1DarGa5SLZCAdpI=;
        b=soPRsAnpY4jTCUXv9VKf2kpSLJLIhglsuaYoHOYeUezerj0+Y9Z+KVsiQO7xYGmwiQ
         kOpv0qQW/KUa/l5Pvr6NbjpDbj3gB7OQ11bkaHenwb7yNm8nPTFr1aX2NPOK4juCbZMe
         S4sjVq+bizQSLPYcifFZqloAz+G+b/Q0FNvCTix2qodJ8kwrCXh7wW4wQUs6A9i8T05A
         Y0OvdmXgjMnfPZ0XzZv5J+FCHSUIJbxXh8hKnph79iak68ozLBEYVbWKKzwMgirlXh/c
         +bo8Y0v+Z2yoKpnVI7prBFTWBS4UxsB+6L2WnyunBhxQlN6LPmTTBMyx9ugQA09fajCz
         IN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IK2B29k6BhpUqqHzckfy+XDU31Vn1DarGa5SLZCAdpI=;
        b=EJ71KWY5VD1Dq9vGb0Yb4t9NN9G4BzBkEk4ANwpB7Vh78uhcYbQTk0pYiFmu5fqqt1
         nt4Kv7ovEhK3Em4Og3rSCsF2ZYv/0nWGrT1pcutkemvOAKv8ESes3oNYxq1uvINdAjVw
         c+EjevdNx7/i/E7yZm+kADYxMcpg4iE6PjzV66iYpFj1zbPJ1oW0kidSH6l2DCZEWzWU
         tc0rrY2E1cObRkLnrnLA1CLE6kkC9hiM0uAvUe/VF1HiEbBroLwA5+1a6h4Aci72wjXj
         X/xUAUtWVDc7N6DBpBDDAXHm6PWebc8AK4/4iCh7esCEtlNOBbJxtD2bIf2lxU7A2tjS
         C6VA==
X-Gm-Message-State: APjAAAWxQD6bylOGFH89A3TePc+0Z0cOji7lSXS4gdxY47WLhfax9K1q
        ky+Hu5ntlnJUNdTFbESOA0CKhMQpKKca7rbYKIa/HLXmj7Y=
X-Google-Smtp-Source: APXvYqyB9PGxpyHi0KTgAhmaFHyda9BrMa+wSC/jD48bS84qCnqLOJBoIVLhk95iMsosEnDtjxtXbYVUzgEeMBtfWNU=
X-Received: by 2002:a50:91ac:: with SMTP id g41mr14196835eda.188.1553081287670;
 Wed, 20 Mar 2019 04:28:07 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 20 Mar 2019 12:27:56 +0100
Message-ID: <CAP8UFD3MkskV+oKr9ORiz6UV5cfkDuENQ_vvi8ciwHzbzbHQdw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 49
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Luca Milanesio <luca.milanesio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 49th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2019/03/20/edition-49/

Thanks a lot to the contributor: Luca Milanesio!

Enjoy,
Christian, Jakub, Markus and Gabriel.
