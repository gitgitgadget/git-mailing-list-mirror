Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5C711FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 15:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966005AbdCXP2G (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 11:28:06 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34301 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965995AbdCXP15 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 11:27:57 -0400
Received: by mail-qt0-f194.google.com with SMTP id x35so841340qtc.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v/H2r/9NX07P8p4zRAqqgb3Q6SQqeRCtjP2fd9KEPmA=;
        b=rM7Qw0ZqGGnBr8jGws3dDfkHmH0OK0s+10w5MQI54ay5gK4aYP3ySmQPxYY9pg8CbJ
         uM0dQ6J1xROLZaWelQ9JFY+jFpipyJFGy4BYKeQAsT/UGhdUEfFtGqjAdLoF6LT+V7uR
         QMwvToTQyTlc6cGRJLf5DUiy/8pPWka5FsqK7cpfy9YWu3La9UKJp+cUt1sxvwigNnxH
         VBxukap13dKAaas9Va7ZZ/YhVsashshLjuFgdM8AQ3NVoZufXBFY7ES99LbRR9lSi23t
         O9xqFPxI67tBPetXXg199c/pX4bs4z9qKv3aMdvneaJLLsFPD+h0/bbU+y1FegiEGlTf
         3JgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v/H2r/9NX07P8p4zRAqqgb3Q6SQqeRCtjP2fd9KEPmA=;
        b=c0lFEBi5rloZNvBbWgIvZqpoN5M0YqFWJbCMtnOpOdW9McAw2yYe6zBOrLp7Ayj29E
         cRrgSgbWP9+uS6dn3CFK4S8AXXpzKXupash8vPW2GOpJgv8RdbsTp53FZRcFuLIi55sH
         I8z96fptwGSBbQWyFFDjUjmfQS0AohXql99XsA6Yfw0Cq8zZzEtYgua3NJ1UvOg9+Ynd
         7D5r+zURq+iCMvZlKtmZAoonJz9+lW3Jeo5shyBbMhXbkMiZv0ApL6DQuOTCX7cBTIbm
         L/moH9UOGnm4biHBEIguJIijvUZRVtccAjqNELVm2rJ85Z40/WKsmYYwtI5K0/SrRuJK
         htiA==
X-Gm-Message-State: AFeK/H2D5tsp8wH9SFIddaVs1RU0BBslRu7XzOe6wg9q/hPRyahxwUgaKjCx9P5snopgsA==
X-Received: by 10.200.50.165 with SMTP id z34mr8001754qta.205.1490369265599;
        Fri, 24 Mar 2017 08:27:45 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id d23sm1717589qta.32.2017.03.24.08.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 08:27:45 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, christian.couder@gmail.com,
        larsxschneider@gmail.com, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] Git 2.12.1
Date:   Fri, 24 Mar 2017 11:27:26 -0400
Message-Id: <20170324152726.14632-7-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.gvfs.1.43.g876ba2a
In-Reply-To: <20170324152726.14632-1-benpeart@microsoft.com>
References: <20170324152726.14632-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/git.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index aa895da4a5..25560f69ff 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -44,9 +44,10 @@ unreleased) version of Git, that is available from the 'master'
 branch of the `git.git` repository.
 Documentation for older releases are available here:
 
-* link:v2.12.0/git.html[documentation for release 2.12.0]
+* link:v2.12.1/git.html[documentation for release 2.12.1]
 
 * release notes for
+  link:RelNotes/2.12.1.txt[2.12.1].
   link:RelNotes/2.12.0.txt[2.12].
 
 * link:v2.11.1/git.html[documentation for release 2.11.1]
-- 
2.12.0.gvfs.1.43.g876ba2a

