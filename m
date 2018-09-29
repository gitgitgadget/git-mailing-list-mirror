Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A7051F453
	for <e@80x24.org>; Sat, 29 Sep 2018 03:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeI2J5H (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 05:57:07 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:33984 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeI2J5H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 05:57:07 -0400
Received: by mail-io1-f54.google.com with SMTP id h16-v6so5654784ioj.1
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 20:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KzVw0M2k9uVl4SUX7xZA3TC3hqDNKhvOVIsuZDeeroQ=;
        b=t5dAsoRjH4A704UJrTtAdD/hzxQsaB0vC6kchyGd9DIsK30NTEgy2jpJxRrQ62hBGR
         ZN5E3ndXS22h+pznrJAgiztNrRLICY0P723XPuLtMxGUS2jpzsXoGvj4F7vqH3rDqqza
         hG71ECTvQ94WqVT4zD87CeHASI9xDIVsCBCZHddLqeDkgZRpwo1KyjlmWIb0ULtF5Wkv
         XVaVabDwc3mRSfVGBomqn/zX8dlwM7LqvQCgmtJZx9MNaw2XaTf5tY6s1qN64FiI0I8I
         WtrIp4AFIcV5jb6P1tlNTKKJqKE3cOxVnB4JrknFTw/36HHhlI11YIpBKXyqv/rO7olr
         //Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KzVw0M2k9uVl4SUX7xZA3TC3hqDNKhvOVIsuZDeeroQ=;
        b=AxV3Bjvw4GoWvn31euvkxGsIi3tyE+OE/qNDZ1ew4e1oeAU4X9LVkmtuG30DNgWdKd
         U74/RdSZeogAXkWH+s28FD1ITdtlglKS3PQqbPGJrZ5VJsX9V+2PvGrsbXBTGBVHbxZd
         tRx5TBDTmJxy2FvbYIoI9sPQVzkiFkQee4uERPg65n2MIZkMl36/1b8LyYWJlG6rlia+
         Ot5SbhPRavg0FY9faUjF6+hp2IV9rxtCJET1Mofqo9smJwZi/PjbS+XI6H7JJ4vMZgKV
         o3hCgt9J8RX3PRcA98XTwD5abAmApmw7N/YZTIBfKfPESjW0M3bZFVeeDaeX0nzdAl04
         xtiA==
X-Gm-Message-State: ABuFfoiOAZ8CPoH6YRL9+gGjmVnhe/uofXzw8+jJDufslue90FGby0MT
        l12DyQ2LKmqfHUH3wOKKFBp6AdQsgW8HC0jCP/+d
X-Google-Smtp-Source: ACcGV62jBLfytXugYCYLb7AhZVKReb4urnTIsZ9NX+fuPKMtnq9q0uHYezOrM1eqX9wclt1HwroTnmjaekajtM455Og=
X-Received: by 2002:a6b:cb01:: with SMTP id b1-v6mr1007761iog.23.1538191822230;
 Fri, 28 Sep 2018 20:30:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:88e4:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 20:30:21
 -0700 (PDT)
From:   Paul Wratt <paul.wratt@gmail.com>
Date:   Sat, 29 Sep 2018 15:30:21 +1200
Message-ID: <CA+zYZ3-CS1ZP_LXdWPMVoOvcU+4QimJH2A0WgQ2yT5dFkO5F3Q@mail.gmail.com>
Subject: wrong output on fail
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--------------
...
Total 21 (delta 8), reused 0 (delta 0)
error: RPC failed; result=56, HTTP code = 0
fatal: The remote end hung up unexpectedly
fatal: The remote end hung up unexpectedly
Everything up-to-date
--------------

I am getting the above from "git push".

I am having intermittent HTTPS connection failures with my ISP
(Vodafone NZ, mobile), although HTTP works fine. It may even be a
peering issue.

The failures above are accounted for, but that last line is definitely wrong

Cheers
Paul
