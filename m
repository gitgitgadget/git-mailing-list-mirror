Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B824320248
	for <e@80x24.org>; Sat, 16 Mar 2019 22:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfCPWZ6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 18:25:58 -0400
Received: from mail-yw1-f47.google.com ([209.85.161.47]:38106 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfCPWZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 18:25:57 -0400
Received: by mail-yw1-f47.google.com with SMTP id m207so10127566ywd.5
        for <git@vger.kernel.org>; Sat, 16 Mar 2019 15:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :to;
        bh=ln3Z83jUUB0rH7pwIJi52UM4/+QhVbLWekZXDDUf1V8=;
        b=TFlvZbXTUdKQEia8yniVGJ2hitfZiwuBxdYs6Gkz0dW7ZvgDJH6F2Q6HRb/B3f63ep
         nvLlxhpf6gE2D4mbXv3K+voUc3YwBlKefJ7hv0WB0i6X2LsMC3pXUJAA1NSKWzuHAtq/
         wb54NvlomYoqCoZYtgjAdmkifpdfgJVa4twxYq87qtkboStSzYE+CxQfi+IJImaoX6qW
         /lgWLHNzkm/gZMu2orthzqQQssOvb7TkLRNDxEq+DQUuUB4PctJ+wqZ9/oU4bfM3DHgt
         rCnNFkXrJo2xC3TWTohQgYcLJ0/0CUs/1jErEzNH74eZSBvnVGKiaTmmzHY/l4ov7cea
         0NBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=ln3Z83jUUB0rH7pwIJi52UM4/+QhVbLWekZXDDUf1V8=;
        b=rIjIW74s+tbmRP6gyf1BGuz94AJBiWymNjfV36gfD2tw6pqrujdECkVh1gkLLZfjRj
         iDpLo5eih/8EH259tv2lO8bMULbFhVvp0DhhwgbqKTRSBbTEcylrWHx8qth6Q7Ood6DL
         Hvxe1WNDfpbj0x8h3InkqFLOXIo5VBZZYarTEN6CITrNjFKzLrDJcgykixZEBdsN8dl9
         BmahQXesDxm3IumL8627ae+O+GBKqd+8AznMPBen8Yskjq7iJ+uFFhzGUG1I27JGpA4u
         W8r3G9fwxYOXwm8P5r2JvKHldhmoCjnS4i+abziQSosKDqPOWg3VyEL7q+vuaQXNWS4C
         B3fA==
X-Gm-Message-State: APjAAAUjN1yv5k2yWZgP9J1kPLA9gMmLmDq3Yumdq4YzGGr972O40z1Z
        An24MBbwG/fXF8xul5IFRe4EN04huuE=
X-Google-Smtp-Source: APXvYqy1N0exs5GeIB6b4UzUHHS1+9WtAYRF0T4Dk5I9PRiitUY1b6KsXNssY8c0K+rlUnHcGw1rmw==
X-Received: by 2002:a25:13c5:: with SMTP id 188mr8578656ybt.473.1552775156167;
        Sat, 16 Mar 2019 15:25:56 -0700 (PDT)
Received: from ?IPv6:2605:380:32:495:43f1:a1::c82? ([2605:380:32:495:43f1:a1:0:c82])
        by smtp.gmail.com with ESMTPSA id i126sm2148289ywa.29.2019.03.16.15.25.55
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 15:25:55 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Linda Brinsfield <lindabrinsfield26@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Sat, 16 Mar 2019 15:25:53 -0700
Subject: Help
Message-Id: <35576C60-5134-46FF-AED6-D422898DFBE1@gmail.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (16D57)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone this is my new phone and number
