Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CDFA1F51C
	for <e@80x24.org>; Sat, 26 May 2018 11:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031782AbeEZLf3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 07:35:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44004 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031606AbeEZLf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 07:35:26 -0400
Received: by mail-wr0-f193.google.com with SMTP id r13-v6so13183381wrj.10
        for <git@vger.kernel.org>; Sat, 26 May 2018 04:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gXmfUWzHrR5CWBAYF21BPddzNe4N6DibEOEJO8kfBRs=;
        b=bl8tRoSS8nB0UNRtN9aZFFqaGHdyn2hwLCh6PWH2dNUyud938Gi+2vY2NGXWW/rxeF
         yTpXt7JG/zj/YpYkQ1bxfPc2lfrgdXH8QGv/CLUZo+KtyE1I49ONP+kjS5i6ZzQ6e+mR
         1YdxEfTR9pBmESAQiMVjzhVpQ+650Z0dZ4ZXbanU1fEXR0YiLpVjOT5LVRPA4ib+5Fo/
         vQpBefCeqbfPNktDQzBJx4Qmonxyk1nRLFw33uG1YnRxvXRqcstoRcRFJ5xIu268jFAV
         SUSLiXH9EJ4G+8Hrd+j3PJ0lICO5DpJpIAr0UjnB8QeizcEomk0hVBwLOs2r2mZYQPfV
         hDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gXmfUWzHrR5CWBAYF21BPddzNe4N6DibEOEJO8kfBRs=;
        b=haDQ2FVxgBqFLbwQ8zwqw9hOJ8CIisuREIdsJKcgusU8W14ZjLP6OLbBDvxRUrWW3c
         m6Fj0knyt1s6cbVxyQNe4hhJ9qnn+rXOTGcJjtlGgLo6qQB1hk5MVOdWRvneCzbj3FTT
         OJRIVUpe4yVsYAuh96KYCJmGjMTRTPte08gUP1oc3Hpnh1grn5B4uFhQqa8jtqJh75A4
         J3T0O8s1gSGpdK+qBpCUkZuZH0Wz+EJ+Ip+at3khwwujukKYOeSXC7QGafzHhx1C+sQA
         vZEEB8XgOT7fx0QGdVuUVOa4/JUaOpIomGk6w8INddryhZ5nx0QmkYJ4P/SVuR7BzUK1
         +igg==
X-Gm-Message-State: ALKqPwdnNc+g5p0jabK5dg4JWoo9gSpn7UIOgzvIepzhactYJ6K/y1gl
        pnumdmEMzg0WzD3Cgr2O5ml78A==
X-Google-Smtp-Source: ADUXVKJtjKsR41GCDlDS1+oknN0+vWLo1QIz1h7pVraM5vY52h0M11gMMgfSKadkTpGtFMHfseRsDQ==
X-Received: by 2002:a19:6a08:: with SMTP id u8-v6mr3477364lfu.31.1527334525175;
        Sat, 26 May 2018 04:35:25 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id e28-v6sm4759370ljb.92.2018.05.26.04.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 04:35:24 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     a.krey@gmx.de,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] upload-pack: reject shallow requests that would return nothing
Date:   Sat, 26 May 2018 13:35:18 +0200
Message-Id: <20180526113518.22403-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180522194854.GA29564@inner.h.apk.li>
References: <20180522194854.GA29564@inner.h.apk.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shallow clones with --shallow-since or --shalow-exclude work by
running rev-list to get all reachable commits, then draw a boundary
between reachable and unreachable and send "shallow" requests based on
that.

The code does miss one corner case: if rev-list returns nothing, we'll
have no border and we'll send no shallow requests back to the client
(i.e. no history cuts). This essentially means a full clone (or a full
branch if the client requests just one branch). One example is the
oldest commit is older than what is specified by --shallow-since.

To avoid this, if rev-list returns nothing, we abort the clone/fetch.
The user could adjust their request (e.g. --shallow-since further back
in the past) and retry.

Another possible option for this case is to fall back to a default
depth (like depth 1). But I don't like too much magic that way because
we may return something unexpected to the user. If they request
"history since 2008" and we return a single depth at 2000, that might
break stuff for them. It is better to tell them that something is
wrong and let them take the best course of action.

Note that we need to die() in get_shallow_commits_by_rev_list()
instead of just checking for empty result from its caller
deepen_by_rev_list() and handling the error there. The reason is,
empty result could be a valid case: if you have commits in year 2013
and you request --shallow-since=year.2000 then you should get a full
clone (i.e. empty result).

Reported-by: Andreas Krey <a.krey@gmx.de>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 shallow.c             |  3 +++
 t/t5500-fetch-pack.sh | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/shallow.c b/shallow.c
index df4d44ea7a..44fdca1ace 100644
--- a/shallow.c
+++ b/shallow.c
@@ -175,6 +175,9 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 		die("revision walk setup failed");
 	traverse_commit_list(&revs, show_commit, NULL, &not_shallow_list);
 
+	if (!not_shallow_list)
+		die("no commits selected for shallow requests");
+
 	/* Mark all reachable commits as NOT_SHALLOW */
 	for (p = not_shallow_list; p; p = p->next)
 		p->item->object.flags |= not_shallow_flag;
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 0680dec808..c8f2d38a58 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -711,6 +711,17 @@ test_expect_success 'fetch shallow since ...' '
 	test_cmp expected actual
 '
 
+test_expect_success 'clone shallow since selects no commits' '
+	test_create_repo shallow-since-the-future &&
+	(
+	cd shallow-since-the-future &&
+	GIT_COMMITTER_DATE="100000000 +0700" git commit --allow-empty -m one &&
+	GIT_COMMITTER_DATE="200000000 +0700" git commit --allow-empty -m two &&
+	GIT_COMMITTER_DATE="300000000 +0700" git commit --allow-empty -m three &&
+	test_must_fail git clone --shallow-since "900000000 +0700" "file://$(pwd)/." ../shallow111
+	)
+'
+
 test_expect_success 'shallow clone exclude tag two' '
 	test_create_repo shallow-exclude &&
 	(
-- 
2.17.0.705.g3525833791

