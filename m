Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B3731F462
	for <e@80x24.org>; Fri, 24 May 2019 12:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391509AbfEXMXu (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 08:23:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45508 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391244AbfEXMXu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 08:23:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id g57so14086722edc.12
        for <git@vger.kernel.org>; Fri, 24 May 2019 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FQZHA8T/68mYgZ+JgAHcGu0ZzENuqCsFXTL+HmtPL9Y=;
        b=DpX60qNs1IvkNplvibZ6DfWNNyOhhZDhwmPA7i/Fxi0tcLudwy0Q7jn7N8v8a0mWyN
         5eTV59LZhxnFCNZvgp+YSDw3Teh/lMzQGDTMx7vQAn96uyhbWfPfdfXxcQfnV7iJz9js
         HG7kFd62t1drEKkbbJ7KtB3d2hfcjhRusg6/tG9nLHr/hwFCeXhYZt+Ndf9iCqO3NYx7
         kJ9DF4gDa717lz9BR3h0Ix+k8MoQFPtSDZFJ8QvrNXAb9XlOuRspb5Su7wacVFWmNJ06
         aa8KsyNS5WOQak9bxii+kmTpvgzi7+KOy+JcLuK3d10TsNBwzpKde6peV2YjljSnYKPL
         oHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FQZHA8T/68mYgZ+JgAHcGu0ZzENuqCsFXTL+HmtPL9Y=;
        b=RYYGCnQRqgccpkkey7PDv9jQmPsgy9a3kH1jo+n474YDkaKDB1uRIpt6uV98i2LOMD
         1+ee5Ckkv+s1l9/jxSoAW/dKckg2+tTOPIQ8BDiqPofMwK0UCUp8cX2zxf+MbhEkWOUO
         eEfuyQS40YHOu039WA1iu2934BB14gRefzRF1L35Ny6chLmncaKZ3xODrGkbvaEt/IZ7
         Kjg5ioRdcY1T3FSr2UM5dRuZlqtdXT4e48AlaOMKfCPw4HXDZDBCCwQH1FaEYm2uZ5b4
         NQa2TjSCSGapUAn5p/tuw8zzCwXt4nYmhkZi39MpN273KOFBkoyT2qIzSFC1vFi2O+y5
         lZiQ==
X-Gm-Message-State: APjAAAVD6+/zwYXhljlugkRJwyrvIsb5ewMvwXJa3T9jaiOetYPotSEJ
        s867aPTTVCoANJpA2OFFr3BQ918j
X-Google-Smtp-Source: APXvYqz9aiE7kk5DJzRzTxKo0ifso3Z0z2R7jdruJ2n66z9YSXXSL7gIDO5kByZjSk1eK0CGfc9iRA==
X-Received: by 2002:a17:906:4e87:: with SMTP id v7mr75338446eju.150.1558700628692;
        Fri, 24 May 2019 05:23:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x40sm699592edx.52.2019.05.24.05.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 05:23:48 -0700 (PDT)
Date:   Fri, 24 May 2019 05:23:48 -0700 (PDT)
X-Google-Original-Date: Fri, 24 May 2019 12:23:45 GMT
Message-Id: <4f988adc1879cdf5d772b805c4b4d5b3f1a5612b.1558700625.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.223.git.gitgitgadget@gmail.com>
References: <pull.223.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] mark_fsmonitor_valid(): mark the index as changed if
 needed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Without this bug fix, t7519's four "status doesn't detect unreported
modifications" test cases would fail occasionally (and, oddly enough,
*a lot* more frequently on Windows).

The reason is that these test cases intentionally use the side effect of
`git status` to re-write the index if any updates were detected: they
first clean the worktree, run `git status` to update the index as well
as show the output to the casual reader, then make the worktree dirty
again and expect no changes to reported if running with a mocked
fsmonitor hook.

The problem with this strategy was that the index was written during
said `git status` on the clean worktree for the *wrong* reason: not
because the index was marked as changed (it wasn't), but because the
recorded mtimes were racy with the index' own mtime.

As the mtime granularity on Windows is 100 nanoseconds (see e.g.
https://docs.microsoft.com/en-us/windows/desktop/SysInfo/file-times),
the mtimes of the files are often enough *not* racy with the index', so
that that `git status` call currently does not always update the index
(including the fsmonitor extension), causing the test case to fail.

The obvious fix: if we change *any* index entry's `CE_FSMONITOR_VALID`
flag, we should also mark the index as changed. That will cause the
index to be written upon `git status`, *including* an updated fsmonitor
extension.

Side note: Even though the reader might think that the t7519 issue
should be *much* more prevalent on Linux, given that the ext4 filesystem
(that seems to be used by every Linux distribution) stores mtimes in
nanosecond precision. However, ext4 uses `current_kernel_time()` (see
https://unix.stackexchange.com/questions/11599#comment762968_11599; it
is *amazingly* hard to find any proper source of information about such
ext4 questions) whose accuracy seems to depend on many factors but is
safely worse than the 100-nanosecond granularity of NTFS (again, it is
*horribly* hard to find anything remotely authoritative about this
question). So it seems that the racy index condition that hid the bug
fixed by this patch simply is a lot more likely on Linux than on
Windows. But not impossible ;-)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff-lib.c      | 2 +-
 fsmonitor.h     | 5 +++--
 preload-index.c | 2 +-
 read-cache.c    | 4 ++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index a838c219ec..61812f48c2 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -232,7 +232,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 
 		if (!changed && !dirty_submodule) {
 			ce_mark_uptodate(ce);
-			mark_fsmonitor_valid(ce);
+			mark_fsmonitor_valid(istate, ce);
 			if (!revs->diffopt.flags.find_copies_harder)
 				continue;
 		}
diff --git a/fsmonitor.h b/fsmonitor.h
index 8489fa3244..739318ab6d 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -49,9 +49,10 @@ void refresh_fsmonitor(struct index_state *istate);
  * called any time the cache entry has been updated to reflect the
  * current state of the file on disk.
  */
-static inline void mark_fsmonitor_valid(struct cache_entry *ce)
+static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache_entry *ce)
 {
-	if (core_fsmonitor) {
+	if (core_fsmonitor && !(ce->ce_flags & CE_FSMONITOR_VALID)) {
+		istate->cache_changed = 1;
 		ce->ce_flags |= CE_FSMONITOR_VALID;
 		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_clean '%s'", ce->name);
 	}
diff --git a/preload-index.c b/preload-index.c
index e73600ee78..ed6eaa4738 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -78,7 +78,7 @@ static void *preload_thread(void *_data)
 		if (ie_match_stat(index, ce, &st, CE_MATCH_RACY_IS_DIRTY|CE_MATCH_IGNORE_FSMONITOR))
 			continue;
 		ce_mark_uptodate(ce);
-		mark_fsmonitor_valid(ce);
+		mark_fsmonitor_valid(index, ce);
 	} while (--nr > 0);
 	if (p->progress) {
 		struct progress_data *pd = p->progress;
diff --git a/read-cache.c b/read-cache.c
index d3b43ae3ba..32816763bd 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -204,7 +204,7 @@ void fill_stat_cache_info(struct index_state *istate, struct cache_entry *ce, st
 
 	if (S_ISREG(st->st_mode)) {
 		ce_mark_uptodate(ce);
-		mark_fsmonitor_valid(ce);
+		mark_fsmonitor_valid(istate, ce);
 	}
 }
 
@@ -1432,7 +1432,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 			 */
 			if (!S_ISGITLINK(ce->ce_mode)) {
 				ce_mark_uptodate(ce);
-				mark_fsmonitor_valid(ce);
+				mark_fsmonitor_valid(istate, ce);
 			}
 			return ce;
 		}
-- 
gitgitgadget
