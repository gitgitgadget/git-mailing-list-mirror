Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28A2120248
	for <e@80x24.org>; Sun, 17 Mar 2019 15:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfCQPYW (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 11:24:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38444 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfCQPYV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 11:24:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id v1so4922744pgi.5
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NivD/tZZ5tt6KvOTJM1WjCiXRgiIyw9yS3YXw6UaOeo=;
        b=Dx/Erer8ddoP+ojMnQcKlV2mYI4i/ZMZdqdxAvSFRlV8nbAWuiuq+MUyK16J3OLW3d
         WiLA2sBk4p3t8XhkOtdylcR0V07PsAg9ugujVGS+d9RtJZdIBWsVmIPDaovP7joCzyg/
         xQw8qb62uSy8JaGlX4DsLiM39SmgcppTMKGgkfC/x9/blQer5NGIHQ0ZYkNdAmZGxySg
         rfLdep8C246M6LNnT1wRoGfDEQhhzkMDTQyOqJA2lq/iJIKjsTg+j8FBDCnn5r9MMcOb
         wYedXc5bFbKA5U+GvPWeMZ+oFyyew/IgK+JO8KG9eM+7mYTuIlMC1X39q6JUZC+JJ2a1
         CgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NivD/tZZ5tt6KvOTJM1WjCiXRgiIyw9yS3YXw6UaOeo=;
        b=aEQa9bp9BAlqUI3QckZEcoEKFEEGi4yrgWyg64bgYmueatrQ/lA1Ji2x63L6hh8fLz
         oHoqRA8zJgzIftsPNEVXXqVg8ZAS2Y65MDK/PSNbv4zPRx4UnaytegxCEAIjYombLatb
         O2f1bzb5EDtjfzsO+oaoOdJF9b1ROPTMVEm0S1j8wQsJLz+B57bVzBcxHBuU58Kkj3sF
         YiiWEU0RSX5A2GC7/Q9pAY+T80X4DrMeRNqZxy9ZlgOOJrocvt/BUbs23GDfLIX074r5
         rSJrXAUZ6ge+X8rXKop2PyjVmbZV7igERtEVsHiMktJPqfXDQbguCutbTFc2lVKedPy3
         RWfw==
X-Gm-Message-State: APjAAAWfuCAHehCvzRZ9Lfe4S0+s0LYzGyufy5kj/0O1uVpO85b5fyFw
        kX0Dt0hDln24HFYFxZS+f0LZ+CKb
X-Google-Smtp-Source: APXvYqwalk6kICH5bROtfsYrUsn8po63Uuo9T0E89D+v4wSJ2mLM+FY24Ax969h6nclQHCSEWn0MZw==
X-Received: by 2002:aa7:91d7:: with SMTP id z23mr14676192pfa.137.1552836260782;
        Sun, 17 Mar 2019 08:24:20 -0700 (PDT)
Received: from localhost.localdomain (cloudream.m3.ntu.edu.tw. [140.112.244.5])
        by smtp.gmail.com with ESMTPSA id z15sm10357978pgc.25.2019.03.17.08.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Mar 2019 08:24:20 -0700 (PDT)
From:   Jonathan Chang <ttjtftx@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jonathan Chang <ttjtftx@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [GSoC][PATCH v3 1/3] t0000: fix indentation
Date:   Sun, 17 Mar 2019 23:23:36 +0800
Message-Id: <c3c231d117604faa167acc75d21738fc97435cd5.1552835153.git.ttjtftx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1552835153.git.ttjtftx@gmail.com>
References: <cover.1552835153.git.ttjtftx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix indentation of a line containing a pipeline to reduce the
noise when refactoring the pipeline in a subsequent commit.
This has been wrong since the refactoring done in 1b5b2b641a
("t0000: modernise style", 2012-03-02), but carries no meaning.

Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
---
 t/t0000-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index b6566003dd..53821f5817 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1132,7 +1132,7 @@ test_expect_success 'git commit-tree records the correct parent in a commit' '
 
 test_expect_success 'git commit-tree omits duplicated parent in a commit' '
 	commit2=$(echo NO | git commit-tree $P -p $commit0 -p $commit0) &&
-	     parent=$(git show --pretty=raw $commit2 |
+	parent=$(git show --pretty=raw $commit2 |
 		sed -n -e "s/^parent //p" -e "/^author /q" |
 		sort -u) &&
 	test "z$commit0" = "z$parent" &&
-- 
2.21.0

