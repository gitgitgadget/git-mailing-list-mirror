Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 651F31F576
	for <e@80x24.org>; Fri,  9 Feb 2018 07:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750920AbeBIHoX (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 02:44:23 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54645 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeBIHoW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 02:44:22 -0500
Received: by mail-wm0-f65.google.com with SMTP id i186so13690854wmi.4
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 23:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a2oQzuocTXLURx4s62bWa5TBrhMQqNSy0PzOf7zuC4o=;
        b=usawgNYmmFGhUv+AIKhkhRXzrcVi8VNri6AgEj8qRsQfPHG05JyiR49bgXIFtgGCaH
         plcX4OWTmTal9lFc22UIIaTzg+zyD2FMtuHqR4fQcsi4rRZwg8GBmLLrgx4eqxrtb3zD
         JYyaTxSSU3jhlrDiHFQ2MQ8k056a5214PjiIRt2W6alyAvEVpewXRDLMqxgKiWGOMWMP
         9agOzRytBKZGd/T91ROUPYeWl5J1jte4R3F+ffUowHGQ7/ihBoy9IvR7gllMBuYOuBwD
         GaSvbR9U4mgdhQxmn1gJdDD9IRnrEPrp4gyUQ1SQJ2n8nsUPoTkVosk2mBxr7BJ0oc/T
         OC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a2oQzuocTXLURx4s62bWa5TBrhMQqNSy0PzOf7zuC4o=;
        b=drNaQgd3WSWxEDhy/0rzEpXdmvbwUSvl7mA9vQYCm8ULbTSwUGMU20l59Map+FHwZb
         GC7nfo/ATISIuBpo/45nB4qPoNGsXDhFCSmiOobT/K1sQnDDUWM5QiMWRRhrWFcTCn5A
         JgKbbz4g2S4eGI+86T3l4IB8/CmGQiaCpK3zX1kbEMhhiQFYz7RDe4VfLfWEYVbU4g+V
         5Df69OyNMrOuAyg1VdjpG7RgNofzaOnLcSevtYfkyWD8g3Cg4vD0FNtXts/q3ZkyOQyi
         lEGZ6DrHi0sTXcKPYrzfQ59CDK2/OgwdBrcmABNt1ilpCfYvhoKLaQrzYqK9wYDlF2qD
         hI8Q==
X-Gm-Message-State: APf1xPBzmqYTO3aBXyw5oX9owV+kEyh1qshR51SnTs1cEgNhiaVkFJKK
        XoPu/ryxJCEI5uDEulxhYqlwZRFYAXTapA==
X-Google-Smtp-Source: AH8x226mumUq+6DvQOkv9DPZ+aQgz58d0rU7ws8MAiD9ob8jM3dauvK34pUHbCLxj+zjWixrXmSSMw==
X-Received: by 10.80.177.178 with SMTP id m47mr2446438edd.45.1518162261428;
        Thu, 08 Feb 2018 23:44:21 -0800 (PST)
Received: from 192.168.2.62 ([2a02:a441:160d:1:b48:8e3e:c67f:c964])
        by smtp.gmail.com with ESMTPSA id z12sm988942edm.0.2018.02.08.23.44.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 23:44:20 -0800 (PST)
From:   Alexander Shopov <ash@kambanaria.org>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Alexander Shopov <ash@kambanaria.org>, martin.agren@gmail.com,
        bmwill@google.com, peff@peff.net, sandals@crustytoothpaste.net,
        worldhello.net@gmail.com, j6t@kdbg.org, sunshine@sunshineco.com,
        pclouds@gmail.com
Subject: [PATCH 0/1] Mark messages for translations
Date:   Fri,  9 Feb 2018 08:44:03 +0100
Message-Id: <20180209074404.2902-1-ash@kambanaria.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180206073812.GA14133@sigill.intra.peff.net>
References: <20180206073812.GA14133@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi all,

Continuing with ths suggestions for improvements.

Racap since last time:

Eric Sunshine:
  1. Use 'test_i18ngrep' rather than 'grep'
Jeff King:
  2. Fix t1506
  
Previous changes:

Johannes Sixt:
  1. Lower-case letters at the beginning of error messages
  2. Past tense to present tense in some cases
Eric Sunshine:
  3. Fix `-cname=value` to say `-c <name>=<value>`
  4. Do not translate "BUG message"
Duy Nguyen:
  5. Fix parentheses on `_` macro

Kind regards:
al_shopov


Alexander Shopov (1):
  Mark messages for translations

 git.c                          | 38 +++++++++++++-------------
 setup.c                        | 62 +++++++++++++++++++++---------------------
 t/t0002-gitfile.sh             |  4 +--
 t/t0008-ignores.sh             |  2 +-
 t/t1506-rev-parse-diagnosis.sh |  2 +-
 5 files changed, 54 insertions(+), 54 deletions(-)

-- 
2.16.1

