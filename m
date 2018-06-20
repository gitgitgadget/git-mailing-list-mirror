Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EFC01F403
	for <e@80x24.org>; Wed, 20 Jun 2018 11:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753825AbeFTLEY (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 07:04:24 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:38286 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753266AbeFTLEX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 07:04:23 -0400
Received: by mail-io0-f182.google.com with SMTP id l19-v6so3068732ioj.5
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 04:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=eiDfrONjAz8OyvEmVuhBQWJRE6QqwjfKHyeJBJfKqBw=;
        b=J5WgA+Xxjzc3cjWnBDlFCYgcjnrka/P9pz/Weu4UZ30Pob6nGsHmMP+EsDkEDdtX9D
         2SA9rR+eBlZr6DoLRyHYaryFfmT2DmqNykQ7slX78mODfy8nOHij3x0wNKrAvNIW+Szc
         rim0F4SetZdkYWO+qKGjcuzcWIqMCTgHmuQjXQ5HjgaOVJb3LmFJGtfxKWsmRjin2NFt
         xoujO9IS3ACr0arFU5Q2yShIJpyLSA6yAkqNzhSLIFRosyIM3KaL3m+QJzEEuZhlGYgE
         8zHWPCD1W5fcFMmspGSWcnFTrJX0KF/Tq0MvDd93lfstTU8/vAivBB2AKcLRhd1/uZgA
         T+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=eiDfrONjAz8OyvEmVuhBQWJRE6QqwjfKHyeJBJfKqBw=;
        b=ud5cu+gYFrf+jBp2QNRJm95I3aJMWfdPHA1Wl2P5z41G21YzNcd2CANhf2XSHkubnR
         ny8kqxqqN1PSk3GllOJN4OeKtFih7I3B0xwCQjslWvfayzYYgAlHmpTu2mwd7lLQdU4G
         rBex1dWl97dJVmTxj1cM60Cl0z1NRrCmjOsGvPgbunz1N83r6Z2b3JlhX3bFnWRtEFw0
         f02nba1+2Ek/JFb6rbnLgEUNWIjOt2EDV2ZfIujyqyy410TPhPh1yleUwqzUwJN+n6z3
         DE4n2Ay7qJiye3PTDraHszBHVMA9eht/ZCyIUL5hvop5t2O+qDGoWNqcbjw4o1BtsPC2
         9hqw==
X-Gm-Message-State: APt69E1FurpakoYKcNWmjznWXX7WL8AO3xAtN8nbqcqOR2NVrCrcpPaS
        sNX/PlIAHIGsCIqLjwU1js7L7O6aFag2j5ME5RBXmt5W
X-Google-Smtp-Source: ADUXVKIwCtG2HJRQX6aa6E5r3zeH5gme4yh+rnCOeFStLeXQX1wuONBjZzABvlwrSCnlJEmkz3hxWE3amaQ5MddnCOw=
X-Received: by 2002:a6b:ac85:: with SMTP id v127-v6mr16341111ioe.53.1529492662108;
 Wed, 20 Jun 2018 04:04:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22d0:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 04:04:21
 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 20 Jun 2018 13:04:21 +0200
Message-ID: <CAP8UFD3uxi4i+HCFqgmCZZ9dYAfk1tqCA1CmzdWgxQLzU4Ab0g@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 40
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@talktalk.net>,
        =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Adam Spiers <git@adamspiers.org>,
        "Sytse 'Sid' Sijbrandij" <sytse@gitlab.com>,
        Bryan Turner <bturner@atlassian.com>,
        Ed Thomson <ethomson@edwardthomson.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 40th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2018/06/20/edition-40/

Thanks a lot to all the contributors: Adam Spiers, Bryan Turner and
Nicolas Pitre!

Enjoy,
Christian, Jakub, Markus and Gabriel.
