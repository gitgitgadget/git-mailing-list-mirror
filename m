Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 242F31F404
	for <e@80x24.org>; Sat, 17 Mar 2018 03:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753019AbeCQDbs (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 23:31:48 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:40561 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752875AbeCQDbr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 23:31:47 -0400
Received: by mail-pg0-f49.google.com with SMTP id g8so4833750pgv.7
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 20:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0jU3C4gPPZA8oWwnViCueOsMQ21+vmfp1ETAjE9CwwA=;
        b=a8/dYLB0oAEoNDOiGU0BvqtLo6V8QqhXAqhDTUJZL+/m71lgQ2QrMJMc4IxfmvnkHT
         fxsQAq0lmA0E5jo+jDP8fCBYUg7/NeCLWZ7Q4m/RA51pDT3T9ijVobjcE60KTN+vYQTb
         AU0obk4uyT77h3gJFZqMhli3tdIj0+0Gu0JNceSD60kHq5+vDbtNhp7IJV9HtuxwECPZ
         uDG9A88fffXXI8TylJHZ9NZHjh4xuJ8eH/SDka5Cvsw4yEhUF6P37n5G5ynw8vqQbEb0
         iePb4c31vx7ap+eqLRkLF30avi50tl3Q4zfcwB7RqVYRJxUBA11pW0Bq1zJDsSpjnuBE
         areA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0jU3C4gPPZA8oWwnViCueOsMQ21+vmfp1ETAjE9CwwA=;
        b=qTft+e5M2DXKZWpuXIljJKIoqikv/ewY7SpPssoETgl7y3gEcOzRcoF+SIgIau8HIR
         syoPzhXifi5vgPcwDUjA17N4AOfiQ2b9c5FJ5p/fBmkdhLJTjNxk9wvhiAssHf5OnS3z
         P1f3MVvijcBvJIOgaRPZde/bStH+H7Wjjw/2e19/f+si+zVizM9KY0Nt3KL3dqGMI6Al
         qMJ6tX9FDP3hNvRRz+2kTCYV4SmWqzuKR4nUbn0kAslzFlfvhpjvBCdChRQHxU0fYBSR
         Ig0pzAhHpix2zqpqg4VdKh/EVEnWrkkpi++6yPVGtVSQNhtRDm52HD7hciGuUgqwCqS2
         oITw==
X-Gm-Message-State: AElRT7Er111Z9y2JTcJqqNEl49VxMjjTGKyaJ0m/JHiC7pDNJA6LMh+j
        aAy+T4q7nmTezvMcnyhUZ5dpmOzj
X-Google-Smtp-Source: AG47ELtmAST2piA+0TLgkrsPzEyhziRyqgYgZMdD4/jiXcdqCgNFo5V1WQCeTRyG5r8tF4+oPaznYw==
X-Received: by 10.99.100.68 with SMTP id y65mr3390873pgb.257.1521257507308;
        Fri, 16 Mar 2018 20:31:47 -0700 (PDT)
Received: from localhost.localdomain (ag026191.dynamic.ppp.asahi-net.or.jp. [157.107.26.191])
        by smtp.gmail.com with ESMTPSA id a80sm15696594pfa.60.2018.03.16.20.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Mar 2018 20:31:46 -0700 (PDT)
From:   David Pursehouse <david.pursehouse@gmail.com>
To:     git@vger.kernel.org
Cc:     David Pursehouse <dpursehouse@collab.net>
Subject: [PATCH 0/1] Fix typo in merge-strategies documentation
Date:   Sat, 17 Mar 2018 12:31:41 +0900
Message-Id: <20180317033142.20119-1-david.pursehouse@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Pursehouse <dpursehouse@collab.net>

Fixes a minor typo in the merge-strategies documentation.

David Pursehouse (1):
  Fix typo in merge-strategies documentation

 Documentation/merge-strategies.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.16.2

