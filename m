Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAEA2215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 15:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754697AbeD3P7n (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 11:59:43 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:44443 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754474AbeD3P7m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 11:59:42 -0400
Received: by mail-ua0-f177.google.com with SMTP id h15so5699785uan.11
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 08:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=zgMxqITDm9MZrR7vqTHSOucYJnyJfxNg7JlXRt8RuNY=;
        b=NLmL1pZHZLedZlJ3oBhkEca0NoAlG+PeTQnE9igauLwMu30x/Oa5GUfnGNwsXn78g6
         ekDWeWUp5y67jUdYbem/E0lB7orm0hq21bywLnirB4IYi9EZGTTi1MCdY2xFEWgkRbxy
         mW2sF/yDBPkzi7Hxl4O19lwnz3WKfHbt8T05CPsqXIlHOU7viN0CQa3j7hnQ3IORQUMl
         s4FndH8ek5rO+owcfsHD0wPyEeVO6v1NlIkSAkHv44A4JbgqhkMPWB6uHu6BDPFi1YXA
         Z3F1eExXrzbq8pGS8QqcDJYqn8wLs4QW4M8xxJn+7oQEtYoN9nXJd7b5vZA4whNwqzer
         4m9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zgMxqITDm9MZrR7vqTHSOucYJnyJfxNg7JlXRt8RuNY=;
        b=n0ZtiXqdLYaLXPOeJLhIqoifB+Fd42y0+rzo2wofPBBXlILjPZyu2WNdeE1jVllYcd
         5yeVJJovj+4qI4r+yJA8Uqxd3Z+d/Agwj2ylScMV6f5f3NE59zr0lkporP3EQ6X2Oh2L
         Y3ytwfmQTIAMx4BLvbBe0O3+Md0rbwkLU3m9ElWIvhaMkpWWgPZHgkiRVDKpak8cypbd
         zXgQsF8FgEe0Nx4RMZhMN+CbuSmhx6bPIYFVIXxSov2ZzWlS0sdbUyWHkLt2eXDLBaHt
         88Y26DmZ8hhXTTgAWuxIm02tQYVzrasTGEigjJ1nc5zcc1/IxgTQgdPkyjphOsJG6N1S
         Qw6w==
X-Gm-Message-State: ALQs6tBUDFhtdpbfGhM40G9SwwTZ1IIYT1kFvFfo0ct2n0/BwZ3GGsDB
        6JExCRvVEQkDVQ0F3IuqG1w44G+NRlBTTZLdtmyPUGIA
X-Google-Smtp-Source: AB8JxZpsqymi7mFnN+wr0UxNrpPrujjMOYDjeClonqRE7E55kvqiAW5XrIUawIhQHnRV07bmSRC/MTx/GdHQ2Wru29o=
X-Received: by 10.176.87.193 with SMTP id u1mr9731084uac.1.1525103981590; Mon,
 30 Apr 2018 08:59:41 -0700 (PDT)
MIME-Version: 1.0
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Mon, 30 Apr 2018 15:59:05 +0000
Message-ID: <CAJZjrdWEgdXmcXuxmF2CH3S6SZT8Lt-3Cw8ZJKiN6fnig-wivg@mail.gmail.com>
Subject: public-inbox.org down?
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DNS lookup is working but the website (possibly the server) seems to be
down. The TLS handshake is never acked:

$ curl -v https://public-inbox.org
* Rebuilt URL to: https://public-inbox.org/
*   Trying 64.71.152.64...
* TCP_NODELAY set
* Connected to public-inbox.org (64.71.152.64) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
   CAfile: /etc/ssl/certs/ca-certificates.crt
   CApath: none
* TLSv1.2 (OUT), TLS handshake, Client hello (1):
