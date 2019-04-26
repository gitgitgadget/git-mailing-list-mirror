Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 441481F453
	for <e@80x24.org>; Fri, 26 Apr 2019 20:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfDZUxd (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 16:53:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45891 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfDZUxd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 16:53:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id k92so1754747edc.12
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 13:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZdIyHvUL4wtO1BWYs2cvTD1t1RTsXYLZrI8MqzZTk8A=;
        b=hq3gpNnjShCOI4PpD901gGeez35e+/e56njxDrtfrMx5a6G6MWibh75GkKnYeFMZ/S
         BO9Awn2kQmUMT0Wp2DnEf1TvSjy87VpBhanN1cemUn6EROsNzFsXz4pjOHD3XgpL/jVC
         KyLGwTlqUSpqS/FFQAWoFvpWh52alpG+SBMB1fJ8n0w0tzHKvVpERfDG/mpBiZoFWLNx
         AOUrhvxj0ZraVb8OOMgI4olzHfkUi2zSmG1EGjT4jB2D3KzUCaKVjseR1yCI5XdMGQzD
         l8qXTGXfHhNgltjqg4j2jtiC1X0qW618gDbnzenVDs1fUymXQaPu2qQfWv4tN8kHOTo0
         XEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZdIyHvUL4wtO1BWYs2cvTD1t1RTsXYLZrI8MqzZTk8A=;
        b=eItNRYkTdK9kTpdle1S4KWJM4Jxg/D8aEo3cWlPIowH7Z+EzZP7z88JrYr7BpCqdUu
         uR1jx1VejsmwBKvDnR2WcEXks2Zbe0ye0kJ95ATl/vPFSKPA/ozWfB/BSU3lTnkJWmfc
         cU37A9fFbYYrKvlFr7jiAqOWlaWmeIS0nTZXmceuAfwxt3GBcLyqOjn0C7PTsvtS8H8I
         3sRfgfSLQ6BJ2Tg5kBCXzFfRF6pAi1oRZdmXDGCoftuY8XILby50XET4pWwuznrQOPKh
         DuLB2JXBBzzgdYYVS0gj43QP7TnsjJcVqNsFxz95zmKvH0QWx85ZFAN5dX594RmfQbXd
         j8AQ==
X-Gm-Message-State: APjAAAX5UmUdP7KNqmz3pz43Sw6GYBOudxLFCxhSGwbBn+1eUI+QHRNc
        9v7hYf/rVXGkVhD5XXmTqNLH+dpGGOM2hd30BCFRyAe+
X-Google-Smtp-Source: APXvYqwbpOZuZiumveejnvhIknzDNGxu2m/6Y9JkzTk8aP9V6Zpt6MQd5/wlvJq/ZE79uVWDPVMCwCU5XEB5EhknGIk=
X-Received: by 2002:a17:906:9d2:: with SMTP id r18mr16319445eje.107.1556312011012;
 Fri, 26 Apr 2019 13:53:31 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 26 Apr 2019 22:53:19 +0200
Message-ID: <CAP8UFD2P6ojUdVh91Q8C=Bmbc=FMEwzYg7jMYZHv_2NBSTNLeQ@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 50
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Luca Milanesio <luca.milanesio@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Fabio Aiuto <polinice83@libero.it>,
        Santiago Torres <santiago@nyu.edu>,
        asymptosis <asymptosis@posteo.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 50th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2019/04/26/edition-50/

Thanks a lot to Luca Milanesio who contributed again this month!

Enjoy,
Christian, Jakub, Markus and Gabriel.
