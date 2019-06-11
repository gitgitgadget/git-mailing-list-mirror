Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 627261F462
	for <e@80x24.org>; Tue, 11 Jun 2019 23:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408123AbfFKXbn (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 19:31:43 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:48396 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404692AbfFKXbn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 19:31:43 -0400
Received: by mail-pf1-f202.google.com with SMTP id u21so7545903pfn.15
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 16:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=o+J3IOknk86VKO2klkj8QJqhfOdxbMbsIKsJCyqwFUE=;
        b=vtejCj2Vqhr9ANEoxxL7GY9hGxeNM1bVufZhMaXVqRgvaqlaF8sZN1tZnpv+rIgOn7
         /S+BL0FPxGFn4Xtvd+/RdzMtt4I4p0WJixQ0nXl4wWQwsAN5Yg1lzG0DOx6ULrbjbQCb
         0aEJ6kDBjWwDy4+UWe3i/H+dEU9Xlr7lein2SVAr6Qn1NiB1N5KwhVzpiYSuZiOFcYVm
         F9jDxyI14r0RJEj71++GEIt5/PG6k/NFTjtJDANnA5EX71pLWZcjeILQofYmgPMaRLs5
         FfugNnsdrKQpjykxxJtzrQCiciXH5SVYO3vlXtrLm9yu+H8d84vE87a6Ektenn75XasX
         5NPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=o+J3IOknk86VKO2klkj8QJqhfOdxbMbsIKsJCyqwFUE=;
        b=SWSFEJV8zMkOqItru9Kv7CMnxJN4drw6rR6YX2bLiVmYzmq0EDmcOBjP476uWkX1xW
         vH8dzDvBDEa7SEo4R31b6UhYBLM8rgU55kf09BlCR8moBdxc4btDHAAmNuA2b38cmM9Y
         TkJcjdcz70aEhZzTMLX8PGZ1D0dw9/NMdfIQTmDOtVAwXkScJILDaNz5kDaRBH7HQmIq
         ktQLytEyFxUaEPtw9p7BrhI12jmAWcQcuy6q7J+MicjCP/stWtLdA5VmAvACqs3UWtJK
         P3b8iPqqc7i43g/A8z7EQdYl74TwbovdbLzyP337aBBpoYi0Wrke7OJEkY8XAvFFuTbD
         JPyA==
X-Gm-Message-State: APjAAAWZNdhqDZr7k3Fg1+GW1flquj6zzzOd4NEeoF+w6RnHEXHaGh1k
        C8i7jb4ukbuN2H5exF+yWfm8H77ywU+kjMnbTbLDDuFxmA899TSXEK+zKOZr+ZLu6gTgikehv5C
        Dki5YjFN0D69j+B7wkTwqE3Mqb5lqrP8fGA7Aj0K36vdqB3dD42++yHFYksYHl/I=
X-Google-Smtp-Source: APXvYqwo2gZDjJ1OudIbJkXpNX1BJ+TbSfqUBZxtHpuwYmY6OLZzhczLv+pvDTotdc8uSLAKg9DIA02rXsQq+w==
X-Received: by 2002:a63:2ad2:: with SMTP id q201mr21438463pgq.94.1560295902011;
 Tue, 11 Jun 2019 16:31:42 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:31:35 -0700
In-Reply-To: <cover.1560295286.git.steadmon@google.com>
Message-Id: <8bcd72a762f0fd349f8bf7d0b134cc7033ae6f00.1560295286.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1560295286.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH 1/3] trace2: correct trace2 field name documentation
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct the api-trace2 documentation, which lists "signal" as an
expected field for the signal event type, but which actually outputs
"signo" as the field name.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/api-trace2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 23c3cc7a37..fd1e628944 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -668,7 +668,7 @@ completed.)
 	"event":"signal",
 	...
 	"t_abs":0.001227,  # elapsed time in seconds
-	"signal":13        # SIGTERM, SIGINT, etc.
+	"signo":13         # SIGTERM, SIGINT, etc.
 }
 ------------
 
-- 
2.22.0.410.gd8fdbe21b5-goog

