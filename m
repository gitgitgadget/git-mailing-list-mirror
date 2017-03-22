Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2698520323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbdCVWTK (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:19:10 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35427 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdCVWTI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:19:08 -0400
Received: by mail-wr0-f194.google.com with SMTP id u108so28765403wrb.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7yhPumiS5lvLopDXl+3fOLvGSTnbMW+SfPlSKQlIsp8=;
        b=lN82Wcgqxi1nv0lVk7nqDEiopVpoU2aEOkoM4o2rRezA/IMHhO4pPGxV3Kijmzvejs
         C1hMy/VSrF0mStu/KnCMDZ2b/O/Y+UVxr4foDWkknzWItV71fRUsb2FDGZBfzMalvNlV
         6xxCsrI4D/ehpKY4peUFxq3OQv50iMf0yoxh+flwCeyNVg9kXYtfGZ3srkUgDzIUzIsb
         3Drff2glYff9nqmjmzrT5bmw8IGI1GX83LLiwneY7EDoAlhtSbhXC2xdK3EnxlWbacI8
         rQ5eslTwfSmySFaU6K2aBpof4gUaPW5hIeVEaZW4bEwKrjvFP5tqVHWqY4QddK25aoGA
         a6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7yhPumiS5lvLopDXl+3fOLvGSTnbMW+SfPlSKQlIsp8=;
        b=m47b9xrIYTWdaUyt18ao77Lsy2FZs8WhkWIkj0BJZEnTTY3LvQxJTBVPu0Ej8QU0eW
         gM3lCcMsMHHeAED8sA8DAofa+gjCUz5cdqyjVZZuLja7jLQFZYw/b3kStu58isp1tfp0
         VdhnGWHanuRZ2UXaF5l6eN2XuhrVZl72pUpnZproYjWuWKfXPjs0iki53sBugYlR8Zxq
         by5eCsQBnAXJJD2FLoWyEBAYxLJ47cJ2yu3WYD7kDpXJIm5vBgRR/Tg13iDrjBzBdzir
         n2t5vYkZV/Q60h9VC3YEKfkHP3b1lZvA0w+j02BmRV+OsdRS6xCxFAzLuMQK7GHRlfqX
         T/+w==
X-Gm-Message-State: AFeK/H2kIah4kzGJpl/eKF5F8XyN4HW+JOBj9ZA1MKpf/HFQdB539MN2LUiO0goneAh66A==
X-Received: by 10.223.151.45 with SMTP id r42mr36708647wrb.185.1490221146106;
        Wed, 22 Mar 2017 15:19:06 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 190sm1916706wmk.17.2017.03.22.15.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2017 15:19:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] t/README: link to metacpan.org, not search.cpan.org
Date:   Wed, 22 Mar 2017 22:18:52 +0000
Message-Id: <20170322221854.10791-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a link to the web version of the TAP::Parser::Grammar
documentation to link to metacpan.org instead of search.cpan.org.

This is something I added back in commit 20873f45e7 ("t/README:
Document the do's and don'ts of tests", 2010-07-02), at the time
search.cpan.org was the more actively maintained CPAN web-interface,
nowadays that's metacpan.org.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 4982d1c521..a50290c789 100644
--- a/t/README
+++ b/t/README
@@ -471,7 +471,7 @@ Don't:
    their output.
 
    You can glean some further possible issues from the TAP grammar
-   (see http://search.cpan.org/perldoc?TAP::Parser::Grammar#TAP_Grammar)
+   (see https://metacpan.org/pod/TAP::Parser::Grammar#TAP-GRAMMAR)
    but the best indication is to just run the tests with prove(1),
    it'll complain if anything is amiss.
 
-- 
2.11.0

