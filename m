Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F5FC433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D79922B51
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbhAZFAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731106AbhAYTRm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 14:17:42 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5916C061574
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:16:32 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id w8so15974290oie.2
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Wi8NBeZJqf+dAArYrGQa6+1ND5701wwsbsRjjDVvAbU=;
        b=ouVdrckPFtTC1Ln4xvQN2Sk2rLYzxX1IK2X+uFCMrFQ34ea0zyBR+CqwYlLqUXph3r
         YJcI1bkbx6F3FpGDlFH5qY+xTcnD5PG9Note6j8V9xKA3/lB0cHZucPcYUvvia35p+IH
         prv8D6Gtzkp4eK5O0t72oRZSjLH/rP8yiwydpiviWMsv5O5mJAkH33wO2WKuoJWMKU43
         guRc7nL2y71SK0AN2irTWY6+c95x9WlGPxVDSTeGtXprxNtqBCOLLtARcEl25qkgv6fa
         BPO0FaiCmOmT8gpaz4/7+6d1ShAKXuqHuu1o+eaN1wSDJwqMtbg4Uj45zWlvyTpAyKby
         fc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Wi8NBeZJqf+dAArYrGQa6+1ND5701wwsbsRjjDVvAbU=;
        b=YQLa/lK0U1zar6o+LwAL5jo4PPP3axxPd3kruQ1suRGNNxyI21B8zQEdVwuRH2P3g1
         B5UlltSFBQExlsQyR2GDXY+aLRVk+Gw9HFMZZjb385+MyYprMWVS7vMYsSK9IfGYEPiq
         fWsBzzef+kLL5HoqPYjhNxAR7AAuPkvacAZLZcZSRNmEz0zQbyoI6cSf+isvoKJ7BDzA
         emPKmK5cpUs/x7QNKlsB6wLg7p+jaHAToicn3vHtNPYy3bRFFYr2UPWhldq1gchAGAHE
         0BNKLxsM64Gb6hpx41JbnLQ7DNezobKZxjzCB0hsq3AXaz2Xc4BUuh9sHdOoYWASsfJy
         S3tA==
X-Gm-Message-State: AOAM531ntGL7zPXJVCYz/hhmwxHWT/SMtDlrWqWuZLepBMMtAJIMoxT1
        YIrXCGY7Fyc8TnM6Mq69JsRbAJs9LsIW7fLSrXdXDfbbFZgAew==
X-Google-Smtp-Source: ABdhPJxofyNnqAmFaciTuxAg7jolM9egUAsaMukxorMF3a4/D9vy3lcjw8tetDaHppvSqnueHdYyB/eQh9KnAKcjlQk=
X-Received: by 2002:aca:b255:: with SMTP id b82mr1030781oif.98.1611602192097;
 Mon, 25 Jan 2021 11:16:32 -0800 (PST)
MIME-Version: 1.0
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Tue, 26 Jan 2021 00:46:21 +0530
Message-ID: <CAPSFM5dYoXOkihsm3nz4KpKL768-Ayfey5OczRUTbsJ96rjCnw@mail.gmail.com>
Subject: [Outreachy] Project blog - 6
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone !

Here is the next blog post regarding updates on the project:
https://charvi-077.github.io/week7-progress/

I appreciate any suggestions and feedback.

Thanks and Regards,
Charvi
