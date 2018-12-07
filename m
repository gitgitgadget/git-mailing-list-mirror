Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 157FD20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 20:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbeLGU43 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 15:56:29 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:34184 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGU42 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 15:56:28 -0500
Received: by mail-pg1-f182.google.com with SMTP id 17so2230615pgg.1
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 12:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Boc3OYBPuJcLYAbSGATGUC/4fPhOLVDX+u/i20C4Oc=;
        b=gGVcqceaglXJQhINsmYHB4lj0zB3VajeHz+gLn8Ei6hJATTfBzPTobDmC1KmydUdij
         tz1Sj00CGOuxEH65BUsjor+V2wvQ/b/UPhM9t1lHaCQyFE3wObomNpyQUZ+9vLDmBDqr
         GfjbCshkRWKx0Df4UuxWkHkSD4KTePf2yUFsha1ZAN5fpkprOV0X67cu/2TlsmRNBu1A
         fJQZOr/VarJd6JGyu2hog3EWh5T6dmyOZZ/wPm7vUSmCT0Gerqb6eS14lYPwt9K8owz6
         q2toMUkpP1Dbj9ri0i1KJLyuxT8CsL0Uw9ygpJKg7A1lYkdRcteSRkwfVxzfXwyPPZy6
         cT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Boc3OYBPuJcLYAbSGATGUC/4fPhOLVDX+u/i20C4Oc=;
        b=N0yXSfvZXs4DtWnTo3BjU28mgINFifluaZBYp8kZkz3dKmkHm/w+JZbmUXNLiTdZ/i
         E8EHOnPoffnUyQpp+IcQa9Deb9VUhJ8V/VkFtbEKypn7wOjsyRCE9nucTmweIubPtAZ3
         xWUiQNn1NvDQTJjV5JK23HFi12EAHKYQLB15sinHbEjKQFHpe9BCUzO+LP2fbH4+2C59
         nanBSgn7YbAGE/CBYGjAlSbJSmMamYEk3w++WsxLqABrTxUOZBXYbqWMZvqXxJJ2O036
         IlnpMHnLk9xsY705UGso415zYvqZoPIVjqdlf+e9Ig5Ftvq/f4GfIjKtP6/hRdrRwSdb
         ZoaQ==
X-Gm-Message-State: AA+aEWYmh3fWLzMht/D87zugd0F4Ewwwui7MS9O93Aai8+vQXm9B1Vk1
        kHp0CKIpXiE17NqqV8syRZcbe2x+
X-Google-Smtp-Source: AFSGD/VXgwtrZYR45uWZ36d1Pr3Tt5YYCrR36yh7dB63VXARLKZRv4IhNqz7YJ3eWWzEQlGHScberQ==
X-Received: by 2002:a63:fb10:: with SMTP id o16mr3255035pgh.211.1544216187707;
        Fri, 07 Dec 2018 12:56:27 -0800 (PST)
Received: from bmwill-mbp.thefacebook.com ([199.201.64.130])
        by smtp.gmail.com with ESMTPSA id k26sm8545529pgf.65.2018.12.07.12.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Dec 2018 12:56:26 -0800 (PST)
From:   Brandon Williams <bwilliamseng@gmail.com>
X-Google-Original-From: Brandon Williams <bwilliams.eng@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bwilliams.eng@gmail.com>
Subject: [PATCH] mailmap: update brandon williams's email address
Date:   Fri,  7 Dec 2018 12:56:21 -0800
Message-Id: <20181207205621.49961-1-bwilliams.eng@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bwilliams.eng@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index eb7b5fc7b..247a3deb7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -27,6 +27,7 @@ Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
 Benoit Sigoure <tsunanet@gmail.com> <tsuna@lrde.epita.fr>
 Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
 Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
+Brandon Williams <bwilliams.eng@gmail.com> <bmwill@google.com>
 brian m. carlson <sandals@crustytoothpaste.net>
 brian m. carlson <sandals@crustytoothpaste.net> <sandals@crustytoothpaste.ath.cx>
 Bryan Larsen <bryan@larsen.st> <bryan.larsen@gmail.com>
-- 
2.19.1

