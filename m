Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DC271F453
	for <e@80x24.org>; Wed, 19 Sep 2018 11:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbeISRf4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 13:35:56 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37819 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbeISRf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 13:35:56 -0400
Received: by mail-it0-f65.google.com with SMTP id h20-v6so7330214itf.2
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 04:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OD/m1FD2wFVF/AkLdPM8hxH0ZfsfbE2w6q0+BIeCfy0=;
        b=UC1B5pS1JkxbYZd5Tv9Pxa4L0gycqT8qnr7Klzy5YZ0UBIdTbjUp9sL/gDPDPurmBZ
         NnSFs6OpWPYDEiazfm0lQU/6XTJ9wl8qxWFjt5l+k39g8bkwRXY5ImND4BV8wm9GU6yS
         si2klfVNQwAns43nlkiMXpydb9FR3eGn9ZJZ7WIpnc3CQedQxjFSUW8L1l32JKRewXYJ
         DDFWCaDrGobhhacorYBm/dMNRnxJo1LOBXZipLUk40/PxrOUbdHHZPxiUPaAeyplOvve
         rRJJuqCkB0IT4ri+VHY1t/rgg+8PWiU9tummYG/HOm0jjuw/ATRfQahU+XuVk6urRTI4
         aTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OD/m1FD2wFVF/AkLdPM8hxH0ZfsfbE2w6q0+BIeCfy0=;
        b=s7dab5Ps0/BDpeKHJCOSiSkvIsjuaXdxUbfo8Ew33cQ1qUxskF7dvXiZQW63AYJgyO
         2r8fNVxrErZsuTFHk43rrqkenvIkkTxAJuYzm2hN20Tn1/R5aWZaaFp+Ip6jCrK9dD8G
         wtW5VHKEO+J6HxjI47IUnturK+KgP77Iut7+kvhvnBvl0q7mx+V9vWYl0rtDapIX15rf
         pVFMa5bkB7rJ2l7F81KjECQYh+SnUoTXftvuj0bGCA6RBd40egRxvVh89LkcQGQoD4yY
         Pdrsc4GbgHOpPtvGopnip97dXpESyrpkIQfub3pmpcYgXV/4oHt/uZXRzbV1nIl12COL
         tDgg==
X-Gm-Message-State: APzg51DL55AVcs62PxdZ3T7j+pMv4LMINHOISNfZWT3N7gNu0tDaEc1x
        p657yguhKP88wM4Kl4YWxsy3sUJo59MrcA2p7jUHF6AD
X-Google-Smtp-Source: ANB0VdabRmS5p3NzAmritVg//1AXEwjwn2WaXXK/2zwrGRbE3FWZPc2yCInOBUCpFDNoS6oHXxpQemM7bRj8XiNV1iY=
X-Received: by 2002:a24:cfd7:: with SMTP id y206-v6mr20528500itf.112.1537358299959;
 Wed, 19 Sep 2018 04:58:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22a7:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 04:58:19
 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 19 Sep 2018 13:58:19 +0200
Message-ID: <CAP8UFD1BDXUa9G=dnfmh1o8Qe1mnh6pUOpLSB+rsc=MhBroYow@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 43
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, lwn@lwn.net,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Luca Milanesio <luca.milanesio@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Paul Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?Michael_Mur=C3=A9?= <batolettre@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Tacitus Aedifex <aedifex@sdf.org>,
        Kyle Meyer <kyle@kyleam.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>,
        Matthias Beyer <mail@beyermatthias.de>,
        Julian Ganz <neither@nut.email>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 43rd edition of Git Rev News is now published:

  https://git.github.io/rev_news/2018/09/19/edition-43/

Thanks a lot to the contributors: Johannes Schindelin and Luca Milanesio.!

Enjoy,
Christian, Jakub, Markus and Gabriel.
