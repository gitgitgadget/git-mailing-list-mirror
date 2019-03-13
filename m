Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C3FC20248
	for <e@80x24.org>; Wed, 13 Mar 2019 10:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfCMKQi (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 06:16:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37524 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfCMKQg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 06:16:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id m12so990748edv.4
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 03:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IfWMkShrQ41KDDbzpbDKXZwOBGskdmyj8PRyBF7JQKU=;
        b=MvyK9PYIyHO7XQIenAvlMA5j4MxYxR4kD94YbAFZcfX9KsiqjtTpU5UNLxusB14piz
         zk0iAt5hvoGnRnlbRluS2pPVZOv8Jw7vnx8HVkNcYbSwtlpyDKvrTp03iJhf5hj9pZEC
         pU6V7BZIQoDJWEdSlIiJcFq3rve7q84wVl77Aga+JTi49tsrdyB+4SPcD8D8lrd2tY1/
         oisw6c7ZlfBQcS4K+43mkkMuoph3JOb4llqR8824P8usVqWcJlkHvjGkvV+CdLKlKLFT
         IIQaQdDsXSYG/gzB4eocGs+hqojQlG6KDWVKHUyPMRAYr6nYE/kwm5TdQWj/7vLdgQxG
         GOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IfWMkShrQ41KDDbzpbDKXZwOBGskdmyj8PRyBF7JQKU=;
        b=ciOhPGwA98rollJwJN8IBoc8gRuAkpiLRWTorNUHmuvOWuPD2hJKOrbnm72TMX8s5j
         u3qYfQbTxYlCMAiQZMqn/SQXKdp7yKkOf69tchrXkMckXANQ907fV7AsMEAHC6mkRP/M
         kKc/r+IdsONGmwPt7BumYIYRt0DhHA2pvTfK2Ub9ai41Mf5ynqayx/dNebvIC45cw8dC
         OsS60pUH95aurpYUbNc/IdWDXBNC7cp06Ivc/dP0L70vlxft7lsZc9+tbBRov9TKf43p
         jwFls48teBkbBg1M9OnzC4siLzKKtbmngF1sGIiGzjmXHU7L0YF/JQ/H81Ft9G5b82ic
         JtDQ==
X-Gm-Message-State: APjAAAX4BbxOmOP8H1j2ug1iQnFByQRw/7KcnSTMO5OuDWKrSADxmtLW
        T2yT6jurLM0PzGWBLWgP+h5iMWId
X-Google-Smtp-Source: APXvYqzIo8HFo0T7Kx1xs4B1gEpSSlKZjgQEuCmYhCKOsBm04bCYnoLmW2rByU/li/8Xp6SNh/0gew==
X-Received: by 2002:a05:6402:603:: with SMTP id n3mr7083185edv.255.1552472193796;
        Wed, 13 Mar 2019 03:16:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15sm479856edl.40.2019.03.13.03.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 03:16:33 -0700 (PDT)
Date:   Wed, 13 Mar 2019 03:16:33 -0700 (PDT)
X-Google-Original-Date: Wed, 13 Mar 2019 10:16:28 GMT
Message-Id: <d749c63170ca5f23f80f8f98816188b237eb648b.1552472189.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.161.git.gitgitgadget@gmail.com>
References: <pull.161.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/4] sequencer: move stale comment into correct location
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index f91062718d..79a046d748 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3641,7 +3641,6 @@ static int pick_commits(struct repository *r,
 			res = do_exec(r, item->arg);
 			*end_of_arg = saved;
 
-			/* Reread the todo file if it has changed. */
 			if (res) {
 				if (opts->reschedule_failed_exec)
 					reschedule = 1;
@@ -3649,6 +3648,7 @@ static int pick_commits(struct repository *r,
 				res = error_errno(_("could not stat '%s'"),
 						  get_todo_path(opts));
 			else if (match_stat_data(&todo_list->stat, &st)) {
+				/* Reread the todo file if it has changed. */
 				todo_list_release(todo_list);
 				if (read_populate_todo(r, todo_list, opts))
 					res = -1; /* message was printed */
-- 
gitgitgadget

