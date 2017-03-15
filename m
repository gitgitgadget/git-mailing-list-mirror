Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF152202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 17:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbdCORGT (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 13:06:19 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35950 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdCORGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 13:06:09 -0400
Received: by mail-lf0-f65.google.com with SMTP id g70so1641391lfh.3
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 10:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=w2Xgw4DRCutegyaKHKa4EAtGnDS8aZySgvyUlneviQU=;
        b=S/rdJZS6+cVDbAeIqJ0naynoMO+UlXvddn4oGzLlL+bqsJSIzRd5F/p+8AuqP/fwbK
         xfsv25SzuJJTp8Kiyj0jzOrW9AGSK8pwEYjR4qZixpc+9RyfSbZVXh1eykjX5nOqChJn
         UjPRXeXjhA1ITpe+HMfADja8/4veyL8TSWW4qWI1yFDG0/KwNOQorL1lMNq0p0bUgfVJ
         /JdgVHbIjJJNFKXhBdbt9Lhe7yxKZKH5FD5s+bzDM+p8gu8XG/YRkjhIcvkPqXWPlRhU
         RNdrjosNHUdgzBMG+CRe03kr5QTb4iittLZrqqo2y7u0VrtqWUdSeRiQVHoZNoS7ChyY
         bDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=w2Xgw4DRCutegyaKHKa4EAtGnDS8aZySgvyUlneviQU=;
        b=SBlgE6um5jxpuPnzG32ib2f+5zRk3QMGITt90ag3LeFIDNH9dlWHkUfZiZV8m2+VDb
         mJxx8VHWwOoMhgzlepZ3DdGibBs5ZLpAePOgwt8CCVHbKLJOT1oh78CUJAQnbxA4blcg
         zACywX0HwsffrfaLYjKx164d1/Xn8ez+olMU01PrVZzd7Hq/n1in0p7e3QWM5EMML9dK
         iCepBd9jJ1tx5QkmFdYe9hddIQvockMajbBvPIoHxscPzPHEb3h/BhR+wa6JCQa3m0s7
         uQ/Ok/GsNIo8JlCFFeActwGuR4ek1uzeWA6AdY2euxKHwust8I4iuMKfLZtdgnYMvlpT
         mU+g==
X-Gm-Message-State: AFeK/H1/N0jx6u7LUCLKZCzgetU1gHnhdCn97mB774JyjcDsp9YM+coqSf3ivlqIUcL/0LRI2QsAE01aHvYgfw==
X-Received: by 10.46.14.1 with SMTP id 1mr1568004ljo.60.1489597567587; Wed, 15
 Mar 2017 10:06:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.150.19 with HTTP; Wed, 15 Mar 2017 10:06:07 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 15 Mar 2017 18:06:07 +0100
Message-ID: <CAP8UFD0Lsrf-6c+4hK+AXCtRME-mW-TVz+vhtFqdpWQewztZww@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 25
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Joey Hess <id@joeyh.name>, Dan Shumow <danshu@microsoft.com>,
        Marc Stevens <marc.stevens@cwi.nl>,
        Johan Hovold <johan@kernel.org>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Lars Schneider <larsxschneider@gmail.com>,
        Luca Milanesio <luca.milanesio@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 25th edition of Git Rev News is now published:

https://git.github.io/rev_news/2017/03/15/edition-25/

Thanks a lot to all the contributors and helpers!

Enjoy,
Christian, Thomas, Jakub and Markus.
