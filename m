Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C69D71F453
	for <e@80x24.org>; Thu,  8 Nov 2018 17:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeKICoh (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 21:44:37 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:35261 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKICoh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 21:44:37 -0500
Received: by mail-pf1-f178.google.com with SMTP id v9-v6so7275255pff.2
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 09:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ttMe8osMBFP+UQACRCc5Qpc3yQhMBNFsKPJNV9+USiI=;
        b=AaXlGWejatXuGhcTVPwC4syf2wBlOtq8MoCbwHmxzvXxPQStwNDnFgUHNkQcyjTgFG
         Rpo25X2HbYWLj4qVzhrEDIQucy8Y7TZIuKs2oLtT8hiC9VS9c8fOfg8afrES9YYHmJ7c
         fcILqbgeoiA9UUl3jvJuBtUHdYMxLrXfAUMugo2mbIMN/8PEEOT9dgI4ZzGtNVuCQrug
         V6TQZEBfz3jPf8NMDTzXwm/Qfz5suS0/fX5PS49QfSD/H351kRm5KD3PmZuX2/xswhhS
         JAlEcqqbr84dTkTvDvaKjckK8DffESpelDGu7gkZ2V3Z3fX8LpE0+P6S3cGy1iQDEgNz
         Wyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ttMe8osMBFP+UQACRCc5Qpc3yQhMBNFsKPJNV9+USiI=;
        b=sdLCuJYW8ttEY4i3gMXy/mlrWm32sh+I/k4mopq+WM9/0MFrgINZzLjku57/ltqhPd
         0jdOiSYw0Yw49g4EZIsg/VZcKi5gXZK3UnJ53K6EYMW959RN6IJ2KiChWwwj1Lg3bbkt
         V+fryRX5ZEQHWdRGRQCye5qgvzDsQ4iuHJ8bc+xwQUmA235OiWLCnyVppTA4OU/+RqyE
         pcWJP2EPS/adwJpULrgGcb5CglPZLJwgTbEGZrfNREeFHvfb5yb+chEDGu8EDQYj9Opy
         cizglHsmdaU7oMsoNTLsq7c8YDK6BzNAcM7mz95Ml5bpIAg5NPwQtoQKXjjWMv121BJJ
         aLWQ==
X-Gm-Message-State: AGRZ1gKUyEUp9tvmx3SY0TU0kNIeqY5tyRNVife2X29BiWuaBmW8Os2L
        uSrg+S/8yJDr425Clr5EK5Ft/hTF
X-Google-Smtp-Source: AJdET5fhktXsiFg0mN4yRDxr1EzQZcSzgBXyte/CHNG2/8tkiv78dAqL5kPvaT0KuIiKBBJdPuIavg==
X-Received: by 2002:a62:1e42:: with SMTP id e63-v6mr5306589pfe.149.1541696889282;
        Thu, 08 Nov 2018 09:08:09 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id g190sm4022080pgc.28.2018.11.08.09.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 09:08:08 -0800 (PST)
Date:   Thu, 08 Nov 2018 09:08:08 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 17:08:05 GMT
Message-Id: <pull.71.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Update .mailmap
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed that there were a couple of duplicate entries in git shortlog -nse
v2.19.1.., and then continued a bit to remove the duplicate entries even for
v2.10.0..

Johannes Schindelin (1):
  Update .mailmap

 .mailmap | 13 +++++++++++++
 1 file changed, 13 insertions(+)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-71%2Fdscho%2Fmailmap-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-71/dscho/mailmap-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/71
-- 
gitgitgadget
