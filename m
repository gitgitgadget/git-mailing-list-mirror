Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5A3C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242427AbiCJNgi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiCJNgg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:36:36 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D776814E958
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:35:35 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t11so7994951wrm.5
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DslYQt5BkcLyb5LoNBlecDCHb+pJGhV0+D+lBlrZAKc=;
        b=ZcvJU3fqHxQdhBXN6NJDB9LapXI2V46eFYaxLOqxrW+NnWJBiZbqYQQQgXiwnrnoVT
         VFkq9WAVjEYsQu7tMmvXfT7yIfUT2CIPLqNdOpQDkM4rPCkqrB6hDwBYOTgNnnQYa3kq
         BMq8ywlWTlxxFfTSBOeLQQTM+ATs/Gd433DFDPhXHMFbklxR5HpjTdfM79r2NrGWEdfZ
         K2uLzIdLIf5rExXGxpwTXxFCyXhIoZgjyOtwbFw2sFcTKQjapuE5Apuasyae8/N+kEiM
         xZroqr/P1caNlgyE64DKDDUgi9NWcyWTRNgNpo7bzQedNLElwKc33vFI1kAeDmSQXQ3N
         A3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DslYQt5BkcLyb5LoNBlecDCHb+pJGhV0+D+lBlrZAKc=;
        b=CIClgRFnQma2UOwsbzDzN5CLi4dIpXy2HPaWLJ4GUQrmGeaZV3ibCMclXQfM67v58S
         F1oEtwJxInQYlmluFlVi/cnlRLvMFLzwzLiF7+qU0mHNGfqpDJh/p30LT8E6BkomkKpu
         oTI1ISrdv5lhqSAOXJDDVtI1M4eROsjglR1STkA7PPBqKmKr6JcdV7/42/oqg4Zq5Khn
         Dght027BeCr138WZe6yT4qeQllZjvgqlGgffiuGmLjveTof+bjMGuo8uoy890REA7Zoj
         IB0LmMgWu8eLvjqrb8zeLj3s3er0uJQRa7aMcup1F+YglS1NpFbl1eAzImW3hybNp9ek
         7pGQ==
X-Gm-Message-State: AOAM532C1w51I1fwRY9R9bl5HnZ+LKE9XT8wZjfbMdof/mH8REQapOwP
        R/tc1OV++T2IBzS7jrOTXzjowzXCcRU=
X-Google-Smtp-Source: ABdhPJynpnllc0k38VdXIUoQZn6lykInmuF9Rxco32GTBARw8rg/+KMUlgE6tAvaIn517g/IfTKEgQ==
X-Received: by 2002:a5d:4bcc:0:b0:1f1:d6f8:89f5 with SMTP id l12-20020a5d4bcc000000b001f1d6f889f5mr3576417wrt.713.1646919333755;
        Thu, 10 Mar 2022 05:35:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c4f4900b00389e8184edcsm687908wmq.35.2022.03.10.05.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:35:33 -0800 (PST)
Message-Id: <07f7ee46232b4ccc53787fa2e08887b436ee11c3.1646919331.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
References: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Mar 2022 13:35:28 +0000
Subject: [PATCH 1/4] trace2 docs: a couple of grammar fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/api-trace2.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index bb13ca3db8b..77216eff622 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -24,7 +24,7 @@ for example.
 
 Trace2 is controlled using `trace2.*` config values in the system and
 global config files and `GIT_TRACE2*` environment variables.  Trace2 does
-not read from repo local or worktree config files or respect `-c`
+not read from repo local or worktree config files nor does it respect `-c`
 command line config settings.
 
 == Trace2 Targets
@@ -34,8 +34,8 @@ Format details are given in a later section.
 
 === The Normal Format Target
 
-The normal format target is a tradition printf format and similar
-to GIT_TRACE format.  This format is enabled with the `GIT_TRACE2`
+The normal format target is a traditional printf format and similar
+to the GIT_TRACE format.  This format is enabled with the `GIT_TRACE2`
 environment variable or the `trace2.normalTarget` system or global
 config setting.
 
@@ -635,7 +635,7 @@ process may be a shell script which doesn't have a session-id.)
 +
 This event is generated after the child is started in the background
 and given a little time to boot up and start working.  If the child
-startups normally and while the parent is still waiting, the "ready"
+starts up normally while the parent is still waiting, the "ready"
 field will have the value "ready".
 If the child is too slow to start and the parent times out, the field
 will have the value "timeout".
@@ -949,7 +949,7 @@ atexit elapsed:3.868970 code:0
 
 Regions::
 
-	Regions can be use to time an interesting section of code.
+	Regions can be used to time an interesting section of code.
 +
 ----------------
 void wt_status_collect(struct wt_status *s)
@@ -1103,9 +1103,9 @@ Thread Events::
 
 	Thread messages added to a thread-proc.
 +
-For example, the multithreaded preload-index code can be
+For example, the multi-threaded preload-index code can be
 instrumented with a region around the thread pool and then
-per-thread start and exit events within the threadproc.
+per-thread start and exit events within the thread-proc.
 +
 ----------------
 static void *preload_thread(void *_data)
-- 
gitgitgadget

