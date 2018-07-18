Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C7901F597
	for <e@80x24.org>; Wed, 18 Jul 2018 12:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbeGRNax (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 09:30:53 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:42823 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbeGRNax (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 09:30:53 -0400
Received: by mail-io0-f174.google.com with SMTP id g11-v6so3971611ioq.9
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 05:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QmpntLyH0NeOJQM9q0uav/AM9S/Miir1cRsSsjGRPLY=;
        b=ex7+7tVSLGg7myQpLbjtqjGiyDOdh3hcTu1mMkomqkSQLTv+9MUT14ooqtJtPDlHSL
         5xnZljXWa7o4Wi1vpnHyAKj4FkXe4Q/ESJIln+fjSfk6u2vqOGC5OYEz15qrc+IQypdG
         uT5K1xw5JjLUF7KEwtl8uuhm7y3hT45KMOI1G8o9/nSkVnkbLjt6v2P0h6n+3CTXD4jM
         ajcq6froTUOy2M3TtFtXRXsJuWeQFESUVTSlznDIlMfeDWH/V8mKXhczczi0jIVg79XE
         xlVKeUHNQSMj4d/9keYNmYWbazwFQt5aPNw5l9yUo77zH1eaCn9+lFjSuldwRZIGVwSm
         u2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QmpntLyH0NeOJQM9q0uav/AM9S/Miir1cRsSsjGRPLY=;
        b=NPV/Hshdpp/ElIogvp6SXhhMIuGX+D9OpGtE/RcfSXAQ9w05nHlNwG40+HTqxabLXN
         Orpei86lyeAOIWUJcwd+Opr99qb6VHMCgDmIq8hdic8dLDCv+CH9vMitcX6adMIT61Y9
         Mo/R1bRy6Bde3ildqo2ZvUMa9vG660xZ4Dp5LEZivZVyGuHOE45+j2tjsE82lldMF8Pa
         QjTA5rvTxEs/87YzEf0vIuJ33XlygslxEyVSrF7uXoIfTe+nAhf/QNazz4zeAY2xWCyr
         JHuwZUSvurup+GZ4WVGvlKuE7yqq33bCaJfRpIotD1sOHk2UuBw7lJHcE3Ybfk/DhtjS
         w+fQ==
X-Gm-Message-State: AOUpUlGOYEQw1Sbb+GUJMgtGuEvaHwzOniBR40vtdsV3PCf4A1nG2JrA
        UpsW+hjbtKtQmHdGKavSjsURriR1A0DVCAwbqXHS+lJn
X-Google-Smtp-Source: AAOMgpcskrT8xHWzbmaCxyLyeW3irhDVlRpxcjQ+69eWNgvOpTIn2WbbCI8GIb1ILD6HxwcLPg1m2OoDza11f06USqE=
X-Received: by 2002:a6b:3042:: with SMTP id w63-v6mr4675916iow.223.1531918385631;
 Wed, 18 Jul 2018 05:53:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:2293:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 05:53:04
 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 18 Jul 2018 14:53:04 +0200
Message-ID: <CAP8UFD1GDWVqD2pCOMpPog4N3XrvyRO_-dkUq2m1N4FvSSXsVw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 41
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>,
        Keccak Team <keccak@noekeon.org>,
        Gilles Van Assche <gilles.van.assche@noekeon.org>,
        Derrick Stolee <stolee@gmail.com>, David Lang <david@lang.hm>,
        Luca Milanesio <luca.milanesio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 41th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2018/07/18/edition-41/

Thanks a lot to the contributors: Luca Milanesio and Derrick Stolee!

Enjoy,
Christian, Jakub, Markus and Gabriel.
