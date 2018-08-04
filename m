Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2618C1F597
	for <e@80x24.org>; Sat,  4 Aug 2018 19:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbeHDVYv (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 17:24:51 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:37825 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbeHDVYv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 17:24:51 -0400
Received: by mail-pf1-f177.google.com with SMTP id a26-v6so4913059pfo.4
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 12:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XlSbdgT4lKXU11kxM4dynBE0z4jI6Ti1YUW6j6JqY6U=;
        b=SjTJfOHvgDyJVgIRko+Sm+MIjpT5yldL/BYcPkGFPdrnOCtZi0+l7+YyHeRIAIGdaw
         Mw/TbyNTphMR3mHZXBLKtUltxlfrwqVkuV4emTZG8YMbDIQn/PvcDvnZuDezhWaCFXhu
         p5Os/34/JlqjgFOrp4AqB1Wpg7mJDWTzp0pFPem/wGYAVHT3YnM6Z2TG0wwDDxfoLqsY
         fmL72UDb+5zWuiGLDHBhCFGwv46dEilq0sWWdEQtTa2vqsyjUrBw0Uo65qNAryo7p+zv
         nKRoHtKJrfCKhckC9S9pOaGFZUJQKSkpMyzIAl9XqXpITDD3Hes56eF+6/hinIXButNS
         nDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XlSbdgT4lKXU11kxM4dynBE0z4jI6Ti1YUW6j6JqY6U=;
        b=Y2DnjJI0WIN/DGiIYdagABMvFNtJjbjorrQ5Lt+vnr0K+N6Dx0ArW37y54vosyPSNd
         xY4InRZrFkwMcu6PG/oTVsg92VKvDlsy7/VpBMtNJpgRB8E/0LESiTWdy0M+tsAQoi+9
         omjMtmt23muxId7QfJIykAKyd59XIfu4xO/htBAzaZrURhWRsNSYU/z8IRMYTdwdWVbU
         b752laDhnlJ//GXQuzzI7SglE39deXw5KSEm0nqmm44sSmviebD3CiqNciUF13bS2gsH
         u+BodmbMeXXHfAPC8g4a8G1/dWAlo/XEZas5Ug8XJVjC1u7/PbtmQnctbqQs7SfCAsf/
         w3Uw==
X-Gm-Message-State: AOUpUlFN3MaRFtCblV9a5Ib3W4b6xuYyCZmU74X0gaksNvqOyBvTGt5E
        nfDlxTBGaMqpQDJGVOx278SoQub7
X-Google-Smtp-Source: AAOMgpeT1rURwTqsGI1JSOnKs+RL+jE0+em8T1mwhMia2WEQ7cYWLSTXY7k326MUE2V2UWZmD1n8fA==
X-Received: by 2002:a65:5a49:: with SMTP id z9-v6mr8660279pgs.244.1533410590408;
        Sat, 04 Aug 2018 12:23:10 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id o84-v6sm13596236pfi.165.2018.08.04.12.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 12:23:09 -0700 (PDT)
Date:   Sat, 04 Aug 2018 12:23:09 -0700 (PDT)
X-Google-Original-Date: Sat, 04 Aug 2018 19:23:05 GMT
Message-Id: <d2ba1e6bef9d6d4eabc8eaa60435dcae1105fd07.1533410586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.14.git.gitgitgadget@gmail.com>
References: <pull.14.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] pull --rebase=<type>: allow single-letter abbreviations
 for the type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Git for Windows' original 4aa8b8c8283 (Teach 'git pull' to handle
--rebase=interactive, 2011-10-21) had support for the very convenient
abbreviation

	git pull --rebase=i

which was later lost when it was ported to the builtin `git pull`, and
it was not introduced before the patch eventually made it into Git as
f5eb87b98dd (pull: allow interactive rebase with --rebase=interactive,
2016-01-13).

However, it is *really* a useful short hand for the occasional rebasing
pull on branches that do not usually want to be rebased.

So let's reintroduce this convenience, at long last.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pull.c  |  6 +++---
 t/t5520-pull.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 4e7893539..53bc5facf 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -48,11 +48,11 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
 		return REBASE_FALSE;
 	else if (v > 0)
 		return REBASE_TRUE;
-	else if (!strcmp(value, "preserve"))
+	else if (!strcmp(value, "preserve") || !strcmp(value, "p"))
 		return REBASE_PRESERVE;
-	else if (!strcmp(value, "merges"))
+	else if (!strcmp(value, "merges") || !strcmp(value, "m"))
 		return REBASE_MERGES;
-	else if (!strcmp(value, "interactive"))
+	else if (!strcmp(value, "interactive") || !strcmp(value, "i"))
 		return REBASE_INTERACTIVE;
 
 	if (fatal)
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 68aa5f034..5e501c8b0 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -475,10 +475,22 @@ test_expect_success 'pull.rebase=interactive' '
 	false
 	EOF
 	test_set_editor "$TRASH_DIRECTORY/fake-editor" &&
+	test_when_finished "test_might_fail git rebase --abort" &&
 	test_must_fail git pull --rebase=interactive . copy &&
 	test "I was here" = "$(cat fake.out)"
 '
 
+test_expect_success 'pull --rebase=i' '
+	write_script "$TRASH_DIRECTORY/fake-editor" <<-\EOF &&
+	echo I was here, too >fake.out &&
+	false
+	EOF
+	test_set_editor "$TRASH_DIRECTORY/fake-editor" &&
+	test_when_finished "test_might_fail git rebase --abort" &&
+	test_must_fail git pull --rebase=i . copy &&
+	test "I was here, too" = "$(cat fake.out)"
+'
+
 test_expect_success 'pull.rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase invalid &&
-- 
gitgitgadget
