Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2659D1F4C1
	for <e@80x24.org>; Fri, 18 Oct 2019 22:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391031AbfJRWLV (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 18:11:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32978 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390488AbfJRWKi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 18:10:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id i76so4098684pgc.0
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 15:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=maL13i5pQgo46tW4TDfni+FU/nTl5BeKKSciXlHc0Fo=;
        b=VxtAUHInqCZkLjbqXfxUI9iM3IUJaZV9XUg0RS5Pho3qcZSwQjqeIC3LdAonGt9y5x
         /kUKCfvVpbDqIqxt/95VLLC9QTYRbji0zwgJ+x/YJlYXkHqFqzP23OfVBIi3b/YDR0IO
         A5O9hLH7/I01q6WKNP5KJWzdC2wmyJr5ahvltJYBhsTg/lKmztl9o0w05aCDESlrq0Tc
         PpW63O6HobcH6kBdS+da5jWzQLodmBDHkapk8GOUxB0al0AWM7zKjx0uo7POp+8vKU7F
         zA3KpNrDr6ZWyp4sYuJ9JXkINxBYvQnZqBdk+8ZFLHcAG6b4BLqQO+s5SuiEqD1dpzTu
         zdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=maL13i5pQgo46tW4TDfni+FU/nTl5BeKKSciXlHc0Fo=;
        b=NZsjan8U+YvhobGDl9lAcKYUEenXHWDy6jnrAJ7Z27aginHboe+2sCbCs7PH57XJQV
         p3QIiYr0TmmGKbWzP4jwshyHqg3YAD0J8N5rRqpZTpQKjHZ+M3+w797gAXb3dvxfl/e7
         1gqHkIsGzmUE4HhTzP4qIAXUSs465QY4TueqSG6bqUsh3LxLjF3oXxVjzLsWl32Dc09E
         UecV6m8NgNzY/o7JbL4JnVjy/d4eFdbow9nDbbkLW7wEIz8BLJum/Rbjs+zEmsld8fZ8
         xMUWni/QRIk9BHXnd+cFieGLp5YNFnU5BA0xU92SVtxjFUY1f4mHeEr4UYxiyRHKBHN1
         lIiQ==
X-Gm-Message-State: APjAAAU7QAlfTgeYOKlqAQ3FU0rC0vUgz4o7YtGACCv0Emb9srRtU9Oc
        QwDFZRII/GbTekblL4pPpUuUyS+J
X-Google-Smtp-Source: APXvYqwl9iNu5pXGRSdb6bFQhwbnsBd8o3Zl8vrEvwscySW9z5bAHD875+AKYiWK55A87HacJAqONQ==
X-Received: by 2002:a62:a504:: with SMTP id v4mr8917375pfm.243.1571436637224;
        Fri, 18 Oct 2019 15:10:37 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id c128sm8075381pfc.166.2019.10.18.15.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:10:36 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:10:34 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 07/15] t5520: remove spaces after redirect operator
Message-ID: <830a8212ae78e2bb3f1001dc11cf6ba2edb85561.1571435195.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
 <cover.1571435195.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571435195.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The style for tests in Git is to have the redirect operator attached to
the filename with no spaces. Fix test cases where this is not the case.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 004d5884cd..7bb9031140 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -243,10 +243,10 @@ test_expect_success 'fast-forward fails with conflicting work tree' '
 
 test_expect_success '--rebase' '
 	git branch to-rebase &&
-	echo modified again > file &&
+	echo modified again >file &&
 	git commit -m file file &&
 	git checkout to-rebase &&
-	echo new > file2 &&
+	echo new >file2 &&
 	git add file2 &&
 	git commit -m "new file" &&
 	git tag before-rebase &&
@@ -542,10 +542,10 @@ test_expect_success '--rebase with rebased upstream' '
 	git checkout copy &&
 	git tag copy-orig &&
 	git reset --hard HEAD^ &&
-	echo conflicting modification > file &&
+	echo conflicting modification >file &&
 	git commit -m conflict file &&
 	git checkout to-rebase &&
-	echo file > file2 &&
+	echo file >file2 &&
 	git commit -m to-rebase file2 &&
 	git tag to-rebase-orig &&
 	git pull --rebase me copy &&
@@ -591,7 +591,7 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
 	test_config branch.to-rebase.remote me &&
 	test_config branch.to-rebase.merge refs/heads/copy &&
 	test_config branch.to-rebase.rebase true &&
-	echo dirty >> file &&
+	echo dirty >>file &&
 	git add file &&
 	test_must_fail git pull &&
 	test "$COPY" = "$(git rev-parse --verify me/copy)" &&
-- 
2.23.0.897.g0a19638b1e

