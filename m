Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 550221F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbeGCL0n (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:26:43 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35572 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752582AbeGCL0i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:26:38 -0400
Received: by mail-pf0-f194.google.com with SMTP id z9-v6so882181pfh.2
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 04:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=MnzhDcuwp4f6hd+Iw0eGyNsYoXQt+7CM2x5MZ9e8AjQ=;
        b=u+r44a259HWJcBT7KxIajgx3fY7yKQ0hOjHVfzL7yVo1h8YLYm59UONM8W/NxLG7cF
         Wsp7WPENVsSSp2tzxVs/xgu4+rTJ3PTJWJSBB9jhIpxT60ghemfn2VX2HjYkG85qxe9c
         qRmiH/sfxVNjjka+vy+ksuq9YJLGEwUdSKUU7OQVPud7OjSyD8NkQGxKsyT3BNnhahBs
         xjjPsdG2UsE859IzY4vteUWPGUqDaRcwOQpV+ubT2kmA0Hfl0kI05n0y7X1oV7uC4A7o
         N2gFAsd5iJ1kp4EOAiRXlPBLmTwsMY2bRAe2/DFTC0c0wzasDtrs4Un3SzkGHw1isd11
         kC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=MnzhDcuwp4f6hd+Iw0eGyNsYoXQt+7CM2x5MZ9e8AjQ=;
        b=UFGUQ8NESIfkklpBr+XKZTJ92BNhv8p4YqALhDrBKBIX3kbxhdGjk+XJvMWSI4FbyN
         cumGAJ6oX3WYl0nTMHeeHmQEXSjSi1c/fdFJV+1d9ceQdPSUvYg7Irv6WGMTgnfRTjIM
         H8PI7vWYYduHVZLud+a2tFErVlq53aqqhAEZZDkX1O4V9OFU/ZEHX8PZhCaZkU8K2Arr
         9BI+AeYAvnEeGCbdJ4qR2zhvAOGsE5N0+ZLjU3TLgSseiPDRi9k16Rl5mt+gGUY1NsWx
         If8hhUo8f3k9bVLCYVadSUW5srO2qoXDoPecTw71n/sv9/kQv117I3bSQr/Vqs8Ho7Zi
         tCOw==
X-Gm-Message-State: APt69E3gK/uwZdhpbdYVW46mygM1PjFPtRNzpaMJlub/4Ov2+J8TFOLy
        emiPt/zGJPkkQY7SHRgYZ6Qvzg==
X-Google-Smtp-Source: ADUXVKJUTMaWk2uwVlmqBFz9bOpIRGbYZ3OA9Cs1I4kc3xhkO1GXuLDX/qRVCRny9B0KAXHI2VzaYQ==
X-Received: by 2002:a63:8848:: with SMTP id l69-v6mr24635156pgd.377.1530617198146;
        Tue, 03 Jul 2018 04:26:38 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id 10-v6sm1933578pgc.87.2018.07.03.04.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:26:37 -0700 (PDT)
Message-Id: <4a68b95ce2a6463708c92d1bcc0208352c14f836.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v3.git.gitgitgadget@gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 30 Jun 2018 22:41:41 +0200
Subject: [PATCH v3 20/20] range-diff: make --dual-color the default mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

After using this command extensively for the last two months, this
developer came to the conclusion that even if the dual color mode still
leaves a lot of room for confusion what was actually changed, the
non-dual color mode is substantially worse in that regard.

Therefore, we really want to make the dual color mode the default.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-range-diff.txt       | 13 ++++++++-----
 builtin/range-diff.c                   | 10 ++++++----
 contrib/completion/git-completion.bash |  2 +-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index 189236cc6..02d33ac43 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -31,11 +31,14 @@ all of their ancestors have been shown.
 
 OPTIONS
 -------
---dual-color::
-	When the commit diffs differ, recreate the original diffs'
-	coloring, and add outer -/+ diff markers with the *background*
-	being red/green to make it easier to see e.g. when there was a
-	change in what exact lines were added.
+--no-dual-color::
+	When the commit diffs differ, `git range-diff` recreates the
+	original diffs' coloring, and add outer -/+ diff markers with
+	the *background* being red/green to make it easier to see e.g.
+	when there was a change in what exact lines were added. This is
+	known to `range-diff` as "dual coloring". Use `--no-dual-color`
+	to revert to color all lines according to the outer diff markers
+	(and completely ignore the inner diff when it comes to color).
 
 --creation-factor=<percent>::
 	Set the creation/deletion cost fudge factor to `<percent>`.
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index e8f7fe452..6cee0c73a 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -20,11 +20,11 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 {
 	int creation_factor = 60;
 	struct diff_options diffopt = { NULL };
-	int dual_color = 0;
+	int simple_color = -1;
 	struct option options[] = {
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("Percentage by which creation is weighted")),
-		OPT_BOOL(0, "dual-color", &dual_color,
+		OPT_BOOL(0, "no-dual-color", &simple_color,
 			    N_("color both diff and diff-between-diffs")),
 		OPT_END()
 	};
@@ -53,8 +53,10 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	argc = j;
 	diff_setup_done(&diffopt);
 
-	if (dual_color) {
-		diffopt.use_color = 1;
+	if (simple_color < 1) {
+		if (!simple_color)
+			/* force color when --dual-color was used */
+			diffopt.use_color = 1;
 		diffopt.flags.dual_color_diffed_diffs = 1;
 	}
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 402490673..e35fc28fc 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1981,7 +1981,7 @@ _git_range_diff ()
   case "$cur" in
   --*)
           __gitcomp "
-	  	--creation-factor= --dual-color
+	  	--creation-factor= --no-dual-color
                   $__git_diff_common_options
                   "
           return
-- 
gitgitgadget
