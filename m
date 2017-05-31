Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ED831FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbdEaVqP (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:46:15 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33422 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdEaVor (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:44:47 -0400
Received: by mail-pf0-f182.google.com with SMTP id e193so18618590pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HtfkjQi1WljzQYDkAHN5HUKAcwafPkPG/D181fXMwz4=;
        b=az45aCK6siMNYJNdZ1KLVpdphg3eG9sieanEs57o/OklByJMCVU9fNZ2gtH8hDfR7b
         JBgdP0KfUqhhMVLKxnmIT0Ck7dA2OF1LS8sRR4dEoGuctnqrkAy2hbuV5YORE8qHP4yT
         H54Ob0Qn40zvqhzuuRFeNZMjw7RcK6fkzoFpDlFnZMAk6yle1eB4ukvdPGXrrByjh+2o
         AWuT8LkMSSsopo6O8ipfLtw1G+c73ORXxOXlrTKvcel3DEJzcz1CX0pnTgMuLNV2X8oB
         anjX5r0J+DCSStSwKHor7sTg7ZyiVvLyYWCL7/4o+u02QJNlMKCb/id1hJI4BeBIdj32
         iATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HtfkjQi1WljzQYDkAHN5HUKAcwafPkPG/D181fXMwz4=;
        b=Xr+qHGN/9Xc0oafSpNlE7Tfe9fa5h6zg9tdqHFwIqBCzVNrC5iXTezcdUF3iFQt1PL
         sw1NSsmKUT50+hx+Is/RAToKCxym6pE+yj+WafFqVDa+q4ljORS9Eg6R0y4o7rycn24B
         nmvCO35X9Zztqql0gZ+Z8YxffGiM3Y9DXjIiSdt8SSHbWfxKP4p2epyPikwjhoURkAs0
         BkArSw32lNouT2rJnUzyxPlB3YiZXVOwN41ItPBM7vqtkXYhEGmvjRQp8XBm8MLr4YN+
         T+M8WHeHtvLAcNel1UBToNobebWGG7TeWz78OEtAR+XPSx+4zTlSwbhY/2XVy4HQqoF8
         WlzQ==
X-Gm-Message-State: AODbwcCgQJz16H3F/I3C0W7f7KZWfaaQuSYQkK03c3WkIHEwhZEBetCB
        tuurRSeNeAFodx0hPt/BhA==
X-Received: by 10.99.124.75 with SMTP id l11mr34931378pgn.211.1496267086168;
        Wed, 31 May 2017 14:44:46 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:44:45 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 09/31] setup: add comment indicating a hack
Date:   Wed, 31 May 2017 14:43:55 -0700
Message-Id: <20170531214417.38857-10-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'GIT_TOPLEVEL_PREFIX_ENVIRONMENT' was added in (b58a68c1c setup: allow
for prefix to be passed to git commands) to aid in fixing a bug where
'ls-files' and 'grep' were not able to properly recurse when called from
within a subdirectory.  Add a 'NEEDSWORK' comment indicating that this
envvar should be removed once 'ls-files' and 'grep' can recurse
in-process.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 setup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/setup.c b/setup.c
index dba3abd00..c3d21345d 100644
--- a/setup.c
+++ b/setup.c
@@ -1057,6 +1057,12 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		die("BUG: unhandled setup_git_directory_1() result");
 	}
 
+	/*
+	 * NEEDSWORK: This was a hack in order to get ls-files and grep to have
+	 * properly formated output when recursing submodules.  Once ls-files
+	 * and grep have been changed to perform this recursing in-process this
+	 * needs to be removed.
+	 */
 	env_prefix = getenv(GIT_TOPLEVEL_PREFIX_ENVIRONMENT);
 	if (env_prefix)
 		prefix = env_prefix;
-- 
2.13.0.506.g27d5fe0cd-goog

