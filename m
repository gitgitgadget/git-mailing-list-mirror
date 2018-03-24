Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBE841F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 08:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbeCXIlW (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 04:41:22 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51307 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeCXIlT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 04:41:19 -0400
Received: by mail-it0-f67.google.com with SMTP id j137-v6so5270127ita.1
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 01:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sDn7dM6i4knCEP4GUo17Mh1q7d4t1QJzvhBHpqqCg/A=;
        b=PBYiHcWqFB9QtPTIk2vjsqSLpRGK/MzVeYynga1UWkb9/5jeSwt6xA8f7lkjSwWhKa
         QxTLsNUSpa0wwtCKkHFNX5eK2qtDadWeMIPvFaD4YlIKJcRpDIeIMCMsqwWNqIWbKRHD
         KXLHEiLicxBE/HlI/Op/sP17t8SLDLBj5e9Nd3rmqejWsp2xpWkm5T+6ibAICcPDZEhL
         j5OE5pM0IN8XtjWzgTUrpzVEqGPfhwW1EGRAifiWVaLtEkS8i16zEERnTGXCz/+xGNv5
         wOoPH+rtk4GnZyAVwZTH5LSUdtvTExcIl99GcWUxJrWaQ0l0PUUTHwFc0RXQRGWHZFMR
         g0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sDn7dM6i4knCEP4GUo17Mh1q7d4t1QJzvhBHpqqCg/A=;
        b=SJZee3d2SEtgsHbrWmz29TuUby/638VcUsIt4OxzfCyOy+Xb5Nyx87OdRegLAGG8CW
         z8h4mzCIuRU/rzNihWecALguIB6wOnxA0rg++9N5v5Hw0VCnIuIB99UjmGZnY0UY1AgP
         tI5C3J+Uw3saMUCV0Uuibw/0dTApK1C70dprBhwoOSU56lf74k7PnzFfZIVvea9FXJY3
         zjBJhsUHFF26gZbEUz43wA3nfC2jIWiV+DFuqqIFEJDM5w2bjBkOsHjrzyiGNyrsYWMD
         d7WG18CTN6NC4DkdgKFwIgjz6PbvSupSTB+Ss1BA9FlNFQFaI2B/fDk7vELiLDbOzBde
         Aerg==
X-Gm-Message-State: AElRT7GozGNWihITS0pMcAWWkJ4maX3F+NcybRVJszU3OCLuJD282rzI
        2HlF38U9z/KNTa7utowiMzyYKc4E
X-Google-Smtp-Source: AG47ELs/EGidtWbdbIv2chXwxJL/u4qeUK928BE/AUM3bXpjbN4tq8SOX929P7i6eJvmRcmr06iKjw==
X-Received: by 2002:a24:7f0a:: with SMTP id r10-v6mr16191925itc.101.1521880878674;
        Sat, 24 Mar 2018 01:41:18 -0700 (PDT)
Received: from localhost.localdomain ([27.34.20.189])
        by smtp.gmail.com with ESMTPSA id b17-v6sm7751186itc.38.2018.03.24.01.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 01:41:17 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [GSoC] Re: Info: git log --oneline improvements
Date:   Sat, 24 Mar 2018 14:26:03 +0545
Message-Id: <20180324084103.3367-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <CAP8UFD2D-XU=YeJD7A+9wauu0WKHwkXgVxbEBkOGPyZE7GiOZA@mail.gmail.com>
References: <CAP8UFD2D-XU=YeJD7A+9wauu0WKHwkXgVxbEBkOGPyZE7GiOZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Christian and Johannes,

Though I sent a mail earlier, saying I would like to submit another
proposal, I am now skeptical on re-writing another proposal as you
guys are only available mentor for GSoC and I believe Git doesn't
select more than 2 proposals. Hence, I will try to update my previous
proposal[1] and make it more worthy. Can you review it and explain
what I might be lacking there? Thank you for your time.


[1]: https://public-inbox.org/git/20180321061605.27814-1-predatoramigo@gmail.com/

Cheers,
Pratik Karki
