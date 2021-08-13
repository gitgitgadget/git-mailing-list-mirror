Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299C7C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 17:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1FA5610CC
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 17:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhHMRuy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 13:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhHMRuv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 13:50:51 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52608C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 10:50:24 -0700 (PDT)
To:     git@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benaaron.dev;
        s=key1; t=1628877021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0Uik8NP7/NwNO0nNvMJJdyon/8qliL+G8S34SAvnOwQ=;
        b=p0Nx701eYabs3bsWiwew7FzSb1LILp74/FqoRRXHcAShE6iC/G2KBEUcHieq9VP1bcAyyo
        ceW7TfdKOipHJxWhIGK0jsTMYT3NxgYO011nZpXqO+8+zlt6oCzKyBDdPEsrGZYh5HH7PO
        4mu2zvaveff602hj6au5VaYj66EOIcZ9TMGsugFGmUxpvUWTdAz9D16O+CmIDdxa22/pKT
        KUz3Dkm+38gYnpUDZCxaMrsKszdx+WVI1EEOawCouOLZhv+FiLNAT4PvzBVinq3C9DNzLI
        ubKUiMJqJx5rXPCcPhwdgCU0aiScy1RSYJrtUozGg8wdKYObcNP9kb1+rECgUQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Ben Goldberg <ben@benaaron.dev>
Subject: send-email issue
Message-ID: <24a88faf-5339-8449-80c4-f6085bd1e098@benaaron.dev>
Date:   Fri, 13 Aug 2021 13:50:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: ben@benaaron.dev
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I hope this is right place to ask this kind of question.
When I try to use get send-email I get:
```
Unable to initialize SMTP properly. Check config and use --smtp-debug. 
VALUES: server=smtp.migadu.com encryption=tls 
hello=localhost.localdomain port=465 at /usr/lib/git-core/git-send-email 
line 1583.
```
I used to be able to use send-email on this machine so I'm not sure why 
it's not wokring now. I'm able to send email using that account using 
Thunderbird on this machine, so I don't think it's a network issue. And 
I double checked my smtp config.

Thx,
Ben
