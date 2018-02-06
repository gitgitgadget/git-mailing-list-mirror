Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 129DC1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 06:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeBFGPq (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 01:15:46 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50210 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeBFGPo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 01:15:44 -0500
Received: by mail-wm0-f66.google.com with SMTP id f71so1445274wmf.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 22:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oeor3PPA9kPHQFjG+fxhvd56h1CO9ed/DPJaHzBH/w4=;
        b=1u8q3f6sLggs8/UZR6kLqdovXLGsDpdaCkBzDhgUqBoB/oIGGAl0KSn+JgltKueOsF
         kDZZ+VIhPsV9eXYuuFZggajJx/Okib+ax9hDfu9D1MwXkRzcwDPoA7OWR6fZd2h53c6e
         ONM9eKBqal4ClXT28sEPx15meQcl5S1WLzEfWUcaSCRDRHAwXUtz98AUdeAnCCNkPcQU
         AIVozboqMIe/eMVcSxuizu6sSLA2Ghs7B4eWDMT0tGp317oIETMnPwdNDu02nutQnaus
         30pcILJusBv/WasCM9tGxPoYMFlUi+sVLxxbQbfLrx6KT52BB9xb7QqCkzQgBFWRRuIb
         7ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oeor3PPA9kPHQFjG+fxhvd56h1CO9ed/DPJaHzBH/w4=;
        b=Bk39SsOi7WL3ybZnnhMxVKGmBhFhPNNbGD59hL3T2uzLvE4SoDYfSKWYJrOMs6qp/2
         kTTuHIWbzN5mCg2tX0k0YCGVQLIWwv0PPduLOpj0Uwr0fUbqRLf0Qm70HLRHngFiuKQg
         wOuWqYYhtDiHSVswKYhxu51Gf+y0fwvBipotP4WTWipi/AB325xeAYd/QM3KLE0kmIKy
         mIZ3zu7vHKXi6BJk1a84V3ntA6XEaAdY4yTKIfw3rr/MYVMYmwJw4pR2QA3WFrdWF40q
         hBu+iW79gzZZuqf+/DGBxox3LkDQHuYMYUct34VA6QhxoA0ZqbMmMPGT4kjoY279nLjJ
         DJKg==
X-Gm-Message-State: APf1xPDai1GQqs8ZScGnfTpTerdbbtdnjaX47FKujUSn/tTT1dN5aGQI
        X04g73W9+zstQZLcV1+k3cWlkx/UA2boWQ==
X-Google-Smtp-Source: AH8x227hi/FO3rK/spHjmeBGrhk9HYxC4cXX3FN4YTPyPvHNYWppSpomTKVYTuxtfp7TW7kUqqHPwg==
X-Received: by 10.80.147.229 with SMTP id o92mr2379998eda.206.1517897743434;
        Mon, 05 Feb 2018 22:15:43 -0800 (PST)
Received: from 192.168.2.26 ([2a02:a441:160d:1:39bf:c953:110:444d])
        by smtp.gmail.com with ESMTPSA id r7sm7950872edc.23.2018.02.05.22.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 22:15:42 -0800 (PST)
From:   Alexander Shopov <ash@kambanaria.org>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Alexander Shopov <ash@kambanaria.org>, martin.agren@gmail.com,
        bmwill@google.com, peff@peff.net, sandals@crustytoothpaste.net,
        worldhello.net@gmail.com, j6t@kdbg.org, sunshine@sunshineco.com,
        pclouds@gmail.com
Subject: [PATCH 0/1] Mark messages for translations
Date:   Tue,  6 Feb 2018 07:15:36 +0100
Message-Id: <20180206061537.2573-1-ash@kambanaria.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180115054419.4112-1-ash@kambanaria.org>
References: <20180115054419.4112-1-ash@kambanaria.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

*** BLURB HERE ***
Hi all,

Again I am marking messages for translations in gui.c and setup.c based
on the feedback I got last time. Now I am fixing unit tests as well,
hopefully no regressions.

Here is a recap:

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

 git.c              | 38 ++++++++++++++++-----------------
 setup.c            | 62 +++++++++++++++++++++++++++---------------------------
 t/t0002-gitfile.sh |  4 ++--
 t/t0008-ignores.sh |  2 +-
 4 files changed, 53 insertions(+), 53 deletions(-)

-- 
2.16.1

