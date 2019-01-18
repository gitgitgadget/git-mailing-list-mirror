Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E946E1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 09:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfARJuT (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 04:50:19 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36015 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfARJuT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 04:50:19 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so10673352edb.3
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 01:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KpFm82n9lrLA4Qg8gsgsd0bZUqfkKNIt2nIKUghqvYA=;
        b=gR9BQgf8sS+KNXsJSKVKDgyLW0GmvnbnqzIy/qFLkyWctH7F2VCNEzQFR+ZMZtJUbR
         v6VJdSERFYMLnaEF5++BVPXv4MmHXYI3rVnWbY5A65AoaFVrNnL+akMBoD/S1SFOVtvf
         MpwjV+QU0Y/SDUEndrNI+1u5gnf9cCdEXL2Nf7a4esWmhFvu1Y7V1CusS32e3v6blaNv
         wBMyoi1r3zstgWDSsgvJsuJxm1Uolz/W4TTERSv2EUhtbxyuFz5OXwj33oTLySGVJZV6
         t/lDsAAd3NV5LzNaDzkx7czZ9owftpXn/z3olPGKYx5s9RfwYUmcDjjQ0eW6haAEzhqN
         mzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KpFm82n9lrLA4Qg8gsgsd0bZUqfkKNIt2nIKUghqvYA=;
        b=dvsmBZbKmYtrkNSe6yWFifNk87qMkO0FUILlV2eLACY2apwlFJsLkIggtSEcsAYYMB
         gYcNcQbIpWtqoV8KCukLBnIbfuHQ98POunHxQ9KBsILkODZGlX8R9A3B0U3vusmRR2T9
         l5ZyGjzC5TBFwT4KVwRbRpKW3866gbwDtGsGUzXqQMeJt4A6JzygMjRKRrmLc8DToMqq
         aYWvsTMuhuorC0s4sQeuatZlx7PlGN+wp81g/5BPvcGHwyxoHwaWSk2CRFN2zxMy5v4J
         yJzPu94CkD3uG+9qRMP7NO1DPnZVwu7bPCrUuZ1vlmMyGK+cbaECLHN4n5wpuEXcvUu1
         HbuA==
X-Gm-Message-State: AJcUukddPv7Z7E55ZhsKf6UM2tz88bTqYZGGjbJ5uJz4blnfH31j/dGJ
        jDLEbG3HFMXIyeE85odGzia3Iv2w
X-Google-Smtp-Source: ALg8bN47dKRexw46TRjfhkKwbVujBHM6z6U7H2+92ji1xYTNxFTYQAQnZLcyuqPxp1r4hEzIf1ndIg==
X-Received: by 2002:a50:d6c5:: with SMTP id l5mr15234231edj.145.1547805017344;
        Fri, 18 Jan 2019 01:50:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r23-v6sm3915270eji.64.2019.01.18.01.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 01:50:16 -0800 (PST)
Date:   Fri, 18 Jan 2019 01:50:16 -0800 (PST)
X-Google-Original-Date: Fri, 18 Jan 2019 09:50:15 GMT
Message-Id: <b5bbc7793c50991c7cb5a5188f53ccc3a14b23f6.1547805015.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.110.git.gitgitgadget@gmail.com>
References: <pull.110.git.gitgitgadget@gmail.com>
From:   "Matthew Kraai via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] stash: fix segmentation fault when files were added with
 intent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Kraai <mkraai@its.jnj.com>

After `git add -N <file>`, the index is in a special state. A state for
which the built-in stash was not prepared, as it failed to initialize
the `rev` structure in that case before using `&rev.pending`.

Detailed explanation: If `reset_tree()` returns a non-zero value,
`stash_working_tree()` calls `object_array_clear()` with `&rev.pending`.
If `rev` is not initialized, this causes a segmentation fault.

Prevent this by initializing `rev` before calling `reset_tree()`.

This fixes https://github.com/git-for-windows/git/issues/2006.

[jes: modified the commit message in preparation for sending this patch
to the Git mailing list.]

Signed-off-by: Matthew Kraai <mkraai@its.jnj.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/stash.c  | 3 ++-
 t/t3903-stash.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 3ee8a41cda..74e6ff62b5 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1048,6 +1048,8 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 	struct strbuf diff_output = STRBUF_INIT;
 	struct index_state istate = { NULL };
 
+	init_revisions(&rev, NULL);
+
 	set_alternate_index_output(stash_index_path.buf);
 	if (reset_tree(&info->i_tree, 0, 0)) {
 		ret = -1;
@@ -1055,7 +1057,6 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 	}
 	set_alternate_index_output(NULL);
 
-	init_revisions(&rev, NULL);
 	rev.prune_data = ps;
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = add_diff_to_buf;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index b67d7a1120..7dfa3a8038 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -287,6 +287,14 @@ test_expect_success 'stash an added file' '
 	test new = "$(cat file3)"
 '
 
+test_expect_success 'stash --intent-to-add file' '
+	git reset --hard &&
+	echo new >file4 &&
+	git add --intent-to-add file4 &&
+	test_when_finished "git rm -f file4" &&
+	test_must_fail git stash
+'
+
 test_expect_success 'stash rm then recreate' '
 	git reset --hard &&
 	git rm file &&
-- 
gitgitgadget
