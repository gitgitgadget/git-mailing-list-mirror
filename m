Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89C9D1FADF
	for <e@80x24.org>; Mon, 15 Jan 2018 05:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932128AbeAOFol (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 00:44:41 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34149 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932266AbeAOFof (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 00:44:35 -0500
Received: by mail-wm0-f65.google.com with SMTP id 81so10870953wmb.1
        for <git@vger.kernel.org>; Sun, 14 Jan 2018 21:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=76qTpLlD8Jkcepm4dUzQDhJTicUjzXNKsmWE/WvQhdA=;
        b=edito1pNlZyly+WS1V1juas0StW1pgmcdu7reBaRWWekac8IYKx/a2IBXCj9iLBaer
         SIAqKY+LKgY92+UvxcFOuqS6Rh0C2NwrxyUWeFvPLaEbpcGHLF9CT/dlR+ZsazhcmtcU
         xEHZGfxy96iy9Iwa0ezmkCDVGogS0gRnbXnd7JVZa2g8H4shZJ/zVJ2TvYOkyoRyR5IR
         rbUR24I150BEOUhkaj8XFmHC9Q0jbq7gd9mXs9EY5K+lDZGOmeh4DkyDDOh9JDl8WdFe
         jFpoyFz6h/Tge0wwE1RG2rmxuj67VvDQJ2bFjae/BifqY3ZWh/r5Px6giX3tWs0waaX0
         CWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=76qTpLlD8Jkcepm4dUzQDhJTicUjzXNKsmWE/WvQhdA=;
        b=piNNXZ9R2jhCFGn+ArtcCtk6iiwu92YlX6S8pdjIasaA1ykP09Nyudkk2xo6rLh84D
         /4uh8YtgzEEov+cx8X7rvIV96NM5hWY2083v2mcv8wq1/f8rImA/mcY5VouHyEpo4cR+
         xEUWKieeKwmTj/5Dyz3h4h2qtQgVZVvV9dv+JpPMaEKEFEyMLrGevTMyVUxlBD+hDIGK
         uYXulmGte6OLxs2E9cNg5Dd2462RcHeXReW1WI5nhyU7vgeuMHt4JF0uHw9m4U1HtKsc
         emBKz1YIrKS1md0x5XUNgjs9s/MjNzVw83Knv9vuinXDxAmXwWE44UXTrIeylmFCvLtF
         lJyg==
X-Gm-Message-State: AKwxytfsDnMgsMv6PGsydvtOVl21BBLV/SztDpK2XxqINTvTn2zRtNMh
        LYfmuVrQu5gAw87NashwtV7TA+viq9o=
X-Google-Smtp-Source: ACJfBot0Fuo2vRmRnVUBVSOsYaxj5eRJ1wUQKv8aJQVbQ7mk2kP+z6Z59EjPZ/mEuNStgaRnS1Cr7g==
X-Received: by 10.80.226.203 with SMTP id q11mr4725413edl.248.1515995073478;
        Sun, 14 Jan 2018 21:44:33 -0800 (PST)
Received: from 192.168.2.62 ([2a02:a441:160d:1:b48:8e3e:c67f:c964])
        by smtp.gmail.com with ESMTPSA id a33sm8758311ede.2.2018.01.14.21.44.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Jan 2018 21:44:32 -0800 (PST)
From:   Alexander Shopov <ash@kambanaria.org>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     martin.agren@gmail.com, bmwill@google.com, peff@peff.net,
        sandals@crustytoothpaste.net, worldhello.net@gmail.com,
        Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH 0/1] Marked end user messages for translation
Date:   Mon, 15 Jan 2018 06:44:18 +0100
Message-Id: <20180115054419.4112-1-ash@kambanaria.org>
X-Mailer: git-send-email 2.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have marked several messages for translations in git.c and setup.c
They pop from time to time on normal usage of git.
The messages are aimed at end users and may help them solve issues.
I have tried to keep the C formatting conventions in the two files.
I have also reused messages which provides uniformity of the used
verb tense and will ease the work of translators.

Alexander Shopov (1):
  Mark messages for translations

 git.c   | 30 +++++++++++++++---------------
 setup.c | 52 ++++++++++++++++++++++++++--------------------------
 2 files changed, 41 insertions(+), 41 deletions(-)

-- 
2.15.1

