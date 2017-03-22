Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 626B520323
	for <e@80x24.org>; Wed, 22 Mar 2017 16:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760771AbdCVQ4o (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 12:56:44 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34555 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760588AbdCVQ4n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 12:56:43 -0400
Received: by mail-pg0-f54.google.com with SMTP id 21so77431695pgg.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KDBNctez2itQHRn6li6G/LOhyBguuLKrZukakTpgLPE=;
        b=gLLkFicvB4gRvjxyq0l3YhlQ9R31RgtuWI8Cqcl84wdO2+7IayMRVw9o1f9NaOrsC6
         8+iaCdqZLDFtuxNH+q1+FVvOUz4guX8AY653evr7bbKCOuK94OGIvSVya4VbhHDLcrlL
         pM/voip2Mp3Nya7eYp9eROAc4GVPtzHSRDWExlML5VH8zpg+6PiGiGaNtB4FQptO3QIP
         JEqSbBri1FD9VorZlPglVOI3CyXyql0aCn+bBHdS7Gmz+8n1BQ2Ou4LvH2232EmMbP1V
         Y2pfpGa8l7DuLRAdVXh3kc7dbsPK2yhPMIomVyPJFlpVM0CYh2vd4ADpy2PdQKSp63QA
         6XzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KDBNctez2itQHRn6li6G/LOhyBguuLKrZukakTpgLPE=;
        b=W4sEfhWTsGCA6gaBhMEpdTMBIPCypnfYuwKav0RkZpWnZoIIBFmqHM+GBPyzqQ95ck
         AsSqRca/Hv2lYmJ0QUZZd0BI8rWc2RK+XwUwYK3acp0VXctbUgvcRk5tcZvgTt8GGBhq
         xl5JZb7Iem9Pg+e83OezZFAW8ZuIHVqyog54DLhWXKx8V1c50rJ5CkC6OziLrrHYwT5t
         Js8WtdNYwRYFs7MpKivVleFwGy0oNm5MiYRxb1Xko7QAtDQKAg5fiSUrdbswj6HIavKz
         TN66jfWlTM/PmCUcu+gG+UXmMDdgLPtW/ApotQti7Hi2c2kmtK/8RqNgvrCQNC7i54V4
         jJdA==
X-Gm-Message-State: AFeK/H1e4vDATatVNMujFbNR6fiQDOdJrx1bMiHSlqbN55bh/N3hzjyXrrPsxmphOgBxWBC4
X-Received: by 10.98.134.142 with SMTP id x136mr47843746pfd.64.1490201801917;
        Wed, 22 Mar 2017 09:56:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1959:c634:6437:385])
        by smtp.gmail.com with ESMTPSA id 11sm315371pgf.28.2017.03.22.09.56.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 09:56:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] t3600: rename test to describe its functionality
Date:   Wed, 22 Mar 2017 09:56:39 -0700
Message-Id: <20170322165639.21658-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.47.g25804914fa.dirty
In-Reply-To: <20170322010058.GA31294@aiede.mtv.corp.google.com>
References: <20170322010058.GA31294@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was an oversight in 55856a35b2 (rm: absorb a submodules git dir
before deletion, 2016-12-27), as the body of the test changed without
adapting the test subject.

Signed-off-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t3600-rm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 5aa6db584c..e94da6b5f1 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -658,7 +658,7 @@ test_expect_success 'rm of a populated nested submodule with nested untracked fi
 	test_cmp expect actual
 '
 
-test_expect_success 'rm of a populated nested submodule with a nested .git directory fails even when forced' '
+test_expect_success 'rm absorbs .git directory of nested submodule' '
 	git reset --hard &&
 	git submodule update --recursive &&
 	(cd submod/subsubmod &&
-- 
2.12.0.rc1.47.g25804914fa.dirty

