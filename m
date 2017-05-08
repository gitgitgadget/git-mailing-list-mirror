Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42E861FC44
	for <e@80x24.org>; Mon,  8 May 2017 21:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753067AbdEHVeA (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 17:34:00 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34478 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752908AbdEHVd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 17:33:59 -0400
Received: by mail-pf0-f171.google.com with SMTP id e64so39034798pfd.1
        for <git@vger.kernel.org>; Mon, 08 May 2017 14:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=HC8mdLuUM14nzeP38d8HspOtF9qtxk7ybXzNYALjrek=;
        b=E4jQTBq9WwhyYUel1Jy3sHeHk8mrHI827jKRLXqS2ZK4EZ8Le5Jo6ZeMoGfMIvIbBT
         5znJmeV4YtRSIUvkRy+5fnqPvI7Xai7G2EYvKwURUJ6rudKsT+e9gsfhZ5Ds9MDGEhwj
         r0A0uyAL1H3FnnIDbaWKIw6+2Pt9QGUG7PL0Mh4aZg3Ed8doDaNYZ7jny/e+Y1fi1qrm
         QWjCYd10P3hcNaqLHqmywNYBMwzlMuRsgnePgCEWBA8LYxlBJmxKAOfC6m7YBFuW0W/1
         S94sNL3hcbqOPcjKaQ2EUFsehPBFNhB9v9P7w5iYu1UWbS9jkoVTlnzUvj+llQizKOfs
         Mr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=HC8mdLuUM14nzeP38d8HspOtF9qtxk7ybXzNYALjrek=;
        b=O11w+s4y+Y0H2E7IUqTV60XirTTbQFMWtCI9RwyuuTzZF3FrKb9pjww31HWBLQMj16
         1taTKSn4Aj4nErTqLLur/NlcZ40LD1sWfwjgL849Yq6hEXlmPFkJYdy116ZHysKDsDwS
         H9xZQja6s/dkrh6A3B/k65ZsO9BStrHPv7yUFr7VoFDbcNhqhx5+FLdpNA84s4xL4OpG
         dxoX+OqkiHMShR2Pcn5PmWmHMqkSSRczz2YmHhbnKzZ3uigud77UUtyra9hc0GAV7WYM
         wFPFcRZ0GjB4zX/wARzPfzzjFDBmUN7ilsWXIxVenFw0OFvIFv23XnJnAojLT7xLQ4ZX
         C4Lg==
X-Gm-Message-State: AN3rC/5YBehtDjrLqtSAn121hzvSo+2y87do6kjMLbbcurEKCHstZ5d6
        b9/oL8nZ6eSCQ/C9
X-Received: by 10.99.178.90 with SMTP id t26mr20430320pgo.136.1494279238643;
        Mon, 08 May 2017 14:33:58 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id c196sm11229854pga.23.2017.05.08.14.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 May 2017 14:33:57 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        sbeller@google.com, gitster@pobox.com
Subject: [PATCH v2 1/2] docs: correct receive.advertisePushOptions default
Date:   Mon,  8 May 2017 14:33:50 -0700
Message-Id: <3d79124df1e235e1819cf16a41ecec27391f8609.1494279020.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <cover.1494279020.git.jonathantanmy@google.com>
References: <cover.1494279020.git.jonathantanmy@google.com>
In-Reply-To: <cover.1494279020.git.jonathantanmy@google.com>
References: <cover.1494027001.git.jonathantanmy@google.com> <cover.1494279020.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit c714e45 ("receive-pack: implement advertising and receiving
push options", 2016-07-14), receive-pack was taught to (among other
things) advertise that it understood push options, depending on
configuration. It was documented that it advertised such ability by
default; however, it actually does not. (In that commit, notice that
advertise_push_options defaults to 0, unlike advertise_atomic_push which
defaults to 1.)

Update the documentation to state that it does not advertise the ability
by default.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/config.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d5..3a847a62e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2620,9 +2620,8 @@ receive.advertiseAtomic::
 	capability, set this variable to false.
 
 receive.advertisePushOptions::
-	By default, git-receive-pack will advertise the push options
-	capability to its clients. If you don't want to advertise this
-	capability, set this variable to false.
+	When set to true, git-receive-pack will advertise the push options
+	capability to its clients. False by default.
 
 receive.autogc::
 	By default, git-receive-pack will run "git-gc --auto" after
-- 
2.13.0.rc1.294.g07d810a77f-goog

